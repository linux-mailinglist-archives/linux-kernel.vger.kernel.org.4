Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B0571524F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjE2XdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE2XdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:33:05 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9171BE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:33:03 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 2552c16e-fe79-11ed-b972-005056bdfda7;
        Tue, 30 May 2023 02:33:00 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 30 May 2023 02:32:58 +0300
To:     George Stark <gnstark@sberdevices.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v2] meson saradc: add iio device attrib to switch channel
 7 mux
Message-ID: <ZHU2Khf84nbLW7Gg@surfacebook>
References: <20230527214854.126517-1-gnstark@sberdevices.ru>
 <ZHMxDHPBWQOJSuaZ@smile.fi.intel.com>
 <9df82b13-7594-a8f0-f27e-87bce5a38b74@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9df82b13-7594-a8f0-f27e-87bce5a38b74@sberdevices.ru>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 29, 2023 at 01:31:40AM +0300, George Stark kirjoitti:
> On 5/28/23 13:46, Andy Shevchenko wrote:
> > On Sun, May 28, 2023 at 12:48:54AM +0300, George Stark wrote:

...

> > > +	if (index >= ARRAY_SIZE(chan7_vol))
> > > +		index = ARRAY_SIZE(chan7_vol) - 1;
> > I think this is incorrect and prone to error in the future in case this array
> > will be extended. What I would expect is to return something like "unknown".
> 
> I agree this part is unclean. Actually the register's last 3 (out of 8)
> possible values are stand for the same mux input "ch7_input". So
> theoretically we can read from register a value out of array bounds. There
> should be a comment at least.

You can add there in the array to extend it up to 8 entries, so it will be
clear. And for the rest you will return unknown / unsupported / etc.

...

> > > +static const char * const chan7_vol[] = {
> > > +	"gnd",
> > > +	"vdd/4",
> > > +	"vdd/2",
> > > +	"vdd*3/4",
> > > +	"vdd",
> > > +	"ch7_input",
> > > +};

> About the question of naming mux inputs from the other letter (vdd/2 vs
> 0.5Vdd etc).
> While I fully agree with you that point is better than slash but mixing
> letter cases... should we?

What's wrong with that?

> e.g. this is how iio_info output looks like now:
> ...
>             voltage7:  (input)
>             3 channel-specific attributes found:
>                 attr  0: mean_raw value: 0
>                 attr  1: raw value: 1
>                 attr  2: scale value: 0.439453125
>         4 device-specific attributes found:
>                 attr  0: chan7_mux value: gnd
>                 attr  1: chan7_mux_available value: gnd vdd/4 vdd/2 vdd*3/4
> vdd ch7_input
>                 attr  2: current_timestamp_clock value: realtime
> 
>                 attr  3: waiting_for_supplier value: 0
> 
> or naming with Jonathan's approach
> /sys/devices/platform/soc/fe000000.bus/fe002c00.adc/iio:device0/in_voltage_0.5vdd_raw

See the alternative I proposed is to have _ delimiter. But that might make
parsing a bit harder in user space.

-- 
With Best Regards,
Andy Shevchenko


