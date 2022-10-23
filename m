Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4C609642
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJWUpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJWUpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:45:35 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B63580AB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:45:31 -0700 (PDT)
Date:   Sun, 23 Oct 2022 20:45:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666557923; x=1666817123;
        bh=2rN4cjOm0aDr2fXoK1xd1UdWC2BFDa/1yVmlDfrqD/k=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=NdmEP81jR0Cpm3aESb9TzhQpFG6ya+sKKfjzJ8KmGSoFhOzi97VuLKTiKVPvlFQfE
         v7+rkAkjjw2xZ1Bp/F5n+pAroFsTvjDftbk29vnDTD/f0aH/xHE/ZLf14Xt6826gk9
         UBVI6TGSkBb6wU4ad5GuWLU6kNp4kmkKI+mbnwgTjREVNoSbgc9PVuo7kuDQp65z23
         xDB2Ta3KdZqOpWryd7lcnWDm1SaKfJIYtyhv3EnKtoILABrYzSchQbOBK9gYkI1CQj
         f+nV+XSCV3hrFUDjMpsgZaMB6inOeo8qx0llK+7b5MgmKOnFBwJ556xgWypzqDBFbS
         /eAZPMLOmRWvQ==
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Harry Austen <hpausten@protonmail.com>
Cc:     Harry Austen <hpausten@protonmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH v2 0/4] Initial OnePlus 3(T) Support
Message-ID: <20221023204505.115141-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1
---------------
v1: https://lore.kernel.org/all/20221021142242.129276-1-hpausten@protonmail=
.com/
- fix node name DT schema problems
- removed "simple-bus" compatible from /clocks node
- use common "-clk" suffix for divclk1/4 node names
- use common "-regulator" suffix for wlan-en regulator node name
- move status properties last in all nodes
- fixed copyright to be assigned to myself, since I don't work for LF
- add Krzysztof's Rb tag to bindings patch

This patch series adds support for the OnePlus 3 and OnePlus 3T mobile
phones based on the Qualcomm MSM8996 SoC. Currently includes support for
the following:

- UART console via PCB test pads
- Qualcomm Atheros QCA6174 WiFi and Bluetooth
- NXP TFA9890 Speaker Amplifier
- TI BQ27541 Battery Fuel Gauge
- Synaptics RMI4 Touchscreen
- UFS Storage

Harry Austen (4):
  arm64: dts: qcom: msm8996: standardize blsp indexing
  arm64: boot: dts: msm8996: add blsp1_i2c6 node
  dt-bindings: arm: qcom: add oneplus3(t) devices
  arm64: dts: qcom: msm8996: add support for oneplus3(t)

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/msm8996-oneplus-common.dtsi | 787 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts |  44 +
 .../arm64/boot/dts/qcom/msm8996-oneplus3t.dts |  45 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  49 +-
 6 files changed, 920 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts

--
2.38.1


