Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A05688E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjBCDg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBCDgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:36:23 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DFA1EBD7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:36:16 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 3133NSqX042892;
        Fri, 3 Feb 2023 11:23:28 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Feb
 2023 11:35:17 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
Subject: [RESENT PATCH v3 -next] crypto: aspeed: fix type warnings
Date:   Fri, 3 Feb 2023 11:35:12 +0800
Message-ID: <20230203033512.980497-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 3133NSqX042892
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes following warnings:

1. sparse: incorrect type in assignment (different base types)
Fix: change to __le32 type.
2. sparse: cast removes address space '__iomem' of expression
Fix: use readb to avoid dereferencing the memory.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
Change since v2: remove unnecessary cast.
Change since v1: keep iomem marker to remain its purpose.

 drivers/crypto/aspeed/aspeed-acry.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 164c524015f0..1f77ebd73489 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -252,7 +252,7 @@ static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
 				    enum aspeed_rsa_key_mode mode)
 {
 	const u8 *src = xbuf;
-	u32 *dw_buf = (u32 *)buf;
+	__le32 *dw_buf = buf;
 	int nbits, ndw;
 	int i, j, idx;
 	u32 data = 0;
@@ -302,7 +302,7 @@ static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
 static int aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)
 {
 	struct akcipher_request *req = acry_dev->req;
-	u8 *sram_buffer = (u8 *)acry_dev->acry_sram;
+	u8 __iomem *sram_buffer = acry_dev->acry_sram;
 	struct scatterlist *out_sg = req->dst;
 	static u8 dram_buffer[ASPEED_ACRY_SRAM_MAX_LEN];
 	int leading_zero = 1;
@@ -321,11 +321,11 @@ static int aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)
 
 	for (j = ASPEED_ACRY_SRAM_MAX_LEN - 1; j >= 0; j--) {
 		data_idx = acry_dev->data_byte_mapping[j];
-		if (sram_buffer[data_idx] == 0 && leading_zero) {
+		if (readb(sram_buffer + data_idx) == 0 && leading_zero) {
 			result_nbytes--;
 		} else {
 			leading_zero = 0;
-			dram_buffer[i] = sram_buffer[data_idx];
+			dram_buffer[i] = readb(sram_buffer + data_idx);
 			i++;
 		}
 	}
-- 
2.25.1

