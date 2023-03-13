Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11A6B763C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCMLmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjCMLly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6A66485B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g17so15319793lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707677;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/S6tlhnVD0jMwhriK/KPRi3yBgfbrY3W/h0PzQMNaR8=;
        b=v9TS3FASe5QrmtH2GPYTbcmnSqeIrOTUIgIFqpXj4ZNmMpyD97ZOAuRuA6xzIvOgwc
         5ToA4XYKFdh7MtK3Vzy8M+RENE8aB1OuNTtkcXENfN0QL2yH0AlyWSZPw+lr1TGr+1Qz
         CacIDCy0tEOHVWkgkKjsZ8INhHgsagPF3IJ4lNjKoAbA6PiKS9X9iKMW74q6C4VCWSbc
         mdhuj4aTx44uQHF+lqxd4e2oqTAeeTAnqiESoLzT8Gc6meyqYIx/TpLvxFpfKyV6fdCG
         eyCo71tdl5lmBzbpo0c9sS9NbluG/puOitJln1Gk34KSK9IHJAxjmjw7BtBKBh6vD1hU
         bAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707677;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/S6tlhnVD0jMwhriK/KPRi3yBgfbrY3W/h0PzQMNaR8=;
        b=vb/PfVTobpnFxRxz8/M9m0EpdaLeELhWynul9rKWh9SB7jnVSrKgocfHxRO4R5t/72
         CaQivWBKYz8xcoYfkYBZqEQlhxBn2qNJNuknmKeh2jTCG6clF3oofuylPBooxGISkFEL
         QxW4RgzxsmJO2S7uVgOBnuCU4zVOhxhbwEawpZGjz9lcpyYSvoL6KoB9UA3bqTmDocr6
         vZFvAb1k2rTyRMnP9l8a+jaSnDREhdrK7NPiRovBw4ddvKQOPhImo/V7+YQpq0xpe37R
         Nr4xpKusjrJgIpjkokV60Xgk1mLubw21Cp0qMt/mwq5oPRSw0VL+9m11as6hf2kH0mU7
         zdHw==
X-Gm-Message-State: AO0yUKWMR+YjV/6fCc2sp/5y3rKMJ0mtCCg1VvNzrDlJ9GECUzZLgxEo
        ndDag8s2j1q5bl/yU2MehWx8i1ODO85uv6RanxA=
X-Google-Smtp-Source: AK7set9v8fcwISQUDvacfsx5NKc3IorSPfzW8quB1f7SIhNWvGL9qSeDapUgBCfPcNrnff23tqojJA==
X-Received: by 2002:ac2:5151:0:b0:4e8:1798:f9e1 with SMTP id q17-20020ac25151000000b004e81798f9e1mr6000204lfd.57.1678707676842;
        Mon, 13 Mar 2023 04:41:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i2-20020ac25222000000b004d86808fd33sm948465lfl.15.2023.03.13.04.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/7] Fix BWMONv4 for <SDM845
Date:   Mon, 13 Mar 2023 12:41:06 +0100
Message-Id: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANILD2QC/3WNQQ6CMBAAv0J6dk1pBdST/zDElHaFTbAlW6waw
 t+t3D3OJJNZREQmjOJcLIIxUaTgM6hdIexgfI9ALrNQUmmp5QHmMJEF5/jWvR7BQy1PUinrKtS
 VyFVnIkLHxtshd/45jllOjHd6b5trm3mgOAf+bNdU/uz/QSpBAla1PurG2caVl5G84bAP3It2X
 dcvcrJloMQAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678707675; l=3845;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=F+Wdt7KucrU/3l2BmjjW7lX2O3UZbJYREc/jBzPumpI=;
 b=fmD4t1vb7FXPLTry4Ekkk7HRLZtygRgXTIHyurArLHXJoWQSJUMRsgWrwCyhzmLjXxyzTPBiSidp
 yooZgnjJBYBrUG5zEv1nepmyJ3VwyyuwaNiLCGvBfjrzHjvAVSId
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
      soc: qcom: icc-bwmon: Handle global registers correctly
      soc: qcom: icc-bwmon: Remove unused struct member
      arm64: dts: qcom: sc7280: Use the correct BWMON fallback compatible
      arm64: dts: qcom: sc8280xp: Use the correct BWMON fallback compatible
      arm64: dts: qcom: sdm845: Use the correct BWMON compatible
      arm64: dts: qcom: sm8550: Use the correct BWMON fallback compatible

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |  41 +++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |   2 +-
 drivers/soc/qcom/icc-bwmon.c                       | 229 +++++++++++++++++++--
 6 files changed, 246 insertions(+), 32 deletions(-)
---
base-commit: 24469a0e5052ba01a35a15f104717a82b7a4798b
change-id: 20230304-topic-ddr_bwmon-609022cd5e35

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

