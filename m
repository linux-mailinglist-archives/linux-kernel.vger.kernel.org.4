Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3445F804A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJGVuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJGVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:50:39 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E583F0E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 14:50:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s68-20020a632c47000000b00434e0e75076so3467937pgs.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YShywGeqIZDpcBEaSHQ5rYoxj4sM6AIZww6UQ+coyfI=;
        b=VufppTi/zTzcgJl8M5k3Qo0rrMpdXQ7MaXZNshLoY/sbxKgJxiBSNUo53okQsrIMQ8
         K8WepTsrKar3kAQdWZ8H2+JHQ6LSm6saglhTpf59oEbnR51yl4CoZtwJL4bT1YFQU5/I
         7Gp/hE5vdM1mU74x7fszg1vduNPvfFqOmEHSuA1cN78ZcZ/M+dF+XGCysrFPjz0aVSUZ
         37eJ6a8HPdiqPL/P7jlNDmQscPz+xtLja+RY3lwMCxmDxLGEtlHMM4E0FBgtJ3CbR0rO
         Ez5q7Q4qdYVxRmI2viYkYAceH2+d84IrHcTzknjj1SwnD/W74ZrfDPM0MmRslc5adzFo
         t92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YShywGeqIZDpcBEaSHQ5rYoxj4sM6AIZww6UQ+coyfI=;
        b=bhcAGafYIoBVtdbqcVpBzzxUD6yUcSYdbRnLvjF/NombhstX7yRWYtaqnjLzwfxov+
         12W3DSUx7RE6L8aURl8a9D8sLabcv/N5aam8egTn8K74ItsnEJAm4x25oZIRMewWcbrc
         USygSvPRZVb94mTNG2pBabNpSzr0y6a0mY9yXFXqYg06h7ps/FLPH3W0D6yDGmbuW35n
         kck2gkKZnCmh7Gkag6BYBMvZp3eRJ8IKdfMtHqloB/n1bVi1am54QQTIjDs51uJg309Z
         /3+sQZc6cFqFTvSbqiQ2TwspzNRLq8kikaSi9DNpdg5SWIxn/zF0B8iC/AoFbUHvhAmr
         T+aA==
X-Gm-Message-State: ACrzQf0sKzVYE2wzS2/Sb2zIF3gDalKV7kLfWlM6ylbFe90poVl//gHq
        OF7kim25IG4QaEFWTCG5OGH1ZelXcWfo
X-Google-Smtp-Source: AMsMyM610GlblJ5qz7nDt6pqrmJNd6MKkeco80561o7UBTOIC1K0FzFCcI8o7gb1qY1Vo5SrBLpr/FNI7KUo
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a05:6a00:8cc:b0:52c:7ab5:2ce7 with SMTP id
 s12-20020a056a0008cc00b0052c7ab52ce7mr7201971pfu.28.1665179437858; Fri, 07
 Oct 2022 14:50:37 -0700 (PDT)
Date:   Fri,  7 Oct 2022 21:50:26 +0000
In-Reply-To: <20221007215027.918507-1-sgzhang@google.com>
Mime-Version: 1.0
References: <20221007215027.918507-1-sgzhang@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221007215027.918507-3-sgzhang@google.com>
Subject: [PATCH v3 2/3] mtd: mtdoops: add mtdoops_erase function and move
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

