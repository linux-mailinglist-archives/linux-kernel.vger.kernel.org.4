Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A775F745F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJGGv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJGGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:51:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7E1176F3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:51:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k11-20020a5b038b000000b006bbf786c30aso3867463ybp.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YShywGeqIZDpcBEaSHQ5rYoxj4sM6AIZww6UQ+coyfI=;
        b=NVl8BmpUMOw/A1G0cyJiZmnVpArIC5Pr6feGlbuFl5GAERbU3SfKIPOuzwU93ca7YX
         o2nDHDgZ5Ce66+0hVn11ujpHD5ao8wq0YQpIQjZVVzSJXNUv5r4HluF5P7Fx2UYcd0qU
         ix3fiLS75nyCVZBiDPsaey5whGmnyfGnxGOVIVpS+2QM+ebDldRI26GKrmoEkoQDrqDw
         hwFX0PtxPizrhtgdloHLvMGcSxKDT+RQrAwq/EADlJP4xt6+6t4fKmfjOPobcHhTVJs7
         jSTl7MLqhLAnyT7jqv6+vOrMx+laOTq/qVWujC1JgXJCnTE3aK+Mx3NJiutXwGKe1FjE
         Ecww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YShywGeqIZDpcBEaSHQ5rYoxj4sM6AIZww6UQ+coyfI=;
        b=m/uXR97/rSmtEmhHQ/xaZ+pJuP7JnKQpTH6gWyVUEKmcWnw+Y8btrhuxqQefx5K1Un
         UVrxg4KuP7Z//C4O/+lx4XRL3ZKstLR8elL6kL/QVCImZKZSnQs1qcf/RRNLItjd0gOd
         nrJKP8xHfZMUZeIUuBCCF5uKERl/dvdn7v74YmsOTvugeQSD9wyrqDg+Hosxirc826mF
         KiCtaWkkRWOmBTPEDmehY5nzdyW80ygWb8d2QwOAUz8Weo+NBH4UQNAL0BM6fepeBHgx
         9+kDpfNZof2hH/StsySFNfgO/uk2nskatPzceW1zlBTPVsywbEnWOPNkya6CgiHI/1+I
         it2A==
X-Gm-Message-State: ACrzQf3aeGTF8xIvaMlXXFJgVV2qJM6zBQKFb8fOFbdETmBNqOCkUcHV
        FN+bHh8Sbkxwut+eGW8Ye+1cgl/0d5Tj
X-Google-Smtp-Source: AMsMyM6cNDQNaZMU03HNe/9QS6jTwDRBFkooH0PAZ/5Aq9cH5UQ27ALHUr4mGbrsMjzz8BwoPo2couSFuy4z
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a25:3790:0:b0:6be:7476:e7c5 with SMTP id
 e138-20020a253790000000b006be7476e7c5mr3031715yba.389.1665125457291; Thu, 06
 Oct 2022 23:50:57 -0700 (PDT)
Date:   Fri,  7 Oct 2022 06:50:41 +0000
In-Reply-To: <20221007065042.700761-1-sgzhang@google.com>
Mime-Version: 1.0
References: <20221007065042.700761-1-sgzhang@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221007065042.700761-3-sgzhang@google.com>
Subject: [PATCH v2 2/3] mtd: mtdoops: add mtdoops_erase function and move
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
index 84b21be347f6..eca48dff9b53 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -106,29 +106,8 @@ static int mtdoops_erase_block(struct mtdoops_context *cxt, int offset)
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
-	pr_debug("mtdoops: ready %d, %d (no erase)\n",
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
 
@@ -181,6 +160,32 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
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
+	pr_debug("mtdoops: ready %d, %d (no erase)\n",
+		 cxt->nextpage, cxt->nextcount);
+}
+
 static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 {
 	struct mtd_info *mtd = cxt->mtd;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

