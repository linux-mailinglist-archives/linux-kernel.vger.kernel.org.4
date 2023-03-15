Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C34D6BB58E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjCOOLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjCOOL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:11:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C366E474F8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:25 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y20so1898027lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678889484;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gO6ONgIrBdOAK3CDxsNhHEwowo3Jgb99AQwPcV025f0=;
        b=Y3bduW3boH9SzR/V4dovmyAs2MA3ckNYKgli86J+7+Zgjvrv0vqxzykJTC45EeSwqD
         CRBMJBmEHtfzqWJkGBRGLkZCmYNzbOmn10qW4v3epz1pXdQ+f8JptWPVI1zMYRzpneyZ
         8zoR73fhrHTwrGAq6/54nqHaNkAiFnJMmO4dnfN8/0D5daQTA5y33PtSVeRhW3rb9qY3
         WvBrXqIEiaM1pLu8UgD639FmWfeOsoKDjvsxOnIJp3GRmtRY94qkNAVO+WrT8fgiwWvM
         gF9lf87H3xNmH0aCSPRwHa70ZsKWz2AVo3mQ34OhZswhw5vJs+8r5WERc7fJr91ltEcE
         8ftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889484;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO6ONgIrBdOAK3CDxsNhHEwowo3Jgb99AQwPcV025f0=;
        b=GMM/w/5DIefZ3lGibqt4TxDwx5XPS4z5B2f+BuhghM9awuIOyfZwk8lldxzEJF/BMM
         /Mx7za8/FE0R3fWNnaJdx7MycQFoFOek5+PWmJSyAo53WIURz4JlA5WD1PuXxTrj9EW6
         BbHPpNGwaVB764HlRnQozWe01PnbxfPdPgTsntzgWCOipX4m03bL944i6a2FryNthjNg
         hKRvOjnpDfy9Op8u21ZlndaepN1ZQsPVYOxS9hF67A6Lp/Zl03TMB0kAxj0csar1bz7W
         9K/niePS/LhYzQvYY2OVKmqWWssxmGXKtJu+CicYwNYo10sSZ5xzK/YNwZysNCm40z6K
         S7Jw==
X-Gm-Message-State: AO0yUKXAYD2IezCZJDZzAIEVlv8s75K+PTNwaPBpbOSHJs74g6hWuqUk
        FBJ1/AnyJsy8Px9wVPjXNxLLQw==
X-Google-Smtp-Source: AK7set/m/1iHF7CmFAbkUW3HNz5L9f09fw7Ur0wz9Oa6IZY5DqypNTD7VHzkDNDt5b4ceuHhFpRq0Q==
X-Received: by 2002:ac2:53a1:0:b0:4b5:3505:d7f9 with SMTP id j1-20020ac253a1000000b004b53505d7f9mr1802683lfh.35.1678889483923;
        Wed, 15 Mar 2023 07:11:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25e88000000b004e845a08567sm824678lfq.291.2023.03.15.07.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:11:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/7] Fix BWMONv4 for <SDM845
Date:   Wed, 15 Mar 2023 15:11:18 +0100
Message-Id: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbSEWQC/4WNywrCMBQFf0WyNnKbNH248j9EJC/bCzUpSY1K6
 b+bdudCXM6BMzOTaAPaSI67mQSbMKJ3Gfh+R3QvXWcpmsyEAePAoaSTH1FTY8JVPe/e0QpaYEw
 bYbkg+aVktFQF6XSff+4xDHkcg73ha8ucL5l7jJMP762ainX9HUgFBWpFxRteG12b4jSgk8Eff
 OjIKkvsj4BlAZRGtU1rFIj2S7Asywd5/7gkBQEAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678889480; l=4225;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5a2gTnVJHInN9xxdIxmrs7yt7ArHpi5O35VOWBjCFEY=;
 b=ezzKac7bBxFqaUZFr4Aie16BW3XwT9ZGqOhZPvlTuQ3uUhVvPIbVF67niLv+giqf4ZU+YqWqXRqL
 0pgZg/tOA4E2rX0B8Dl4Dx+Nz0SkvLk5oCJBTjTpdY9Z+2MpXNEy
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
- Rename: "DDR BWMON" -> "CPU BWMON" [2, 6/7]
- Set F_IRQ_STATUS = F_NUM_GLOBAL_FIELDS in enum bwmon_fields to save
  one space in the enum
