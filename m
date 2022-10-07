Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E335F8049
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJGVum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJGVuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:50:37 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D45F9AA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 14:50:36 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 7-20020a630007000000b0045bb8a49ae6so3280697pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 14:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkpszfP4h2/7GyFHKskjCX9AFVi8V6vMmb1v72zzmVg=;
        b=CM4MeXq8fYCIih2RJLdSc8UB4zjJqbwq79tXYZ1wiKA2kQMnKAo/8o57y9Y4RuYRH6
         6bEvagqc3LxGP1kPmPX3O5ZN3t9wLJiqiHttHiEynozwUk6JYm7zgIwKNrQL4qj0IrEp
         /zLpRxIv99TB4QgkY9eOAd9CGJ5Z4V0FT/LUfgVCISwsO3UUisYk+NIaOUpxKvcrnBm7
         FJ2K9E3srDAeJ3z/D2gsA9cX50Pz7YHo0Qt6ORzGQw9fdwSzXJKbpc40WbGo+9+nrfzz
         iU4spaQTqDJpnc6JtDtzXrf11B3ZcuQD6O3y6G/e+lnbgouvFxUVF1EOp8GIPcyDA3EH
         wp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkpszfP4h2/7GyFHKskjCX9AFVi8V6vMmb1v72zzmVg=;
        b=xueYSodwixRFfaYwRvl/X8ZJpZ/PwBqV3mUCvWOvg9eRDNXbyTKrmsuIBbdW4/JjzA
         h3TYvu9eMRAyqEdwNXa5FZHNZ06NjBN5gIsdEq+0F3jvxHxVjRo2kUMYIgh3ieTlVrIw
         acA6DL6UlKj/nm2PRNHLrsQZYspevNiodgw/hghdTqVC1d4D1vA4wYdITfXBEzm3J3dX
         l/mPsE9pLR7oYAZ9TWTwj/uEVXkSv6Fphu071KPEK7cABQB0IaA2t/Vt7HDLYSfOQNgc
         y/pIEzeUjfik+a4XBKjg8a+Kcpd5J0I5VO2BxvfDtlo6rcDm4dXdBgiyx6/Ib2psxrKB
         Sjrw==
X-Gm-Message-State: ACrzQf1mq6nsnZqrQGiDKPE3AJy1KbqIu2gSgXQ+kmsl2xWM6g5PIy1F
        72A0VkH1ySYz5qhWYJ0GE1tJ6608pLmb
X-Google-Smtp-Source: AMsMyM5Oi3sZ7TgLvU2Wlq5+qg8oIYkpKXnJdzrirPgwmv8mFRx4EV2O/+YhS7CCS6Y8IsU1JUmtH00+HnBN
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP id
 d6-20020a17090acd0600b00203ae0e6a21mr890414pju.0.1665179435196; Fri, 07 Oct
 2022 14:50:35 -0700 (PDT)
Date:   Fri,  7 Oct 2022 21:50:25 +0000
In-Reply-To: <20221007215027.918507-1-sgzhang@google.com>
Mime-Version: 1.0
References: <20221007215027.918507-1-sgzhang@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221007215027.918507-2-sgzhang@google.com>
Subject: [PATCH v3 1/3] mtd: mtdoops: change printk() to counterpart pr_ functions
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
 drivers/mtd/mtdoops.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 3d4a2ffb5b01..84b21be347f6 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -93,9 +93,9 @@ static int mtdoops_erase_block(struct mtdoops_context *cxt, int offset)
 
 	ret = mtd_erase(mtd, &erase);
 	if (ret) {
-		printk(KERN_WARNING "mtdoops: erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
-		       (unsigned long long)erase.addr,
-		       (unsigned long long)erase.len, mtddev);
+		pr_warn("mtdoops: erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
+			(unsigned long long)erase.addr,
+			(unsigned long long)erase.len, mtddev);
 		return ret;
 	}
 
