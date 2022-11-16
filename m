Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EBC62C03C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiKPN60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiKPN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:56:30 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E754347312;
        Wed, 16 Nov 2022 05:53:14 -0800 (PST)
Received: from hednb3.intra.ispras.ru (unknown [10.10.2.52])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8001040737B7;
        Wed, 16 Nov 2022 13:53:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8001040737B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1668606790;
        bh=JxEVrn+CoDPfLQqba4pxYEzAJIOuMvgQmIttHtvn1nE=;
        h=From:To:Cc:Subject:Date:From;
        b=GxRIBPHdwORe3YfuO45TguEuwZDn1SBQbbYIORdScBHlLqWH2KaPNlS6IXwA2t33G
         Suk07DbARRW/aQ1wVSMB0pJ3Wijv6GtYZ3pZ0dS1qL+gnwmVpZ3wOyoiL+08/WMrO8
         c+GhvrD/Jcnb2lBAil85JrLR1GRpCgAwhgqFb9J8=
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] crypto: algapi - fix be32_to_cpu macro call in crypto_inc()
Date:   Wed, 16 Nov 2022 16:52:51 +0300
Message-Id: <1668606771-5382-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

be32_to_cpu() macro in some cases may be expanded to an expression
that evaluates its arguments multiple times. Because of the decrement
in argument it has unexpected result in such cases.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 7613636def82 ("[CRYPTO] api: Add crypto_inc and crypto_xor")
---
 crypto/algapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 5c69ff8e8fa5..18f14aed1658 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -987,7 +987,8 @@ void crypto_inc(u8 *a, unsigned int size)
 	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
 	    IS_ALIGNED((unsigned long)b, __alignof__(*b)))
 		for (; size >= 4; size -= 4) {
-			c = be32_to_cpu(*--b) + 1;
+			b--;
+			c = be32_to_cpu(*b) + 1;
 			*b = cpu_to_be32(c);
 			if (likely(c))
 				return;
-- 
2.7.4

