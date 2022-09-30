Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E895F1515
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiI3Vlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiI3Vlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:41:31 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293161A6EB5;
        Fri, 30 Sep 2022 14:41:27 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UKU6n8000753;
        Fri, 30 Sep 2022 21:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=LvxRN7i3GlP5rBZtiXWtnTHuUir79o8h/VO513pKWeA=;
 b=hbx9Zio5Gi0X8zU0WKAJA446DnZa8G1UxeGqyiUesALWn/JV0JPEg+41tgqDFGK4WFNT
 8xmOGRdOBqODmQUAbNTDNLOIHTDADncqu+YSqKGtU2IyOvK/yzRt3dM9MCSgNuprw68n
 5K9IgGmig2AUYh9OepuO/mIYE4vyg2IuazqDD3qaPjsIRufsGHHGS2tMU7kSsZfP351G
 5UkRkJBztnwfPwOE8Y/YZvoPIqfvUixtS0lBQxt1kDgTFXk/PaCPAX0q/ANhsuSdezoJ
 y60gOY8poUXsAq/ddQ5l5W5d98ayEiFPayBMVI41eUV+WRN8pzx0If7kKpmEL8stRGpC 0w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jx2q9abkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:41:20 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id ECF6DD25B;
        Fri, 30 Sep 2022 21:41:18 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5D28A806766;
        Fri, 30 Sep 2022 21:41:18 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, jarod@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH] crypto: tcrypt - fix return value for multiple subtests
Date:   Fri, 30 Sep 2022 16:40:14 -0500
Message-Id: <20220930214014.37194-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g9uvCet19u3peJxypk8f92YiHaw3tVbv
X-Proofpoint-ORIG-GUID: g9uvCet19u3peJxypk8f92YiHaw3tVbv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxlogscore=953 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300135
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a test mode invokes multiple tests (e.g., mode 0 invokes modes
1 through 199, and mode 3 tests three block cipher modes with des),
don't keep accumulating the return values with ret += tcrypt_test(),
which results in a bogus value if more than one report a nonzero
value (e.g., two reporting -2 (-ENOENT) end up reporting -4 (-EINTR)).
Instead, keep track of the minimum return value reported by any
subtest.

Fixes: 4e033a6bc70f ("crypto: tcrypt - Do not exit on success in fips mode")
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/tcrypt.c | 256 ++++++++++++++++++++++++------------------------
 1 file changed, 128 insertions(+), 128 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index e85f623c3c54..c0fb4427c647 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1471,387 +1471,387 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		}
 
 		for (i = 1; i < 200; i++)
-			ret += do_test(NULL, 0, 0, i, num_mb);
+			ret = min(ret, do_test(NULL, 0, 0, i, num_mb));
 		break;
 
 	case 1:
-		ret += tcrypt_test("md5");
+		ret = min(ret, tcrypt_test("md5"));
 		break;
 
 	case 2:
-		ret += tcrypt_test("sha1");
+		ret = min(ret, tcrypt_test("sha1"));
 		break;
 
 	case 3:
-		ret += tcrypt_test("ecb(des)");
-		ret += tcrypt_test("cbc(des)");
-		ret += tcrypt_test("ctr(des)");
+		ret = min(ret, tcrypt_test("ecb(des)"));
+		ret = min(ret, tcrypt_test("cbc(des)"));
+		ret = min(ret, tcrypt_test("ctr(des)"));
 		break;
 
 	case 4:
-		ret += tcrypt_test("ecb(des3_ede)");
-		ret += tcrypt_test("cbc(des3_ede)");
-		ret += tcrypt_test("ctr(des3_ede)");
+		ret = min(ret, tcrypt_test("ecb(des3_ede)"));
+		ret = min(ret, tcrypt_test("cbc(des3_ede)"));
+		ret = min(ret, tcrypt_test("ctr(des3_ede)"));
 		break;
 
 	case 5:
-		ret += tcrypt_test("md4");
+		ret = min(ret, tcrypt_test("md4"));
 		break;
 
 	case 6:
-		ret += tcrypt_test("sha256");
+		ret = min(ret, tcrypt_test("sha256"));
 		break;
 
 	case 7:
-		ret += tcrypt_test("ecb(blowfish)");
-		ret += tcrypt_test("cbc(blowfish)");
-		ret += tcrypt_test("ctr(blowfish)");
+		ret = min(ret, tcrypt_test("ecb(blowfish)"));
+		ret = min(ret, tcrypt_test("cbc(blowfish)"));
+		ret = min(ret, tcrypt_test("ctr(blowfish)"));
 		break;
 
 	case 8:
-		ret += tcrypt_test("ecb(twofish)");
-		ret += tcrypt_test("cbc(twofish)");
-		ret += tcrypt_test("ctr(twofish)");
-		ret += tcrypt_test("lrw(twofish)");
-		ret += tcrypt_test("xts(twofish)");
+		ret = min(ret, tcrypt_test("ecb(twofish)"));
+		ret = min(ret, tcrypt_test("cbc(twofish)"));
+		ret = min(ret, tcrypt_test("ctr(twofish)"));
+		ret = min(ret, tcrypt_test("lrw(twofish)"));
+		ret = min(ret, tcrypt_test("xts(twofish)"));
 		break;
 
 	case 9:
-		ret += tcrypt_test("ecb(serpent)");
-		ret += tcrypt_test("cbc(serpent)");
-		ret += tcrypt_test("ctr(serpent)");
-		ret += tcrypt_test("lrw(serpent)");
-		ret += tcrypt_test("xts(serpent)");
+		ret = min(ret, tcrypt_test("ecb(serpent)"));
+		ret = min(ret, tcrypt_test("cbc(serpent)"));
+		ret = min(ret, tcrypt_test("ctr(serpent)"));
+		ret = min(ret, tcrypt_test("lrw(serpent)"));
+		ret = min(ret, tcrypt_test("xts(serpent)"));
 		break;
 
 	case 10:
-		ret += tcrypt_test("ecb(aes)");
-		ret += tcrypt_test("cbc(aes)");
-		ret += tcrypt_test("lrw(aes)");
-		ret += tcrypt_test("xts(aes)");
-		ret += tcrypt_test("ctr(aes)");
-		ret += tcrypt_test("rfc3686(ctr(aes))");
-		ret += tcrypt_test("ofb(aes)");
-		ret += tcrypt_test("cfb(aes)");
-		ret += tcrypt_test("xctr(aes)");
+		ret = min(ret, tcrypt_test("ecb(aes)"));
+		ret = min(ret, tcrypt_test("cbc(aes)"));
+		ret = min(ret, tcrypt_test("lrw(aes)"));
+		ret = min(ret, tcrypt_test("xts(aes)"));
+		ret = min(ret, tcrypt_test("ctr(aes)"));
+		ret = min(ret, tcrypt_test("rfc3686(ctr(aes))"));
+		ret = min(ret, tcrypt_test("ofb(aes)"));
+		ret = min(ret, tcrypt_test("cfb(aes)"));
+		ret = min(ret, tcrypt_test("xctr(aes)"));
 		break;
 
 	case 11:
-		ret += tcrypt_test("sha384");
+		ret = min(ret, tcrypt_test("sha384"));
 		break;
 
 	case 12:
-		ret += tcrypt_test("sha512");
+		ret = min(ret, tcrypt_test("sha512"));
 		break;
 
 	case 13:
-		ret += tcrypt_test("deflate");
+		ret = min(ret, tcrypt_test("deflate"));
 		break;
 
 	case 14:
-		ret += tcrypt_test("ecb(cast5)");
-		ret += tcrypt_test("cbc(cast5)");
-		ret += tcrypt_test("ctr(cast5)");
+		ret = min(ret, tcrypt_test("ecb(cast5)"));
+		ret = min(ret, tcrypt_test("cbc(cast5)"));
+		ret = min(ret, tcrypt_test("ctr(cast5)"));
 		break;
 
 	case 15:
-		ret += tcrypt_test("ecb(cast6)");
-		ret += tcrypt_test("cbc(cast6)");
-		ret += tcrypt_test("ctr(cast6)");
-		ret += tcrypt_test("lrw(cast6)");
-		ret += tcrypt_test("xts(cast6)");
+		ret = min(ret, tcrypt_test("ecb(cast6)"));
+		ret = min(ret, tcrypt_test("cbc(cast6)"));
+		ret = min(ret, tcrypt_test("ctr(cast6)"));
+		ret = min(ret, tcrypt_test("lrw(cast6)"));
+		ret = min(ret, tcrypt_test("xts(cast6)"));
 		break;
 
 	case 16:
-		ret += tcrypt_test("ecb(arc4)");
+		ret = min(ret, tcrypt_test("ecb(arc4)"));
 		break;
 
 	case 17:
