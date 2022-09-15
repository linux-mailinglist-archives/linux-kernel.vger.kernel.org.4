Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED85B9783
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIOJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIOJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:34:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A597529
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:34:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e16so29904817wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nx/BhNRVvudK8AcmKzKEeABUr5hW6bgb4H8HtATz2WQ=;
        b=anPZy6RR5haz9Hh899sAj1/aToTK2d8Fu7rSqVKSWtwJ1R40ymJpj00ARQHKEjDaBX
         P2TBldrxNF3yZTpsA14Lu0bosAM04VyKBblBBV6VppGzZdV5MOFzqrMx/3+0vhahlfTs
         jEEGe3D8sM/Pa0z7OcRoLr74jLfcKbwv6XjAVRXcU/6qHcZf9SIAZm3mNgwoDvkmgnrU
         Zx6mGUbEnAG7iSjnm6T69Ma0jszGLBUEWO38F7NsdZdAJiEYOkBrwVyQs9hdAW8Hl4Ze
         4dQVZGo+yKfO9lvKI09cWKdahSCKn8GChwgdNK/dfk3Bi5TsUO001xU7zvzBskeM+rvF
         Dp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nx/BhNRVvudK8AcmKzKEeABUr5hW6bgb4H8HtATz2WQ=;
        b=dSfvkxJBrZSI38QHC0LK78KKJ3ZO47v6ujDWaGrdKSScMV/i/jxzGfq4foLL/Kh6rj
         xxH1gqkJ5GtgCxTQX9qX3nOYs6OIrlBEtIkaQ74bqkq+zZ1taupAsBZoRCccKMb6TlKv
         oWt70lwOAIyh4yzGNriYSGwHU7i6yQh5ZsJHqfbovJ0l2EpLHcpj1w+rJWI7y2TMHbeL
         GggaTNATKtB+qqv+3dVEqRtBvw41o0EYPFjrkpjqKr8bet1IZ+UseptDH1kSCdoU0IgD
         ODAh7r9ugtIAitRmBKeU3tOS/aJp+4LUJNRZiUzVrWCCI8UjIuGg1NOmfHJk974B9xNl
         ifEA==
X-Gm-Message-State: ACgBeo2S/OD3ShXn5tJQ0ZLRpcqADWoHIQvJcX8GdAL21k0pckOlFeFj
        nf5FbsEDzrs5TDr4SF4qI2VDyw==
X-Google-Smtp-Source: AA6agR5klBkZDS5PPlrsrMthFDbg2IRjfgTscq/lu3jeVteIuoFZcP2H2deWMucrrK89u9SZcvzzNQ==
X-Received: by 2002:a5d:6190:0:b0:228:6972:fd14 with SMTP id j16-20020a5d6190000000b002286972fd14mr24575588wru.114.1663234448802;
        Thu, 15 Sep 2022 02:34:08 -0700 (PDT)
Received: from krzk-bin ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id d13-20020adff2cd000000b00228dcf471e8sm2080450wrp.56.2022.09.15.02.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:34:08 -0700 (PDT)
Date:   Thu, 15 Sep 2022 10:34:06 +0100
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        James Smart <jsmart2021@gmail.com>,
        Andy Gross <agross@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Christian Brauner <brauner@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Justin Tee <justin.tee@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Marc Herbert <marc.herbert@intel.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/5] dt-bindings: arm: msm: Rework kpss-gcc driver
 Documentation to yaml
Message-ID: <20220915093406.lwss7frqqidor357@krzk-bin>
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
 <20220914142256.28775-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220914142256.28775-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 16:22:54 +0200, Christian Marangi wrote:
> Rework kpss-gcc driver Documentation to yaml Documentation.
> The current kpss-gcc Documentation have major problems and can't be
> converted directly. Introduce various changes to the original
> Documentation.
> 
> Add #clock-cells additional binding as this clock outputs a static clk
> named acpu_l2_aux with supported compatible.
> Only some compatible require and outputs a clock, for the others, set
> only the reg as a required binding to correctly export the kpss-gcc
> registers. As the reg is shared also add the required syscon compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


clock-controller@2011000: clock-names: False schema does not allow ['pll8_vote', 'pxo']
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

clock-controller@2011000: 'clock-output-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

clock-controller@2011000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960', 'qcom,kpss-gcc-msm8660', 'qcom,kpss-gcc-mdm9615']
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: compatible: ['qcom,kpss-gcc', 'syscon'] is too short
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2082000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960', 'qcom,kpss-gcc-msm8660', 'qcom,kpss-gcc-mdm9615']
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: compatible: ['qcom,kpss-gcc', 'syscon'] is too short
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb
