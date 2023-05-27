Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AFB7135C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjE0Qpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjE0Qp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:45:26 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABAED8;
        Sat, 27 May 2023 09:45:18 -0700 (PDT)
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5A4A20003;
        Sat, 27 May 2023 16:45:15 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 3/3] sh: dma: Correct the number of DMA channels in SH7709
Date:   Sat, 27 May 2023 18:44:52 +0200
Message-Id: <20230527164452.64797-4-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527164452.64797-1-contact@artur-rojek.eu>
References: <20230527164452.64797-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the hardware manual [1], the DMAC found in SH7709 features
only 4 channels.

While at it, also sort the existing targets and clarify that
NR_ONCHIP_DMA_CHANNELS must be a multiply of two.

[1] https://www.renesas.com/us/en/document/mah/sh7709s-group-hardware-manual (p. 373)

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

v2: - sort existing targets
    - clarify that the value must be a multiply of two

 arch/sh/drivers/dma/Kconfig | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
index 7d54f284ce10..382fbb189fcf 100644
--- a/arch/sh/drivers/dma/Kconfig
+++ b/arch/sh/drivers/dma/Kconfig
@@ -28,17 +28,19 @@ config SH_DMA_API
 config NR_ONCHIP_DMA_CHANNELS
 	int
 	depends on SH_DMA
-	default "4" if CPU_SUBTYPE_SH7750  || CPU_SUBTYPE_SH7751  || \
-		       CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7091
+	default "4" if CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7750  || \
+		       CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7751 || \
+		       CPU_SUBTYPE_SH7091
 	default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || \
 		       CPU_SUBTYPE_SH7760
-	default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7780  || \
-			CPU_SUBTYPE_SH7785 || CPU_SUBTYPE_SH7724
+	default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7724  || \
+			CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785
 	default "6"
 	help
 	  This allows you to specify the number of channels that the on-chip
-	  DMAC supports. This will be 4 for SH7750/SH7751/Sh7750S/SH7091 and 8 for the
-	  SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724, default is 6.
+	  DMAC supports. This will be 4 for SH7709/SH7750/SH7750S/SH7751/SH7091,
+	  8 for SH7750R/SH7751R/SH7760, and 12 for SH7723/SH7724/SH7780/SH7785.
+	  Default is 6. Must be an even number.
 
 config SH_DMABRG
 	bool "SH7760 DMABRG support"
-- 
2.40.1

