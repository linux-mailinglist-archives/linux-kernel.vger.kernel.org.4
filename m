Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9F73A852
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFVSgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFVSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:36:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F52105
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687458973; x=1718994973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yWLvnl8GBxtfpixtJGOFm07hcrmmJHs+aRhEjmyx6TY=;
  b=FTs7I5ddUTx6kuua4bSkzQcd98tvORUuZEcJcm41DnDOvvaDi3QAs4Yd
   V2KwwRd+wFKVZwAVAOr0Yd0tFnri1JdgqNGfHl/1+PE3ga/t+ExxQuC1L
   xohSsbpaEdcReEsNbbSqBUL573rSTlm8t9KGjZO0BnoYvsyGY6CQRLdXQ
   xMW0jPEdx/wUeldgEGIrHlqB+mK6wH8EVAeRYEXD1O6b9UGwmnmJSaVI3
   O16a5ig+IU2xaDxJmzU7TNgavkfHSyJw7Ni/MMP1ZiyBsoskUqPZZOuYd
   3hRuVK6Mm/6GVK9/Tb7mUwzQpgGnybOQdhMClI1ASffWLqnH9IYibtqRi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350336491"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="350336491"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:36:10 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="749444245"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="749444245"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 11:36:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 560C724F; Thu, 22 Jun 2023 21:36:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 0/3] regmap: Drop never (properly) worked 64-bit support
Date:   Thu, 22 Jun 2023 21:36:10 +0300
Message-Id: <20230622183613.58762-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap API internally operates on unsigned int values for the register
offsets and data. The commit back in 2015 that introduces 64-bit
excerpts in the code made a false impression that it works. Not really.

Consider two things:
 1/ register offset
 2/ data

For the first one is very rarely we need (except probably an MMIO case)
it. Even though, it won't work due to 32-bit limitations of the base offset.
Considering, let's say, 4 bytes stride the current implementation may
cover 36-bit of address space _only_. And 37-bit for the 8 bytes stride.

For the second one it's obviously that we want _all_ bits to be covered
in the data (otherwise what's the point?) and unsigned int gives us
only 32-bits.

With all this, revert all 64-bit excerpts from regmap API to avoid
false impressions and new code that never works.

Note, there are no users with such sizes in the kernel.

Andy Shevchenko (3):
  regmap: Revert "add 64-bit mode support" and Co.
  regmap: cache: Revert "Add 64-bit mode support"
  regmap: mmio: Remove unused 64-bit support code

 drivers/base/regmap/regcache.c    |  15 ----
 drivers/base/regmap/regmap-mmio.c |  24 ------
 drivers/base/regmap/regmap.c      | 122 ------------------------------
 3 files changed, 161 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

