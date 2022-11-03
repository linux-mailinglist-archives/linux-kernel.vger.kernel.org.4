Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8423D617597
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKCEap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKCE3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:29:32 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E93A12D35;
        Wed,  2 Nov 2022 21:28:43 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A33leNg022647;
        Thu, 3 Nov 2022 04:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=EFnJoixPZ3/Qjr5SSbSdQKS+GwLwG6oMKcGkzRv3xr4=;
 b=IuMWTAJ7ZKPlEJy37kS+AL/tc/o1fmyZoYKUgmmGJ4eUX4FAmiyfTdvY905KEQjTcH/y
 07dujrahekiliFZOKs9hNtZA4VsCJLCMSXBm+RUgaAGr2IoqSftB9TvHcyHMI+1RHjva
 hf3Jpg5FbNzlXcWqBl1zTFznH9EjFD/AeeO51pj3DkWX9BT/bU5SukphToCalsKxy8IA
 YagpsC7fcfuJWuKmZlQISOZWrbncDkdSAxl1GfBQiV+tTb0hiGmfZTPzZA1yDEHOOxks
 R2ibDCltjg8dcov+TnND9t1Z4OW8jDe9YM1vZSQcl0mXt28Bp7hty6aLjkPG4yOGDkzM 1Q== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3km624r8vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:07 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 65C7B806B41;
        Thu,  3 Nov 2022 04:28:06 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id E50EC808EAF;
        Thu,  3 Nov 2022 04:28:05 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 03/17] crypto: tcrypt - reschedule during cycles speed tests
Date:   Wed,  2 Nov 2022 23:27:26 -0500
Message-Id: <20221103042740.6556-4-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TQQwrXZMaq1zVHMUHtqcG37LyzX2Jxm0
X-Proofpoint-GUID: TQQwrXZMaq1zVHMUHtqcG37LyzX2Jxm0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 2af632996b89 ("crypto: tcrypt - reschedule during speed tests")
added cond_resched() calls to "Avoid RCU stalls in the case of
non-preemptible kernel and lengthy speed tests by rescheduling when
advancing from one block size to another."

It only makes those calls if the sec module parameter is used
(run the speed test for a certain number of seconds), not the
default "cycles" mode.

Expand those to also run in "cycles" mode to reduce the rate
of rcu stall warnings:
  rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks:

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Tested-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/tcrypt.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 7a6a56751043..c025ba26b663 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -408,14 +408,13 @@ static void test_mb_aead_speed(const char *algo, int enc, int secs,
 
 			}
 
-			if (secs) {
+			if (secs)
 				ret = test_mb_aead_jiffies(data, enc, bs,
 							   secs, num_mb);
-				cond_resched();
-			} else {
+			else
 				ret = test_mb_aead_cycles(data, enc, bs,
 							  num_mb);
-			}
+			cond_resched();
 
 			if (ret) {
 				pr_err("%s() failed return code=%d\n", e, ret);
@@ -661,13 +660,11 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 					       bs + (enc ? 0 : authsize),
 					       iv);
 
-			if (secs) {
-				ret = test_aead_jiffies(req, enc, bs,
-							secs);
-				cond_resched();
-			} else {
+			if (secs)
+				ret = test_aead_jiffies(req, enc, bs, secs);
+			else
 				ret = test_aead_cycles(req, enc, bs);
-			}
+			cond_resched();
 
 			if (ret) {
 				pr_err("%s() failed return code=%d\n", e, ret);
@@ -917,14 +914,13 @@ static void test_ahash_speed_common(const char *algo, unsigned int secs,
 
 		ahash_request_set_crypt(req, sg, output, speed[i].plen);
 
-		if (secs) {
+		if (secs)
 			ret = test_ahash_jiffies(req, speed[i].blen,
 						 speed[i].plen, output, secs);
-			cond_resched();
-		} else {
+		else
 			ret = test_ahash_cycles(req, speed[i].blen,
 						speed[i].plen, output);
-		}
+		cond_resched();
 
 		if (ret) {
 			pr_err("hashing failed ret=%d\n", ret);
@@ -1184,15 +1180,14 @@ static void test_mb_skcipher_speed(const char *algo, int enc, int secs,
 							   cur->sg, bs, iv);
 			}
 
-			if (secs) {
+			if (secs)
 				ret = test_mb_acipher_jiffies(data, enc,
 							      bs, secs,
 							      num_mb);
-				cond_resched();
-			} else {
+			else
 				ret = test_mb_acipher_cycles(data, enc,
 							     bs, num_mb);
-			}
+			cond_resched();
 
 			if (ret) {
 				pr_err("%s() failed flags=%x\n", e,
@@ -1401,14 +1396,11 @@ static void test_skcipher_speed(const char *algo, int enc, unsigned int secs,
 
 			skcipher_request_set_crypt(req, sg, sg, bs, iv);
 
-			if (secs) {
-				ret = test_acipher_jiffies(req, enc,
-							   bs, secs);
-				cond_resched();
-			} else {
-				ret = test_acipher_cycles(req, enc,
-							  bs);
-			}
+			if (secs)
+				ret = test_acipher_jiffies(req, enc, bs, secs);
+			else
+				ret = test_acipher_cycles(req, enc, bs);
+			cond_resched();
 
 			if (ret) {
 				pr_err("%s() failed flags=%x\n", e,
-- 
2.37.3

