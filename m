Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157345FCDEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJLWAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJLWAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:01 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91421A3A4;
        Wed, 12 Oct 2022 14:59:59 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CL4RTk005193;
        Wed, 12 Oct 2022 21:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=Nj/d5OC2AY6b4soOh7HzxmFB+I7wGPKsbzfoKqMoiAo=;
 b=mPsvLxOfIXLYpsskHdU5Yah6fDTyDmk7EYqojBSolApJF9of4Kda4tJxBDYFeOFhJAzY
 a5eAuMuT/V+wnNv8XPjcUtCyZRDbHtORDRNzTU7a/hsKiQdg5EsoLqJgX5tV3RUgaAzO
 SnuwiQWaqXMahGsjhjDZeSksbjavla2tW20RCsjbY8CubbaIk/5CJlUvisA6K9s6cvnc
 H7mNmVNM5zIofME/gtoMuYWRiA/74YoaXA+eyrV/e5m33zY3KZCSd5tK9s3F5aOzaQqM
 VC/85Ofa4iX4niHexAqB0X+OWH8HTNwD6NmAHaSBrOqQ2JTnCOpocIlVGE2+2tPoBcAW Gg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k6471rtmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 21:59:45 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 359EDD25E;
        Wed, 12 Oct 2022 21:59:45 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id C79D6805032;
        Wed, 12 Oct 2022 21:59:44 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 02/19] crypto: tcrypt - test nhpoly1305
Date:   Wed, 12 Oct 2022 16:59:14 -0500
Message-Id: <20221012215931.3896-3-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TfiL1oFu1kgu4lTkUG7plhaa5JSLfse-
X-Proofpoint-ORIG-GUID: TfiL1oFu1kgu4lTkUG7plhaa5JSLfse-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120138
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add self-test mode for nhpoly1305.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/tcrypt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 4426386dfb42..7a6a56751043 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1715,6 +1715,10 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret += tcrypt_test("crc32");
 		break;
 
+	case 60:
+		ret += tcrypt_test("nhpoly1305");
+		break;
+
 	case 100:
 		ret += tcrypt_test("hmac(md5)");
 		break;
-- 
2.37.3

