Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468777256CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbjFGIFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjFGIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:05:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBAD10F8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:05:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977d02931d1so549565266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686125106; x=1688717106;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WwfN3KvY/c/aNVK3t3sR/GB3uBGYQkPJHDX8ssQfX7g=;
        b=mwhq7l9opsippHmvHeI4AT0f+OQRdkAv9JAs5sYimXNqKUq7yN54DYqtP9q8bw7hJ0
         1XaTRaquflQrBAStahZKedkLsIjfZ5clvTRLWb0MTjYRJoNumLhqv7CczRlZhhbg/DWK
         0C9unRmm1AcPxPfcO3mnEJSLNKXGlW+ZhMf2tc/XzahkMCYkv3cU0eu/j55/pphKlNqc
         3goSIOJmxWcfCxuQw8Us1LRL95vjmRXgI1RiyZXi4etgXgvzXOq9aBVzJhF0ao0ymjeb
         wnarkE2bPTUAtrQoslklTrEi2nL5xbOoHBjG2Tn1Zz+5AiqewZoHp+pJz6hxmk7f9CbV
         QRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125106; x=1688717106;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwfN3KvY/c/aNVK3t3sR/GB3uBGYQkPJHDX8ssQfX7g=;
        b=dcYSyiIZ/oORCqaEQ9rhaQTIMQHaEOhWuLJvEyg2IqjAW6I11J3D85J7sfqgLKkx9h
         xOOYpc3ue0/t++Mz3DhihplvgJEIjUlE+dC0rdSaenNbj1bIhRmDDBHZCBcz2zGo3jXD
         ikEwvvxmxu+lTmrAkdw6U5fs8ZeS1XCVXmQ3qEWB5vPgFu0IsD9VrvfQe2qtFjf+WhJt
         vAz+0RXdMIO5/PxfYc+PPZaDisCpEEhKVWpYAvqmpSXfpTQ/hBTgUASpEDAFf/gR/imU
         0wkMN9+xlZLaIpmkxPWKQkntTKvM9lW0WRKwBcGiJccEZFBpPxZ95HM4/JQyhx6woIMv
         46+Q==
X-Gm-Message-State: AC+VfDwILM3YbNu5G9jKKSNc9TIgZTt3NfXgmc5AbiWP8tm/YjUi8Bhe
        k6Lfin2vsUgsMkIHnP1gaMctIQ==
X-Google-Smtp-Source: ACHHUZ5zAyQU3UGt9/z0tOmguRfc8YaUDylkDkACEDTHC39HKi295p/X1Peesuk0WkSdW1pp1Phx8g==
X-Received: by 2002:a17:907:dab:b0:977:95f4:5cca with SMTP id go43-20020a1709070dab00b0097795f45ccamr5573295ejc.54.1686125106046;
        Wed, 07 Jun 2023 01:05:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm14706269wrm.17.2023.06.07.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:05:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/8] arm64: qcom: add Type-C Altmode support
