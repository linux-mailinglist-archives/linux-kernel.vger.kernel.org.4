Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3116BCEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCPLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCPLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:48:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58DCB32A6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:48:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t11so1982840lfr.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678967289;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V40UIBIV7hPTyX/krWtJpPy79uZEnLvClqZyIUwEw58=;
        b=qrFkwj8IWa1ErWQQKZoWfrHsIfYbFmOytJSE4xDu/1lN/+BCXv1jEIG9DzTWCy4f/5
         IuOKCpXL5miDCH4g5mviJesNrq87Y9Q/KNfqf6c/YpfSAai6CsCDMzm2wu3GtxXL2Nfu
         IlDOiaKtZYkcaWwYCQfJ+nIh1vsgCoLxDm6PDSe6Kale0SXdpSd05pGqj3AHEjBOMxUc
         LJTlj7adWW0Pc0xWpgREfvxSRBG46tKlS092U8GAzPt1pqsT4ePLfyagTfn4HA9KCT0/
         EYMBYIQb1evq7iWFnbipkPb6TanzuCl8fgsPM/HzEx2m18VJng4dpD+/BolzbYpl/dQ6
         K02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678967289;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V40UIBIV7hPTyX/krWtJpPy79uZEnLvClqZyIUwEw58=;
        b=NLayk4QAEMsYPpAgFmVUk3ysjAt3+3QX/2CcUzLP4nqNhPgx1Z23yAZP6uFwtiOglJ
         eqKk0uzdKgsChceXCHLDhAsD2CjW9rf6ND2XgI6jGSEDJidJyqFZ5MFqICD7PNkZppWG
         K4l6SaxdHMIJwk7uV0lyyPm177gwkQoL//E9XvnYqzgpOJP3STefJ4EXdehI+qMPdU+r
         FLHpy3O0bVZOoWxuz1hYmMWj4XsScNah5sms1oklai+xPKJqPLIc/Yd/4F+zbMMroMLx
         1N7yVjPwvamAOeMZ7thzybsocw7WlRbM+iamiBftEjI38e8plB+R1DgcDP8BDVoCb1x/
         ML8Q==
X-Gm-Message-State: AO0yUKVixsd1fE6ECcuSIpHz87MiUAgRYa1+9WOlXlH0Zml8iBEFUYYT
        4QTym4959az7RmTLxBD+Sk10qhFVPGiXpdMBveg=
X-Google-Smtp-Source: AK7set/C3J+hKoy8p5SVN27Bdz6nNj11Ttf/edmmDJfaDcNpZfXUIzTUtPem/lQS0E7om5Fw85B1lQ==
X-Received: by 2002:ac2:5291:0:b0:4cb:4362:381d with SMTP id q17-20020ac25291000000b004cb4362381dmr2675416lfm.62.1678967288875;
        Thu, 16 Mar 2023 04:48:08 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512390e00b004d5a720e689sm1198443lfu.126.2023.03.16.04.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:48:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Add MDSS_CORE reset on QCM2290
Date:   Thu, 16 Mar 2023 12:48:03 +0100
Message-Id: <20230316-topic-qcm_dispcc_reset-v1-0-dd3708853014@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPMBE2QC/x2N0QqDMAwAf0XyvEJrRcZ+ZQypaZwBV7tEx0D89
 4U93sFxBygJk8KtOUDow8prMQiXBnBO5UmOszG0vo0+ht5ta2V0b3wNmbUiDkJKm8PkY9f569S
 HDBaPScmNkgrOlpd9WUxWoYm//9v9cZ4/nJK5J30AAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678967287; l=612;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=djwBa2GsaQLC2NA83jAfHWizjbkVqG1wW5ZrGNmb/Hk=;
 b=fIA0g+UN19lyeiN2LIzcvGxtg5q5XRV2cAv9wUaqYxTbkYiKo5VKE6+hsxls7FJpSPbsIwgSRm4B
 LPOq0YOlAgP7gsI4n0hGvHpL1gal+LddBWWlkz0IjCKL+pvLBIgN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MDSS_CORE reset which can be used to reset the state of MDSS.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: clock: dispcc-qcm2290: Add MDSS_CORE reset
      clk: qcom: dispcc-qcm2290: Add MDSS_CORE reset

 drivers/clk/qcom/dispcc-qcm2290.c               | 7 +++++++
 include/dt-bindings/clock/qcom,dispcc-qcm2290.h | 4 ++++
 2 files changed, 11 insertions(+)
---
base-commit: 6f72958a49f68553f2b6ff713e8c8e51a34c1e1e
change-id: 20230316-topic-qcm_dispcc_reset-ca034408f61d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

