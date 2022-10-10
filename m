Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF85F9783
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiJJE4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJJE4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:56:01 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F273E3DBFC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:56:00 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id b11-20020a170902d50b00b0017828988079so7428112plg.21
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 21:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5rEc7KuSG8cmN4lQmoVLJoG9j0x/2DEKJaMbcZ2CU0=;
        b=KDpmZ7bo0zPf/eZT5qUzqYTXLyoYn9UO8veMeCOP+GKD5bNCFsHkzSkn0fAad0b5eA
         4Dya3H+lLn4iThtp4uLKnWB91BdmG+kiqYpiDn+baNHRee7/vOQNyOx4waQPdYDCGs1X
         txyyGL7YLeI3OO9KSOm7Z81K9tb0GBJd3JUgkFLb/PyGcY7l9et9aIMkfvuuthbIFP14
         PLenG6sCH9pQtufa1pmbd/fZPJfwX88bDVCo8FdCrAhDcbLlzGZA2J3OPAS/l+qQO4+b
         PE482p8VqUNPhseZ5eb8vF69d0+yl4GYTNsZkrSOmyQHAkbNOHyt/xJWsMSxozgV42ok
         b4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5rEc7KuSG8cmN4lQmoVLJoG9j0x/2DEKJaMbcZ2CU0=;
        b=xLbnl3o9lInI9Kr8eUZtcurr9Qz2XtglE74SdB+LMA7Jke6eH2izJGkdJlrQRQZdiJ
         6IByI677/YqCXSWU3MTYPBSq/1qNbYn8N/yrEjoKC69FeQfjcI115D16wIq+7qkws98L
         66+GawOd//Y8zCyfLhrOxOS0F6VKMhz7wazdXrS62jegJnzrmwJzVgYWQ1R9XTmp0srZ
         22+zoazvPONFVyd/IYFlodz3pcGEVfeeMQsFP9jP21zkmbR95yplguWxouLIrHZn8bWX
         CSw8kRstSovBgiwU8UujUhyhlD/lObBuPsZNg0yNVpn3aemCQseUV+/iuN6iOYuaQwLW
         dnWg==
X-Gm-Message-State: ACrzQf3GabmQb0pYDHEhhJ/dEPFUMzmZ0A7UzESaPu12gWBugnSeuT9R
        9wKGviNoBBK/rQMGDg3bb2WyL2gBwcdj
X-Google-Smtp-Source: AMsMyM5kMBxQ1/A4s0m7jJM202Q9cOw+L/nl5EWStZu/gB/QC2QJJRSuMVENxK9wo9rCobrjnJ8Q1q78ditE
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a17:903:22cc:b0:178:18a1:d16c with SMTP id
 y12-20020a17090322cc00b0017818a1d16cmr17345818plg.155.1665377759761; Sun, 09
 Oct 2022 21:55:59 -0700 (PDT)
Date:   Mon, 10 Oct 2022 04:55:48 +0000
In-Reply-To: <20221010045549.2221965-1-sgzhang@google.com>
Mime-Version: 1.0
References: <20221010045549.2221965-1-sgzhang@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010045549.2221965-3-sgzhang@google.com>
Subject: [PATCH v4 2/3] mtd: mtdoops: add mtdoops_erase function and move
 mtdoops_inc_counter to after it
From:   Ray Zhang <sgzhang@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Zhang <sgzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparing for next patch with minimal code difference, add mtdoops_erase
function and move mtdoops_inc_counter to after it, with no functional
change.

Signed-off-by: Ray Zhang <sgzhang@google.com>
---
 drivers/mtd/mtdoops.c | 49 ++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 6b70331da3b6..0226b9e9ea8f 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -108,29 +108,8 @@ static int mtdoops_erase_block(struct mtdoops_context *cxt, int offset)
 	return 0;
 }
 
-static void mtdoops_inc_counter(struct mtdoops_context *cxt)
-{
-	cxt->nextpage++;
-	if (cxt->nextpage >= cxt->oops_pages)
-		cxt->nextpage = 0;
-	cxt->nextcount++;
-	if (cxt->nextcount == 0xffffffff)
-		cxt->nextcount = 0;
-
-	if (page_is_used(cxt, cxt->nextpage)) {
-		schedule_work(&cxt->work_erase);
-		return;
-	}
-
-	pr_debug("ready %d, %d (no erase)\n",
-		 cxt->nextpage, cxt->nextcount);
-}
-
-/* Scheduled work - when we can't proceed without erasing a block */
-static void mtdoops_workfunc_erase(struct work_struct *work)
+static void mtdoops_erase(struct mtdoops_context *cxt)
 {
-	struct mtdoops_context *cxt =
-			container_of(work, struct mtdoops_context, work_erase);
 	struct mtd_info *mtd = cxt->mtd;
 	int i = 0, j, ret, mod;
 
@@ -183,6 +162,32 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 	goto badblock;
 }
 
+/* Scheduled work - when we can't proceed without erasing a block */
+static void mtdoops_workfunc_erase(struct work_struct *work)
+{
+	struct mtdoops_context *cxt =
+			container_of(work, struct mtdoops_context, work_erase);
+	mtdoops_erase(cxt);
+}
+
+static void mtdoops_inc_counter(struct mtdoops_context *cxt)
+{
+	cxt->nextpage++;
+	if (cxt->nextpage >= cxt->oops_pages)
+		cxt->nextpage = 0;
+	cxt->nextcount++;
+	if (cxt->nextcount == 0xffffffff)
+		cxt->nextcount = 0;
+
+	if (page_is_used(cxt, cxt->nextpage)) {
+		schedule_work(&cxt->work_erase);
+		return;
+	}
+
+	pr_debug("ready %d, %d (no erase)\n",
+		 cxt->nextpage, cxt->nextcount);
+}
+
 static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 {
 	struct mtd_info *mtd = cxt->mtd;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

