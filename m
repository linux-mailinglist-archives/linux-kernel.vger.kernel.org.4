Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203476AB879
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCFIiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCFIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:38:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9945C7DB9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:38:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h14so7918684wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091884;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yScVezbYDWz1/PWiaNDGxXrxcWymv3H9xhefZxRIETg=;
        b=rCHD0Qe9siBIsahEHG0UCvqKu6ETf/q9a+33Gnl6jehVinsrovgwnQBADb2uqsDU3f
         vKKRMkYXe9UarHSQ8MBmd3/MOhhBwnL3d65taEkJAukGSCne2n9DhN+UKhORTbe9qiHJ
         rhBh88kEHhmg2/g6wjyj51kfc0hq+KZGJH7zvY7VYSJptxYfnq7kVP8/BDd7OO7hmqes
         ZTp5LMZ5KSN6AdqaOqlEURRV8b17MVPWqHjCqrnYrMI9/y/sX+QALl7uBo/RKCSfdLL5
         iT71Cm5yC8RH2j6AY+VFvEtwYklgtPJ0xB2M5CSMkTiS6hw+ecKTQ2FgMsciGDqG6ZVF
         stig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091884;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yScVezbYDWz1/PWiaNDGxXrxcWymv3H9xhefZxRIETg=;
        b=E5FzjzfLnpr28vW9IfUBhyfXgb0xt6TT5rIThyO4nkdcLWEZ40yLlaIxHPidO0zTJw
         HpBsuYBk8PbAoQY2LCmkqtCwQ3t9lc1WtXA7KDSflOSUitmkm1VVdYLi9zoeNTnHEUjd
         8tBKG4/OW/w9Y2Rzq0hWtUXKscRZBPxSinkswvx0DuHrWNZ0vGrGXojfskCwMwji6lxS
         a5pOGv25drDXKWsqGdGosnCp8CDbH1+jKSTj7nuqkBM7yoo5W7rMTVdbTwKKkIgLHCO0
         DkBgDJTAU+AFljJDUr7VJqrTg4XzUQVSxK3dWU9pz8xQ95HjR5PuN8K9KbDDIBfhlLg/
         6gnA==
X-Gm-Message-State: AO0yUKV8x1KGkOEAaEotQ8vENQ/Irq7wgmsVKAjisouqf3T2wxpIyj0W
        fg0O6dXgRrAnQGuMT+sXgjQcnA==
X-Google-Smtp-Source: AK7set8vfhN1fgMLRWrhruNGd8B/tShsgSyB3bFMD1pOorhvfnF83jaWjT0VckULYL2rLfOEJCE7mw==
X-Received: by 2002:adf:edc8:0:b0:2c7:adb:db9 with SMTP id v8-20020adfedc8000000b002c70adb0db9mr6221870wro.63.1678091884080;
        Mon, 06 Mar 2023 00:38:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003eb0d6f48f3sm14184064wmn.27.2023.03.06.00.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:38:03 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
Subject: Re: [PATCH 0/8] arm64: meson: bunch of DT fixes, take 2
Message-Id: <167809188325.8899.9049191801315125808.b4-ty@linaro.org>
Date:   Mon, 06 Mar 2023 09:38:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 07 Feb 2023 16:07:53 +0100, Neil Armstrong wrote:
> This is a bunch of fixes against the current applied and reviewed bindings.
> 
> More DT fixes will be needed when full dt-schema conversion is done.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.4/arm64-dt)

[1/8] arm64: dts: amlogic: meson-sm1-bananapi: correct usb-hub hog node name
      https://git.kernel.org/amlogic/c/f88f3dcbb145a0133292d5c9d8da5935a36c8914
[2/8] arm64: dts: amlogic: meson-gxm-s912-libretech-pc: add simple connector node in fusb302 node
      https://git.kernel.org/amlogic/c/d7ff22a6ec9dd154d027d6bc6b4f172c22f8c00d
[3/8] arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx: remove invalid #gpio-cells in onewire node
      https://git.kernel.org/amlogic/c/bd47319f999e6055124a2b4d2a0da495d52759c3
[4/8] arm64: dts: amlogic: meson-g12b-radxa-zero2: fix pwm clock names
      https://git.kernel.org/amlogic/c/db217e84d0a3f4183ea5b6d5929e55b73128fcb2
[5/8] arm64: dts: amlogic: meson-g12b-odroid-go-ultra: rename keypad-gpio pinctrl node
      https://git.kernel.org/amlogic/c/50e7d712144e7246f4ad5ce0f8577aa09cd09bc6
[6/8] arm64: dts: amlogic: meson-s4: fix apb4 bus node name
      https://git.kernel.org/amlogic/c/d1e336eef1f4834bae0a54f203e9f74aa040726d
[7/8] arm64: dts: amlogic: meson-sm1: use correct enable-gpios
      https://git.kernel.org/amlogic/c/4bddf79acdc7ef15f8b913e8ef7861461b235df2
[8/8] arm64: dts: amlogic: meson-gxm-s912-libretech-pc: remove unused pinctrl-names from phy node
      https://git.kernel.org/amlogic/c/739e93e254e4797a29bdf397c10111a50a970734

These changes has been applied on the intermediate git tree [1].

The v6.4/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

