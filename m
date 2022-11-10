Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E2624D49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiKJVrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKJVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:47:33 -0500
Received: from box.opentheblackbox.net (box.opentheblackbox.net [IPv6:2600:3c02::f03c:92ff:fee2:82bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F7945A2C;
        Thu, 10 Nov 2022 13:47:31 -0800 (PST)
Received: from authenticated-user (box.opentheblackbox.net [172.105.151.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.opentheblackbox.net (Postfix) with ESMTPSA id DB1DD3EBA5;
        Thu, 10 Nov 2022 16:47:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pgazz.com; s=mail;
        t=1668116851; bh=sn8BqdoR2X8FcNsynZZXapa7cThUJZkv2dbIQQBL4pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAE9NJeu6YQkQvts3qhVrv2Hkgyoz0ewmyzowsEMBWGoowUMjWONTC0VD0/bPZ9vZ
         RbvelwAmmSkw+vNcvrmDO/J36oOkaXcvIKxOhRJd3cj40ilOsEqZyvA35TxkFUoYrM
         NS66AnexegCyeM6PeZHQ2cirMHIn4+PX7poL5FKMgj1NWbspYxPZm5oK+5gdS1xOVf
         x0TspcVDsIb5b/LWYefEYLI9Is2OFOVGnlvabnin3rNaYztD1uV2GqNl0juGa1GzQ7
         HRpQO9V0YkKzy9DqfGujQgwfZDATs7u5B/aO2j909rhqFW49kqE9rZhFhWQHLgkkm+
         1CNW2qIWxA3Jw==
Date:   Thu, 10 Nov 2022 16:47:29 -0500
From:   Paul Gazzillo <paul@pgazz.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1]: iio: light: rpr0521: add missing Kconfig dependencies
Message-ID: <20221110214729.ls5ixav5kxpeftk7@device>
References: <20221110144448.wexu6neb67krqhla@device>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110144448.wexu6neb67krqhla@device>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an implicit declaration of function error for rpr0521 under some configs

When CONFIG_RPR0521 is enabled without CONFIG_IIO_TRIGGERED_BUFFER,
the build results in "implicit declaration of function" errors, e.g.,
  drivers/iio/light/rpr0521.c:434:3: error: implicit declaration of function
           'iio_trigger_poll_chained' [-Werror=implicit-function-declaration]
    434 |   iio_trigger_poll_chained(data->drdy_trigger0);
        |   ^~~~~~~~~~~~~~~~~~~~~~~~

This fix adds select dependencies to RPR0521's configuration declaration.

Signed-off-by: Paul Gazzillo <paul@pgazz.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216678
---
V1 -> V2: Cleaned up commit message per reviewer comments and added link
          to bug report.

 drivers/iio/light/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 7cf6e8490123..0d4447df7200 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -293,6 +293,8 @@ config RPR0521
 	tristate "ROHM RPR0521 ALS and proximity sensor driver"
 	depends on I2C
 	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here if you want to build support for ROHM's RPR0521
 	  ambient light and proximity sensor device.
-- 
2.25.1