@@ -120,8 +120,8 @@ static void mtdoops_inc_counter(struct mtdoops_context *cxt)
 		return;
 	}
 
-	printk(KERN_DEBUG "mtdoops: ready %d, %d (no erase)\n",
-	       cxt->nextpage, cxt->nextcount);
+	pr_debug("mtdoops: ready %d, %d (no erase)\n",
+		 cxt->nextpage, cxt->nextcount);
 }
 
 /* Scheduled work - when we can't proceed without erasing a block */
@@ -145,20 +145,20 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 
 	while ((ret = mtd_block_isbad(mtd, cxt->nextpage * record_size)) > 0) {
 badblock:
-		printk(KERN_WARNING "mtdoops: bad block at %08lx\n",
-		       cxt->nextpage * record_size);
+		pr_warn("mtdoops: bad block at %08lx\n",
+			cxt->nextpage * record_size);
 		i++;
 		cxt->nextpage = cxt->nextpage + (mtd->erasesize / record_size);
 		if (cxt->nextpage >= cxt->oops_pages)
 			cxt->nextpage = 0;
 		if (i == cxt->oops_pages / (mtd->erasesize / record_size)) {
-			printk(KERN_ERR "mtdoops: all blocks bad!\n");
+			pr_err("mtdoops: all blocks bad!\n");
 			return;
 		}
 	}
 
 	if (ret < 0) {
-		printk(KERN_ERR "mtdoops: mtd_block_isbad failed, aborting\n");
+		pr_err("mtdoops: mtd_block_isbad failed, aborting\n");
 		return;
 	}
 
@@ -166,15 +166,15 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 		ret = mtdoops_erase_block(cxt, cxt->nextpage * record_size);
 
 	if (ret >= 0) {
-		printk(KERN_DEBUG "mtdoops: ready %d, %d\n",
-		       cxt->nextpage, cxt->nextcount);
+		pr_debug("mtdoops: ready %d, %d\n",
+			 cxt->nextpage, cxt->nextcount);
 		return;
 	}
 
 	if (ret == -EIO) {
 		ret = mtd_block_markbad(mtd, cxt->nextpage * record_size);
 		if (ret < 0 && ret != -EOPNOTSUPP) {
-			printk(KERN_ERR "mtdoops: block_markbad failed, aborting\n");
+			pr_err("mtdoops: block_markbad failed, aborting\n");
 			return;
 		}
 	}
@@ -201,7 +201,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 		ret = mtd_panic_write(mtd, cxt->nextpage * record_size,
 				      record_size, &retlen, cxt->oops_buf);
 		if (ret == -EOPNOTSUPP) {
-			printk(KERN_ERR "mtdoops: Cannot write from panic without panic_write\n");
+			pr_err("mtdoops: Cannot write from panic without panic_write\n");
 			goto out;
 		}
 	} else
@@ -209,7 +209,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 				record_size, &retlen, cxt->oops_buf);
 
 	if (retlen != record_size || ret < 0)
