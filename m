Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF70B6D94D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbjDFLPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbjDFLPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:15:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA4D7EEA;
        Thu,  6 Apr 2023 04:15:39 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4559666031C5;
        Thu,  6 Apr 2023 12:15:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680779738;
        bh=Z9FAONHJXsqdRclhbJrYl+nWr1QeHPMowvuPQxfxQPo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dPUfn2F0fQXOoWw/LhHXmj7I5sHnUAs2uMKLfwE0QFoOEjf6/c3DfoURVk3HYpSuO
         /9Ll1dnR1Y8LMCAp1bhyjqMFQ+GXfXOS9XqPKpYUycTOhd6fcwG2CR5aZAp4ortlfg
         Xf0sG/qrIjHLHqEauLHg0wT4h73jh42CP7xLpo/WkcPC+M6LchHE81mHvOFoMrUHJr
         bUyNN3JVdcIjhCEzuqaHtC+8qIC33GJaczStp8mSm/q8Wd9ZYVI+Kv50iPVqr3u0G5
         m2iG/mQ7o1l+gFiNINDmid/+F2RgLCfKY1G4Idj7c140qci/W10qKEZDcOEl6Yt1x/
         67l/27Z2SdZhA==
Message-ID: <8fc46929-6d73-ea75-f44f-b83820c0e5df@collabora.com>
Date:   Thu, 6 Apr 2023 14:15:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 8/8] regulator: fan53555: Add support for RK860X
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
 <20230405194721.821536-9-cristian.ciocaltea@collabora.com>
 <4115e47e-b64b-391a-493c-701c8de0565b@linaro.org>
 <53c803ce-2607-6fd1-485e-e19eb961fd08@collabora.com>
 <231b72cd-352c-10a9-8695-a04f61e36568@linaro.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <231b72cd-352c-10a9-8695-a04f61e36568@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 14:03, Krzysztof Kozlowski wrote:
> On 06/04/2023 12:08, Cristian Ciocaltea wrote:
>>>> +	}, {
>>>> +		.name = "rk8602",
>>>> +		.driver_data = RK8602_VENDOR_ROCKCHIP
>>>> +	}, {
>>>> +		.name = "rk8603",
>>>> +		.driver_data = RK8602_VENDOR_ROCKCHIP
>>>
>>> Why do you need this entry match data if it is the same as rk8602?
>>
>> This is consistent with the handling of syr827 and syr828:
>>
>> 		.name = "syr827",
>> 		.driver_data = FAN53555_VENDOR_SILERGY
>> 	}, {
>> 		.name = "syr828",
>> 		.driver_data = FAN53555_VENDOR_SILERGY
> 
> Yeah, I understand, but it's not necessarily the pattern we want to
> continue. Unless these devices are not really compatible?

They are compatible, so should I simply drop the rk8601 and rk8603 entries?

Probably also renaming rk8600 and rk8602, though I'm not sure what a
proper naming scheme would be to combine the 2 variants for each.

Thanks,
Cristian
