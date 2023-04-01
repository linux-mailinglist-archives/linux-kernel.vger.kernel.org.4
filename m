Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97FF6D32D9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDARfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDARfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:35:41 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0583B443;
        Sat,  1 Apr 2023 10:35:38 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Ppknx5RwKz9sTM;
        Sat,  1 Apr 2023 19:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680370533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QlwqryxjwFEcRsCwNYC3KAfNY5tSCiH5bPCN24vQW8k=;
        b=Y8Ggx7+z0JfhkBKAMSKQwsd3Efzv/edr2wsa1hx7Dk9YaqXtDJE66DNTLbh5UTcGn0UZvH
        fncXnnA847hrNt1TSPE5xNOo1uWVEIexnbtX7s+lT1McTSM6kqG6BPgIyZTyu8vnED5HyJ
        XaPG76fYyL6BfuL9MuomWOnJyhU+2Y4/Bkic+A0zbFC84uTW4INTlnAnErAoC77+boCive
        N5CQfIUFUFd965Zcyx9Rrg1m6rAovuzbPGXGHLAng0J//Z8Cckr/FgGZzGX+6jdZ3x8R6A
        66fsQI+cRLmTAAnfxIAvj53mePFJV81/e07xYV3od9qQSky22o47JlkjwtQTWA==
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
Subject: [PATCH v4 0/6] dts: qcom: arm64: sdm845: SLPI DSP enablement
Date:   Sat,  1 Apr 2023 19:35:17 +0200
Message-Id: <20230401173523.15244-1-me@dylanvanassche.be>
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

1. Remoteproc changes (v3) to support the SLPI DSP in SDM845:
https://lore.kernel.org/linux-remoteproc/20230330164633.117335-1-me@dylanvanassche.be
2. FastRPC changes (v2) to support the SLPI DSP in SDM845:
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

Changes in v3:

- Dropped FastRPC dt-bindings change, unnecessary to relax the bindings
- Add reg property to compute-cb for the SLPI on SDM845

Changes in v4:
- Moved SLPI node in sdm845.dtsi to honor sorting by unit address
- Reordered FastRPC memory nodes to have a reverse-Christmas-tree layout
- Use 0x0 instead of 0 for memory addresses
- Add SSC_Q6 (0x5) and ADSP_Q6 (0x6) VMIDs to qcom,scm.h
- Replace magic VMID values by the qcom,scm.h in sdm845.dtsi
- Added Reviewed-by tags for patches:
  - 'dts: arm64: qcom: sdm845-oneplus: enable SLPI'
  - 'dts: arm64: qcom: sdm845-shift-axolotl: enable SLPI'
  as these are unchanged in v4.

Kind regards,
Dylan Van Assche

Dylan Van Assche (6):
  dts: arm64: qcom: sdm845: add SLPI remoteproc
  dts: arm64: qcom: sdm845: add SLPI FastRPC support
  dt-bindings: firmware: qcom: scm: add SSC_Q6 and ADSP_Q6 VMIDs
  dts: qcom: arm64: qcom: sdm845: use defines for VMIDs
  dts: arm64: qcom: sdm845-oneplus: enable SLPI
  dts: arm64: qcom: sdm845-shift-axolotl: enable SLPI

 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  5 ++
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  5 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 62 +++++++++++++++++++
 include/dt-bindings/firmware/qcom,scm.h       |  2 +
 4 files changed, 74 insertions(+)

-- 
2.39.2

