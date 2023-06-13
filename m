Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1C72E83E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243092AbjFMQRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbjFMQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:17:44 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F12F92;
        Tue, 13 Jun 2023 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686673063; x=1718209063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=10E+Y86g/Yai3sd+LYmwEpoMquRQt118JOpAy+F2U5A=;
  b=h3r4z3pC/B0lDjYQh2f/CAFrp5XtdIEX1AnyYXfM5PuHSSW+UhpWkChU
   dts/vWPo6ceqiNWvYvm+9n4VRqivxemxA1Fz2HhFgLBChi1SGI2ZvCqPh
   yTOPOUyMQ/1kLNhne0TAlJXn2BYjpIEUW6QZKAPhkXZ3l3Pa9VB520WBC
   U=;
X-IronPort-AV: E=Sophos;i="6.00,240,1681171200"; 
   d="scan'208";a="590367005"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 16:17:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 52839413EA;
        Tue, 13 Jun 2023 16:17:39 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 16:17:39 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 16:17:38 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 16:17:38 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
        id 4E9BE960E; Tue, 13 Jun 2023 16:17:38 +0000 (UTC)
From:   Mahmoud Adam <mngyadam@amazon.com>
To:     <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mahmoud Adam <mngyadam@amazon.com>
Subject: [PATCH] crypto: rsa - allow only odd e and restrict value in FIPS mode
Date:   Tue, 13 Jun 2023 16:17:31 +0000
Message-ID: <20230613161731.74081-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check if rsa public exponent is odd and check its value is between
2^16 < e < 2^256.

FIPS 186-5 DSS (page 35)[1] specify that:
1. The public exponent e shall be selected with the following constraints:
  (a) The public verification exponent e shall be selected prior to
  generating the primes, p and q, and the private signature exponent
  d.
  (b) The exponent e shall be an odd positive integer such that:
   2^16 < e < 2^256.

[1] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.186-5.pdf

Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 crypto/rsa.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/crypto/rsa.c b/crypto/rsa.c
index c50f2d2a4d06..c79613cdce6e 100644
--- a/crypto/rsa.c
+++ b/crypto/rsa.c
@@ -205,6 +205,32 @@ static int rsa_check_key_length(unsigned int len)
 	return -EINVAL;
 }
 
+static int rsa_check_exponent_fips(MPI e)
+{
+	MPI e_max = NULL;
+
+	/* check if odd */
+	if (!mpi_test_bit(e, 0)) {
+		return -EINVAL;
+	}
+
+	/* check if 2^16 < e < 2^256. */
+	if (mpi_cmp_ui(e, 65536) <= 0) {
+		return -EINVAL;
+	}
+
+	e_max = mpi_alloc(0);
+	mpi_set_bit(e_max, 256);
+
+	if (mpi_cmp(e, e_max) >= 0) {
+		mpi_free(e_max);
+		return -EINVAL;
+	}
+
+	mpi_free(e_max);
+	return 0;
+}
+
 static int rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
 			   unsigned int keylen)
 {
@@ -232,6 +258,11 @@ static int rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
 		return -EINVAL;
 	}
 
+	if (fips_enabled && rsa_check_exponent_fips(mpi_key->e)) {
+		rsa_free_mpi_key(mpi_key);
+		return -EINVAL;
+	}
+
 	return 0;
 
 err:
@@ -290,6 +321,11 @@ static int rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 		return -EINVAL;
 	}
 
+	if (fips_enabled && rsa_check_exponent_fips(mpi_key->e)) {
+		rsa_free_mpi_key(mpi_key);
+		return -EINVAL;
+	}
+
 	return 0;
 
 err:
-- 
2.40.1

