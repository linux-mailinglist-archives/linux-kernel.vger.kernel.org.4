Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A306490F7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 23:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLJWGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 17:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLJWFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 17:05:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0213D24;
        Sat, 10 Dec 2022 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670709939; x=1702245939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nkgtRUpy/gZUYkzHWEcPgSfI8fgT7IazaxmYic/RiEE=;
  b=dPlu4OvgESPDicL/HRR07nzbCj17SybpwfB9WMCv6HFoCbMfEf0bYgVK
   qWBGEvFenvQgaEtIfVyOdEfgLv9tTjA7/FASwgVhOfpOB1kmwPj+uuB5I
   JtWU86djkJsEHvnGL7T/zCtK4K+aTfF4omWTbjhZOgqVT7P4iMfxiOT6G
   QdffMFR1kGCrIyU9QqbVKZofoXfRdTaRX4/CVRXTByPLjoGqOxMZltV3k
   brm3yUeB3N8A0B8VZhrXNFFrHm88VQhp1Crrb1ewtr1eUkZDfWnjga73k
   S9IjkMpOD6mKKGdWUQ1VTzqnq7KSku0DYvIAp9LVEJiqxaoHlrsZlyQzN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="298001327"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="298001327"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 14:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="754448424"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="754448424"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2022 14:05:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47584179; Sun, 11 Dec 2022 00:06:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/4] gpio: pca953x: avoid to use uninitialized value pinctrl
Date:   Sun, 11 Dec 2022 00:05:58 +0200
Message-Id: <20221210220601.77648-1-andriy.shevchenko@linux.intel.com>
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

From: Haibo Chen <haibo.chen@nxp.com>

There is a variable pinctrl declared without initializer. And then
has the case (switch operation chose the default case) to directly
use this uninitialized value, this is not a safe behavior. So here
initialize the pinctrl as 0 to avoid this issue.
This is reported by Coverity.

Fixes: 13c5d4ce8060 ("gpio: pca953x: Add support for PCAL6534")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used default case (Andy)
 drivers/gpio/gpio-pca953x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index a59d61cd44b2..5299e5bb76d6 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -474,6 +474,9 @@ static u8 pcal6534_recalc_addr(struct pca953x_chip *chip, int reg, int off)
 	case PCAL6524_DEBOUNCE:
 		pinctrl = ((reg & PCAL_PINCTRL_MASK) >> 1) + 0x1c;
 		break;
+	default:
+		pinctrl = 0;
+		break;
 	}
 
 	return pinctrl + addr + (off / BANK_SZ);
-- 
2.35.1

