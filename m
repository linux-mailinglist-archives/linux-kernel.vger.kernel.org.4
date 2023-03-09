Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34D66B2542
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCIN2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCIN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:28:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D71ACDD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:28:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k37so1163437wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678368481;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eI0q9N1LmPrgG1bPRrjXueV1/2pjR5jMVC1vrOlTxZk=;
        b=mCyJ+pIu3fJnTZ6AxJoX7FX8aPOAthn2nT3CsX0nqJKPj4QmqhC9gze/VRLUfv+Noj
         Z0ksc+0Vv3AeUUkntSYoi8z4RtrHBIGxBpu7QoSDHYMssnqETL24QdQDzPVX44BLbHz+
         IPvDqGBGsOxREuxuMZizM1egLLHAfsw5AxDqIaO3854FYwpjiPYJDjTNlqodPhdzQzOU
         z5v4mvjClRbMMlV3vNbzbl46+MRpvMaoBL8VV9Ift2EJZL7Y6ndlw2Y/iOd8IoH6+9NU
         qxXhXLa0z9/PkzeJ2Db9cwJjaokjuaW3rjb6ywd4BXxUYUB4ka5XVvt5/+m5ECTce6OJ
         Lpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368481;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eI0q9N1LmPrgG1bPRrjXueV1/2pjR5jMVC1vrOlTxZk=;
        b=FwqrQep5D/EmKKb/E/4mTvWMunTDq38NurVQqXySjp0E0yfVipSrAqU9Y152f8lvAg
         mHgGpJ15CEiOVtxTWp3PeasXNMyYB3wWrWG6hTYZ7wH7K11eZ0J71jwcR2mXyY2QjWI0
         z53aVaNa9qDAFmdAyVfkvKVpPn3Svj0xk8EVGjKMxgn1dfeGZka24bZqreBT80y7ZOrT
         Ed7KTR4V/wP+YaJOCGEa7g3Cn1zD+WNrYDMjNZqILRyTTIqak6/tmR7adqpC64RmpghL
         kdP9IJaojAbqRtyWhQgqMZ3P2nZQqM1pz2p+Z2erFFvGY7V0rJoIxpM5YLEZ6MZTe25V
         52ag==
X-Gm-Message-State: AO0yUKWBgorsXcK5kEw4mYkNTE6zXB4zvYYpcvW5Y+/csKg2D75tQusI
        RKI7dHBJgWdNJlXHpXjxgwtCbg==
X-Google-Smtp-Source: AK7set+RVr9R3x1jEVqWgBX5muzCjd74ZneQf6HVDVVZ6rAykvzMMvKkHyAxnK5MmTsoxUGY97yRdQ==
X-Received: by 2002:a05:600c:3d8f:b0:3e2:91c:7cb7 with SMTP id bi15-20020a05600c3d8f00b003e2091c7cb7mr20553312wmb.39.1678368481425;
        Thu, 09 Mar 2023 05:28:01 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003eb966d39desm2926714wmo.2.2023.03.09.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:28:00 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 00/12] soc: qcom: add UCSI function to PMIC GLINK
Date:   Thu, 09 Mar 2023 14:27:51 +0100
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfeCWQC/5WOQQ6CMBBFr2K6dkxpQYwr72FcTMsAjdCSFoiGc
 HcHdi5ZvpfM+7OIRNFREvfTIiLNLrngGfT5JGyLviFwFbNQUmmZaQljGJyF1N/yQsI0pDES9jD
 0LJvO+Tdoo1Ga0thKa8EZg4nARPS25ZCfuo7lEKl2n333+WJuXRpD/O5vzNlmDyzOGUiQRqKts
 eIberDGGC4hNmKrz+poUXGxzGpCVVzzMq//iuu6/gDYO/DtOAEAAA==
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  16 ++
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            |  67 ++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  19 ++
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |  45 ++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  19 ++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |  45 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  19 ++
 arch/arm64/configs/defconfig                       |   4 +
 drivers/soc/qcom/pmic_glink.c                      |  63 +++-
 drivers/usb/typec/ucsi/Kconfig                     |  10 +
 drivers/usb/typec/ucsi/Makefile                    |   1 +
 drivers/usb/typec/ucsi/ucsi_glink.c                | 320 +++++++++++++++++++++
 13 files changed, 616 insertions(+), 14 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230130-topic-sm8450-upstream-pmic-glink-3b3a0b7bcd33

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

