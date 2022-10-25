Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E464660CF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiJYOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiJYOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:46:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA21111877F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:46:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v1so21473153wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pa3LKMnS7r2iizMPoaQLt3RtRARTx6E2qBv41qZjic=;
        b=H4kfTg7okgWeVf3kp2Q7eAN/5rfwwa/tYWNvYrsAGY9WtLGueTmpAexjoQIbcR8k5r
         x0qIwXP56AlMxCsaQD0gE8weUnMtX3YCf/J/GI5AVi9QqiiQHIQ21qevEmlQg+vhacdy
         KCxHxbv7UonuC1HramRi9UDMaOZEzEQHHXA3JjjFGCTPqp8y4OZadkeh4kR3sleJzTA3
         CtNwm8zZtc9OVMIGlKwILdocLBZ61mEJq+t2hVofDbOyeQix8A6T97vYykbqLSB4iyC/
         EpvnwwjODU+ewysJxN2dpybP+8RSub07Kiqtz4JhNdkHWZHyHkZ0v/fhxjrDmuBYrXbc
         xBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pa3LKMnS7r2iizMPoaQLt3RtRARTx6E2qBv41qZjic=;
        b=ekv9YYI3yzBWFX5dU+0Bb2mSnRIR8+24FtkukSWzwEVaDK4RMsV/fVUYi3RdJ2TKs5
         EMiRLBfXCM7KUtNwi3L6uVnLw2m0gsYv5IgfRDJc0xfqajBGUmb3sfU1wm0OxkOCHkCC
         qMVuc5F3duCFmfdOz5rWi41aUAVpZeVDsbPMyEup/j/fw4Cjkt+w0Fq8C237XQ4RiEni
         kX8RoVGDoWQAT9Ji3cJ8dgZ7q8kSOrzyfvQuh5RqfTXh6tpJBatgSzUU2kBQ07Ya7Akd
         l/SUYzqn8pahXmtuIcQuScPru+FoAaqosO2OzB9pH9zeF1u8Riu96wAHUei+YBEYMFOk
         HQOw==
X-Gm-Message-State: ACrzQf3Oy99wq3K3wcvO3KYXy3Rxx+NmdZUt9ydVyJ4nW3RnawNieVZX
        jYfV3SwfenMKkMSLbDsIgNgYZw==
X-Google-Smtp-Source: AMsMyM74VwSpJCoWC2zVCGEqLRGsDpzeeKL1SFMSQiwRWOMtutgpfbdYbYzCfH9vE5eANnHqPUN/rA==
X-Received: by 2002:adf:e8cb:0:b0:236:7ae2:918e with SMTP id k11-20020adfe8cb000000b002367ae2918emr4418583wrn.613.1666709204473;
        Tue, 25 Oct 2022 07:46:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020a1ce906000000b003c6d0f8c377sm2498670wmc.7.2022.10.25.07.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:46:44 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Da Xue <da@libre.computer>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
Subject: Re: (subset) [PATCH v4 0/4] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle
Message-Id: <166670920358.4012520.5560439627049911254.b4-ty@linaro.org>
Date:   Tue, 25 Oct 2022 16:46:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Oct 2022 15:31:24 +0200, Amjad Ouled-Ameur wrote:
> Between SPI transactions, all SPI pins are in HiZ state. When using the SS
> signal from the SPICC controller it's not an issue because when the
> transaction resumes all pins come back to the right state at the same time
> as SS.
> 
> The problem is when we use CS as a GPIO. In fact, between the GPIO CS
> state change and SPI pins state change from idle, you can have a missing or
> spurious clock transition.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.2/arm64-dt)

[3/4] arm64: dts: meson-gxl: add SPI pinctrl nodes for CLK
      https://git.kernel.org/amlogic/c/2ba370bb98b53b7565493083699d82da5ef2cec8
[4/4] arm64: dts: meson-gxbb: add SPI pinctrl nodes for CLK
      https://git.kernel.org/amlogic/c/ce759829b8fffac891780611b54a6be26a2d5a5f

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
