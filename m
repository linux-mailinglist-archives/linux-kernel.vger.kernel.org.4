Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025772E7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbjFMQIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbjFMQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:08:06 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8461981;
        Tue, 13 Jun 2023 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686672486; x=1718208486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UMXii+5rBuoMAs0WL8DNFNbC1KKA1KhEPyGQS0o9/ak=;
  b=GNyjnvNEzdVq5wdedMC/ElxZC96HJIhVsVgxlJqwPL2cHdvRPpjs/oRf
   5ewKxrtOb+xm+ADdyKMD0rbNWE7UDe77wWc33LKG7S+5Pe2xC+xJvEVqb
   0xzz7e7J6gogpDZFChQ8NNVoLDGvFmT3iHLCGzXzgfTLA/m2xqzgxs64v
   Q=;
X-IronPort-AV: E=Sophos;i="6.00,240,1681171200"; 
   d="scan'208";a="136747801"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 16:08:03 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id A8F1A414A5;
        Tue, 13 Jun 2023 16:08:01 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.218) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 16:07:53 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 16:07:53 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
        id F01C6960E; Tue, 13 Jun 2023 16:07:52 +0000 (UTC)
From:   Mahmoud Adam <mngyadam@amazon.com>
To:     <dhowells@redhat.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mahmoud Adam <mngyadam@amazon.com>
Subject: [PATCH] KEYS: use kfree_sensitive with key
Date:   Tue, 13 Jun 2023 16:07:23 +0000
Message-ID: <20230613160723.61729-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key member might contain private part of the key, so better use
kfree_sensitive to free it

Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 crypto/asymmetric_keys/public_key.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index eca5671ad3f2..006ae170a16f 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -43,7 +43,7 @@ static void public_key_describe(const struct key *asymmetric_key,
 void public_key_free(struct public_key *key)
 {
 	if (key) {
-		kfree(key->key);
+		kfree_sensitive(key->key);
 		kfree(key->params);
 		kfree(key);
 	}
@@ -218,7 +218,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	ret = 0;
 
 error_free_key:
-	kfree(key);
+	kfree_sensitive(key);
 error_free_tfm:
 	crypto_free_akcipher(tfm);
 	pr_devel("<==%s() = %d\n", __func__, ret);
@@ -303,7 +303,7 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 		ret = req->dst_len;
 
 error_free_key:
-	kfree(key);
+	kfree_sensitive(key);
 error_free_req:
 	akcipher_request_free(req);
 error_free_tfm:
@@ -456,7 +456,7 @@ int public_key_verify_signature(const struct public_key *pkey,
 	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
 
 error_free_key:
-	kfree(key);
+	kfree_sensitive(key);
 error_free_req:
 	akcipher_request_free(req);
 error_free_tfm:
-- 
2.40.1

