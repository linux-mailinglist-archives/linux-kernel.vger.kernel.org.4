Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35456F927D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjEFOR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjEFORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:17:49 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91A619D42;
        Sat,  6 May 2023 07:17:41 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id D7D8420008;
        Sat,  6 May 2023 14:17:38 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 2/2] sh: dma: Correct the number of DMA channels in SH7709
Date:   Sat,  6 May 2023 16:17:03 +0200
Message-Id: <20230506141703.65605-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230506141703.65605-1-contact@artur-rojek.eu>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the PM, the DMAC found in SH7709 features only 4 channels.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/sh/drivers/dma/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
index 7d54f284ce10..4494d09597e9 100644
--- a/arch/sh/drivers/dma/Kconfig
+++ b/arch/sh/drivers/dma/Kconfig
@@ -28,8 +28,9 @@ config SH_DMA_API
 config NR_ONCHIP_DMA_CHANNELS
 	int
 	depends on SH_DMA
-	default "4" if CPU_SUBTYPE_SH7750  || CPU_SUBTYPE_SH7751  || \
-		       CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7091
+	default "4" if CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7750  || \
+		       CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7750S || \
+		       CPU_SUBTYPE_SH7091
 	default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || \
 		       CPU_SUBTYPE_SH7760
 	default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7780  || \
@@ -37,8 +38,9 @@ config NR_ONCHIP_DMA_CHANNELS
 	default "6"
 	help
 	  This allows you to specify the number of channels that the on-chip
-	  DMAC supports. This will be 4 for SH7750/SH7751/Sh7750S/SH7091 and 8 for the
-	  SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724, default is 6.
+	  DMAC supports. This will be 4 for SH7709/SH7750/SH7751/Sh7750S/SH7091
+	  and 8 for the SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724,
+	  default is 6.
 
 config SH_DMABRG
 	bool "SH7760 DMABRG support"
-- 
2.40.1

