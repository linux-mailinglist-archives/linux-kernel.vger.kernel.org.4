Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B47698A82
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBPC0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBPC0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:26:45 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E232CEA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:26:43 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E6D771A00A5E;
        Thu, 16 Feb 2023 10:27:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O873CoC8MC4m; Thu, 16 Feb 2023 10:27:18 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 1AA2F1A00A0E;
        Thu, 16 Feb 2023 10:27:18 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] lkdtm: perms: Increase pointer assignment check
Date:   Sat, 18 Feb 2023 02:58:01 +0800
Message-Id: <20230217185801.3232-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the check after the pointer allocates memory. If these two
functions are used, at least increase some robustness.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/misc/lkdtm/perms.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index b93404d65650..a5d8dce5ce49 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -180,15 +180,19 @@ static void lkdtm_EXEC_STACK(void)
 static void lkdtm_EXEC_KMALLOC(void)
 {
 	u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
-	execute_location(kmalloc_area, CODE_WRITE);
-	kfree(kmalloc_area);
+	if (kmalloc_area) {
+		execute_location(kmalloc_area, CODE_WRITE);
+		kfree(kmalloc_area);
+	}
 }
 
 static void lkdtm_EXEC_VMALLOC(void)
 {
 	u32 *vmalloc_area = vmalloc(EXEC_SIZE);
-	execute_location(vmalloc_area, CODE_WRITE);
-	vfree(vmalloc_area);
+	if (vmalloc_area) {
+		execute_location(vmalloc_area, CODE_WRITE);
+		vfree(vmalloc_area);
+	}
 }
 
 static void lkdtm_EXEC_RODATA(void)
-- 
2.18.2

