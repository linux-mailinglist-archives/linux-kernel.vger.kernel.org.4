Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A006DB985
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDHIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHIOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:14:18 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24849CB;
        Sat,  8 Apr 2023 01:14:17 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9BFA7403B9;
        Sat,  8 Apr 2023 13:14:14 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680941655; bh=7ypwQpfzYbwP9zkuvkd1wuczBoIHgDyxmN9zJNBqqz4=;
        h=From:To:Cc:Subject:Date:From;
        b=LKEiVWLaJBAh4l0ZYdMg0OQx2RLPxqrE3VMbE8OJR1gnrNdzHByV0IJq6Mn+ApJYU
         pP8QNY7ne2qBVa923c7s5NwrEzkMCs+fhnmT1COMSHEOOlFoVYJ63dE8praLxc/b6n
         0c3HTmQck6SVTRI5SOsXVbZc/6/C4qfbi+x7NCMUg2ehZn69mzeCur4n8CNNs8UZpM
         fbygv4EVeBOyfY5NzlGAjoilUPJn6DgSsP0xo+9SbOxfXR8gJeIuBIBNRBzZi9D+is
         cbNF+N7brtx6YTvPE3PIdzvWjSVNqHcz0h14ZgWAhrbzMc4FTiWsstFTIjqC9rjJt9
         86OIIjiiQVTHA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, quic_srivasam@quicinc.com,
        judyhsiao@chromium.org, mka@chromium.org, dianders@chromium.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v6 0/4] Add Acer Aspire 1
Date:   Sat,  8 Apr 2023 13:13:12 +0500
Message-Id: <20230408081316.234293-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.39.2

