Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C067774EDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGKMSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGKMSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:18:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C723E69
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6fdaf6eefso87498911fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077906; x=1691669906;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ge+hjy1ytS3fWV6a0cnAiNI+XNr+wbfujfaDkKlcW1Y=;
        b=lKGVu4/leGvJTRgUrgFiHw0Xqd08JRXEdUBnLtOufAfgIMn7SPWxrOrNBNKMfsnioR
         +MTqd/mpBGAIF8ftjonFVh6XzyRm4JZnsDpB1wdipbSk7+CIebXTmGqYjpjjZxvsRYLt
         yxJ0p1hbGvul44m3GWLQa1GneolSJjYOBOTfyi95zHULpH5LT0nigldAQt9JLneMbyQA
         eR3S8QkcpjM0lTn9PeBUtdQp4ZuvdYQ8tp3v0hWk2MwtpaukiKA+SZjb+Ejh106ZAkpk
         8PNE7V3N1x0jSEGQ/GQiCPIYqOabGFccMavoeQzbhokUqH3eTEsA/bjgROlyiv6WhlHc
         8crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077906; x=1691669906;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ge+hjy1ytS3fWV6a0cnAiNI+XNr+wbfujfaDkKlcW1Y=;
        b=Dh1tCLBLQAfvkwm152aNSAd0YuiOOp91x+xFnibcOFObAW/DTck0n+/M0E6rNJkhWG
         /W4uFKQOKHUBC7hHj6W0PvuIWlUrvkUJE7XttHfr4SdBCKXxZsU8jmoThSFF6yRTWevA
         7ysC/WVnIf7lr+AbNoEa5K4BN8cGEkG0s+aDMbMN01ImpLkDGmPM5soh7EALeJAYFHyz
         pbwaC1SZNp46Ja2p3OLUUx8E5SRUm8OkX7LmJic7oIiXT7EGo3Dmq//t2ur2L1iqLPRq
         IWigiwScXvjNcd87xoefemqH60etMC2f5iC6qrlQTORG/HkQ2gcjourpa9SUb8oiEDBr
         sV1w==
X-Gm-Message-State: ABy/qLYjpyjhU0lJtqrwwSozFpztvvMa++kcrn/+lVNzLBgNTWV8HKnt
        5z5XlNsGY2X82npJO2nQqqjdig==
X-Google-Smtp-Source: APBJJlEe7jF73xVl9Xnl+Gn0QpIn+S2PUKPPg/0Lj/trUSzp9bNR52JqL2cta6wvrOqHJ7cTqdyIDA==
X-Received: by 2002:a2e:9216:0:b0:2b6:ec2b:659 with SMTP id k22-20020a2e9216000000b002b6ec2b0659mr12236809ljg.17.1689077905830;
        Tue, 11 Jul 2023 05:18:25 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/53] icc-rpmh multi-RSC voting groundwork
Date:   Tue, 11 Jul 2023 14:17:59 +0200
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHhIrWQC/x2N0QrCMAxFf2Xk2UKsD5v+ishoY2oDsyuJijD27
 wYfz7kc7gbGKmxwGTZQ/ojJ2hyOhwGopvbgIHdniBhPOOIUXmsXCtqfdRaiWY1Cmc6+YMkRR/A
 wJ+OQNTWqnrb3srjsykW+/6frbd9/lcHIh3kAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=7841;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Rei3R9n4uCU+u2iJ+J2m+Ko7NiZGPGkR7HWezlPw+hQ=;
 b=VpWSByJM2AvVTsGuUMxF9PX3d/YlFvF7k1f2BwyYhtmvirx+8MZ+C9lRN6l1gsja9k7POci2c
 LmuuJeAnqvnBq/QHVgrI4jt5neFMqEcH0znLMWQDoAhPEpr5v31Ieq3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many parts of Qualcomm SoCs are entirely independent of each other and can
run when the other parts are off. The RPMh system architecture embraces
this by giving each (loosely defined) subsystem its own connection (as in,
physical wires) to the AOSS, terminated by per-subsystem RSCs (Resource
State Coordinators) that barter for power, bandwidth etc.

