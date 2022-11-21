Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3364F631ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKUKwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKUKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:52:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52A9BC22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:52:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so8711662wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DwFFWAbB39pdzGdbl/1ro70K08wbqiEN02fL5my0ng=;
        b=nSAKPp9iT1tfGIkSlXmfAmD6MPcXsYYSG4wspAw3llD1/Df8G+BuHDkMTvqHL+Ou7k
         BdMNJojv0ZkWbXFCsFg7d7OA4/6iPdyYm4WKe5lNtl4U7m6vEQm08L9Ms3ZmKPXqtpdx
         I64b3oIqfZid2IGanRVuzxL3U/FfDQTek317Vcp9WljqMqy5DUAl7gdwh3PLfjHEUhkN
         tJFIn9n/MGoRjCqHLTHIp/zAMjLbAOxMeYKQVxiOlibovRknkPM+XVoJMfdjpzzAXwlc
         ud5Srn6WG1kuGnTHesZ1sV07MFHQ2uF1hXZbLaVPxmIq1lsmnqkr33HLgfephdLSU0j0
         Iz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DwFFWAbB39pdzGdbl/1ro70K08wbqiEN02fL5my0ng=;
        b=xtBF2aWwUNuBsRbSLg0q96waUC+NthPQHdCOW/asJ61GtAcG6KSRN4gm2ZCZb32n0b
         DqpaUc14Mq2sJBtFInNT0vf/k/IdPGV2+YMLX+2jcwiThWNLD4wiedRD7h0+IzL9LMU9
         /szUuG5Aw6R7+t3Ow92hHQCX6Klv9KBrox7K4ibdM3u/+skIQ3Q+9GGpTS94DzIHxAG2
         RdB3m5Iy3hR46nsH3/aDvj49DqoqvxbOJb2tvJbl9X3VGk5u0tEhR1yL6AUVmwinCZSd
         +zkaWtavQJ2REb9Aum3N4eUdP96ycU0WJGcvLwLUTD86AixJlrA193zKZ3Gb2o3AnMJ3
         lF+w==
X-Gm-Message-State: ANoB5pmIC34518wfM6EmuD3ubtY4WR/mtxF3Fv8J8Hak2SEPFzf71szZ
        IUIop3bI8F9DGJIMmh/ssqIg42qJZDf+cw==
X-Google-Smtp-Source: AA0mqf5QSJ7OtroHLmnJdUzSWQwzpQbp01lD9Fe8uHseFbRLgx9H+XiLEeh83Dx4wJW6i6KniCCkYw==
X-Received: by 2002:a1c:7409:0:b0:3cf:713a:c947 with SMTP id p9-20020a1c7409000000b003cf713ac947mr4678415wmc.40.1669027962284;
        Mon, 21 Nov 2022 02:52:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b003b3365b38f9sm14550303wms.10.2022.11.21.02.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:52:41 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh@kernel.org>
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v2-0-a3df1e09b0af@linaro.org>
References: <20221031-b4-odroid-go-ultra-initial-v2-0-a3df1e09b0af@linaro.org>
Subject: Re: [PATCH v2 0/2] arm64: amlogic: add initial Odroid Go Ultra DTS
Message-Id: <166902796132.3866590.17335821749451892538.b4-ty@linaro.org>
Date:   Mon, 21 Nov 2022 11:52:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 18 Nov 2022 16:50:04 +0100, Neil Armstrong wrote:
> This adds initial support for the Hardkernel Odroid Go Ultra.
> 
> The Odroid Go Ultra is a portable gaming device with the following
> characteristics:
> - Amlogic S922X SoC
> - RK817 & RK818 PMICs
> - 2GiB LPDDR4
> - On board 16GiB eMMC
> - Micro SD Card slot
> - 5inch 854×480 MIPI-DSI TFT LCD
> - Earphone stereo jack, 0.5Watt 8Ω Mono speaker
> - Li-Polymer 3.7V/4000mAh Battery
> - USB-A 2.0 Host Connector
> - x16 GPIO Input Buttons
> - 2x ADC Analog Joysticks
> - USB-C Port for USB2 Device and Charging
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.2/arm64-dt)

[1/2] dt-bindings: amlogic: document Odroid Go Ultra compatible
      https://git.kernel.org/amlogic/c/66af218f8669a262b1bf89ba80f2acf1a3be429c
[2/2] arm64: dts: amlogic: add initial Odroid Go Ultra DTS
      https://git.kernel.org/amlogic/c/62e73f000696cc41cfd237a1ad90b001ad0f76c6

These changes has been applied on the intermediate git tree [1].

The v6.2/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
