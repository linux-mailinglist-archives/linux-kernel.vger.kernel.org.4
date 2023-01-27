Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FCF67EBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjA0RCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjA0RCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:02:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2509D80152
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:02:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so3959732wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74RYKXADYiWuMtd1iDXR46UqUxe2kZuhY4va9NHmRgw=;
        b=sftt/w4VLfphRnNORfESsr3LME9gLjhtV6Na3+8e3+UcB+ePTF8lVHMMrTJlROLAMx
         BTzeq+4dIfLiK0XzuQGpBAx0/C3Y7kjugNFmH9ihf8bwaHJn37MKD7j0/Gg49d8aJAEi
         PlBaxu2GPd2lnn+NQjhqFUyHCFJMvzP0dCRyWbWaGmutrbGa/tlxTDl++SwiwevX9x75
         Eoy9mh3SBsUNHyp5Uq9Yf/aIeLu2pVdgAExiN0de44JVkAP7uj5nt4pWSk788i42rSxL
         apV8ByJ1HpEClYySlJut+SbiATLnHNDZr36zIBieB//l6VE6aV9fBMPT3Gi+rl5prxOy
         nrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74RYKXADYiWuMtd1iDXR46UqUxe2kZuhY4va9NHmRgw=;
        b=p9G/tGMjGm7iLuYaozDIEAxvauG5DOKQDgvOX5AjliV22n+f/OHpQwSTWs3CW35ZfW
         s8m9TgEp05T8Zfm6t0SPdj6ASZYXNGxuw2N7vl7HFsbU+Rsqphx7EDv7QaAEn577Rxcw
         HG9VfvCsLY2xR249sJreFN9Wwfm6vOu8alzOS7rdPX8hVN5E/rIdTZeBS7GGz+TIzDfz
         pE3rv50DW6I7b24ruqmJCPxr0tICn04OFv5K7v6S9kEcnlWddf7tqeZU7QmrWI9g1+Dv
         EOAyDL9tMcjuOHZXIxAMNCmQcwrXEZ2Iy5iLo3u1GagCEHNzIGenHrzUjIcXajjwL5a2
         9zDw==
X-Gm-Message-State: AFqh2kpBz9MVoFVlcurhDNtrSUpRlC1C+6bNkgf9Kor5rtylPSuJenl/
        VOFu6McCOxlyFf3kcfdPplwiSw==
X-Google-Smtp-Source: AMrXdXsL1Hr0yZEA0/ZyJzgSBTvzReIJkdTSMyNhsF6vOWDcuTJ7XyKdsh1A5LroidB30T6W4Q+mHA==
X-Received: by 2002:a05:600c:b54:b0:3c6:e60f:3f6f with SMTP id k20-20020a05600c0b5400b003c6e60f3f6fmr40944390wmr.38.1674838949712;
        Fri, 27 Jan 2023 09:02:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c12ca00b003d9df9e59c4sm7925935wmd.37.2023.01.27.09.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:02:28 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230127142221.3718184-1-christianshewitt@gmail.com>
References: <20230127142221.3718184-1-christianshewitt@gmail.com>
Subject: Re: [PATCH v2 0/5] arm64: dts: meson: fix BPI-M5 and add
 BPI-M2-PRO
Message-Id: <167483894832.2238401.307745303107295003.b4-ty@linaro.org>
Date:   Fri, 27 Jan 2023 18:02:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 27 Jan 2023 14:22:16 +0000, Christian Hewitt wrote:
> The first patch in this series fixes an SD card (re)boot issue on the
> BPI-M5. The second removes a redundant status from the sound node so
> we don't carry it forward when subsequent patches convert the (fixed)
> dts into a common dtsi, then add support for BPI-M2-PRO which is based
> on the BPI-M5 board design.
> 
> Changes from v1:
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm64-dt)

[1/5] arm64: dts: meson: bananapi-m5: switch VDDIO_C pin to OPEN_DRAIN
      https://git.kernel.org/amlogic/c/856968e066bd77b113965f1a355ec7401edff65f
[2/5] arm64: dts: meson: bananapi-m5: remove redundant status from sound node
      https://git.kernel.org/amlogic/c/31752ffeece8b8dc2cf2be36614c8a4e8e8dcf57
[3/5] arm64: dts: meson: bananapi-m5: convert dts to dtsi
      https://git.kernel.org/amlogic/c/ca8dac3a019ac190c39365c99a632c0748c72f58
[4/5] dt-bindings: arm: amlogic: add support for BananaPi M2-Pro
      https://git.kernel.org/amlogic/c/bd2529aa41ccb93c2ffcb045ac97121711277fe0
[5/5] arm64: dts: meson: add support for BananaPi M2-Pro
      https://git.kernel.org/amlogic/c/5bcfbee7d58d8512493b03b1d1622fe138d0aaee

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

