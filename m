Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB6651544
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiLSWEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiLSWDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:33 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2A140D8;
        Mon, 19 Dec 2022 14:03:20 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJKdEeQ002227;
        Mon, 19 Dec 2022 22:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ytx49hxAW/5Vofc1aOHCr8Q+x9j/e6AuWZ4zsK8+9Fc=;
 b=T/CbVSUjbXTIPnbdEp5IctHSx/fVjKlksErJBnrc/G/sqyWFXQhLUzilM38Zf247E5jt
 GKvRjMDVq9Xxg/qXAuOxyysQWkh4Hz2rWITY6gNPt10CKx7yYXkBb3gzfcZ3kyWV6pZ+
 RZxksUGp30chzOo1BXP/ir5lu7ytBDADYQ2rtEaDRrHJR6uVdc5hvtgwj13YWk/iUIM0
 gbnwoJnORqDTpyKpFJo97/TjKEaASY/Ij0d2J45gW6CRFoXI8/KgwHb0oA0uANPVR8+G
 1lt8WQqCMEstAg9FqRQeL6ryFpdhlXCeN64F83QqXwtqs+yGNP2zOALvesIp7KCziLEn qw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjy650gt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:03:03 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id D89063DE25;
        Mon, 19 Dec 2022 22:03:02 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 161CF808734;
        Mon, 19 Dec 2022 22:03:02 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 12/13] crypto: x86/chacha - yield FPU context only when needed
Date:   Mon, 19 Dec 2022 16:02:22 -0600
Message-Id: <20221219220223.3982176-13-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: j1P-dXNFLU2g8BowGj6h7B-U2Q2W6YtA
X-Proofpoint-ORIG-GUID: j1P-dXNFLU2g8BowGj6h7B-U2Q2W6YtA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190194
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 assembly language implementations using SIMD process data
between kernel_fpu_begin() and kernel_fpu_end() calls. That
disables scheduler preemption, so prevents the CPU core from being
used by other threads.

Rather than break the processing into 4 KiB passes, each of which
unilaterally calls kernel_fpu_begin() and kernel_fpu_end(),
periodically check if the kernel scheduler wants to run something
else on the CPU. If so, yield the kernel FPU context and let the
scheduler intervene.

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/chacha_glue.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 7b3a1cf0984b..892cbae958b8 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -146,17 +146,21 @@ void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src, unsigned int bytes,
 	    bytes <= CHACHA_BLOCK_SIZE)
 		return chacha_crypt_generic(state, dst, src, bytes, nrounds);
 
-	do {
-		unsigned int todo = min_t(unsigned int, bytes, SZ_4K);
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunk = min(bytes, 4096U);
 
-		kernel_fpu_begin();
-		chacha_dosimd(state, dst, src, todo, nrounds);
-		kernel_fpu_end();
+		chacha_dosimd(state, dst, src, chunk, nrounds);
 
-		bytes -= todo;
-		src += todo;
-		dst += todo;
-	} while (bytes);
+		bytes -= chunk;
+		if (!bytes)
+			break;
+
+		src += chunk;
+		dst += chunk;
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
 }
 EXPORT_SYMBOL(chacha_crypt_arch);
 
-- 
2.38.1

