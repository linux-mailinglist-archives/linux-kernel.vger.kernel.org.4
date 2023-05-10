Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF96FD96E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbjEJIcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbjEJIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:31:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EBD30E6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so1349355e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683707506; x=1686299506;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6/8dciljmKXjO5B/G4gS/fyc4Xic7p1ydUeagA+MqQ=;
        b=OUhXzgJ1bt6NDAd1klWenZ1K7TEF6xZa21lYvBajP59vB15PYazc5hmq4AoDVYUJT6
         uAmjvq/NWMdOLmCf1wpiEgdRPCALHL//7ZWfN+kjz6HuMe7ZmgO5/osMd1FjjcAEcDKp
         TK6hcUU/S/xIRg2EtBIgdvSae1FCQefFOrXtWLfCMe0+6LV9N6KkjlF1BAJyy+Ie1rON
         A507wodroEXZAy561XNqchYdG1WdRWRdGRWE2JZyL2N+frYDHkQXpG1yU5p8/A9S++WC
         TxbTu9cDeKjYBJUkrIS4hmCKJN4LsXivPbQ2dqfHunh68sqCck6l7O6BRncOBDhut7YD
         whnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707506; x=1686299506;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6/8dciljmKXjO5B/G4gS/fyc4Xic7p1ydUeagA+MqQ=;
        b=jybE4I7BzYXkrNs6NGuv2Y+yh2BfiLPMSgMcwyQS/9qyjn/9Ld4jdWcaeLUA/pKu5v
         4IxcqFX6XTeUOzNSuQj3n97KNtTr42ZM5vO5MzrmRmMmEcMkVB6Ka0OXsJ31clqQiZ05
         Rd/sOJ3oeaFk486usJq8at+Wu7JZHCbwYBiYT8pK+DXZ9F95Ufz5xrlldNQ/0HgtPzHi
         ycklMwIWiVWwT1XO9LVnUpeST6SFvJFeJK/i/Qn3RAp/Rn7y7fDCrvmbjXeWheJyGu43
         Lyb6UestwSe7Vjhm/2Y4LAwaWF6by0gAUFxpft/mCbJsIF+Y0xIdtUy5atZzigUVoamn
         SjmQ==
X-Gm-Message-State: AC+VfDzcAYt94+lx4gWjlchK1QAue6b9093ApKnzJ8kpXCHvFMII2PGD
        OMYHjU7cmoHjdHReg5TJM5ONHg==
X-Google-Smtp-Source: ACHHUZ7z7VIXhIhWsH7MtjcPdFGM0TKW1D0IQrZ6MAVNrXddhYlCDe/SJBW3zbnfJLt11Zj2urBakA==
X-Received: by 2002:a05:600c:20c:b0:3f1:812d:1da3 with SMTP id 12-20020a05600c020c00b003f1812d1da3mr11591599wmi.0.1683707506033;
        Wed, 10 May 2023 01:31:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003ee74c25f12sm22108737wmk.35.2023.05.10.01.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:31:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/6] arm64: qcom: sm84[34]50: enable DP altmode on USB-C
 Connector
Date:   Wed, 10 May 2023 10:31:38 +0200
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpWW2QC/42OQQ6CMBBFr2K6dkwpAuLKexgWpR3oJNg2UyQYw
 t2tnMDle4v//iYSMmES99MmGBdKFHwGdT4J47QfEchmFkqqUlayhDlEMpBet2slYWQdHZkENoL
 HdYbC6r6tlca6sSJv9Doh9Ky9cXnFv6cpy8g40HpEn11mR2kO/Dk+LMXP/ptbCpBgC8S2bJtB6
 foxkdccLoFH0e37/gUc6MwZ4AAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ttEQEsjvPQWp2h4M0SrBo7wcXJP9LjcD2YCXbuw2NgE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkW1Zuy32NdfAaC6MBhzZMzrMIbEA34eA6urz6qlTx
 01g0ksaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFtWbgAKCRB33NvayMhJ0ZCoD/
 kBEAP3RBdMYhvQnR8B+MJrrgU7fR0fLNbVwRp/bB5Q4tBC/sGgvWSbKjDWQWH99ObURIgWvbEMGLL7
 qcogjTj1DE2Lo7C//uvq3zqixfG+MbyqOofjt2RNSr57SldF6xt7qxexCKWeTJf4iUjBHHW81voHk9
 eXl83pOxXKxJX4IJoCUXzvg6NJ/v2kEypQ4jLsaNwBp+tGVgQamvQbhv2Lz6bwDvTN+B5yt/7Adijd
 qTqDjlvb7Qi4VAKhNjki0vOLL2Z2Kbwm+x1Eq4+9NrdvmdJD3uyTktwKqD9NFXxzg7hww3fUQPlDyS
 /A9GzLYdRq3dQc768pCB32DGIEwsAtx2t/ofNDvfmVAbArzGapFtcS/bWUgrUlSb97Uv6EGDM+R4DK
 QZRAOuac14GzyztPDntqLaKQpl9uScIgqPUgY+OPqHUpVRi1gXKTiJNaN9Wy0Ct+KqfQ+mDCE3dws2
 L6QXYQl2lsrcbBKZ30GeHtTxi3tnMN4zupwBeh3dZk1hCuzobJqhQBhSTDHdqyzJw2UcjAukaW/smX
 y/dOXX1XWBwgE8J/t4O/zuDZyrNcu6TbIyF5INvqYuooBruxBDKM1ZZUtai/66DDBP8EpI+Ym1/5Cq
 CnBOwC/2o7wyf1j1v+ulCSHTtUPRnUsLkhfmZuQ9j1+1x/H8Ol3dL2kHtAdg==
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

[1] https://lore.kernel.org/all/20230510031930.1996020-1-quic_bjorande@quicinc.com

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- rebased on next-230510 + orientation patchset v2
- define port@2 in patches 1 & 2
- Add reviewed tags
- Renamed fsa4480 node name
- Added missing blank line
- Moved status at last position
- Re-ordered node ref
- Fixed commit message of last patch
- Link to v1: https://lore.kernel.org/r/20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org

---
Neil Armstrong (6):
      arm64: dts: qcom: sm8350: add ports subnodes in usb1 qmpphy node
      arm64: dts: qcom: sm8450: add ports subnodes in usb1 qmpphy node
      arm64: dts: qcom: sm8350-hdk: Add QMP & DP to SuperSpeed graph
      arm64: dts: qcom: sm8450-hdk: Add QMP & DP to SuperSpeed graph
      arm64: defconfig: enable FSA4480 driver as module
      qcom: pmic_glink: enable altmode for SM8450

 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 76 ++++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 26 +++++++++++
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 73 ++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 26 +++++++++++
 arch/arm64/configs/defconfig            |  1 +
 drivers/soc/qcom/pmic_glink.c           |  8 +++-
 6 files changed, 204 insertions(+), 6 deletions(-)
---
base-commit: 4f3cab37420881679d82cecb21f18bc7d88fdd83
change-id: 20230503-topic-sm8450-graphics-dp-next-1dab962ae67d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

