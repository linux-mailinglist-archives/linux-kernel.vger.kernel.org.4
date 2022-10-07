Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF45F804B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJGVuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJGVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:50:42 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF483F0E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 14:50:40 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s68-20020a632c47000000b00434e0e75076so3467983pgs.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8RGq8MFx6yg4rvWL2LsrEdijzeVAuwua99jyz3WuY0=;
        b=Jm4fGwHaDYx7k9kxYT6mKkXoumBg51rFPtFVs1GUI0RDAED/uoDgT2YNed/lVzfR63
         h0TE9R+NpFZlX072/6JitNBwgwOCkwj7MWGEJ9gSHP7juK93M7454+wy1rhY7QCus+rq
         wETw9tMRCilnjfF4BoNjlvaT7PaGOETx1PmHdjQz/gZyRd/vatqaqevPArtVOBLVpt7D
         qtJj4KgMq7PvlziZGs6v15glFw3zQHU4ozOBFV0tWIsguGo/HUN1RbaBMF2gkCbsHk42
         I5W0wotcQX/ykvIoxcCSVRcdg3YeZdE/rgpy8N/In3caWqbczTRDU6ug4vJspOvW+iWe
         kC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8RGq8MFx6yg4rvWL2LsrEdijzeVAuwua99jyz3WuY0=;
        b=IP3w8tQexhDSVjZYjSDiRUmNP+h1nf7c71ccox5FJwqNBuSEN2iUzD4ZYxfsrxjuac
         ZSmsBv7TmOHql5HqnWW5pTZyr8unlkS1PALhrm/Gg/pcABoP//P09SwaMJI7gxAmYJjW
         oUCttofTGULAu0ROkyKL4fovYZWQ1Xuo8N7DNiinBA5NZqkD2kjmOmyVxJ7EhaPMwEoz
         T2ezqumSFCOFiCD33M8zR7n9siBVAeiTMbL/qL+PEe6ttXWPPdyGPj3N6r9DN3XuCGiM
         Mo5PC1PqU+bizfqY5Jmsc3pJ6j5GBrJ+Of51Qjw2RH/qQaDyOgfmHYEiTr0XhjOsbz+u
         7LQw==
X-Gm-Message-State: ACrzQf0ILh6OWfHhwq0Eo7J2L8OyCPpVj34Qvj69dWr2VDyKxBkvIeI3
        99znRxohm8yJ6il4zhJbFeDTbasOdiNl
X-Google-Smtp-Source: AMsMyM6u9ghCGBUvbM5APJ6uXbUZZysoD0yKXdfPswKlv7hHAgLwY/TTgHaNURF+8tLhijVM7Y0cjxypeMEW
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a62:1a8d:0:b0:544:1309:19f3 with SMTP id
 a135-20020a621a8d000000b00544130919f3mr7193381pfa.37.1665179440177; Fri, 07
 Oct 2022 14:50:40 -0700 (PDT)
Date:   Fri,  7 Oct 2022 21:50:27 +0000
In-Reply-To: <20221007215027.918507-1-sgzhang@google.com>
Mime-Version: 1.0
References: <20221007215027.918507-1-sgzhang@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221007215027.918507-4-sgzhang@google.com>
Subject: [PATCH v3 3/3] mtd: mtdoops: panic caused mtdoops to call
 mtdoops_erase function immediately
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
calling schedule_work() to do it will not work. Instead, just call
mtdoops_erase function immediately.

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
 drivers/mtd/mtdoops.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index eca48dff9b53..eccb7dea892f 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -168,7 +168,7 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 	mtdoops_erase(cxt);
 }
 
-static void mtdoops_inc_counter(struct mtdoops_context *cxt)
+static void mtdoops_inc_counter(struct mtdoops_context *cxt, int panic)
 {
 	cxt->nextpage++;
 	if (cxt->nextpage >= cxt->oops_pages)
@@ -178,12 +178,20 @@ static void mtdoops_inc_counter(struct mtdoops_context *cxt)
 		cxt->nextcount = 0;
 
 	if (page_is_used(cxt, cxt->nextpage)) {
-		schedule_work(&cxt->work_erase);
-		return;
+		pr_debug("mtdoops: not ready %d, %d (erase %s)\n",
+			 cxt->nextpage, cxt->nextcount,
+			 panic ? "immediately" : "scheduled");
+		if (panic) {
+			/* In case of panic, erase immediately */
+			mtdoops_erase(cxt);
+		} else {
+			/* Otherwise, schedule work to erase it "nicely" */
+			schedule_work(&cxt->work_erase);
+		}
+	} else {
+		pr_debug("mtdoops: ready %d, %d (no erase)\n",
+			 cxt->nextpage, cxt->nextcount);
 	}
-
-	pr_debug("mtdoops: ready %d, %d (no erase)\n",
-		 cxt->nextpage, cxt->nextcount);
 }
 
 static void mtdoops_write(struct mtdoops_context *cxt, int panic)
@@ -219,7 +227,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	mark_page_used(cxt, cxt->nextpage);
 	memset(cxt->oops_buf, 0xff, record_size);
 
-	mtdoops_inc_counter(cxt);
+	mtdoops_inc_counter(cxt, panic);
 out:
 	clear_bit(0, &cxt->oops_buf_busy);
 }
@@ -284,7 +292,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 		cxt->nextcount = maxcount;
 	}
 
-	mtdoops_inc_counter(cxt);
+	mtdoops_inc_counter(cxt, 0);
 }
 
 static void mtdoops_do_dump(struct kmsg_dumper *dumper,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

