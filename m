Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554BF621604
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiKHOVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiKHOUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:20:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A3D862D6;
        Tue,  8 Nov 2022 06:20:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14D9C22AA8;
        Tue,  8 Nov 2022 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667917249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9ib9ZQ/+innM0aD2x69ESuXh3a/zTGWSIsXZMke6AU=;
        b=HnS57CldwjnrLHR6RJs1lxMqU/5R71SJ9Pf10dqy6lRxWNuxHDNQsmghv4ua3OmXGGo9UF
        FZ48pQokWhWUzO+hSYa2Vq08OYK8Sqs3wwp+QYs6ADO0Tz7bx51vS3nx1M6U6rARSaaWHU
        YRSltZiUOoYd2Pk3UXk9Y6i/XlSbWh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667917249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9ib9ZQ/+innM0aD2x69ESuXh3a/zTGWSIsXZMke6AU=;
        b=TFhOTSr9M9P5QaV8wXtBTQB3imVXYwPUv290JXdVOm5sat3zThaV2EtLf/AzgwyDACYsze
        zvRu1ujw/ilUhMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04D3413398;
        Tue,  8 Nov 2022 14:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a3S5AMFlamMVKQAAMHmgww
        (envelope-from <nstange@suse.de>); Tue, 08 Nov 2022 14:20:49 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vladis Dronov <vdronov@redhat.com>,
        Stephan Mueller <smueller@chronox.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 2/4] crypto: testmgr - disallow plain cbcmac(aes) in FIPS mode
Date:   Tue,  8 Nov 2022 15:20:23 +0100
Message-Id: <20221108142025.13461-3-nstange@suse.de>
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

cbcmac(aes) may be used only as part of the ccm(aes) construction in FIPS
mode. Since commit d6097b8d5d55 ("crypto: api - allow algs only in specific
constructions in FIPS mode") there's support for using spawns which by
itself are marked as non-approved from approved template instantiations.
So simply mark plain cbcmac(aes) as non-approved in testmgr to block any
attempts of direct instantiations in FIPS mode.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/testmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index e2806ef044fd..1ffbe3abb84a 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4501,7 +4501,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 	}, {
 #endif
 		.alg = "cbcmac(aes)",
-		.fips_allowed = 1,
 		.test = alg_test_hash,
 		.suite = {
 			.hash = __VECS(aes_cbcmac_tv_template)
-- 
2.38.0

