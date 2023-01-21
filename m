Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67867690C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjAUURF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:17:03 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14522A3E;
        Sat, 21 Jan 2023 12:17:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so21826878ejc.4;
        Sat, 21 Jan 2023 12:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVSO49G+90zNDzrj6MAr5GjdLJ2Rrum8smiQJoUXN+E=;
        b=iejkVLTzMekISSw7CuLQ4ejyCGyo3rzrEO/81IsoLg9rNEnI6pWKM7s4ws93O7rGEB
         92N1S3ak2gbjYCrf/Lm8C76cDgePs6mtbqELstgxYAhz9NDmSTy2x//JB05Hx/8dbEos
         7uEfMg5RFZo27PQf7ytsB2zfbrkG/X7XnjlUB34lhlFybPEkWSx6hHsVaVUm7riZ7qDz
         bmqQN2NsoZSSRIcmsqx3gI8LMHCxozMYubQ1h5WUIuIpKlzd36OqhuRNxB1eYs6Q/aGa
         L5UXTP5bOEUWiLlZKabKMMGBK5Ha3/m/6GccEWiBPB7j7T4yyXjnx4fIBKHcT2sYgCng
         XQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVSO49G+90zNDzrj6MAr5GjdLJ2Rrum8smiQJoUXN+E=;
        b=3OyhDmNB6Wkw2PeGS1s+RmH9Cbr8AFtAfUENENLDMSyxy+/jvUIljyq2EljMFfswaL
         /RZooAHTEI9SiAwLdr6CA/AHzpDEXIyZCxqXLsgjr7ARxmm36fFPv1W0X1j1R+FkH7Cj
         Us4Ox/TGIke3VZEUamrrFDznBE6APi5fVqjbxWM4EdZqlhvjnN2rw0sMh3Sy51rR/D2E
         Iz2sg0oZSBLbTNHMDgcbVGZ0heuxpEYc/TagpfHCZCKAKskztpT+7QSpQ8koUOXMVaKR
         qnakSq7+t4aKLDNIxSRDdH1D+J1OmmoLMIfVtNIVrQOZkOT13HpSL6WftVLg0RQLTZg8
         jw8Q==
X-Gm-Message-State: AFqh2kp2+sC3H7jFmLfDg5inW8j8uiYQBU89C0qJaD3EF5KRHd+VXV5i
        Exkwkqf4z7An7eC+4esWcNVdbBztn0/bTQ==
X-Google-Smtp-Source: AMrXdXvsw4VtD76/xrwX5+TzLQDVpMWA1ZIvWyAa1Z/4uArg0b19K+cHV2txsCX07YXiBPZ+e1dr3Q==
X-Received: by 2002:a17:906:25db:b0:877:6a03:9ad1 with SMTP id n27-20020a17090625db00b008776a039ad1mr11055618ejb.7.1674332220452;
        Sat, 21 Jan 2023 12:17:00 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id g8-20020aa7d1c8000000b0049e1f167956sm8278427edp.9.2023.01.21.12.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:16:59 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/3] Correct inaccuracies in Exynos5420 and Exynos5800 device trees
Date:   Sat, 21 Jan 2023 22:16:47 +0200
Message-Id: <20230121201650.46560-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the proper compatibles for the DSI host controller and MIPI
video phy, as the current ones are not compatible with the hardware.

While this fixes the kernel panic while trying to use DSI, I was still
unsuccessful to consistently produce image that isn't noise on S6E3FA2
panel of Samsung Galaxy S5. It seems to only work sometimes.

Cc: Mark Brown <broonie@kernel.org>

v1 -> v2:
- squash patch 1 and patch 3, making it one patch for adding the label and
  changing the compatible
- use better subject prefixes

Markuss Broks (2):
  arm: dts: exynos5420: Use Exynos5420 compatible for the MIPI video phy
  arm: dts: exynos5800: Use Exynos5422 compatible for the DSI controller

 arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
 arch/arm/boot/dts/exynos5800.dtsi | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.39.0

