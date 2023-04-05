Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B96B6D7D65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbjDENJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbjDENIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:08:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37EB271C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:08:52 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335BXMYx028010;
        Wed, 5 Apr 2023 13:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FfCX+5MS5/mbJzVh7X50G8k35Eqk7y00iwhhaK8QWd8=;
 b=lbb181pwcf7fONX0LdOwWx1fUCQ5LqYPqG7AEnLeFLiMp0duUKYEuX8leNC240b/bDlk
 aUr2OXuFeRl6ECE9yL+Hb1MsTMpVX73NJDfHSOmAbS/Eib2uBZiOVR2Fa1GPeCA7upHk
 dfhcVjxrOONLcFTyoFlhV7CgVxpMAjPF2S9xvpbIT2a7qWTIAw+7DJmQLb4ZGICUA09E
 ta/GJQYCK4z27tAx7RDxzBEobt5FJ5fDkIRnPqDd7YJnqTFo0Iv5IaEi28KTClTYaQe/
 P843NTxFUAWMbDpMwKjDUHaVevEoK9JW7Mo1ybkE4CyFSQuv/cXLTSmIGGtZdzVbrTbs Hw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps75jc2ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 13:08:47 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 334BDPkV018271;
        Wed, 5 Apr 2023 13:08:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ppc86thes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 13:08:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335D8gUl46465508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 13:08:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73C0B20040;
        Wed,  5 Apr 2023 13:08:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AD1720043;
        Wed,  5 Apr 2023 13:08:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 13:08:42 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] s390/stackleak: provide fast __stackleak_poison() implementation
Date:   Wed,  5 Apr 2023 15:08:41 +0200
Message-Id: <20230405130841.1350565-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405130841.1350565-1-hca@linux.ibm.com>
References: <20230405130841.1350565-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6MIjz_VF5-ht1h1HZarl0nvZAfl7B397
X-Proofpoint-ORIG-GUID: 6MIjz_VF5-ht1h1HZarl0nvZAfl7B397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_08,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 mlxlogscore=757 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050118
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an s390 specific __stackleak_poison() implementation which is
faster than the generic variant.

For the original implementation with an enforced 4kb stackframe for the
getpid() system call the system call overhead increases by a factor of 3 if
the stackleak feature is enabled. Using the s390 mvc based variant this is
reduced to an increase of 25% instead.

This is within the expected area, since the mvc based implementation is
more or less a memset64() variant which comes with similar results. See
commit 0b77d6701cf8 ("s390: implement memset16, memset32 & memset64").

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/processor.h | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index efffc28cbad8..dc17896a001a 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -118,6 +118,41 @@ unsigned long vdso_size(void);
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
+#define __stackleak_poison __stackleak_poison
+static __always_inline void __stackleak_poison(unsigned long erase_low,
+					       unsigned long erase_high,
+					       unsigned long poison)
+{
+	unsigned long tmp, count;
+
+	count = erase_high - erase_low;
+	if (!count)
+		return;
+	asm volatile(
+		"	cghi	%[count],8\n"
+		"	je	2f\n"
+		"	aghi	%[count],-(8+1)\n"
+		"	srlg	%[tmp],%[count],8\n"
+		"	ltgr	%[tmp],%[tmp]\n"
+		"	jz	1f\n"
+		"0:	stg	%[poison],0(%[addr])\n"
+		"	mvc	8(256-8,%[addr]),0(%[addr])\n"
+		"	la	%[addr],256(%[addr])\n"
+		"	brctg	%[tmp],0b\n"
+		"1:	stg	%[poison],0(%[addr])\n"
+		"	larl	%[tmp],3f\n"
+		"	ex	%[count],0(%[tmp])\n"
+		"	j	4f\n"
+		"2:	stg	%[poison],0(%[addr])\n"
+		"	j	4f\n"
+		"3:	mvc	8(1,%[addr]),0(%[addr])\n"
+		"4:\n"
+		: [addr] "+&a" (erase_low), [count] "+&d" (count), [tmp] "=&a" (tmp)
+		: [poison] "d" (poison)
+		: "memory", "cc"
+		);
+}
+
 /*
  * Thread structure
  */
-- 
2.37.2

