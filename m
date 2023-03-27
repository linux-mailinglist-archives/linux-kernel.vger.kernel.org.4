Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113C66CAD21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjC0Sh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjC0Sh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:37:56 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2D3AAF;
        Mon, 27 Mar 2023 11:37:53 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PlhQ54Lpsz9sbP;
        Mon, 27 Mar 2023 20:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679942269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C8kkdUguiMjdIapGBB4Pr2z2atFYN6EF4wazx5kklCs=;
        b=gAbXfp4dquLJjFqWTC1MnWG1++pJ2iXoRNrydg8SYK6C0hBryDC5DEOY/wwTUvi/NqfjFO
        dOaXw8FcxVf6X/OAZ2L3gDKOXQUTTCpDQuT/zICvZkoNJcr7bN1PeQdsBe4hGTBlxAFVIR
        xWeIiTgfXGexixR+ukJjnGkacoKO5uM7Os9Pm3ywVdRAR8PiK3nSP7QsNsOu84rhAetTPg
        4JT874O0GDR/Rys88iYr4uUSxouq/Cy858IPpZXkSVr7Yi+NCh9lJLJkCAhyOVZcY9fUEF
        fEFAb7FK+asYwHaKzGCaxlMXU4vmtwnFZ12bJlFLWS+jbCSRaenhcsSFQ0WhrQ==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 0/3] remoteproc: qcom: pas: Support SDM845 SLPI
Date:   Mon, 27 Mar 2023 20:37:33 +0200
Message-Id: <20230327183736.496170-1-me@dylanvanassche.be>
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

This patchseries adds support for this remoteproc in the q6v5_pas driver
to allow booting the SLPI on the SDM845 and expose its service 400 over QRTR.

* Related patches *

Support for the FastRPC side of the SLPI and DTS changes are submitted 
in separate series. These are the links to v1 of the series:

1. FastRPC changes:
https://lore.kernel.org/linux-arm-msm/20230325134410.21092-1-me@dylanvanassche.be/
2. DTS changes:
https://lore.kernel.org/linux-devicetree/20230325135114.21688-1-me@dylanvanassche.be/

* Changelog *

Changes in v2:

- Removed double blank lines
- Added power-domain if:then: for SDM845 SLPI
- After adding SDM845 SLPI, refactor SLPI resource init

Kind regards,
Dylan Van Assche

Dylan Van Assche (3):
  dt-bindings: remoteproc: qcom: adsp: add qcom,sdm845-slpi-pas
    compatible
  remoteproc: qcom: pas: add SDM845 SLPI resource
  remoteproc: qcom: pas: refactor SLPI remoteproc init

 .../bindings/remoteproc/qcom,adsp.yaml        | 19 +++++++
 drivers/remoteproc/qcom_q6v5_pas.c            | 49 ++++---------------
 2 files changed, 28 insertions(+), 40 deletions(-)

-- 
2.39.2

