Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A376591AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiL2Ujy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiL2Uis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:38:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECE31704C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672346276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HocLF/KBTVlQUJt7QQMW7FIy1E4x5xixVjqadrM9WOY=;
        b=BH+d48BJZzUpDVJ+BGYOU8v3L6myTadiKSqYEfozLOrbLHXNacun/4w1kJWgXJUtWnYQFZ
        x+xofrg5D5sELp3Mz9xFZxbTyZWOhE/zmTPjM6QB0mRBb+oYTkJDPEQqPwCQwM6uH4kKcO
        CMFvgjO3pvRxmgGrkFvJGYjrh8odxz8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-3X_ffHm3OjeLDsUUQMHdMQ-1; Thu, 29 Dec 2022 15:37:51 -0500
X-MC-Unique: 3X_ffHm3OjeLDsUUQMHdMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96D6229ABA00;
        Thu, 29 Dec 2022 20:37:50 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-208-2.brq.redhat.com [10.40.208.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61AE1112132C;
        Thu, 29 Dec 2022 20:37:48 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolai Stange <nstange@suse.de>, Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH v2 4/6] crypto: testmgr - disallow plain cbcmac(aes) in FIPS mode
Date:   Thu, 29 Dec 2022 21:37:06 +0100
Message-Id: <20221229203708.13628-5-vdronov@redhat.com>
In-Reply-To: <20221229203708.13628-1-vdronov@redhat.com>
References: <20221229203708.13628-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolai Stange <nstange@suse.de>

cbcmac(aes) may be used only as part of the ccm(aes) construction in FIPS
mode. Since commit d6097b8d5d55 ("crypto: api - allow algs only in specific
constructions in FIPS mode") there's support for using spawns which by
itself are marked as non-approved from approved template instantiations.
So simply mark plain cbcmac(aes) as non-approved in testmgr to block any
attempts of direct instantiations in FIPS mode.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 crypto/testmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 4476ac97baa5..562463a77a76 100644
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
2.38.1

