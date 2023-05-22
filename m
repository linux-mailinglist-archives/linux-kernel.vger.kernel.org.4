Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63A70C62E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjEVTQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjEVTPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:15:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223781A8
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:15:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d15660784so3569656b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684782933; x=1687374933;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yOtfK1pFQtCc71cFzgVKT6xOp98rRtV2rALJqQa+Fg=;
        b=tzCG7+bIvrimmh9A79/cNNYbpqnrTvZ9KS7MzHN8Wwp9N/VNwyNHiWm9sfXmiJN+FZ
         2NAYs3kITqf86jDQ3tpi3vVo9R3izNAYncChMT8VoVmi6HPAkDIemARWEjqJubVudaVB
         1atrGX3hl/iXBUubxEcRJXz0FdWG1FKy510pwp3Xpz800d6nlmEUq405nJvUPJafdCLb
         /Re6eMA2CPNO3M6CKiek6H7kiLzIBPVhu0jT/VtcH4URW2lTu6qP2wWPpBwCM7yxB0nc
         7iIFFjrTuI1aN9UfKYRt4g6d8659Mn/ft8lHutS63ZrazzQpjQsxrgPANbJl/a3l5cVX
         5GBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684782933; x=1687374933;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yOtfK1pFQtCc71cFzgVKT6xOp98rRtV2rALJqQa+Fg=;
        b=UFc1y9N+vwc4PHeCOl8KJOprw3bWFL0Dj9NRdR9V90n6Qra6xb2Jcset/fem1mAl8X
         8oaOMQwFn6K2zwiximywmhrq2Fi8BJJsea8VEW15X5TRZe3kPHvCoJjUxTgAxqCtgFHQ
         trfc3is03Nwj+KumvvUiWukku8SOk8C9VeFoo7aR3jMTi1nOnOo6yr/oUyhKWO7EsHwu
         iWYiasvjj+vehywVIwY9IoPCmrKLDvGrRQHLyzIkD8jEUQZLAmjOOPeNLx418pZn4llY
         nXVpBDIg0/zln91Q3uA5qj78js+w4RLuZHVEJ/xZkVu3s5GiGsyz3hcoTFNLW23ZWphV
         OLew==
X-Gm-Message-State: AC+VfDz02ne59OY86HdNNZO41kBZAt6BQ6vHDXGDaBTNgKCTEkkd/r/u
        FUfPC4VH44BVTMbG2oypH/XlUA==
X-Google-Smtp-Source: ACHHUZ52ZEECneLAS9tm/UNsmG0ECpBajQruy+F2ybktcTEo240DF7Ky6kbzndheezdG3NztN857vw==
X-Received: by 2002:a17:902:c407:b0:1ac:451d:34b with SMTP id k7-20020a170902c40700b001ac451d034bmr16613997plk.9.1684782932841;
        Mon, 22 May 2023 12:15:32 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id bj6-20020a170902850600b001a183ade911sm5205732plb.56.2023.05.22.12.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:15:32 -0700 (PDT)
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
In-Reply-To: <c63ebd7e-8658-9cdd-4fc4-ade9c94dfa64@linaro.org>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-2-jstephan@baylibre.com>
 <ab9aa30f-82d7-1d14-5561-e19ff10af0b0@linaro.org>
 <4yppinkucchwnwtnnpbqdn4bejmntjq3q6mx6es55f2pwyce3c@qdhdks47lpyt>
 <1853f049-4f00-b7f0-973a-2c4e7b0b2634@linaro.org>
 <7h353w2oug.fsf@baylibre.com>
 <fbf1b0a6-f45d-69a0-5de6-8269567e15b3@linaro.org>
 <7hwn18yndq.fsf@baylibre.com>
 <c63ebd7e-8658-9cdd-4fc4-ade9c94dfa64@linaro.org>
Date:   Mon, 22 May 2023 12:15:31 -0700
Message-ID: <7hcz2snpnw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 16/05/2023 23:31, Kevin Hilman wrote:
>
>>> Third is to use versioned IP blocks.
>>>
>>> The second case also would work, if it is applicable to you (you really
>>> have fallback matching all devices). Third solution depends on your
>>> versioning and Rob expressed dislike about it many times.
>>>
>>> We had many discussions on mailing lists, thus simplifying the review -
>>> I recommend the first choice. For a better recommendation you should say
>>> a bit more about the block in different SoCs.
>> 
>> I'll try to say a bit more about the PHY block, but in fact, it's not
>> just about differences between SoCs. On the same SoC, 2 different PHYs
>> may have different features/capabilities.
>> 
>> For example, on MT8365, There are 2 PHYs: CSI0 and CSI1.  CSI0 can
>> function as a C-PHY or a D-PHY, but CSI1 can only function as D-PHY
>> (used as the example in the binding patch[1].)  On another related SoC,
>> there are 3 PHYs, where CSI0 is C-D but CSI1 & CSI2 are only D.
>> 
>> So that's why it seems (at least to me) that while we need SoC
>> compatible, it's not enough.  We also need properties to describe
>> PHY-specific features (e.g. C-D PHY)
>
> I recall the same or very similar case... It bugs me now, but
> unfortunately I cannot find it.
>
>> 
>> Of course, we could rely only on SoC-specific compatibles describe this.
>> But then driver will need an SoC-specific table with the number of PHYs
>> and per-PHY features for each SoC encoded in the driver.  Since the
>> driver otherwise doesn't (and shouldn't, IMHO) need to know how many
>> PHYs are on each SoC, I suggested to Julien that perhaps the additional
>> propery was the better solution.
>
> Phys were modeled as separate device instances, so you would need
> difference in compatible to figure out which phy is it.
>
> Other way could be to create device for all phys and use phy-cells=1.
> Whether it makes sense, depends on the actual datasheet - maybe the
> split phy per device is artificial? There is one PHY block with two
> address ranges for each PHY - CSI0 and CSI1 - but it is actually one
> block? You should carefully check this because once design is chosen,
> you won't be able to go back to other and it might be a problem (e.g.
> there is some top-level block for powering on all CSI instances).

We're pretty sure these are multiple instances of the IP block as they
can operate completely independently. 

>> 
>> To me it seems redundant to have the driver encode PHYs-per-SoC info,
>> when the per-SoC DT is going to have the same info, so my suggestion was
>> to simplify the driver and have this kind of hardware description in the
>> DT, and keep the driver simple, but we are definitely open to learning
>> the "right way" of doing this.
>
> The property then is reasonable. It should not be bool, though, because
> it does not scale. There can be next block which supports only D-PHY on
> CSI0 and C-PHY on CSI1? Maybe some enum or list, depending on possible
> configurations.

OK, looks like include/dt-bindings/phy/phy.y already has

  #define PHY_TYPE_DPHY		10
  #define PHY_TYPE_CPHY		11

we'll add a PHY_TYPE_CDPHY and use that.   Sound reasonable?

Kevin
