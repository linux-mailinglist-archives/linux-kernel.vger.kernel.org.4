Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DCA5F9782
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJJE4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJJEz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:55:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DF23DBEF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:55:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n9-20020a170902d2c900b001782ad97c7aso7295143plc.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lzwp40a62FGAnOoiZ5XoBxodmWLF61UQZ56kTVbia9E=;
        b=LhRHZodajX8y2Sx8JbDwzXp3+viYlr2Er7Erk6vEclxdP6hgm4I3icQMRRdPFOo+CB
         O0mMsk826UWFYYGzXvZJ/OsclscQh30gMMBJqvFMQU5R9V3F2LVm0mdZShlth43ecCFo
         lt956zbsUz6IRYYbWDMeBrW9MH4HBGdsJ5bzb75spGv/5sLdpyYpkJCPRXGEf+EhxAtt
         Z/rmURuLb0hO7I2gGSVTt/i/OMRN14hpYqOLG/reKOut2S8BX9zStwuT/stXtK4Deh+9
         mHBIK2JKNf2lFGSX0C6XX/mHWl6WqmrUrbu/bQUlDjLB8MAAmQo0Xb5LdU6fSWi93MH3
         KWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzwp40a62FGAnOoiZ5XoBxodmWLF61UQZ56kTVbia9E=;
        b=whTEn+wCDbzeJ0n84mC0P5iam8EMc72K8ISXGaJHjxHOX4xf6QeBjJk/p/DxZRxoxf
         xKwrK2X5psEiEx7OSaQth15YiET78J6cbvDFlLOcw2LjhzUOGwzBdlW4K53cjDvjU1s1
         KXXZ5u8AtSyimzPxW3If4sr1xBn2SE8WchA23x5pvWL6k8ko5GE7FPZiAbGFSuCoNB5U
         3WqafNhrbnIcARyaWcou6umfitfp7B3IuLGishBuvb5Reej8lMlo9BiEayHge9wneMor
         ZZeEuBbb0DZRdvBa3yoZ06ocBlEbBMQ2KOWvU9/tgOv457A08lbkFr3ffQfucENNfjJq
         KtFA==
X-Gm-Message-State: ACrzQf3PvQxIdaI485B7E2g5EX4Z7imE5kN49X45nVbz+D0x51eS2jnr
        7kgSSnjG525EzYAVjhHSf7qMRqp/wB+V
X-Google-Smtp-Source: AMsMyM6o8NER8Y3yaSbuhO2Np81zL46aICeiXFpwpKFZMksSRanKZiO1CdsUg0xkJCwFCFo3Pr7noLl9qEoS
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:aa7:9250:0:b0:563:723f:7914 with SMTP id
 16-20020aa79250000000b00563723f7914mr1753359pfp.12.1665377756870; Sun, 09 Oct
 2022 21:55:56 -0700 (PDT)
Date:   Mon, 10 Oct 2022 04:55:47 +0000
In-Reply-To: <20221010045549.2221965-1-sgzhang@google.com>
Mime-Version: 1.0
References: <20221010045549.2221965-1-sgzhang@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010045549.2221965-2-sgzhang@google.com>
Subject: [PATCH v4 1/3] mtd: mtdoops: change printk() to counterpart pr_ functions
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

To comply with latest kernel code requirement, change printk() to
counterpart pr_ functions in mtdoops driver:
- change printk(INFO) to pr_info()
- change printk(DEBUG) to pr_debug()
- change printk(WARNING) to pr_warn()
- change printk(ERR) to pr_err()

Note that only if dynamic debugging is enabled or DEBUG is defined,
printk(KERN_DEBUG) and pr_debug() are equivalent; Otherwise pr_debug()
is no-op, causing different behavior.

Signed-off-by: Ray Zhang <sgzhang@google.com>
---
 drivers/mtd/mtdoops.c | 52 ++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 3d4a2ffb5b01..6b70331da3b6 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -7,6 +7,8 @@
  * Author: Richard Purdie <rpurdie@openedhand.com>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/console.h>
