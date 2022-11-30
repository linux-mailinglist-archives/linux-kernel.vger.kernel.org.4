Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD963DA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiK3QN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiK3QN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:13:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0040686A0A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669824743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVZppsKA0ZkKrWi0UQJ3nN97bBOZR3Uq+VmhTSXYrAc=;
        b=EPeieIar5GpX40C/Qm/p30UDU12rR54RpQ8SrkpC76hLadUiyISp6Zjln8XDfsAHYFBeIr
        ag2G+vlV9nBc6n+8JN6yGrxHsFjUGvmOm24xRUyzOgM7sZ97CAu8i4GreUJtzjkE2lNgWf
        uucGki5LbDTvbs4j/UO8wYTtdVYTPQ4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-BMD9txSoMVyDESBFxm8RdQ-1; Wed, 30 Nov 2022 11:12:17 -0500
X-MC-Unique: BMD9txSoMVyDESBFxm8RdQ-1
Received: by mail-ed1-f71.google.com with SMTP id t4-20020a056402524400b004620845ba7bso9960607edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVZppsKA0ZkKrWi0UQJ3nN97bBOZR3Uq+VmhTSXYrAc=;
        b=yg9YbJYXC5PVhLmt0mwBs9kJUnwTEAGKe1jv1WNOI7nQPo+5xWlIfwxJCPM3jtdPeh
         bcpUprj+kF6zmtdVfkDjXu/3rrroHS+0ZNJpKJFH2Tg9p5/Ay6kDF0plvF3kA3EkTlzs
         CekkUzQdntcGYaOEPNcOpaiV3VwR6SKhe+wORc5LokemCEysy8OkG97tyZys6W1H2lV0
         fOiXBtETa52hA4Etnp7Cvj0V9LZ4mAlSvkCbYarn/5D3LRyFe43a7g2uDHujAJltAxoy
         QmN08NG3e73yGYwjO9cRafELrVw+U7Ob67XIm1o+cgiorlC+dfAqi7qmCSK48oUSuu2/
         eyiA==
X-Gm-Message-State: ANoB5pkvhr3AOmBFztEHQlblvitcoSu05+qLPp1EzZNcHh4lA7Kk0Nkj
        N8ShOPgDkJ3P2MnVpJcSZbkx8Ye+H7qO9oPFSvlyGVCBgkxdxjLRVYbn5iLQdtxLXXsDhKZu9Mi
        v6+rnNaLtzdIuItjciQxL4AtY
X-Received: by 2002:a05:6402:2b8a:b0:46b:2979:7397 with SMTP id fj10-20020a0564022b8a00b0046b29797397mr14524416edb.332.1669824735438;
        Wed, 30 Nov 2022 08:12:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6if3Kc2Cj0h+P6TmrYnaFX5IltT1cl7CIO76VkItJB2JB2khb5ke+7EhgOoPjv45ky0ZvgCw==
X-Received: by 2002:a05:6402:2b8a:b0:46b:2979:7397 with SMTP id fj10-20020a0564022b8a00b0046b29797397mr14524389edb.332.1669824735178;
        Wed, 30 Nov 2022 08:12:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007ae4717bef1sm816567ejc.15.2022.11.30.08.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:12:14 -0800 (PST)
Message-ID: <8a53e88b-1e74-bf34-62a1-780a1b29bcbc@redhat.com>
Date:   Wed, 30 Nov 2022 17:12:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/30/22 16:55, Andy Shevchenko wrote:
> The ->get() callback depending on other settings and hardware support
> may return different values, while the line outside the chip is kept
> in the same state. Let's discuss that in the documentation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/driver-api/gpio/driver.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
> index bf6319cc531b..3d2f36001a7a 100644
> --- a/Documentation/driver-api/gpio/driver.rst
> +++ b/Documentation/driver-api/gpio/driver.rst
> @@ -251,6 +251,30 @@ supports more versatile control over electrical properties and can handle
>  different pull-up or pull-down resistance values.
>  
>  
> +Considerations of the ->get() returned value
> +--------------------------------------------
> +
> +Due to different possible electrical configurations and software applications
> +the value that ->get() callback returns may vary depending on the other settings.
> +This will allow to use pins in the I2C emulation mode or other not so standard
> +uses.
> +
> +The below table gathered the most used cases.
> +
> +==========  ==========  ===============  =======================
> +  Input       Output         State        What value to return?
> +==========  ==========  ===============  =======================
> + Disabled    Disabled    Hi-Z             input buffer
> + Disabled    OS/OD/etc   Single ended     [cached] output buffer

You need to clarify what single-ended means here. You mean a pin
which is only capable of output I guess ?  So now way to figure
out if another participant in the OS/OD bus has its transistor
in the "on" state this pulling the bus high / low agains the bias
resistor(s) which determine the state of the bus in rest ?

Or you mean that the bus is uni-directional, even then being
able to detect a short-circuit is useful.

> +    x        Push-Pull   Out              [cached] output buffer

Why, most GPIO drivers are protected against short-circuit to
GND / Vdd and actually reading the input-buffer here will allow
GPIO API consumers to detect such short-circuits if they are
interested in this.  This would e.g. be useful to detect
mis-wiring on devices like the Raspberry Pi were users often
connect extra peripherals through breadboards.

IMHO for pins with an input buffer get() should simply
always return the contents of the input buffer. This is what
I believe almost all GPIO drivers currently do and also
keeps the get() methods KISS.

Actually implementing the behavior you suggest here requires
the get() method to differentiate between push-pull and
other mode. This makes the get() method implementation
needlessly complicated and will likely be a source of bugs
as people will get this wrong in some cases and people
will very likely not test all possible combinations from
this big table you are adding here.

IHMO the rules for get() should simply be:

1. Device has an input buffer:
   Return input-buffer value for the pin.

2. Devices does not have an input buffer:
   Return last set output-buffer value

Regards,

Hans




> + Enabled     Disabled    In               input buffer
> + Enabled     OS/OD/etc   Bidirectional    input buffer
> +==========  ==========  ===============  =======================
> +
> +The [cached] here is used in a broader sense: either pure software cache, or
> +read back value from the GPIO output buffer (not all hardware support that).
> +
> +
>  GPIO drivers providing IRQs
>  ===========================
>  

