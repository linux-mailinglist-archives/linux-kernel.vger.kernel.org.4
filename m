Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071A0621615
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiKHOWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiKHOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:22:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E51C54B13;
        Tue,  8 Nov 2022 06:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667917328; x=1699453328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmvq9J3vKVtopSojPs7YdH4K99jNadewdc2yE8CsvjU=;
  b=HWwT3AIgrd+7IjtOHLu8rOxuFRIE+nHxD9Y/YFfDpslBBK6uMbmIXPKj
   fGOH2Jz4/rwjPweGLDf/DfKDzv5HjE1XyGrNZAZAC91zAw/KP41I6j3mz
   VCmZzK6+ByKmsUinDLrD0wFUDOVfCu3wrcpKuvTpPvgPB3X/kTVPBAuHk
   K98NUMTfceJ+SNapnoW2BoPudAueCDegVcd+6BnTgrDtFRp5JVxj4ZgBa
   mw9PrcBE21vKuFNBoy+psZMjfskc+NxKUgAhp5JQRoPAgrV48bScBDd3n
   /laBS19PBW6tOa6Ou6iJ0K/2JObZ4B+XB/DJPDnazwTnbUBDzdVpZtXjj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="298219282"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298219282"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699938291"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="699938291"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2022 06:22:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6B189155; Tue,  8 Nov 2022 16:22:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/6] pwm: Add a stub for devm_pwmchip_add()
Date:   Tue,  8 Nov 2022 16:22:21 +0200
Message-Id: <20221108142226.63161-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
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

devm_pwmchip_add() can be called by a module that optionally
instantiates PWM chip. In case of CONFIG_PWM=n, the compilation
can't be performed. Hence, add a necessary stub.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/pwm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d70c6e5a839d..bba492eea96c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -478,6 +478,11 @@ static inline int pwmchip_remove(struct pwm_chip *chip)
 	return -EINVAL;
 }
 
+static inline int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
+{
+	return -EINVAL;
+}
+
 static inline struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 						       unsigned int index,
 						       const char *label)
-- 
2.35.1

