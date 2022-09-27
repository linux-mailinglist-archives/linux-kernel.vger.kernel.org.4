Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF75ECB79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiI0RmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiI0RlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:41:08 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B225DFB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:32 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f15-20020a17090a664f00b002038154eb4bso4934954pjm.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=LKa2EWOH75ZXoIQz8iJsf15zmXg+mcEaCfZdnIoCDl8=;
        b=GYnYXIqhIDBBrd9uswEbBLefhqiFuI3W4dE1JQ8t4ZePyjbWFuHxVP7oWd37h1++w/
         LWZj+xk6vpnHaWrC5ATggx6aUxoC5h14WSD1+EdoMuvrngQ0UsDTJi0CgvRY8nDZl6Mc
         tXHVm5d6SHnZI7Lu8Ubcxo9EHQQQF/oOkfTScfGuhiiJ+0DWO5NEcE3xxpkNakiF8mwt
         57xrFA9wH8XkgCGC1c1odivGOwxJ1WB6LrPtpewirWFQdlpq4T6In6tHiZC7jwUyQRaI
         cg8hRc7ikN4meIQ2bh2RY1aBvmJAGhw7apovwzddrcNunHn8VBf3EurZ509/3n+ciDfn
         DVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=LKa2EWOH75ZXoIQz8iJsf15zmXg+mcEaCfZdnIoCDl8=;
        b=Y63jSVphTUowXO0rM2wNWAjR6Z+tuFrF0WMzxbX1/hGNXdjfupblPKvFhr+SqnLoRK
         LBxBLDsZqDZHMKebvHkEPL2LpejU95aBUGaohmQONoIhDdKmp5E0gjIuGpWKnVJtXF+F
         pClYFZieZmpn/DD+Kcu1+ZFi9t9NhQAdCOein9s9gk+5UKUZ6dl4V5+9UeF+KbdIc5v5
         JBUAggO2WvKDRc8WRoOXAfYOnK+/rXlDfnWX8FwnphDQo01YjxKXaZ6uYmvDzwx0KxuL
         2DapE+DvKYPTq4YRaUJ28wyU4c08vSkKi7nHt3/XTu8IpZFzXcIwTJoApGMShNQXxYY0
         BdSA==
X-Gm-Message-State: ACrzQf3ENBT1ktqt2VXx5x3PrZP1J8WKcN8+vy0iflA+uPV0jnmXLg9u
        k7EMdo/sjmnR8bzuMuyVchPxHU+PmkuH
X-Google-Smtp-Source: AMsMyM5J6i/YqOcI+hTNRY2P8XVevJYiVh4MV1n67GgcgyhzZsBzTNeLRFP9/gfvmoX+DNI1R3BjtZBhkXX+
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a17:90b:4a82:b0:200:a89e:6f1f with SMTP id
 lp2-20020a17090b4a8200b00200a89e6f1fmr5625770pjb.13.1664300359293; Tue, 27
 Sep 2022 10:39:19 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:38:45 +0000
In-Reply-To: <20220927173845.2293378-1-sgzhang@google.com>
Mime-Version: 1.0
References: <20220927173845.2293378-1-sgzhang@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927173845.2293378-3-sgzhang@google.com>
Subject: [PATCH v1 2/2] mtd: mtdoops: panic caused mtdoops to call mtd erase
 function immediately
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

The panic function disables the local interrupts, preemption, and all
other processors. When the invoked mtdoops needs to erase a used page,
calling schedule_work() to do it will not work. Instead, just call mtd
erase function immediately.

Tested:
~# echo c > /proc/sysrq-trigger
[  171.654759] sysrq: Trigger a crash
[  171.658325] Kernel panic - not syncing: sysrq triggered crash
......
[  172.406423] mtdoops: not ready 34, 35 (erase immediately)
[  172.432285] mtdoops: ready 34, 35
[  172.435633] Rebooting in 10 seconds..

Signed-off-by: Ray Zhang <sgzhang@google.com>
---
 drivers/mtd/mtdoops.c | 66 ++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 84b21be347f6..73c6a55eb391 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -106,29 +106,8 @@ static int mtdoops_erase_block(struct mtdoops_context *cxt, int offset)
 	return 0;
 }
 
-static void mtdoops_inc_counter(struct mtdoops_context *cxt)
+static void mtdoops_erase(struct mtdoops_context *cxt)
 {
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
-	pr_debug("mtdoops: ready %d, %d (no erase)\n",
-		 cxt->nextpage, cxt->nextcount);
-}
-
-/* Scheduled work - when we can't proceed without erasing a block */
-static void mtdoops_workfunc_erase(struct work_struct *work)
-{
-	struct mtdoops_context *cxt =
-			container_of(work, struct mtdoops_context, work_erase);
 	struct mtd_info *mtd = cxt->mtd;
 	int i = 0, j, ret, mod;
 
@@ -166,8 +145,8 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 		ret = mtdoops_erase_block(cxt, cxt->nextpage * record_size);
 
 	if (ret >= 0) {
-		pr_debug("mtdoops: ready %d, %d\n",
-			 cxt->nextpage, cxt->nextcount);
+		pr_notice("mtdoops: ready %d, %d\n",
+			  cxt->nextpage, cxt->nextcount);
 		return;
 	}
 
@@ -181,6 +160,41 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 	goto badblock;
 }
 
+/* Scheduled work - when we can't proceed without erasing a block */
+static void mtdoops_workfunc_erase(struct work_struct *work)
+{
+	struct mtdoops_context *cxt =
+			container_of(work, struct mtdoops_context, work_erase);
+
+	mtdoops_erase(cxt);
+}
+
+static void mtdoops_inc_counter(struct mtdoops_context *cxt, int panic)
+{
+	cxt->nextpage++;
+	if (cxt->nextpage >= cxt->oops_pages)
+		cxt->nextpage = 0;
+	cxt->nextcount++;
+	if (cxt->nextcount == 0xffffffff)
+		cxt->nextcount = 0;
+
+	if (page_is_used(cxt, cxt->nextpage)) {
+		pr_notice("mtdoops: not ready %d, %d (erase %s)\n",
+			  cxt->nextpage, cxt->nextcount,
+			  panic ? "immediately" : "scheduled");
+		if (panic) {
+			/* In case of panic, erase immediately */
+			mtdoops_erase(cxt);
+		} else {
+			/* Otherwise, schedule work to erase it "nicely" */
+			schedule_work(&cxt->work_erase);
+		}
+	} else {
+		pr_notice("mtdoops: ready %d, %d (no erase)\n",
+			  cxt->nextpage, cxt->nextcount);
+	}
+}
+
 static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 {
 	struct mtd_info *mtd = cxt->mtd;
@@ -214,7 +228,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	mark_page_used(cxt, cxt->nextpage);
 	memset(cxt->oops_buf, 0xff, record_size);
 
-	mtdoops_inc_counter(cxt);
+	mtdoops_inc_counter(cxt, panic);
 out:
 	clear_bit(0, &cxt->oops_buf_busy);
 }
@@ -279,7 +293,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 		cxt->nextcount = maxcount;
 	}
 
-	mtdoops_inc_counter(cxt);
+	mtdoops_inc_counter(cxt, 0);
 }
 
 static void mtdoops_do_dump(struct kmsg_dumper *dumper,
-- 
2.37.3.998.g577e59143f-goog

