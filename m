Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790836BEC20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCQPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjCQPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:04:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83510DE7C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:04:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r18so4734917wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679065465;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrNP2U1Bweu+K3EQ1iwfmC2BkNeHceAtfpVaftw7AuE=;
        b=hvQ9L9xFlFTyzCzkELWRsbNWD+V8o/O/lxqs+ucNSpUnQCUbD4d8r54Yq/mXFbtfVW
         CVptaCLb5Z6AfEPH/1A9wosw0+a/8kAj/xJtSv2aW310M1fPWI2sRCnzmRKL8nrGmwtL
         YfBaZ5ssF1eohRIslE/uV7l7pXKDUNpE7QAMPCjCCl+6pvSnSJtQ8+YvND6kXfKv8WFC
         QxRou1r8QnlE0BezkH1j7GB8Va3IPzCnZl+67tvKgFzyLuPXu5G5osHiuvYSyUTS+DIt
         CBsX1LalRYayX/7RnNL9fWovxBE0w/k2hyVFEH3YDmAUm2gGRLH0AfRXJrO60YIepm04
         UoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679065465;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrNP2U1Bweu+K3EQ1iwfmC2BkNeHceAtfpVaftw7AuE=;
        b=7YpEOBgMRTiEv/0GuYcFa4IzvzUL7vxsQSVF4/ZdfAkQ0jW5xP1IPPGLZn2A57MS/S
         f8aKTnfbF06SgwHOGmZnXl1Hh+V/v4c2E6w9Fx47+OOcOXBDPLvDL9p9GUHjvk/0Cv4T
         w5BbfTcRZuZd5V4/9BeK2AqNeY0T15lNusLl7ZXpA0WZNUWM7nPsKkZZexWVeGuIuU/P
         Y06Gu0IHIqsFHoys2P7+kiSMUcff41SywQzd+f3jX1N4YCFZ+YGhOJY8PL6tXG2ODsJj
         N/fTNhsBJ7OGLFxvUfs4ER1L1fmpcBvZG8YB8pnaQYaUPqbmjAKYM3BLLpyHnNxYUdXo
         X3Rg==
X-Gm-Message-State: AO0yUKXtVGjlafraXFxXuR1eY/0Q5Z0zaqX3ipUH0yzgs7yFFvEM/u8f
        5VmUL6MY0Wp1hSYocK/JlQrq5w==
X-Google-Smtp-Source: AK7set/6E/+aRE8WDx7crNSpQvDpdkFOTSvxHwHopJFuVaKrIh1NXS6C77sCNGCYq4JQ/tb1btEUEA==
X-Received: by 2002:adf:f1d1:0:b0:2cf:e8b2:4f76 with SMTP id z17-20020adff1d1000000b002cfe8b24f76mr7305646wro.66.1679065464789;
        Fri, 17 Mar 2023 08:04:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b002be505ab59asm2133773wrx.97.2023.03.17.08.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:04:24 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 00/12] soc: qcom: add UCSI function to PMIC GLINK
Date:   Fri, 17 Mar 2023 16:04:16 +0100
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v4-0-38bf0f5d07bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCBFGQC/5XOS27DMAwE0KsEWocBLckfZNV7FF3oQ9tCbcmQH
 KNB4LuHyS7oyssZgG/4EIVyoCKup4fItIUSUuSgzyfhRhMHguA5C4lSYaUQ1rQEB2XudI1wW8q
 aycywzFwOU4i/oKwyaFvrvFKCGWsKgc0mupGheJsmLpdMffh7737/cB5DWVO+v9/Yqld7YHGrA
 AEtGtcbzzf0xbXJ6ZLyIF76Jo+KksW26snIutGt7v+J6qioWNSua9DLpvay+xD3fX8C4Wn/nIo
 BAAA=
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC GLINK interface offers an UCSI endpoint for newer
SoCs, the UCSI exchange is necessary to configure the USB-C
port USB role and altmode on the SM8450 HDK and SM8550 MTP
boards.
Since the DT description is the same, support for SM8350 HDK
is also added.

This patchset focuses on USB and disables altmode support
on those 2 SoCs until DP altmode over the combo phy is
supported.

Depends on PMIC Glink patchset at [1].

[1] https://lore.kernel.org/all/20230130042003.577063-1-quic_bjorande@quicinc.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Handle remove for UCSI driver
- Fixup client mask match data handling
- Added USB ports bindings review tag
- Link to v3: https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org

Changes in v3:
- Fixed patch 1 by moving mask to pmic_glink_of_match
- Fixed patch 8 by adding back hsphy
- Add bindings change to dwc3 to support separate HS & SS OF graph links
- Link to v2: https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org

Changes in v2:
- Moved the dwc3 port subnodes to dtsi
- Added SM8350 HDK support
- Added help about ucsi module name
- Added bindings acks
- Fixed sm8550 pmic glink compatible
- Added more description in config update patch
- Link to v1: https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org

---
Neil Armstrong (12):
      usb: typec: ucsi: add PMIC Glink UCSI driver
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8450 compatible
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8550 compatible
      soc: qcom: pmic_glink: register ucsi aux device
      dt-bindings: usb: snps,dwc3: document HS & SS OF graph ports
      arm64: dts: qcom: sm8350: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8450: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8550: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8350-hdk: add pmic glink node
      arm64: dts: qcom: sm8450-hdk: add pmic glink node
      arm64: dts: qcom: sm8550-mtp: add pmic glink node
      arm64: defconfig: add PMIC GLINK modules

 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   2 +
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  16 +
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            |  67 +++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  19 ++
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |  45 ++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  19 ++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |  45 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  19 ++
 arch/arm64/configs/defconfig                       |   4 +
 drivers/soc/qcom/pmic_glink.c                      |  65 +++-
 drivers/usb/typec/ucsi/Kconfig                     |  10 +
 drivers/usb/typec/ucsi/Makefile                    |   1 +
 drivers/usb/typec/ucsi/ucsi_glink.c                | 345 +++++++++++++++++++++
 13 files changed, 642 insertions(+), 15 deletions(-)
---
base-commit: 6f72958a49f68553f2b6ff713e8c8e51a34c1e1e
change-id: 20230130-topic-sm8450-upstream-pmic-glink-3b3a0b7bcd33

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

