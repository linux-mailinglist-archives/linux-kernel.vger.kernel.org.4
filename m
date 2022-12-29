Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E490C658CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiL2M7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiL2M7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:59:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072113DC3;
        Thu, 29 Dec 2022 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672318773; x=1703854773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ecyaM796ewTXPb5Y7iWRp/152r6U7JCXSRKl2+pMC2s=;
  b=Cvj4hLWwvQSGiH8oaIDteGcOKMYI6qFq/aQGs2x6K1p+8OyKjw4CyfLx
   7UrXaw3qp+2iSpjZ3Si9VLXVipIzG18q9lLZC82XvHWzuzQa5BiJacoPz
   VWV9Df6ownFWwLpc8x/8aF4pmGMFodgAfjsWb4vPu1dkpWcrEPxNagxeX
   X91EH6wltubvE6nL7JLnsDQEE/vrU4QifI4eI1GkqlsdkjPLhKQxEGpyj
   t2rnX8H/Jab9nUH960RMn3jiHCRUpc4sS8dT9OjollxmPi/Q1CipWed+f
   VynTwnEcCNfkx5KDeRXsHgDXKYPJ26UMABZxb1X26TTxBuOi3Q3OrgHO7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="348247457"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="348247457"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="777691258"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="777691258"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 04:59:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 43824159; Thu, 29 Dec 2022 15:00:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 0/3] pinctrl: intel: Provide NOIRQ PM helper and use it
Date:   Thu, 29 Dec 2022 14:59:54 +0200
Message-Id: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel pin control drivers use NOIRQ variant of PM callbacks.
Besides that several other drivers do similar. Provide a helper
to make them smaller.

Andy Shevchenko (3):
  pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
  pinctrl: intel: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
  pinctrl: cherryview: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper

 drivers/pinctrl/intel/pinctrl-cherryview.c | 4 +---
 drivers/pinctrl/intel/pinctrl-intel.h      | 6 ++----
 include/linux/pm.h                         | 5 +++++
 3 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.35.1

