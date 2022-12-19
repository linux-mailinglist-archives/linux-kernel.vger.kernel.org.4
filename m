Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5226513F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLSUai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiLSUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:30:03 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B39582;
        Mon, 19 Dec 2022 12:29:59 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJJOigi017410;
        Mon, 19 Dec 2022 20:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=0ROCRnzk94uQKB9hFXedgn0T1ir63wjm+lzksBC+x48=;
 b=YEH+2sfquvZx5fwJcv47RHK/ljj/7a87XAzyJW/gr65VyWvBBA4TcvfdV4a6Wdq6fibe
 zq0drfo0z6RT835kNfy4qAlZ+IYBRJRFCDgHZsowTth0UBNKeU/TfWMUnvsepSeOR+s5
 AFM3fDuacsMCcSok09+E94hGLJaqZrQ6eXhZl9TaUYxVHKRa8Ya/FOolBYUoGs3Xa6Iw
 hgV2iyud08nD6sXrnf84uVOUnLxpsywNYyjVBvAT/fJoQurCQwIjHO8YYYPAw5gJHVkg
 YggKt4AXboVPkDKoPlp4izRkTob1jpmX2S/w9JGSaqVVS4stggbkVz2cJ2PtWcMKeffh AQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjx3b0d4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 20:29:45 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id BBBD64AC60;
        Mon, 19 Dec 2022 20:29:44 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 49DAE8064BE;
        Mon, 19 Dec 2022 20:29:44 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org
Cc:     linux-crypto@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 3/3] crypto: tcrypt - suppress RCU stall warnings during speed tests
Date:   Mon, 19 Dec 2022 14:29:10 -0600
Message-Id: <20221219202910.3063036-4-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219202910.3063036-1-elliott@hpe.com>
References: <20221219202910.3063036-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b8j5S8cYNvBcF4NRwQ6rkCjGZ592I-ZJ
X-Proofpoint-GUID: b8j5S8cYNvBcF4NRwQ6rkCjGZ592I-ZJ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppress RCU CPU stall warnings while running speed tests.

The tcrypt module is intended only for developer usage, so
RCU stalls induced by those tests are not necessarily representative
of real problems.

Speed tests need to disable interrupts or preemption to get results
that are not distorted by such interruptions. This triggers more
RCU stalls than normal invocations of the crypto functions.

If an RCU stall is triggered and reported, the time to print to the
console distorts the speed results.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/tcrypt.c | 113 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 19 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 8645e72a7099..3e9e4adeef02 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
+#include <linux/rcupdate.h>
 #include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/moduleparam.h>
