Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604525B6955
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIMIR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiIMIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:17:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFE957E14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:17:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so12857801wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vGVgNjVIquChRYG3qNsuhFrwCzwmt0K1e1bT0honEPI=;
        b=TU7nC+WV/Iqgj8T8V/TWKd4PZw0eiq5Sa3jBgVl4y4E5CAIF5CCWmegZpz8EcNv+18
         U4i6AnT264NkAmyb48ufAfjXVG+uEBaetxgH1Lyk9qIYi40q1+Qk0Tj5UvNiDHQekD87
         IMCNbUhsao2RvnRex5PozcE8ltGYi6SvnBrpTAi1IU6YhieMEgXKQE6u8w/fM3OqZ00H
         G6Qihgb7JzNDCwUzZ1kLu4oJHh2oeLmZLnyoLnbZzr0p20Rh3FhFZdpOiCPkgQzLIR1W
         HqmoCZtfzXMKi24A3dZsbEe84M3TC7MF2/y6LwRsJEUKGop6nFBFVcoLQ2kPZz4jhYx/
         OgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vGVgNjVIquChRYG3qNsuhFrwCzwmt0K1e1bT0honEPI=;
        b=KZt+Ikb9xhfMhi3/w0tjruZNwZs1uWSMmgtKZLFGti8T3wznX7UkWrWYhjLD09OF8m
         pHCYO/MmZbUiF/Yjpno13bvansfGr+0c36Ntt0HPQ0bZG4g6jISMswBi2ktooMkjc93P
         ekINQE1rBGoG1UCuqZn+7USbbhCxaUFuiNtLit6Ebtt04Z/3IxPqEpUSQg7VMOp5YhPi
         5CnXQ5Vy02o6VPaL0PLbCGQkdOjYMQrgibXD+0AQ7a7Ymw7C9mVhMEL9YxttvYonh6RD
         uZCTlQIOYZxR0EqXBAMbHeD2Tk3mcwfmTPLPtHP5w4z2Oe/lx6hsFAHi25jlSslYL1Fb
         BZXQ==
X-Gm-Message-State: ACgBeo2PTged/U/RgJ6nhtEFsee6RLyZLXOCWx51MhbR+QtEVDMl1Wog
        iaBbehMAQtq6J8O3+3qviDqwhStWuxvIcHbh
X-Google-Smtp-Source: AA6agR4meZWm9mDdaxGaxa+e19Zlo0nNYMe+FubUX0U/41wXMZk3HjVPAmlXDUztz0OYV2rMoaYsJw==
X-Received: by 2002:a1c:7412:0:b0:3b4:7a81:e7e4 with SMTP id p18-20020a1c7412000000b003b47a81e7e4mr1401171wmc.15.1663057068753;
        Tue, 13 Sep 2022 01:17:48 -0700 (PDT)
Received: from bullseye-11-arm64.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q127-20020a1c4385000000b003a5f54e3bbbsm13091967wma.38.2022.09.13.01.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 01:17:47 -0700 (PDT)
Date:   Tue, 13 Sep 2022 08:17:46 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add Lenovo Yoga C630 EC driver
Message-ID: <20220913081746.wjj5jne6fjbzcjxr@bullseye-11-arm64.lan>
References: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
 <20220810030500.2793882-3-bjorn.andersson@linaro.org>
 <20220912165802.dvlf3eeqx5g3bzdm@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912165802.dvlf3eeqx5g3bzdm@maple.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 05:00:17PM +0000, Daniel Thompson wrote:
> On Tue, Aug 09, 2022 at 10:05:00PM -0500, Bjorn Andersson wrote:
> > The Qualcomm Snapdragon-based Lenovo Yoga C630 has some sort of EC
> > providing AC-adapter and battery status, as well as USB Type-C altmode
> > notifications for Displayport operation.
>
> There's a couple of minor review comments but before we get to that:
> woo hoo!

... and now with the correct address for Bjorn too (comments still below
and indented > one level).


Daniel.


> > The Yoga C630 ships with Windows, where these operations primarily are
> > implemented in ACPI, but due to various issues with the hardware
> > representation therein it's not possible to run Linux on this
> > information. As such this is a best-effort re-implementation of these
> > operations, based on the register map expressed in ACPI and a fair
> > amount of trial and error.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  drivers/power/supply/Kconfig        |  11 +
> >  drivers/power/supply/Makefile       |   1 +
> >  drivers/power/supply/yoga-c630-ec.c | 547 ++++++++++++++++++++++++++++
> >  3 files changed, 559 insertions(+)
> >  create mode 100644 drivers/power/supply/yoga-c630-ec.c
> >
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 1aa8323ad9f6..6e706e948ad2 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -897,4 +897,15 @@ config BATTERY_UG3105
> >  	  device is off or suspended, the functionality of this driver is
> >  	  limited to reporting capacity only.
> >
> > +config LENOVO_YOGA_C630_EC
> > +	tristate "Lenovo Yoga C630 EC battery driver"
> > +	depends on DRM
> > +	depends on I2C
>
> This needs a "depends on TYPEC" in order to avoid linker errors.
>
>
> > +	help
> > +	  Driver for the Embedded Controller in the Qualcomm Snapdragon-based
> > +	  Lenovo Yoga C630, which provides battery information and USB Type-C
> > +	  altmode notifications.
> > +
> > +	  Say M or Y here to include this support.
> > +
> >  endif # POWER_SUPPLY
> > diff --git a/drivers/power/supply/yoga-c630-ec.c b/drivers/power/supply/yoga-c630-ec.c
> > new file mode 100644
> > index 000000000000..1fa0b5844e01
> > --- /dev/null
> > +++ b/drivers/power/supply/yoga-c630-ec.c
> > @@ -0,0 +1,547 @@
> > <snip>
> > +static int yoga_c630_ec_bat_get_property(struct power_supply *psy,
> > +					 enum power_supply_property psp,
> > +					 union power_supply_propval *val)
> > +{
> > +	struct yoga_c630_ec *ec = power_supply_get_drvdata(psy);
> > +	int rc = 0;
> > +
> > +	if (ec->bat_present)
> > +		yoga_c630_ec_maybe_update_bat_status(ec);
> > +	else if (psp != POWER_SUPPLY_PROP_PRESENT)
> > +		return -ENODEV;
> > +
> > +	switch (psp) {
> >       <snip>
> > +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> > +		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
> > +		break;
> > +	case POWER_SUPPLY_PROP_MODEL_NAME:
> > +		val->strval = "PABAS0241231";
> > +		break;
> > +	case POWER_SUPPLY_PROP_MANUFACTURER:
> > +		val->strval = "Compal";
> > +		break;
> > +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> > +		val->strval = "05072018";
> > +		break;
>
> I'm a little sceptical that hardcoding a serial number into the
> driver provides anybody any benefit (regardless of whether the
> AML code does this). AFAICT this is not a commonly implemented property
> in other power supplies so I'm not clear why this is needed.
>
>
> Daniel.
