Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59E972DD09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbjFMIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbjFMIvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:51:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A19C9;
        Tue, 13 Jun 2023 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686646292; x=1718182292;
  h=from:to:cc:subject:date:message-id;
  bh=ucZ19n3MS9PrxtzEnvdcPHoRoGd5kctbRrbYoIyxl64=;
  b=iU7X8coogzpa3SqOSqXOm9tBdnlbHr5+3MufpIXgysIql9hzpDTirWsq
   ZxLg7NNDz2aKeSNcC/4vAgZNbadD4yUoQ6BVDkgzbLHh+SHTXbZi/qOIj
   +euq2GnL3EzPPYMenomFS3EfcqQoBG8gwIFXnhJnGYc+A/HUoUiPlUKrP
   LNz/qlgKbWTypLtZKXnjT0YVG4oJcUjMeqwTitzUdKAKHjp8KHLeqvnez
   RpU5QQ1ltQEsSBbaCps9P1RXswD6dAe5bzGUo9E2T0GVEspqN1/ZaBnQk
   Nr+vellZZFS9eemPd3PJNkhQbd9Ke30WyxzPTOlaNbBHaR8e4mnJih5Ok
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386664943"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="386664943"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 01:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824305092"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="824305092"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 01:51:29 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 6A9051973D;
        Tue, 13 Jun 2023 14:21:28 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 6371A104; Tue, 13 Jun 2023 14:21:28 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 0/3] Minor improvements for Intel pinctrl
Date:   Tue, 13 Jun 2023 14:20:51 +0530
Message-Id: <20230613085054.10976-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements minor improvements for Intel pinctrl driver.

The optimizations are as tested with gcc 7.5.0 with default -O2.

Changes since v2:
- Drop redundant patches.
- Update commit message.

Changes since v1:
- Update commit message.
- Specify compiler options used to measure optimizations.
- Drop redundant comments.

Raag Jadav (3):
  pinctrl: intel: refine ->set_mux() hook
  pinctrl: intel: refine ->irq_set_type() hook
  pinctrl: intel: simplify exit path of ->gpio_request_enable() hook

 drivers/pinctrl/intel/pinctrl-intel.c | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

-- 
2.17.1

