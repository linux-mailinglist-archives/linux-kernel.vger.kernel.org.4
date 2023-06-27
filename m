Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2B740347
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjF0Sa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjF0Saw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:30:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A010DA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so6934270e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687890648; x=1690482648;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEYoyXW6KI+40nikgb+c9QT03ex81BcyrCC3z8MFeq8=;
        b=ChhBkIYBCPE5e3butSMyjWz2gumAtO2Gb7pMg07bRRdoyNFS+pHiMMN27n8s0qzIxc
         cVeVKJd0CsbKMTpCXbPT4aX4shOOvjvxUiDqLO7ZGkGtBJleWdBTahf9wC5CXXJnowoZ
         qBYAZKy/IpgwG9FPSOzqQSSeGoL6K4QX9swrtNaRnKyvvetrweb78H03mCjxzrLlfyqA
         mfhlzt9uXcO32ygXXhAibp0CXrYLODrJjNOO6Ml97mgY1UPHcZrQl+RLVC1NwAoCKv5O
         57LSKb3ID2OMOE+q/bjxPr+4w8Qlzw072a6ilFn1jG4zqZW03HpHoPDddjOlU6acvqw+
         mt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890648; x=1690482648;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEYoyXW6KI+40nikgb+c9QT03ex81BcyrCC3z8MFeq8=;
        b=aQp6igFlbpfHF+7MVktXQENX2BcLmUuftl9CIFxs+/5dVmP69Cm6yHw7xtP5K+FrNU
         nyA58hd3cCEh2DRCy7Kd24mvbUswrgFI6C5XRi+13gEJa9l0yp7mDidPsxtmaqFUjSMY
         eJswEGY8sh/Z62+SqZeG22CeQGDVgwb+VqZ7j6z6BHDD9opDIxKmCXeNmg5jcgWf04V0
         2caYOq8e8DM3xcjVHjBAaoCr3Ir277Uv6HIu7duJomuoBTJlutkQ8y5+eINSz2cSIdwk
         +xRuJe+REbtjXb4PaWy5UTIVSEvjYsoXZVa+y7FNaPV8wJqBNk3Ns5LYCNp94b4kpL+g
         xFNw==
X-Gm-Message-State: AC+VfDw9RHVKZMDU/s43HcxL26GXvYO7EKmQpiJeXrBkrHmsOgvS9Icq
        o7fvjYmy/2gP/gufz69F21GzXQ==
X-Google-Smtp-Source: ACHHUZ49G223k7CVIhwQfiDM5CG7kvqpA7d51dAPg9ld9xVIXu250DD4U+oqXvUmZbEVXUf3jAewgA==
X-Received: by 2002:ac2:4f12:0:b0:4ed:cc6d:61fe with SMTP id k18-20020ac24f12000000b004edcc6d61femr5638416lfr.24.1687890647601;
        Tue, 27 Jun 2023 11:30:47 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id q16-20020ac25290000000b004f640b0fb04sm1605205lfm.212.2023.06.27.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:30:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v11 0/9] Add support for Core Power Reduction v3, v4 and
 Hardened
Date:   Tue, 27 Jun 2023 20:30:36 +0200
Message-Id: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMwqm2QC/22NzQqDMBCEX0VybkoSi5ae+h7iIT8bsyCJbKy0i
 O/erece5xu+mV1UIIQqHs0uCDasWDIHrS+N8MnmCSQGBsIo0yqje7mWBb30C7VJBjCtcdHdevC
 CDWcrSEc2+8ROfs0zw4Ug4vv8GEbOCeta6HNeblr98P91LqWSXW8h3GOIttPPGbOlci00ifE4j
 i88gg2EvwAAAA==
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687890646; l=7563;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7+lu1MyAGNXwDNfi7jE2GjLf4UHybiRnD4saUaliAL8=;
 b=XGTPmVre2Lc9Yp+EHRK4Wn5/lJNhQ+g9SX0/b72Pa6s5vC8tbYPycWChZ2KKKHWEmC+YSiHth
 /augxC8pFpCBcIhfWiv2DBEAqsTKzYnd4s2dvNp/pOQYtJeeV2ohLEI
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

Changes in v11:

CPR COMMON:
- split the commonizing patch, make it actually do what it says on the
  tin..
- fix some overflow bugs

CPR3:
- fix some overflow bugs
- don't assume "lack of qcom,opp-?loop-vadj" means val=0"

