Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A79163FD48
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiLBAuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiLBAuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:50:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40187BC5A5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:50:05 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id td2so8187562ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7vv0AAcoPBw8lAAEAG1SUbk7k5AR+sWuTiUY/+9wW8E=;
        b=XABptQ1cyK5zAoublcuBrzvzHSNPn16lIrlJcEqRnP+m+ysoIAUyPru77RsPjf2UMF
         fMG6NQ7eKRkcs5zlYDFv8UuNGmFf3xUC3ZHwbjhmB+5u0AB61KEdHEoQQY+fVp0A+bS4
         tV71XbSKazWh5SOHR471oGaqbuS9Izn97lnwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vv0AAcoPBw8lAAEAG1SUbk7k5AR+sWuTiUY/+9wW8E=;
        b=GfjZW8JPV6lS2gn0e27FzVSdYjHZwRjhbZyMgj9pZOdAPQTVtpI7gmJDv5iVhiKB4t
         +HFSUgwItQg9g+fMzJlNFHqOeKFnkdHRymFa0uBtihYesAMGNVwMNWXOP0x//oeuOZgQ
         jOq8qZzJ90Mj68N41L06T4gozowv5QKh+OqYkHBSjvIo57a04Zn4sUBzHUNQAdNDrp7Y
         lLkEdOIb7BVmttTtrcCGyCBDuRGw3UDTNZJ+TbwwWxwGRMMLDmd9RsZCNqd6M7WBcnU0
         PrgHj8u8mHQmSu6tczlxgyOjR9GzvvCQZtpws0jz76y+ffTkYtVKu9dyrvJ8hjmn+Lu1
         GdwA==
X-Gm-Message-State: ANoB5pk8mn0BiVmVYoEBs/dz+GWTmmNDJOt9tDSjra7FjH2L0AdEF56G
        36n7gclhhybhuyJZ88ph33aLqEqPgWUv+HgQ
X-Google-Smtp-Source: AA0mqf6sf2MW/GfnL+i77LkhubRDwzkmvvo91ErMp9MBZHPVrVYxS+9mPwMNEMzUWiLXKha2A8q4QA==
X-Received: by 2002:a17:906:a1d6:b0:7c0:b284:13f6 with SMTP id bx22-20020a170906a1d600b007c0b28413f6mr4331554ejb.149.1669942203634;
        Thu, 01 Dec 2022 16:50:03 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id o17-20020a170906769100b00782fbb7f5f7sm2359015ejm.113.2022.12.01.16.50.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 16:50:02 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id q7so5550585wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:50:02 -0800 (PST)
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id
 c12-20020adffb4c000000b002365270735emr31203152wrs.659.1669942201820; Thu, 01
 Dec 2022 16:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20221118164201.321147-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118164201.321147-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Dec 2022 16:49:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vo9zbsjgYEn0eBkC8eKRceg6v4u1g=w6nSYHNctFQWxg@mail.gmail.com>
Message-ID: <CAD=FV=Vo9zbsjgYEn0eBkC8eKRceg6v4u1g=w6nSYHNctFQWxg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 1/2] arm64: dts: qcom: sdm845-db845c: drop unneeded qup_spi0_default
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Nov 18, 2022 at 8:42 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The qup_spi0_default pin override is exactly the same as one already in
> sdm845.dtsi.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Doug Anderson <dianders@chromium.org>
>
> Changes since v1:
> 1. New patch.
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 02dcf75c0745..56a7afb697ed 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -1274,11 +1274,3 @@ ov7251_ep: endpoint {
>                 };
>         };
>  };
> -
> -/* PINCTRL - additions to nodes defined in sdm845.dtsi */
> -&qup_spi0_default {
> -       config {
> -               drive-strength = <6>;
> -               bias-disable;
> -       };
> -};

I guess it's more of a question for what Bjorn thinks, but I view the
fact that the drive-strength / bias are in the dtsi file to begin with
as more as a bug in commit 8f6e20adaaf3 ("arm64: dts: qcom: sdm845:
enable dma for spi"), which is where these properties were introduced
to sdm845.dtsi.

The historical guidance from Bjorn was that things like
"drive-strength" and "bias" didn't belong in the SoC dtsi file. Later
we came to an agreement that it could be OK to put drive-strength in
the SoC dtsi file but that bias was still problematic because it meant
ugly "/delete-property/" stuff in the board dtsi files [1].

[1] https://lore.kernel.org/r/YnSQvyAN3v69an8k@ripper
