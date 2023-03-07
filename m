Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D15D6ADF36
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCGMyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCGMyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:54:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B40D7E8B4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:54:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F310F219B5;
        Tue,  7 Mar 2023 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678193654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EViJoIRl/2M31taW2MlxCxL7zL/ceVFDlbOtpRH0eQY=;
        b=Z5coI70rju7Q7LR0nHTk/oxPAPI4MshMawQYdx9ZSV0hP9GGFdylkuVvSrHwMeLTZj4JW4
        fdytS6rXw1Hb0TQD0kbbZH3I77AfaJ0XkBtw7G+WhVYv1/BhRowjrTBvCEQ3p976ETNTyJ
        Y3kJVh2ab2qi+LpMIM3Z8ThwYft9Tcg=
Received: from alley.suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 98D442C141;
        Tue,  7 Mar 2023 12:54:13 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 3/5] workqueue: Interrupted create_worker() is not a repeated event
Date:   Tue,  7 Mar 2023 13:53:33 +0100
Message-Id: <20230307125335.28805-4-pmladek@suse.com>
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

kthread_create_on_node() might get interrupted(). It is rare but realistic.
For example, when an unbound workqueue is allocated in module_init()
callback. It is done in the context of the "modprobe" process. And,
for example, systemd might kill pending processes when switching root
from initrd to the booted system.

The interrupt is a one-off event and the race might be hard to reproduce.
It is always worth printing.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/workqueue.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 36ad9a4d65e4..16439d79d164 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1961,8 +1961,13 @@ static struct worker *create_worker(struct worker_pool *pool)
 	worker->task = kthread_create_on_node(worker_thread, worker, pool->node,
 					      "kworker/%s", id_buf);
 	if (IS_ERR(worker->task)) {
-		pr_err_once("workqueue: Failed to create a worker thread: %pe",
-			    worker->task);
+		if (PTR_ERR(worker->task) == -EINTR) {
+			pr_err("workqueue: Interrupted when creating a worker thread \"kworker/%s\"\n",
+			       id_buf);
+		} else {
+			pr_err_once("workqueue: Failed to create a worker thread: %pe",
+				    worker->task);
+		}
 		goto fail;
 	}
 
-- 
2.35.3

