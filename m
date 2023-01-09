Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D80663360
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjAIVoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbjAIVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:43:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF5F6E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:43:15 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw16so11775784ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YjLtLtXLOnSnL793Sq/I8VFYvndSrKg7SG1Bksti8BE=;
        b=GjBZA38WlbpKU4L56iqHJzclJQFTgfmVQK330/hyArEhGnLfP9/JGYhQtadS3f+f1Z
         GP1oE7x+qIsfZckFtdQQlkYn/L3H4mPxaBODAdQR5WcpwQ26+Y8ZOZBFy4WOkoVLftjf
         EmbiwXjqUdY3zgOKRcLV4j7/H+r3OkSiAv2uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjLtLtXLOnSnL793Sq/I8VFYvndSrKg7SG1Bksti8BE=;
        b=K+oUtqatCIiY99oUnSqYTxKUE+H0HQR78zI1/+7pJ1Q167JB+UBV7eUvWXS0hCk14X
         9AyffCGSJtSNp7kh67kZKKE5suAcHFj3WCEorWw7DwBmoPqgqcIb2BvpEmaHROmjXx8E
         uCT6IdEW5dVrGX7cW1jfIYNU9oIVmStNZ1usJvsP39tAIoNFvwdbexwnLEGj04DEaEmW
         pEHtN+5bJAB4gdhJ1y2dnPLVo4PaSHN+cWsMiTdCcU/U5kinDLqwumgiYFBkycTdQRns
         CeL8MXmlehlecPoZuSTAjDThdbu+ubd2je2pJfvh/kUBbXF2L3h/X6qCKaaqRYu8AQSY
         w0jw==
X-Gm-Message-State: AFqh2kqDNtQzAGYS5ZyCHOsLM28uHbGQXcaw2A8kPAq3GQ/DsGGU0L/O
        kav29+yENcqLu52jPL9oWgyw4r2YmhQtgoT4
X-Google-Smtp-Source: AMrXdXtX5xBk0asfaVou9AIo/84R23e8w5fGkxXPslPORlE7ycksihtMMT7xUxvUmXq03s4/I7h4pA==
X-Received: by 2002:a17:907:6e16:b0:7c0:9f6f:6d8 with SMTP id sd22-20020a1709076e1600b007c09f6f06d8mr74162861ejc.2.1673300593995;
        Mon, 09 Jan 2023 13:43:13 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id bk5-20020a170906b0c500b00852e0bbed1dsm508412ejb.17.2023.01.09.13.43.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:43:11 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so8255454wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:43:11 -0800 (PST)
X-Received: by 2002:a05:600c:2141:b0:3d3:494f:a4ad with SMTP id
 v1-20020a05600c214100b003d3494fa4admr5841087wml.151.1673300590704; Mon, 09
 Jan 2023 13:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20221216112918.1243-1-quic_rjendra@quicinc.com>
 <Y5x+WEwTtpoV0gaR@google.com> <fd23e295-fea0-1b0a-752c-3cce26b57346@quicinc.com>
 <Y6HHCrl0q5BhrHOY@google.com> <e269300d-539e-9eb8-8b3c-d309f3abca1b@quicinc.com>
 <bbc3c257-0a49-4c80-4586-c179c8997b50@linaro.org> <CAD=FV=X3DyMrEWESV2cWvqg_TQYnj+VGFBQodAp+gfbhBz6X3Q@mail.gmail.com>
 <9f6bd192-2a42-0a23-0032-df8b01921bdc@linaro.org>
