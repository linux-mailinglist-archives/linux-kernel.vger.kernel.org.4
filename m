Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385796591AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiL2Uju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiL2Uir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1E01740A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672346279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/O7ovWlD6rDqALxE5fmNq+xJQTo2e2KoATZ05+fVUM=;
        b=i0mYWB8ZyU6WReOfsbQ2ZG9XEQeZEira0S6qdCVt7/Gvr46jKC5wDj5G2YSyrCv2qPfN+W
        9tVAGVyp9AZs6P73DIWqzHC/m8c83mTn78Hy5fD/o8EMl/zgtrtMCZ9qxHGx3Rjfdqj+9H
        4jCkB0iLxtkfg8Cp7LBYYq4OHxGNBzo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-MPEltkLTPYOClQJQrA3BGA-1; Thu, 29 Dec 2022 15:37:56 -0500
X-MC-Unique: MPEltkLTPYOClQJQrA3BGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C499929ABA00;
        Thu, 29 Dec 2022 20:37:55 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-208-2.brq.redhat.com [10.40.208.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97DAF112132C;
        Thu, 29 Dec 2022 20:37:53 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolai Stange <nstange@suse.de>, Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH v2 6/6] crypto: testmgr - allow ecdsa-nist-p256 and -p384 in FIPS mode
Date:   Thu, 29 Dec 2022 21:37:08 +0100
Message-Id: <20221229203708.13628-7-vdronov@redhat.com>
In-Reply-To: <20221229203708.13628-1-vdronov@redhat.com>
References: <20221229203708.13628-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
Reviewed-by: Eric Biggers <ebiggers@google.com>
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

