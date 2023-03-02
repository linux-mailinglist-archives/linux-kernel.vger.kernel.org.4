Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF3D6A7FB6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCBKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCBKKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:10:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79E7CC1B;
        Thu,  2 Mar 2023 02:10:43 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C32146602E5A;
        Thu,  2 Mar 2023 10:10:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677751842;
        bh=t5eq3uAkekcEAZLBKAQk76E2Y4WVk9vwCEg+Zuvuy/A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TwfYYIGRNFbj7TPJk8Ku+1d9YuhYyvePwH1DX2afzhjlg6jJEMN4myG0NdEkWLmEU
         drlSjra9QWW7BP3MZzga8G8+gHSk/kLTaD3GswwLAMa9+5U3Nnio2o4SsmOQtoHslN
         DdloZtIB7ZpZhKuGvH6Gb/vvpYFam4m9kHsGmAtFK0hIwXJHv5IH3/KqvkNPr+xIUN
         Jejx3aPfQIjKWrNeGlLGcq2oebGHRBY4JwO4KK45rTVYq94XrajBjB7oKbNCDmd2U2
         KoIv8ZZyQcgJnVqnXPfuN5gS7vdwQzfeCxGUd4J27Tfn+HHPnOJa4EO//V3JUMB5MH
         GmVGJGSdYlfbQ==
Message-ID: <895abaa2-5fd3-9928-4e53-86ce160fbad8@collabora.com>
Date:   Thu, 2 Mar 2023 11:10:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 00/19] Enable GPU with DVFS support on MediaTek SoCs
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <b4fc6bd8-e300-0f40-4216-8b99589c21cc@gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b4fc6bd8-e300-0f40-4216-8b99589c21cc@gmail.com>
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

Il 02/03/23 10:36, Matthias Brugger ha scritto:
> Series looks good but from my understanding has a dependency on:
> [PATCH v4 00/12] Panfrost: Improve and add MediaTek SoCs support 
> (https://lore.kernel.org/linux-mediatek/20230228102610.707605-1-angelogioacchino.delregno@collabora.com/)
> 
> Did I get that right?
> 

Yes you got it right - without the mentioned series, this one will do nothing
at all (and will also fail binding checks, as the bindings are introduced in
that other series).

Cheers,
Angelo

> Regards,
> Matthias
> 
> On 01/03/2023 10:55, AngeloGioacchino Del Regno wrote:
>> Changes in v4:
>>   - Added a fix for MT8192 Vgpu voltage constraints
>>   - Changed constraints for MT8192 VSRAM-GPU to reflect the maximum
>>     achievable voltage as per the actual vsram-vgpu relation constraint
>>
>> Changes in v3:
>>   - Changed MT8186 compatibles for new bindings
>>   - Added min/max voltage overrides for vgpu/vsram_gpu on
>>     mt8183-pumpkin and evb as suggested by Chen-Yu
>>   - Cosmetic fixes for "arm64: dts: mediatek: mt8192: Add GPU nodes"
>>
>> Changes in v2:
>>   - Changed MT8186 to use only two power domains for the GPU.
>>
>> We finally have working GPU DVFS on MediaTek SoCs.
>> On Panfrost.
>> For real.
>> ...and the best part is that it's going upstream.
>>
>> In order to get GPU DVFS working, it was necessary to satisfy a
>> specific constraint (which is different, depending on the SoC)
>> between two regulators: GPU VCORE and GPU SRAM.
>> This was done through adding the mtk-regulator-coupler driver,
>> which transparently manages the voltage relation between these
>> two vregs, hence completely eliminating the need to manage these
>> regulators in the Panfrost driver; this solves the long standing
>> issue with devfreq+opp tables not supporting managing voltages
>> for two regulators per opp entry out of the box, due to which
>> we never got GPU DVFS on those SoCs, often locking them out to
>> a low GPU frequency.
>>
>> This changes. Right now!
>>
>> Tested on MT8192, MT8195 Chromebooks.
>>
>> This series depends on [1].
>>
>> [1]: 
>> https://lore.kernel.org/lkml/20230228102704.708150-1-angelogioacchino.delregno@collabora.com/
>>
>> Alyssa Rosenzweig (2):
>>    arm64: dts: mediatek: mt8192: Add GPU nodes
>>    arm64: dts: mediatek: mt8192-asurada: Enable GPU
>>
>> AngeloGioacchino Del Regno (16):
>>    arm64: dts: mediatek: mt8183-kukui: Couple VGPU and VSRAM_GPU
>>      regulators
>>    arm64: dts: mediatek: mt8183-kukui: Override vgpu/vsram_gpu
>>      constraints
>>    arm64: dts: mediatek: mt8183: Remove second opp-microvolt entries from
>>      gpu table
>>    arm64: dts: mt8183-pumpkin: Couple VGPU and VSRAM_GPU regulators
>>    arm64: dts: mediatek: mt8183-evb: Couple VGPU and VSRAM_GPU regulators
>>    arm64: dts: mediatek: mt8183: Use mediatek,mt8183b-mali as GPU
>>      compatible
>>    arm64: dts: mediatek: mt8192: Add mfg_ref_sel clock to MFG0 domain
>>    arm64: dts: mediatek: mt8192-asurada: Assign sram supply to MFG1 pd
>>    arm64: dts: mediatek: mt8192-asurada: Fix voltage constraint for Vgpu
>>    arm64: dts: mediatek: mt8192-asurada: Couple VGPU and VSRAM_OTHER
>>      regulators
>>    arm64: dts: mediatek: mt8195: Add mfg_core_tmp clock to MFG1 domain
>>    arm64: dts: mt8195: Add panfrost node for Mali-G57 Valhall Natt GPU
>>    arm64: dts: mediatek: mt8195-cherry: Enable Mali-G57 GPU
>>    arm64: dts: mediatek: mt8186: Add GPU node
>>    arm64: dts: mediatek: mt8183-pumpkin: Override vgpu/vsram_gpu
>>      constraints
>>    arm64: dts: mediatek: mt8183-evb: Override vgpu/vsram_gpu constraints
>>
>> Nícolas F. R. A. Prado (1):
>>    arm64: dts: mediatek: mt8192-asurada: Add MFG0 domain supply
>>
>>   arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  17 ++-
>>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  17 ++-
>>   .../boot/dts/mediatek/mt8183-pumpkin.dts      |  17 ++-
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  34 ++---
>>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  17 +++
>>   .../boot/dts/mediatek/mt8192-asurada.dtsi     |  24 +++-
>>   arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 116 +++++++++++++++++-
>>   .../boot/dts/mediatek/mt8195-cherry.dtsi      |   5 +
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  95 +++++++++++++-
>>   9 files changed, 315 insertions(+), 27 deletions(-)
>>

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

