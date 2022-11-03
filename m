Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94555617585
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKCE2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKCE21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:28:27 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F211A0E;
        Wed,  2 Nov 2022 21:28:26 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A302CS7011246;
        Thu, 3 Nov 2022 04:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ieDB45JQqpAn8o0cFOMeE/nL1kcgeiYxQWZKC81F9j4=;
 b=orKUc4UngGHaem0TAWr0Eo+3mrvdt1Kua2tiyy0hiuWzupCw9NNhtq81j0nmkvy0hhbm
 QqMQZAaGWZpcJiScABt+xwPAnMhGpL0/mIIRnEABOIFIa7+5Rrbt8xPeLFWQGPbEjvIK
 Qg1yuSewszsg+xjm0N+3oPFudnVx/daSs6sCNls9AJnXZuPBGdmzKdn14ZUIFOsA5u/w
 jIbqjbMJHvwqEPaYx3kIVtbYxPD78qbWrprqvL7nIBSXgtH8AUf72LnSigdVMQ7NMIkZ
 t7mcwjqXlX5d5+7HDR91Zyh9YEjxa6a6JL/jERJZT5M0dMiKX14qWBdjrkSw44v8X4Gr zg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3km2pfhdec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:03 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 31F9FD25A;
        Thu,  3 Nov 2022 04:28:03 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id A6F93808EB4;
        Thu,  3 Nov 2022 04:28:02 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 01/17] crypto: tcrypt - test crc32
Date:   Wed,  2 Nov 2022 23:27:24 -0500
Message-Id: <20221103042740.6556-2-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lt5JL0LdQtIpZFpIelRq2x8RieiHiKgO
X-Proofpoint-ORIG-GUID: lt5JL0LdQtIpZFpIelRq2x8RieiHiKgO
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=939 clxscore=1015 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add self-test and speed tests for crc32, paralleling those
offered for crc32c and crct10dif.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/tcrypt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index a82679b576bb..4426386dfb42 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1711,6 +1711,10 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret += tcrypt_test("gcm(aria)");
 		break;
 
+	case 59:
+		ret += tcrypt_test("crc32");
+		break;
+
 	case 100:
 		ret += tcrypt_test("hmac(md5)");
 		break;
@@ -2317,6 +2321,10 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 				generic_hash_speed_template);
 		if (mode > 300 && mode < 400) break;
 		fallthrough;
+	case 329:
+		test_hash_speed("crc32", sec, generic_hash_speed_template);
+		if (mode > 300 && mode < 400) break;
+		fallthrough;
 	case 399:
 		break;
 
-- 
2.37.3

