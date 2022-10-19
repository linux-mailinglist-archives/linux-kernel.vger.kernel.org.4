Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC4604C74
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiJSP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiJSP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:56:33 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE75FE916
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:54:17 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id bj12so40910326ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oCxur44GiGn0KEf47+NGc2flFZLTxOPMJcgB85rch6w=;
        b=Af1ORI7qLHGJw4ifz/2FBCp+Nq0eizmGhWVnbLOtKaMLO9xPtn7WgrxQFzTVHlGfI1
         2lFZJu+P2cn2W4CKzeUJnS3n2wUNZDghZrIxPpbENfO1w+DMF4ypDyyfQGvc9uuprFoe
         GBgp+bgwLUw6X0CUrZCNNCVIWXh2uD4Y7879s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCxur44GiGn0KEf47+NGc2flFZLTxOPMJcgB85rch6w=;
        b=3QYD77he9ctRjhB2rtpsggHwqTuj0bBemvkN3FG1uYaDfn/h3f4P0eCmgfe6UP3/8w
         Zuc7wUxkWfzTLOEl2vq3K/HspcRIBPW2K3mNKpagTMpm+Q+1hiWrtX+7G86fOXJ0mh9O
         A0JefdMAcEa0YniAQW/XoJoxQJAyiFPi1mTQj3PXHkJy2bjcVmtP1JqDUrfjWkjbgzAW
         8neOnrV6SxzvSMgu59w1z5g+sZdI5cZUvfQFv5EFmuMMuZaZhpsDU4lf15Lftc6x/uSX
         zkot2COuWB8WhlltN+Q3JOkJ41Y1VjzblohV3o4iJJ8AfT28q2UhJow3Jhd97lE9aS74
         YE9A==
X-Gm-Message-State: ACrzQf3ghoM/pvztmPHp3Wz1YoD46E/i1VDns8HnLu5cbSv48DY9J4SX
        FV1DgZzB6zG/9tnMe4KQW6IbGq1MjYkx59NS
X-Google-Smtp-Source: AMsMyM5ohWhDSnAJA0V5lznAjhbA3FQid7xMxNHYACQdaU7Bm2nlWY9ndVGWhOrpEX53JoUENS4dgg==
X-Received: by 2002:a17:907:8690:b0:791:9f83:6872 with SMTP id qa16-20020a170907869000b007919f836872mr6216302ejc.386.1666194530066;
        Wed, 19 Oct 2022 08:48:50 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id s25-20020a50ab19000000b004587f9d3ce8sm10767545edc.56.2022.10.19.08.48.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:48:48 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id e18so13206746wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:48:48 -0700 (PDT)
X-Received: by 2002:a05:600c:19c9:b0:3c2:7fff:a689 with SMTP id
 u9-20020a05600c19c900b003c27fffa689mr27767365wmq.85.1666194527713; Wed, 19
 Oct 2022 08:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221019001351.1630089-1-krzysztof.kozlowski@linaro.org> <20221019001351.1630089-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019001351.1630089-4-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Oct 2022 08:48:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsFbei4h_cwhJhReUi8Pk_C-qHu_8iDqfzf_e=C8QnXg@mail.gmail.com>
Message-ID: <CAD=FV=VsFbei4h_cwhJhReUi8Pk_C-qHu_8iDqfzf_e=C8QnXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sc7180: align TLMM pin
 configuration with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 18, 2022 at 5:14 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
>
> Merge subnodes named 'pinconf' and 'pinmux' into one entry, add function
> where missing (required by bindings for GPIOs) and reorganize overriding
> pins by boards.
>
> Split the SPI and UART configuration into separate nodes
> 1. SPI (MOSI, MISO, SCLK), SPI chip-select, SPI chip-select via GPIO,
> 2. UART per each pin: TX, RX and optional CTS/RTS.
>
> This allows each board to customize them easily without adding any new
> nodes.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes since v2:
> 1. Rebase on reverted SPI CS glitch patch.
>
> Changes since v1:
> 1. Split SPI and UART nodes, after discussion with Doug.
>
> Not tested on hardware.
>
> Cc: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts       | 236 +++----
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  36 +-
>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  47 +-
>  .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  16 +-
>  .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   |   8 +-
>  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  16 +-
>  .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  25 +-
>  .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi |  72 +-
>  .../qcom/sc7180-trogdor-parade-ps8640.dtsi    |  32 +-
>  .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |   8 +-
>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  14 +-
>  .../qcom/sc7180-trogdor-quackingstick.dtsi    |  56 +-
>  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |   8 +-
>  .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi |  16 +-
>  .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  25 +-
>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  72 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 629 +++++++-----------
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 597 +++++++++--------
>  18 files changed, 776 insertions(+), 1137 deletions(-)

You probably should send a v4 since this now conflicts with commit
c24c9d53e001 ("arm64: dts: qcom: correct white-space before {"), which
has landed.

In any case, this looks nice to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

FWIW I put this on a sc7180-trogdor-coachz and the device booted up to
the browser. I didn't do massive amounts of tests, but I'm OK with:

Tested-by: Douglas Anderson <dianders@chromium.org>
