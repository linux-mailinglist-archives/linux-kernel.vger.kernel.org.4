Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D3659229
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiL2VSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiL2VSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B662BC32
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672348651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwfJcVBxWNMAZYpPSPCoOdNBGIp3nX0+9louWAKvFDk=;
        b=YUIHjnC0xTzv5EZEMU1k4u4a/hXLTr+ZmvOj0t18H63Qu0iVO6mnrnEf97RTQXweMu+uoz
        zZrmcSRBPX4pKcGtt5lU2QkgueTTb+3IqZbeq63syQGoKYglGOT7rIKHCyCrVhCWo8FVa+
        JrSJORenijhXhdj5YInJqv95tJ8jl1g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-JWXU0-KVNMuepvPYIMb6zQ-1; Thu, 29 Dec 2022 16:17:28 -0500
X-MC-Unique: JWXU0-KVNMuepvPYIMb6zQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D113B8F6E83;
        Thu, 29 Dec 2022 21:17:27 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-208-2.brq.redhat.com [10.40.208.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E13B492B00;
        Thu, 29 Dec 2022 21:17:25 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolai Stange <nstange@suse.de>, Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH v3 3/6] crypto: xts - drop redundant xts key check
Date:   Thu, 29 Dec 2022 22:17:07 +0100
Message-Id: <20221229211710.14912-4-vdronov@redhat.com>
In-Reply-To: <20221229211710.14912-1-vdronov@redhat.com>
References: <20221229211710.14912-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xts_fallback_setkey() in xts_aes_set_key() will now enforce key size
rule in FIPS mode when setting up the fallback algorithm keys, which
makes the check in xts_aes_set_key() redundant or unreachable. So just
drop this check.

xts_fallback_setkey() now makes a key size check in xts_verify_key():

xts_fallback_setkey()
  crypto_skcipher_setkey() [ skcipher_setkey_unaligned() ]
    cipher->setkey() { .setkey = xts_setkey }
      xts_setkey()
        xts_verify_key()

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 arch/s390/crypto/aes_s390.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 526c3f40f6a2..c773820e4af9 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -398,10 +398,6 @@ static int xts_aes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
 	if (err)
 		return err;
 
-	/* In fips mode only 128 bit or 256 bit keys are valid */
-	if (fips_enabled && key_len != 32 && key_len != 64)
-		return -EINVAL;
-
 	/* Pick the correct function code based on the key length */
 	fc = (key_len == 32) ? CPACF_KM_XTS_128 :
 	     (key_len == 64) ? CPACF_KM_XTS_256 : 0;
-- 
2.38.1

