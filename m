Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095106A14C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBXCFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBXCFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:05:35 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D4838658
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:05:32 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 31O1qK9V007233;
        Fri, 24 Feb 2023 09:52:20 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 24 Feb
 2023 10:05:24 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
Subject: [PATCH v2] crypto: aspeed: add error handling if dmam_alloc_coherent() failed
Date:   Fri, 24 Feb 2023 10:05:21 +0800
Message-ID: <20230224020521.3158285-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 31O1qK9V007233
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the acry_dev->buf_addr may be NULL, add error handling to
prevent any additional access to avoid potential issues.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
Change since v1: remove memzero_explicit() as dmam_alloc_coherent()
returns memory that's already zeroed.

 drivers/crypto/aspeed/aspeed-acry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 1f77ebd73489..eb30649ea7b3 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -782,7 +782,10 @@ static int aspeed_acry_probe(struct platform_device *pdev)
 	acry_dev->buf_addr = dmam_alloc_coherent(dev, ASPEED_ACRY_BUFF_SIZE,
 						 &acry_dev->buf_dma_addr,
 						 GFP_KERNEL);
-	memzero_explicit(acry_dev->buf_addr, ASPEED_ACRY_BUFF_SIZE);
+	if (!acry_dev->buf_addr) {
+		rc = -ENOMEM;
+		goto err_engine_rsa_start;
+	}
 
 	aspeed_acry_register(acry_dev);
 
-- 
2.25.1

