Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD5262B218
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKPEOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKPEOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:12 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9381DF33;
        Tue, 15 Nov 2022 20:14:11 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG31MdE027556;
        Wed, 16 Nov 2022 04:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=OQQdqDDbTZo3g2+8cfmGfikrPh68vOUttFSoj8wftHw=;
 b=I1XsPFNR/SjuWMvT/gvlpEIPKJiMDMnVifggwyfN+2z+hLbruihk0N2DpR3ycva+jS3z
 8iIZ8V3rev+FZ7nHeV8gB9dUcU7zBG+dHIM6HM8z9CL7qdrKkyVTAhLlZ3cA/pOhdlqp
 AA4PvJKGF/g1RI4UMEG/gEgG7ibcXpRYcYJS+P2jx1hJkPEnppM6Z5LTTI5OoJDy1LdG
 eOjGJo3ay3sNUmUpbjaiBrE6IBtqmlbkvmilnpfxadbO1cgxTV3fWERIaB8iBEu1HFYi
 ConBT0K0eRhtr/TVfeHEiL/DKvNQeMh4f6DjOJ5ATjRP1oPukIfuabENvJbVpzMM9Ja4 tA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqkbreeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:13:55 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8C9C9809F55;
        Wed, 16 Nov 2022 04:13:54 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 07DE6808B9A;
        Wed, 16 Nov 2022 04:13:53 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 01/24] crypto: tcrypt - test crc32
Date:   Tue, 15 Nov 2022 22:13:19 -0600
Message-Id: <20221116041342.3841-2-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tKkXXZb93fsG73gPIS7Xx7aTQbp_KSIH
X-Proofpoint-ORIG-GUID: tKkXXZb93fsG73gPIS7Xx7aTQbp_KSIH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=920
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.38.1