In-Reply-To: <9f6bd192-2a42-0a23-0032-df8b01921bdc@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Jan 2023 13:42:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6KhJR+9q49=T3-aYppukRNmLrgvhaxP_ZtLP=VgSaDA@mail.gmail.com>
Message-ID: <CAD=FV=U6KhJR+9q49=T3-aYppukRNmLrgvhaxP_ZtLP=VgSaDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     andersson@kernel.org, Rajendra Nayak <quic_rjendra@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 9, 2023 at 1:36 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 09/01/2023 23:00, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Dec 20, 2022 at 9:12 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >> On 20/12/2022 18:20, Rajendra Nayak wrote:
> >>>
> >>>
> >>> On 12/20/2022 8:00 PM, Matthias Kaehlcke wrote:
> >>>> On Tue, Dec 20, 2022 at 10:30:32AM +0530, Rajendra Nayak wrote:
> >>>>>
> >>>>> On 12/16/2022 7:49 PM, Matthias Kaehlcke wrote:
> >>>>>> On Fri, Dec 16, 2022 at 04:59:17PM +0530, Rajendra Nayak wrote:
> >>>>>>> Add compatibles for the Pro SKU of the sc7280 CRD boards
> >>>>>>> which come with a Pro variant of the qcard.
> >>>>>>> The Pro qcard variant has smps9 from pm8350c ganged up with
> >>>>>>> smps7 and smps8.
> >>>>>>>
> >>>>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> >>>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> >>>>>>> ---
> >>>>>>> v4 changes:
> >>>>>>> Added the zoglin-sku1536 compatible along with hoglin-sku1536.
> >>>>>>> Zoglin is same as the Hoglin variant, with the SPI Flash reduced
> >>>>>>> from 64MB to 8MB
> >>>>>>>
> >>>>>>>     Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
> >>>>>>>     1 file changed, 6 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml
> >>>>>>> b/Documentation/devicetree/bindings/arm/qcom.yaml
> >>>>>>> index 1b5ac6b02bc5..07771d4c91bd 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >>>>>>> @@ -558,6 +558,12 @@ properties:
> >>>>>>>               - const: google,hoglin
> >>>>>>>               - const: qcom,sc7280
> >>>>>>> +      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro
> >>>>>>> platform (newest rev)
> >>>>>>> +        items:
> >>>>>>> +          - const: google,zoglin-sku1536
> >>>>>>> +          - const: google,hoglin-sku1536
> >>>>>>
> >>>>>> Is there actually such a thing as a 'hoglin-sku1536', i.e. the Pro
> >>>>>> qcard
> >>>>>> with 64MB of SPI flash, or do they all have 8MB of flash?
> >>>>>
> >>>>> The SPI flash is on the CRD mother-board and not on the qcards, so if
> >>>>> you replace
> >>>>> the qcards on the CRDs with 64MB flash you would need the
> >>>>> hoglin-sku1536 to
> >>>>> boot on those.
> >>>>
> >>>> With such a configuration how does the bootloader know it should pass
> >>>> the kernel
> >>>> the device tree for 'hoglin-sku1536' (pro) and not the non-pro
> >>>> variant? IIUC the
> >>>> device tree is selected based on pin strappings on the mother-board,
> >>>> not the
> >>>> qcard.
> >>>
> >>> The device tree is selected based on the pin strappings _and_ additional
> >>> logic
> >>> to dynamically identify modem/non-modem(wifi) as well as pro/non-pro
> >>> SKUs which
> >>> was added in the bootloaders.
> >>
> >> Just to clarify things, when you mention pro SKU, is it a separate SoC
> >> revision (like sc7280-pro vs bare sc7280), or is it a CRD revision (CRD
> >> Pro vs bare CRD)?
> >
> > I guess Rajendra never responded, but since I know the answer: it's a
> > different SoC revision. ...but the SoC in this case is on a daughter
> > card, so you could remove the daughter card containing the SoC and put
> > a new daughtercard on. That would have the effect of making an old CRD
> > revision have the new Pro SKU SoC.
>
> So, this is a new SoC. Is it 100% compatible with the sc7280? In other
> words: does it require any additional customizations (in OPP tables, in
> frequences, speed bins, etc)?

If I understand correctly, the OPP customizations have been accounted
for since the beginning. I believe that the GPU operating table
already has some fairly high operating points. Maybe commit
3bfef00d7671 ("arm64: dts: qcom: sc7280: Support gpu speedbin") was
for pro? Similarly, the CPU operating table also has some fairly high
operating points (probably for PRO?) and I think the higher points are
dynamically disabled for CPUs that don't support them. That's how it
was on sc7180, in any case.

...I will say it's not 100% compatible, though. Patch #2 in this
series deletes "vreg_s9c_0p676" on pro SKUs. As far as I know, that's
the only needed change, though.

-Doug