@@ -93,9 +95,9 @@ static int mtdoops_erase_block(struct mtdoops_context *cxt, int offset)
 
 	ret = mtd_erase(mtd, &erase);
 	if (ret) {
-		printk(KERN_WARNING "mtdoops: erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
-		       (unsigned long long)erase.addr,
-		       (unsigned long long)erase.len, mtddev);
+		pr_warn("erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
+			(unsigned long long)erase.addr,
+			(unsigned long long)erase.len, mtddev);
 		return ret;
 	}
 
@@ -120,8 +122,8 @@ static void mtdoops_inc_counter(struct mtdoops_context *cxt)
 		return;
 	}
 
-	printk(KERN_DEBUG "mtdoops: ready %d, %d (no erase)\n",
-	       cxt->nextpage, cxt->nextcount);
+	pr_debug("ready %d, %d (no erase)\n",
+		 cxt->nextpage, cxt->nextcount);
 }
 
 /* Scheduled work - when we can't proceed without erasing a block */
@@ -145,20 +147,20 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 
 	while ((ret = mtd_block_isbad(mtd, cxt->nextpage * record_size)) > 0) {
 badblock:
-		printk(KERN_WARNING "mtdoops: bad block at %08lx\n",
-		       cxt->nextpage * record_size);
+		pr_warn("bad block at %08lx\n",
+			cxt->nextpage * record_size);
 		i++;
 		cxt->nextpage = cxt->nextpage + (mtd->erasesize / record_size);
 		if (cxt->nextpage >= cxt->oops_pages)
 			cxt->nextpage = 0;
 		if (i == cxt->oops_pages / (mtd->erasesize / record_size)) {
-			printk(KERN_ERR "mtdoops: all blocks bad!\n");
+			pr_err("all blocks bad!\n");
 			return;
 		}
 	}
 
 	if (ret < 0) {
-		printk(KERN_ERR "mtdoops: mtd_block_isbad failed, aborting\n");
+		pr_err("mtd_block_isbad failed, aborting\n");
 		return;
 	}
 
@@ -166,15 +168,15 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 		ret = mtdoops_erase_block(cxt, cxt->nextpage * record_size);
 
 	if (ret >= 0) {
-		printk(KERN_DEBUG "mtdoops: ready %d, %d\n",
-		       cxt->nextpage, cxt->nextcount);
+		pr_debug("ready %d, %d\n",
+			 cxt->nextpage, cxt->nextcount);
 		return;
 	}
 
 	if (ret == -EIO) {
 		ret = mtd_block_markbad(mtd, cxt->nextpage * record_size);
 		if (ret < 0 && ret != -EOPNOTSUPP) {
-			printk(KERN_ERR "mtdoops: block_markbad failed, aborting\n");
+			pr_err("block_markbad failed, aborting\n");
 			return;
 		}
 	}
@@ -201,7 +203,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 		ret = mtd_panic_write(mtd, cxt->nextpage * record_size,
 				      record_size, &retlen, cxt->oops_buf);
 		if (ret == -EOPNOTSUPP) {
-			printk(KERN_ERR "mtdoops: Cannot write from panic without panic_write\n");
+			pr_err("Cannot write from panic without panic_write\n");
 			goto out;
 		}
 	} else
@@ -209,7 +211,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 				record_size, &retlen, cxt->oops_buf);
 
 	if (retlen != record_size || ret < 0)
