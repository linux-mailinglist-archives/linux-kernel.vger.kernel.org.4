Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6E5BB3B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIPUyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIPUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:54:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3AE26AF0;
        Fri, 16 Sep 2022 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663361681; x=1694897681;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T09DtgLjqBDwlgsiEVO57dHA2hCg6DGweO1eZT4MuK0=;
  b=cH4KzjiewxlywuNQUA4CtTy0kibFbIOiN9siVn2Q/ar2NDTxLrW5CZF1
   BTnGT5vEWmxEfrcEkT563jm8Npas/9rAhAVTsX2gVXw2DIMMfsa2HgkqP
   gd6DNeGHGOq1EOLZZcFl/T5bG67kCJ3GgRWdRnf0c5eYAGSxka3bO3PVN
   NA7OFrptHXhpFFj9+k9w+FAGgnJbZp71G1o0KXtwey+nKP2jZsPrchWt1
   fEuQRs1iK2Yn7Cf9l1ZOJLgeUZ+LFuVpUUEW3Ko8ntUyKUf7F6SCBonN+
   K9VDVumlpCB1V8F8bss+ejrDdRq/+PPfZQ1AJuTM8JpmgBP9iBUvAJQkl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299900281"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="299900281"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 13:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="595381224"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2022 13:54:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 26017235; Fri, 16 Sep 2022 23:54:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] pinctrl: cy8c95x0: Lock register accesses in cy8c95x0_set_mux()
Date:   Fri, 16 Sep 2022 23:54:48 +0300
Message-Id: <20220916205450.86278-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that cy8c95x0_set_mux() missed serialization of IO access.
And its implementation looks half-baked. Add locking to the function.

Fixes: e6cbbe42944d ("pinctrl: Add Cypress cy8c95x0 support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 79f73d364f3f..75be06d29dc1 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1152,8 +1152,13 @@ static int cy8c95x0_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
 			    unsigned int group)
 {
 	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
+	int ret;
 
-	return cy8c95x0_pinmux_cfg(chip, selector, group);
+	mutex_lock(&chip->i2c_lock);
+	ret = cy8c95x0_pinmux_cfg(chip, selector, group);
+	mutex_unlock(&chip->i2c_lock);
+
+	return ret;
 }
 
 static const struct pinmux_ops cy8c95x0_pmxops = {
-- 
2.35.1

