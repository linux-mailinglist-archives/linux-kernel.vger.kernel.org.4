Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC684650BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiLSMdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiLSMck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:32:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D273F58A;
        Mon, 19 Dec 2022 04:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453125; x=1702989125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ata/4PTa5Uu7NYxPIvrTUdKVybjbAKys8AJYQMscqA=;
  b=nz0fUSjJLf2oEpJJu4afuwa4VbuNqrKl69iJA9t1GwIsPQmGDSwGyZFd
   pu+YQunbn+HxfUsqo3RfplIwtCCaUe0AtmajGAPVMnxzfXM/4KzYWd3SU
   uN77E1EqMw/PS3GHEtC6NcvU5miaEezCZKmCWWLo92A6u2XajtRgjly72
   Z90pbRjPzC8pQ0owdt4uA8ktKqa2oM6UdmkakZH4rrgfsX50xOrelj6+8
   eDxiL8lSJzS5sYEyCfAsE+/ztR0eCGzmDV9GG8xeu7Ljv/aNyEsF/tv88
   yT0y4OP1gm8/0qVhBlZpk0L3GAF7EJS/JR9k30+W6YBh0wYrrKD84lSFO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="299670701"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299670701"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:32:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="896027958"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="896027958"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Dec 2022 04:32:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CB268F7; Mon, 19 Dec 2022 14:32:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: intel: Use same order of bit fields for PADCFG2
Date:   Mon, 19 Dec 2022 14:32:29 +0200
Message-Id: <20221219123229.5564-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

PADCFG0 and PADCFG1 are ordered from MSB to LSB, do the same
for PADCFG2 bit fields.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 5e21b0a96efe..9d2791a81ffa 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -88,9 +88,9 @@
 #define PADCFG1_TERM_800		(BIT(2) | BIT(1) | BIT(0))
 
 #define PADCFG2				0x008
-#define PADCFG2_DEBEN			BIT(0)
 #define PADCFG2_DEBOUNCE_SHIFT		1
 #define PADCFG2_DEBOUNCE_MASK		GENMASK(4, 1)
+#define PADCFG2_DEBEN			BIT(0)
 
 #define DEBOUNCE_PERIOD_NSEC		31250
 
-- 
2.35.1

