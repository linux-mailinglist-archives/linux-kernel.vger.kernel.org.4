Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDBD62B677
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiKPJ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiKPJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:26:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920FD2FD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:26:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c1so28554642lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTk4m78nldGwz8/w+Qb5sMvmRKXadZx0hjAjuUwf6/o=;
        b=z60N0Dy9E3BeooJoTOtRL56IDiWeKQ+CoxlqpTGqar5Zw8MHDklK0PQv0kGH9ADp0h
         zYyf6lPNUX4d1fv+k/XMsdrFXzKgCmiu+8vmGTfl32PqtISLg0pYl/WP8QhQUwlS9Fke
         GkrjbmJ5i1SAEFCbLQQPhY4YWw4wE0bhD7z6gmjBehCEb8TVY5kXGT83zJrOmJ31N/sd
         CMqIbDGwZ1svvOiqctVq/5U8eCDYu16GWjgZdROT2CsByCi8/8YSarzGSN8QzAVe/s1g
         +RJ+9VJb9NMKqarWUZ0FHep9wFLESgNLel6ADJ1xMkRiiyqHo8KhhI15eOXalliVPYeF
         mtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTk4m78nldGwz8/w+Qb5sMvmRKXadZx0hjAjuUwf6/o=;
        b=3owNIzLuq+4Wg8uwlSFa8tUMdebgMSExH4eHaaLPnxEv4k8BwJBjEPQXNuZNuYruKI
         HJzsEtjosLvdm3CELUqaJNj/fBSHzGnEkBBWm2XUitjFr8kLvG3yLOpCRl5YXNhHlWpe
         fZaKwzNYINPuesBjJzIRGWphPL/3lVewFTQh9yg1yKrvvSAmYTvJKWanhzr0ca4bDYY5
         IjSm51vYK0Lev4QS11UcD2DZK04ryJgEL46oWbtQ5CwPjYx4QM528JH7zt8z3TZCDSuF
         4DUypWDQMeEB/2bQw1IFNQ1DHbn+ihCsYJCW74BNQqLUXrFFbx689q9+Hq+O2dGwmqXW
         kMyw==
X-Gm-Message-State: ANoB5pmSID4sRkwyKLzWK2LdiI3Yi4w+PzsM9BmseclM17JuVPpAUSKb
        P2bF+jjxFh1y/k+FPCqlSsHkPw==
X-Google-Smtp-Source: AA0mqf5IBvXe4FG23QYgVQONrT+oErAGS1AxXK+RcSHC2Rp7oifietV2nk+4Pi5nCeTZTiDvDrvAZA==
X-Received: by 2002:ac2:5d69:0:b0:4b4:1036:bbb with SMTP id h9-20020ac25d69000000b004b410360bbbmr6571649lft.65.1668590779965;
        Wed, 16 Nov 2022 01:26:19 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n20-20020a05651203f400b004a2511b8224sm2523150lfq.103.2022.11.16.01.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:26:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: Pull for v6.2
Date:   Wed, 16 Nov 2022 10:26:16 +0100
Message-Id: <20221116092616.17960-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.2

for you to fetch changes up to 2bc5febd05abe86c3e3d4b4f18dff4bc4316c1be:

  clk: samsung: Revert "clk: samsung: exynos-clkout: Use of_device_get_match_data()" (2022-11-15 10:36:54 +0100)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.1

1. Fix calling of_device_get_match_data() on wrong device (parent's) in
   Exynos clock out driver.
2. Correct clock name in bindings of ExynosAutov9 clocks.
3. Correct parents of div4 clock on Exynos7885.

----------------------------------------------------------------
David Virag (1):
      clk: samsung: exynos7885: Correct "div4" clock parents

Inbaraj E (1):
      dt-bindings: clock: exynosautov9: fix reference to CMU_FSYS1

Marek Szyprowski (1):
      clk: samsung: Revert "clk: samsung: exynos-clkout: Use of_device_get_match_data()"

 .../devicetree/bindings/clock/samsung,exynosautov9-clock.yaml       | 2 +-
 drivers/clk/samsung/clk-exynos-clkout.c                             | 6 ++++--
 drivers/clk/samsung/clk-exynos7885.c                                | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)
