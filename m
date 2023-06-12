Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75F72CD5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbjFLR7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbjFLR7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:59:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5033E4E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:59:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d6aa3758so841842466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686592754; x=1689184754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kja3SgwesCI8mivV99SZPOWE2UVpV1r0v4iU8FZZkk=;
        b=pjXh9aVZiXOJFFCjCmr7A4oawfygz/Bd4NeTlZUT122McbGv90yOB+QM7dRZkDguAv
         pdaR2/52/J28BpsZXW2d/aXQp5afOWtnMULnJAA0qqQV45bw4S5T/NSxthNA4O9c1zxT
         kHgVYauEPJLkTmV/A2kDbDwcAU3OMfwAPURH80CfFtpa9U6RhOKqtoZGAD1PiQ60D4fo
         /iTKt8B1C8srtP/qazc3X1d4osO/IGZgeZZxxS/DqB+lVkwAQga5SwnCSF/v0YiX5xFg
         kpUk5xOQ43xbHKqQvw8DxLPX0fMXjXqkkxhQ+be5X4o/S2AFpH9/jODYkwcFDQyOPLdG
         6b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592754; x=1689184754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kja3SgwesCI8mivV99SZPOWE2UVpV1r0v4iU8FZZkk=;
        b=PUitQ5E1RcVW/kwW+UCgmR0i6Ckl+6LZQS8eCHfsS/tCboynDmvfnWmkECY25n0Vbb
         NhsuJgxHwLs1iINg4l6IQggmj/O3v4nYGfc1wcTRfX82cn8dQtkquUZwYqZxMPW22SL8
         0vuUvU5vJAU1d6KQbFU2hT2y5v7os94AXrUg7GmnAQ37S28OKH8S/Vi7qVEL67IYjF6J
         VsWxwzl3B9BPj+Im7qrgdwIOo0Tyb8EPMGu0pK9BSz0JsmcLlJJMF0upViTNRl6RUF9q
         SptPw41EqnluWXbDiGw01KR2liUQvC5yY/txguG7V+QSfsRjK6WzY8Vqb0K7wObSY35T
         Govw==
X-Gm-Message-State: AC+VfDxVn6LbyG9FtbJfLk3J4BfmZXyuHlesmuva8HksMK6me49C2KMz
        iMKMvn6qaZN75QZB/Zk7YFahug==
X-Google-Smtp-Source: ACHHUZ6oEp6zQOXL+EEOKj1+6lJ1O0RK86/UNGZco7BEnX9YCFuXS+nIiKnIbUHujOwR9mw2Knukxw==
X-Received: by 2002:a17:907:7202:b0:96f:cb13:8715 with SMTP id dr2-20020a170907720200b0096fcb138715mr10521958ejc.69.1686592754157;
        Mon, 12 Jun 2023 10:59:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id dx22-20020a170906a85600b009745e1065f1sm5396790ejb.206.2023.06.12.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:59:13 -0700 (PDT)
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
Subject: [GIT PULL] clk: samsung: drivers for v6.5
Date:   Mon, 12 Jun 2023 19:59:10 +0200
Message-Id: <20230612175910.289428-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.5

for you to fetch changes up to 2aac2d8b95923203e683c60124877ab434133679:

  clk: samsung: add CONFIG_OF dependency (2023-06-12 11:45:20 +0200)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.5

1. Re-add support for Exynos4212 clock controller because we are
   re-introducing the SoC in the mainline.

2. Add CONFIG_OF dependency to solve some objtool warnings.

----------------------------------------------------------------
Arnd Bergmann (1):
      clk: samsung: add CONFIG_OF dependency

Artur Weber (3):
      dt-bindings: clock: samsung,exynos: add Exynos4212 clock compatible
      clk: samsung: Add Exynos4212 compatible to CLKOUT driver
      clk: samsung: Re-add support for Exynos4212 CPU clock

 .../bindings/clock/samsung,exynos-clock.yaml       |  1 +
 drivers/clk/samsung/Kconfig                        |  1 +
 drivers/clk/samsung/clk-exynos-clkout.c            |  3 ++
 drivers/clk/samsung/clk-exynos4.c                  | 44 +++++++++++++++++++---
 4 files changed, 44 insertions(+), 5 deletions(-)
