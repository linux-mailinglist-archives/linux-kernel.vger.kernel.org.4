Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8097C733AED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFPUfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjFPUey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:34:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D513A9D;
        Fri, 16 Jun 2023 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686947693; x=1718483693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0Nx2tcrNyouaIATaj8ZYKNJsnZ50pb885XPfiz8v0YY=;
  b=CmIUOiAxtG2HcnFEAZd5AybuBQGxXB75Gwbs2c8jZGTLzwnDSQ5YdyHb
   k7NjCsX5ozLYxJq9d8zM57JdLtVhw9ogpytNFgeXh+qhRLVVn5G1Kji+/
   dHftGGYyHaZrIK5mu4OKpEKd2A/g6EhOabnvLdlugk1HxSKmaFPPzBXiP
   PFE/y35CRbI/0iua0pglmk00Nrqjucys6AVqXzqzUntbVHbwhL/qNjPj6
   CPXofaPZmYGmRWqyUjUxsFIxRAb7nXMHUtJBVVRuVQSpnqGFh09Y1RFWi
   13ijtQJTlqxUfOoE8Dl3qXnMY38hRY7x8Mp9EvzQIgj8BVKWJyki4ASsa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="358181774"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="358181774"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 13:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="802964395"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="802964395"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2023 13:34:50 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 52262911E8;
        Sat, 17 Jun 2023 02:04:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 4C53819B; Sat, 17 Jun 2023 02:04:49 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH for-next v1 1/3] pinctrl: baytrail: reduce scope of spinlock in ->dbg_show() hook
Date:   Sat, 17 Jun 2023 02:03:54 +0530
Message-Id: <20230616203356.27343-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616203356.27343-1-raag.jadav@intel.com>
References: <20230616203356.27343-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce scope of spinlock to IO operations in ->dbg_show() hook
and save a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-12 (-12)
Function                                     old     new   delta
byt_gpio_dbg_show                            890     878     -12
Total: Before=17029, After=17017, chg -0.07%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index d53952f5c87c..54d3c5c26944 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1241,30 +1241,30 @@ static void byt_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 
 	for (i = 0; i < vg->soc->npins; i++) {
 		const struct intel_community *comm;
+		void __iomem *conf_reg, *val_reg;
 		const char *pull_str = NULL;
 		const char *pull = NULL;
-		void __iomem *reg;
 		unsigned long flags;
 		const char *label;
 		unsigned int pin;
 
-		raw_spin_lock_irqsave(&byt_lock, flags);
 		pin = vg->soc->pins[i].number;
-		reg = byt_gpio_reg(vg, pin, BYT_CONF0_REG);
-		if (!reg) {
+
+		conf_reg = byt_gpio_reg(vg, pin, BYT_CONF0_REG);
+		if (!conf_reg) {
 			seq_printf(s, "Pin %i: can't retrieve CONF0\n", pin);
-			raw_spin_unlock_irqrestore(&byt_lock, flags);
 			continue;
 		}
-		conf0 = readl(reg);
 
-		reg = byt_gpio_reg(vg, pin, BYT_VAL_REG);
-		if (!reg) {
+		val_reg = byt_gpio_reg(vg, pin, BYT_VAL_REG);
+		if (!val_reg) {
 			seq_printf(s, "Pin %i: can't retrieve VAL\n", pin);
-			raw_spin_unlock_irqrestore(&byt_lock, flags);
 			continue;
 		}
-		val = readl(reg);
+
+		raw_spin_lock_irqsave(&byt_lock, flags);
+		conf0 = readl(conf_reg);
+		val = readl(val_reg);
 		raw_spin_unlock_irqrestore(&byt_lock, flags);
 
 		comm = byt_get_community(vg, pin);
-- 
2.17.1