CPR BINDINGS:
- drop quotes in items
- drop clock-names (there's just a single one)
- rewrite the description a bit
- fix up the example
- drop bogus minItems
- "acc-syscon" -> "qcom,acc"

DTS:
- fix qfprom children so that the bits=<> doesn't overflow reg[size]
- drop unrelated changes
- place one reg entry per line

Link to v10: https://lore.kernel.org/r/20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org

Changes in v10:
- Skip "Let qcom,opp-fuse-level be a 2-long array" (Applied by Viresh)
- Use b4 (it may be the first time you're receiving this if git send-email
  omitted you before..)
- +Cc Robert Marko (expressed interest in previous revisions)
- Add "Document CPR3 open/closed loop volt adjustment"
CPR:
- %hhu -> %u (checkpatch)
CPR BINDINGS:
- Drop QCS404 fuse set (it doesn't use this driver, what did I even think..)
  but leave the allOf:if: block for expansion (sdm660, msm8996, ipqABCD should
  follow soon..)
- Drop Rob's R-b (as things changed *again*, please take one more look to make
  sure you're okay with this file, Rob..)

Link to v9:
https://lore.kernel.org/linux-arm-msm/20230116093845.72621-1-konrad.dybcio@linaro.org/

Changes in v9:
- Restore forgotten MAINTAINERS patch (oops)
CPR:
- Include the missing header (big oops!)
- Fix kconfig dependencies
CPR bindings:
- Fix cpu reg in example (why didn't dt_binding_check scream at that)
- Add newlines between nodes in example
- Change opp table node names to opp-table-cpu[04]
- Change opp table labels to cpu[04]_opp_table
- Change CPRh opp subnode names to opp-N from oppN
- Remove some stray newlines
- Bring back nvmem-cell-names and add the 8998's set
- Allow power-domains for VDDCX_AO voting
- Remove Rob's r-b, there's been quite a bit of changes..
CPR DT:
- Send the correct revision of the patch this time around..
OPP bindings:
- Add Rob's ack

Link to v8:
https://lore.kernel.org/linux-arm-msm/20230110175605.1240188-1-konrad.dybcio@linaro.org/

Changes in v8:
- Overtake this series from AGdR
- Apply all review comments from v7 except Vladimir's request to
  not create the include/ header; it will be strictly necessary for
  OSM-aware cpufreq_hw programming, which this series was more or
  less created just for..
- Drop QCS404 dtsi change, account for not breaking backwards compat
  in [3/5]
- Add type phandle type reference to acc-syscon in [1/5]
- Update AGdR's email addresses for maintainer entries
- Add [2/5] to make dt_binding_check happy
- Separate the CPRh DT addition from cpufreq_hw addition, sort and
  properly indent new nodes
- Drop CPR yaml conversion, that happened in meantime
- Reorder the patches to make a bit more sense
- Tested again on MSM8998 Xperia XZ Premium (Maple)
- I take no responsibility for AGdR's cheeky jokes, only the code!

Link to v7:
https://lore.kernel.org/lkml/20210901155735.629282-1-angelogioacchino.delregno@somainline.org/

Changes in v7:
- Rebased on linux-next as of 210901
- Changed cpr_read_efuse calls to nvmem_cell_read_variable_le_u32,
  following what was done in commit c77634b9d916

Changes in v6:
- Fixes from Bjorn's review
- After a conversation with Viresh, it turned out I was abusing the
  OPP API to pass the APM and MEM-ACC thresholds to qcom-cpufreq-hw,
  so now the driver is using the genpd created virtual device and
  passing drvdata instead to stop the abuse
- Since the CPR commonization was ignored for more than 6 months,
  it is now included in the CPRv3/4/h series, as there is no point
  in commonizing without having this driver
- Rebased on v5.13

Changes in v5:
- Fixed getting OPP table when not yet installed by the caller
  of power domain attachment

Changes in v4:
- Huge patch series has been split for better reviewability,
  as suggested by Bjorn

Changes in v3:
- Fixed YAML doc issues
- Removed unused variables and redundant if branch

Changes in v2:
- Implemented dynamic Memory Accelerator corners support, needed
  by MSM8998
- Added MSM8998 Silver/Gold parameters

This commit introduces a new driver, based on the one for cpr v1,
to enable support for the newer Qualcomm Core Power Reduction
hardware, known downstream as CPR3, CPR4 and CPRh, and support
for MSM8998 and SDM630 CPU power reduction.

In these new versions of the hardware, support for various new
features was introduced, including voltage reduction for the GPU,
security hardening and a new way of controlling CPU DVFS,
consisting in internal communication between microcontrollers,
specifically the CPR-Hardened and the Operating State Manager.

The CPR v3, v4 and CPRh are present in a broad range of SoCs,
from the mid-range to the high end ones including, but not limited
to, MSM8953/8996/8998, SDM630/636/660/845.

As to clarify, SDM845 does the CPR/SAW/OSM setup in TZ firmware, but
this is limited to the CPU context; despite GPU CPR support being not
implemented in this series, it is planned for the future, and some
SDM845 need the CPR (in the context of GPU CPR) to be configured from
this driver.

It is also planned to add the CPR data for MSM8996, since this driver
does support the CPRv4 found on that SoC, but I currently have no time
to properly test that on a real device, so I prefer getting this big
implementation merged before adding more things on top.

As for MSM8953, we (read: nobody from SoMainline) have no device with
this chip: since we are unable to test the cpr data and the entire
driver on that one, we currently have no plans to do this addition
in the future. This is left to other nice developers: I'm sure that
somebody will come up with that, sooner or later

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
AngeloGioacchino Del Regno (7):
      MAINTAINERS: Add entry for Qualcomm CPRv3/v4/Hardened driver
      dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
      soc: qcom: cpr: Move common functions to new file
      soc: qcom: cpr-common: Add support for flat fuse adjustment
      soc: qcom: cpr-common: Add threads support
      soc: qcom: Add support for Core Power Reduction v3, v4 and Hardened
      arm64: dts: qcom: msm8998: Configure CPRh

Konrad Dybcio (2):
      dt-bindings: opp: v2-qcom-level: Document CPR3 open/closed loop volt adjustment
      soc: qcom: cpr: Use u64 for frequency

 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   14 +
 .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    |  289 ++
 MAINTAINERS                                        |    6 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  757 +++++
 drivers/soc/qcom/Kconfig                           |   22 +
 drivers/soc/qcom/Makefile                          |    2 +
 drivers/soc/qcom/cpr-common.c                      |  362 +++
 drivers/soc/qcom/cpr-common.h                      |  109 +
 drivers/soc/qcom/cpr.c                             |  392 +--
 drivers/soc/qcom/cpr3.c                            | 2932 ++++++++++++++++++++
 include/soc/qcom/cpr.h                             |   17 +
 11 files changed, 4535 insertions(+), 367 deletions(-)
---
base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
change-id: 20230217-topic-cpr3h-de232bfb47ec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

