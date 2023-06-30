Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779B47444EE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjF3Whm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3Whk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:37:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B03A3C22;
        Fri, 30 Jun 2023 15:37:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d885b0256so2799658a12.2;
        Fri, 30 Jun 2023 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688164658; x=1690756658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHcB/iLisBvflfYzvvCWaPnr6rCwiIa7meLN1SJ4+28=;
        b=iO1ic/HFhwjuzVm+DHsUdZ7k4vUGoyd8D6V2YXhNH8/8uBYXScOb+W5WCPSuiJ+L5B
         YqUMMbiZyFk3b80MehDj/decPoIwfuafed4sDGIy6LI5rTIb4+rslZ4swjyH5H9Z9ccR
         HWNmYqGVjyIAPZbX7VQ9LKp/Df5HF0cdjriM7JY+qp/aey5qoO27ri7Aub8awSogtExm
         RLzpCcE8XfiTK4Mo8ZdzuGvsJHRd5qKCtzpAgSuTNuF6fFejNMpLl7k+XYoQ9x+yxzyJ
         TWn1lY8TWX2ZBhGnJDUYfYouHcUJ+80o/fUKR75pqXxf0I4gCQ/SfkQZnhKNvvTw/Cbt
         VGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688164658; x=1690756658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHcB/iLisBvflfYzvvCWaPnr6rCwiIa7meLN1SJ4+28=;
        b=POdpJqCqCnTGVLbbjcW3d3W/7EFzAIOFkQX74oWfjONqVLYLgyEj+dp58oA7y7HOT4
         1iHUMEkHB33aYb9+389dX3mIM6cKdfB05TgOtmKQdEej4/vxDsEMfDoAQTKEvtJnXf9n
         tys3AFSeinAtD98Iyqg0CnxgnBwmNSN3eZUByAWacAvbljFEQi82U9+o5N5WtqkIuN63
         m/6dhQ6Xfnrlfb7MFkqsL+vre179M/PId/RTtuC074Ji4HDlasIW5qfB50AVf29kUjWr
         YplKpXpveoLGG/kv2Dl0fjtADqDQotjJ+2r/l5u+VevHFuEXEpnFrmLNuUJRLA4RrVV9
         7Y7w==
X-Gm-Message-State: ABy/qLZDvoKEe3APA44Nnx4NChi751UGr8GxrWw5+jYbP164yrcPBzE3
        orI0PTMogXiNFlOLrSxdjMY=
X-Google-Smtp-Source: APBJJlGalle3nE4th/qdxhjroKEJ1EdtxMZefxVeVzqdomk7RFFEccOlbYqSeTBDHby2vZeWhNQjiw==
X-Received: by 2002:aa7:c6da:0:b0:51c:d01d:ce7 with SMTP id b26-20020aa7c6da000000b0051cd01d0ce7mr2425669eds.33.1688164657496;
        Fri, 30 Jun 2023 15:37:37 -0700 (PDT)
Received: from localhost.localdomain (snat-11.cgn.sat-an.net. [176.222.226.11])
        by smtp.gmail.com with ESMTPSA id z24-20020aa7cf98000000b0051bfcd3c4desm7021206edx.19.2023.06.30.15.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:37:37 -0700 (PDT)
From:   Jakub Vanek <linuxtardis@gmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jakub Vanek <linuxtardis@gmail.com>, stable@vger.kernel.org,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] usb: dwc3: Disable AutoRetry controller feature for dwc_usb3 v2.00a
Date:   Sat,  1 Jul 2023 00:36:38 +0200
Message-Id: <20230630223638.2250-1-linuxtardis@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AutoRetry has been found to cause issues in this controller revision.
This feature allows the controller to send non-terminating/burst retry
ACKs (Retry=1 and Nump!=0) as opposed to terminating retry ACKs
(Retry=1 and Nump=0) to devices when a transaction error occurs.

Unfortunately, some USB devices do not retry transfers when
the controller sends them a non-terminating retry ACK. After the transfer
times out, the xHCI driver tries to resume normal operation of the
controller by sending a Stop Endpoint command to it. However, this
revision of the controller fails to respond to that command in this
state and the xHCI driver therefore gives up. This is reported via dmesg:

[sda] tag#29 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
[sda] tag#29 CDB: opcode=0x28 28 00 00 69 42 80 00 00 48 00
xhci-hcd: xHCI host not responding to stop endpoint command
xhci-hcd: xHCI host controller not responding, assume dead
xhci-hcd: HC died; cleaning up

This problem has been observed on Odroid HC2. This board has
an integrated JMS578 USB3-to-SATA bridge. The above problem could be
triggered by starting a read-heavy workload on an attached SSD.
After a while, the host controller would die and the SSD would disappear
from the system.

Reverting b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature in
the controller") stopped the issue from occurring on Odroid HC2.
As this problem hasn't been reported on other devices, disable
AutoRetry just for the dwc_usb3 revision v2.00a that the board SoC
(Exynos 5422) uses.

Fixes: b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature in the controller")
Link: https://lore.kernel.org/r/a21f34c04632d250cd0a78c7c6f4a1c9c7a43142.camel@gmail.com/
Link: https://forum.odroid.com/viewtopic.php?t=42630
Cc: stable@vger.kernel.org
Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Jakub Vanek <linuxtardis@gmail.com>
---
 drivers/usb/dwc3/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d68958e151a7..d742fc882d7e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1218,9 +1218,15 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		 * Host mode on seeing transaction errors(CRC errors or internal
 		 * overrun scenerios) on IN transfers to reply to the device
 		 * with a non-terminating retry ACK (i.e, an ACK transcation
-		 * packet with Retry=1 & Nump != 0)
+		 * packet with Retry=1 & Nump != 0).
+		 *
+		 * Do not enable this for DWC_usb3 v2.00a. This controller
+		 * revision stops responding to Stop Endpoint commands if
+		 * a USB device does not retry after a non-terminating retry
+		 * ACK is sent to it.
 		 */
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+		if (!DWC3_VER_IS(DWC3, 200A))
+			reg |= DWC3_GUCTL_HSTINAUTORETRY;
 
 		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
 	}
-- 
2.25.1

