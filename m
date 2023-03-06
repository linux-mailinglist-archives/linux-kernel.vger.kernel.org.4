Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9A6ACE8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjCFTzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77A64A93;
        Mon,  6 Mar 2023 11:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132536; x=1709668536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x77bSH20Ou4EihSoiJQDgs4+5OFy75brI2gUDSEqixA=;
  b=cMryF/q2DkCkGdjn36ecf/XF5C/Kdn/qJO3rQFe5iTgajiG6nR5bLnlJ
   pgA5t5nWmhjnQLHfBGmau/ZeYXdMrQKxh491XwFjlKqzfyb/BU+o/PCDv
   oUQ2B8N22aJh0yF4wWDoSWG4hSRZkjtHARIMv4blbIjTCRbTmhEm8rdix
   adiWN0u4mfDQzWas5FerAK/fBnGfBMSVkSUKRbF82hp+Z57y8Cm4HUSFz
   teN6rr9gStnG8Pjv4NDmditY057hyrt0+VwRgz7iyLpZPZgK+9ijInGvS
   ckR7VRvvq54Kko+G78+LQuK8iKq+CRgYuuayM3VBBSbqcqAg2WzIlQzqI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400483892"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="400483892"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="1005549562"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="1005549562"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2023 11:55:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6B292398; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
Subject: [PATCH v1 04/16] lib/string_choices: Add str_input_output() helper
Date:   Mon,  6 Mar 2023 21:55:44 +0200
Message-Id: <20230306195556.55475-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add str_input_output() helper to return 'input' or 'output' string literal.
Also add an inversed variant, i.e. str_output_input().

All the same for str_in_out().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_choices.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 48120222b9b2..ad345df325ec 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -26,6 +26,18 @@ static inline const char *str_high_low(bool v)
 }
 #define str_low_high(v)		str_high_low(!(v))
 
+static inline const char *str_in_out(bool v)
+{
+	return v ? "in" : "out";
+}
+#define str_out_in(v)		str_in_out(!(v))
+
+static inline const char *str_input_output(bool v)
+{
+	return v ? "input" : "output";
+}
+#define str_output_input(v)	str_input_output(!(v))
+
 static inline const char *str_read_write(bool v)
 {
 	return v ? "read" : "write";
-- 
2.39.1

