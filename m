Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50AC73F6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjF0IQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjF0IQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:16:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D910FD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:16:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa9850bfebso17297745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687853764; x=1690445764;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yQFEnlmWTzmD4v8v49zNv7VsmYLYcrpbow9siGJNP4=;
        b=czgQCnAFJ8Xd83kIpzwxPdcxqmidfRNk5flJtIQBcPdEe38IDE7p+10TmWw9W5W1fZ
         IlxxqS9Uoid5yXSNrm/Qi6Z/HlMQEeMn+DkNQ0CEVa4MneNtDOU5iVgdsXOyc6iwY7iI
         ErHfSWg7V3aZibXcxjc6OyvKoZvt7/4ggad1m1Ep2qGcryW7MmGk3QogAqzy7nojjU/N
         NNq/g6XuLicIVB7xmDGFYbQ8AncRcAnH9jXjmWwWoIpRxJU4TG2oOCLA4jwtm6G1NrEn
         izKeLiUeB5dJxyACip6u0A05HuPlqm1yci/aKB6qGFGqOFO2NSdOOy9H2kN5Rb8NihvA
         eSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853764; x=1690445764;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yQFEnlmWTzmD4v8v49zNv7VsmYLYcrpbow9siGJNP4=;
        b=MSptDfYoBfdh9XsuTJAVaviREnBLz2Mzf48ym2nSPiL9joYW0Sm+zLMgLrhrNwakLC
         qtW36OAuWN8Sx4z2X4GonKc2uNY7FLptW010Ubv9D5rtxFCHSvX6zHd50YjraLOZMV9e
         ykGifSUkn7bmgrDHOcW4c3YSViII4GHsJBAHdqBrzNmNlq1BF5OSgYzG8W37KuWc3KSc
         FXqi0FICZDdokh4DNTavuPxAyKgzf7XGDNFk/vrOB51qA4aeP6MFl/Qdft6prvVy8j/9
         ptARsZH46jx8485g2ldjOvHx1MwyEOSnyA6HW7qTz4OVsd5OKN2eGtXFBK1m7gd2pLoY
         cWVg==
X-Gm-Message-State: AC+VfDyqfo86Xgb/YR25mVN26SxRZa/4WWvzTrElx2GNsNYg/oVHYSSk
        ngPw5nNvKlo697nnqU+e8cwmCg==
X-Google-Smtp-Source: ACHHUZ5buXqau94bITzRkCNSm8pvrrp74ljkSE95CsdnNaaE7n+AhvA6hq0iDdRKf9Cu8uL5Sx9U2g==
X-Received: by 2002:a1c:6a0a:0:b0:3f9:2c0:b58 with SMTP id f10-20020a1c6a0a000000b003f902c00b58mr20010969wmc.4.1687853763862;
        Tue, 27 Jun 2023 01:16:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003faabd8fcb8sm3922480wmi.46.2023.06.27.01.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:16:03 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/5] bluetooth: qca: enable WCN7850 support
Date:   Tue, 27 Jun 2023 10:15:53 +0200
Message-Id: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALmammQC/42NQQ6DIBBFr9Kw7jSIqLSr3qNxgQg6iYIZ0LQx3
 r3UE3T5XvL/21m0hDayx2VnZDeMGHwGcb0wM2o/WMA+MxNclLwWHFJY0ECcVVVxWJeYyOoZugS
 9M7LklbubQrI873S00JH2ZswHfp2mLBeyDt9n79VmHjGmQJ8zvxU/+0dpK4CDbISqaumUasRzQ
 q8p3AINrD2O4wtFIP1w1gAAAA==
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8ajAaelp7METtTO+em4pEvC+eBHXTg//fu024TG3vFk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkmprAZG99W3x4f389GUC2SbWIaDEijrZdWHQhQmXY
 nIYBPYWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJqawAAKCRB33NvayMhJ0YpJD/
 9enhJFRMX81YEnArzQ0WWLgwhe3V9qmJjnMxyFelBwC1bnCPVwAyjBx6imUlzTlV3+U1YQNVHjRnHZ
 AFOorjd4lGc+yUZZnXZU5Ok0T1UuD/TOuotykKcsuILad9aiVeFeSFVP/28mGn8NzpLXgkKAVGV/wr
 E3OUxR9lYss4yYivFeVaGdP6U9k+SR8fyxBTjJ5ZOuXNuwj0cd6IkdWuh8t4sGXcig3K1UWIQf9SXP
 sonkYvB29wZA3bWRJxkEOsKhv0KJCexLIh3RFnWxgtw2Br/C08JhS31DYMLd1TMSiuk80oE6Zo9zZD
 CvsVrNWqqronc+oYgwBW2nyHmleDUWsWPT2Y/08rozuBxnm5L/3AJQ8jX0kg38DGSBMDcgXi1q03Gl
 Y6xwZ+C5cz9zKMsrsOjWrPip2t7tIEK7vXZFLjrO4ccL+e8Fm6YL3S/psBHFSaANqqSIusnejKRX56
 YUuXKkH6qCho4B3Bg/q9H2o8rBesAfhfIVNn9aUjIfU+X3FOrOOVSDn3SYpDq6U1w4mS415xM04trM
 32tL/HrGosvbz6IA953hE/zLCG/m9AtzfCiQbof/f6GSEHhwCjExF/hIjTkzetJGud/l+robth02pe
 1IYFLkNazchLFs3w3gl9CHbNKUpGADA9kmITCa55C8sJiC2OStD2m/np4wgg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie enables WCN7850 on the Qualcomm SM8550 QRD
reference platform.

The WCN7850 is close to the WCN6855 but uses different
firmware names.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Convert if/else and qca_is_*() macros by switch/case to simplify adding now BT SoCs
- Add bindings reviewed-by
- Link to v1: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org

---
Neil Armstrong (5):
      dt-bindings: net: bluetooth: qualcomm: document WCN7850 chipset
      bluetooth: qca: use switch case for soc type behavior
      bluetooth: qca: add support for WCN7850
      arm64: dts: qcom: sm8550: add UART14 nodes
      arm64: dts: qcom: sm8550-qrd: add bluetooth support

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  23 ++
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |  43 ++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  30 +++
 drivers/bluetooth/btqca.c                          |  82 +++++--
 drivers/bluetooth/btqca.h                          |  30 +--
 drivers/bluetooth/hci_qca.c                        | 250 ++++++++++++++++-----
 6 files changed, 350 insertions(+), 108 deletions(-)
---
base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
change-id: 20230620-topic-sm8550-upstream-bt-dfc4305f9c14

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

