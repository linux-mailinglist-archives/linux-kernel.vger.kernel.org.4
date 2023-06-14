Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28C730510
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjFNQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjFNQgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:36:13 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE1A212B;
        Wed, 14 Jun 2023 09:36:12 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 46E4ECFCAF;
        Wed, 14 Jun 2023 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1686760570; bh=OJMtAUAytlFBSm6etVG7AgdKyXd/04mqeGE4t7oTRIg=;
        h=From:Subject:Date:To:Cc;
        b=QKK27an9PIDLEstUsKB16j5lH0PeQr5+zOhOVq0Tn81KjE6AAetlCVjMngvl2Ml4b
         eN+5kJlbWfaeJiFn48jl3eE5ZVij1ZfGaKif93+vdETcbhbkQtjVbUAocLW9LbVvRb
         /aaClIPt9/r4BOAHjYM1fogcR7lgXkk8xmC27rZQ=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v3 0/6] Add MSM8226 OCMEM support plus some extra OCMEM
 driver fixes
Date:   Wed, 14 Jun 2023 18:35:46 +0200
Message-Id: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGLsiWQC/32Nyw6DIBQFf8WwLg1cVLSr/kfTBei1kig2oMRH/
 Peiq27a5Zxk5mzEozPoyS3ZiMNgvBlsBHFJSNUq+0Jq6sgEGAiWsZz2vi8AcjpUPfZUI3KZSY4
 FahIdrTxS7ZSt2mjZqevi+HbYmPk8eTwjt8aPg1vOz8CP9Vc+cMqoQEgRJKQN4/dV2HG6zstKj
 lKAvzZEm0tZ56XEVKjy2973/QN4Aaq//QAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=OJMtAUAytlFBSm6etVG7AgdKyXd/04mqeGE4t7oTRIg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkiextv7z/LWT6N0CVbvOiOoWWGarCvipr2SG0P
 Glgs+aMXDeJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZInsbQAKCRBy2EO4nU3X
 Vtl6EACkQiGYF6MAeTl/QY9qjGzCHcthbN8ZSRrNf9/voBLP8pWP8Hg+8LNM95StxkpCrJ0Zs3y
 ly1muyKav0tUeZMXtrlw8vQPx0LL+iYDHBVoQIhmyTwphbOY6IzIoeB/y+zrNVUlUJ/Dn6Seq2Z
 FkNoe6s7WBu7h49Tw118OM7KKt0xx4w5Gg+AIq1wPJQXkinhTji6AETjh65aO27gxbkZBWjivSL
 oOUga6DTMUO6HhuHtow5cTmhv73JdiyWcGK9mn86Isktlbu+++b6rGmoQPRBD4RIegbXX2++07G
 I6guKTWCS6ThZK3q1ZCX35y2b/bRd26nXjmghf6w7KjgtTYhQ+C4qvySxbWvW/cwNCOekzNzTFj
 hVgAvu5awLPhViAKsMIIyx5D2BtV220SxEGmKCZrqB87pmzjE3dlhvmdtSdxMsioaSgcvUzt/A6
 0UkutFIZQmkth6IX7YPgeYxr/zNnqj7VzwtjGsPPmtdbLxB29wKE8cXymFwSu+zup+zLihKLGny
 Hf6tslETpJUCHHeIAavw1Rd927FpuU2VU7a9gPP/uNPWbvJDRbODV/z7wErJd0FzF5kKXoCe71R
 UfBzs/KwgA7EMvIrh0PXlU3YxSvn80KRqbl6Di7iVunbGzlbjFDn+eu6DtS/MIWDpy/SPgISVKH
 TES+22n3mvTN1Hw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like MSM8974 the MSM8226 SoC also contains some OCMEM but it has just
one region for graphics compared to 8974.

While adding support I found a bug in the existing driver that is being
fixed in this series also and the rest of the matches are mostly
preparations for MSM8226 support.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v3:
- Rebase on linux-next
- Add 'else' to clk/clk-names in dt-bindings limiting to 1
- Link to v2: https://lore.kernel.org/r/20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz

Changes in v2:
- dt-bindings: add hw version hint to msm8974 & msm8226 variant (Konrad)
- dt-bindings: add constraints for clock (Konrad)
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz

---
Luca Weiss (6):
      soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
      soc: qcom: ocmem: Use dev_err_probe where appropriate
      soc: qcom: ocmem: make iface clock optional
      dt-bindings: sram: qcom,ocmem: Add msm8226 support
      soc: qcom: ocmem: Add support for msm8226
      ARM: dts: qcom: msm8226: Add ocmem

 .../devicetree/bindings/sram/qcom,ocmem.yaml       | 26 ++++++++-
 arch/arm/boot/dts/qcom-msm8226.dtsi                | 17 ++++++
 drivers/soc/qcom/ocmem.c                           | 67 ++++++++++++----------
 3 files changed, 78 insertions(+), 32 deletions(-)
---
base-commit: bcbf7634663f705695e9faa80ef419c2b1589f8e
change-id: 20230506-msm8226-ocmem-bee17571e8eb

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

