Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7E6C8EA6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCYNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCYNvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:51:35 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96CB11E8D;
        Sat, 25 Mar 2023 06:51:29 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PkL8Z2Jb8z9sZ1;
        Sat, 25 Mar 2023 14:51:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679752286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YMbLEoGgO0L0aWTTrGydm32RuWu6VoxcVZo86QWXzck=;
        b=cP6KByAOhabnsHWqbfArLEXes96hdm4tJIlx3G7EjvcUQ7D9UX72pqG/fjH64nUWzW40Qz
        0iLbD92bey1YRQJpUB2Ms5RGIzj8CHg5RubTQX10v2INiV1n04zX1lZ5wWa89mZD2xhHMt
        aA3gmNrPU6HjjoSL9ItFYe8tZNbrp8KZiTi7JPvJePfzwxR7iAu15dan47TX1Bvg5FYzxJ
        u6Lc4DSojxrfewchAEXzgQ8v++Ak6lZOCAx325JeED1u2R7gRy/7+HuJqESGrp030zv2Ff
        br+fO8MWzt/MpL0HEcXkhEvyVRPME4ve/70RtHuLd5/6vDi+RDiwjtLoC+SiMg==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 0/4] Qualcomm SDM845 SLPI DSP enablement
Date:   Sat, 25 Mar 2023 14:51:10 +0100
Message-Id: <20230325135114.21688-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PkL8Z2Jb8z9sZ1
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* About *

The Qualcomm SDM845 SoC has a separate SLPI (Sensor Low Power Island)
DSP for sensors connected to the SoC which is responsible for exposing
sensors to userspace, power saving, and other features. 
While sensors are connected to GPIOs of the SoC, they cannot be used
because the hypervisor blocks direct access to the sensors, thus the 
DSP must be used to access any sensor on this SoC. The SLPI DSP uses a
GLink edge (dsps) to communicate with the host and has a FastRPC interface
to load files from the host filesystem such as sensor configuration files.
The FastRPC interface does not use regular FastRPC Compute Banks
but instead uses an allocated CMA region through which communication happens.

* Changes *

This patchseries completes support for the SLPI in the Qualcomm SDM845 SoC
by adding the SLPI to the SDM845 DTS and enable it for 2 hardware devices:
- Oneplus 6
- SHIFTPHONES SHIFT6mq

* Related patches *

1. Remoteproc changes to support the SLPI DSP in SDM845:
https://lore.kernel.org/linux-remoteproc/20230325132117.19733-1-me@dylanvanassche.be/
2. FastRPC changes to support the SLPI DSP in SDM845:
https://lore.kernel.org/linux-arm-msm/20230325134410.21092-1-me@dylanvanassche.be/

This serie does not depend on any serie, but all of them are necessary
to enable the feature in the end.

Kind regards,
Dylan Van Assche

Dylan Van Assche (4):
  dts: arm64: qcom: sdm845: add SLPI remoteproc
  dts: arm64: qcom: sdm845: add SLPI FastRPC support
  dts: arm64: qcom: sdm845-oneplus: enable SLPI
  dts: arm64: qcom: sdm845-shift-axolotl: enable SLPI

 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  5 ++
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  5 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 61 +++++++++++++++++++
 3 files changed, 71 insertions(+)

-- 
2.39.2

