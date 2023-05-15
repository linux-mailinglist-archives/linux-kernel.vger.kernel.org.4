Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3E7029EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbjEOKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbjEOKDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:03:12 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 03:02:53 PDT
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A3197;
        Mon, 15 May 2023 03:02:52 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6381E4182D;
        Mon, 15 May 2023 14:37:50 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1684143471; bh=jbvIDYwyFsYFzcr006UKNnY1tOqxvQxoK0H8UlLMUjE=;
        h=From:To:Cc:Subject:Date:From;
        b=NFqzJ/Te4xd5oHf7rqfinH4BLBvqbIcaHZKcbCdxoLbvLyiuH7N7vzszoD55SGQ9V
         Z8MAYkdiM2knqXT243EtT0Endlf/fptVPf3RpzBvznAyahk06tLZIydNYyZNhykFTo
         MKxw3BlZUH0tzep4mNLJcvcgzBC3bLrKhg1lMoXMXGVxTb/X5t1eqYHAoUA6CPmrpl
         o+deDXRhFcxTWu+BPMJ05rEgNheNpfLEi+q8UShUpeO3qT3OfXDDpFOrrF5RsP+k3I
         nZFcuRqy777PvU4WKPIZZqnMx//Y7MKtpiWDB+hrgZBlRJp1m/B0OrO3fGbrnnIODm
         mJa98YDYYAo2A==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, dianders@chromium.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v6 RESEND 0/4] Add Acer Aspire 1
Date:   Mon, 15 May 2023 14:37:40 +0500
Message-Id: <20230515093744.289045-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces Acer Aspire 1 - A WoA laptop with sc7180.

The dts adds mostly complite support for the hardware and the device,
with minor patches on top, can be used as a normal laptop daily.

Notable features absent from this patch:
- Sound
   While the dedicated sound components are defined, since the
   ADSP must be used, sound requires additions of that remoteproc
   as well some extra "glue" to connect the i2s outputs to it.
   I was able to hack together some sound based on sm8250 stuff
   but it needs more work.
- Embedded Controller
   The laptop has a dedicated EC that controls, notably,
   battery/charger and notifies the device about the USB-C DisplayPort
   HPD events. As per this patch, there is no battery status
   indication and external display support. Also, due to the EC
   defaults, the fn key is disabled. I have an experimental driver that
   implements all of that, which needs more work and will be submitted
   at a later date.
- PSCI OSI Mode
   Firmware on this laptop does not support the PC mode, as is usual
   for Qualcomm. This change would require adding OSI related
   power-domains to the SoC dtsi and is omitted in expectation that
   this can be handled when (if?) CrOS team handles their tf-a, like
   they did with sc7280.

Changed in v3:
 - Disable lpass clocks by default (Konrad)
 - Drop status=disabled for mdp in the common soc dtsi (Konrad)

Changed in v4:
 - Resend with picked up tags, no other change.

Changed in v5:
 - Minor style issues fixed. (Konrad)

Changed in v6:
 - Fix eDP HPD hack (Doug)

Nikita Travkin (4):
  arm64: dts: qcom: sc7180: Don't enable lpass clocks by default
  arm64: dts: qcom: sc7180: Drop redundant disable in mdp
  dt-bindings: arm: qcom: Add Acer Aspire 1
  arm64: dts: qcom: Add Acer Aspire 1

 .../devicetree/bindings/arm/qcom.yaml         |   4 +-
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sc7180-acer-aspire1.dts     | 845 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |   4 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |   6 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |   6 +-
 6 files changed, 857 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts

-- 
2.40.0

