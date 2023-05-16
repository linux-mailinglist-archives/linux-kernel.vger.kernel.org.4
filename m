Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EE470597E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjEPVbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEPVbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:31:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64A6A54
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:31:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6434e263962so10799428b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684272676; x=1686864676;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5CRHn8zU2wZsvy0JRRZis0EWZY7YDhaSFOHEA4KdRg=;
        b=o4uwt/CEsKOFVj4TSBd9vuegw2VIZM9zVBVMpcYfDe9/EKHD52bRQNnaFbjpbkHJ9p
         YplJPVxC1QHPQx5yH/tZwo4tBQAj5EFxdqd9FxWnMi5sjpS4xui7FsgN2dpvILzib/Hk
         faroGEqAEyUgMM0+717KknAxv3UII1KDhg0glpLXzpBYje/KSloSiAtGRvvIx3MkHjgi
         VKD5e/ZjZAztMwm4+LWz2VWSjXW8kVp2htInaNA5jlDsrXioL+90VDshEbq3TdfNjSPc
         Yleugl/EQgz52mrBRjAMGK9M7mauAmyGuptJxSEeCz6+OP4P7/Lm2HNTU4nOZz7xjcob
         bawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272676; x=1686864676;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5CRHn8zU2wZsvy0JRRZis0EWZY7YDhaSFOHEA4KdRg=;
        b=dnCn5bQKA31M2SIJQKIaaz+3KlrVQKfsw98Oi1lwwKX9sAQgVsgQ6Iuki0ToC0QGCd
         uuyv4xkyP755byclX0bzQ7HwWqUjZIlgORPp4C4ncvu8kn5VKYsYNQFqS+BHAz71gVDG
         6DMUHseJ7/LP8xQo+QrIKTvBbPJ+5Vm+5iXT7Plnx4ZzbyoQcn+n7p4nRYzIdbAx2zHH
         fFnWTMUT2N+4H5Frp4NWqK29IEobYsCeR+E+9z20sOruCNo4MBoPSMJYwxsYk455zvC3
         hE4za9Vgb1FZpY7AISG+kTPVBuN3fptZz1ry9sAE7BBMMXtpIlja5zybawzTCiMROfkk
         jZKg==
X-Gm-Message-State: AC+VfDzuUdC4EvS+8RCHfT+MxbGfUWH0+Ksip48L1PgAGNibwwH7d8sc
        doAU6K1q3nwAhOD+1TCBDpl33Q==
X-Google-Smtp-Source: ACHHUZ6+HwilpdkWKX7TFAFXPBYVyOINgkLVoqxcmDktQYsz1CYMpBHtUHdIF5XtrBA17/dhRUjXAg==
X-Received: by 2002:a05:6a00:2d0e:b0:641:699:f353 with SMTP id fa14-20020a056a002d0e00b006410699f353mr52896229pfb.22.1684272676506;
        Tue, 16 May 2023 14:31:16 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id e11-20020a62ee0b000000b00642ea56f06dsm13790697pfi.26.2023.05.16.14.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:31:14 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Julien Stephan <jstephan@baylibre.com>
Cc:     robh@kernel.org, chunkuang.hu@kernel.org,
        linux-mediatek@lists.infradead.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add mediatek mipi csi driver v
 0.5
In-Reply-To: <fbf1b0a6-f45d-69a0-5de6-8269567e15b3@linaro.org>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-2-jstephan@baylibre.com>
 <ab9aa30f-82d7-1d14-5561-e19ff10af0b0@linaro.org>
 <4yppinkucchwnwtnnpbqdn4bejmntjq3q6mx6es55f2pwyce3c@qdhdks47lpyt>
 <1853f049-4f00-b7f0-973a-2c4e7b0b2634@linaro.org>
 <7h353w2oug.fsf@baylibre.com>
 <fbf1b0a6-f45d-69a0-5de6-8269567e15b3@linaro.org>
