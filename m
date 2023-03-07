Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7DF6ADF38
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCGMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCGMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:54:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED997C964
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:54:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EDBC61FE18;
        Tue,  7 Mar 2023 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678193659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwdAX4GqGQBW4Sq41+9WAcG3LtQ9kxjBt9mM0BrglRk=;
        b=qU3OBeEV0ev27nqWFFoWmTb08omv1pdCUGfdepQCZ+K7I+f6nLTHbYV3evGHWe3LziYIeD
        dI6g4jzqnIlG+iCxNedfXo3SGbL0tMjXGZK70WVdCXIe1pZ830THAkRawjY1oOCAjMkQ06
        rGj0gpnD2Hd49qlW6tNp/ORH2YLDBZY=
Received: from alley.suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id A440C2C141;
        Tue,  7 Mar 2023 12:54:19 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 4/5] workqueue: Warn when a rescuer could not be created
Date:   Tue,  7 Mar 2023 13:53:34 +0100
Message-Id: <20230307125335.28805-5-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230307125335.28805-1-pmladek@suse.com>
References: <20230307125335.28805-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rescuers are created when a workqueue with WQ_MEM_RECLAIM is allocated.
It typically happens during the system boot.

systemd switches the root filesystem from initrd to the booted system
during boot. It kills processes that block the switch for too long.
One of the process might be modprobe that tries to create a workqueue.

These problems are hard to reproduce. Also alloc_workqueue() does not
pass the error code. Make the debugging easier by printing an error,
similar to create_worker().

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/workqueue.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 16439d79d164..cce342defc69 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4393,13 +4393,18 @@ static int init_rescuer(struct workqueue_struct *wq)
 		return 0;
 
 	rescuer = alloc_worker(NUMA_NO_NODE);
-	if (!rescuer)
+	if (!rescuer) {
+		pr_err("workqueue: Failed to allocate a rescuer for wq \"%s\"\n",
+		       wq->name);
 		return -ENOMEM;
+	}
 
 	rescuer->rescue_wq = wq;
 	rescuer->task = kthread_create(rescuer_thread, rescuer, "%s", wq->name);
 	if (IS_ERR(rescuer->task)) {
 		ret = PTR_ERR(rescuer->task);
+		pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
+		       wq->name, ERR_PTR(ret));
 		kfree(rescuer);
 		return ret;
 	}
-- 
2.35.3

