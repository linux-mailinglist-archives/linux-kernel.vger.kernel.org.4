Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0F56F58AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjECNKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjECNKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:10:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3495264
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:10:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3062db220a3so2410193f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683119439; x=1685711439;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGhjoHsqtpGAvCt96yR+CnnEwvBFAtRaMqZAarDkXaA=;
        b=YhG45OPWvg/KpGncWxjG8rSHhly+z9qC3UY7/iGT/zTm6UM5PbEIo1cMAUWoRflAKw
         /FCnXVZecHknk+kn1bBahKKu6r5Ux56T6ruDxvaXcN+9RZnQiYt4QlwaY7LnJoWpzxt0
         KArwOpw2/iDBqFR/rXgDFFbdQH/I6n6TrsYs3uG7EdOdJZpyea6My7asGIC0r7og8aPr
         8cKpfXweTA0XJw/RnAnELw3PyGuYvmFLmBw1lqMfjELx0okO2nd6ibGRk1x8s5WAAsTQ
         PrIYtpMdK+LfZsg7kaQNH2WNV7p8/JbUhavyEFqtSmvm8V9HsgCLxUmSrD8CFbYmOapN
         mdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683119439; x=1685711439;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGhjoHsqtpGAvCt96yR+CnnEwvBFAtRaMqZAarDkXaA=;
        b=KRsrCa8EzMrDejKG0F+JmrYKjrF5rcn6uxGHyq94h47XseXYcPSJgn5n7bRYJEHTP1
         wmZDQxyYbuQlszuXdlxoqomD4Sz8YB5tOHRjDaTETxq4t56tTZnRHFT7aapLaGgOS0SG
         P3Pi2HmxF/uomj75S7NOeLdkmyxoPl9+bxR/kSDx2PUrjNSgWFl7BxzjSA6yc6skdCpC
         0CAl6FdvgXBHWx7t59DtTcq4QLOtY3b/7jOIDhfjkG/PLbCwsyYmb68Bg9DxqN1P+u+5
         8TO670pCzOJuRcaymhoxvGR2zslyokQJia3hdp0pbhbpydinHTKDA1WhBsT+89qK8LOb
         yM8g==
X-Gm-Message-State: AC+VfDxnO10s8OvNisc+BtX4fsCRCKHpb5uwsHU/Pd9HqGyyYGLidbXf
        mJit4cHSJBTLIrZSjlUnPUKt0w==
X-Google-Smtp-Source: ACHHUZ6H6rMEcexyjbQ76KEEHrcdFlTqDgcGpY5IB+Xv3dbWBDpeQnZ3XIOY8tmrT9xqFmUgNrFIDA==
X-Received: by 2002:adf:cd10:0:b0:306:34ae:6a23 with SMTP id w16-20020adfcd10000000b0030634ae6a23mr80497wrm.5.1683119438816;
        Wed, 03 May 2023 06:10:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b00306344eaebfsm5413479wrr.28.2023.05.03.06.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:10:38 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/6] arm64: qcom: sm84[34]50: enable DP altmode on USB-C
 Connector
Date:   Wed, 03 May 2023 15:10:32 +0200
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEhdUmQC/x2NSQrDMAwAvxJ0rsBxli5fKT3IthoLUsdYaQmE/
 D2mx5nDzA7KRVjh0exQ+CcqS6rQXhrwkdLEKKEyWGM7M5gO1yWLR/3c+sHgVChH8YohY+JtxTa
 Qu4+WeLwGqA1HyugKJR9rJX3nucpc+C3bf/p8HccJ63ehaYQAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MguxGlBFp7LECZBwSsQYwigxpYUvCvs4cPcikosbYP4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkUl1LdczO4fUc0a5fL4UK3klFWGWxVU63pXBVsGxZ
 OqU9VPWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFJdSwAKCRB33NvayMhJ0ZsmD/
 0TPSbP+An/zeK+WCLDmvG1X1QZxc1rpnXMuYYJTGqNMAbEdivzMBlFqUTTU83M/veQg01ZlKnwuD8B
 YQQ5f33pNfV2BtW7m5lR+euFF7lOrax5Kg5PPi5jZQHBdo9bblz1YwsMyWpUIA7JlWzPpkZuOK2SDr
 ICJKIa6jVk0F3onTAU49sskw6vxZry0jbMY99OTPoMGJLIUbZD4Q+aRf3MBwRbNTDwgWKYwQFjJzHI
 CadeVVVBVQn/lpc0WP2FBR6DZBqtJgLkyFdGL6lIe4/8RY8yfZ0SraVzq0KZ+wX6YC2zMvxTG4F89V
 hKGZj4nsybmEIY9P2q78SmI3R0C6WpoBgrMki0x5UvggK+vT/kY2xXCwZZCuqC8vRlRy3K5OcQkv1U
 nsTUeHb7uooGpJYtf2jUlgjzQYoPuZWLHMN/+1SVmN12IXigRJpfibb7NppwwTxu5frMZ7o1WI3+l+
 ZgIDPWGunlQrA2JvVFG/vnOXXb0glnVNiHg1Mgo244Qo67NlZ+I/FqjncUTLkByiarUDT9HpuZT+Aa
 rHSxvCBKSOPQTDv+C9D3gUuChfcJFhV+rq5nOo643jCA7srZrCe235lMHcWqXgRA53mQ099IpR76AL
 hYov9E7j5iIgtPJPhobC1509UZ5y7Dr/OxMkQUcnxOKbRVn6B0XsnXPDBCig==
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

This is the final step to achieve USB-C Altmode on the HDK8350
and HDK8450 now DP controller support, USB3+DP Combo PHY and
pmic glink support have been merged for those platforms.

This patchset depends on the QMP Combo USB3+DP PHY orientation
support at [1].

The following has been successfully tested:
- USB-C PD Power Role, reported status are coherent
- USB-C dual-role data
  - USB2.0 only (no-PD) as DFP or UFP
  - USB2.0 + USB SuperSpeed as DFP or UFP & in both orientations
  - USB2.0 + USB SuperSpeed + DisplayPort Altmode in both orientations
  - DisplayPort-only Altmode in both orientations

Data role and SuperSpeed lanes were correctly switched on the PHY
side after USB-C removal/insertion.

[1] https://lore.kernel.org/all/20230425034010.3789376-1-quic_bjorande@quicinc.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (6):
      arm64: dts: qcom: sm8350: add ports subnodes in usb1 qmpphy node
      arm64: dts: qcom: sm8450: add ports subnodes in usb1 qmpphy node
      arm64: dts: qcom: sm8350-hdk: Add QMP & DP to SuperSpeed graph
      arm64: dts: qcom: sm8450-hdk: Add QMP & DP to SuperSpeed graph
      arm64: defconfig: enable FSA4480 driver as module
      qcom: pmic_glink: enable altmode for SM8450

 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 74 ++++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 26 ++++++++++++
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 71 ++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 26 ++++++++++++
 arch/arm64/configs/defconfig            |  1 +
 drivers/soc/qcom/pmic_glink.c           |  8 +++-
 6 files changed, 200 insertions(+), 6 deletions(-)
---
base-commit: b3afd23af1d1a8b690d512be825a7a8aef991eff
change-id: 20230503-topic-sm8450-graphics-dp-next-1dab962ae67d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

