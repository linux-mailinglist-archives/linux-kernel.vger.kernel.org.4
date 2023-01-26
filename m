Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE8C67C5EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjAZIfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbjAZIe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:34:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD76C11E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3730748wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9Aqz9ow0096NYVpMVct4LsgcvHoqSMpUjeGW88ptQc=;
        b=vHPTMynsbnrZC9C3R+6zY5NRfqAAcSsw2x5wvGFFqW5V/vJAWxG6YRjJxYnfqDHh1G
         wqXLMz15+Z5PE1OsIuAINaxSivTkC3bv02/vzVoHj3RgGaB6uHTbHtM9g7gHXMaU+fQE
         qHXzi6KLYhBH1Dtnb/8yFhgaXUQzH+us19ZVZzfmA4EA93yZTbmmnjls7QhqaEJ6JJ2N
         AKXadY0YvPzbEoOn7hp9fdFi0F/ukl4BGpd4IBX6AMDZ+xbuU9BZ/VrcDouL7tVapNGw
         IeiF9Nx5j2iiVe1PGujtdCJ/aB05Ryc5/Nw7ja/HqthGCIGedXpHTji8658+h8cI3xkm
         RnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9Aqz9ow0096NYVpMVct4LsgcvHoqSMpUjeGW88ptQc=;
        b=UzdcricqoLzvxCpbKkEfBuBw5THE5/oA6xmzN3rBDcH1DtRfQWcAnPqsU31A/piuqZ
         5tuqoFgRLNfNf61C0WO0Ix1xvONkoCsxrT+ywHAHVESNidC3ppy5RVq1r0Cf3IaCu0Jc
         MrOAHTZlMqdsA52YM55SgQ+S3ZW9aOtZYnIuSRkPVHffBLVVGA0SpHoKkizBWR5HyrLx
         kxyJjju3JMnt9nxrmERypclmdSeuEXlXowAPEBba+G657hKylgkyRpcBvFZzaJ61ZoKd
         AiiGrR/v7VKsnJJ5aokoWtisCZu8Jr6F9YCV5oBRzCs/lSQUJ8MV2oUYnzoqRn4f08Xc
         Vwdw==
X-Gm-Message-State: AFqh2ko8bFtLNTC1TeKfDeTw8e1dRnMDwBcY+a2Hd0NT4/SYT0DdsjTy
        AneniKfBoRQPCOvgDJCbB34X+6vokqEhIwenHsw=
X-Google-Smtp-Source: AMrXdXtdHWb1Hu57UY2Fx3spWKuK8REEt5FDqslm9OxT4gnSFLkU+EulXG8ozOVLCNMOe1Bz0s4SAw==
X-Received: by 2002:a05:600c:4347:b0:3da:fc2c:cda8 with SMTP id r7-20020a05600c434700b003dafc2ccda8mr35154325wme.6.1674722040962;
        Thu, 26 Jan 2023 00:34:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c328a00b003d9a86a13bfsm757709wmp.28.2023.01.26.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 00:34:00 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230123065504.2669769-1-christianshewitt@gmail.com>
References: <20230123065504.2669769-1-christianshewitt@gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: meson: add WiFi to P212 and cleanup
 VIM1
Message-Id: <167472204014.456104.18412997475456067152.b4-ty@linaro.org>
Date:   Thu, 26 Jan 2023 09:34:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 23 Jan 2023 06:55:01 +0000, Christian Hewitt wrote:
> This small series adds WiFi support to the P212 dtsi then removes the
> corresponding node from the VIM1 dts (as it's now inherited). Also
> move the pwm_ef node in the dtsi to alpha-sort correctly.
> 
> Christian Hewitt (3):
>   arm64: dts: meson: add Broadcom WiFi to P212 dtsi
>   arm64: dts: meson: move pwm_ef node in P212 dtsi
>   arm64: dts: meson: remove WiFi/BT nodes from Khadas VIM1
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm64-dt)

[1/3] arm64: dts: meson: add Broadcom WiFi to P212 dtsi
      https://git.kernel.org/amlogic/c/ac714d0925b4fae6a2a8c03da743a91d559f2b5c
[2/3] arm64: dts: meson: move pwm_ef node in P212 dtsi
      https://git.kernel.org/amlogic/c/81351d2f0b006302a72310c95203a767cf68631e
[3/3] arm64: dts: meson: remove WiFi/BT nodes from Khadas VIM1
      https://git.kernel.org/amlogic/c/3384645fb6cf31542650b89ecabe1fb04d0662fd

These changes has been applied on the intermediate git tree [1].

The v6.3/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

