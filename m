Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4D369AFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjBQP5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjBQP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:57:09 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1B711AF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:56:41 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id T35cpSuxkFOC9T35cp2ZIu; Fri, 17 Feb 2023 16:56:01 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 17 Feb 2023 16:56:01 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-clk@vger.kernel.org
Subject: [PATCH] clk: Reorder fields in 'struct clk_fractional_divider'
Date:   Fri, 17 Feb 2023 16:55:55 +0100
Message-Id: <d1874eb8848d5f97f87337011188640a1463a666.1676649335.git.christophe.jaillet@wanadoo.fr>
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

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct clk_fractional_divider'
from 72 to 64 bytes.

It saves a few bytes of memory when the structure is kzalloc()'ed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct clk_fractional_divider {
	struct clk_hw              hw;                   /*     0    24 */
	void *                     reg;                  /*    24     8 */
	u8                         mshift;               /*    32     1 */
	u8                         mwidth;               /*    33     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        mmask;                /*    36     4 */
	u8                         nshift;               /*    40     1 */
	u8                         nwidth;               /*    41     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        nmask;                /*    44     4 */
	u8                         flags;                /*    48     1 */

	/* XXX 7 bytes hole, try to pack */

	void                       (*approximation)(struct clk_hw *, long unsigned int, long unsigned int *, long unsigned int *, long unsigned int *); /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	spinlock_t *               lock;                 /*    64     8 */

	/* size: 72, cachelines: 2, members: 11 */
	/* sum members: 61, holes: 3, sum holes: 11 */
	/* last cacheline: 8 bytes */
};


After:
=====
struct clk_fractional_divider {
	struct clk_hw              hw;                   /*     0    24 */
	void *                     reg;                  /*    24     8 */
	u8                         flags;                /*    32     1 */
	u8                         mshift;               /*    33     1 */
	u8                         mwidth;               /*    34     1 */

	/* XXX 1 byte hole, try to pack */

	u32                        mmask;                /*    36     4 */
	u8                         nshift;               /*    40     1 */
	u8                         nwidth;               /*    41     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        nmask;                /*    44     4 */
	void                       (*approximation)(struct clk_hw *, long unsigned int, long unsigned int *, long unsigned int *, long unsigned int *); /*    48     8 */
	spinlock_t *               lock;                 /*    56     8 */

	/* size: 64, cachelines: 1, members: 11 */
	/* sum members: 61, holes: 2, sum holes: 3 */
};
---
 include/linux/clk-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index cf1adfeaf257..8cec844f5dde 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1134,13 +1134,13 @@ struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
 struct clk_fractional_divider {
 	struct clk_hw	hw;
 	void __iomem	*reg;
+	u8		flags;
 	u8		mshift;
 	u8		mwidth;
 	u32		mmask;
 	u8		nshift;
 	u8		nwidth;
 	u32		nmask;
-	u8		flags;
 	void		(*approximation)(struct clk_hw *hw,
 				unsigned long rate, unsigned long *parent_rate,
 				unsigned long *m, unsigned long *n);
-- 
2.34.1

