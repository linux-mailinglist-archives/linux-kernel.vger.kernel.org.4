Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48C5BD5E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiISUtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiISUsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:48:39 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B94AD5E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:48:37 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DF99F3F5F9;
        Mon, 19 Sep 2022 22:48:34 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Add Qcom PM6125 PMIC, and use in Sony Xperia Seine PDX201
Date:   Mon, 19 Sep 2022 22:48:21 +0200
Message-Id: <20220919204826.215845-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial support for the PM6125 PMIC, and its power key
handling and thermal monitoring capabilities are configured for Sony's
PDX201 (Xperia 10II).

One patch for pm660 is included to fix a node address mismatch with its
reg field.

Changes since v2:
- Rebased on v6.0-rc6 to drop dependent DT patches;
- Dropped iio patch which has already been picked into Jonathan's tree;
- Added qcom,pm6125 compatible in new yaml-ified SPMI-PMIC dt-bindings.

v2: https://lore.kernel.org/linux-arm-msm/20220805135729.1037079-1-marijn.suijten@somainline.org/T/#u

Changes since v1:
- Dropped both pinctrl patches that have already been applied;
- Add -us suffix to qcom,hw-settle-time properties on ADC TM5 nodes
  (this suffix is not present on regular ADC5/VADC nodes);
- Add -state suffix to pm6125_gpio pinctrl nodes;
- Use PMIC_GPIO_FUNC_NORMAL instead of the string-literal "normal";
- Removed #address-cells and #size-cells from empty pmic@1 node;
- Removed ADC5_AMUX_THM3 / ADC5_GPIO2_100K_PU channels from the ADC5
  patch, these are unused on my board and hence untested.

v1: https://lore.kernel.org/phone-devel/20220511220613.1015472-1-marijn.suijten@somainline.org/T/#u

Marijn Suijten (5):
  dt-bindings: mfd: qcom-spmi-pmic: Add pm6125 compatible
  arm64: dts: qcom: pm660: Use unique ADC5_VCOIN address in node name
  arm64: dts: qcom: Add PM6125 PMIC
  arm64: dts: qcom: sm6125-seine: Include PM6125 and configure PON
  arm64: dts: qcom: sm6125-seine: Configure additional trinket
    thermistors

 .../bindings/mfd/qcom,spmi-pmic.yaml          |   1 +
 arch/arm64/boot/dts/qcom/pm6125.dtsi          | 154 +++++++++++++++++
 arch/arm64/boot/dts/qcom/pm660.dtsi           |   2 +-
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 162 +++++++++++++++++-
 4 files changed, 317 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/pm6125.dtsi

--
2.37.3

