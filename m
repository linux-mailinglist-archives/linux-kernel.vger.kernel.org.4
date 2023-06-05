Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2C72323E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjFEV1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjFEV1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:27:37 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED2110A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:27:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686000452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/W2KTV3ULawkr9BtdK4REvFFcYHPIv4u0Yiv/rOYuY=;
        b=tjmpCz2EinHgsmvuXii8BrI6Xyb3kVTA5dfu1dGW48GnnlR9bF5r/ar6aQtTDrHJdKlVZ+
        smA0XvgGjirfWIzaRrmGJeUG4Wsj1gj3yN6px1v51k/rdliYnASvFPNkrBNVQH2fBG4p1K
        nZi7M2e7o1e/Rn/rVMwMgEdUd166Y5c=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 5/5] block: CONFIG_BLK_DEBUG
Date:   Mon,  5 Jun 2023 17:27:17 -0400
Message-Id: <20230605212717.2570570-5-kent.overstreet@linux.dev>
In-Reply-To: <20230605212717.2570570-1-kent.overstreet@linux.dev>
References: <20230605212717.2570570-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new kconfig option to enable some extra debug mode
assertions. Currently this is just used for some bio iterator
assertions, but hopefully more will be added in the future.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 block/Kconfig        | 7 +++++++
 include/linux/bio.h  | 5 +++++
 include/linux/bvec.h | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 86122e459f..611dddb59c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -165,6 +165,13 @@ config BLK_CGROUP_IOPRIO
 	scheduler and block devices process requests. Only some I/O schedulers
 	and some block devices support I/O priorities.
 
+config BLK_DEBUG
+	bool "Extra block layer assertions"
+	depends on DEBUG_KERNEL
+	help
+	Enable extra assertions in the block layer. Currently this is just the
+	bio iterator code, but may be expanded.
+
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f599bcf15e..cece57c54d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -81,6 +81,8 @@ static inline void *bio_data(struct bio *bio)
 static inline struct bio_vec bio_iter_all_peek(const struct bio *bio,
 					       struct bvec_iter_all *iter)
 {
+	BLK_BUG_ON(iter->idx >= bio->bi_vcnt);
+
 	return bvec_iter_all_peek(bio->bi_io_vec, iter);
 }
 
@@ -89,6 +91,9 @@ static inline void bio_iter_all_advance(const struct bio *bio,
 					unsigned bytes)
 {
 	bvec_iter_all_advance(bio->bi_io_vec, iter, bytes);
+
+	BLK_BUG_ON(iter->idx > bio->bi_vcnt ||
+		   (iter->idx == bio->bi_vcnt && iter->done));
 }
 
 #define bio_for_each_segment_all_continue(bvl, bio, iter)		\
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ee5965fedf..2467245da2 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -16,6 +16,12 @@
 
 struct page;
 
+#ifdef CONFIG_BLK_DEBUG
+#define BLK_BUG_ON(cond) BUG_ON(cond)
+#else
+#define BLK_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
+#endif
+
 /**
  * struct bio_vec - a contiguous range of physical memory addresses
  * @bv_page:   First page associated with the address range.
@@ -210,6 +216,8 @@ static inline struct bio_vec __bvec_iter_all_peek(const struct bio_vec *bvec,
 {
 	struct bio_vec bv = bvec[iter->idx];
 
+	BLK_BUG_ON(iter->done >= bv.bv_len);
+
 	bv.bv_offset	+= iter->done;
 	bv.bv_len	-= iter->done;
 
-- 
2.40.1

