Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F83F71815C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbjEaNWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjEaNWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:22:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE86A0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4effb818c37so6541391e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685539364; x=1688131364;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIZPiJOryrYBNzDV98c5rF00N4czhl7JRYIFLL6eVDE=;
        b=tE0emTrSm9NQyVenD1GTAkMF6bvCt1cGL00lP46GIgghU5FL+whNQ94bXxDu07Nqmc
         GKamdIfxvYDEGucW1fWmwZ0eU2CRPwRqfBbdGlNOSbbJ/QlhSj2dNXDQbZe156n4wxZp
         C6U/8JeNf9MnNOi2hL7jrb69nQ2U8YEf9xiDPBbkOkjOVBVrikwSCXXMHWqy8AbAGD/I
         mdWQSdcpuCAglFEX78X4Sdr3owhIYl2IK7EtP87uHJwf08xU3LU7FFBo744cTwiBfqPR
         /F+pyfXakVR1aVmHNcGQpmnxURMi8SPXJPrkzHAAWrqODPGYDZIB7eHGd6GftY+e/byD
         19VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539364; x=1688131364;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIZPiJOryrYBNzDV98c5rF00N4czhl7JRYIFLL6eVDE=;
        b=Eh7KPEb9AVVHlYv1FgB+O/TRUjrmpHI+Y3+/TVcMvr/1V7Y06NA3G1KG+zN/Y0uTi2
         3wppduJO8okNM35z78jmmU65lEIp6fPRJMTZpI7Dy2J0+il816CxIIKa7kMASUIxy3Jr
         mo/tSDl8EaKBXaWOVi6KP9Q3ZdIS01FKYSJqyhByZSHNHQWg3TKjAhZZJPpF0PAPRR7J
         Zx7xKWGVQx6wqW74i6FV/M2mhfbbtSBsOLxRUMRcOZ+PBU1aaBdmWSfpXJexEoDQCpmJ
         lfKD7TR5OCMc/OcjUX2JLzBIZ8wRNzd8fhOjG1pPhlxaXcjpPRhGV+LsV+yxVHqk1ckp
         w9rw==
X-Gm-Message-State: AC+VfDyPsl/KnbmgyaCxypQO2jSKv271Dw6Z1ZRcWd9BmqMsLh6lMAwy
        MoqJM9BodyT00A+REHFlUVTq3g==
X-Google-Smtp-Source: ACHHUZ69cuPzxgFaBu/ndAZ/Jh0mzfaPzNG2OiEpJsxsJzTr0tCnhuHghDE45Y+hXakMT1wYSGfSMQ==
X-Received: by 2002:ac2:4c1a:0:b0:4dd:9a38:fcc with SMTP id t26-20020ac24c1a000000b004dd9a380fccmr2597905lfq.63.1685539363921;
        Wed, 31 May 2023 06:22:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w8-20020ac24428000000b004eb0c51780bsm720138lfl.29.2023.05.31.06.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:22:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/8] Flush RSC votes properly on more RPMh platforms
Date:   Wed, 31 May 2023 15:22:34 +0200
Message-Id: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpKd2QC/x2NQQqDQAxFrzJkbUBnEGyvUrrIjLEGZJSkiiDev
 aHL93mfd4GxChs8wwXKh5is1aFrApSZ6odRRmeIbUxtnzr8rpsUVCuYeh7SMNKDpgzuZzLGrFT
 L7I+6L4uPm/Ik5z/wet/3D/m8hRNwAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685539362; l=2037;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JZ68AX9UMXCzwIdH9lqsuXJaapN5UStvCJNTkI8Mj+8=;
 b=ORTrmJjKqdpwjFR3Ef9AKxSvaE6DTtZc1d7TLHHwp12L0cAOPlIES0MvS3S3LGxSz/AxR4Jmh
 GOR+J3KZS6GCaEJgQbWBIsWFVAxYV3whdi16uuGo7Fm7luAxpwKRd59
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

As pointed out in [1], the Linux implementation of RSC basically requires
(even if not explicitly) that we point it to a power domain which
represents the power state of the CPUs. In an effort to fulfill that
requirement, make it required in bindings and hook it up on all platforms
where I was able to do. This means all RPMh platforms, except

- SC7180
- SC7280
- SA8775

As there wasn't an idle-states setup (which may be on purpose for CrOS
devices, certainly not for Windows SC7[12]80s) that I could validate.
(Doug, Bartosz, could you guys look into your respective platforms of
interest here?)

This series also adds support for idle states on SM6350, as I was able
to add and test that.

[1] https://lore.kernel.org/linux-arm-msm/20230512150425.3171122-1-quic_bjorande@quicinc.com/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (8):
      dt-bindings: soc: qcom,rpmh-rsc: Require power-domains
      arm64: dts: qcom: sm6350: Add PSCI idle states
      arm64: dts: qcom: qdu1000: Flush RSC sleep & wake votes
      arm64: dts: qcom: sc8180x: Flush RSC sleep & wake votes
      arm64: dts: qcom: sdm670: Flush RSC sleep & wake votes
      arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes
      arm64: dts: qcom: sm6350: Flush RSC sleep & wake votes
      arm64: dts: qcom: sm8550: Flush RSC sleep & wake votes

 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |   2 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi               | 142 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |   1 +
 7 files changed, 149 insertions(+)
---
base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
change-id: 20230531-topic-rsc-35e838da9afb

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

