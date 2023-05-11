Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB7D6FF3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbjEKONl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjEKONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:13:34 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B521BC1;
        Thu, 11 May 2023 07:12:54 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QHDNW34ZCz9spr;
        Thu, 11 May 2023 16:11:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1683814315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sd6dUDVlduWJM+HnYeES6xBRaZitnQSV9AIx4FVcTS4=;
        b=enBGY9cNK1pl7ZE79ErAPB18bUZq92u1aUO0RZcFogDASNVKiSz0Nbn+hhZkVJx63kAbtb
        C/m3YuFDkhxXc+zgX9HxU+Jdt4EulWMM6uHtJm0b6qsm3HKw1oY5mKLi3Kr71UYp8uHAh3
        37GzsKo+04lmYP0darIL52Co5egARFDiLjdCrTWaU66aMaJWDVleApSFt6UQBdFZxocFPt
        X1UMVwUdnhnZ6KGWBZZ7fwJwjkgTCWc0BjhC7EwaN2VaQ4UTOtehwzYPbH18RXHAb2Y+9I
        KOTPW03yjHUrxr0UE+t0fEsUUK3bkwnGDHB999vU60BKHbIa1kNrES2j9RONBw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     srinivas.kandagatla@linaro.org, amahesh@qti.qualcomm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        dan.carpenter@linaro.org, Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v4 0/2] misc: fastrpc: FastRPC reserved memory assignment for SDM845 SLPI
Date:   Thu, 11 May 2023 16:11:44 +0200
Message-Id: <20230511141146.30465-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QHDNW34ZCz9spr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
but uses a memory region instead when allocating buffers.

* Related patches *

1. Remoteproc changes to support the SLPI DSP in SDM845 (v3), needs to be applied:
https://lore.kernel.org/linux-remoteproc/20230330164633.117335-1-me@dylanvanassche.be
2. DTS changes (v5), already applied:
https://lore.kernel.org/linux-devicetree/20230406173148.28309-1-me@dylanvanassche.be

This serie does not depend on any serie, but all of them are necessary
to enable the feature in the end.

* Changelog *

Changes in v4:
- Fixed possible memory leak when driver encounters an error during probing.

Changes in v3:
- Dropped debug prints.
- Added Reviewed-By tags from v2.

Changes in v2:

- Removed double blank lines
- Dropped dt-bindings property as it is not needed for driver behavior
- Add additional patch to allocate buffers via CMA memory for DSPs
  without dedicated FastRPC Compute Banks.

Dylan Van Assche (2):
  misc: fastrpc: support complete DMA pool access to the DSP
  misc: fastrpc: use coherent pool for untranslated Compute Banks

 drivers/misc/fastrpc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.40.1

