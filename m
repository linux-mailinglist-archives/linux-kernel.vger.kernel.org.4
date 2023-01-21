Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D2667691E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjAUUTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjAUUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:18:58 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4B41BF0;
        Sat, 21 Jan 2023 12:18:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b4so10487574edf.0;
        Sat, 21 Jan 2023 12:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVSO49G+90zNDzrj6MAr5GjdLJ2Rrum8smiQJoUXN+E=;
        b=Ktqtj+r02FZQaYel1XTo+d4okKkl0sNay94nq6NRhXwXAyAVoGLoW7A2YVuJnBujpy
         oCK+C1lWCsaVqVa9bzgTNvKxVLYdDFAAFWHDhR6i4hBYg9Tw7820Gbw1KMyCWgDeaTsd
         AMZWXxj1y9cUD9F01nm0Zr9yM4BM2OliyHUIhFgJdwPDs2xlOmeBG/R/eOsgrFSfZrr8
         Wtf12eAQW9K1QnaNkOJH3zlMrLBt+RCPqHwpBdExoMUVFRf8iSuOlk+cHg1JDqe7zvTR
         kq5JMPFV+5BF6kWTBkkn3g0I4XO+1Bx1hz4FPm029EQ/8f3fxVyiR+s/ngmZE9J5OazA
         EC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVSO49G+90zNDzrj6MAr5GjdLJ2Rrum8smiQJoUXN+E=;
        b=Nu4UnEsoDFPJD3LpWYujUkDceEjQPVbNGePRT7Y+Oe4BPCRxxb4RTiZpaZNzXpROq1
         h5MQOUPkqR2J648XwsRGMfMmTFUHuGEEKwYka+jBK83ZPMCassLzyt4MFMypexJWZB5A
         10EUHy8aZmIBByKpP6ZdOjQLOgR0yzYRI0tgJx6t3Azt5SSIuHUOrKh1BHEHAhIEQP+r
         BL8SUIohHgiqwM8M1b4+fxwwq45kLmCEuDrrMTd1S40+SXT+lc80amXf3BtGthlHyyEO
         jfcg436hGdbgKxKkDa34SSjWzTbjAnw+bIfAYAOkj5KDS1NhatUezc5CPvFITAMGU3jI
         m+PA==
X-Gm-Message-State: AFqh2kpuNCzIqanRYn2jwfIjzrg0cBcGYXCNi6TNWzU2S29gGNfT8rQo
        YI06Dd9LhPFYYcQZI+fVH6sDUkURfveODA==
X-Google-Smtp-Source: AMrXdXuFmN6u3MxCqMpo+4RPCuRTKeRNijeNYyRJhci6brkCoAJdlqPDIb1W631UAXXidJekm1m38w==
X-Received: by 2002:a05:6402:27cf:b0:499:c332:3b50 with SMTP id c15-20020a05640227cf00b00499c3323b50mr26900820ede.39.1674332335663;
        Sat, 21 Jan 2023 12:18:55 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i23-20020a50fc17000000b0047c6f3eccb2sm19203423edr.50.2023.01.21.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:18:55 -0800 (PST)
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
Date:   Sat, 21 Jan 2023 22:18:41 +0200
Message-Id: <20230121201844.46872-1-markuss.broks@gmail.com>
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

