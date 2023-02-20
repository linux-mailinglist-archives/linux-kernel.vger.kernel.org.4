Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E475269D0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjBTPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjBTPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:33:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAA46E9C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676907177; x=1708443177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pVyCUhUAC9GAkjDWps3VzfA7cnMkEYE/QOmQHDbRpDM=;
  b=G2sMl3Psc/UATicZJGomIv5E97fKMSDDaV08zZkI2TOOLUW6i9aR7o97
   oX5vFNrQMfQtfv3zvgujtIOz6JGMZ+dwAmly+ueBsC0rLa4em9q/VUFjm
   TY6T2xpWG5BVeza87S3Dikj7QFRiXi/CvDoK/EkvhFNM4rU3tY6DcGkhV
   lnTDi/yhuy/Ue2gcekjdjU7mebxk7DUeFF10Fb0UpprUpbhytBPF1PfaH
   vGlDzeXO3cl1xwi3Q+Rj+2Xu394qqaQDgw6dZYWxN57vKGYPxw5zM5v0s
   s4f9JDIhjJDKf+RCQypoPPFARyEOpzTIZXJbz0fFpn1DtTp8PI/40l93L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="334624678"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="334624678"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 07:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="735169947"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="735169947"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2023 07:32:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 458E0147; Mon, 20 Feb 2023 17:33:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] regmap-irq: Place kernel doc of struct regmap_irq_chip in order
Date:   Mon, 20 Feb 2023 17:33:34 +0200
Message-Id: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that a couple of members got lost theirorder, put them back.
Besides that, split field descriptions into groups in the same way
as it's done in the structure definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on the latest Linux Next (Mark)
 include/linux/regmap.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4d10790adeb0..1c777566fb7d 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1551,6 +1551,7 @@ struct regmap_irq_chip_data;
  * @use_ack:     Use @ack register even if it is zero.
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
+ * @status_invert: Inverted status register: cleared bits are active interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_in_mask: Use the mask registers for controlling irq type. Use this if
  *		  the hardware provides separate bits for rising/falling edge
@@ -1560,18 +1561,19 @@ struct regmap_irq_chip_data;
  * @clear_on_unmask: For chips with interrupts cleared on read: read the status
  *                   registers before unmasking interrupts to clear any bits
  *                   set when they were masked.
+ * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  * @not_fixed_stride: Used when chip peripherals are not laid out with fixed
  *		      stride. Must be used with sub_reg_offsets containing the
  *		      offsets to each peripheral. Deprecated; the same thing
  *		      can be accomplished with a @get_irq_reg callback, without
  *		      the need for a @sub_reg_offsets table.
- * @status_invert: Inverted status register: cleared bits are active interrupts.
- * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
  * @num_regs:    Number of registers in each control bank.
+ *
  * @irqs:        Descriptors for individual IRQs.  Interrupt numbers are
  *               assigned based on the index in the array of the interrupt.
  * @num_irqs:    Number of descriptors.
+ *
  * @num_type_reg:    Number of type registers. Deprecated, use config registers
  *		     instead.
  * @num_virt_regs:   Number of non-standard irq configuration registers.
@@ -1579,6 +1581,7 @@ struct regmap_irq_chip_data;
  *		     instead.
  * @num_config_bases:	Number of config base registers.
  * @num_config_regs:	Number of config registers for each config base register.
+ *
  * @handle_pre_irq:  Driver specific callback to handle interrupt from device
  *		     before regmap_irq_handler process the interrupts.
  * @handle_post_irq: Driver specific callback to handle interrupt from device
@@ -1625,12 +1628,12 @@ struct regmap_irq_chip {
 	unsigned int use_ack:1;
 	unsigned int ack_invert:1;
 	unsigned int clear_ack:1;
+	unsigned int status_invert:1;
 	unsigned int wake_invert:1;
-	unsigned int runtime_pm:1;
 	unsigned int type_in_mask:1;
 	unsigned int clear_on_unmask:1;
+	unsigned int runtime_pm:1;
 	unsigned int not_fixed_stride:1;
-	unsigned int status_invert:1;
 
 	int num_regs;
 
-- 
2.39.1

