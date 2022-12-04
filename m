Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC5641CBA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiLDLls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLDLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:41:07 -0500
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA1C186C5
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:39:51 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 1nLYpvyXGap0Y1nLYp173T; Sun, 04 Dec 2022 12:39:49 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Dec 2022 12:39:49 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     paulmck@kernel.org, elver@google.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] init_task: Include <linux/rbtree.h> in the right file
Date:   Sun,  4 Dec 2022 12:39:47 +0100
Message-Id: <f06e810735c49a611e7dc75715f0689b5f7e87c6.1670153931.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to include <linux/rbtree.h> in init_task.h.
Move it to the right place, in kernel/cred.c which uses RB_ROOT_CACHED.

This is a follow-up of commit 4e7e3adbba52 ("Expand various INIT_* macros
and remove") which moved things from init_task.h to init_task.c

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Let see if build-bots agree with me!

This patch depends on [1] and [2].
All these patches are related to init_task.h simplification.

They are unrelated and can be applied separately, but as they modify more
or less the same place in the same file, there may be some merge conflict.

[1]: https://lore.kernel.org/all/1a3d5bd51b7807471a913f8fa621e5a4ecd08e6a.1670100520.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/94c8f2123a8833b61d84a662ec35f9c070cdf4dd.1670147823.git.christophe.jaillet@wanadoo.fr/
---
 include/linux/init_task.h | 1 -
 init/init_task.c          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 6d2c4ea4c97a..e18a6c6f6fd9 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -9,7 +9,6 @@
 #include <linux/ipc.h>
 #include <linux/user_namespace.h>
 #include <linux/seqlock.h>
-#include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched/autogroup.h>
 #include <net/net_namespace.h>
diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..2392c0a67fb7 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -2,6 +2,7 @@
 #include <linux/init_task.h>
 #include <linux/export.h>
 #include <linux/mqueue.h>
+#include <linux/rbtree.h>
 #include <linux/sched.h>
 #include <linux/sched/sysctl.h>
 #include <linux/sched/rt.h>
-- 
2.34.1

