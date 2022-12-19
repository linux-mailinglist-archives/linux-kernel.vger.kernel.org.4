Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD38E650B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiLSM1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiLSM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCD2DF7C;
        Mon, 19 Dec 2022 04:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452793; x=1702988793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RakmmzlY6jMPeov+PSuZEvYARu9FFL2L6z23c01ftqU=;
  b=ILwmC99Gm5jMvAzy8MEYKAJ0NCxScMyb74v4khkcNK/lMMDlrJbkGvtF
   CKcH+rwv55fQL6AvKPSIph209KYVAr7kDiq0wOoVwvGp+0NXXh5OBV/nb
   rSHwKlaFgwELtYb6rwHGVOaCoL7gx71vimkK2V0T4bn3YjnH7gMlEqnBx
   FG00PGwakClXa4pgmIf2g0U57rK5Is42mauiq/MpMlx56gqC56jQwu2gc
   aapxsN+HRBx6fWS7nN4uL/qsvIrBYy4Tq4SjODr/laBs/Z80KryZzxxXV
   DOwZj2mM4VeHP11eLq7Yf4Bf/gR+09yD9Eebe2k+lKsaHCjsz3DLzDrqi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="302762263"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="302762263"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="824831639"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="824831639"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2022 04:26:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 440F0735; Mon, 19 Dec 2022 14:26:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 17/17] pinctrl: intel: Always use gpp_num_padown_regs in the main driver
Date:   Mon, 19 Dec 2022 14:26:43 +0200
Message-Id: <20221219122643.3513-17-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the size-based communities, always use gpp_num_padown_regs,
which is now provided explicitly via INTEL_COMMUNITY_SIZE() macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c |  9 +--------
 drivers/pinctrl/intel/pinctrl-intel.h | 13 +++++++------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index cc3aaba24188..4029891ba628 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1451,14 +1451,7 @@ static int intel_pinctrl_add_padgroups_by_size(struct intel_pinctrl *pctrl,
 		gpps[i].gpio_base = gpps[i].base;
 		gpps[i].padown_num = padown_num;
 
-		/*
-		 * In older hardware the number of padown registers per
-		 * group is fixed regardless of the group size.
-		 */
-		if (community->gpp_num_padown_regs)
-			padown_num += community->gpp_num_padown_regs;
-		else
-			padown_num += DIV_ROUND_UP(gpps[i].size * 4, 32);
+		padown_num += community->gpp_num_padown_regs;
 	}
 
 	community->ngpps = ngpps;
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index b0f2be4c1fd1..981c1f520f13 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -96,8 +96,7 @@ enum {
  * @gpp_size: Maximum number of pads in each group, such as PADCFGLOCK,
  *            HOSTSW_OWN, GPI_IS, GPI_IE. Used when @gpps is %NULL.
  * @gpp_num_padown_regs: Number of pad registers each pad group consumes at
- *			 minimum. Use %0 if the number of registers can be
- *			 determined by the size of the group.
+ *			 minimum. Used when @gpps is %NULL.
  * @gpps: Pad groups if the controller has variable size pad groups
  * @ngpps: Number of pad groups in this community
  * @pad_map: Optional non-linear mapping of the pads
@@ -106,11 +105,13 @@ enum {
  * @regs: Community specific common registers (reserved for core driver)
  * @pad_regs: Community specific pad registers (reserved for core driver)
  *
- * In some of Intel GPIO host controllers this driver supports each pad group
+ * In older Intel GPIO host controllers, this driver supports, each pad group
  * is of equal size (except the last one). In that case the driver can just
- * fill in @gpp_size field and let the core driver to handle the rest. If
- * the controller has pad groups of variable size the client driver can
- * pass custom @gpps and @ngpps instead.
+ * fill in @gpp_size and @gpp_num_padown_regs fields and let the core driver
+ * to handle the rest.
+ *
+ * In newer Intel GPIO host controllers each pad group is of variable size,
+ * so the client driver can pass custom @gpps and @ngpps instead.
  */
 struct intel_community {
 	unsigned int barno;
-- 
2.35.1

