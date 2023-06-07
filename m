Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E177725C3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbjFGK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbjFGK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:56:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DDA1FDD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso60145855e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135383; x=1688727383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2iKHUzCB8EHUg15xjq4OMMdldskToFfPs25o8tYY9w=;
        b=ymQSvjPpvyT7jG/isiZDKYSjksflsakM1YaZEIQlVBp8tEte6OHoV5wzQSyR40giFJ
         6owvCmjaV8p4WDxDsicuGv8nEhAhYjhBfz1olOTwHNvr6MxKDCqVpoPbQgduASPfCVx6
         weZ/oSsGvokYUSqusI/bYDdifZqmtrkNNt5JUvDmSXqWdZsagBRnxoqa8+VphqUB4FIO
         m5k+tRTCPkKLltUc+swA3zhH8So+5wsxhMfCNYRtX6e6U3TJEqAsRBZS8xmJvW1iSboq
         BZIg73q8N6lal8smXZyxMs4XJvDRqeIhspY5+zETXpeSZbLBmEXumbde9vkOmUbp8KIZ
         HTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135383; x=1688727383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2iKHUzCB8EHUg15xjq4OMMdldskToFfPs25o8tYY9w=;
        b=Pc5CfY7B5rxEXwFM/FwRYLutcvyRsIargEkQRBLS3rTkz6CucaXPBrmw08AdMnPl8p
         nVsqQkfc55Xz9F+G4svz3gQdlM3XZP623TKXYKy8UDpQsP7QjbLAGaWtmZUjzYx+fgfQ
         nil+LMd8HaL3gMA5z9P7wPMV3f6/WEdfyFzepYbApuHDek/woFgDqzyx2mvcM+7fTyPI
         VkFqQkaYTa40IbLMdbFI1T5vLxHPSM/p5qKL7BDO94aRTfR9Mf1NWQa4AGUjMp3Lo8FA
         W02UN+ly6djmpkDUmsfAYGX4cJFzI5XP2l0hDuckhR/r/RwjJK22saxdWhRy5fvVhJ1y
         //ww==
X-Gm-Message-State: AC+VfDy8brrnk7t8AAqeeozwNvcvEYz4wfVQcUeAb4rCkXgq24yyWZA6
        iDULN5DTGX8UGLDNhnAnDU0+Jg==
X-Google-Smtp-Source: ACHHUZ6/rVBwSBm+ljhsr4Hys2ZgNVqWoCxvgWyYTTUx6yhM6vnzeAM7hJ7kNTg2bIdzCNA5WPDVyg==
X-Received: by 2002:a1c:730c:0:b0:3f7:5e3:c1f2 with SMTP id d12-20020a1c730c000000b003f705e3c1f2mr4665801wmb.8.1686135382955;
        Wed, 07 Jun 2023 03:56:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:22 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 00/18] clk: meson: move all private clk IDs to public
 dt-bindings headers
Date:   Wed, 07 Jun 2023 12:56:11 +0200
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtigGQC/x2OywqDMBBFf0Wy7oBaq9JfKS6ScYxD8yIxpSD+e
 4euLucsDvdUhTJTUc/mVJk+XDgGge7WKNx1sAS8Cqu+7e/t2E5wxMQI2rtoZWsqRybtAd2bV0j
 VOLGebdaHlGDDDscJh2F+zEqaRhcCk3XAXaqhOicyZdr4+z/xWq7rBykCF5CUAAAA
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4001;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uJNGNauTjMkkifelIBeMDs+ah1nOQgnUxgk/5DE80k8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJNOIxWQSHL0QurCTHu93otFh40QfOFcpZcxiQ2
 nXKYJUmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiTQAKCRB33NvayMhJ0ZG2EA
 CzoAL+jZ+bj25TogujANFIzdIsx4Colo13UTfPLmbq2qTRMMwRvF3v5svBmFoAkG99HVwprsLoOZUi
 zbKzst9h2eR9kYgAHcxTxCE98trRbn6rpmpEHd19ZDls0KNmHcz/fqMI0ZFz6mbAhgi3sBYRJ+73Wj
 NbTT/4U7et0se7GwoF3lu/q+HJNeDcc+bJ5ZBIQZjHE5U1Y/917Lj4PYPJSqGGIwVRdAY7qBC1tK+p
 JH0cQOg6cGUSDC5naqm8NHXmf61TbJJxE7iB8jGCPvcBC3xIhpQyxmC7NYYjH8YIdttHQ/61xsgH8u
 6EtafiiYX+cJkY8mbE46QAjRsbs7/gse009YuvHB6msIRZntcNsRW+16FmGII4hy7fcInlKrHhJYcK
 4xeyTKtBu57lCEL2Qx3mdH0Vg/kw4zmgbVGBLx0RqY+LaLkPH/zInXprp7SpHP6gzznrFC/SdLW1Rj
 QkUygqf6gVNOb7pYjCYSKvoGwgDWq6DgJgcnwKCPEiiDZ/49NvSbyzNV3ShqsAn1ZPBPLeh1/hJXUG
 ipp4wrlJVBOZELbH8pN3Po7quSh5N0odzGDbzmFOf0y6WxC9WDtIP7MVpThFNmBDl17Uqpgak+yGaz
 gdaSZMtKIDYWDlqCB1BK0skHlvQTLG6mVSkaydxzyWpVbR9QudnXZoMP2zdg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After some complaints in the upstreaming of the A1 clock drivers,
