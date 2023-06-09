Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72290729356
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjFIIfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbjFIIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:35:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBD2737;
        Fri,  9 Jun 2023 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299710; x=1717835710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/pE+3hHV6AqoKO5etBgX4H2a1idh1vvlqcKd7R4NC+g=;
  b=GrxiExiS44Q46/Mgq9ATZDaWjeznn0bZQdkXDJD4F88Dim4CeA3HXy46
   g7k/joy1erupCevtqBm90qM/si+U9BeRIgInV2H9QJ6GZhE5TIwfNbGYI
   sRKkVs2HNa6I2ga+CpOkgpG4qG0Fsu+9/+FI5Uw8yNZ+G1YAli9oCjZIR
   RlT49A1vd6uD2/ZmhH4QXKgjKe0+Uj2tBQGXWrjGjgCjp0ULKAy7VhRIs
   4YilMtMQVuJy0yCsb/Od7vyX/rQy4wvZrJN8P4soZ2g/m1P9VnJWgdTLU
   I+7bo0I3EeScGpt1vYGTrJ+grX/63SAWVxLGEComdPov+A8FgdlNkBjMz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355041493"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="355041493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="660690483"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="660690483"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 01:35:07 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id AFADD911E9;
        Fri,  9 Jun 2023 14:05:06 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id A9217163; Fri,  9 Jun 2023 14:05:06 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/2] pinctrl: cherryview: simplify exit path of set_mux hook
Date:   Fri,  9 Jun 2023 14:03:55 +0530
Message-Id: <20230609083356.24849-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230609083356.24849-1-raag.jadav@intel.com>
References: <20230609083356.24849-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify exit path of ->set_mux() hook and save a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-34 (-34)
Function                                     old     new   delta
chv_pinmux_set_mux                           640     606     -34
Total: Before=19233, After=19199, chg -0.18%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index b9b2b1d2d47f..4942d22cf9d9 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -716,7 +716,7 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	struct device *dev = pctrl->dev;
 	const struct intel_pingroup *grp;
 	unsigned long flags;
-	int i;
+	int i, ret = 0;
 
 	grp = &pctrl->soc->groups[group];
 
@@ -725,9 +725,9 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	/* Check first that the pad is not locked */
 	for (i = 0; i < grp->grp.npins; i++) {
 		if (chv_pad_locked(pctrl, grp->grp.pins[i])) {
-			raw_spin_unlock_irqrestore(&chv_lock, flags);
 			dev_warn(dev, "unable to set mode for locked pin %u\n", grp->grp.pins[i]);
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out_unlock;
 		}
 	}
 
@@ -765,9 +765,10 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			invert_oe ? "" : "not ");
 	}
 
+out_unlock:
 	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static void chv_gpio_clear_triggering(struct intel_pinctrl *pctrl,
-- 
2.17.1

