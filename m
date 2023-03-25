Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A0F6C8E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCYNVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYNVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:21:48 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61390BDED;
        Sat, 25 Mar 2023 06:21:46 -0700 (PDT)
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PkKVC6hKTz9sx2;
        Sat, 25 Mar 2023 14:21:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679750499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rQ4rmDiN74N93ke3ZfdLAVNzGoB4ib6CMk1ag8Q3NV0=;
        b=tMw+jM5JSj9ECmfpovTCPePydYS+RsWoGnpX7iudp/qiKaZzrnqr72z2eKizb8i2lNT0OG
        +dY9IvoFN9ukFT9s2N+peVdsszgw/ibXwpWnaFuEpYl1DhGaXavAJiTGZDrKgShAEHY8E7
        P23kJ0FvqpZxWaDdcvKALNHMgCvbVQzoDH2fGxgY02wr+tudiVjUQK54Pn9lrSXVO1N7B4
        t+xcrVhMUdJVkAOW3ubSroyudyRsXqfU+l3p0CYp6APSiFIYXwdk8O1u+weR+WArQ3U4o3
        m5Bs9txPxNtH05VY7dcl/+F2NiHaxdg/NSNqR2yqRQYfOslV9qzk2irGu9Qpqw==
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
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 0/2] Qualcomm SDM845 SLPI DSP driver support
Date:   Sat, 25 Mar 2023 14:21:15 +0100
Message-Id: <20230325132117.19733-1-me@dylanvanassche.be>
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

This set of patches adds support to drivers for the SLPI DSP:
1. Configure the permissions of assigned DSP memory through the hypervisor.
2. Allocate a remote heap when the FastRPC session ID is 0 instead of using 
a Compute Bank directly.
3. Add the SLPI remoteproc resource to the q6v5_pas driver to enable support
for it in the driver.
over QRTR.

DTS changes to enable the SLPI DSP in the SDM845 DTS and hardware
e.g. Oneplus 6 and SHIFTPHONES SHIFT6mq will be send once the driver changes
are applied.

Kind regards,
Dylan Van Assche

Dylan Van Assche (2):
  dt-bindings: remoteproc: qcom: adsp: add qcom,sdm845-slpi-pas
    compatible
  remoteproc: qcom: pas: add SDM845 SLPI resource

 .../bindings/remoteproc/qcom,adsp.yaml          |  3 +++
 drivers/remoteproc/qcom_q6v5_pas.c              | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.39.2

