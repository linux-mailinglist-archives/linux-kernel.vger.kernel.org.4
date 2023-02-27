Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A016A46BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjB0QHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjB0QHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:07:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B62F233C8;
        Mon, 27 Feb 2023 08:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1vz2UEdjmQXWhUlE3HWzfK6c4UyQl3yd4RAPwcSJ89A=; b=ZTBfsGzw1Zz25agNHtP5dojHJj
        SbvBw4DWjkluj57TGsurxGKn7gq5utVt4Xo3T87VCnghOCjxsyOzwSFD6p9BzQA8dzP6aFzroou/G
        joiJ2HyB6hVfZie38EcUmBZtP13momINHbb8XT2j4fAjqp3Qy2L7cV8ty1o0CBQL9ZEmrBFPas6B9
        hCyor6yF7a5nzuuNCJo+8LQbNEfALDGwi0FHT3YgblTzpvR0rVQfzjEzd6ZPJeDq7FdCg+eKyKAY4
        1TARqq1Vn1SRIuIhwDqKPV3mwmE+gt26RF978mC3zR66Misshi/Y8AiXx1BjQTKxkLcfITK3b0m8i
        s73G6E1w==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWg1q-00AItm-J2; Mon, 27 Feb 2023 16:07:06 +0000
Message-ID: <6a95a337-2972-427f-635d-5ef4e91a82fa@infradead.org>
Date:   Mon, 27 Feb 2023 08:07:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/8] drivers: select REGMAP instead of depending on it
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
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
 <7dd27ec5-0619-128d-8407-6711a05ef271@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7dd27ec5-0619-128d-8407-6711a05ef271@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 01:31, Hans de Goede wrote:
> Hi Randy,
> 
> On 2/26/23 06:39, Randy Dunlap wrote:
>> REGMAP is a hidden (not user visible) symbol. Users cannot set it
>> directly thru "make *config", so drivers should select it instead of
>> depending on it if they need it.
>>
>> Consistently using "select" or "depends on" can also help reduce
>> Kconfig circular dependency issues.
>>
>> REGMAP is selected 94 times and is depended on 11 times in
>> current linux-next. Eliminate the uses of "depends on" by
>> converting them to "select".
> 
> Thank you for your work on this. Mixing of depends on vs select
> is a real problem with many Kconfig symbols.
> 
>>  [PATCH 1/8] ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it
>>  [PATCH 2/8] clk: HI655X: select REGMAP instead of depending on it
>>  [PATCH 3/8] gpio: GPIO_REGMAP: select REGMAP instead of depending on it
>>  [PATCH 4/8] leds: TI_LMU_COMMON: select REGMAP instead of depending on it
>>  [PATCH 5/8] platform: mellanox: select REGMAP instead of depending on it
>>  [PATCH 6/8] platform: x86: MLX_PLATFORM: select REGMAP instead of depending on it
>>  [PATCH 7/8] thermal: intel: BXT_PMIC: select REGMAP instead of depending on it
>>  [PATCH 8/8] serial: 8250: ASPEED_VUART: select REGMAP instead of depending on it
> 
> For patch 5/8 and 6/8, do you want me to merge them through the pdx86
> (platform-drivers-x86) tree, or do you plan to merge this whole series
> in one go through some other tree?

Hi Hans,
Please merge them thru the pdx86 tree.

Thanks.

> If you plan to merge the whole series through some other tree,
> here is my acked by for doing so for 5/8 and 6/8:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>>
>> diffstat:
>>  drivers/char/ipmi/Kconfig         |    3 ++-
>>  drivers/clk/Kconfig               |    2 +-
>>  drivers/gpio/Kconfig              |    2 +-
>>  drivers/leds/Kconfig              |    2 +-
>>  drivers/platform/mellanox/Kconfig |    9 ++++-----
>>  drivers/platform/x86/Kconfig      |    3 ++-
>>  drivers/thermal/intel/Kconfig     |    3 ++-
>>  drivers/tty/serial/8250/Kconfig   |    3 ++-
>>  8 files changed, 15 insertions(+), 12 deletions(-)
>>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Cc: Corey Minyard <minyard@acm.org>
>> Cc: openipmi-developer@lists.sourceforge.net
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Riku Voipio <riku.voipio@linaro.org>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: linux-clk@vger.kernel.org
>> Cc: Michael Walle <michael@walle.cc>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
>> Cc: linux-gpio@vger.kernel.org
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Lee Jones <lee@kernel.org>
>> Cc: linux-leds@vger.kernel.org
>> Cc: Darren Hart <dvhart@infradead.org>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Michael Shych <michaelsh@nvidia.com>
>> Cc: Mark Gross <markgross@kernel.org>
>> Cc: Vadim Pasternak <vadimp@nvidia.com>
>> Cc: platform-driver-x86@vger.kernel.org
>> Cc: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>
>> Cc: Bin Gao <bin.gao@intel.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Amit Kucheria <amitk@kernel.org>
>> Cc: linux-pm@vger.kernel.org
>> Cc: Oskar Senft <osk@google.com>
>> Cc: linux-serial@vger.kernel.org
>>
> 

-- 
~Randy
