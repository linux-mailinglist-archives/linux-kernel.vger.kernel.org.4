Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB574ACAA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjGGITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjGGITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:19:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168911BEE;
        Fri,  7 Jul 2023 01:19:15 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADCD36606FCA;
        Fri,  7 Jul 2023 09:19:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688717954;
        bh=V2zCa6YQcn89QUk+30ncJYOiCspZ2CW7lvzYLcoBYmw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EKago4s9/yPqzmRoj0O5g0MNg5s9C9Xge7/MwV8FE8TRU2SGLJxDeIdahrJXMvmwj
         Z3w/3sIgqHZV8eK3VVGFX7Cfyc7mYfTmfiv65T6vsZsbZftmU/Y42RStc0XhkWyN1E
         IZUA+jJRMx2Mpc1+t+0qAIkj0Rx2L8z6ZsPAUU2vHU9iAcUrPonmC/MNMcqwUHiBR1
         1yRpFuvEBuuaWDgrZZquwRyGapgqeKZUz6rCRN4VAwv0f86ErE9Lkdy8wFtZ80tab5
         YygvdisRuod+sWxfylNiarkLIdTTAP+dOXQGJzh/SClusExi6ev+6mIk9yWobhhEq3
         ZS7LhUVVs3Jkg==
Message-ID: <63457512-1cf4-d2a6-7afc-daa579de99e8@collabora.com>
Date:   Fri, 7 Jul 2023 10:19:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Fix PM suspend/resume with
 venc clocks
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yong.wu@mediatek.com, tinghan.shen@mediatek.com,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230706095841.109315-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5HsScBVMOY4JcSNS_ZZdpLnNAYWUKohwmfQr6gJJv26CA@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HsScBVMOY4JcSNS_ZZdpLnNAYWUKohwmfQr6gJJv26CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/07/23 07:06, Chen-Yu Tsai ha scritto:
> On Thu, Jul 6, 2023 at 5:59 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Before suspending the LARBs we're making sure that any operation is
>> done: this never happens because we are unexpectedly unclocking the
>> LARB20 before executing the suspend handler for the MediaTek Smart
>> Multimedia Interface (SMI) and the cause of this is incorrect clocks
>> on this LARB.
>>
>> Fix this issue by changing the Local Arbiter 20 (used by the video
>> encoder secondary core) apb clock to CLK_VENC_CORE1_VENC;
>> furthermore, in order to make sure that both the PM resume and video
>> encoder operation is stable, add the CLK_VENC(_CORE1)_LARB clock to
>> the VENC (main core) and VENC_CORE1 power domains, as this IP cannot
>> communicate with the rest of the system (the AP) without local
>> arbiter clocks being operational.
> 
> Somehow I feel like this is papering over some dependency issue in Linux.
> 

It felt the same here, but then, if you disable the video encoder driver entirely
(or even both enc/dec drivers), you'll still get issues with the LARB20 timing out
on the SLP_PROT_RDY check, as there's something in queue going through that larb,
probably from something done by the bootloader before booting Linux.

Note that I'm pointing my finger to the bootloader because - again - even disabling
the venc entirely produces the same issue, and if you disable probing the LARB20
you will anyway get sleep issues (wakes up immediately after going to sleep).

That said, there is another possible solution to that (but even then, I think that
we still need those clock assignments that I've done here), which is to implement
the SMI power domains (mtcmos...): we'd be saving *all smi registers*, resetting an
entire SMI ctx with a poweroff, powering back on and restoring all registers *but*
larb20... at least that's the only solution that I've seen downstream (android
kernels).

...and that's why I believe that this commit is correct.

Of course, if there's something that I'm underestimating here, I'd be glad to
understand.

Cheers,
Angelo

>> Fixes: 3b5838d1d82e ("arm64: dts: mt8195: Add iommu and smi nodes")
>> Fixes: 2b515194bf0c ("arm64: dts: mt8195: Add power domains controller")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> index 95bd058d6083..5c670fce1e47 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> @@ -626,6 +626,8 @@ power-domain@MT8195_POWER_DOMAIN_VDEC1 {
>>
>>                                          power-domain@MT8195_POWER_DOMAIN_VENC_CORE1 {
>>                                                  reg = <MT8195_POWER_DOMAIN_VENC_CORE1>;
>> +                                               clocks = <&vencsys_core1 CLK_VENC_CORE1_LARB>;
>> +                                               clock-names = "venc1-larb";
>>                                                  mediatek,infracfg = <&infracfg_ao>;
>>                                                  #power-domain-cells = <0>;
>>                                          };
>> @@ -688,6 +690,8 @@ power-domain@MT8195_POWER_DOMAIN_VDEC2 {
>>
>>                                                  power-domain@MT8195_POWER_DOMAIN_VENC {
>>                                                          reg = <MT8195_POWER_DOMAIN_VENC>;
>> +                                                       clocks = <&vencsys CLK_VENC_LARB>;
>> +                                                       clock-names = "venc0-larb";
>>                                                          mediatek,infracfg = <&infracfg_ao>;
>>                                                          #power-domain-cells = <0>;
>>                                                  };
>> @@ -3094,7 +3098,7 @@ larb20: larb@1b010000 {
>>                          reg = <0 0x1b010000 0 0x1000>;
>>                          mediatek,larb-id = <20>;
>>                          mediatek,smi = <&smi_common_vpp>;
>> -                       clocks = <&vencsys_core1 CLK_VENC_CORE1_LARB>,
>> +                       clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>,
>>                                   <&vencsys_core1 CLK_VENC_CORE1_GALS>,
>>                                   <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>;
>>                          clock-names = "apb", "smi", "gals";
>> --
>> 2.40.1
>>
>>
> 



