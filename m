Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1073A62C145
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiKPOrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiKPOrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:47:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9294540461;
        Wed, 16 Nov 2022 06:47:36 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGEkG18002677;
        Wed, 16 Nov 2022 14:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lw4nrFNvweQchMjADogyRUrn8uN03wYeaiAvxvCmGBg=;
 b=M7gdpECzaNHNZFQzwlsWuIqxDs/paSbfYg7TN1uSobM1dPwopzxPLUFKOHx6P4b+HILf
 DXzf66I6AKlNMfA5MjMDO7WzsmnOtJYPxbeH6SzoHbIMNg71dDcXTPZ2RKGqMJOJLbVY
 7B+LASmIpHPgMtgw+rPkauSxUyIU7rTQAx3FXfMqfnHzdbNJE7mU3mwjuy9sfJoJ0nA+
 o1tR87Aiz76Dv6q/bPcc5XDCF7d0xI25TsItRiHSFeM4j0z0hURRDo45ocYHdtRh9IgN
 LPlIWT+BlsuIBHZEImbxLFdxroEf6VhgcngfIyl8Bai+EHjiazgM7dFFPptLQ0qagQJ6 nw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw0hh34m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 14:47:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGEZkob000725;
        Wed, 16 Nov 2022 14:47:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3kt348x2tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 14:47:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AGElU8a7340642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 14:47:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5183A4C044;
        Wed, 16 Nov 2022 14:47:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B7064C040;
        Wed, 16 Nov 2022 14:47:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Nov 2022 14:47:29 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: cmpxchg: Make loop condition for 1,2 byte cases precise
Date:   Wed, 16 Nov 2022 15:47:11 +0100
Message-Id: <20221116144711.3811011-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y2zhNhFjIJPKJao8@osiris>
References: <Y2zhNhFjIJPKJao8@osiris>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yW-o3Ig67b9-hrlLZGJS7gqBYrs1MfWH
X-Proofpoint-GUID: yW-o3Ig67b9-hrlLZGJS7gqBYrs1MfWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cmpxchg implementation for 1 and 2 bytes consists of a 4 byte
cmpxchg loop. Currently, the decision to retry is imprecise, looping if
bits outside the target byte(s) change instead of retrying until the
target byte(s) differ from the old value.
E.g. if an attempt to exchange (prev_left_0 old_bytes prev_right_0) is
made and it fails because the word at the address is
(prev_left_1 x prev_right_1) where both x != old_bytes and one of the
prev_*_1 values differs from the respective prev_*_0 value, the cmpxchg
is retried, even if by a semantic equivalent to a normal cmpxchg, the
exchange would fail.
Instead exit the loop if x != old_bytes and retry otherwise.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---


Unfortunately the diff got blown up quite a bit, even tho the asm
changes are not that complex. This is mostly because of in arguments
becoming (in)out arguments.

I don't think all the '&' constraints are necessary, but I don't see how
they could affect code generation.
I don't see why we would need the memory clobber, however.

I tested the cmpxchg_user_key changes via the kvm memop selftest that is
part of the KVM cmpxchg memop series.
I looked for an existing way to test the cmpxchg changes, but didn't
find anything.


 arch/s390/include/asm/cmpxchg.h | 60 ++++++++++++++-----------
 arch/s390/include/asm/uaccess.h | 80 ++++++++++++++++++---------------
 2 files changed, 78 insertions(+), 62 deletions(-)

