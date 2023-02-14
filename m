Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D341E695D42
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjBNIkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjBNIkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:40:32 -0500
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE9C178
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:40:22 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id RqrMpTv93mwp8RqrMpArGj; Tue, 14 Feb 2023 09:40:20 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Feb 2023 09:40:20 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] regmap: Reorder fields in 'struct regmap_bus' to save some memory
Date:   Tue, 14 Feb 2023 09:40:14 +0100
Message-Id: <077ca39622c8870a3ea932298a9cec34f7a8295a.1676363976.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some bool variables to reduce hole and avoid padding.
On x86_64, this shrinks the size from 136 to 128 bytes.

As an example:

$ size drivers/base/regmap/regmap-fsi.o (Before)
   text	   data	    bss	    dec	    hex	filename
   4837	    136	      0	   4973	   136d	drivers/base/regmap/regmap-fsi.o

$ size drivers/base/regmap/regmap-fsi.o (After)
   text	   data	    bss	    dec	    hex	filename
   4701	    136	      0	   4837	   12e5	drivers/base/regmap/regmap-fsi.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct regmap_bus {
	bool                       fast_io;              /*     0     1 */

	/* XXX 7 bytes hole, try to pack */

	regmap_hw_write            write;                /*     8     8 */
	regmap_hw_gather_write     gather_write;         /*    16     8 */
	regmap_hw_async_write      async_write;          /*    24     8 */
	regmap_hw_reg_write        reg_write;            /*    32     8 */
	regmap_hw_reg_noinc_write  reg_noinc_write;      /*    40     8 */
	regmap_hw_reg_update_bits  reg_update_bits;      /*    48     8 */
	regmap_hw_read             read;                 /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	regmap_hw_reg_read         reg_read;             /*    64     8 */
	regmap_hw_reg_noinc_read   reg_noinc_read;       /*    72     8 */
	regmap_hw_free_context     free_context;         /*    80     8 */
	regmap_hw_async_alloc      async_alloc;          /*    88     8 */
	u8                         read_flag_mask;       /*    96     1 */

	/* XXX 3 bytes hole, try to pack */

	enum regmap_endian         reg_format_endian_default; /*   100     4 */
	enum regmap_endian         val_format_endian_default; /*   104     4 */

	/* XXX 4 bytes hole, try to pack */

	size_t                     max_raw_read;         /*   112     8 */
	size_t                     max_raw_write;        /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	bool                       free_on_exit;         /*   128     1 */

	/* size: 136, cachelines: 3, members: 18 */
	/* sum members: 115, holes: 3, sum holes: 14 */
	/* padding: 7 */
	/* last cacheline: 8 bytes */
};


After:
=====
struct regmap_bus {
	bool                       fast_io;              /*     0     1 */
	bool                       free_on_exit;         /*     1     1 */

	/* XXX 6 bytes hole, try to pack */

	regmap_hw_write            write;                /*     8     8 */
	regmap_hw_gather_write     gather_write;         /*    16     8 */
	regmap_hw_async_write      async_write;          /*    24     8 */
	regmap_hw_reg_write        reg_write;            /*    32     8 */
	regmap_hw_reg_noinc_write  reg_noinc_write;      /*    40     8 */
	regmap_hw_reg_update_bits  reg_update_bits;      /*    48     8 */
	regmap_hw_read             read;                 /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	regmap_hw_reg_read         reg_read;             /*    64     8 */
	regmap_hw_reg_noinc_read   reg_noinc_read;       /*    72     8 */
	regmap_hw_free_context     free_context;         /*    80     8 */
	regmap_hw_async_alloc      async_alloc;          /*    88     8 */
	u8                         read_flag_mask;       /*    96     1 */

	/* XXX 3 bytes hole, try to pack */

	enum regmap_endian         reg_format_endian_default; /*   100     4 */
	enum regmap_endian         val_format_endian_default; /*   104     4 */

	/* XXX 4 bytes hole, try to pack */

	size_t                     max_raw_read;         /*   112     8 */
	size_t                     max_raw_write;        /*   120     8 */

	/* size: 128, cachelines: 2, members: 18 */
	/* sum members: 115, holes: 3, sum holes: 13 */
};
---
 include/linux/regmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 029b9e09d3ca..f26432dc02ef 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -520,6 +520,7 @@ typedef void (*regmap_hw_free_context)(void *context);
  *	     to perform locking. This field is ignored if custom lock/unlock
  *	     functions are used (see fields lock/unlock of
  *	     struct regmap_config).
+ * @free_on_exit: kfree this on exit of regmap
  * @write: Write operation.
  * @gather_write: Write operation with split register/value, return -ENOTSUPP
  *                if not implemented  on a given device.
@@ -548,10 +549,10 @@ typedef void (*regmap_hw_free_context)(void *context);
  *     DEFAULT, BIG is assumed.
  * @max_raw_read: Max raw read size that can be used on the bus.
  * @max_raw_write: Max raw write size that can be used on the bus.
- * @free_on_exit: kfree this on exit of regmap
  */
 struct regmap_bus {
 	bool fast_io;
+	bool free_on_exit;
 	regmap_hw_write write;
 	regmap_hw_gather_write gather_write;
 	regmap_hw_async_write async_write;
@@ -568,7 +569,6 @@ struct regmap_bus {
 	enum regmap_endian val_format_endian_default;
 	size_t max_raw_read;
 	size_t max_raw_write;
-	bool free_on_exit;
 };
 
 /*
-- 
2.34.1

