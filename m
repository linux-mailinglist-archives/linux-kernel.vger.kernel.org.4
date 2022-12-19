Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19263650B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiLSM1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiLSM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:58 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1636DFD6;
        Mon, 19 Dec 2022 04:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452817; x=1702988817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SYtkw/hm1hSKB4vnlGtuHusIzAgneRrEzLZaacIs33Y=;
  b=iYfpR9pJBQ1dLOxi55T9PoYVRzA3kiN7pWlJ9TMW4R6A2YytMsxTX/d7
   nAq4GodGUYRNuCsVEEQftN9MrnhUaAd5EyAvzIclFUK94UH3BZ6xoZfmy
   hbVEByFt5t+t7hLl40E3fsPi5vZz16/LCpCEFUmqP/7SmKz32MqbxMGBb
   rk8kcLHdJ6/z9r1D5P4bowftOgf4uGmCn1GbDeuKDn8Gb9zoXEhDk3CSN
   IZVHPTQuu78liinWkYQydVulHCYA4zS9gn8jExshQlolKDExNuCFV/3cs
   ui2NFe5r4YQdEnq4J3Wb+KYT8ASLJAHPsqfAi9ScIFv5APCPjJkTY1FZM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="318024754"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="318024754"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="681209042"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="681209042"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2022 04:26:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5AAF0F7; Mon, 19 Dec 2022 14:27:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: intel: Convert to generic_handle_domain_irq()
Date:   Mon, 19 Dec 2022 14:27:22 +0200
Message-Id: <20221219122722.3639-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Replace construct that matches generic_handle_irq(irq_find_mapping())
to a single call to generic_handle_domain_irq().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 4029891ba628..8181a65fb815 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1215,13 +1215,8 @@ static int intel_gpio_community_irq_handler(struct intel_pinctrl *pctrl,
 		/* Only interrupts that are enabled */
 		pending &= enabled;
 
-		for_each_set_bit(gpp_offset, &pending, padgrp->size) {
-			unsigned int irq;
-
-			irq = irq_find_mapping(gc->irq.domain,
-					       padgrp->gpio_base + gpp_offset);
-			generic_handle_irq(irq);
-		}
+		for_each_set_bit(gpp_offset, &pending, padgrp->size)
+			generic_handle_domain_irq(gc->irq.domain, padgrp->gpio_base + gpp_offset);
 
 		ret += pending ? 1 : 0;
 	}
-- 
2.35.1