diff --git a/arch/s390/include/asm/cmpxchg.h b/arch/s390/include/asm/cmpxchg.h
index 1c5785b851ec..3f26416c2ad8 100644
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -90,55 +90,63 @@ static __always_inline unsigned long __cmpxchg(unsigned long address,
 {
 	switch (size) {
 	case 1: {
-		unsigned int prev, tmp, shift;
+		unsigned int prev, shift, mask;
 
 		shift = (3 ^ (address & 3)) << 3;
 		address ^= address & 3;
+		old = (old & 0xff) << shift;
+		new = (new & 0xff) << shift;
+		mask = ~(0xff << shift);
 		asm volatile(
 			"	l	%[prev],%[address]\n"
-			"0:	nr	%[prev],%[mask]\n"
-			"	lr	%[tmp],%[prev]\n"
-			"	or	%[prev],%[old]\n"
-			"	or	%[tmp],%[new]\n"
-			"	cs	%[prev],%[tmp],%[address]\n"
+			"	nr	%[prev],%[mask]\n"
+			"	xilf	%[mask],0xffffffff\n"
+			"	or	%[new],%[prev]\n"
+			"	or	%[prev],%[tmp]\n"
+			"0:	lr	%[tmp],%[prev]\n"
+			"	cs	%[prev],%[new],%[address]\n"
 			"	jnl	1f\n"
 			"	xr	%[tmp],%[prev]\n"
+			"	xr	%[new],%[tmp]\n"
 			"	nr	%[tmp],%[mask]\n"
-			"	jnz	0b\n"
+			"	jz	0b\n"
 			"1:"
 			: [prev] "=&d" (prev),
-			  [tmp] "=&d" (tmp),
-			  [address] "+Q" (*(int *)address)
-			: [old] "d" ((old & 0xff) << shift),
-			  [new] "d" ((new & 0xff) << shift),
-			  [mask] "d" (~(0xff << shift))
-			: "memory", "cc");
+			  [address] "+Q" (*(int *)address),
+			  [tmp] "+&d" (old),
+			  [new] "+&d" (new),
+			  [mask] "+&d" (mask)
+			:: "memory", "cc");
 		return prev >> shift;
 	}
 	case 2: {
-		unsigned int prev, tmp, shift;
+		unsigned int prev, shift, mask;
 
 		shift = (2 ^ (address & 2)) << 3;
 		address ^= address & 2;
+		old = (old & 0xffff) << shift;
+		new = (new & 0xffff) << shift;
+		mask = ~(0xffff << shift);
 		asm volatile(
 			"	l	%[prev],%[address]\n"
-			"0:	nr	%[prev],%[mask]\n"
-			"	lr	%[tmp],%[prev]\n"
-			"	or	%[prev],%[old]\n"
-			"	or	%[tmp],%[new]\n"
-			"	cs	%[prev],%[tmp],%[address]\n"
+			"	nr	%[prev],%[mask]\n"
+			"	xilf	%[mask],0xffffffff\n"
+			"	or	%[new],%[prev]\n"
+			"	or	%[prev],%[tmp]\n"
+			"0:	lr	%[tmp],%[prev]\n"
+			"	cs	%[prev],%[new],%[address]\n"
 			"	jnl	1f\n"
 			"	xr	%[tmp],%[prev]\n"
+			"	xr	%[new],%[tmp]\n"
 			"	nr	%[tmp],%[mask]\n"
-			"	jnz	0b\n"
+			"	jz	0b\n"
 			"1:"
 			: [prev] "=&d" (prev),
-			  [tmp] "=&d" (tmp),
-			  [address] "+Q" (*(int *)address)
-			: [old] "d" ((old & 0xffff) << shift),
-			  [new] "d" ((new & 0xffff) << shift),
-			  [mask] "d" (~(0xffff << shift))
-			: "memory", "cc");
+			  [address] "+Q" (*(int *)address),
+			  [tmp] "+&d" (old),
+			  [new] "+&d" (new),
+			  [mask] "+&d" (mask)
+			:: "memory", "cc");
 		return prev >> shift;
 	}
 	case 4: {
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index a125e60a1521..d028ee59e941 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -400,74 +400,82 @@ static __always_inline int __cmpxchg_user_key(unsigned long address, void *uval,
 
 	switch (size) {
 	case 1: {
-		unsigned int prev, tmp, shift;
+		unsigned int prev, shift, mask, _old, _new;
 
 		shift = (3 ^ (address & 3)) << 3;
 		address ^= address & 3;
+		_old = (old & 0xff) << shift;
+		_new = (new & 0xff) << shift;
+		mask = ~(0xff << shift);
 		asm volatile(
 			"	spka	0(%[key])\n"
 			"	sacf	256\n"
 			"0:	l	%[prev],%[address]\n"
 			"1:	nr	%[prev],%[mask]\n"
-			"	lr	%[tmp],%[prev]\n"
-			"	or	%[prev],%[old]\n"
-			"	or	%[tmp],%[new]\n"
-			"2:	cs	%[prev],%[tmp],%[address]\n"
-			"3:	jnl	4f\n"
+			"	xilf	%[mask],0xffffffff\n"
+			"	or	%[new],%[prev]\n"
+			"	or	%[prev],%[tmp]\n"
+			"2:	lr	%[tmp],%[prev]\n"
+			"3:	cs	%[prev],%[new],%[address]\n"
+			"4:	jnl	5f\n"
 			"	xr	%[tmp],%[prev]\n"
+			"	xr	%[new],%[tmp]\n"
 			"	nr	%[tmp],%[mask]\n"
-			"	jnz	1b\n"
-			"4:	sacf	768\n"
+			"	jz	2b\n"
+			"5:	sacf	768\n"
 			"	spka	%[default_key]\n"
-			EX_TABLE_UA_LOAD_REG(0b, 4b, %[rc], %[prev])
-			EX_TABLE_UA_LOAD_REG(1b, 4b, %[rc], %[prev])
-			EX_TABLE_UA_LOAD_REG(2b, 4b, %[rc], %[prev])
-			EX_TABLE_UA_LOAD_REG(3b, 4b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(0b, 5b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(1b, 5b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(3b, 5b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(4b, 5b, %[rc], %[prev])
 			: [rc] "+&d" (rc),
 			  [prev] "=&d" (prev),
-			  [tmp] "=&d" (tmp),
-			  [address] "+Q" (*(int *)address)
-			: [old] "d" (((unsigned int)old & 0xff) << shift),
-			  [new] "d" (((unsigned int)new & 0xff) << shift),
-			  [mask] "d" (~(0xff << shift)),
-			  [key] "a" (key << 4),
+			  [address] "+Q" (*(int *)address),
+			  [tmp] "+&d" (_old),
+			  [new] "+&d" (_new),
+			  [mask] "+&d" (mask)
+			: [key] "a" (key << 4),
 			  [default_key] "J" (PAGE_DEFAULT_KEY)
 			: "memory", "cc");
 		*(unsigned char *)uval = prev >> shift;
 		return rc;
 	}
 	case 2: {
-		unsigned int prev, tmp, shift;
+		unsigned int prev, shift, mask, _old, _new;
 
 		shift = (2 ^ (address & 2)) << 3;
 		address ^= address & 2;
+		_old = (old & 0xffff) << shift;
+		_new = (new & 0xffff) << shift;
+		mask = ~(0xffff << shift);
 		asm volatile(
 			"	spka	0(%[key])\n"
 			"	sacf	256\n"
 			"0:	l	%[prev],%[address]\n"
 			"1:	nr	%[prev],%[mask]\n"
-			"	lr	%[tmp],%[prev]\n"
-			"	or	%[prev],%[old]\n"
-			"	or	%[tmp],%[new]\n"
-			"2:	cs	%[prev],%[tmp],%[address]\n"
-			"3:	jnl	4f\n"
+			"	xilf	%[mask],0xffffffff\n"
+			"	or	%[new],%[prev]\n"
+			"	or	%[prev],%[tmp]\n"
+			"2:	lr	%[tmp],%[prev]\n"
+			"3:	cs	%[prev],%[new],%[address]\n"
+			"4:	jnl	5f\n"
 			"	xr	%[tmp],%[prev]\n"
+			"	xr	%[new],%[tmp]\n"
 			"	nr	%[tmp],%[mask]\n"
-			"	jnz	1b\n"
-			"4:	sacf	768\n"
+			"	jz	2b\n"
+			"5:	sacf	768\n"
 			"	spka	%[default_key]\n"
-			EX_TABLE_UA_LOAD_REG(0b, 4b, %[rc], %[prev])
-			EX_TABLE_UA_LOAD_REG(1b, 4b, %[rc], %[prev])
-			EX_TABLE_UA_LOAD_REG(2b, 4b, %[rc], %[prev])
-			EX_TABLE_UA_LOAD_REG(3b, 4b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(0b, 5b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(1b, 5b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(3b, 5b, %[rc], %[prev])
+			EX_TABLE_UA_LOAD_REG(4b, 5b, %[rc], %[prev])
 			: [rc] "+&d" (rc),
 			  [prev] "=&d" (prev),
-			  [tmp] "=&d" (tmp),
-			  [address] "+Q" (*(int *)address)
-			: [old] "d" (((unsigned int)old & 0xffff) << shift),
-			  [new] "d" (((unsigned int)new & 0xffff) << shift),
-			  [mask] "d" (~(0xffff << shift)),
-			  [key] "a" (key << 4),
+			  [address] "+Q" (*(int *)address),
+			  [tmp] "+&d" (_old),
+			  [new] "+&d" (_new),
+			  [mask] "+&d" (mask)
+			: [key] "a" (key << 4),
 			  [default_key] "J" (PAGE_DEFAULT_KEY)
 			: "memory", "cc");
 		*(unsigned short *)uval = prev >> shift;

base-commit: b23ddf9d5a30f64a1a51a85f0d9e2553210b21a2
-- 
2.34.1

