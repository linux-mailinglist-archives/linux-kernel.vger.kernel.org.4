Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1766722BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjFEPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjFEPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:46:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2938810EF;
        Mon,  5 Jun 2023 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685979969; x=1717515969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n04K44TNBgGUbKDi3tPripATee3IQ1jbbgVXYhgm2wU=;
  b=EYWx6XWGBE7aB1Z5OVFOQ3WSFefPbq+vVnzPO9dUkhCIiAq6mJHMlBlm
   l1p0a6RWCeqMqFjEMry9nyBPkj8vFofcpMDyH/UYp89WTMoiLe0QWN2RE
   o5sVJiNn/I2Ez69ErX6ujxSxSrPI3LT5h6/nUj9oLUGkLGyotwULyeXdp
   zkQWPBtvV8IPNnA4Zhri3XLKc7DWTyiR57PJC9uaHbdWnwx7JVh7u5G4R
   /BJWb2pGOjkvk/2aoKUipfyC5cHpVm6MqVg6GvsOI7Q2tSz5jyAyta4SP
   nk1XcBdJjIaRvqvaTo7mZYgmfs3MtJvmw4u/RcV2TP89s64nTTkKp55qG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="384707609"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384707609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="738405455"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="738405455"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2023 08:45:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D07F62A6; Mon,  5 Jun 2023 18:45:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/2] pinctrl: merrifield: Use BUFCFG_PINMODE_GPIO in ->pin_dbg_show()
Date:   Mon,  5 Jun 2023 18:45:09 +0300
Message-Id: <20230605154509.11616-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230605154509.11616-1-andriy.shevchenko@linux.intel.com>
References: <20230605154509.11616-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use explicit comparison to BUFCFG_PINMODE_GPIO instead of implying it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-merrifield.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-merrifield.c b/drivers/pinctrl/intel/pinctrl-merrifield.c
index f1d0b7576703..fb6de38b1c50 100644
--- a/drivers/pinctrl/intel/pinctrl-merrifield.c
+++ b/drivers/pinctrl/intel/pinctrl-merrifield.c
@@ -549,7 +549,7 @@ static void mrfld_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	}
 
 	mode = (value & BUFCFG_PINMODE_MASK) >> BUFCFG_PINMODE_SHIFT;
-	if (!mode)
+	if (mode == BUFCFG_PINMODE_GPIO)
 		seq_puts(s, "GPIO ");
 	else
 		seq_printf(s, "mode %d ", mode);
-- 
2.40.0.1.gaa8946217a0b

