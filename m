Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8662160A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiKHOVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiKHOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:21:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4BEC8A30;
        Tue,  8 Nov 2022 06:21:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DCF81FB84;
        Tue,  8 Nov 2022 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667917262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3T0eeo4rDxCTZEodATTbmKUVD7KoHxSR9GUsWoJPUyA=;
        b=tlNczIRO1IJ5wuS9cdVO5s3WPJFQ1XDcV9CAmgBCOXm0j7Y4dNGiaB1kqqudITvlvK7/6K
        ljvnrI5beWnDFxu6xg0IUAlLoEnRLuFPRy668Ju1tSwctagOgT4r8RYAgB9sjflJvM4xfs
        llStYI6EatCkLg/en3BWq9PAHd6cYxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667917262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3T0eeo4rDxCTZEodATTbmKUVD7KoHxSR9GUsWoJPUyA=;
        b=rNJym0SULVMg4fQl4TbvAqFcaF02Iv7fFma9H6oFWAxqttwZOuw+WZb5TKs8uK3857TPO/
        3SkUNT42aRuKcnAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3944813398;
        Tue,  8 Nov 2022 14:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F5j2Dc5lamNJKQAAMHmgww
        (envelope-from <nstange@suse.de>); Tue, 08 Nov 2022 14:21:02 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vladis Dronov <vdronov@redhat.com>,
        Stephan Mueller <smueller@chronox.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 4/4] crypto: testmgr - allow ecdsa-nist-p256 and -p384 in FIPS mode
Date:   Tue,  8 Nov 2022 15:20:25 +0100
Message-Id: <20221108142025.13461-5-nstange@suse.de>
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

The kernel provides implementations of the NIST ECDSA signature
verification primitives. For key sizes of 256 and 384 bits respectively
they are approved and can be enabled in FIPS mode. Do so.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/testmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 6d91a2acd119..f641f9c830d8 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5034,12 +5034,14 @@ static const struct alg_test_desc alg_test_descs[] = {
 	}, {
 		.alg = "ecdsa-nist-p256",
 		.test = alg_test_akcipher,
+		.fips_allowed = 1,
 		.suite = {
 			.akcipher = __VECS(ecdsa_nist_p256_tv_template)
 		}
 	}, {
 		.alg = "ecdsa-nist-p384",
 		.test = alg_test_akcipher,
+		.fips_allowed = 1,
 		.suite = {
 			.akcipher = __VECS(ecdsa_nist_p384_tv_template)
 		}
-- 
2.38.0

