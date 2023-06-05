Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD0722BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjFEPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjFEPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:47:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47606E62;
        Mon,  5 Jun 2023 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685980022; x=1717516022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xhhgZY3xg0rFH5890iJyOdraSy01n5OZPHXu7d0onXU=;
  b=JJIBqsoGAf/iRL50/jICX7dqw73LjnniN0WLwkeoRsGyaardJFOkUOgc
   0KTbVg/DToTettZ1+siha5SRob2JMRqW/I6F1J/JlviFAUOU/PmfRSex7
   laXPLntEEyXlrqY2BXXHx4tsduxkaQUg/z653A9QJn/pUc3R2uKDedI5h
   OH/+Vjk4H50C5u2jn+d3YvrkVng8rguFaEhaplaS3U0N8tiI6k0CfF9aa
   W0s901FFfZVAMWqkQqUtdOWF3pR97JquHotX1+d4XOiCeRpXUWsHmybYa
   llWHL/fTIPQBgnL7WDOA/3T2o5lUB2ltQn/VXzIWv6YedAKY9WjX/Z9jl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359713189"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="359713189"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773777198"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="773777198"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 08:45:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 82D662A6; Mon,  5 Jun 2023 18:45:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/2] pinctrl: moorefield: Use BUFCFG_PINMODE_GPIO in ->pin_dbg_show()
Date:   Mon,  5 Jun 2023 18:45:23 +0300
Message-Id: <20230605154523.11799-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230605154523.11799-1-andriy.shevchenko@linux.intel.com>
References: <20230605154523.11799-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use explicit comparison to BUFCFG_PINMODE_GPIO instead of implying it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-moorefield.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-moorefield.c b/drivers/pinctrl/intel/pinctrl-moorefield.c
index 7656a5e20919..2d38d953f360 100644
--- a/drivers/pinctrl/intel/pinctrl-moorefield.c
+++ b/drivers/pinctrl/intel/pinctrl-moorefield.c
@@ -504,7 +504,7 @@ static void mofld_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	}
 
 	mode = (value & BUFCFG_PINMODE_MASK) >> BUFCFG_PINMODE_SHIFT;
-	if (!mode)
+	if (mode == BUFCFG_PINMODE_GPIO)
 		seq_puts(s, "GPIO ");
 	else
 		seq_printf(s, "mode %d ", mode);
-- 
2.40.0.1.gaa8946217a0b

