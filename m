Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B996A7FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCBKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCBKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:17:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF333B0F1;
        Thu,  2 Mar 2023 02:17:17 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 09DD96602E5A;
        Thu,  2 Mar 2023 10:17:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677752236;
        bh=o7ImUOBWJocC9IE4w/doapnXAOm4lxDZbXD8YD8dd4M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KIkRDQIORgXA/JtkgBUDzdxgOgnBoCEig6Lp2q8g58I0F4raynLoL6kwtDyDRrGk0
         Cqt1KU04//2mmbVqjmV3Ia0mNY/qIMNxa1f1YwEHRblxvlcjSWFOSbf5IzXcHv8exN
         FQLNWCTHVgyp3+ylDkzs0Xr638oVKA2GaStFbRKjDR3e8vODI6llTkL+ah0pvb6RcE
         zYsIWcRTCI9ey2meVJL2XaZt9GlQ/etqv1Q6HMa42EKE6zJ/LUPJUoKrMoGtFCx3zO
         fT24Dx6Mocw65XersYHWcQ8e8f6OLKsCyKseS1Dt+GL6ESI7F2RjRR8Outd9r+YUj4
         frtmC8FIxFMbg==
Message-ID: <5dba27e1-d480-ea24-c1ba-03bb7f77b1b1@collabora.com>
Date:   Thu, 2 Mar 2023 11:17:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 12/19] arm64: dts: mediatek: mt8192-asurada: Couple
 VGPU and VSRAM_OTHER regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <20230301095523.428461-13-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GHdtbheL6wxtDo-szk+=3BGk2z93SBowd4Z=E9XupZkw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5GHdtbheL6wxtDo-szk+=3BGk2z93SBowd4Z=E9XupZkw@mail.gmail.com>
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

Il 02/03/23 11:03, Chen-Yu Tsai ha scritto:
> On Wed, Mar 1, 2023 at 5:55 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Add coupling for these regulators, as VSRAM_OTHER is used to power the
>> GPU SRAM, and they have a strict voltage output relation to satisfy in
>> order to ensure GPU stable operation.
>> While at it, also add voltage constraint overrides for the GPU SRAM
>> regulator "mt6359_vsram_others" so that we stay in a safe range of
>> 0.75-0.80V.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> index 8570b78c04a4..f858eca219d7 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
>>          regulator-always-on;
>>   };
>>
>> +&mt6359_vsram_others_ldo_reg {
>> +       regulator-min-microvolt = <750000>;
>> +       regulator-max-microvolt = <800000>;
>> +       regulator-coupled-with = <&mt6315_7_vbuck1>;
>> +       regulator-coupled-max-spread = <10000>;
> 
> Looking again at the downstream OPP table, it seems there's no voltage
> difference requirement. It only needs V_SRAM >= V_GPU. Same applies to
> MT8195. Looks like only MT8183 and MT8186 need V_SRAM - V_GPU >= 10000.

On MT8195 we don't need any regulator coupling. There, the GPU-SRAM voltage
is fixed at .. I don't remember, 0.7V? - anyway - MT8195 doesn't need to
scale the vsram.

> 
> Would setting max-spread to 0 work? I ask because with both regulator's
> maximum voltage set to 0.8V, there's no way we can reach the highest
> OPP.
> 

No that doesn't work. I can raise the Vgpu max voltage to 0.88V to solve the
issue right here and right now, or we can leave it like that and revisit it
later.

I would at this point go for setting mt6315_7_vbuck1's max-microvolt to
880000, as this is the maximum recommended voltage for the GPU as per the
MT8192 datasheet, it would also make sense as we would be still describing
the hardware in a correct manner.

What do you think?

Angelo

> ChenYu
> 
> 
>> +};
>> +
>>   &mt6359_vufs_ldo_reg {
>>          regulator-always-on;
>>   };
>> @@ -1411,6 +1418,8 @@ mt6315_7_vbuck1: vbuck1 {
>>                                  regulator-max-microvolt = <800000>;
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

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

