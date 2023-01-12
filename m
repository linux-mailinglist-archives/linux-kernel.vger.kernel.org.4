Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B295F667EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjALTIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbjALTGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:06:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEE265A7;
        Thu, 12 Jan 2023 10:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673549337; x=1705085337;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9ZqpR6hozABIVRF8f5BclL/5aXMMC3qUWYKR8P4jke0=;
  b=dFyr17eVhAHEMTovZiRdnosj6a7QP34deyTCofi3unlkLICa6IQLA4b3
   PdgBUT9y42CFa48prP64zhVq2HWqkHRHY6VI/lJWZUMgDradJPfTleNcg
   ursWJau7oTsI8eIai0tLd+F0AAldtfVcnhpy09CMThTAPsn3VGZaQfwI4
   pXX2PMy3Vwo/CUyd5SRSBnVSu/arfNdP5CgiVdcLuVzhjgRH8tWOnzDQ0
   f9zi0HMe4e4jKQzhqFPFABMeGercZy5sCDUH8vZ2lVlkfIEVxLTMnwPjQ
   wyqz54s/hjxZ3DXziOu6j1CJLIuwsNZhdn4YYCmgmnhSlToRt69w6NhCh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="323853959"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="323853959"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="726429625"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="726429625"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2023 10:48:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 012BA14B; Thu, 12 Jan 2023 20:49:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Remove duplicate assignment of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 20:49:23 +0200
Message-Id: <20230112184923.80442-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

The of_gpio_n_cells default is 2 when ->of_xlate() callback is
not defined. No need to assign it explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 3dc670faa59e..87920257bb73 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -430,7 +430,6 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 	pctrl->chip.base = -1;
 	pctrl->chip.ngpio = data->npins;
 	pctrl->chip.label = dev_name(dev);
-	pctrl->chip.of_gpio_n_cells = 2;
 	pctrl->chip.can_sleep = false;
 
 	mutex_init(&pctrl->slew_access_lock);
-- 
2.39.0

