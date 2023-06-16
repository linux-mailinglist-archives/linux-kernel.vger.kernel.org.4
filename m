Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86B5732AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbjFPJCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343955AbjFPJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:01:21 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770FA359B;
        Fri, 16 Jun 2023 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686906077; x=1718442077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2WAo5QZvbfYixUoqu6KVie30gcKIvMWKb1DXqy43ri8=;
  b=OzmPb6LpYHlx0S3m4WaY0HmIhDS/QsM/gk2nU2PYcrQauY5Uj9/QONBH
   amkKxff8VzJsraENnEi140JF1gMNnn+GaVwb85oPzI9uWkHA6eUOQF3QQ
   AQ91TSD6OIEjYJC6GhK7U8Z866bcMrtVixOObLGiwS8alwko9T9mFIHPi
   cA19Po3gTMw1SwrqzlB6liAUQcywoSEdNHLd9BDb9LVDwo/UdAGV2/U4e
   c8kx1sv/XDSUVhO9vjpodQBrata7e4wnlnY2B2COwg45mkQ/WM1goHb3n
   6q7utLPTHJgj+mlOOwRxii7cJ3QgyH8G0OUhgm+DLk4Cd21PfC9in/pu+
   A==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="31462055"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Jun 2023 11:01:15 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 79C12280082;
        Fri, 16 Jun 2023 11:01:15 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 0/5] gpio: aggregator: Incorporate gpio-delay functionality
Date:   Fri, 16 Jun 2023 11:01:17 +0200
Message-ID: <4392854.e9J7NaK4W3@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
References: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am Donnerstag, 15. Juni 2023, 15:20:18 CEST schrieb Andy Shevchenko:
> The newly appeared gpio-delay module enables external signal delay lines
> that may be connected to the GPIOs. But at the same time it copies the
> GPIO forwarder functionality. Besides that the approach does not scale.
> If we would have another external component, we would need yet another
> driver. That's why I think, and seems others support me, better to
> enable such a functionality inside GPIO aggregator driver.
>=20
> Patch 1 is a cleanup that may be applied independently on the decision
> about the rest.
>=20
> Please, test and comment! Alexander, I would appreciate your tag.

This works on my platform:
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> In v3:
> - added new patch 3 to prevent device removal from sysfs
> - switched to feature in driver data instead of "compatible" (Geert)
> - applied tags (Geert, Linus)
> - left DT bindings untouched, can be amended later on
>=20
> In v2:
> - split as a series
> - covered CONFIG_OF_GPIO=3Dn case
> - removed the gpio-delay
> - moved gpio-delay Kconfig help to the comment in the code
> - left udelay() call untouched as recommended by documentation
>=20
> Andy Shevchenko (5):
>   gpio: aggregator: Remove CONFIG_OF and of_match_ptr() protections
>   gpio: aggregator: Support delay for setting up individual GPIOs
>   gpio: aggregator: Prevent collisions between DT and user device IDs
>   gpio: aggregator: Set up a parser of delay line parameters
>   gpio: delay: Remove duplicative functionality
>=20
>  drivers/gpio/Kconfig           |   9 --
>  drivers/gpio/Makefile          |   1 -
>  drivers/gpio/gpio-aggregator.c | 113 +++++++++++++++++++++--
>  drivers/gpio/gpio-delay.c      | 164 ---------------------------------
>  4 files changed, 106 insertions(+), 181 deletions(-)
>  delete mode 100644 drivers/gpio/gpio-delay.c


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


