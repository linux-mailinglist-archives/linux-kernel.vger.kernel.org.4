Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3206ACC9B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCFSaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCFSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:30:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDB126AF;
        Mon,  6 Mar 2023 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127439; x=1709663439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U8MEIvj+kGc2O4EMH1nkEahOSHrfAnYigBd8xzJ855c=;
  b=RkJdzGNVyPI6CH+eOhVxQe7gZU8iY5uOPTANYp+HF7dG2/o2nVi1tomU
   ZSsT+0smBKqZRbEZ1RlXQC9WzEnydY6C1P6+clKB4Ji637QsoJSVqhj6i
   lLDA19JzcHd7vXVlb2LH+zFbPrPfytRSOOLoNBAQ+GLVYMZ1vb7no3zvM
   oewgESyb5CJOne2YYG1FA3GMPbn5H4qg8gOYDZLFvVrR6vgmR3I4d60TG
   EWVtpliRsgmRogy5OI9hCGAM+M5zATsx/XdDpaZ0l8OhG3PUK61+LIg6V
   jVw7NUJpLYOL/aE+6ukDJSkHn/K79zRuW/cDFxU/i1toRqL5WKID2zi4j
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363257689"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363257689"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="786348694"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="786348694"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2023 10:30:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 454CA143; Mon,  6 Mar 2023 20:31:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/5] spi: mpc5xxx-psc: Clean up even more and fix
Date:   Mon,  6 Mar 2023 20:31:10 +0200
Message-Id: <20230306183115.87314-1-andriy.shevchenko@linux.intel.com>
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

The recent cleanup series broke the error path in the drivers.
So fix it and do even more cleanups.

Andy Shevchenko (5):
  spi: mpc5xxx-psc: Correct error check for
    devm_platform_get_and_ioremap_resource()
  spi: mpc5xxx-psc: Return immediately if IRQ resource is unavailable
  spi: mpc5xxx-psc: use devm_clk_get_enabled() for core clock
  spi: mpc5xxx-psc: Propagate firmware node
  spi: mpc5xxx-psc: Consistently use device property APIs

 drivers/spi/spi-mpc512x-psc.c | 50 +++++++++--------------------------
 drivers/spi/spi-mpc52xx-psc.c | 15 +++++++----
 2 files changed, 22 insertions(+), 43 deletions(-)

-- 
2.39.1

