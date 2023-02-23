Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B76A00B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjBWBm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBWBm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:42:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB53CE27
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677116546; x=1708652546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8eVOJTR3++h5ooqz/0hjkn4J4fdx89sFGRFdqwx4JLE=;
  b=BJeXFlKkuASFEmWhZoIYfA01HpJMue1cZ9VgesJ/LkfZlfaIbg75p1rA
   5211fjqcWN9OCzyVXei3KIile5GB90b2CMD5sIl3SZN2RFhJgEqryn31/
   r10EWnz8kKpubZQLcgKN/96Hz8M3llATQwArGRLyo8kjtklfFyJlaISdQ
   /snyMFWrc3iUrCHHCT94bHyv6u5ZhF4n0teDE6GVMNEzk+nJTQGKqfEK/
   xT4wnTPhIimx8M1pp1P+Bbg+uiwHy4DpuJDmh0QFWOvFDQs3IEsZomqrA
   RhPKC3QULpZpcOGwP0ryKNCHJtMMDqhINYa/K+9t3hnh0OSyZZBJ9pQGe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="321233295"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="321233295"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 17:42:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="665566054"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="665566054"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 17:42:25 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH -next] mux: convert mux_chip->mux to flexible array
Date:   Wed, 22 Feb 2023 17:42:21 -0800
Message-Id: <20230223014221.1710307-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mux_chip structure size is over allocated to additionally include both
the array of mux controllers as well as a device specific private area.
The controllers array is then pointed to by assigning mux_chip->mux to the
first block of extra memory, while the private area is extracted via
mux_chip_priv() and points to the area just after the controllers.

The size of the mux_chip allocation uses direct multiplication and addition
rather than the <linux/overflow.h> helpers. In addition, the mux_chip->mux
struct member wastes space by having to store the pointer as part of the
structures.

Convert struct mux_chip to use a flexible array member for the mux
controller array. Use struct_size() and size_add() to compute the size of
the structure while protecting against overflow.

After converting the mux pointer, notice that two 4-byte holes remain in
the structure layout due to the alignment requirements for the dev
sub-structure and the ops pointer.

These can be easily fixed through re-ordering the id field to the 4-byte
hole just after the controllers member.

This changes the layout from:

struct mux_chip {
        unsigned int               controllers;          /*     0     4 */

        /* XXX 4 bytes hole, try to pack */

        struct mux_control *       mux;                  /*     8     8 */
        struct device              dev __attribute__((__aligned__(8))); /*    16  1400 */

        /* XXX last struct has 3 bytes of padding */

        /* --- cacheline 22 boundary (1408 bytes) was 8 bytes ago --- */
        int                        id;                   /*  1416     4 */

        /* XXX 4 bytes hole, try to pack */

        const struct mux_control_ops  * ops;             /*  1424     8 */

        /* size: 1432, cachelines: 23, members: 5 */
        /* sum members: 1424, holes: 2, sum holes: 8 */
        /* paddings: 1, sum paddings: 3 */
        /* forced alignments: 1 */
        /* last cacheline: 24 bytes */
} __attribute__((__aligned__(8)));

To the following:

struct mux_chip {
        unsigned int               controllers;          /*     0     4 */
        int                        id;                   /*     4     4 */
        struct device              dev __attribute__((__aligned__(8))); /*     8  1400 */

        /* XXX last struct has 3 bytes of padding */

        /* --- cacheline 22 boundary (1408 bytes) --- */
        const struct mux_control_ops  * ops;             /*  1408     8 */
        struct mux_control         mux[];                /*  1416     0 */

        /* size: 1416, cachelines: 23, members: 5 */
        /* paddings: 1, sum paddings: 3 */
        /* forced alignments: 1 */
        /* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));

This both removes risk of overflowing and performing an under-allocation,
as well as saves 16 bytes of otherwise wasted space for every mux_chip.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/mux/core.c         |  7 +++----
 include/linux/mux/driver.h | 10 +++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 49bedbe6316c..3e26b9911cc2 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -100,13 +100,12 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
 	if (WARN_ON(!dev || !controllers))
 		return ERR_PTR(-EINVAL);
 
-	mux_chip = kzalloc(sizeof(*mux_chip) +
-			   controllers * sizeof(*mux_chip->mux) +
-			   sizeof_priv, GFP_KERNEL);
+	mux_chip = kzalloc(size_add(struct_size(mux_chip, mux, controllers),
+				    sizeof_priv),
+			   GFP_KERNEL);
 	if (!mux_chip)
 		return ERR_PTR(-ENOMEM);
 
-	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
 	mux_chip->dev.class = &mux_class;
 	mux_chip->dev.type = &mux_type;
 	mux_chip->dev.parent = dev;
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 18824064f8c0..84dc0d3e79d6 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -56,18 +56,18 @@ struct mux_control {
 /**
  * struct mux_chip -	Represents a chip holding mux controllers.
  * @controllers:	Number of mux controllers handled by the chip.
- * @mux:		Array of mux controllers that are handled.
- * @dev:		Device structure.
  * @id:			Used to identify the device internally.
+ * @dev:		Device structure.
  * @ops:		Mux controller operations.
+ * @mux:		Flexible array of mux controllers that are handled.
  */
 struct mux_chip {
 	unsigned int controllers;
-	struct mux_control *mux;
-	struct device dev;
 	int id;
-
+	struct device dev;
 	const struct mux_control_ops *ops;
+
+	struct mux_control mux[];
 };
 
 #define to_mux_chip(x) container_of((x), struct mux_chip, dev)

base-commit: 307e14c039063f0c9bd7a18a7add8f940580dcc9
-- 
I found this while developing a coccinelle patch that helps detect potential
code that could be converted to struct_size() and noticed this weird case
that could be a flexible array and save memory.

2.39.1.405.gd4c25cc71f83

