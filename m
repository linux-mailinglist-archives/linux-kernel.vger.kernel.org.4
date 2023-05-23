Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC63670D4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjEWHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjEWHP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:15:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB23186
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6094cb26eso6070055e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684826152; x=1687418152;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMCIjm0EWJ59bjTrTKGOEsB89wmLq+xJYAhJre88DaU=;
        b=QHMHfWV6KAgZW1LWIipqkPKRbVV/zFLdRDK1vLJfS7sMJn1+vEEgv3f43CiDov+RbB
         JiZ8HS8V0Qz9iVwf6F0H2dw7xi1efZXs9EoDI9rVrqWpW4vWiOjVky0ataJzJ8JaFo/B
         QS7VyJQuUWfG1hOLbeoNodHMnSjLAqaIebGU5Z/lRXxqQRfsAxGvEYMtp4T3bWo6XnHW
         BpiJXXT5o2ZEiGlO+1FEfcE0jjPPZAlD7Qjgn6U/EMTNjARl8vc8zDHU3C/bWvB8cL1Q
         uMXBw2TWdPncjfBOK6EqeNtPmsGolP2ZsB8auZlpUVWwsnrX7+h6o+CgJpAx2uFrSIHz
         D+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826152; x=1687418152;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMCIjm0EWJ59bjTrTKGOEsB89wmLq+xJYAhJre88DaU=;
        b=UehdkENd5uBqBC8sRF+aFNOxUnAMwsUWkc0qxDi39OMPHWJm5iITK3OwJ0rB0bUZMB
         7Jwww8FccPxv9kzlEb94xUIZWDtrsA8aeeKmtwQ0o7hcKwU2wVWNNE14WtRsNx8jCSJj
         ++xBU+jQvHVffHpTnm2MCnTW+OINWWkNp2NP2ZaUe9L1hILfSVRRlNs/PN9PBGQfkuL8
         J5BFOiCeBBFUFSHPNlRe9oqFnNs5uY825/Zk0IKiEBLL2PJ0ueG3H7yuaTNJjQ2mmkM6
         p9GjI8GXMpr0VfjEoDfzpwudRUBt1P/htHDn1RSFGCRAsgBcij1Xd5U/TRD+6Lq4BVCN
         2rVw==
X-Gm-Message-State: AC+VfDwJmdqPA62Z78Lhz0u7Qf1d3C5QLNIgMogG0xKjOxULG6hn7Zyw
        PnQ0C7YhNJwUG9Ocbgkfc/0idA==
X-Google-Smtp-Source: ACHHUZ6csuTfuCIx7D22LUAAHZ1wwbvaanW0tdyD510g2Pq6Y0BVg8/CWbycVKRYc3u8V5+ycC3AWw==
X-Received: by 2002:a05:600c:245:b0:3f6:7d2:9859 with SMTP id 5-20020a05600c024500b003f607d29859mr2771125wmj.6.1684826151946;
        Tue, 23 May 2023 00:15:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b00306299be5a2sm10096239wrq.72.2023.05.23.00.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:15:51 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/6] arm64: qcom: sm8[34]50: enable DP altmode on USB-C
 Connector
Date:   Tue, 23 May 2023 09:15:44 +0200
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACBobGQC/5XOOw7CMBAE0Ksg1yyyHciHinsgirW9JCsFO7JDF
 IRyd5x0dFDOFG/mLRJFpiTOu7eINHHi4HMo9jthO/QtAbuchZa6kCdZwBgGtpAe9fEkoY04dGw
 TuAE8zSMoh6YpNVJZOZENg4nARPS2y4p/9n0uh0h3nrfR6y3njtMY4mv7MKm1/XVuUiDBKaKma
 Kq7xvLSs8cYDiG2YqUn/RenM1ejNYYUNU4dv7hlWT4nnNQ4LwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hEXbIPaHVHV3s0TjgnFmct0gcpyj2Uw1ZgBBgoDcF1k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkbGgkQ/iiUtQbfcUKjnJznKYgNcICkN96EXCrkkBH
 yMpvQe2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZGxoJAAKCRB33NvayMhJ0YQdD/
 4ot8VHy04OWst4DTTRmrGJFDcQGsaUIRQK3AIXJsLJzAp3+pWaQmvHQETH443g1eqkbRK6YS3XRtJy
 yNvWSvukRos8Z41P2XHkWWn3ql29N4a6ouGfzeQtVYnWKDhlaG2ouZSVwGhNo9oat+j5GKEsYyseil
 WFAn/wj6Rw3djUkAduDEn71D9ptjRpO0aGmLe7/V9WtpDeMpr6zX+xObx0jMpKSi14zizrK1g9KhwP
 MLVfHM9uOi5Iz7kMSSGtUndEu/GoiYhHjt1bgbWcQUdQXYhQvzjJ8kWM6wz2aquJZbBBifE8CO10oa
 Nlt/rqN1Ksmgpv+kIipnYvks/6lTJvDLXG2Uuwiemc3BRl7FiyuP7gfFsTetyArm9RtmbkDq83F3z3
 D1LqoUO1lOSusWgpPdt5hEjWwcSWxcj3FhOk25jtQdL9HaiSMDSF3XU7usnKkc4g8WJlfwO1LSMiom
 X0sw4xV1x5nKawrz07ZihPCnnuVWpewFlFsaOd8VPM6CQjUf/twUKIXy/0VBzVWhQRUXfUP89+dILs
 dvKRVNUVZH33n9Kp+6sZ9fDtfZL1oV4s7GZ6OfQd8ChhxxUb3gIxaGVxHbL20uA3Z32u5m4gWVf7zJ
 t0sJLMsGtsIHusjbgFeoqTXkymkAu+HFH6zAdWVCPNO/Z7HucymzWez9cfmQ==
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
Changes in v3:
- Rebased on next-230523 now PHY patches were applied
- Link to v2: https://lore.kernel.org/r/20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org

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
base-commit: 8e7eb170057ce57f049f7b6749741d7b23d09af2
change-id: 20230503-topic-sm8450-graphics-dp-next-1dab962ae67d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

