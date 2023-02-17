Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F47369B296
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBQSwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:52:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673312D64
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676659968; x=1708195968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qWdXU8+AY5bvvKgSyD0R0V06MxM7iYNdZ+POrljfklg=;
  b=Tdvmt9qhN/8ykGqX1s205FJ/IhLyGekC4WqZI20nWgsf1ax/jKk5lTlx
   nqyCCdF85dmS42ZG8UXBgQvKSskY6eBDYZUtzuUJZOQCWOiZzbdHOVPwc
   k6vQGj9Ipy4keimsMLf1/cmFkZN6dJ79bP0P8XhCbfwGWRsvq2O4RQxMQ
   JjxflXwQ0D4afpALjNyUtDPT1YmuQC+2G9b73OZhBxcripY3molvLVgjQ
   lLCZTw2Kw2gJDBr4ItvQcHJyzbb+FEETNaiNs6TqvVY2Is4lvCtbBDRyh
   qyxpyZwBrFN8/gExmT704PtLrEzigu/2bqLFA//Bv2F4j+YxyqrJgYXjC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="330725611"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="330725611"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 10:52:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="759472538"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="759472538"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Feb 2023 10:52:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 769481A6; Fri, 17 Feb 2023 20:53:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regmap-irq: Place kernel doc of struct regmap_irq_chip in order
Date:   Fri, 17 Feb 2023 20:53:26 +0200
Message-Id: <20230217185326.23490-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/regmap.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f26432dc02ef..853d98e0c74d 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1554,6 +1554,7 @@ struct regmap_irq_chip_data;
  * @use_ack:     Use @ack register even if it is zero.
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
+ * @status_invert: Inverted status register: cleared bits are active interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_invert: Invert the type flags. Deprecated, use config registers
  *		 instead.
@@ -1565,18 +1566,19 @@ struct regmap_irq_chip_data;
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
@@ -1584,6 +1586,7 @@ struct regmap_irq_chip_data;
  *		     instead.
  * @num_config_bases:	Number of config base registers.
  * @num_config_regs:	Number of config registers for each config base register.
+ *
  * @handle_pre_irq:  Driver specific callback to handle interrupt from device
  *		     before regmap_irq_handler process the interrupts.
  * @handle_post_irq: Driver specific callback to handle interrupt from device
@@ -1631,13 +1634,13 @@ struct regmap_irq_chip {
 	unsigned int use_ack:1;
 	unsigned int ack_invert:1;
 	unsigned int clear_ack:1;
+	unsigned int status_invert:1;
 	unsigned int wake_invert:1;
-	unsigned int runtime_pm:1;
 	unsigned int type_invert:1;
 	unsigned int type_in_mask:1;
 	unsigned int clear_on_unmask:1;
+	unsigned int runtime_pm:1;
 	unsigned int not_fixed_stride:1;
-	unsigned int status_invert:1;
 
 	int num_regs;
 
-- 
2.39.1

