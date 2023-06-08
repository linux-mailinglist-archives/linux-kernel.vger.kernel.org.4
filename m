Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653EC727808
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjFHHB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjFHHBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:01:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D92D71;
        Thu,  8 Jun 2023 00:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686207684; x=1717743684;
  h=from:to:cc:subject:date:message-id;
  bh=JpTqFAq/cmib2VeZjTzsz5mnRuKIDVQkY6W9QBQdkQk=;
  b=K7UsvkPDDe+y+l61BHAatbaVuiCEF7OjCNl3xQQiKAvDTBaX7f5flqNN
   MebPGnT3WvQYXuVs3Zu9t1/es0xb8yxHVjiT/VX54ZQM5sFyNoaEiQnLh
   xWEBeJMW9pUv9qAw5OJ10j5We5Yb7vduc0qpHjXsBK8m8bprEBuhEZ4Ry
   e7lwJmTkPdBFrIKlzW277ohVeP7TQ+K7G3p++vCYQzWK/EmNQGEF1yy5/
   4ESboBLnQaTNdi3hXjT7DxRxbTNFdEzGLdXEbwNnVhaRyi9MquuFoNF/s
   ljHt+nmEYwEY2RlsTdDw7xO2e6gI1IR/nh63wp2876PIblCvQUSqKKvb0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="359696348"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="359696348"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 00:01:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709867970"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="709867970"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2023 00:01:07 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 0B8AC1A9F2;
        Thu,  8 Jun 2023 12:31:07 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 04A06176; Thu,  8 Jun 2023 12:31:07 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/4] Minor optimizations for Intel pinctrl
Date:   Thu,  8 Jun 2023 12:30:13 +0530
Message-Id: <20230608070017.28072-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements minor optimizations for Intel pinctrl driver.

The numbers are as tested with gcc 7.5.0 and may vary with newer versions.

Raag Jadav (4):
  pinctrl: intel: optimize set_mux hook
  pinctrl: intel: optimize irq_set_type hook
  pinctrl: intel: simplify exit path of set_mux hook
  pinctrl: intel: simplify exit path of gpio_request_enable hook

 drivers/pinctrl/intel/pinctrl-intel.c | 63 +++++++++++++++------------
 1 file changed, 35 insertions(+), 28 deletions(-)

-- 
2.17.1