This series introduces the groundwork necessary for voting for resources
through non-APPS RSCs. It should allow for lower-latency vote adjustments
(e.g. for very high bandwidth / multiple displays) and could potentially
allow for full APSS collapse while keeping e.g. MDSS operating (say
refreshing an image from a RAM buffer).

On top of that, a rather necessary and overdue cleanup is performed to
stop adding more and more arguments to the insane preprocessor macros.

Partially reverting (or reimplementing the revert) [1] will be necessary
to coordinate the rather complex relationship between the DPU and RSC
drivers.

The "Point x paths to the x RSC" patches won't do anything (check the
compatibility workaround qcom_icc_pre_aggregate()) until disp_rsc is
properly described in the device tree, along with its BCM voter),
but they prepare ground for when that happens.

I was able to test sending requests through the DISP_RSC on SM8450, but
I had to hack its clocks (_rscc_ in dispcc) to be always-on, as we don't
have any clk handling for qcom,rpmh-rsc today.

Boot-tested on SM8350 and SM8450, nothing exploded.

[1] https://patchwork.kernel.org/project/dri-devel/patch/1521827074-28424-1-git-send-email-ryadav@codeaurora.org/

Dependencies:
[2] https://lore.kernel.org/linux-arm-msm/113b50f8-35f6-73fc-4fc9-302262927c5e@quicinc.com/
[3] https://lore.kernel.org/linux-arm-msm/20230703-topic-8250_qup_icc-v2-0-9ba0a9460be2@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (53):
      dt-bindings: interconnect: qcom,icc: Introduce fixed BCM voter indices
      dt-bindings: interconnect: qcom,bcm-voter: Add qcom,bcm-voter-idx
      interconnect: qcom: icc-rpmh: Store direct BCM voter references
      interconnect: qcom: icc-rpmh: Retire dead code
      interconnect: qcom: icc-rpmh: Implement voting on non-APPS RSCs
      interconnect: qcom: sc7180: Retire DEFINE_QNODE
      interconnect: qcom: sdm670: Retire DEFINE_QNODE
      interconnect: qcom: sdm845: Retire DEFINE_QNODE
      interconnect: qcom: sdx55: Retire DEFINE_QNODE
      interconnect: qcom: sdx65: Retire DEFINE_QNODE
      interconnect: qcom: sm6350: Retire DEFINE_QNODE
      interconnect: qcom: sm8150: Retire DEFINE_QNODE
      interconnect: qcom: sm8250: Retire DEFINE_QNODE
      interconnect: qcom: sm8350: Retire DEFINE_QNODE
      interconnect: qcom: icc-rpmh: Retire DEFINE_QNODE
      interconnect: qcom: sc7180: Retire DEFINE_QBCM
      interconnect: qcom: sdm670: Retire DEFINE_QBCM
      interconnect: qcom: sdm845: Retire DEFINE_QBCM
      interconnect: qcom: sdx55: Retire DEFINE_QBCM
      interconnect: qcom: sdx65: Retire DEFINE_QBCM
      interconnect: qcom: sm6350: Retire DEFINE_QBCM
      interconnect: qcom: sm8150: Retire DEFINE_QBCM
      interconnect: qcom: sm8250: Retire DEFINE_QBCM
      interconnect: qcom: sm8350: Retire DEFINE_QBCM
      interconnect: qcom: icc-rpmh: Retire DEFINE_QBCM
      interconnect: qcom: qdu1000: Explicitly assign voter_idx
      interconnect: qcom: sa8775p: Explicitly assign voter_idx
      interconnect: qcom: sc7280: Explicitly assign voter_idx
      interconnect: qcom: sc8180x: Explicitly assign voter_idx
      interconnect: qcom: sc8280xp: Explicitly assign voter_idx
      interconnect: qcom: sm8450: Explicitly assign voter_idx
      interconnect: qcom: sm8550: Explicitly assign voter_idx
      arm64: dts: qcom: qdu1000: add qcom,bcm-voter-idx
      arm64: dts: qcom: sa8775p: add qcom,bcm-voter-idx
      arm64: dts: qcom: sc7180: add qcom,bcm-voter-idx
      arm64: dts: qcom: sc7280: add qcom,bcm-voter-idx
      arm64: dts: qcom: sc8180x: add qcom,bcm-voter-idx
      arm64: dts: qcom: sc8280xp: add qcom,bcm-voter-idx
      arm64: dts: qcom: sdm670: add qcom,bcm-voter-idx
      arm64: dts: qcom: sdm845: add qcom,bcm-voter-idx
      arm64: dts: qcom: sdx75: add qcom,bcm-voter-idx
      arm64: dts: qcom: sm6350: add qcom,bcm-voter-idx
      arm64: dts: qcom: sm8150: add qcom,bcm-voter-idx
      arm64: dts: qcom: sm8250: add qcom,bcm-voter-idx
      arm64: dts: qcom: sm8350: add qcom,bcm-voter-idx
      arm64: dts: qcom: sm8450: add qcom,bcm-voter-idx
      arm64: dts: qcom: sm8550: add qcom,bcm-voter-idx
      arm64: dts: qcom: sdx55: add qcom,bcm-voter-idx
      arm64: dts: qcom: sdx65: add qcom,bcm-voter-idx
      interconnect: qcom: sm8350: Point display paths to the display RSC
      interconnect: qcom: sm8450: Point display paths to the display RSC
      interconnect: qcom: sm8550: Point display paths to the display RSC
      interconnect: qcom: sm8550: Point camera paths to the camera RSC

 .../bindings/interconnect/qcom,bcm-voter.yaml      |   10 +
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |    1 +
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |    1 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |    2 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              |    1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |    1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |    2 +
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |    2 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |    2 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi               |    2 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |    2 +
 arch/arm64/boot/dts/qcom/sdx75.dtsi                |    2 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |    1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |    2 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |    2 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |    2 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |    2 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |    2 +
 drivers/interconnect/qcom/bcm-voter.c              |   75 +-
 drivers/interconnect/qcom/bcm-voter.h              |    9 -
 drivers/interconnect/qcom/icc-rpmh.c               |   53 +-
 drivers/interconnect/qcom/icc-rpmh.h               |   14 +-
 drivers/interconnect/qcom/qdu1000.c                |   11 +
 drivers/interconnect/qcom/sa8775p.c                |   28 +
 drivers/interconnect/qcom/sc7180.c                 | 1637 +++++++++++++++--
 drivers/interconnect/qcom/sc7280.c                 |   27 +
 drivers/interconnect/qcom/sc8180x.c                |   23 +
 drivers/interconnect/qcom/sc8280xp.c               |   27 +
 drivers/interconnect/qcom/sdm670.c                 | 1410 +++++++++++++--
 drivers/interconnect/qcom/sdm845.c                 | 1683 ++++++++++++++++--
 drivers/interconnect/qcom/sdx55.c                  |  863 ++++++++-
 drivers/interconnect/qcom/sdx65.c                  |  850 ++++++++-
 drivers/interconnect/qcom/sm6350.c                 | 1551 +++++++++++++++--
 drivers/interconnect/qcom/sm8150.c                 | 1714 ++++++++++++++++--
 drivers/interconnect/qcom/sm8250.c                 | 1772 +++++++++++++++++--
 drivers/interconnect/qcom/sm8350.c                 | 1830 ++++++++++++++++++--
 drivers/interconnect/qcom/sm8450.c                 |   24 +
 drivers/interconnect/qcom/sm8550.c                 |   42 +
 include/dt-bindings/interconnect/qcom,icc.h        |    8 +
 39 files changed, 12320 insertions(+), 1370 deletions(-)
---
base-commit: 82cee168d497ffcb79e4889fe3c7384788e89f4d
change-id: 20230708-topic-rpmh_icc_rsc-f897080fb207

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

