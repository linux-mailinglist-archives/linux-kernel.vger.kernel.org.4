Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD75F1300
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiI3TwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiI3TwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:52:19 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDB18E694
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:52:18 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id f11-20020a5d858b000000b006a17b75af65so3435550ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=M+0FjOXGxdUyOWeiIKmnYqXrvtkV45XJ57lTF7hku5U=;
        b=OHjxPF0CBcbVcOGxJ6AfkBgP6ehzsTThmZ1tBnO5VAvOPc1o4N2O4UzFZ6KdCnVhUh
         jiqFmBY79+eRtCKZrKru5khB16VvhFMG8QpkgMFmR1XNITxRjHFJC1Z29n5p4cOuq2HF
         EL9Le0jLEloNqQ/DMh9C7xPTiTd8T8RHqv2LOtfowtqePlaPOfOOeo1CCMnSC4ZFFtea
         6GB4WV5qwMWjQC2awnhV47b50YV6ER30wgkKPSq09U4byiuxtq1KxJwTPAgbz3FeSzEL
         cs6hyV0ngnWWbEzFf3dG/E+qMuTwWUiJzzaMGKeZjBYqLfvyZKxkkhZ7aDHn8O8EpDhS
         PKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=M+0FjOXGxdUyOWeiIKmnYqXrvtkV45XJ57lTF7hku5U=;
        b=qAkFHdPYDEqoPNSIlQqWEpv5omR/HIE6c4ZO2EcMYVbZK1gid+vS6JEIckP0bCQRfV
         /zGLv2sOK+B7lG27CMLjvPWC+ZrCE2S8tclQYSgNvzrE+8WAL57HUlKM0v6KkcMQDoIv
         fcuBfcCaSpvA++/q0LJDEqAm8oMqNxG5TXzW1yDITXJCZ55wFNeePP1rg+CyPeGZ1LhL
         fboPrE9SSjHKObafm2uurw1TUu3Rp0gBFfkbmlCkH3jwjWI2aOyyaop8q0sPWILJUS0x
         waAJgycZ0Lc30b+GJplFRpDh57VTtDpD5B+IJIkqCY+ZvW9CXXv2fCRWImi6RXb7EsIR
         rThw==
X-Gm-Message-State: ACrzQf1f07a4FuK2lwTBUQH/OARXdB+w62/Bfw3lKft+R5hZcEII18Sn
        Ua8uqvSUZffJpNxZ7salnM/4mftQDQse
X-Google-Smtp-Source: AMsMyM6KeFXwgfL1YORHVcKAI+/tHDmnV7aLNPCd0P/jHf5mS+U+kAwFNGyj4hBsx5SqaOiN4dxOa2+nFjRq
X-Received: from bg.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b4])
 (user=bgeffon job=sendgmr) by 2002:a05:6638:3043:b0:341:d8a4:73e8 with SMTP
 id u3-20020a056638304300b00341d8a473e8mr5584265jak.239.1664567538267; Fri, 30
 Sep 2022 12:52:18 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:52:15 -0400
In-Reply-To: <Yy4JkpZ/SnXtrVRf@google.com>
Mime-Version: 1.0
References: <Yy4JkpZ/SnXtrVRf@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930195215.2360317-1-bgeffon@google.com>
Subject: [PATCH] zram: Always expose rw_page
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Rom Lemarchand <romlem@google.com>, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>
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

Currently zram will adjust its fops to a version which does not
contain rw_page when a backing device has been assigned. This is
done to prevent upper layers from assuming a synchronous operation
when a page may have been written back. This forces every operation
through bio which has overhead associated with bio_alloc/frees.

The code can be simplified to always expose a rw_page method and
only in the rare event that a page is written back we instead will
return -EOPNOTSUPP forcing the upper layer to fallback to bio.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 drivers/block/zram/zram_drv.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 226ea76cc819..b9646886be0f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -52,9 +52,6 @@ static unsigned int num_devices = 1;
 static size_t huge_class_size;
 
 static const struct block_device_operations zram_devops;
-#ifdef CONFIG_ZRAM_WRITEBACK
-static const struct block_device_operations zram_wb_devops;
-#endif
 
 static void zram_free_page(struct zram *zram, size_t index);
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
@@ -543,17 +540,6 @@ static ssize_t backing_dev_store(struct device *dev,
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
-	/*
-	 * With writeback feature, zram does asynchronous IO so it's no longer
-	 * synchronous device so let's remove synchronous io flag. Othewise,
-	 * upper layer(e.g., swap) could wait IO completion rather than
-	 * (submit and return), which will cause system sluggish.
-	 * Furthermore, when the IO function returns(e.g., swap_readpage),
-	 * upper layer expects IO was done so it could deallocate the page
-	 * freely but in fact, IO is going on so finally could cause
-	 * use-after-free when the IO is really done.
-	 */
-	zram->disk->fops = &zram_wb_devops;
 	up_write(&zram->init_lock);
 
 	pr_info("setup backing device %s\n", file_name);
@@ -1267,6 +1253,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		struct bio_vec bvec;
 
 		zram_slot_unlock(zram, index);
+		/* If we don't have a bio we came via rw_page, we must fallback to bio */
+		if (!bio)
+			return -EOPNOTSUPP;
 
 		bvec.bv_page = page;
 		bvec.bv_len = PAGE_SIZE;
@@ -1848,15 +1837,6 @@ static const struct block_device_operations zram_devops = {
 	.owner = THIS_MODULE
 };
 
-#ifdef CONFIG_ZRAM_WRITEBACK
-static const struct block_device_operations zram_wb_devops = {
-	.open = zram_open,
-	.submit_bio = zram_submit_bio,
-	.swap_slot_free_notify = zram_slot_free_notify,
-	.owner = THIS_MODULE
-};
-#endif
-
 static DEVICE_ATTR_WO(compact);
 static DEVICE_ATTR_RW(disksize);
 static DEVICE_ATTR_RO(initstate);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

