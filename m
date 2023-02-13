Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F949694B87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjBMPpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBMPo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:44:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E4193ED;
        Mon, 13 Feb 2023 07:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676303098; x=1707839098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xlBf3u2jIImE6JHKLtR/28/lGgiDloE+1ryfEFZJMy0=;
  b=bJ0a39FmTWi6vMrRwXso1Ix2IoUOj6ddqF1gDCjKp3vQ+Aw3lduE/GiR
   MiaxMsNV2yndYqEcvpH3qbDV4j2GTUrFi9B3qv2cJV1KIzJ1V2Rx5bH+A
   rLC/sT3WJkWILaV+iY0rfSChl+5OjuzFqu//8d+VwrUdJBLnnA0nPQqFP
   pGWuV1wJgcg5DnjTT2ILDtH1+NCF1QA2/RmJOWrbYYqJ3U2mRBh7RDa+W
   6Z6wjkODv7WcCNCVVieU3Jkzxn8HSABtZcZRXhYqOBuFOfFLnekLJRz66
   5h1OuZDum2YPD3mPMDZ4jgLcOPmCGkfzDyokR2T5FIZeoFT8S50pMDDy1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="318938337"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="318938337"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:44:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="618682262"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="618682262"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 07:44:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0D42E1A6; Mon, 13 Feb 2023 17:45:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] pinctrl: at91: Cleanups
Date:   Mon, 13 Feb 2023 17:45:27 +0200
Message-Id: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

The kasprintf() patch makes me look into the driver code and besides
missed fix, there is a room to improve. Hence this series.

Compile tested only.

Changes in v2:
- fixed compilation errors (LKP)

Andy Shevchenko (5):
  pinctrl: at91: use devm_kasprintf() to avoid potential leaks (part 2)
  pinctrl: at91: Don't mix non-devm calls with devm ones
  pinctrl: at91: Use of_device_get_match_data()
  pinctrl: at91: Use dev_err_probe() instead of custom messaging
  pinctrl: at91: Utilise temporary variable for struct device

 drivers/pinctrl/pinctrl-at91.c | 164 ++++++++++++++-------------------
 1 file changed, 67 insertions(+), 97 deletions(-)

-- 
2.39.1