-		printk(KERN_ERR "mtdoops: write failure at %ld (%td of %ld written), error %d\n",
+		pr_err("mtdoops: write failure at %ld (%td of %ld written), error %d\n",
 		       cxt->nextpage * record_size, retlen, record_size, ret);
 	mark_page_used(cxt, cxt->nextpage);
 	memset(cxt->oops_buf, 0xff, record_size);
@@ -244,7 +244,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 			       &retlen, (u_char *)&hdr);
 		if (retlen != sizeof(hdr) ||
 				(ret < 0 && !mtd_is_bitflip(ret))) {
-			printk(KERN_ERR "mtdoops: read failure at %ld (%zu of %zu read), err %d\n",
+			pr_err("mtdoops: read failure at %ld (%zu of %zu read), err %d\n",
 			       page * record_size, retlen, sizeof(hdr), ret);
 			continue;
 		}
@@ -324,17 +324,17 @@ static void mtdoops_notify_add(struct mtd_info *mtd)
 		return;
 
 	if (mtd->size < mtd->erasesize * 2) {
-		printk(KERN_ERR "mtdoops: MTD partition %d not big enough for mtdoops\n",
+		pr_err("mtdoops: MTD partition %d not big enough for mtdoops\n",
 		       mtd->index);
 		return;
 	}
 	if (mtd->erasesize < record_size) {
-		printk(KERN_ERR "mtdoops: eraseblock size of MTD partition %d too small\n",
+		pr_err("mtdoops: eraseblock size of MTD partition %d too small\n",
 		       mtd->index);
 		return;
 	}
 	if (mtd->size > MTDOOPS_MAX_MTD_SIZE) {
-		printk(KERN_ERR "mtdoops: mtd%d is too large (limit is %d MiB)\n",
+		pr_err("mtdoops: mtd%d is too large (limit is %d MiB)\n",
 		       mtd->index, MTDOOPS_MAX_MTD_SIZE / 1024 / 1024);
 		return;
 	}
@@ -345,7 +345,7 @@ static void mtdoops_notify_add(struct mtd_info *mtd)
 				   DIV_ROUND_UP(mtdoops_pages,
 						BITS_PER_LONG)));
 	if (!cxt->oops_page_used) {
-		printk(KERN_ERR "mtdoops: could not allocate page array\n");
+		pr_err("mtdoops: could not allocate page array\n");
 		return;
 	}
 
@@ -353,7 +353,7 @@ static void mtdoops_notify_add(struct mtd_info *mtd)
 	cxt->dump.dump = mtdoops_do_dump;
 	err = kmsg_dump_register(&cxt->dump);
 	if (err) {
-		printk(KERN_ERR "mtdoops: registering kmsg dumper failed, error %d\n", err);
+		pr_err("mtdoops: registering kmsg dumper failed, error %d\n", err);
 		vfree(cxt->oops_page_used);
 		cxt->oops_page_used = NULL;
 		return;
@@ -362,7 +362,7 @@ static void mtdoops_notify_add(struct mtd_info *mtd)
 	cxt->mtd = mtd;
 	cxt->oops_pages = (int)mtd->size / record_size;
 	find_next_position(cxt);
-	printk(KERN_INFO "mtdoops: Attached to MTD device %d\n", mtd->index);
+	pr_info("mtdoops: Attached to MTD device %d\n", mtd->index);
 }
 
 static void mtdoops_notify_remove(struct mtd_info *mtd)
@@ -373,7 +373,7 @@ static void mtdoops_notify_remove(struct mtd_info *mtd)
 		return;
 
 	if (kmsg_dump_unregister(&cxt->dump) < 0)
-		printk(KERN_WARNING "mtdoops: could not unregister kmsg_dumper\n");
+		pr_warn("mtdoops: could not unregister kmsg_dumper\n");
 
 	cxt->mtd = NULL;
 	flush_work(&cxt->work_erase);
@@ -393,15 +393,15 @@ static int __init mtdoops_init(void)
 	char *endp;
 
 	if (strlen(mtddev) == 0) {
-		printk(KERN_ERR "mtdoops: mtd device (mtddev=name/number) must be supplied\n");
+		pr_err("mtdoops: mtd device (mtddev=name/number) must be supplied\n");
 		return -EINVAL;
 	}
 	if ((record_size & 4095) != 0) {
-		printk(KERN_ERR "mtdoops: record_size must be a multiple of 4096\n");
+		pr_err("mtdoops: record_size must be a multiple of 4096\n");
 		return -EINVAL;
 	}
 	if (record_size < 4096) {
-		printk(KERN_ERR "mtdoops: record_size must be over 4096 bytes\n");
+		pr_err("mtdoops: record_size must be over 4096 bytes\n");
 		return -EINVAL;
 	}
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