-		printk(KERN_ERR "mtdoops: write failure at %ld (%td of %ld written), error %d\n",
+		pr_err("write failure at %ld (%td of %ld written), error %d\n",
 		       cxt->nextpage * record_size, retlen, record_size, ret);
 	mark_page_used(cxt, cxt->nextpage);
 	memset(cxt->oops_buf, 0xff, record_size);
@@ -244,7 +246,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 			       &retlen, (u_char *)&hdr);
 		if (retlen != sizeof(hdr) ||
 				(ret < 0 && !mtd_is_bitflip(ret))) {
-			printk(KERN_ERR "mtdoops: read failure at %ld (%zu of %zu read), err %d\n",
+			pr_err("read failure at %ld (%zu of %zu read), err %d\n",
 			       page * record_size, retlen, sizeof(hdr), ret);
 			continue;
 		}
@@ -324,17 +326,17 @@ static void mtdoops_notify_add(struct mtd_info *mtd)
 		return;
 
 	if (mtd->size < mtd->erasesize * 2) {
-		printk(KERN_ERR "mtdoops: MTD partition %d not big enough for mtdoops\n",
+		pr_err("MTD partition %d not big enough for mtdoops\n",
 		       mtd->index);
 		return;
 	}
 	if (mtd->erasesize < record_size) {
-		printk(KERN_ERR "mtdoops: eraseblock size of MTD partition %d too small\n",
+		pr_err("eraseblock size of MTD partition %d too small\n",
 		       mtd->index);
 		return;
 	}
 	if (mtd->size > MTDOOPS_MAX_MTD_SIZE) {
-		printk(KERN_ERR "mtdoops: mtd%d is too large (limit is %d MiB)\n",
+		pr_err("mtd%d is too large (limit is %d MiB)\n",
 		       mtd->index, MTDOOPS_MAX_MTD_SIZE / 1024 / 1024);
 		return;
 	}
@@ -345,7 +347,7 @@ static void mtdoops_notify_add(struct mtd_info *mtd)
 				   DIV_ROUND_UP(mtdoops_pages,
 						BITS_PER_LONG)));
 	if (!cxt->oops_page_used) {
-		printk(KERN_ERR "mtdoops: could not allocate page array\n");
+		pr_err("could not allocate page array\n");
 		return;
 	}
 
@@ -353,7 +355,7 @@ static void mtdoops_notify_add(struct mtd_info *mtd)
 	cxt->dump.dump = mtdoops_do_dump;
 	err = kmsg_dump_register(&cxt->dump);
 	if (err) {
-		printk(KERN_ERR "mtdoops: registering kmsg dumper failed, error %d\n", err);
+		pr_err("registering kmsg dumper failed, error %d\n", err);
 		vfree(cxt->oops_page_used);
 		cxt->oops_page_used = NULL;
 		return;
@@ -362,7 +364,7 @@ static void mtdoops_notify_add(struct mtd_info *mtd)
 	cxt->mtd = mtd;
 	cxt->oops_pages = (int)mtd->size / record_size;
 	find_next_position(cxt);
-	printk(KERN_INFO "mtdoops: Attached to MTD device %d\n", mtd->index);
+	pr_info("Attached to MTD device %d\n", mtd->index);
 }
 
 static void mtdoops_notify_remove(struct mtd_info *mtd)
@@ -373,7 +375,7 @@ static void mtdoops_notify_remove(struct mtd_info *mtd)
 		return;
 
 	if (kmsg_dump_unregister(&cxt->dump) < 0)
-		printk(KERN_WARNING "mtdoops: could not unregister kmsg_dumper\n");
+		pr_warn("could not unregister kmsg_dumper\n");
 
 	cxt->mtd = NULL;
 	flush_work(&cxt->work_erase);
@@ -393,15 +395,15 @@ static int __init mtdoops_init(void)
 	char *endp;
 
 	if (strlen(mtddev) == 0) {
-		printk(KERN_ERR "mtdoops: mtd device (mtddev=name/number) must be supplied\n");
+		pr_err("mtd device (mtddev=name/number) must be supplied\n");
 		return -EINVAL;
 	}
 	if ((record_size & 4095) != 0) {
-		printk(KERN_ERR "mtdoops: record_size must be a multiple of 4096\n");
+		pr_err("record_size must be a multiple of 4096\n");
 		return -EINVAL;
 	}
 	if (record_size < 4096) {
-		printk(KERN_ERR "mtdoops: record_size must be over 4096 bytes\n");
+		pr_err("record_size must be over 4096 bytes\n");
 		return -EINVAL;
 	}
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

