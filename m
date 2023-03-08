Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C196B0FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCHRFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCHREx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1228E61A93
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678295014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+bV6MJeZtqLU80fZFFPU6YZTkzQK1mAwlHMg0ipvOFY=;
        b=An2dSBCYT9iEsUPJAw8EnvU9n9mmgupFB6q2m/w9Ss91P6POLkP2rYZCFEg/fIOynSQfJz
        VDi95Uqhn7T2B9/AeRJaF6GHGL5AdPv6qWIxI30//D8TdJLd6Ak2vfin2VcgCj5k7FGWf9
        TE9mBWyfzjZXjXcCCt692xAqVu2RTjc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-7xreSsEqMGCNlXMwQinL-g-1; Wed, 08 Mar 2023 12:03:31 -0500
X-MC-Unique: 7xreSsEqMGCNlXMwQinL-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6294E85CCE7;
        Wed,  8 Mar 2023 17:03:30 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.45.242.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D86818EC7;
        Wed,  8 Mar 2023 17:03:28 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephan Mueller <smueller@chronox.de>
Cc:     Nicolai Stange <nstange@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH] crypto: jitter - panic on runtime health test failures in FIPS mode
Date:   Wed,  8 Mar 2023 18:02:33 +0100
Message-Id: <20230308170233.19475-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A FIPS certification lab has noted that the kernel doesn't go to error
state upon failure of the RCT and APT health tests. Add a panic() call
in FIPS mode to jent_kcapi_random().

Revert b454fb702515 ("crypto: jitter - don't limit ->health_failure
check to FIPS mode") for this partially.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 crypto/jitterentropy-kcapi.c | 8 ++++++++
 crypto/jitterentropy.h       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index 2d115bec15ae..9c692119d926 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -37,6 +37,7 @@
  * DAMAGE.
  */
 
+#include <linux/fips.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -59,6 +60,11 @@ void jent_zfree(void *ptr)
 	kfree_sensitive(ptr);
 }
 
+int jent_fips_enabled(void)
+{
+	return fips_enabled;
+}
+
 void jent_panic(char *s)
 {
 	panic("%s", s);
@@ -140,6 +146,8 @@ static int jent_kcapi_random(struct crypto_rng *tfm,
 
 	/* Return a permanent error in case we had too many resets in a row. */
 	if (rng->reset_cnt > (1<<10)) {
+		if (jent_fips_enabled())
+			jent_panic("jitterentropy: Too many RCT/APT health test failures\n");
 		ret = -EFAULT;
 		goto out;
 	}
diff --git a/crypto/jitterentropy.h b/crypto/jitterentropy.h
index b7397b617ef0..c83fff32d130 100644
--- a/crypto/jitterentropy.h
+++ b/crypto/jitterentropy.h
@@ -2,6 +2,7 @@
 
 extern void *jent_zalloc(unsigned int len);
 extern void jent_zfree(void *ptr);
+extern int jent_fips_enabled(void);
 extern void jent_panic(char *s);
 extern void jent_memcpy(void *dest, const void *src, unsigned int n);
 extern void jent_get_nstime(__u64 *out);
-- 
2.39.2

