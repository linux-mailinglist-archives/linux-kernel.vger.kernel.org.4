Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6078B62D7B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiKQKH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiKQKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:07:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5E9231;
        Thu, 17 Nov 2022 02:07:54 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHA4ZR0021905;
        Thu, 17 Nov 2022 10:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JaCIDDpk7BYV0nNmKdadv18At5+yJDw3IEaveKy6i2M=;
 b=Tpn4xNkl0eK4LaxL17ZMT2L6dKosgxWirY4t1rVQRy3/no0e++afuawoAHXcl+Ot/HcW
 mmyYyfWClO36goWKC2LsDjYtImEsxjKt/leBUpUUUXg8StZ3DTM+lPitgHJCx+gh99cl
 aL7KPA5h8obuGGyJokcAseCUjmee/FM3fxIpVMgjRHUKbrwgAzrfUFVZDYsKTWa77MMs
 SsQxsRHpE/BuZ9KD1JJViMvirqEIcrY2mbrydLv2cXd9KB+fOmt8z5VC7l20NBh8ATgb
 /X5MiGdAyTu2EUEXJIO1I3dxbRAS4zXUvcOzWDXdFYAVkaIFF4h23R3dJtvDOjhq/pj/ 5g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwjvtgc1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 10:07:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHA4bim017472;
        Thu, 17 Nov 2022 10:07:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3kt348yc6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 10:07:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHA7lEV1049124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 10:07:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43A15A405B;
        Thu, 17 Nov 2022 10:07:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8860A4054;
        Thu, 17 Nov 2022 10:07:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 10:07:46 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] s390/uaccess: Limit number of retries for cmpxchg_user_key
Date:   Thu, 17 Nov 2022 11:07:45 +0100
Message-Id: <20221117100745.3253896-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8708073bdd4c90dbc25ee3711afc59585bc0d740.camel@linux.ibm.com>
References: <8708073bdd4c90dbc25ee3711afc59585bc0d740.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tIXt1GMRcWCOyb7J6xZz-3RaWGVE-grR
X-Proofpoint-ORIG-GUID: tIXt1GMRcWCOyb7J6xZz-3RaWGVE-grR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmpxchg_user_key for byte and short values is implemented via a one word
cmpxchg loop. Give up trying to perform the cmpxchg if it fails too
often because of contention on the cache line. This ensures that the
thread cannot become stuck in the kernel.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---


128 might seem like a small number, but it actually seems to be plenty.
I could not get it to return EAGAIN with MAX_LOOP being 8 while 248
vcpus/threads are hammering the same word.
This could mean that we don't actually need to limit the number of
retries, but then, I didn't simulate the absolute worst case, where
the competing threads are running on dedicated cpus.


 arch/s390/include/asm/uaccess.h | 35 +++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index d028ee59e941..f2d3a4e27963 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -392,6 +392,8 @@ do {									\
 
 void __cmpxchg_user_key_called_with_bad_pointer(void);
 
+#define CMPXCHG_USER_KEY_MAX_LOOPS 128
+
 static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
 					      __uint128_t old, __uint128_t new,
 					      unsigned long key, int size)
@@ -400,7 +402,7 @@ static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
 
 	switch (size) {
 	case 1: {
-		unsigned int prev, shift, mask, _old, _new;
+		unsigned int prev, shift, mask, _old, _new, count;
 
 		shift = (3 ^ (address & 3)) << 3;
 		address ^= address & 3;
@@ -410,6 +412,7 @@ static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
 		asm volatile(
 			"	spka	0(%[key])\n"
 			"	sacf	256\n"
+			"	llill	%[count],%[max_loops]\n"
 			"0:	l	%[prev],%[address]\n"
 			"1:	nr	%[prev],%[mask]\n"
 			"	xilf	%[mask],0xffffffff\n"
@@ -421,7 +424,8 @@ static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
 			"	xr	%[tmp],%[prev]\n"
 			"	xr	%[new],%[tmp]\n"
 			"	nr	%[tmp],%[mask]\n"
-			"	jz	2b\n"
+			"	jnz	5f\n"
+			"	brct	%[count],2b\n"
 			"5:	sacf	768\n"
 			"	spka	%[default_key]\n"
 			EX_TABLE_UA_LOAD_REG(0b, 5b, %[rc], %[prev])
@@ -433,15 +437,19 @@ static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
 			  [address] "+Q" (*(int *)address),
 			  [tmp] "+&d" (_old),
 			  [new] "+&d" (_new),
-			  [mask] "+&d" (mask)
-			: [key] "a" (key << 4),
-			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			  [mask] "+&d" (mask),
+			  [count] "=a" (count)
+			: [key] "%[count]" (key << 4),
+			  [default_key] "J" (PAGE_DEFAULT_KEY),
+			  [max_loops] "J" (CMPXCHG_USER_KEY_MAX_LOOPS)
 			: "memory", "cc");
 		*(unsigned char *)uval = prev >> shift;
+		if (!count)
+			rc = -EAGAIN;
 		return rc;
 	}
 	case 2: {
-		unsigned int prev, shift, mask, _old, _new;
+		unsigned int prev, shift, mask, _old, _new, count;
 
 		shift = (2 ^ (address & 2)) << 3;
 		address ^= address & 2;
@@ -451,6 +459,7 @@ static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
 		asm volatile(
 			"	spka	0(%[key])\n"
 			"	sacf	256\n"
+			"	llill	%[count],%[max_loops]\n"
 			"0:	l	%[prev],%[address]\n"
 			"1:	nr	%[prev],%[mask]\n"
 			"	xilf	%[mask],0xffffffff\n"
@@ -462,7 +471,8 @@ static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
 			"	xr	%[tmp],%[prev]\n"
 			"	xr	%[new],%[tmp]\n"
 			"	nr	%[tmp],%[mask]\n"
-			"	jz	2b\n"
+			"	jnz	5f\n"
+			"	brct	%[count],2b\n"
 			"5:	sacf	768\n"
 			"	spka	%[default_key]\n"
 			EX_TABLE_UA_LOAD_REG(0b, 5b, %[rc], %[prev])
@@ -474,11 +484,15 @@ static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
 			  [address] "+Q" (*(int *)address),
 			  [tmp] "+&d" (_old),
 			  [new] "+&d" (_new),
-			  [mask] "+&d" (mask)
-			: [key] "a" (key << 4),
-			  [default_key] "J" (PAGE_DEFAULT_KEY)
+			  [mask] "+&d" (mask),
+			  [count] "=a" (count)
+			: [key] "%[count]" (key << 4),
+			  [default_key] "J" (PAGE_DEFAULT_KEY),
+			  [max_loops] "J" (CMPXCHG_USER_KEY_MAX_LOOPS)
 			: "memory", "cc");
 		*(unsigned short *)uval = prev >> shift;
+		if (!count)
+			rc = -EAGAIN;
 		return rc;
 	}
 	case 4:	{
@@ -568,6 +582,7 @@ static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
  *
  * Return:     0: cmpxchg executed
  *	       -EFAULT: an exception happened when trying to access *@ptr
+ *             -EAGAIN: maxed out number of retries (byte and short only)
  */
 #define cmpxchg_user_key(ptr, uval, old, new, key)			\
 ({									\

base-commit: b23ddf9d5a30f64a1a51a85f0d9e2553210b21a2
prerequisite-patch-id: c5cdc3ce7cdffc18c5e56abfb657c84141fb623a
-- 
2.34.1