Date:   Tue, 16 May 2023 14:31:13 -0700
Message-ID: <7hwn18yndq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, 

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 16/05/2023 19:00, Kevin Hilman wrote:
>>>>>> +  compatible:
>>>>>> +    enum:
>>>>>> +      - mediatek,phy-mipi-csi-0-5
>>>>>
>>>>> SoC based compatibles. 0-5 is odd.
>>>>>
>>>>>> +
>>>>>> +  reg:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  '#phy-cells':
>>>>>> +    const: 0
>>>>>> +
>>>>>> +  mediatek,is_cdphy:
>>>>>
>>>>> No underscores in node names.
>>>>>
>>>>>> +    description:
>>>>>> +      Specify if the current phy support CDPHY configuration
>>>>>
>>>>> Why this cannot be implied from compatible? Add specific compatibles.
>>>>>
>>>>>
>>>> This cannot be implied by compatible because the number of phys depends
>>>> on the soc and each phy can be either D-PHY only or CD-PHY capable.
>>>> For example mt8365 has 2 phy: CSI0 and CSI1. CSI1 is DPHY only and CSI0 is CD-PHY
>>>
>>> So it is SoC specific so why it cannot be implied by compatible? I don't
>>> understand. You will have SoC specific compatibles, right? or you just
>>> ignored my comments here?
>> 
>> Julien, I think you had SoC specific compatibles in an earlier version
>> but then changed it to be generic based on reviewer feedback.  However,
>> that earlier version of the driver was trying to do a bunch of SoC
>> specific logic internally and support multiple SoCs.  You've now greatly
>> simplified the driver, with only a few SoC specific decisions needed.
>> These can be implied by the driver based SoC specific compatible, as
>> Krzysztof suggests, so you should just go back to having SoC specific
>> compatibles.
>> 
>
> Yes. If there is common part, e.g. several SoCs use the same device with
> same programming model, then the generic recommendation is to have
> SoC-based fallback (used also in the driver) and SoC-specific compatibles.
>
> Second accepted solution is to have generic fallback which does not use
> SoC in the compatible (and of course mandatory SoC-specific comaptibles).
>
> Third is to use versioned IP blocks.
>
> The second case also would work, if it is applicable to you (you really
> have fallback matching all devices). Third solution depends on your
> versioning and Rob expressed dislike about it many times.
>
> We had many discussions on mailing lists, thus simplifying the review -
> I recommend the first choice. For a better recommendation you should say
> a bit more about the block in different SoCs.

I'll try to say a bit more about the PHY block, but in fact, it's not
just about differences between SoCs. On the same SoC, 2 different PHYs
may have different features/capabilities.

For example, on MT8365, There are 2 PHYs: CSI0 and CSI1.  CSI0 can
function as a C-PHY or a D-PHY, but CSI1 can only function as D-PHY
(used as the example in the binding patch[1].)  On another related SoC,
there are 3 PHYs, where CSI0 is C-D but CSI1 & CSI2 are only D.

So that's why it seems (at least to me) that while we need SoC
compatible, it's not enough.  We also need properties to describe
PHY-specific features (e.g. C-D PHY)

Of course, we could rely only on SoC-specific compatibles describe this.
But then driver will need an SoC-specific table with the number of PHYs
and per-PHY features for each SoC encoded in the driver.  Since the
driver otherwise doesn't (and shouldn't, IMHO) need to know how many
PHYs are on each SoC, I suggested to Julien that perhaps the additional
propery was the better solution.  

To me it seems redundant to have the driver encode PHYs-per-SoC info,
when the per-SoC DT is going to have the same info, so my suggestion was
to simplify the driver and have this kind of hardware description in the
DT, and keep the driver simple, but we are definitely open to learning
the "right way" of doing this.

Thanks for your review and guidance,

Kevin

[1] https://lore.kernel.org/linux-mediatek/20230515090551.1251389-2-jstephan@baylibre.com/