- Correct the struct icc_bwmon->global_regs array size
- Reorder the "Remove unused struct member" patch to come before the big
  one

v2: https://lore.kernel.org/r/20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org

v1 -> v2:
- Un-mess-up the example in bindings
- Correctly limit reg/-names in bindings
- Introduce "qcom,sdm845-cpu-bwmon"
- Fix incorrect register assignment in msm8998_bwmon_reg_noread_ranges
- Clean up the code around setting global registers on <=8998
  - Don't add a separate enum for global registers
  - Don't use _GLOBAL vs _GLB
  - Add of match entries for targets that abused qcom,msm8998-bwmon before
    to keep old DTs working
  - Add comments near of match entries to make things clearer
  - Instead of if (...) { write to x } else { write to y } make the global
    register variable to keep the code more readable
- Add dts patches to stop improperly using the 8998 compatible
- (grumpily) drop Fixes from [2/7]
- Pick up rb on [3/7]
- Re-test on MSM8998 and SM6375 (OOT, uses 845-style BWMONv4)

v1: https://lore.kernel.org/r/20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org

BWMONv4 (the one used for DDR scaling on all SoCs from msm8998 to sm8550)
features two register regions: "monitor" and "global" with the first one
containing registers specific to the throughput monitor itself and the
second one containing some sort of a head switch.

The register layout on all BWMON versions an implementations up to that
looked like this:

|..........[GLOBAL].........[MONITOR]........|

however with SDM845 somebody thought it would be a good idea to turn it
into this:

|................[GLOBAL]....................|
|....................[MONITOR]...............|

Sadly, the existing upstream driver was architected with SDM845 in mind,
which means it doesn't support the global registers being somewhere else
than near the beginning of the monitor space. This series tries to address
that in the hopefully least painful way. Tested on msm8998 (the count unit
seems to be wrong, should probably be 1MiB and not 64 KiB but the point is
that this series makes it work at all, as without it the headswitch is
never turned on) and SM6375 (with the "combined" layout introduced in
SDM845). Equally sadly, everybody uses the qcom,msm8998-bwmon compatible
(which frankly should have been just qcom,bwmon-v4) that never actually
worked on MSM8998 , which prevents us from handling it in a simpler way..

While at it, an unused struct member is removed.

One suboptimal feature of this patchset is that it introduces an "invalid
resource" print from within devres. This could be solved with an
introduction of devm_ioremap_resource_optional or by dropping devres
functions in place of manual handling, which also doesn't sound great..
I'll leave it up to the reviewers to decide.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (7):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Resolve MSM8998 support
      soc: qcom: icc-bwmon: Remove unused struct member
      soc: qcom: icc-bwmon: Handle global registers correctly
      arm64: dts: qcom: sc7280: Use the correct BWMON fallback compatible
      arm64: dts: qcom: sc8280xp: Use the correct BWMON fallback compatible
      arm64: dts: qcom: sdm845: Use the correct BWMON compatible
      arm64: dts: qcom: sm8550: Use the correct BWMON fallback compatible

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |  41 +++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |   2 +-
 drivers/soc/qcom/icc-bwmon.c                       | 231 +++++++++++++++++++--
 6 files changed, 247 insertions(+), 33 deletions(-)
---
base-commit: 24469a0e5052ba01a35a15f104717a82b7a4798b
change-id: 20230304-topic-ddr_bwmon-609022cd5e35

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

