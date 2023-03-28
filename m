Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E3F6CCB04
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjC1T4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjC1T41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:56:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFAD3AAA;
        Tue, 28 Mar 2023 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680033386; x=1711569386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3xmdzUlUHuX0xIMraGebBNCDEpGfEWNIysVoHmlrc8=;
  b=zw+8y/FJNMzxhqxyGfJl+LARhaNqM2Kk+ZFtBSVpLwychdlJw67JExZX
   9R0VX1hIfD7W3qbR6WOmuAvHXe0qzg123dyMN7JM8dVjRhImawzoqtMlo
   t4WHES7wrQpjQYLhNoUnE0RRdv43KJd9Aq9BKu4+LT4o9kPcnU+5uNcLM
   6IrhIoDETgzlGtaN3luU+xuYO9OBVVaVlWcpnwvkCjc9PIliCHE/TUJqb
   uHA0Bm4RAH7uTmfXl+ucjnVlwL9e/DChS2OUzTv4ryoSWOBSSDfrL0cDV
   27UahbTXJDMetk/M9FvVm5p+YTWUzc/vem/CnogM3G9FQzFLDr8x6ylXY
   A==;
X-IronPort-AV: E=Sophos;i="5.98,297,1673938800"; 
   d="scan'208";a="144351916"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Mar 2023 12:56:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 12:56:22 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 12:56:22 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 4/4] crypto: atmel-aes - Match cfb block size with generic implementation
Date:   Tue, 28 Mar 2023 12:56:29 -0700
Message-ID: <5a21411d8dd263155f86fb067d446b3359a60c9b.1680019905.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1680019905.git.Ryan.Wanner@microchip.com>
References: <cover.1680019905.git.Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Change blocksize to match the cfb(aes) generic implementation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/crypto/atmel-aes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 08a923c2a0eb..012cdf60d9d2 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -1335,7 +1335,7 @@ static struct skcipher_alg aes_algs[] = {
 {
 	.base.cra_name		= "cfb(aes)",
 	.base.cra_driver_name	= "atmel-cfb-aes",
-	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_blocksize	= 1,
 	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
 
 	.init			= atmel_aes_init_tfm,
-- 
2.37.2

