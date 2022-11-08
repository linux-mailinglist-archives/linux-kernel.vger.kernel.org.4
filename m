Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A36F621603
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiKHOU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiKHOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:20:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C36862D2;
        Tue,  8 Nov 2022 06:20:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D9EC22A9E;
        Tue,  8 Nov 2022 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667917247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uG7bkbR8f1ErSbpnIswqV7scwgYtGlwKnO07NfMV1Ro=;
        b=S2tQIpOsR9mMrPkL1xyeJAXruYNrjsUZ6HF8BLdHGTnO80bnA4iQkodZli0rCTWp17IWc8
        G6kffZIEF11rAdTdbELZu1ST4TdSTXfL63M0DMnRrH2pmqypMjsfkU+No7jDGUW6teZcNJ
        PWzOVo6S0JUb+DhSXB3gdpuJQuSP/vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667917247;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uG7bkbR8f1ErSbpnIswqV7scwgYtGlwKnO07NfMV1Ro=;
        b=KlJyrsTfyiJ5AaM/jlA9pToJSlXsFBVquwdB4l/WR9qI2U1mbUcggpwAbxZgZCNIAzPvsU
        DmdguqNlPjek2aAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F98E13398;
        Tue,  8 Nov 2022 14:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kBtiB79lamMTKQAAMHmgww
        (envelope-from <nstange@suse.de>); Tue, 08 Nov 2022 14:20:47 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vladis Dronov <vdronov@redhat.com>,
        Stephan Mueller <smueller@chronox.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 1/4] crypto: xts - restrict key lengths to approved values in FIPS mode
Date:   Tue,  8 Nov 2022 15:20:22 +0100
Message-Id: <20221108142025.13461-2-nstange@suse.de>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221108142025.13461-1-nstange@suse.de>
References: <20221108142025.13461-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to FIPS 140-3 IG C.I., only (total) key lengths of either
256 bits or 512 bits are allowed with xts(aes). Make xts_verify_key() to
reject anything else in FIPS mode.

As xts(aes) is the only approved xts() template instantiation in FIPS mode,
the new restriction implemented in xts_verify_key() effectively only
applies to this particular construction.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 include/crypto/xts.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/crypto/xts.h b/include/crypto/xts.h
index 0f8dba69feb4..a233c1054df2 100644
--- a/include/crypto/xts.h
+++ b/include/crypto/xts.h
@@ -35,6 +35,13 @@ static inline int xts_verify_key(struct crypto_skcipher *tfm,
 	if (keylen % 2)
 		return -EINVAL;
 
+	/*
+	 * In FIPS mode only a combined key length of either 256 or
+	 * 512 bits is allowed, c.f. FIPS 140-3 IG C.I.
+	 */
+	if (fips_enabled && keylen != 32 && keylen != 64)
+		return -EINVAL;
+
 	/* ensure that the AES and tweak key are not identical */
 	if ((fips_enabled || (crypto_skcipher_get_flags(tfm) &
 			      CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) &&
-- 
2.38.0

