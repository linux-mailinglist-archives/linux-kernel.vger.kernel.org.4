Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0613A6D9ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbjDFRdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbjDFRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:33:40 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB428A7A;
        Thu,  6 Apr 2023 10:33:19 -0700 (PDT)
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PspVz3fYyz9sW5;
        Thu,  6 Apr 2023 19:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680802395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n+QKer/py7TYF0+btZiVdHF6Qql5Af4f0rRDFyBjvgQ=;
        b=0px1b44FXUtpEGPBbZvIv/ua7v0eB3wWbTazLPw5Vvfkc6rYUy6p8UhAf0k55Mi8GEx3Lh
        8XStSOj9DFdsk3/sfc3krFf5h2QlRw1SNXuggRlySY2m+ElAIN89EIPyAyB8tlueBrcjze
        FvUhUg/ETbgM24lM3/pyYgliv3PElfrTXZXNQF94/3EQeCF0f6tJHEIx4zdO/axmu+jr3j
        6EEkKVqdksa+hREgMSwI572PLY5+4bZOVGGhI7nJ/9seRa9lpe7yac45ViQJf0jqhsPV3Y
        kiBkxIRoCO8giYsAX4gVlgHSmC3UhxP7Y+KBXm5FA83911SY6lvqEFc7vdPzOQ==
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
Subject: [PATCH v5 0/5] arm64: dts: qcom: sdm845: add SLPI remoteproc
Date:   Thu,  6 Apr 2023 19:31:43 +0200
Message-Id: <20230406173148.28309-1-me@dylanvanassche.be>
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

Changes in v5:
- Squashed patch 'dts: qcom: arm64: qcom: sdm845: use defines for VMIDs'
  into 'dts: arm64: qcom: sdm845: add SLPI FastRPC support'.
- Reordered patches do make sure we first define the additional VMIDs
  in dt-bindings before using them.
- Added Acked-by for
  'dt-bindings: firmware: qcom: scm: add SSC_Q6 and ADSP_Q6 VMIDs'.
- Fix order of 'arm64' and 'dts' in patch subjects to match tree.

Kind regards,
Dylan Van Assche

Dylan Van Assche (5):
  arm64: dts: qcom: sdm845: add SLPI remoteproc
  dt-bindings: firmware: qcom: scm: add SSC_Q6 and ADSP_Q6 VMIDs
  arm64: dts: qcom: sdm845: add SLPI FastRPC support
  arm64: dts: qcom: sdm845-oneplus: enable SLPI
  arm64: dts: qcom: sdm845-shift-axolotl: enable SLPI

 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  5 ++
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  5 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 62 +++++++++++++++++++
 include/dt-bindings/firmware/qcom,scm.h       |  2 +
 4 files changed, 74 insertions(+)

-- 
2.39.2

