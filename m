Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F419474770A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjGDQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGDQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:42:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6C10EC;
        Tue,  4 Jul 2023 09:42:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69923a715so90056071fa.0;
        Tue, 04 Jul 2023 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688488928; x=1691080928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yupS//9NmMxfnT6ltG5kxVBogtqQcoE8/2q6AUUdGQw=;
        b=FG28R3P6sSBELo1BHbDh1u5yXRQtjbi5PCB0MoKyVK7IEKtJZajXi3XuqG5Ml6I45+
         yZHUmy6XsrEMAxnm1IzZ8BztupTZC0Z9fpWlqK8LGHVk2F2apsSIukrAHilS2oxa/xAS
         qpihh/xfR7BUIthE3ApDowHFV5XZUeX0LpTcIqMU/7V2xIPOQj3Vpor+WiZeEQRKpZX5
         l+7kpLghxGLlwcG7YCoOLx/zJjoROv8J8JqBp1pN9JdZrMnPjxiZgvczFAJWu+OYxfQF
         iK1tP2gS0VXdP/BD7rDoFPetrExeVBXCYhvXmzTwIXDylQkw396omYx4cHktqagcfCPc
         V0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488928; x=1691080928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yupS//9NmMxfnT6ltG5kxVBogtqQcoE8/2q6AUUdGQw=;
        b=YfikvDlJiviSB5xQlVy6wfiaYGXkJgElQAYuPdOjZYEg43gcW292+jJR0pT3xKdO5O
         iGvDtabp8RcYZTJK6gCPjbghSgRIgg8M0oD/tWt2IxhU+BhbYsMOVX2DTslHC+e+U6Fk
         MfY4MAAB5WLFI7dBNBcQtPsQYUsPp92btlOD1x8TQPngv4H18h7EDFNseGAkyi36owj3
         h9pPHrsAQOtfa0rzoESfI1AfUPnb6dEsKwzQlGt+a5rCtN46ucvyUtvH6EhczAfJjXo8
         sqsm3kSl7TJ3PWq+MNUdHPXgCXyzORt4SwqK1HioOuQCF9QNr+V4YoaNDkWyMd01aq64
         F3Hw==
X-Gm-Message-State: ABy/qLZaOqbZitZxJkfHQ8x6NGRGSHSUHloYm6f9tVjrQ/yUmfQ7aV9H
        U68ljrpR/5pyqlkA0en/dJI=
X-Google-Smtp-Source: APBJJlF3gZ2pDkNLrQ+Vr/5gwS3fkTjsbD4Rft28N6ngjS3EphzfTJ2DCzAq9VU2i+6oKg3rNxFEXQ==
X-Received: by 2002:a2e:9209:0:b0:2b4:490a:66b7 with SMTP id k9-20020a2e9209000000b002b4490a66b7mr11624877ljg.12.1688488927887;
        Tue, 04 Jul 2023 09:42:07 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id u15-20020a2e2e0f000000b002b6eb5db863sm1181920lju.43.2023.07.04.09.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:42:07 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 0/7] Add initial support for SM7125 and Xiaomi SM7125 platform
Date:   Tue,  4 Jul 2023 18:31:53 +0200
Message-ID: <20230704163848.169853-2-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for the Qualcomm SM7125 and the Xiaomi
SM7125 platform.

David Wronek (3):
  dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
  arm64: dts: qcom: pm6150: Add resin and rtc nodes
  arm64: dts: qcom: Add support for the Xiaomi SM7125 platform

map220v (4):
  dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
  soc: qcom: socinfo: Add SoC ID for SM7125
  clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
  arm64: dts: qcom: Add SM7125 device tree

 .../devicetree/bindings/arm/qcom.yaml         |   6 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |  15 +
 .../boot/dts/qcom/sm7125-xiaomi-joyeuse.dts   |  16 +
 .../boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi  | 420 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7125.dtsi          |  16 +
 drivers/clk/qcom/gcc-sc7180.c                 |   1 +
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   1 +
 9 files changed, 477 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi

-- 
2.41.0

