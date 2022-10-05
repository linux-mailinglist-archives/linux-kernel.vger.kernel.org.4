Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1465F51C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJEJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJEJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:34:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1CB51A0D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:34:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c7so14829089pgt.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date;
        bh=W6Rjad9w9ZpkRZmKm2QHPWW580vRhPpczFar+LESCVo=;
        b=iZI1Iyire6ZTuwbvd8W4RiiM4TT6TG8gcGVBXW3TsEr/KEeNlhMBXvnYSyExvSwn3a
         p3ISPPu43kYjGGdL+XauTnffdEe5ijgj1m+vEor7sGOVi8FmZ4gak2VFB8dRHKrsDZFm
         8hZQFhkbsyuLe+kUIi3QSkf9kRPTFqsSCVMtolYS8EOYfoS/GK8TkSWwnxS+FFKm9yat
         XpIbghx5Sk12glXdcpeuYkmzht2zDqYos1e4+xuCFYhiDKk2k0G0DU59L8lru2htuZE+
         GkJlscyAYFiO0/giotTXb8RpUDhKgqlD9Nwv/Fy/XLME4SN5KyZMbguwqExPbfAUYEE6
         neCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date;
        bh=W6Rjad9w9ZpkRZmKm2QHPWW580vRhPpczFar+LESCVo=;
        b=yaiG7yx3NNRdrBs8BP4EtxTLWWv1W/zOUXimH54C4qZGCdKBlkMOkNl8mwibUCA630
         hpOkCbJ4BitMQDxpWu1sTUz4BmPKGB9P4PZ4Yxqk1aVVGf942djyLOGV1uZgJUtVTpDB
         sCNq9Cl70Fy7QcZ49pZp9oTBsAZnoGw0Vsd5ewTjIcHnrpRGscCFJ24vNWlKRJMdr8VS
         6RLXo3/jx1jrSKg80sa9SoSf8SuBfYT4y4+9TkwzczQI/Cl89aMX1LyQfTxOsb0dwRAp
         21xBTRlpSBGRYKToiTgvFBJ01ns0DTtY28pFfmxaj8LbzL97sj+qHyOhixzqLWkpjnJz
         HJ8w==
X-Gm-Message-State: ACrzQf2suh7JE7B26D1Dntjo3o23y6AWZs5MuloyMdbydkAaUOylMnSZ
        1YwVQAqJrI0BH9zoJ89jyRXapqWdTsoUpir8dAOGUg==
X-Google-Smtp-Source: AMsMyM7IEMQ8VuBpLr4M/FXXnQHnzRBpA7qrWywzLLp9eOB5FOQsqJXreoP7ZvOaT2OaBEB8mfOoaLfZ0CauXaSBTac=
X-Received: by 2002:aa7:83cd:0:b0:560:21ea:bb21 with SMTP id
 j13-20020aa783cd000000b0056021eabb21mr19326276pfn.1.1664962460150; Wed, 05
 Oct 2022 02:34:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Oct 2022 02:34:19 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v1-0-4844816c9808@baylibre.com> <20220919-v1-17-4844816c9808@baylibre.com>
 <a0a3c427-c851-ae5d-4010-e94740bf9f6e@linaro.org> <CABnWg9s3N_Ua9g0S3x0uj8PN4FtOX6DO+zQcBzGFqoLTL1J24A@mail.gmail.com>
 <bc64b69d-3d65-f5ca-a688-2ad1a055ba4b@linaro.org> <CABnWg9sJFBAXi1bu_yHDppFOmg=H=G7QTn9Bzqkr-t7qm5vUFw@mail.gmail.com>
 <db1abf9d-ba40-f71c-0d37-c3912ac1bd8e@linaro.org> <CABnWg9vOHWpdLPAFdXAG3GNgsxpbzgh2gTq_tm72Tk2uR54LaQ@mail.gmail.com>
 <49daae86-e922-9a17-ebed-2a33a5eeb18e@linaro.org>
In-Reply-To: <49daae86-e922-9a17-ebed-2a33a5eeb18e@linaro.org>
MIME-Version: 1.0
Date:   Wed, 5 Oct 2022 02:34:19 -0700
Message-ID: <CABnWg9sPuJQQOmLGDSgE86NCRh_3GqWZ0dFAs_J2PO9HCVbExQ@mail.gmail.com>
Subject: Re: [PATCH v1 17/17] drm/mediatek: Add mt8195-dpi support to drm_drv
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022 17:05, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>On 04/10/2022 13:55, Guillaume Ranquet wrote:
>>> No. You said what the code is doing. I think I understand this. You
>>> still do not need more compatibles. Your sentence did not clarify it
>>> because it did not answer at all to question "why". Why do you need it?
>>>
>>> Sorry, the change looks not correct.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> I need a new compatible to adress the specifics of mt8195 in the mtk_dpi driver,
>> the change is in this series with:
>> [PATCH v1 16/17] drm/mediatek: dpi: Add mt8195 hdmi to DPI driver [1]
>
>But you do not have specifics of mt8195. I wrote it in the beginning.
>
>>
>> I then need to add that compatible to the "list" here in mtk_drm_drv.
>
>No, you do not... I checked the driver and there is no single need... or
>convince me you need.
>
>> I don't see a way around this unless I rewrite the way mtk_drm_drv works?
>
>Why rewrite? You have all compatibles in place.
>
>>
>> Maybe if I declare a new compatible that is generic to all mediatek
>> dpi variants?
>
>You were asked to use fallback. Don't create some fake fallbacks. Use
>existing ones.
>
>> and have all the dts specify the node with both the generic dpi and
>> the specific compatible?
>>
>> dpi@xxx {
>> 	compatible = "mediatek,dpi", "mediatek,mt8195-dpi";
>
>I don't know what's this but certainly looks odd. Some wild-card
>compatible in front (not fallback) and none are documented.
>
>> 	...
>> }
>>
>> Then I can "collapse" all the dpi related nodes in mtk_drm_drv under
>> "mediatek,dpi" ?
>>
>> I guess would have to do the change for all other components that are needed in
>> mtk_drm_drv (mmsys, aal, ccor, color, dither, dsc, gamma, mutex...).
>>
>> That's the only trivial way I can think of implementing this with the
>> current status
>> of the mtk_drm stack.
>>
>> Do you have any other ideas in mind?
>
>Use fallback of compatible device. That's the common pattern.
>Everywhere, Mediatek as well.
>

I'm unsure about what a "fallback of compatible device" is.
But from what I can gather, you'd have me write the dts as:

dpi@xxx {
	compatible = "mediatek,mt8195-dpi", "mediatek,mt2701-dpi";
	...
}

so that the mtk_dpi driver will use the specific mt8195 dpi config and
the mtk_drm driver will fallback to mt2701 to find the compatible it needs.

Would you like me to use this pattern for all the other compatibles declared
in the mtk_ddp_comp_ids array in separate patches?

Thx,
Guillaume.

>Best regards,
>Krzysztof
>
