Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A2697DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBONmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBONmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:42:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D05E7D88;
        Wed, 15 Feb 2023 05:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676468529; x=1708004529;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LpZ2pavJbYJwjqbuOZHktfU8NRSQTEvgzcvODOSIzQY=;
  b=d6GaRV2aj4+RuMh7SGzuBWJGMD1IfSkv+PTwWc/4EKXcUA1N6DYNUXQb
   OZW5XCzFKdsf9IxL0vCVMNHRUThmTP/oZ3ox15bMofGox4OryzBAMeg8l
   U9UiEbvb5KavFjn4W/s9hiousWVQcEf//wb6uoOivzEdMefnWP2b3FUqI
   5nENNKeYYStYvPHHrCm/Aj3nZgc/JXmIbzM6R6UmLx9H5YVxWWLuCx7HB
   N/+BbgOjy5vfSERtJH2VgI2cmrEnIV+Pdqv8Q/y2WuoxHAmicG6k/ZWfy
   2O3nPF9v5ZETJcmddmswK/BMUMIKkuYQYjL782J6EIwz/KzKqpD3vQX3W
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358849421"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="358849421"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793502739"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="793502739"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2023 05:42:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 405611A6; Wed, 15 Feb 2023 15:42:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/5] pinctrl: at91: Cleanups
Date:   Wed, 15 Feb 2023 15:42:37 +0200
Message-Id: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
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

Changes in v3:
- added tags (Claudiu)
- dropped unrelated curly bracket change (Claudiu)

Changes in v2:
- fixed compilation errors (LKP)

Andy Shevchenko (5):
  pinctrl: at91: use devm_kasprintf() to avoid potential leaks (part 2)
  pinctrl: at91: Don't mix non-devm calls with devm ones
  pinctrl: at91: Use of_device_get_match_data()
  pinctrl: at91: Use dev_err_probe() instead of custom messaging
  pinctrl: at91: Utilise temporary variable for struct device

 drivers/pinctrl/pinctrl-at91.c | 161 ++++++++++++++-------------------
 1 file changed, 66 insertions(+), 95 deletions(-)

-- 
2.39.1

