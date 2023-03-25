Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB2C6C8E97
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjCYNob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCYNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:44:29 -0400
X-Greylist: delayed 1364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Mar 2023 06:44:28 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B9113C4;
        Sat, 25 Mar 2023 06:44:28 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PkL0S5CL7z9sSw;
        Sat, 25 Mar 2023 14:44:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679751864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aR+hP/m9l3u4+vi2NDp4lyvEWbmEKWe9Ycz0HwJHkU0=;
        b=UVRdNlL7M0kA8hi9aMagjpJ8xaLfEdbQobIexzc/GEMeCVXrtYPI9eWnvjcZvO621Nt/kB
        9DNm4XvrBmf+T76WLMWgUrw3gDuCKCDdYRTIIeExZ6FTSxWmDYtcA3mY1xwhSW1+WSgv60
        bLNnPIjfBVeTG3mhGZ3LtC+DrSBXQ6HL+XqbRTvKVFs4b3tTpIC/9Q+/hGC3Woo3b6R2BC
        Imn2dbcbj7HHscqvMH2dY7te2azXpOa9vasf9uHNPBe9WfAlkNDsVwvoyTevcGYpJVUryH
        p50zojo/JO2RurbZHqfp3eaRuwLzAr1eh1HJ8wTerBg30iNVjl2gcGi/+8/K8A==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 0/2] FastRPC reserved memory assignment for SDM845 SLPI
Date:   Sat, 25 Mar 2023 14:44:08 +0100
Message-Id: <20230325134410.21092-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PkL0S5CL7z9sSw
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

This patchseries add support to the FastRPC for assigning a coherent memory
region to a DSP via the hypervisor with the correct permissions.
This is necessary to support the SLPI found in the Qualcomm SDM845 SoC which
does not have dedicated FastRPC Compute Banks, in contrast to newer SoCs,
but uses a memory region instead.

* Related patches *

1. Remoteproc changes to support the SLPI DSP in SDM845:
https://lore.kernel.org/linux-remoteproc/20230325132117.19733-1-me@dylanvanassche.be/
2. DTS changes will be submitted after this serie.

This serie does not depend on any serie, but all of them are necessary
to enable the feature in the end.

Kind regards,
Dylan Van Assche

Dylan Van Assche (2):
  dt-bindings: misc: qcom,fastrpc: add qcom,assign-all-memory property
  misc: fastrpc: support complete DMA pool access to the DSP

 .../bindings/misc/qcom,fastrpc.yaml           |  6 ++++++
 drivers/misc/fastrpc.c                        | 19 ++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.39.2

