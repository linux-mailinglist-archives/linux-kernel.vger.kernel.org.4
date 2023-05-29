Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA231714D41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjE2PmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjE2PmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:42:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF20A7;
        Mon, 29 May 2023 08:42:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30ad458f085so2249617f8f.0;
        Mon, 29 May 2023 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685374919; x=1687966919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zj+VDAqPSb25/DEXl04R56d41dEGPCQtyqOgNMpILjY=;
        b=VsmwXUVg+FoHXj/nL+qq/3/Md3DiD6hWqsH/LJ+FyWokSlgesuJXyr6UkdmVvRjp0z
         6FmNAZsMS4gTubamr/kPK08H+M7Thdqil9TzAzOO727WyQulsERgEMRUP2mOFCc1f96J
         59dXBg0NSMeCamgo0kP+F6WLNZwBml1ugAEBSSAZ1JR++9sdGGAQnExwSEDhBWDO1SWg
         nCZFbo/14kJlKW6UAKAM5FR/GWhqVNPXGaebbLckTiy00xh7Eo7U6x4lu9WputUkvPrZ
         SwxogrersE/foLyZ/cGYiVF/X62FCpYHdlH/H0RDfBWRhAKYgfKM/3p0bprzQUXNJ4lp
         4Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685374919; x=1687966919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj+VDAqPSb25/DEXl04R56d41dEGPCQtyqOgNMpILjY=;
        b=NF0NcIyiY9BKyZ3VvKzt1iorsDNH32cgMBfMj947m+ihZpp70uFhtATeasGuQyvOEb
         IhL6ZLZSkth3mWyWrFKA2tAzEUd0VxQqCSdBOMYt7YFBmaaOm306adKBGd6xKLiuVNqQ
         TnY/qYV9TcD5nDuq20hGXNhDn15DvqQ5167wR7qEBdUub64nWQrv2P/E+4Zy87xLF/Bd
         Dv7TcA4l+FJ+xfI9TnhTLqFcrRMQ3bakqYlcMHF0pHr8IJRmlRlt2Gg9lotV/gV/N4we
         iU3f9s2wMWpmnyX4+HCyzhAMCaM17NYjIzMfJNSk9JxCUET8AnIwGJtC1luHvN7/45RS
         3iww==
X-Gm-Message-State: AC+VfDzk1PyzDTPdlksyOiUyhjk3R/KpNyC3r9abBQk8Ex+hxnKaKrqI
        U0yglshjc4vUr+MKNS4WrRs=
X-Google-Smtp-Source: ACHHUZ6PZ31jEVJxxW/BVWIZxBiKX42sooJ61VxYWeoBtBaDqvQviu9rCxfVlTeS23L+cDrKF8HXkA==
X-Received: by 2002:adf:f08d:0:b0:30a:efcc:f89a with SMTP id n13-20020adff08d000000b0030aefccf89amr1722530wro.2.1685374919021;
        Mon, 29 May 2023 08:41:59 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b17-20020adff251000000b002c71b4d476asm288024wrp.106.2023.05.29.08.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:41:57 -0700 (PDT)
Message-ID: <cf7afb1f-ad1f-b077-6276-222c5ca918cd@gmail.com>
Date:   Mon, 29 May 2023 17:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/5] irqchip/gic-v3: Disable pseudo NMIs on Mediatek
 Chromebooks w/ bad FW
Content-Language: en-US, ca-ES, es-ES
To:     Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, wenst@chromium.org,
        yidilin@chromium.org, Tinghan Shen <tinghan.shen@mediatek.com>,
        jwerner@chromium.org, Weiyi Lu <weiyi.lu@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Enric Balletbo i Serra <eballetbo@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org
References: <20230515131353.v2.cover@dianders> <86edngmwcf.wl-maz@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <86edngmwcf.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/05/2023 11:58, Marc Zyngier wrote:
> On Mon, 15 May 2023 21:13:49 +0100,
> Douglas Anderson <dianders@chromium.org> wrote:
>>
>> As talked about in the bindings patch included in this series
>> ("dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for
>> Mediatek SoCs w/ broken FW"), many Mediatek-based Chromebooks shipped
>> with firmware that doesn't properly save/restore some GICR
>> registers. This causes the system to crash if "pseudo NMIs" are turned
>> on.
>>
>> This series makes sure that we never allow turning on "pseudo NMIs" if
>> we are running with the problematic firmware.
>>
>> The patches in this series can land in any order and can go through
>> entirely different trees. None of the patches are harmful on their
>> own, but to get things fixed we need all of them.
>>
>> v2 fixes the quirk name and also moves the quirk out of the SoC.dtsi
>> file and into the Chromebook file. This, unfortunately, means that
>> mt8186-based Chromebooks are no longer handled since they don't appear
>> to be upstream yet. :(
>>
>> Changes in v2:
>> - "when CPUs are powered" => "when the GIC redistributors are..."
>> - Changed "Fixes" tag.
>> - Moved from mt8183.dtsi to mt8183-kukui.dtsi
>> - Moved from mt8192.dtsi to mt8192-asurada.dtsi
>> - Moved from mt8195.dtsi to mt8195-cherry.dtsi
>> - mediatek,gicr-save-quirk => mediatek,broken-save-restore-fw
>>
>> Douglas Anderson (5):
>>    dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for Mediatek
>>      SoCs w/ broken FW
>>    irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware
>>      issues
>>    arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to
>>      kukui
>>    arm64: dts: mediatek: mt8192: Add mediatek,broken-save-restore-fw to
>>      asurada
>>    arm64: dts: mediatek: mt8195: Add mediatek,broken-save-restore-fw to
>>      cherry
>>
>>   .../interrupt-controller/arm,gic-v3.yaml      |  6 ++++++
>>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 ++++
>>   .../boot/dts/mediatek/mt8192-asurada.dtsi     |  4 ++++
>>   .../boot/dts/mediatek/mt8195-cherry.dtsi      |  4 ++++
>>   drivers/irqchip/irq-gic-common.c              |  8 ++++++--
>>   drivers/irqchip/irq-gic-common.h              |  1 +
>>   drivers/irqchip/irq-gic-v3.c                  | 20 +++++++++++++++++++
>>   7 files changed, 45 insertions(+), 2 deletions(-)
> 
> I'll take the first two patches as fixes. The rest can be merged via
> the soc tree as required.
> 
> 	M.
> 

Patches 3-5 applied now. Thanks!
