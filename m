Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE475046F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGLKcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:32:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16A31998
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:32:35 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3942c6584f0so4873683b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689157955; x=1691749955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gW/Rn79XK+Jon3f7wv6t0M4u9Do+bTGAD75094KkDlA=;
        b=AKB+GTSaHk3kq6eQL8Ppv5Y493xUK+Ldnsux+eGTp0AvWXw8ooSAEY44HAyzYIm8Ln
         pZBtI4GHPsgh5Sqrow6NyaSybhVNEgjt1iNis0reg9/tHup7NTfyMobbj1BFysr9dPbX
         sSVX9+atlY9mIDX0SL90ifniWIFJaqLjcq1x6BInFSiPwWRgVcMvHoxUxrKPmnEPH8ft
         Yt7EpVm/e34biWKF+gQ3WllBXdbWW3wlROwPWefgqkTJ6NKuoX80bStnV7AboTW1EA08
         riv/82CTVT9eP4FwKXYby+b3Z5AQlrlzzdm069kDKiv5c5OhU1pWKfw1oYZP1WALU/Mt
         4d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689157955; x=1691749955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW/Rn79XK+Jon3f7wv6t0M4u9Do+bTGAD75094KkDlA=;
        b=lVubDbW6os8EKwlBW4Tu0VBm2oy4nOPw4rUvyqhqLJGYFuxiJn0LyfmaqUjt+yBfSg
         KjQ8IRHh5MeJ1iTNCgIsQ76ER3852GyyKIMVbbPXsrWv4cYCE0LHfD984pdDDJ9XoYcy
         CrjYJLVO04JIfSJJnQnScvZZViRAuHZ+xu9OgH/canUIu7u1ObswNLMiSfFaKo3NaQxq
         jc3+uHQci2Tlqh0CN08GYV7a4SrLE4eFJefeovz/s51pyVBIi5pgF1uTDe1sJ8xn22dC
         ZoStQiaJOGs2HV8mZq7D5zfMdiA2P1cf32GZYQmsStV1l/v7Nr74qPKHHRNX86GvYwsz
         lAGg==
X-Gm-Message-State: ABy/qLaHCoRxORWoTFi8J2i4lGfWZt74bNrTa8+5HlSElYqXWIMBzaAc
        lltu/S+qU9/+IkVOWwkLC4Wj
X-Google-Smtp-Source: APBJJlHrRbVOwjEDykKU3VS/JLdZbI3DQPaXVwR/4RwYHk98KK4TQ3GcyQXHCXG0cl8AgXwHOhFKFg==
X-Received: by 2002:a54:4f91:0:b0:3a4:2545:1cec with SMTP id g17-20020a544f91000000b003a425451cecmr1602518oiy.38.1689157955107;
        Wed, 12 Jul 2023 03:32:35 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:32:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/14] UFS: Add OPP and interconnect support
Date:   Wed, 12 Jul 2023 16:01:55 +0530
Message-Id: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds OPP (Operating Points) support to UFSHCD driver and
interconnect support to Qcom UFS driver.

Motivation behind adding OPP support is to scale both clocks as well as
regulators/performance state dynamically. Currently, UFSHCD just scales
clock frequency during runtime with the help of "freq-table-hz" property
defined in devicetree. With the addition of OPP tables in devicetree (as
done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
both clocks and performance state of power domain which helps in power
saving.

For the addition of OPP support to UFSHCD, there are changes required to
the OPP framework and devfreq drivers which are also added in this series.

Finally, interconnect support is added to Qcom UFS driver for scaling the
interconnect path dynamically. This is required to avoid boot crash in
recent SoCs and also to save power during runtime. More information is
available in patch 13/13.

Credits
=======

This series is a continuation of previous work by Krzysztof Kozlowski [1]
and Brian Masney [2]. Ideally, this could've split into two series (OPP
and interconnect) but since there will be a dependency in the devicetree,
I decided to keep them in a single series.

Testing
=======

This series is tested on 96Boards RB3 (SDM845 SoC) and RB5 (SM8250 SoC)
development boards.

Merging Strategy
================

An immutable branch might be required between OPP and SCSI trees because of
the API dependency (devfreq too). And I leave it up to the maintainers to
decide.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220513061347.46480-1-krzysztof.kozlowski@linaro.org/
[2] https://lore.kernel.org/all/20221117104957.254648-1-bmasney@redhat.com/

Krzysztof Kozlowski (2):
  dt-bindings: ufs: common: add OPP table
  arm64: dts: qcom: sdm845: Add OPP table support to UFSHC

Manivannan Sadhasivam (12):
  dt-bindings: opp: Increase maxItems for opp-hz property
  arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
  arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
  arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
  OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
  OPP: Introduce dev_pm_opp_get_freq_indexed() API
  PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed()
    APIs
  scsi: ufs: core: Add OPP support for scaling clocks and regulators
  scsi: ufs: host: Add support for parsing OPP
  arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
  arm64: dts: qcom: sm8250: Add interconnect paths to UFSHC
  scsi: ufs: qcom: Add support for scaling interconnects

 .../devicetree/bindings/opp/opp-v2-base.yaml  |   2 +-
 .../devicetree/bindings/ufs/ufs-common.yaml   |  34 ++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  47 ++++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  43 ++++--
 drivers/devfreq/devfreq.c                     |  14 +-
 drivers/opp/core.c                            |  76 ++++++++++
 drivers/ufs/core/ufshcd.c                     | 142 ++++++++++++++----
 drivers/ufs/host/ufs-qcom.c                   | 131 +++++++++++++++-
 drivers/ufs/host/ufs-qcom.h                   |   3 +
 drivers/ufs/host/ufshcd-pltfrm.c              | 116 ++++++++++++++
 include/linux/pm_opp.h                        |  26 ++++
 include/ufs/ufshcd.h                          |   4 +
 12 files changed, 574 insertions(+), 64 deletions(-)

-- 
2.25.1

