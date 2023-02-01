Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF3968675B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjBANqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjBANqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:46:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D44530F7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:46:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 62F6C21F56;
        Wed,  1 Feb 2023 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675259189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfQlY0Qc1E2NuHOqKGILm3b8KFgcj8CSW4JGgDhEqzU=;
        b=Wc5Ghx4Ry6X3DeR7Bv7ZinkHREKeVB1gC82rShOQbzQaxIhF/0Gu+QDr4HEL15EUtl/d8+
        hce9QVnHNyeK2SiakHbmZRKhROaikP8UvjAlrvKB13oY9Jb7pQ7M4JPvqL/S/QHvNtxCFm
        EKW1ubxdvLLX4lBEHNqQ3mt7gVkbW+4=
Received: from alley.suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 250972C141;
        Wed,  1 Feb 2023 13:46:29 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [RFC 3/5] workqueue: Interrupted create_worker() is not a repeated event
Date:   Wed,  1 Feb 2023 14:45:41 +0100
Message-Id: <20230201134543.13687-4-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230201134543.13687-1-pmladek@suse.com>
References: <20230201134543.13687-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Handle the interrupt a special way. It a one-off event in compare with
the other failures. Always print this warning. And do not block the other
warnings.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/workqueue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ab109ef7a7c0..5f3327e119b4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1925,7 +1925,7 @@ void __print_create_worker_failure(long err, const char *fmt, ...)
 	 * touch watchdogs so that more frequent messages would prevent
 	 * reaching the watchdog thresh.
 	 */
-	if (!create_worker_failed) {
+	if (!create_worker_failed || err == -EINTR) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -1933,7 +1933,8 @@ void __print_create_worker_failure(long err, const char *fmt, ...)
 		va_end(args);
 	}
 
-	create_worker_failed++;
+	if (err != -EINTR)
+		create_worker_failed++;
 
 	spin_unlock_irq(&create_worker_failed_lock);
 }
-- 
2.35.3