Date:   Wed, 07 Jun 2023 10:04:59 +0200
Message-Id: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACs6gGQC/42OQQ6CMBBFr2K6dkxBqujKexgWbRlhEmibaSESw
 t0tnMDle4v//ioiMmEUz9MqGGeK5F2G8nwStteuQ6A2syhleZU3WUDygSzEsVZKwhRiYtQjpCU
 gWMBamap93ItKSZEnjI4IhrWzfR5x0zBkGRg/9D2a7yZzTzF5Xo4Lc7HbP2tzARLavZejtdHmN
 ZDT7C+eO9Fs2/YDT57e3d4AAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Mkj0wPYCZQIKUW31m33WD3TMAwvTacRLlnxcKmg9vbE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgDotruFhguAz80Uz+X6MCWkdyDTUicoGT2U8QFkR
 YK2ysquJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIA6LQAKCRB33NvayMhJ0fRdD/
 42Yzy2x+tqdX+C8XnZMdKct16FlO/H951CU/hRgHROZinM0xfIGTfQhROO1mV42PXL9SWqoVsXLv6I
 5dJxZZaUYyk02hFBwNKyBw6/PwAf16Hq7bx9++VjVj40MoK+Fi5WrpQC7aDd8dE9kkSmV88I20Wutt
 uIKJbTQUrg39hupL3E0Hj6xxUfPQcM7nyRdDw0DjzlGzX+mE+GjlxDsuV4xu/UfwbDJDm8SSypDzLv
 EuWzVR5YLtNDW3UNgJN+Wj9zhO2SVu6VbUZFamcjn6pr0+kjPvDcoOnqzrHQPsuoE/SmwIevTCtaBI
 iDywVg3boTJI+HUYs7w7eU57bbdvACbyZPfd1PMrl1MkVACcuaXmPmojno3/4L//g5PFpWJahjOsRk
 btNQCF+Ojbtok2S4ipYeQU1tNJSuYT0BRJTea5hZxS56DNqQuPoSB0QVoCmQWGvP+pYZHQaEs1JlB/
 8ILuLwKHRstgYTNyBXjZzN6snoQLvHt+SEbcc1n3Su40o9AL109ucCAsHd/1YQKGCQAQ62FBEEQvcI
 fovSY6zdIFCGPDy64UVX9MHSXevTKTMGl8rAGngzci/SHG/dCFJQgmuvwM5sCzBkFEvqJ0iK+nqnZE
 hu8ckLNJhGeOP2Jwp38aMaBNnQxgp72uGBjgiCraEP6pENgSLRsFJaifINQQ==
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

This adds the missing bits to support the USB-C Altmode
support on SM8550.

These are the following changes since the previous SM8450 SoC:
- No more GLINK altmode events for USB only changes, only DP
- Type-C orientation is available on a PMIC signal connected
  to a GPIO line
- When altmode is disconnected, an 0xff mode event is sent.

In order to handle those changes, a new orientation-gpios property
is added to the usb-c connector bindings.
The 0xff altomode is translated as a SAFE type-c mux mode.

And in order to handle such info, we tie this to the UCSI connector
events to propagate the orientation to Type-C switches.

Redriver driver & bindings dependency at [1].

[1] https://lore.kernel.org/all/20230601-topic-sm8x50-upstream-redriver-v2-0-dda89b22b1c0@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Updated redriver node to use retimer-switch on QRD
- Fixed redriver data-lane according to v2 bindings
- Added review/ack tags
- Added new change to handle retimer-switch in pmic-glink altmode driver
- Link to v1: https://lore.kernel.org/r/20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org

---
Neil Armstrong (8):
      dt-bindings: connector: usb-connector: add a gpio used to determine the Type-C port plug orientation
      soc: qcom: pmic_glink_altmode: handle safe mode when disconnect
      usb: ucsi: glink: use the connector orientation GPIO to provide switch events
      qcom: pmic_glink_altmode: add retimer-switch support
      qcom: pmic_glink: enable altmode for SM8550
      arm64: dts: qcom: sm8550: add ports subnodes in usb/dp qmpphy node
      arm64: dts: qcom: sm8550-mtp: add pmic glink port/endpoints
      arm64: dts: qcom: sm8550-qrd: add pmic glink port/endpoints

 .../bindings/connector/usb-connector.yaml          |  5 ++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            | 67 ++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            | 99 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 26 ++++++
 drivers/soc/qcom/pmic_glink.c                      |  6 +-
 drivers/soc/qcom/pmic_glink_altmode.c              | 61 ++++++++++++-
 drivers/usb/typec/ucsi/ucsi_glink.c                | 52 +++++++++++-
 7 files changed, 305 insertions(+), 11 deletions(-)
---
base-commit: 54bfdd3bfe0f13da0bcf6e720d0ec0020a89b4dc
change-id: 20230601-topic-sm8550-upstream-type-c-e85b4d971450

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

