Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB2F6636BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjAJBjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjAJBjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:39:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578211AA1A;
        Mon,  9 Jan 2023 17:39:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE787614A3;
        Tue, 10 Jan 2023 01:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EACC433EF;
        Tue, 10 Jan 2023 01:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673314750;
        bh=2kOxmVscJ0t8ceI4B5aGjHT1LyF2wAdxmeKbbucTgVM=;
        h=Date:From:To:Cc:Subject:From;
        b=s0zcsXJ1bYO8TaF0VS1YgBT615bIXmHXZD4oEytBCR1eBws6SdPfRKfb8iCQy2bwi
         owhRi/eU+e6OrfUiuL2KvlT9gPe2e84ZwDdTAgXGaJRJqaZ+3zYlII7zET63AuuacT
         OOLOQ5vkrHKQ+qCH5knAXbqMsy8ANjQm+QP7HRZ8bGYHHAu0TPQk7gdLxl8bsPX+d9
         7Kl6R4WnMAEbXJE6xSR3P2eLOirCsBz8gUBHRq+0oN+5DNjocpnMFuTpR/zSs8yyuB
         7hTz7g6pKLdX3dp9DEPrlcEIS7JV4OTc869bVmm5Jluoh6O0akYlKjOhE+gq9/w2Cn
         LDLPR+Yi6q1kg==
Date:   Mon, 9 Jan 2023 19:39:17 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] crypto: aspeed - Replace zero-length array with
 flexible-array member
Message-ID: <Y7zBxbEAvcEEJRie@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1] and we are moving towards
adopting C99 flexible-array members instead. So, replace zero-length
array declaration in struct aspeed_sham_ctx with flex-array
member.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/aspeed/aspeed-hace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.h b/drivers/crypto/aspeed/aspeed-hace.h
index f2cde23b56ae..05d0a15d546d 100644
--- a/drivers/crypto/aspeed/aspeed-hace.h
+++ b/drivers/crypto/aspeed/aspeed-hace.h
@@ -183,7 +183,7 @@ struct aspeed_sham_ctx {
 	struct aspeed_hace_dev		*hace_dev;
 	unsigned long			flags;	/* hmac flag */
 
-	struct aspeed_sha_hmac_ctx	base[0];
+	struct aspeed_sha_hmac_ctx	base[];
 };
 
 struct aspeed_sham_reqctx {
-- 
2.34.1

