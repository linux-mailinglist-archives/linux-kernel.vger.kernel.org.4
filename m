Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFCA63DA01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiK3PzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiK3PzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:55:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6DC2AC4B;
        Wed, 30 Nov 2022 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669823702; x=1701359702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W3W8UQp+uTMVzTm3Ojr0JjiDtmOtEXslOxckk+D0c1g=;
  b=mPm+VoFj7iYbvN/TThkolFhFYFGzZvdsylpDxejo7Re6VC/yXHUhAaHE
   uqyZoUPh2GzptJ1KJnYsR2whRrm2KHwYFWaQ2ZWi+KyziTptg9X0dQ6LY
   JqUtzDHjQfJaE5rcZTX/CYA6uWb4gPoqPXq5w2V07lIOwXyFmptJqC566
   2bp5nIKYlUM6F5sRbnz4DAhFTzEKbA7kMx7jt6JoFtuLQkwgZtBfKDZnN
   7TP4osZNhVQ6WkXO5gP9yGXQMO1HSP7J2BeW8Z6x6x3L98jVs8+XD+TeN
   UONmg4k9V6bVHhKiZ/xJNNKApGQir5yIIXjYQtOR6ypBIZjzav9KWH94M
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295126527"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="295126527"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 07:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707693498"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="707693498"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 07:54:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E65CA10E; Wed, 30 Nov 2022 17:55:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 1/3] Documentation: gpio: Input mode is not true Hi-Z
Date:   Wed, 30 Nov 2022 17:55:17 +0200
Message-Id: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The true Hi-Z (a.k.a. high impedance) mode is when pin is completely
disconnected from the chip. This includes input buffer as well.
Nevertheless, some hardware may not support that mode and they are
considering input only as Hi-Z, but more precisely it is an equivalent
to that, in electronics it's basically "an antenna mode".

Sligthly correct documentation to take the above into consideration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/driver.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 6baaeab79534..bf6319cc531b 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -218,10 +218,10 @@ not support open drain/open source in hardware, the GPIO library will instead
 use a trick: when a line is set as output, if the line is flagged as open
 drain, and the IN output value is low, it will be driven low as usual. But
 if the IN output value is set to high, it will instead *NOT* be driven high,
-instead it will be switched to input, as input mode is high impedance, thus
-achieving an "open drain emulation" of sorts: electrically the behaviour will
-be identical, with the exception of possible hardware glitches when switching
-the mode of the line.
+instead it will be switched to input, as input mode is an equivalent to
+high impedance, thus achieving an "open drain emulation" of sorts: electrically
+the behaviour will be identical, with the exception of possible hardware glitches
+when switching the mode of the line.
 
 For open source configuration the same principle is used, just that instead
 of actively driving the line low, it is set to input.
-- 
2.35.1

