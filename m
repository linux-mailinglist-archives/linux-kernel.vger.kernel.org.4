Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE365A58A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiLaPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLaPak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B01FD2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672500596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ioTWK7xKnjeiXWvIiaopMDUCl0bx2ByRbNdpJnCkz08=;
        b=ciL0ltYYs9o+4EQe0ANeeOX+9NlkNlyUKFKncrNNC//BjAErV4BTnQHk5lzH90CWfUFRdW
        PjFjD5UGYj5opapuUfDlNaZKhQkwhfxMFdmI9jGTYanDqVLzD1ce2RIU6Si1YitbHC9ZQZ
        13cEx343eZ9bXELcjKZmHFkMK8sEmLU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-rAzcwsnUOiicq46XTIbKuw-1; Sat, 31 Dec 2022 10:29:52 -0500
X-MC-Unique: rAzcwsnUOiicq46XTIbKuw-1
Received: by mail-wm1-f69.google.com with SMTP id c23-20020a7bc857000000b003d97c8d4935so8507277wml.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 07:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioTWK7xKnjeiXWvIiaopMDUCl0bx2ByRbNdpJnCkz08=;
        b=KkhIqb3/NX6lFeE4fyjCvQyGyULYsBeH1UU/3qpbWhtl/4J6VBJegAASvJ4YN7jJef
         NVIhChlm8ZbGsKqaxTiJoPuT3HVT6Ttuh/NRMxvgFJ6+nNrfJrgrVfjdK5h4BJQ0boAh
         ofGe2XEQjcxEVmLAvWyL+QpnMmuNLULEgE6QHZ9oasUXukKuMH7JwtGPozHGJdJcJkhs
         8b+vorx4JnHt/9Mgj809jpzNRQWDH5AWnWaaghMJqCCwYZxNDIOCVRU0nFaqpCTZewNq
         FnFcpAjoAvA10MyiD4SiWlkV01a6hikkLxgEqwxTBgRs6qqQqhbifzrWHWtkxyhgrZ1+
         /ajA==
X-Gm-Message-State: AFqh2kpZsy/FVxrcCYhI2BHYP84IAjWGoAlgMowti8yjrjjb8e1nMQAi
        zOJr/EBUM7Bc1jj935nqyB0jzeI6JhSpjrBzyKBSfe8A1FfT1HE+fNXmAxb7pRh7qzRSM7AHh+6
        vOlSGYuh3VUSiWDseOADsEBt0
X-Received: by 2002:adf:f54a:0:b0:242:73d5:d8cf with SMTP id j10-20020adff54a000000b0024273d5d8cfmr22054932wrp.32.1672500591431;
        Sat, 31 Dec 2022 07:29:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsI4kSzJ3dpbAZwpiBrPu3lrGFl0XL17c/4Epgs9kKSScUH5YrWEp2AzMmrpLu3nOWNFJp6MA==
X-Received: by 2002:adf:f54a:0:b0:242:73d5:d8cf with SMTP id j10-20020adff54a000000b0024273d5d8cfmr22054909wrp.32.1672500591182;
        Sat, 31 Dec 2022 07:29:51 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j6-20020a056000124600b0029100e8dedasm3736327wrx.28.2022.12.31.07.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 07:29:50 -0800 (PST)
Message-ID: <e21b5c12-0cc0-5ec0-b2c6-9dde633d5e10@redhat.com>
Date:   Sat, 31 Dec 2022 16:29:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 4/4] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20221230113155.3430142-1-javierm@redhat.com>
 <20221230113155.3430142-5-javierm@redhat.com>
 <20221230153745.tfs6n4zy4xfwugbw@core>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221230153745.tfs6n4zy4xfwugbw@core>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ondřej,

Thanks a lot for your feedback.

On 12/30/22 16:37, Ondřej Jirman wrote:

[...]

>>  &i2c0 {
>>  	clock-frequency = <400000>;
>>  	i2c-scl-rising-time-ns = <168>;
>> @@ -214,6 +251,9 @@ vcc3v0_touch: LDO_REG2 {
>>  				regulator-name = "vcc3v0_touch";
>>  				regulator-min-microvolt = <3000000>;
>>  				regulator-max-microvolt = <3000000>;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
> 
> You're instructing RK818 to shut down the regulator for touch controller during
> suspend, but I think Goodix driver expects touch controller to be kept powered on
> during suspend. Am I missing something?
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/input/touchscreen/goodix.c#L1405
>

You tell me, it is your patch :) I just cherry-picked this from your tree:

https://github.com/megous/linux/commit/11f8da60d6a5

But if that is not correct, then I can drop the regulator-off-in-suspend.
 
[...]

>> +
>> +	touchscreen@14 {
>> +		compatible = "goodix,gt917s";
> 
> This is not the correct compatible. Pinephone Pro uses Goodix GT1158:
> 
> Goodix-TS 3-0014: ID 1158, version: 0100
> Goodix-TS 3-0014: Direct firmware load for goodix_1158_cfg.bin failed with error -2
> 
>

Same thing. I wasn't aware of this since your patch was using this compatible
string. If "goodix,gt1158" is the correct compatible string, then I agree we
should have that instead even when the firmware is missing. Because the DT is
supposed to describe the hardware. The FW issue can be tackled as a follow-up.

[...] 

>> +
>> +&vopb {
>> +	status = "okay";
>> +	assigned-clocks = <&cru DCLK_VOP0_DIV>, <&cru DCLK_VOP0>,
>> +			  <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
>> +	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
>> +	assigned-clock-parents = <&cru PLL_CPLL>, <&cru DCLK_VOP0_FRAC>;
>> +};
> 
> So here you're putting a fractional clock into path between CPLL -> VOP0_DIV
> -> DCLK_VOP0_FRAC -> DCLK_VOP0.
> 
> Fractional clocks require 20x difference between input and output rates, and
> CPLL is 800Mhz IIRC, while you require 74.25MHz DCLK, so this will not work
> correctly.
> 
> Even if this somehow works by fractional clock being bypassed, I did not design
> the panel mode to be used with CPLL's 800 MHz, but with GPLL frequecy of 594 MHz.
> 
> GPLL 594/74.25 = 8  (integral divider without the need for fractional clock)
> CPLL 800/74.25 = ~10.77441077441077441077
> 
> If you really want to use fractional clock, you'd need to parent it to VPLL
> and set VPLL really high, like close to 2GHz.
>

Thanks for the explanation. Then I just need to squash on top of this, the
following patch. Is that correct?

https://github.com/megous/linux/commit/f19ce7bb7d72

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