S4 clock driver and a tentative to use some of the private DSI
clocks in [1], it has been decided to move out all the "private"
clk IDs to public dt-bindings headers.

For that we must get rid of the "NR_CLKS" define and use
ARRAY_SIZE() to get the count of hw_clks, then we can move
the IDs and do some cleanup.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (18):
      clk: meson: migrate meson-eeclk out of hw_onecell_data to drop NR_CLKS
      clk: meson: migrate meson-aoclk out of hw_onecell_data to drop NR_CLKS
      clk: meson: migrate a1 clock drivers out of hw_onecell_data to drop NR_CLKS
      clk: meson: migrate meson8b out of hw_onecell_data to drop NR_CLKS
      clk: meson: migrate axg-audio out of hw_onecell_data to drop NR_CLKS
      dt-bindings: clk: gxbb-clkc: expose all clock ids
      dt-bindings: clk: axg-clkc: expose all clock ids
      dt-bindings: clk: g12a-clks: expose all clock ids
      dt-bindings: clk: g12a-aoclkc: expose all clock ids
      dt-bindings: clk: meson8b-clkc: expose all clock ids
      dt-bindings: clk: amlogic,a1-peripherals-clkc: expose all clock ids
      dt-bindings: clk: amlogic,a1-pll-clkc: expose all clock ids
      dt-bindings: clk: axg-audio-clkc: expose all clock ids
      clk: meson: aoclk: move bindings include to main driver
      clk: meson: eeclk: move bindings include to main driver
      clk: meson: a1: move bindings include to main driver
      clk: meson: meson8b: move bindings include to main driver
      clk: meson: axg-audio: move bindings include to main driver

 drivers/clk/meson/a1-peripherals.c                 |  345 ++---
 drivers/clk/meson/a1-peripherals.h                 |   67 -
 drivers/clk/meson/a1-pll.c                         |   59 +-
 drivers/clk/meson/a1-pll.h                         |   19 -
 drivers/clk/meson/axg-aoclk.c                      |   46 +-
 drivers/clk/meson/axg-aoclk.h                      |   18 -
 drivers/clk/meson/axg-audio.c                      |  858 +++++------
 drivers/clk/meson/axg-audio.h                      |   75 -
 drivers/clk/meson/axg.c                            |  283 ++--
 drivers/clk/meson/axg.h                            |   63 -
 drivers/clk/meson/g12a-aoclk.c                     |   70 +-
 drivers/clk/meson/g12a-aoclk.h                     |   32 -
 drivers/clk/meson/g12a.c                           | 1483 ++++++++++----------
 drivers/clk/meson/g12a.h                           |  145 --
 drivers/clk/meson/gxbb-aoclk.c                     |   12 +-
 drivers/clk/meson/gxbb-aoclk.h                     |   15 -
 drivers/clk/meson/gxbb.c                           |  844 ++++++-----
 drivers/clk/meson/gxbb.h                           |   81 --
 drivers/clk/meson/meson-aoclk.c                    |   22 +-
 drivers/clk/meson/meson-aoclk.h                    |    3 +-
 drivers/clk/meson/meson-eeclk.c                    |   22 +-
 drivers/clk/meson/meson-eeclk.h                    |    3 +-
 drivers/clk/meson/meson8b.c                        | 1335 +++++++++---------
 drivers/clk/meson/meson8b.h                        |  117 --
 .../clock/amlogic,a1-peripherals-clkc.h            |   53 +
 include/dt-bindings/clock/amlogic,a1-pll-clkc.h    |    5 +
 include/dt-bindings/clock/axg-audio-clkc.h         |   65 +
 include/dt-bindings/clock/axg-clkc.h               |   48 +
 include/dt-bindings/clock/g12a-aoclkc.h            |    7 +
 include/dt-bindings/clock/g12a-clkc.h              |  130 ++
 include/dt-bindings/clock/gxbb-clkc.h              |   65 +
 include/dt-bindings/clock/meson8b-clkc.h           |   97 ++
 32 files changed, 3205 insertions(+), 3282 deletions(-)
---
base-commit: 84af914404dbc01f388c440cac72428784b8a161
change-id: 20230607-topic-amlogic-upstream-clkid-public-migration-fc1c67c44858

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

