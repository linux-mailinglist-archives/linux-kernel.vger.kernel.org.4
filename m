Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8426C72BEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjFLKSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjFLKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:17:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269C5AD0F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:58:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso41742835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563854; x=1689155854;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o855QaO+l++MYTLXHUjksxbcIJtZOMXvxvs2vov9LyA=;
        b=KHy+WQSs4/5+U2nuN+xUrqtWJnw+odFK2wudBhHg0gh8/SOmAjC9CS9A28oBw+XXxE
         TKwMnU9SdCYraMLYAECZL34G9dxZlAFQKnMfcctaEdoC1usrSTGQAzJ/D/aWXWWTag/Q
         NocFSUF7FW0SmpBCmF8w5gAgnyvGiO9yTBJpttykjK3MoEOsNkJd55VgmpcKZ2CmNgDA
         S2faZD+3njjnrAR2eWbovMW4NtYfvxLS2aXA3RdAq03zp3OwNRxYgbFAYS5V9Gxw1RJs
         idhyLmvSqgkw+TeZN3QZwdBPct3bDgb8MQPKmj5lBwTBbheIQJF6UBYVHSRzlRrPquRd
         OiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563854; x=1689155854;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o855QaO+l++MYTLXHUjksxbcIJtZOMXvxvs2vov9LyA=;
        b=VMrqRk/q/E/jjivoJ5BfV/kuA4c1MavOZ5dKxzpdWN/DJG0PSj6xVOScD3394XQIIq
         mViCM9SH/7adso9LB8My5HcQxOH1Pk7dkBslL+qxC3P1IB2Jo4c7laQpxSoAsZxzui5c
         rmY2nhpX7B1LGqXthFDcUch6jjzFsQV6Coi2QnQSnTGCegPNL7TGobLL81Z9RyAeY8UY
         4FpmwNIqpnkckLhbZTIFZ+l8fjAGT5vUqfn7VFKBNNsohUybpvMAHfS0rGC53yN5WY6V
         6b7Qv17Mvk/3xMEteRo4ZSEBwWyzncJcGa6rsdgq9jvpPNu3KG02QP/Pu/PJ+n2BAwYl
         CvHw==
X-Gm-Message-State: AC+VfDygposEA55sJpwzqWhb18SRMnZcFqa074OppveUJ6CDVl2qLliY
        twTtEW+pizWl1dcAHA6PNuk9+w==
X-Google-Smtp-Source: ACHHUZ76tlC52QR2c7f3SZC0tnLDn2fDe/unYxyGueCJ78aWuAhWGO14gfwsmKORvvc21l4HJN+xBw==
X-Received: by 2002:a7b:c5ca:0:b0:3f8:11ec:7c06 with SMTP id n10-20020a7bc5ca000000b003f811ec7c06mr4126142wmk.39.1686563854329;
        Mon, 12 Jun 2023 02:57:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:33 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 00/19] clk: meson: move all private clk IDs to public
 dt-bindings headers
Date:   Mon, 12 Jun 2023 11:57:17 +0200
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP3rhmQC/52OQQ6CMBBFr2K6dgxULOrKexgWQy0wsbTNFIiGc
 HdHj+Bq8t7izV9Vdkwuq+tuVewWyhSDgN7vlB0w9A7oIax0oY+FKWqYYiILOPrYy51TntjhCNY
 /6QFpbr3YkXrGSUrQ2dKa2lbV+XRW0mwxO2gZgx2kGmbvRSZ2Hb1+I+6N8EB5ivz+bVrKr/33/
 VJCARdTG+zQtFrbm6eAHA+Re9Vs2/YBtmILdgABAAA=
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4541;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=RjI23b0gLBxTnXLhveDvC9kkSQ+2dt9BY4QrDQ4LfQo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwEjJFHZXNls8ngxcAhUJh0MJ2UoQZmwdvLcY5q
 liePl9SJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsBAAKCRB33NvayMhJ0TlID/
 0W5shmbocLZr/lQ4gwX6XEb3XNjNRJOKIp8PWsdIeF/fkMJfFyXw0R1V3Eu03NKVRknp6W80+bvBh5
 5Rhqjq54mQvzzQ6e72Cs+SP9BQYSO7VQUyglG0qGmVzCpQ/PoEvKCKhF0gT/uOm5Lb9Uyu5y00RJoU
 n0ZjVRUDhS5mTj4bK1Mi+BO+ewXG8+yTcgHJnFfvRstNMQCiqullPBakTNYpEp5snou8IU5AGL7pT3
 CWlDocEZwJlMRwtm+eQ2O2oBpgusXydYE5W3jaCqq8pNHdgDBs+69r0N62LLm6wmHRUIRyBsWnpud+
 Uj7zNPtKbDCQbWt6J/7Mr6DMjDepZ9InBECWerR3zzCJmMbUfG0cMFeS0+sKshdla3Kg7ULxIbzFrK
 LE6sIZEwm9R1Oa0INTb3Ngeb817Ra6XnCGyL9MAHYPbpLXYEuVPn/ELBW//IoZrkAN8dI5/OznDjj2
 EKjDwAiElT3Epa0RtoCuOut5uqfdQoxoHIdzNEiJbJUq0cxH2tWBNHPgODMuawpYjDgrVjbEYs8Bm/
 kBffToNkiIbZJ7eYlQ2ZDWQEgVgRRxQ35QaK5IuLf0bigWNilXifYFxLlLtOcIphgZlswpYT+xF4XD
 vMd5btSQSBcyMMgn3VkP5Gqe3FXQshA0kiXQxeS3wSIE0uLzkmBNRSLQLNOg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v2:
