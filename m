Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29C070E6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbjEWUzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjEWUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:55:21 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD98E;
        Tue, 23 May 2023 13:55:20 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CE959CFB2A;
        Tue, 23 May 2023 20:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684875318; bh=uQFqe5iVdN9eN/p5L3w9/rrS5p9PnWq9XPTlLZU9wdQ=;
        h=From:Subject:Date:To:Cc;
        b=NVgKbTcYbsH90zxHKbMvTCrS0WZLOSoqHBsMvtDNHpfGp+5xuOs8gtow7KZE706jv
         Cz08E5jgb4d5/a/L+Vzn7yFOMf3WSoJvTLfBZN8PPmoM5p8GtAtB5t+82n8lVFz12i
         tLi/WiXGXPIWGYs5s1SY42ftNswu3sjdPYdUqfFA=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/6] Add MSM8226 OCMEM support plus some extra OCMEM
 driver fixes
Date:   Tue, 23 May 2023 22:55:07 +0200
Message-Id: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACsobWQC/3WNOw6DMBAFr4K2zkb28lWq3COiwGQJlrBBNlh8x
 N3j0Keckd6bAzw7zR4eyQGOg/Z6tBHolkDbN/bDqN+RgQSlIhcFGm8qogLH1rBBxSzLvJRcsYK
 4UY1nVK6xbR9XdhmGKCfHnV6vyKuO3Gs/j267mkH+7L/7IFFgypQxlZR1Qj731M7Lfd12qM/z/
 AJ/CN7mvwAAAA==
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
        Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=uQFqe5iVdN9eN/p5L3w9/rrS5p9PnWq9XPTlLZU9wdQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSgt7sUiKz4ME5XGxcVEPS6FyEdN4zJb9wYLV
 nbImeMc17OJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0oLQAKCRBy2EO4nU3X
 VtWZD/9Scy+RTRdb0GgGgkI/rmfcu8Lujfpk5jK4NZFApFtgTuBlCAeemp2DyB/IuPvLH3mjeaS
 Z6HV407kOafUPf6crxSfTiH/0DlaWvO0HKBt3ea+BSGLAbmsuLm9WkSRRyxAlqQlFBPd1niUmum
 fBT2Yky4Livacu8kvtjcQkCtSpOQsAnJPtuRYVhFxGirdSDCNEt73RqGnynYnq5bmoet0a4CIac
 IK01tPVlbeqjlasThw3KWYLtODUM5R9tKjHwhDj6+r+fFjzQbGLikFP626AW+0KQeLSV7Fu+hru
 GbLc2hijSN78b16tfqbTHYjENmdY+aAqaJ0QKbiKwWZw5AwnwWRnc9i/1Y3IAray7xiePkhcCiD
 rwfBGow7SYxwBw481fvxlHJX9I1zwz+LzsLM2vN+Si6LsMMkJKkrql18R+oy5rPxPFHMy1brN1k
 wPPr1ddDVTB5MWHjo4kuN23Vr6hJNWOXeyn7epHJC/jsPtafrxc3tiUGakeFfuzKoM7cVdTEEBN
 y09Kr517jW4QAmdLXqjbXeBY4jpw6V6q2p7zqv8LAHphKOPe4E3Bjcmb4Az7Fh9iER1L1etoFhH
 ps2v3rJpYBl2+HyQLVB3gYKTdIGKeCOesNV1dIz/WHSHt2RmUbZ7MhyCbP6g4HKyMTzs4kCAH14
 BT377SRU1Sfljtg==
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

 .../devicetree/bindings/sram/qcom,ocmem.yaml       | 20 ++++++-
 arch/arm/boot/dts/qcom-msm8226.dtsi                | 17 ++++++
 drivers/soc/qcom/ocmem.c                           | 67 ++++++++++++----------
 3 files changed, 72 insertions(+), 32 deletions(-)
---
base-commit: 8a80314554f679bc440e2affd842ece2048031ea
change-id: 20230506-msm8226-ocmem-bee17571e8eb

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

