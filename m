Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6560A731960
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245722AbjFOM7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbjFOM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:59:03 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113372700;
        Thu, 15 Jun 2023 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686833937; x=1718369937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SngTreX9qafzwT80LSxBPU6C4pEnYSvfLSIgpOhMlis=;
  b=OCc9YrxxCpNTmJiUvNaMseRwCHTP064lamkUIzYsZkIXZkqupnJqpWl9
   Pwo/UqTunNk/1ldHKixTjwWThirpfP95In3BMnfEF5dQDsIw2xsMwij5J
   k5J7yjML/ZQVTqs7uExRQePGaR4mm2z4vpd6FYE7LYR/gZ3NvRubtgZAd
   s=;
X-IronPort-AV: E=Sophos;i="6.00,244,1681171200"; 
   d="scan'208";a="654379430"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 12:58:37 +0000
Received: from EX19MTAUEB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 7D491A28B0;
        Thu, 15 Jun 2023 12:58:34 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Jun 2023 12:58:33 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Jun 2023 12:58:33 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
        id 436D831E0; Thu, 15 Jun 2023 12:58:33 +0000 (UTC)
From:   Mahmoud Adam <mngyadam@amazon.com>
To:     <dhowells@redhat.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mahmoud Adam <mngyadam@amazon.com>
Subject: [PATCH v2] KEYS: use kfree_sensitive with key
Date:   Thu, 15 Jun 2023 12:57:13 +0000
Message-ID: <20230615125712.105873-1-mngyadam@amazon.com>
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

key might contain private part of the key, so better use
kfree_sensitive to free it

Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
v2: kfree_sensitive only private key

 crypto/asymmetric_keys/public_key.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index eca5671ad3f2..cd8c4123d936 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -43,7 +43,10 @@ static void public_key_describe(const struct key *asymmetric_key,
 void public_key_free(struct public_key *key)
 {
 	if (key) {
-		kfree(key->key);
+		if(key->key_is_private)
+			kfree_sensitive(key->key);
+		else
+			kfree(key->key);
 		kfree(key->params);
 		kfree(key);
 	}
@@ -218,7 +221,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	ret = 0;

 error_free_key:
-	kfree(key);
+	kfree_sensitive(key);
 error_free_tfm:
 	crypto_free_akcipher(tfm);
 	pr_devel("<==%s() = %d\n", __func__, ret);
@@ -303,7 +306,7 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 		ret = req->dst_len;

 error_free_key:
-	kfree(key);
+	kfree_sensitive(key);
 error_free_req:
 	akcipher_request_free(req);
 error_free_tfm:
@@ -456,7 +459,7 @@ int public_key_verify_signature(const struct public_key *pkey,
 	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);

 error_free_key:
-	kfree(key);
+	kfree_sensitive(key);
 error_free_req:
 	akcipher_request_free(req);
 error_free_tfm:
--
2.40.1
