Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA26A3E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjB0JcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjB0JcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251E9EF8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677490288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZ7tgd2yMldNRnjyOaSsgByklv9W+sBvCfRkPHDmb94=;
        b=AulAr32E/BbqvfLAZ0y56TpIyXCZhTX62R3j6dYQDpUQx9xHh9VFjzfyfSSz/wllzAb98+
        u8nu6FQKkZZYYsTv3GzZse0Ojq3Z0dAjSUV4H1LymMOTBCBYWpRMU4I5WrhvauU0ARhY/v
        iIK0GymWgtriG+cgi4vVB5TGK87rxxU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-532-rfmJlkqbNX2PHcaPWQQUyw-1; Mon, 27 Feb 2023 04:31:25 -0500
X-MC-Unique: rfmJlkqbNX2PHcaPWQQUyw-1
Received: by mail-ed1-f69.google.com with SMTP id eg35-20020a05640228a300b004ad6e399b73so7637772edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ7tgd2yMldNRnjyOaSsgByklv9W+sBvCfRkPHDmb94=;
        b=nm+6S1UmuQtZJlrdBXu2pmY7C068T4gzVSrxdHNJTh6u3Fj69t83rREvQR4NVzQQ0W
         bvCg42xSCbmeFQj4FH74jBibiLOUlm5fCZeFii49HnZ7Ha5uXrdpMIXJjiF/66HE5Rai
         Cb99QDJGE2gs08tMxj07R72w+X9ZTbQ5f3jpaNygkSrhSl5HQiBCPcBWkUYVOswwnsnQ
         8ULPigmvONg864B4XKU5pIeYT9sjgE9ulrR0VDDgUzEYW6YVvbK76YIFJzH2+Ek9rc/h
         HBsVVawmZeWcxDsMP+JJ2H+CIcKZXQ9xSmsbxcxCrGufP49FMIPwJqgfxV1W/6Fa2a74
         MBmg==
X-Gm-Message-State: AO0yUKUvZnHzpHv+/YLQzSnfiqrCIGNmtx+tggX1zadOP0gIFKbGgO4n
        PizwsF37TeuNluT7FVy6tIsAz01u8h5fIcJbylAFDjlAZ1rWFmYCt7U/IbCLBWrfpcCaSnV0ZDB
        QUtAvzBHMOtD/RsmioUY5ngHE
X-Received: by 2002:a17:906:4d8c:b0:8ae:f73e:233f with SMTP id s12-20020a1709064d8c00b008aef73e233fmr36187958eju.32.1677490284511;
        Mon, 27 Feb 2023 01:31:24 -0800 (PST)
X-Google-Smtp-Source: AK7set+NbVSpt4yOAnECcpAr2/cCoG6u5mlrIrkJajmml4ubXI2EjR7IrG3eLzjCQWCzYYep+F5FNw==
X-Received: by 2002:a17:906:4d8c:b0:8ae:f73e:233f with SMTP id s12-20020a1709064d8c00b008aef73e233fmr36187918eju.32.1677490284210;
        Mon, 27 Feb 2023 01:31:24 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id qq10-20020a17090720ca00b008e09deb6610sm2942505ejb.200.2023.02.27.01.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 01:31:23 -0800 (PST)
Message-ID: <7dd27ec5-0619-128d-8407-6711a05ef271@redhat.com>
Date:   Mon, 27 Feb 2023 10:31:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] drivers: select REGMAP instead of depending on it
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Riku Voipio <riku.voipio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Michael Shych <michaelsh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org,
        Yegnesh S Iyer <yegnesh.s.iyer@intel.com>,
        Bin Gao <bin.gao@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        Oskar Senft <osk@google.com>, linux-serial@vger.kernel.org
References: <20230226053953.4681-1-rdunlap@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230226053953.4681-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 2/26/23 06:39, Randy Dunlap wrote:
> REGMAP is a hidden (not user visible) symbol. Users cannot set it
> directly thru "make *config", so drivers should select it instead of
> depending on it if they need it.
> 
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
> 
> REGMAP is selected 94 times and is depended on 11 times in
> current linux-next. Eliminate the uses of "depends on" by
> converting them to "select".

Thank you for your work on this. Mixing of depends on vs select
is a real problem with many Kconfig symbols.

>  [PATCH 1/8] ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it
>  [PATCH 2/8] clk: HI655X: select REGMAP instead of depending on it
>  [PATCH 3/8] gpio: GPIO_REGMAP: select REGMAP instead of depending on it
>  [PATCH 4/8] leds: TI_LMU_COMMON: select REGMAP instead of depending on it
>  [PATCH 5/8] platform: mellanox: select REGMAP instead of depending on it
>  [PATCH 6/8] platform: x86: MLX_PLATFORM: select REGMAP instead of depending on it
>  [PATCH 7/8] thermal: intel: BXT_PMIC: select REGMAP instead of depending on it
>  [PATCH 8/8] serial: 8250: ASPEED_VUART: select REGMAP instead of depending on it

For patch 5/8 and 6/8, do you want me to merge them through the pdx86
(platform-drivers-x86) tree, or do you plan to merge this whole series
in one go through some other tree?

If you plan to merge the whole series through some other tree,
here is my acked by for doing so for 5/8 and 6/8:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> diffstat:
>  drivers/char/ipmi/Kconfig         |    3 ++-
>  drivers/clk/Kconfig               |    2 +-
>  drivers/gpio/Kconfig              |    2 +-
>  drivers/leds/Kconfig              |    2 +-
>  drivers/platform/mellanox/Kconfig |    9 ++++-----
>  drivers/platform/x86/Kconfig      |    3 ++-
>  drivers/thermal/intel/Kconfig     |    3 ++-
>  drivers/tty/serial/8250/Kconfig   |    3 ++-
>  8 files changed, 15 insertions(+), 12 deletions(-)
> 
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Riku Voipio <riku.voipio@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Cc: Michael Walle <michael@walle.cc>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-gpio@vger.kernel.org
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-leds@vger.kernel.org
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Michael Shych <michaelsh@nvidia.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Vadim Pasternak <vadimp@nvidia.com>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>
> Cc: Bin Gao <bin.gao@intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Oskar Senft <osk@google.com>
> Cc: linux-serial@vger.kernel.org
> 

