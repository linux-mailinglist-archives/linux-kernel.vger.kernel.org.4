Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E9364D16F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLNUpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:45:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35EEDF92
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:45:48 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gh17so47504485ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ffmonq0jONZ5zQpJsMWvuzEqJVc48PVYRBBpDxiBFE8=;
        b=J21O/4LrOSaQND9lM5pYxQbxMkBGx3wIYOJIVakgCN5iuimwusKpAJN/yjlAbwqUEj
         fmSGijwMCZ3ljnt8COaOXgfF/rh+yUFaroA6YrJVCh52+CML2gdfyZBYYWUeE7xV7pCm
         m9+pDchgrLfn+A++E9tMcJG4SzRMLQA7lNQG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ffmonq0jONZ5zQpJsMWvuzEqJVc48PVYRBBpDxiBFE8=;
        b=btS00xPqqTivOpMeKJJ7faWpDL/3efvgkpc8STDkdwNTcARHOfFCcEZUlROxc/Mt8T
         QXTTtbQiB7ycwnnIF/qvlLNiH0f7U8wzEnPEHYgkBNkjaOMWiuvO4xTmGZrsqL2vAzcD
         lafUOE3Zrfx42fCEPWRKo93hyleHuU7vybaiU/yj1xbOrh6vS6ASG45bgbRPcupqKZ4v
         /eXnQ7kJOsMGF2Yepf5VkE1f88DZO/C1bGEGT33TjZ/ZC1IQI+ca9zlukLrieyIslaOy
         bRdUl4NUjzw8BDTf3Mdx4gNBZTSUcbCDr3WPUPn8ipLIxWhD2K9TsUj68jh8E5h0lt01
         uflw==
X-Gm-Message-State: ANoB5pm1Ch3zChzttoFuKRWk/2NgkybmlNP4l4RzGbspAwj8r8YOcXK+
        Glsaioai9JGSwtrPXhKGyerp+C+UdtlrKdpFZQ4=
X-Google-Smtp-Source: AA0mqf5TeWz/YTiNDVbed6zcBEnBmTsGFRYvnlPMxlsk0pVEgPHqx7WFfafSbB0xILL9K50TUbsxAg==
X-Received: by 2002:a17:906:c287:b0:7c0:daa3:b4ab with SMTP id r7-20020a170906c28700b007c0daa3b4abmr21190546ejz.40.1671050747138;
        Wed, 14 Dec 2022 12:45:47 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id y4-20020a170906470400b007bd7178d311sm6276367ejq.51.2022.12.14.12.45.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 12:45:46 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id y16so1068876wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:45:45 -0800 (PST)
X-Received: by 2002:a5d:4943:0:b0:242:3ca3:b7bd with SMTP id
 r3-20020a5d4943000000b002423ca3b7bdmr18737336wrs.583.1671050745735; Wed, 14
 Dec 2022 12:45:45 -0800 (PST)
MIME-Version: 1.0
References: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
 <20221214114706.2.I1a0c709f8ec86cc5b38f0fe9f9b26694b1eb69d6@changeid>
In-Reply-To: <20221214114706.2.I1a0c709f8ec86cc5b38f0fe9f9b26694b1eb69d6@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Dec 2022 12:45:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X1XMi6rMN7FVf7iWkYbs8rvYF09ebbaA9gb+SkMWHPRg@mail.gmail.com>
Message-ID: <CAD=FV=X1XMi6rMN7FVf7iWkYbs8rvYF09ebbaA9gb+SkMWHPRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add DT for
 sc7280-herobrine-zombie with NVMe
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Bob Moragues <moragues@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>, Harvey <hunge@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 13, 2022 at 7:48 PM Owen Yang <ecs.taipeikernel@gmail.com> wrote:
>
> Add DT for sc7280-herobrine-zombie with NVMe
>
> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile               |  2 ++
>  .../dts/qcom/sc7280-herobrine-nvme-sku.dtsi     | 14 ++++++++++++++
>  .../qcom/sc7280-herobrine-zombie-nvme-lte.dts   | 17 +++++++++++++++++
>  .../dts/qcom/sc7280-herobrine-zombie-nvme.dts   | 17 +++++++++++++++++
>  .../boot/dts/qcom/sc7280-herobrine-zombie.dtsi  | 10 ----------
>  5 files changed, 50 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-nvme-sku.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dts

It's like sunshine on a cloudy day!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
