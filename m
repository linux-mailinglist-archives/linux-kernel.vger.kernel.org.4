Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1523692160
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBJPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjBJPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:02:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8437737735
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:02:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u10so4020767wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfoF3LxZ7FuaoMpPGi3DPf+5A6Pn53XBVXLoatUwlOI=;
        b=x09ZDNm+B9yTe3oLr5AHzfAadepjTiaWyQohF/GdUFUCDwJAIdr5mqmQVOOcxKh4x1
         wjtMFdyqCfDu9Wi2ccT2wfV2eidIO2EEZgoYrBsf3ny07ZaoASVLLHT6TkA0+a1RKy/G
         N976Ggs6li4CINwBCIQeFfdFqLj1F6930eXa/34XOvj+Mkoawk1J0XdeU9aHE7dEX6c7
         u/BQDBpwzWhErft0ntBJ+kbN/4OfQQaTPtW3Sarv3ebudEkdNDGdG/LU8UWDKoo0448z
         nneBI3eUSKR8sETOtMJXeEJejbB9uoHszQD4k4z33mrM17BXAhbOa7wRV5HDPgz6ts7d
         G34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfoF3LxZ7FuaoMpPGi3DPf+5A6Pn53XBVXLoatUwlOI=;
        b=Kox+3+gqjDmijgbEvT4GQblqOJzGmOGHvBsUXsMVz+uauraF8hyf2KLxonsZY8wdw5
         twM/RQ3P1fDcC0uiq5mjxmdjLMT/KNqSCrX/olWGnzmjC+A6eY3j7kPYD37TEn8LjE67
         jFlUwVWo9Dw+7qQhcX/sbXwJ0zRuSIxdzPxK5+trVRfMNSxKD/23FGZfMThZaSjX4rVE
         bEikDnR9Q+M5EJHxHwM7P+wqdoEySzPpyrM3nLEd+K1b6WdC51WaLhEdf0pQH3MMiyTc
         xK3bky0x37QI+4RCtNSxLSMYd+fizg2lmlLsD8RPYio4+dPzeqcjd+WJErPOcepLpFT6
         rQCA==
X-Gm-Message-State: AO0yUKUE2HLoZP0EtIInUmpfFDtlwbOPno+05uvexebO2i/4XRjldnuK
        FDfe4+ba5EDSvAS1S5PEmSGEjg==
X-Google-Smtp-Source: AK7set/LH212DvxwEitxNs91cTmT2ZI61PHfX4jFahcrfOSv+ZuMHAS4aedTb9hAoVNMLzm5MRWJOg==
X-Received: by 2002:a05:600c:319d:b0:3dc:5950:b358 with SMTP id s29-20020a05600c319d00b003dc5950b358mr14257527wmp.14.1676041329010;
        Fri, 10 Feb 2023 07:02:09 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w23-20020a1cf617000000b003db1d9553e7sm8282482wmc.32.2023.02.10.07.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:02:08 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 00/11] soc: qcom: add UCSI function to PMIC GLINK
Date:   Fri, 10 Feb 2023 16:02:03 +0100
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtc5mMC/5WOTQ6CMBBGr2K6dsxANRpX3sOwmJYCE6ElUyAaw
 t0duYHL95LvZzU5CIds7ofVSFg4c4oK5fFgfEexDcC1simxtFhYhCmN7CEPt/MFYR7zJIEGGAe
 Vbc/xBdZZQnd1vrbWaI2jHMAJRd9pUZz7XuUooeH3vvuslDvOU5LPfmMpfvaPxaUABHRIvqFaM
 +GhmiSdkrSm2rbtC0ePH6HmAAAA
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
X-Mailer: b4 0.12.0
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
Changes in v2:
- Moved the dwc3 port subnodes to dtsi
- Added SM8350 HDK support
- Added help about ucsi module name
- Added bindings acks
- Fixed sm8550 pmic glink compatible
- Added more description in config update patch
- Link to v1: https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org

---
Neil Armstrong (11):
      usb: typec: ucsi: add PMIC Glink UCSI driver
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8450 compatible
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8550 compatible
      soc: qcom: pmic_glink: register ucsi aux device
      arm64: dts: qcom: sm8350: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8450: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8550: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8350-hdk: add pmic glink node
      arm64: dts: qcom: sm8450-hdk: add pmic glink node
      arm64: dts: qcom: sm8550-mtp: add pmic glink node
      arm64: defconfig: add PMIC GLINK modules

 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   2 +
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            |  77 ++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  19 ++
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |  45 ++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  19 ++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |  45 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  19 ++
 arch/arm64/configs/defconfig                       |   4 +
 drivers/soc/qcom/pmic_glink.c                      |  67 ++++-
 drivers/usb/typec/ucsi/Kconfig                     |  10 +
 drivers/usb/typec/ucsi/Makefile                    |   1 +
 drivers/usb/typec/ucsi/ucsi_glink.c                | 320 +++++++++++++++++++++
 12 files changed, 604 insertions(+), 24 deletions(-)
---
base-commit: 2746a238ae3ea7215b3e95b78020a3d72243d55f
change-id: 20230130-topic-sm8450-upstream-pmic-glink-3b3a0b7bcd33

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

