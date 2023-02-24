Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421DC6A1A80
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBXKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBXKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:42:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB6F671F5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:41:31 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OAFRNJ017733;
        Fri, 24 Feb 2023 10:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bt25XQYrLSxNwDQkOSnKkbwhoxJd6ZKZw9dpKyyeqgM=;
 b=m/VfBJIpgO1uCFTZfhTxhdyBxleVZwE6vVp6y9Qd9EkAzNcD3Lar5++GqerGSYzLNAB4
 aX3UrCu8zfsZ43cxoK9QWRs+3fyC2o2qojf+5HvFI1c5FpoT3F37URluc2tZ0RdJmz15
 m5DBu80hOqKWflNTzscsisyPm2xOKbqG0V9vJKEyW1YLY4lyo+pAX3gutoUUR2GeW6Lq
 GzPNV6gjueE+zEIVRpyFM+c4+z502c+Q8JYzWL2doVrFtQwl0P4sKYchqdEUXR9jcaKs
 uWnZ4pYkG9fB9BrZ07m7uDODp88mUQdMyqX5liGIpWqbSGhBDn1HeI7SZe3qrXskYtS9 JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxuap8h3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:41:09 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31OAI50q025813;
        Fri, 24 Feb 2023 10:41:08 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxuap8h2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:41:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31NN1KEN016569;
        Fri, 24 Feb 2023 10:41:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6fudc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:41:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31OAf4LS44368162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 10:41:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05CD320043;
        Fri, 24 Feb 2023 10:41:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57A8320040;
        Fri, 24 Feb 2023 10:41:01 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.ibm.com.com (unknown [9.43.6.21])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Feb 2023 10:41:01 +0000 (GMT)
From:   "Nysal Jan K.A" <nysal@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Nysal Jan K.A" <nysal@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/atomics: Remove unused function
Date:   Fri, 24 Feb 2023 16:09:40 +0530
Message-Id: <20230224103940.1328725-1-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YQ5ZyqvNeE7DCvVnFBnX-f4PBjlAc0TV
X-Proofpoint-ORIG-GUID: xz1fJeRRP9tfijdHZwPNFYxo7x5A5U5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_04,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=899 lowpriorityscore=0 clxscore=1011 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove arch_atomic_try_cmpxchg_lock function as it is no longer used
since commit 9f61521c7a28 ("powerpc/qspinlock: powerpc qspinlock
implementation")

Signed-off-by: Nysal Jan K.A <nysal@linux.ibm.com>
---
 arch/powerpc/include/asm/atomic.h | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 486ab7889121..b3a53830446b 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -130,35 +130,6 @@ ATOMIC_OPS(xor, xor, "", K)
 #define arch_atomic_xchg_relaxed(v, new) \
 	arch_xchg_relaxed(&((v)->counter), (new))
 
-/*
- * Don't want to override the generic atomic_try_cmpxchg_acquire, because
- * we add a lock hint to the lwarx, which may not be wanted for the
- * _acquire case (and is not used by the other _acquire variants so it
- * would be a surprise).
- */
-static __always_inline bool
-arch_atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
-{
-	int r, o = *old;
-	unsigned int eh = IS_ENABLED(CONFIG_PPC64);
-
-	__asm__ __volatile__ (
-"1:	lwarx	%0,0,%2,%[eh]	# atomic_try_cmpxchg_acquire		\n"
-"	cmpw	0,%0,%3							\n"
-"	bne-	2f							\n"
-"	stwcx.	%4,0,%2							\n"
-"	bne-	1b							\n"
-"\t"	PPC_ACQUIRE_BARRIER "						\n"
-"2:									\n"
-	: "=&r" (r), "+m" (v->counter)
-	: "r" (&v->counter), "r" (o), "r" (new), [eh] "n" (eh)
-	: "cr0", "memory");
-
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-
 /**
  * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
-- 
2.39.2

