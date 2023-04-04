Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA46D5F00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjDDLbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjDDLbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:31:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114AA1FEF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:31:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg48so129105789edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brixit-nl.20210112.gappssmtp.com; s=20210112; t=1680607866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isvzfUusXevjlX/m8HLoBojzsla6kKnE2+y1gA32U+s=;
        b=RWalar01Xmr+HObS0EXf9V6RV3OgW+IwyVxygsMcCo0hEWnEaxZD/UJOsmWuWmUHi0
         FB7xnIlwANfXSwnSi5UePDNhcKITLcpOODnT2sPNgQezdpq33Qqu2prAABabsMZphQpd
         wCWU6O1lVr0MPD+ocgVWEES0TxXa2wuCNrr3JdXBoTpaN0YihUYrOH3I6dWZiHwF0AfK
         kZBvEh8dDHV6zv0kGoLx4KMsEDFxwYX4+WhFDoz//KNk8EStR9Tz0IF497BCO/bRG29c
         iMUtLEFIjqjmSWuoklQxR6OrvxlyarN8st28ZGH4N8toDscXIURpqu2YKP2e3pASDpvw
         j4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680607866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isvzfUusXevjlX/m8HLoBojzsla6kKnE2+y1gA32U+s=;
        b=e3Y0njk2OsKFmFXYKeOYjDSlfbZbqrHp3dIMvQu6yUecbSH2BfmdpE0IDCR9RhqKpq
         LvbyMn68huxP9Zq4OAhFImXqIWk1CCCJe221ib9v8ClPz2A2R1wy/EgwB877ywjb3d/z
         krg00w1KmCZWDHjjYW6ZTDlAUBD4Jbmnaeb2Zc7YM5Owo5vLKJw12DOpGvhtULToGlII
         lgNwlOsT0jWb9RJSRK0HFyK5ONxSlOHfckZXPwUfYq+xYBLLU4EysNXfaZJMy0PwAlyP
         ANCewLlASEk9NPIZJ+/2aHnna5UB6l3zNfCHhLB6xgEfXvuaAgLUwkANVoDCbEQWu6eR
         2R6g==
X-Gm-Message-State: AAQBX9cMPoT7EFdnJHHvuXdJbnVWu6QrgYRosTHo3TT0ijr/I8E3BMYE
        c8xn0S3+7J6XFByiVAlh6vlCWQ==
X-Google-Smtp-Source: AKy350a0zQtZph/zn4aeueNw/Sjo9JuX+ChnqUn8cHiLEoru4plLeDblm/ZGedDP2DOoN1iQnLaSYQ==
X-Received: by 2002:a17:907:d94:b0:933:4dc8:972d with SMTP id go20-20020a1709070d9400b009334dc8972dmr2039657ejc.20.1680607866502;
        Tue, 04 Apr 2023 04:31:06 -0700 (PDT)
Received: from ?IPV6:2a00:bba0:120c:9f02:16cc:d78a:1492:84b3? (2a00-bba0-120c-9f02-16cc-d78a-1492-84b3.static6.cust.trined.nl. [2a00:bba0:120c:9f02:16cc:d78a:1492:84b3])
        by smtp.gmail.com with ESMTPSA id dv23-20020a170906b81700b008f89953b761sm5848931ejb.3.2023.04.04.04.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 04:31:06 -0700 (PDT)
Message-ID: <52d83a29-0f16-cd4c-9810-7c6bd497fe85@brixit.nl>
Date:   Tue, 4 Apr 2023 13:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
Content-Language: en-US
From:   Martijn Braam <martijn@brixit.nl>
In-Reply-To: <3738011.44csPzL39Z@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/23 09:51, Heiko Stübner wrote:
> Hi,
>
> Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
>> This baud rate is set for the device by mainline u-boot and is also what
>> is set in the Pinebook Pro Device Tree, which is a device similar to the
>> PinePhone Pro but with a different form factor.
>>
>> Otherwise, the baud rate of the firmware and Linux don't match by default
>> and a 'console=ttyS2,1500000n8' kernel command line parameter is required
>> to have proper output for both.
> The interesting question is always if this will break someone else's setup.
> I've never really understood the strange setting of 1.5MBps, but on the
> other hand it _is_ a reality on most boards.

It breaks my device test setup at least. The extra speed isn't worth the 
hassle
of having a few devices at weird baudrates and the bootloader already
starts outputting debug logs at 115200 baud.

>
> Personally I don't care that much either way, but would like a comment
> from the other people working on that device - if possible.
>
> I guess if we don't hear anything, I'll apply it nevertheless at some point
>
>
> Heiko
>
>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>> I tried to instead get rid of the baud rate altogether, as suggested by
>> Peter Robinson. AFAIU that should just pick whatever bad rate has been
>> using by the early console.
>>
>> But neither using 'stdout-path = "serial2" nor 'stdout-path = &uart2'
>> worked for me.
>>
>> In both cases I didn't have any output unless setting a baud rate using
>> the 'console='param.
>>
>>   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> index a0795a2b1cb1..6bbe65bd5bd4 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> @@ -26,7 +26,7 @@ aliases {
>>   	};
>>   
>>   	chosen {
>> -		stdout-path = "serial2:115200n8";
>> +		stdout-path = "serial2:1500000n8";
>>   	};
>>   
>>   	gpio-keys {
>>
>> base-commit: 3adf89324a2b2a9dbc2c12d8895021e7e34e3346
>>
>
>
>
