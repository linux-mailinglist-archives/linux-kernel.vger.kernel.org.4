Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A646F9779
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjEGILb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 04:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjEGIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:11:29 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4E14345;
        Sun,  7 May 2023 01:11:20 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QDcZD4grkz9sck;
        Sun,  7 May 2023 10:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1683447076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LROmirExRCF+QadD8DHkqyTlH8jb5FTHqGp+6hp6CEs=;
        b=HVVKcyI2C5IkQSC2nv9TCDI0jpu3fpowQyh2QaIdnwJiQLvcXY2Y8NOebT+lq4ivAwZFbK
        Hwv/6MS2dSWsL2+xYuyCubxT7NdA1MAL0LQ5AaUhGAs6nVybkTuy4EvRtmhepHY6g7DJAH
        d3tqBtpdEMcIfi0kUvvbwfp/MBFTMuiQNRzD6Uqzj+3jDClraFHTngyDT8/RC2uYl0uWhI
        issudTEbo8p4bJWep8aMX9AUEuD2BfvgCGCOs32xKWLMNkatCmuvYRd9z0QaExYSSXVwKD
        MTYOuqlOUH5vg4gZMWXIsRZDGHSWI47BwCRuSJz16S85olgDAMvW+Wryo52oWw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     srinivas.kandagatla@linaro.org, amahesh@qti.qualcomm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v3 0/2] misc: fastrpc: FastRPC reserved memory assignment for SDM845 SLPI
Date:   Sun,  7 May 2023 10:08:37 +0200
Message-Id: <20230507080839.37578-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v3:
- Dropped debug prints.
- Added Reviewed-By tags from v2.

Changes in v2:

- Removed double blank lines
- Dropped dt-bindings property as it is not needed for driver behavior
- Add additional patch to allocate buffers via CMA memory for DSPs
  without dedicated FastRPC Compute Banks.

Kind regards,
Dylan Van Assche

Dylan Van Assche (2):
  misc: fastrpc: support complete DMA pool access to the DSP
  misc: fastrpc: use coherent pool for untranslated Compute Banks

 drivers/misc/fastrpc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.40.1

