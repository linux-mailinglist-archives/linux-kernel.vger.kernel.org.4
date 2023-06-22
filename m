Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2773A134
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFVMtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:49:40 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C562193;
        Thu, 22 Jun 2023 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687438180; x=1718974180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NlzD/CvLWWdttX4UrB2Vhmi3xDeUykPh+lPbouFV1UY=;
  b=LHS2OFrFefCXSV/Vv1idO/jtFrbP5/OwlrmMohZS5l1rzZlJ+x+W0Ix9
   2UIdm1wVzcSvfaiscVV2y/mbf/q2x23Vdm+okZv2S7nEwFdPoRGVg8rha
   3YWat2HbJSYPZ2Cwy+5e5g846UBnuZbZvoRXxXYeuj+znTa8A1a0tBqQy
   w=;
X-IronPort-AV: E=Sophos;i="6.00,263,1681171200"; 
   d="scan'208";a="656430713"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 12:49:33 +0000
Received: from EX19MTAUEA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id 2039F45F4A;
        Thu, 22 Jun 2023 12:49:30 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Jun 2023 12:49:29 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Jun 2023 12:49:29 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
        id 0C35E2016; Thu, 22 Jun 2023 12:49:29 +0000 (UTC)
From:   Mahmoud Adam <mngyadam@amazon.com>
To:     <dhowells@redhat.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mahmoud Adam <mngyadam@amazon.com>
Subject: [PATCH v3] KEYS: use kfree_sensitive with key
Date:   Thu, 22 Jun 2023 12:47:22 +0000
Message-ID: <20230622124719.93393-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key might contain private part of the key, so better use
kfree_sensitive to free it
---
v1: conflicts with c3d03e8e35e0:
KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()
kfree_sensitive the buf variable also because it might has private
part

 crypto/asymmetric_keys/public_key.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 50c933f86b21..170f06982381 100644
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
@@ -460,7 +460,7 @@ int public_key_verify_signature(const struct public_key *pkey,
 	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);

 error_free_buf:
-	kfree(buf);
+	kfree_sensitive(buf);
 error_free_req:
 	akcipher_request_free(req);
 error_free_tfm:
--
2.40.1
