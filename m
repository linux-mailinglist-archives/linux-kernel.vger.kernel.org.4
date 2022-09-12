Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5981F5B55D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiILIVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiILIVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:21:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D952655F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:21:02 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28C7g17e030107;
        Mon, 12 Sep 2022 08:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=pIVSStzXkzMCQKu51+bqeIkE7v1EnMDNXkIa6OMrcAo=;
 b=id/fNb5cKZ+tXTaz5pOYmQydK3RtFDBp8af5ir9eJl0DXNTocbPR5U4xPq0OhXmDQXzf
 ITbjelR9apJLDLaiP2l18HLLqZ0xn0K+avB1RvEb0fwyfLxqByLslc2T9gTUCiWbsSpN
 LwnaNDkAX8Te+hzDa8/n/YB87SodxXUoChWHBkCDPl/ITr2B1xQc7xIgDeP9E6rTZ6mM
 CCtVjfnHvXudZOVcPTWWTwRIUZ0I5Xwp2ZjJkqGr8ZoGmLHSqy8bF/bTDYPjDE8bGVua
 mnuEECS0/IDR4g5DZ+UI85uvtA9kbttlLR2PZvSma+zFAI4QQ5M/pmeT56aA1RMZ/1Vv nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jj0kv92mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:20:41 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28C82dZj020858;
        Mon, 12 Sep 2022 08:20:40 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jj0kv92js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:20:40 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28C86YtE030757;
        Mon, 12 Sep 2022 08:20:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3jgj78shqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:20:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28C8KZe016843242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 08:20:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37E32A4053;
        Mon, 12 Sep 2022 08:20:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E587A4040;
        Mon, 12 Sep 2022 08:20:30 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.91.220])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Sep 2022 08:20:30 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v3 01/16] powerpc: Fix __WARN_FLAGS() for use with Objtool
Date:   Mon, 12 Sep 2022 13:50:05 +0530
Message-Id: <20220912082020.226755-2-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220912082020.226755-1-sv@linux.ibm.com>
References: <20220912082020.226755-1-sv@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uYfVAMj_QzTtDumOlHBmN4dNpWw_8yw6
X-Proofpoint-ORIG-GUID: q3e4ZxmwhRFc9ggP1Avx2pkR6w2v0HTN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=916 mlxscore=0 phishscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120027
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1e688dd2a3d675 ("powerpc/bug: Provide better flexibility to
WARN_ON/__WARN_FLAGS() with asm goto") updated __WARN_FLAGS() to use asm
goto, and added a call to 'unreachable()' after the asm goto for optimal
code generation. With CONFIG_OBJTOOL enabled, 'annotate_unreachable()'
statement in 'unreachable()' tries to note down the location of the
subsequent instruction in a separate elf section to aid code flow
analysis. However, on powerpc, this results in gcc emitting a call to a
symbol of size 0. This results in objtool complaining of "unannotated
intra-function call" since the target symbol is not a valid function
call destination.

Objtool wants this annotation for code flow analysis, which we are not
yet enabling on powerpc. As such, expand the call to 'unreachable()' in
__WARN_FLAGS() without annotate_unreachable():
        barrier_before_unreachable();
        __builtin_unreachable();

This still results in optimal code generation for __WARN_FLAGS(), while
getting rid of the objtool warning.

We still need barrier_before_unreachable() to work around gcc bugs 82365
and 106751:
- https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
- https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106751

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/include/asm/bug.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 61a4736355c2..ef42adb44aa3 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -99,7 +99,8 @@
 	__label__ __label_warn_on;				\
 								\
 	WARN_ENTRY("twi 31, 0, 0", BUGFLAG_WARNING | (flags), __label_warn_on); \
-	unreachable();						\
+	barrier_before_unreachable();				\
+	__builtin_unreachable();				\
 								\
 __label_warn_on:						\
 	break;							\
-- 
2.31.1

