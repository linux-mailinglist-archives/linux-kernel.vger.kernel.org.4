Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58B8692136
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjBJO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjBJO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:56:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F946C7E4;
        Fri, 10 Feb 2023 06:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676040982; x=1707576982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AThVWBNveoz/JpJx8JnUOLPccE8eXG1Vr5Mj2Xb9+bA=;
  b=D19G9W1o7ILSl3LxrbjYRtPHeHn6OFuuvFHnule3i1+7hS7TzaK65/7/
   GAWz81Xr6IE0rS95lGVy8PM2Mczbvq55Qm4cN9NOhLC9NUrqreqJB0leR
   Drjj3djjcAF1aHRMs8HlxIXaMqbxtuyiYWlgJETMIBHzWNhElyoqJcusR
   jgoXPbmJNAWcveseh+GeX9UYxF84rQUpFD3SvI+ADnMLQI1PrcnabTmOl
   +2LZPDZI88rdv0Ydh6V1EMtKqGNzdCDnrIQ1efJIxpTOIoXZMkGciL6WT
   46PAI7OzLWMfSRrg4cd61rkbBJMGkUmzxBNGNt/povTIom89ZZU6HGyMY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="357836321"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="357836321"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 06:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="668079983"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="668079983"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2023 06:56:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D34B81C5; Fri, 10 Feb 2023 16:56:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/5] pinctrl: at91: Cleanups
Date:   Fri, 10 Feb 2023 16:56:51 +0200
Message-Id: <20230210145656.71838-1-andriy.shevchenko@linux.intel.com>
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

(for now not even compile tested)

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

