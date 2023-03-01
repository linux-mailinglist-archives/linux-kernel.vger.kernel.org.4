Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F46A69D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCAJaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:30:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC1936469;
        Wed,  1 Mar 2023 01:30:30 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5DC106600362;
        Wed,  1 Mar 2023 09:30:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677663028;
        bh=kzRKHPaffCQS5sZAFMRnd4mRdECYEDJHB5S8AGoRV3k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ilJhazDlsLkG0QAjiGSO16V0TmcYh3StQiRL5RB9pxezQuHyy5YJl2YKZXyTn3iox
         G558l5GWrGaUOt7gVhT6EDDGpYo8/we/o8y+n9vanUn9LOEDVYSnX4lXdjLPjoKIUS
         NCQw3HOODF4DkwXD8jj5XpQvOov/Crh6OQSYY05shfq0CX54cIbuT8k0iIs2S7vyGs
         L02OS97YYbQTOD/lUSxdqKXz4r6R95OmShXqkfnDTCPXoTySQ9LFkj/+489zNVlnn1
         YiVOGSQ/Ony31EpA7UlTr4lGbxwwa9xEw9pJuNy4vwurSXUkK8aSl/0squi69e0LlZ
         UfdmJiK2Wz30Q==
Message-ID: <1022ffb8-c691-5af3-e138-006ea77d3165@collabora.com>
Date:   Wed, 1 Mar 2023 10:30:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 11/18] arm64: dts: mediatek: mt8192-asurada: Couple
 VGPU and VSRAM_OTHER regulators
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com>
 <20230228104741.717819-12-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FyjoLo1VW2Kep5JWH0tz5JE77XjbwWiKusnTntj2eZHQ@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FyjoLo1VW2Kep5JWH0tz5JE77XjbwWiKusnTntj2eZHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/03/23 05:53, Chen-Yu Tsai ha scritto:
> On Tue, Feb 28, 2023 at 6:47 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Add coupling for these regulators, as VSRAM_OTHER is used to power the
>> GPU SRAM, and they have a strict voltage output relation to satisfy in
>> order to ensure GPU stable operation.
>> While at it, also add voltage constraint overrides for the GPU SRAM
>> regulator "mt6359_vsram_others", but don't touch mt6315's vbuck1 as
>> its constraints are fine.
> 
> The minimum voltage on vbuck1 matches the lowest OPP. However the maximum
> voltage is set to the maximum of the regulator itself. The MT8192 datasheet
> says the absolute maximum for the GPU is 0.8V, and the recommended range
> for 0.8V is 0.72V ~ 0.88V. The highest OPP we have is 0.8V, so I would
> just set the maximum voltage to that?
> 

The point was that we'd never get vbuck1 at more than vsram+10mV because
of the constraints that are set with regulator-coupled-max-spread, but
thinking about it again, relying on that is *highly* suboptimal.

Yes, you're right, let's change the constraints on vbuck1 to 800mV: that's
going to be for v4.

Thanks!
Angelo

> ChenYu
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> index df477eb89f21..c8b6e1a9605b 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
>>          regulator-always-on;
>>   };
>>
>> +&mt6359_vsram_others_ldo_reg {
>> +       regulator-min-microvolt = <750000>;
>> +       regulator-max-microvolt = <850000>;
>> +       regulator-coupled-with = <&mt6315_7_vbuck1>;
>> +       regulator-coupled-max-spread = <10000>;
>> +};
>> +
>>   &mt6359_vufs_ldo_reg {
>>          regulator-always-on;
>>   };
>> @@ -1411,6 +1418,8 @@ mt6315_7_vbuck1: vbuck1 {
>>                                  regulator-max-microvolt = <1193750>;
>>                                  regulator-enable-ramp-delay = <256>;
>>                                  regulator-allowed-modes = <0 1 2>;
>> +                               regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
>> +                               regulator-coupled-max-spread = <10000>;
>>                          };
>>                  };
>>          };
>> --
>> 2.39.2
>>

