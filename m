Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC767C5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbjAZIfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjAZIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:35:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420983C0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so601586wmo.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy4JH/8Y4BIAqhpj+kNbuq2a/U7ZJXTkwi3YphKX6wA=;
        b=zlsDK5voMRPUM4nKKt8QdmuD/57HzrklVqIviWeVdmAUDSQHHG9qHKk6moGlFoJSU+
         W3mNtyLXv/QFP3lq2iEDvU9aN6z39Y5Zz897R3RctRM0tSX2AUgj1APgIFfO2bKt9ut5
         K59U68pcfApeOVdflYbF7J/W0eBWiRh2e0WWuOWDyc5dMaGu0Dd3zkruR/Ou/c/PuZoJ
         OdSLzHfPtqrEJQCU5W2x4meDJjm8wsxRp7FudyzwrY/4wS4ZoW8M5WDJ1MzPQet8vPT9
         /2FKWXPwkDb2N3vLIce6gzppJPYKl6svm92TSv0p3c/5kLv4TZYY8YdNgdd8Km+BeFFe
         +z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wy4JH/8Y4BIAqhpj+kNbuq2a/U7ZJXTkwi3YphKX6wA=;
        b=z/GKvxpQLXvUEq5LSv0Boqir+U1rzW+rrZWIAMiK3abQc19bpzJ+G1OCagitvCzJIA
         l81evuBjEEM701FzPuZprTgYL2RA6dAIGan4QQVXHWYyatzToueaNJY+rpV+JmqSQcQq
         xNJ3gov7gpO4xEGXXdDtFx1JUdShlg0XkcY/LFkG1VwJ1kVFXPh5qWrVDP3DBuzQpAu5
         tH4BWq5RMn9EcSZafgcDts+xEHcdotx7r//laN3MYdh8wC8MfZHZ0VQqweobZLfaCoMd
         spTXns2qCFf5FaldgJMOP0JP/QqCdD0sOrXRKkakXVpSUT2uluJPcRisKtAvKrr4rZuZ
         WvgA==
X-Gm-Message-State: AFqh2krMgRAr246x3pQcxKOHxuDY/uSIJK4cFsRACklBTy9TWiRQhmw9
        z3Y3srgPn0RxDgxy1k53F73bTQ==
X-Google-Smtp-Source: AMrXdXvspuhNLwRUh/Je30Th3z3ZFJPNoD133B5ZmcSE3V09vHaqsUnF+CdOZNBK74w+4MfPzJhCgw==
X-Received: by 2002:a05:600c:3556:b0:3db:331b:bd2d with SMTP id i22-20020a05600c355600b003db331bbd2dmr23729081wmq.18.1674722043741;
        Thu, 26 Jan 2023 00:34:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c328a00b003d9a86a13bfsm757709wmp.28.2023.01.26.00.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 00:34:03 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Dongjin Kim <tobetter@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230122-topic-odroid-n2l-upstream-initial-v2-0-8d3fea6d403d@linaro.org>
References: <20230122-topic-odroid-n2l-upstream-initial-v2-0-8d3fea6d403d@linaro.org>
Subject: Re: [PATCH v2 0/3] arm64: meson-g12b: add initial support for
 Odroid-N2L
Message-Id: <167472204279.456104.140123192066740782.b4-ty@linaro.org>
Date:   Thu, 26 Jan 2023 09:34:02 +0100
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

On Wed, 25 Jan 2023 09:18:36 +0100, Neil Armstrong wrote:
> ODROID-N2L is a variant SBC in small form factor and some peripherals
> are removed from ODROID-N2PLUS based on S922X SoC.
> 
> - On-board ethernet is removed
> - On-board RTC is removed
> - USB 3.0 hub is removed, so one USB 2.0 and one USB 3.0 host ports
> are available
> - Huge heatsink is replaced with 40x40mm heatsink, 5V active heatsink
> is recommended or a tall passive sink is optional
> - 3.5mm earjack is removed
> - IR remote receiver is removed
> - MIPI DSI port is added
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm64-dt)

[1/3] dt-bindings: arm: amlogic: document Odroid-N2L
      https://git.kernel.org/amlogic/c/8280a4ea1d7dd1d635c1ecdb9375b156e83358b9
[2/3] arm64: dts: meson-g12b: move common node into new odroid.dtsi
      https://git.kernel.org/amlogic/c/379ae64609c7a3301b60483eb65bd8bc78f76328
[3/3] arm64: dts: meson-g12b-odroid: Add initial support for Hardkernel ODROID-N2L
      https://git.kernel.org/amlogic/c/f1193c5c09b1bb6e214c804c7dd1c7fb07046631

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