- Collect review tags
- Move newly introduced helper and header into new meson-clkc-utils module
- Link to v1: https://lore.kernel.org/r/20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org

---
Neil Armstrong (19):
      clk: meson: introduce meson-clkc-utils
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

 drivers/clk/meson/Kconfig                          |    9 +
 drivers/clk/meson/Makefile                         |    1 +
 drivers/clk/meson/a1-peripherals.c                 |  325 ++---
 drivers/clk/meson/a1-peripherals.h                 |   67 -
 drivers/clk/meson/a1-pll.c                         |   38 +-
 drivers/clk/meson/a1-pll.h                         |   19 -
 drivers/clk/meson/axg-aoclk.c                      |   48 +-
 drivers/clk/meson/axg-aoclk.h                      |   18 -
 drivers/clk/meson/axg-audio.c                      |  851 ++++++-----
 drivers/clk/meson/axg-audio.h                      |   75 -
 drivers/clk/meson/axg.c                            |  285 ++--
 drivers/clk/meson/axg.h                            |   63 -
 drivers/clk/meson/g12a-aoclk.c                     |   72 +-
 drivers/clk/meson/g12a-aoclk.h                     |   32 -
 drivers/clk/meson/g12a.c                           | 1489 ++++++++++----------
 drivers/clk/meson/g12a.h                           |  145 --
 drivers/clk/meson/gxbb-aoclk.c                     |   14 +-
 drivers/clk/meson/gxbb-aoclk.h                     |   15 -
 drivers/clk/meson/gxbb.c                           |  848 +++++------
 drivers/clk/meson/gxbb.h                           |   81 --
 drivers/clk/meson/meson-aoclk.c                    |    9 +-
 drivers/clk/meson/meson-aoclk.h                    |    3 +-
 drivers/clk/meson/meson-clkc-utils.c               |   25 +
 drivers/clk/meson/meson-clkc-utils.h               |   19 +
 drivers/clk/meson/meson-eeclk.c                    |    9 +-
 drivers/clk/meson/meson-eeclk.h                    |    3 +-
 drivers/clk/meson/meson8b.c                        | 1318 ++++++++---------
 drivers/clk/meson/meson8b.h                        |  117 --
 .../clock/amlogic,a1-peripherals-clkc.h            |   53 +
 include/dt-bindings/clock/amlogic,a1-pll-clkc.h    |    5 +
 include/dt-bindings/clock/axg-audio-clkc.h         |   65 +
 include/dt-bindings/clock/axg-clkc.h               |   48 +
 include/dt-bindings/clock/g12a-aoclkc.h            |    7 +
 include/dt-bindings/clock/g12a-clkc.h              |  130 ++
 include/dt-bindings/clock/gxbb-clkc.h              |   65 +
 include/dt-bindings/clock/meson8b-clkc.h           |   97 ++
 36 files changed, 3189 insertions(+), 3279 deletions(-)
---
base-commit: 84af914404dbc01f388c440cac72428784b8a161
change-id: 20230607-topic-amlogic-upstream-clkid-public-migration-fc1c67c44858

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

