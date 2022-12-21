Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E96538EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiLUWnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiLUWnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78523E9C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671662541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mv0JdiEUm8fY4r7rY54vtlemTUttCXqsgsmptQYzLmc=;
        b=cYljFLhcJFt3MYTEGZ+b0yGSZk0JDANahCTwnX/dsijkpT/D4ByryZaaNsY0YtbibWAs8M
        c9Q5Wv4MNBgMzyAYGCzJXtOIfvf88SyaQhRXEbdOmD5ba5pTeqXHiLCK2DWGokPG7ULtuj
        9Wv1KRAthi/ssWOzNI4wTw2in5kf+/U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-fKIoZ0QBPd-fRFtYSUZekg-1; Wed, 21 Dec 2022 17:42:17 -0500
X-MC-Unique: fKIoZ0QBPd-fRFtYSUZekg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4522A858F0E;
        Wed, 21 Dec 2022 22:42:17 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-208-11.brq.redhat.com [10.40.208.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 409A040C2004;
        Wed, 21 Dec 2022 22:42:14 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     nstange@suse.de, elliott@hpe.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, smueller@chronox.de,
        vdronov@redhat.com
Subject: [PATCH 6/6] crypto: testmgr - allow ecdsa-nist-p256 and -p384 in FIPS mode
Date:   Wed, 21 Dec 2022 23:41:11 +0100
Message-Id: <20221221224111.19254-7-vdronov@redhat.com>
In-Reply-To: <20221221224111.19254-1-vdronov@redhat.com>
References: <20221221224111.19254-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolai Stange <nstange@suse.de>

The kernel provides implementations of the NIST ECDSA signature
verification primitives. For key sizes of 256 and 384 bits respectively
they are approved and can be enabled in FIPS mode. Do so.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 crypto/testmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index a223cf5f3626..795c4858c741 100644
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
2.38.1