-		ret += tcrypt_test("michael_mic");
+		ret = min(ret, tcrypt_test("michael_mic"));
 		break;
 
 	case 18:
-		ret += tcrypt_test("crc32c");
+		ret = min(ret, tcrypt_test("crc32c"));
 		break;
 
 	case 19:
-		ret += tcrypt_test("ecb(tea)");
+		ret = min(ret, tcrypt_test("ecb(tea)"));
 		break;
 
 	case 20:
-		ret += tcrypt_test("ecb(xtea)");
+		ret = min(ret, tcrypt_test("ecb(xtea)"));
 		break;
 
 	case 21:
-		ret += tcrypt_test("ecb(khazad)");
+		ret = min(ret, tcrypt_test("ecb(khazad)"));
 		break;
 
 	case 22:
-		ret += tcrypt_test("wp512");
+		ret = min(ret, tcrypt_test("wp512"));
 		break;
 
 	case 23:
-		ret += tcrypt_test("wp384");
+		ret = min(ret, tcrypt_test("wp384"));
 		break;
 
 	case 24:
-		ret += tcrypt_test("wp256");
+		ret = min(ret, tcrypt_test("wp256"));
 		break;
 
 	case 26:
-		ret += tcrypt_test("ecb(anubis)");
-		ret += tcrypt_test("cbc(anubis)");
+		ret = min(ret, tcrypt_test("ecb(anubis)"));
+		ret = min(ret, tcrypt_test("cbc(anubis)"));
 		break;
 
 	case 30:
-		ret += tcrypt_test("ecb(xeta)");
+		ret = min(ret, tcrypt_test("ecb(xeta)"));
 		break;
 
 	case 31:
-		ret += tcrypt_test("pcbc(fcrypt)");
+		ret = min(ret, tcrypt_test("pcbc(fcrypt)"));
 		break;
 
 	case 32:
-		ret += tcrypt_test("ecb(camellia)");
-		ret += tcrypt_test("cbc(camellia)");
-		ret += tcrypt_test("ctr(camellia)");
-		ret += tcrypt_test("lrw(camellia)");
-		ret += tcrypt_test("xts(camellia)");
+		ret = min(ret, tcrypt_test("ecb(camellia)"));
+		ret = min(ret, tcrypt_test("cbc(camellia)"));
+		ret = min(ret, tcrypt_test("ctr(camellia)"));
+		ret = min(ret, tcrypt_test("lrw(camellia)"));
+		ret = min(ret, tcrypt_test("xts(camellia)"));
 		break;
 
 	case 33:
-		ret += tcrypt_test("sha224");
+		ret = min(ret, tcrypt_test("sha224"));
 		break;
 
 	case 35:
-		ret += tcrypt_test("gcm(aes)");
+		ret = min(ret, tcrypt_test("gcm(aes)"));
 		break;
 
 	case 36:
-		ret += tcrypt_test("lzo");
+		ret = min(ret, tcrypt_test("lzo"));
 		break;
 
 	case 37:
-		ret += tcrypt_test("ccm(aes)");
+		ret = min(ret, tcrypt_test("ccm(aes)"));
 		break;
 
 	case 38:
-		ret += tcrypt_test("cts(cbc(aes))");
+		ret = min(ret, tcrypt_test("cts(cbc(aes))"));
 		break;
 
         case 39:
-		ret += tcrypt_test("xxhash64");
+		ret = min(ret, tcrypt_test("xxhash64"));
 		break;
 
         case 40:
-		ret += tcrypt_test("rmd160");
+		ret = min(ret, tcrypt_test("rmd160"));
 		break;
 
 	case 42:
-		ret += tcrypt_test("blake2b-512");
+		ret = min(ret, tcrypt_test("blake2b-512"));
 		break;
 
 	case 43:
-		ret += tcrypt_test("ecb(seed)");
+		ret = min(ret, tcrypt_test("ecb(seed)"));
 		break;
 
 	case 45:
-		ret += tcrypt_test("rfc4309(ccm(aes))");
+		ret = min(ret, tcrypt_test("rfc4309(ccm(aes))"));
 		break;
 
 	case 46:
-		ret += tcrypt_test("ghash");
+		ret = min(ret, tcrypt_test("ghash"));
 		break;
 
 	case 47:
-		ret += tcrypt_test("crct10dif");
+		ret = min(ret, tcrypt_test("crct10dif"));
 		break;
 
 	case 48:
-		ret += tcrypt_test("sha3-224");
+		ret = min(ret, tcrypt_test("sha3-224"));
 		break;
 
 	case 49:
-		ret += tcrypt_test("sha3-256");
+		ret = min(ret, tcrypt_test("sha3-256"));
 		break;
 
 	case 50:
-		ret += tcrypt_test("sha3-384");
+		ret = min(ret, tcrypt_test("sha3-384"));
 		break;
 
 	case 51:
-		ret += tcrypt_test("sha3-512");
+		ret = min(ret, tcrypt_test("sha3-512"));
 		break;
 
 	case 52:
-		ret += tcrypt_test("sm3");
+		ret = min(ret, tcrypt_test("sm3"));
 		break;
 
 	case 53:
-		ret += tcrypt_test("streebog256");
+		ret = min(ret, tcrypt_test("streebog256"));
 		break;
 
 	case 54:
-		ret += tcrypt_test("streebog512");
+		ret = min(ret, tcrypt_test("streebog512"));
 		break;
 
 	case 55:
-		ret += tcrypt_test("gcm(sm4)");
+		ret = min(ret, tcrypt_test("gcm(sm4)"));
 		break;
 
 	case 56:
-		ret += tcrypt_test("ccm(sm4)");
+		ret = min(ret, tcrypt_test("ccm(sm4)"));
 		break;
 
 	case 57:
-		ret += tcrypt_test("polyval");
+		ret = min(ret, tcrypt_test("polyval"));
 		break;
 
 	case 58:
-		ret += tcrypt_test("gcm(aria)");
+		ret = min(ret, tcrypt_test("gcm(aria)"));
 		break;
 
 	case 100:
-		ret += tcrypt_test("hmac(md5)");
+		ret = min(ret, tcrypt_test("hmac(md5)"));
 		break;
 
 	case 101:
-		ret += tcrypt_test("hmac(sha1)");
+		ret = min(ret, tcrypt_test("hmac(sha1)"));
 		break;
 
 	case 102:
-		ret += tcrypt_test("hmac(sha256)");
+		ret = min(ret, tcrypt_test("hmac(sha256)"));
 		break;
 
 	case 103:
-		ret += tcrypt_test("hmac(sha384)");
+		ret = min(ret, tcrypt_test("hmac(sha384)"));
 		break;
 
 	case 104:
-		ret += tcrypt_test("hmac(sha512)");
+		ret = min(ret, tcrypt_test("hmac(sha512)"));
 		break;
 
 	case 105:
-		ret += tcrypt_test("hmac(sha224)");
+		ret = min(ret, tcrypt_test("hmac(sha224)"));
 		break;
 
 	case 106:
-		ret += tcrypt_test("xcbc(aes)");
+		ret = min(ret, tcrypt_test("xcbc(aes)"));
 		break;
 
 	case 108:
-		ret += tcrypt_test("hmac(rmd160)");
+		ret = min(ret, tcrypt_test("hmac(rmd160)"));
 		break;
 
 	case 109:
-		ret += tcrypt_test("vmac64(aes)");
+		ret = min(ret, tcrypt_test("vmac64(aes)"));
 		break;
 
 	case 111:
-		ret += tcrypt_test("hmac(sha3-224)");
+		ret = min(ret, tcrypt_test("hmac(sha3-224)"));
 		break;
 
 	case 112:
-		ret += tcrypt_test("hmac(sha3-256)");
+		ret = min(ret, tcrypt_test("hmac(sha3-256)"));
 		break;
 
 	case 113:
-		ret += tcrypt_test("hmac(sha3-384)");
+		ret = min(ret, tcrypt_test("hmac(sha3-384)"));
 		break;
 
 	case 114:
-		ret += tcrypt_test("hmac(sha3-512)");
+		ret = min(ret, tcrypt_test("hmac(sha3-512)"));
 		break;
 
 	case 115:
-		ret += tcrypt_test("hmac(streebog256)");
+		ret = min(ret, tcrypt_test("hmac(streebog256)"));
 		break;
 
 	case 116:
-		ret += tcrypt_test("hmac(streebog512)");
+		ret = min(ret, tcrypt_test("hmac(streebog512)"));
 		break;
 
 	case 150:
-		ret += tcrypt_test("ansi_cprng");
+		ret = min(ret, tcrypt_test("ansi_cprng"));
 		break;
 
 	case 151:
-		ret += tcrypt_test("rfc4106(gcm(aes))");
+		ret = min(ret, tcrypt_test("rfc4106(gcm(aes))"));
 		break;
 
 	case 152:
-		ret += tcrypt_test("rfc4543(gcm(aes))");
+		ret = min(ret, tcrypt_test("rfc4543(gcm(aes))"));
 		break;
 
 	case 153:
-		ret += tcrypt_test("cmac(aes)");
+		ret = min(ret, tcrypt_test("cmac(aes)"));
 		break;
 
 	case 154:
-		ret += tcrypt_test("cmac(des3_ede)");
+		ret = min(ret, tcrypt_test("cmac(des3_ede)"));
 		break;
 
 	case 155:
-		ret += tcrypt_test("authenc(hmac(sha1),cbc(aes))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha1),cbc(aes))"));
 		break;
 
 	case 156:
-		ret += tcrypt_test("authenc(hmac(md5),ecb(cipher_null))");
+		ret = min(ret, tcrypt_test("authenc(hmac(md5),ecb(cipher_null))"));
 		break;
 
 	case 157:
-		ret += tcrypt_test("authenc(hmac(sha1),ecb(cipher_null))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha1),ecb(cipher_null))"));
 		break;
 
 	case 158:
-		ret += tcrypt_test("cbcmac(sm4)");
+		ret = min(ret, tcrypt_test("cbcmac(sm4)"));
 		break;
 
 	case 159:
-		ret += tcrypt_test("cmac(sm4)");
+		ret = min(ret, tcrypt_test("cmac(sm4)"));
 		break;
 
 	case 181:
-		ret += tcrypt_test("authenc(hmac(sha1),cbc(des))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha1),cbc(des))"));
 		break;
 	case 182:
-		ret += tcrypt_test("authenc(hmac(sha1),cbc(des3_ede))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha1),cbc(des3_ede))"));
 		break;
 	case 183:
-		ret += tcrypt_test("authenc(hmac(sha224),cbc(des))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha224),cbc(des))"));
 		break;
 	case 184:
-		ret += tcrypt_test("authenc(hmac(sha224),cbc(des3_ede))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha224),cbc(des3_ede))"));
 		break;
 	case 185:
-		ret += tcrypt_test("authenc(hmac(sha256),cbc(des))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha256),cbc(des))"));
 		break;
 	case 186:
-		ret += tcrypt_test("authenc(hmac(sha256),cbc(des3_ede))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha256),cbc(des3_ede))"));
 		break;
 	case 187:
-		ret += tcrypt_test("authenc(hmac(sha384),cbc(des))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha384),cbc(des))"));
 		break;
 	case 188:
-		ret += tcrypt_test("authenc(hmac(sha384),cbc(des3_ede))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha384),cbc(des3_ede))"));
 		break;
 	case 189:
-		ret += tcrypt_test("authenc(hmac(sha512),cbc(des))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha512),cbc(des))"));
 		break;
 	case 190:
-		ret += tcrypt_test("authenc(hmac(sha512),cbc(des3_ede))");
+		ret = min(ret, tcrypt_test("authenc(hmac(sha512),cbc(des3_ede))"));
 		break;
 	case 191:
-		ret += tcrypt_test("ecb(sm4)");
-		ret += tcrypt_test("cbc(sm4)");
-		ret += tcrypt_test("cfb(sm4)");
-		ret += tcrypt_test("ctr(sm4)");
+		ret = min(ret, tcrypt_test("ecb(sm4)"));
+		ret = min(ret, tcrypt_test("cbc(sm4)"));
+		ret = min(ret, tcrypt_test("cfb(sm4)"));
+		ret = min(ret, tcrypt_test("ctr(sm4)"));
 		break;
 	case 192:
-		ret += tcrypt_test("ecb(aria)");
-		ret += tcrypt_test("cbc(aria)");
-		ret += tcrypt_test("cfb(aria)");
-		ret += tcrypt_test("ctr(aria)");
+		ret = min(ret, tcrypt_test("ecb(aria)"));
+		ret = min(ret, tcrypt_test("cbc(aria)"));
+		ret = min(ret, tcrypt_test("cfb(aria)"));
+		ret = min(ret, tcrypt_test("ctr(aria)"));
 		break;
 	case 200:
 		test_cipher_speed("ecb(aes)", ENCRYPT, sec, NULL, 0,
-- 
2.37.2

