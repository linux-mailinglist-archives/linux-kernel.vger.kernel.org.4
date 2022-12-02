Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121E164070F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiLBMpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiLBMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:45:39 -0500
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216F5DCBD9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:45:34 -0800 (PST)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1p15Pp-005MRe-O6;
        Fri, 02 Dec 2022 13:45:17 +0100
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] devtmpfs: move NULLing the thread pointer before unregistering fs
Date:   Fri,  2 Dec 2022 14:45:01 +0200
Message-Id: <20221202124502.217462-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit
31c779f293b3 ("devtmpfs: fix the dangling pointer of global devtmpfsd thread")
a dangling pointer on an error condition was fixed. But the fix
left the dangling pointer during unregister_filesystem and printk calls.
Improve the fix to clear the pointer before unregistration to close
the window  where the dangling pointer can be potentially used.
Make it clear the pointer at only one place in the function.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/base/devtmpfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index e4bffeabf344..773e66ef5642 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -472,17 +472,15 @@ int __init devtmpfs_init(void)
 	}
 
 	thread = kthread_run(devtmpfsd, &err, "kdevtmpfs");
-	if (!IS_ERR(thread)) {
+	if (!IS_ERR(thread))
 		wait_for_completion(&setup_done);
-	} else {
+	else
 		err = PTR_ERR(thread);
-		thread = NULL;
-	}
 
 	if (err) {
+		thread = NULL;
 		printk(KERN_ERR "devtmpfs: unable to create devtmpfs %i\n", err);
 		unregister_filesystem(&dev_fs_type);
-		thread = NULL;
 		return err;
 	}
 

base-commit: b7b275e60bcd5f89771e865a8239325f86d9927d
-- 
2.31.1

