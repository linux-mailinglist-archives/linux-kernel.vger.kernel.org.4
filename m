Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40976CADCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjC0Ssa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0Ss2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:48:28 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F3BA3;
        Mon, 27 Mar 2023 11:48:27 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PlhfH2qykz9sTW;
        Mon, 27 Mar 2023 20:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679942903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dhL+LGkrki0muDqB8H1PWedY5IW9NDpXQ10RZ+jS+8A=;
        b=U4i6PKhzr4RvzH9iWGMl6PPd7WLKRwAUoklD+dV+8+/89X5vDp0dTOAiKOLgaj8zji6hLo
        6dYqHe4CIBN8ckpzpuUGy9FbW++xyHrZuSoaoUSBOFDPiDdv3LhZ2WIMkmteHxWFQyCQub
        Jv9d3mW9cWrVtCyzYHBWFHWOzKNDUr8ltrR557/xZkoYn1wmj7wSHtFzEJiAI9waLIl8Ps
        LDJaK77jRrT4IgJkswQsLtP2u9/VzDgtyJ945HWWVy/S+dtiylsro3+UtVLJueV0ZHByUE
        TSjObyXFmAJSsph1FfH4KdGR/YinmPl5KmoZHO4JyOeAio2CAFLpU+m5e0O3yQ==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 0/5] dts: qcom: arm64: sdm845: SLPI DSP enablement
Date:   Mon, 27 Mar 2023 20:48:06 +0200
Message-Id: <20230327184811.499553-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

1. Remoteproc changes to support the SLPI DSP in SDM845 (v2):
https://lore.kernel.org/linux-remoteproc/20230327183736.496170-1-me@dylanvanassche.be/
2. FastRPC changes to support the SLPI DSP in SDM845 (v2):
https://lore.kernel.org/linux-arm-msm/20230327184204.498032-1-me@dylanvanassche.be/

This serie does not depend on any serie, but all of them are necessary
to enable the feature in the end.

* Changelog *

Changes in v2:

- Removed double blank lines
- Enforce alphabetically order for 'slpi_pas'
- Reordered 'slpi_pas' properties
- Fixed FastRPC syntax
- Dropped qcom,assign-all-mem property as this is not necessary anymore

Kind regards,
Dylan Van Assche

Dylan Van Assche (5):
  dts: arm64: qcom: sdm845: add SLPI remoteproc
  dt-bindings: misc: qcom,fastrpc: allow FastRPC node without reg entry
  dts: arm64: qcom: sdm845: add SLPI FastRPC support
  dts: arm64: qcom: sdm845-oneplus: enable SLPI
  dts: arm64: qcom: sdm845-shift-axolotl: enable SLPI

 .../bindings/misc/qcom,fastrpc.yaml           |  3 +-
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  5 ++
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  5 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 59 +++++++++++++++++++
 4 files changed, 70 insertions(+), 2 deletions(-)

-- 
2.39.2

