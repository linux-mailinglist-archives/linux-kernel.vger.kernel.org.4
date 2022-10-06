Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3525F68CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJFOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiJFOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:06:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C130A59A9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:06:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f37so2855026lfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Q9PKkVz5JSd6Red0ZQhk3d2Bnwnk9qONZE4I2NARHis=;
        b=P1yd/GPwotgXVaiYMKA7nJU5+WQr73w+H/smLgRPaht2EATD5u5hsAFELMvXtm7QXU
         p/sA+W7SGJj9LE57tDDL9l8bPuvqgtnzx/8hg/j2W6DF8Pkgl4lkjOuIq4exUuBH5SrE
         +NjkTy46vH9+v4HEUuii5aR7eaD4nAyWbKxL0ErVgGNsvdhVtFaq8mARzxDq5yBTJ44+
         T4NvRYIPHRYGYtoXNoaRur0Sp3az6OHR2wFTZDz0gCFGDqZQtzyN5QLSdVkkOdNr5WEf
         RzEKtBb3MoZ6suDpSG1qsDIXYKg3H90XdNpE5jy/xvOxm7PcschDgtHawrCZD2sSooj4
         noKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Q9PKkVz5JSd6Red0ZQhk3d2Bnwnk9qONZE4I2NARHis=;
        b=FCcC3sCK1nWa+qKLKcgwwZWI9QvNUGceicVZMQ6XchIg1GEKE4kkX18stqc7yW5lF+
         2gLlWHKrr4MBVpYtLGvvVFpCwIm4bSIh5+NyVHaM9mbsRbgwuTVNKAkkUZn4hud6Fn5a
         NO5SJmRyLG3d3gyxxLJHUNOldaXOvVIzh27QPNdZlT4kiKQ0ui3JzVCOP2t2xbiD7ske
         pp4AaPEV/EGNO8dIUi7dJabGup3mo34UCtmVxLCuWDJjE4aPSYQ/BTTGpERbQ9hJCwvP
         W95dHok6jZGpL3iikhMXCfNP3LNbT7mkmHTL9gBIdqznoJLKYITmbs4yiB/r5j9P+HY8
         B69Q==
X-Gm-Message-State: ACrzQf0KeBcDbIBe+Zgq43TEk/sesMRpd66OfNe5ToGQ2I2rB9u8RUNX
        t58BnbGb3tsGXiZd2HrOMXN3WA==
X-Google-Smtp-Source: AMsMyM7jNkr5nJqC81rh2I33D/cUBPIGVpbYgb6Sc/9YVIQ4bXbpknWTD/xz5aWue1udMin4LwzAgw==
X-Received: by 2002:ac2:4c52:0:b0:4a2:6bf9:bd7e with SMTP id o18-20020ac24c52000000b004a26bf9bd7emr51873lfk.400.1665065202596;
        Thu, 06 Oct 2022 07:06:42 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:06:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings (5th set)
Date:   Thu,  6 Oct 2022 16:06:03 +0200
Message-Id: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patches are organized not by file, but rather type of change
1. First patches is for common TLMM schema and dropping unneeded refs.
2. Last patches are pure cleanups without functional impact.

Overview
========
This is the *fifth* patchset around Qualcomm pinctrl in recent days:
1. First round of TLMM fixes: merged
2. LPASS fixes:
   https://lore.kernel.org/linux-devicetree/20220927153429.55365-1-krzysztof.kozlowski@linaro.org/
3. ARMv7 TLMM fixes:
   https://lore.kernel.org/linux-devicetree/20221006124659.217540-1-krzysztof.kozlowski@linaro.org/
4. ARMv8 remaining TLMM fixes:
   https://lore.kernel.org/linux-devicetree/20220930192954.242546-1-krzysztof.kozlowski@linaro.org/
5. Fifth clean - styles and using common TLMM schema: *THIS PATCHSET*

Dependencies
============
1. Almost no dependencies - logically the bindings patch "dt-bindings: pinctrl:
   qcom,sm8250: drop checks used in common TLMM" depends on patchset #3 above.
   This is not a hard-dependency, everything will compile nicely, no warnings.

2. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (34):
  dt-bindings: pinctrl: qcom,mdm9607: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sc7280: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sc8180x: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sc8180x: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sc8280xp: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sm6115: use common TLMM schema
  dt-bindings: pinctrl: qcom,sm6125: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sm6125: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sm6350: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sm6350: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sm6375-tlmm: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sm6375-tlmm: drop checks used in common
    TLMM
  dt-bindings: pinctrl: qcom,sm8250: use common TLMM schema
  dt-bindings: pinctrl: qcom,sm8350: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sm8350: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sm8450: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,mdm9607: minor style cleanups
  dt-bindings: pinctrl: qcom,msm8909-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,qcm2290: minor style cleanups
  dt-bindings: pinctrl: qcom,sdx65: minor style cleanups
  dt-bindings: pinctrl: qcom,sc8180x: minor style cleanups
  dt-bindings: pinctrl: qcom,sc8280xp: minor style cleanups
  dt-bindings: pinctrl: qcom,sm6115: minor style cleanups
  dt-bindings: pinctrl: qcom,sm6125: minor style cleanups
  dt-bindings: pinctrl: qcom,sm6350: minor style cleanups
  dt-bindings: pinctrl: qcom,sm6375: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8250: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8350: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8450: minor style cleanups
  dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: minor style cleanups
  dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor style cleanups
  dt-bindings: pinctrl: qcom: adjust description

 .../pinctrl/qcom,ipq6018-pinctrl.yaml         |  5 +-
 .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 16 ++---
 .../pinctrl/qcom,msm8226-pinctrl.yaml         |  5 +-
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 11 ++-
 .../pinctrl/qcom,msm8953-pinctrl.yaml         |  5 +-
 .../pinctrl/qcom,qcm2290-pinctrl.yaml         | 10 ++-
 .../qcom,sc7280-lpass-lpi-pinctrl.yaml        | 13 ++--
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 16 +----
 .../pinctrl/qcom,sc8180x-pinctrl.yaml         | 27 +++----
 .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 13 ++--
 .../pinctrl/qcom,sc8280xp-pinctrl.yaml        | 22 ++----
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  |  5 +-
 .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 10 ++-
 .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml | 53 +++-----------
 .../bindings/pinctrl/qcom,sm6125-pinctrl.yaml | 30 +++-----
 .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml | 23 ++----
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml    | 23 ++----
 .../qcom,sm8250-lpass-lpi-pinctrl.yaml        | 16 ++---
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 70 ++++++-------------
 .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml | 23 ++----
 .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 13 ++--
 .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml | 22 ++----
 22 files changed, 136 insertions(+), 295 deletions(-)

-- 
2.34.1