@@ -191,12 +192,16 @@ static int test_mb_aead_jiffies(struct test_mb_aead_data *data, int enc,
 	if (!rc)
 		return -ENOMEM;
 
+	rcu_suppress_start();
 	for (start = jiffies, end = start + secs * HZ, bcount = 0;
 	     time_before(jiffies, end); bcount++) {
 		ret = do_mult_aead_op(data, enc, num_mb, rc, prefix);
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 	}
+	rcu_suppress_end();
 
 	pr_info("%s %8d operations in %d seconds (%12llu bytes)\n",
 		prefix, bcount * num_mb, secs, (u64)bcount * blen * num_mb);
@@ -218,19 +223,25 @@ static int test_mb_aead_cycles(struct test_mb_aead_data *data, int enc,
 		return -ENOMEM;
 
 	/* Warm-up run. */
+	rcu_suppress_start();
 	for (i = 0; i < 4; i++) {
 		ret = do_mult_aead_op(data, enc, num_mb, rc, prefix);
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 	}
+	rcu_suppress_end();
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
 		cycles_t start, end;
 
+		rcu_suppress_start();
 		start = get_cycles();
 		ret = do_mult_aead_op(data, enc, num_mb, rc, prefix);
 		end = get_cycles();
+		rcu_suppress_end();
 
 		if (ret)
 			goto out;
@@ -470,6 +481,7 @@ static int test_aead_jiffies(struct aead_request *req, int enc,
 	int bcount;
 	int ret;
 
+	rcu_suppress_start();
 	for (start = jiffies, end = start + secs * HZ, bcount = 0;
 	     time_before(jiffies, end); bcount++) {
 		if (enc)
@@ -477,9 +489,12 @@ static int test_aead_jiffies(struct aead_request *req, int enc,
 		else
 			ret = do_one_aead_op(req, crypto_aead_decrypt(req));
 
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			return ret;
+		}
 	}
+	rcu_suppress_end();
 
 	pr_info("%s %8d operations in %d seconds (%12llu bytes)\n",
 	        prefix, bcount, secs, (u64)bcount * blen);
@@ -494,26 +509,32 @@ static int test_aead_cycles(struct aead_request *req, int enc,
 	int i;
 
 	/* Warm-up run. */
+	rcu_suppress_start();
 	for (i = 0; i < 4; i++) {
 		if (enc)
 			ret = do_one_aead_op(req, crypto_aead_encrypt(req));
 		else
 			ret = do_one_aead_op(req, crypto_aead_decrypt(req));
 
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 	}
+	rcu_suppress_end();
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
 		cycles_t start, end;
 
+		rcu_suppress_start();
 		start = get_cycles();
 		if (enc)
 			ret = do_one_aead_op(req, crypto_aead_encrypt(req));
 		else
 			ret = do_one_aead_op(req, crypto_aead_decrypt(req));
 		end = get_cycles();
+		rcu_suppress_end();
 
 		if (ret)
 			goto out;
@@ -746,12 +767,16 @@ static int test_ahash_jiffies_digest(struct ahash_request *req, int blen,
 	int bcount;
 	int ret;
 
+	rcu_suppress_start();
 	for (start = jiffies, end = start + secs * HZ, bcount = 0;
 	     time_before(jiffies, end); bcount++) {
 		ret = do_one_ahash_op(req, crypto_ahash_digest(req));
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			return ret;
+		}
 	}
+	rcu_suppress_end();
 
 	pr_info("%s %6u opers/sec, %9lu bytes/sec\n",
 	       prefix, bcount / secs, ((long)bcount * blen) / secs);
@@ -769,21 +794,29 @@ static int test_ahash_jiffies(struct ahash_request *req, int blen,
 	if (plen == blen)
 		return test_ahash_jiffies_digest(req, blen, secs, prefix);
 
+	rcu_suppress_start();
 	for (start = jiffies, end = start + secs * HZ, bcount = 0;
 	     time_before(jiffies, end); bcount++) {
 		ret = do_one_ahash_op(req, crypto_ahash_init(req));
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			return ret;
+		}
 		for (pcount = 0; pcount < blen; pcount += plen) {
 			ret = do_one_ahash_op(req, crypto_ahash_update(req));
-			if (ret)
+			if (ret) {
+				rcu_suppress_end();
 				return ret;
+			}
 		}
 
 		ret = do_one_ahash_op(req, crypto_ahash_final(req));
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			return ret;
+		}
 	}
+	rcu_suppress_end();
 
 	pr_info("%s %6u opers/sec, %9lu bytes/sec\n",
 		prefix, bcount / secs, ((long)bcount * blen) / secs);
@@ -798,23 +831,31 @@ static int test_ahash_cycles_digest(struct ahash_request *req, int blen,
 	int ret, i;
 
 	/* Warm-up run. */
+	rcu_suppress_start();
 	for (i = 0; i < 4; i++) {
 		ret = do_one_ahash_op(req, crypto_ahash_digest(req));
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 	}
+	rcu_suppress_end();
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
 		cycles_t start, end;
 
+		rcu_suppress_start();
 		start = get_cycles();
 
 		ret = do_one_ahash_op(req, crypto_ahash_digest(req));
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 
 		end = get_cycles();
+		rcu_suppress_end();
 
 		cycles += end - start;
 	}
@@ -839,24 +880,33 @@ static int test_ahash_cycles(struct ahash_request *req, int blen,
 		return test_ahash_cycles_digest(req, blen, prefix);
 
 	/* Warm-up run. */
+	rcu_suppress_start();
 	for (i = 0; i < 4; i++) {
 		ret = do_one_ahash_op(req, crypto_ahash_init(req));
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 		for (pcount = 0; pcount < blen; pcount += plen) {
 			ret = do_one_ahash_op(req, crypto_ahash_update(req));
-			if (ret)
+			if (ret) {
+				rcu_suppress_end();
 				goto out;
+			}
 		}
 		ret = do_one_ahash_op(req, crypto_ahash_final(req));
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 	}
+	rcu_suppress_end();
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
 		cycles_t start, end;
 
+		rcu_suppress_start();
 		start = get_cycles();
 
 		ret = do_one_ahash_op(req, crypto_ahash_init(req));
@@ -864,14 +914,19 @@ static int test_ahash_cycles(struct ahash_request *req, int blen,
 			goto out;
 		for (pcount = 0; pcount < blen; pcount += plen) {
 			ret = do_one_ahash_op(req, crypto_ahash_update(req));
-			if (ret)
+			if (ret) {
+				rcu_suppress_end();
 				goto out;
+			}
 		}
 		ret = do_one_ahash_op(req, crypto_ahash_final(req));
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 
 		end = get_cycles();
+		rcu_suppress_end();
 
 		cycles += end - start;
 	}
@@ -1039,12 +1094,16 @@ static int test_mb_acipher_jiffies(struct test_mb_skcipher_data *data, int enc,
 	if (!rc)
 		return -ENOMEM;
 
+	rcu_suppress_start();
 	for (start = jiffies, end = start + secs * HZ, bcount = 0;
 	     time_before(jiffies, end); bcount++) {
 		ret = do_mult_acipher_op(data, enc, num_mb, rc, prefix);
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 	}
+	rcu_suppress_end();
 
 	pr_info("%s %8d operations in %d seconds (%12llu bytes)\n",
 		prefix, bcount * num_mb, secs, (u64)bcount * blen * num_mb);
@@ -1066,19 +1125,25 @@ static int test_mb_acipher_cycles(struct test_mb_skcipher_data *data, int enc,
 		return -ENOMEM;
 
 	/* Warm-up run. */
+	rcu_suppress_start();
 	for (i = 0; i < 4; i++) {
 		ret = do_mult_acipher_op(data, enc, num_mb, rc, prefix);
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 	}
+	rcu_suppress_end();
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
 		cycles_t start, end;
 
+		rcu_suppress_start();
 		start = get_cycles();
 		ret = do_mult_acipher_op(data, enc, num_mb, rc, prefix);
 		end = get_cycles();
+		rcu_suppress_end();
 
 		if (ret)
 			goto out;
@@ -1270,6 +1335,7 @@ static int test_acipher_jiffies(struct skcipher_request *req, int enc,
 	int bcount;
 	int ret;
 
+	rcu_suppress_start();
 	for (start = jiffies, end = start + secs * HZ, bcount = 0;
 	     time_before(jiffies, end); bcount++) {
 		if (enc)
@@ -1279,9 +1345,12 @@ static int test_acipher_jiffies(struct skcipher_request *req, int enc,
 			ret = do_one_acipher_op(req,
 						crypto_skcipher_decrypt(req));
 
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			return ret;
+		}
 	}
+	rcu_suppress_end();
 
 	pr_info("%s %8d operations in %d seconds (%12llu bytes)\n",
 		prefix, bcount, secs, (u64)bcount * blen);
@@ -1296,6 +1365,7 @@ static int test_acipher_cycles(struct skcipher_request *req, int enc,
 	int i;
 
 	/* Warm-up run. */
+	rcu_suppress_start();
 	for (i = 0; i < 4; i++) {
 		if (enc)
 			ret = do_one_acipher_op(req,
@@ -1304,14 +1374,18 @@ static int test_acipher_cycles(struct skcipher_request *req, int enc,
 			ret = do_one_acipher_op(req,
 						crypto_skcipher_decrypt(req));
 
-		if (ret)
+		if (ret) {
+			rcu_suppress_end();
 			goto out;
+		}
 	}
+	rcu_suppress_end();
 
 	/* The real thing. */
 	for (i = 0; i < 8; i++) {
 		cycles_t start, end;
 
+		rcu_suppress_start();
 		start = get_cycles();
 		if (enc)
 			ret = do_one_acipher_op(req,
@@ -1320,6 +1394,7 @@ static int test_acipher_cycles(struct skcipher_request *req, int enc,
 			ret = do_one_acipher_op(req,
 						crypto_skcipher_decrypt(req));
 		end = get_cycles();
+		rcu_suppress_end();
 
 		if (ret)
 			goto out;
-- 
2.38.1

