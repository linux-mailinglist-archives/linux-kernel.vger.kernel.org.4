Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050A9621606
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiKHOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiKHOVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:21:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2B8C8A01;
        Tue,  8 Nov 2022 06:21:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C51D1FB81;
        Tue,  8 Nov 2022 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667917260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPSHPQSCdTnJCBZ6fMK+DYGTstwG8CZs+9HEtDCY0L8=;
        b=YypPimf/81K/l5dZxvWEYO2mkOFBa0WRCfYZ/QU6VE6lpGMfFOHZy+n/CapWTElDjdU+5l
        lNJZf4e+lvvJUUbTiw/mqgvT7M5COty8gTohZyVhGVdPKWia/o6kGYhIBLoxFSgOIg7Ndb
        WGH2TxUDkVLuSsS3z1vO64GOmJrU0M8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667917260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPSHPQSCdTnJCBZ6fMK+DYGTstwG8CZs+9HEtDCY0L8=;
        b=5aQPMVpzPztkei8q7HJrOpM67zWqRw1fhsour4s/Muw9aep3N9WA+sWMA8N6eB9fxPkp71
        yy1WRDdTv8U2e9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04E4F13398;
        Tue,  8 Nov 2022 14:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lH4xAcxlamM/KQAAMHmgww
        (envelope-from <nstange@suse.de>); Tue, 08 Nov 2022 14:21:00 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vladis Dronov <vdronov@redhat.com>,
        Stephan Mueller <smueller@chronox.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 3/4] crypto: testmgr - disallow plain ghash in FIPS mode
Date:   Tue,  8 Nov 2022 15:20:24 +0100
Message-Id: <20221108142025.13461-4-nstange@suse.de>
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

ghash may be used only as part of the gcm(aes) construction in FIPS
mode. Since commit d6097b8d5d55 ("crypto: api - allow algs only in specific
constructions in FIPS mode") there's support for using spawns which by
itself are marked as non-approved from approved template instantiations.
So simply mark plain ghash as non-approved in testmgr to block any attempts
of direct instantiations in FIPS mode.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/testmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 1ffbe3abb84a..6d91a2acd119 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5125,7 +5125,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 	}, {
 		.alg = "ghash",
 		.test = alg_test_hash,
-		.fips_allowed = 1,
 		.suite = {
 			.hash = __VECS(ghash_tv_template)
 		}
-- 
2.38.0

