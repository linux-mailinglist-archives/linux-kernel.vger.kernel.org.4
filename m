Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EECA64DAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLOLxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLOLxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:53:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83FA1CB0D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:53:48 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFBhqT1027378;
        Thu, 15 Dec 2022 11:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KMsyXNo4wrG3JGbanD30ONjK9LdvZThpq8x1OMRG4uU=;
 b=WPnD+sOi0KDK17JKV18Fqo6Z6CzLukIQ5bCrxwE2mNTKgurFZNkY8qzCBGckxBTM5e9W
 oBzpe6otvDpb1zxabQuI6Rbuy2qTl0b1yIHlG/grEYEEJim1r+/vtE2lsJJhmz+veylJ
 +8J09sEJnnSRRExr8lVSD7fd5hEaw+Ac3BOGctfWIISmus51Vh0EcLPNFtmfR9RVI+Eg
 y7pnF8ecx2ELa1W4xJj8TLsZImxf7k9w7qAOXnVW1DbsSwUIyfV3OXWTZ8zSwOsUmSql
 5W7OKLDOztTSeeCMbwGjogpD9T86bxh95q2bYiS7BJeSwgNPbA+Oc48bnMLiz40gUYYa 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg2ydg5kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 11:53:10 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BFBr9iF019169;
        Thu, 15 Dec 2022 11:53:10 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg2ydg5jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 11:53:09 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF3WsuK004709;
        Thu, 15 Dec 2022 11:53:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3meyqy26gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 11:53:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BFBr4Df32899430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 11:53:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D53A320040;
        Thu, 15 Dec 2022 11:53:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75F3320049;
        Thu, 15 Dec 2022 11:53:01 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.in.ibm.com (unknown [9.109.198.229])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Dec 2022 11:53:01 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, aik@ozlabs.ru,
        mpe@ellerman.id.au, mingo@redhat.com, christophe.leroy@csgroup.eu,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        sfr@canb.auug.org.au, naveen.n.rao@linux.vnet.ibm.com,
        sv@linux.ibm.com
Subject: [PATCH] powerpc/32: Curb objtool unannotated intra-function call warning
Date:   Thu, 15 Dec 2022 17:22:58 +0530
Message-Id: <20221215115258.80810-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gl-UhVaEhy6ypk6gAQVSYI9QrfNV9cqq
X-Proofpoint-GUID: VrzvWT3dZ9Izk71RqyGQGcFCZXugUM3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 mlxlogscore=923 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objtool throws the following warning:
arch/powerpc/kexec/relocate_32.o: warning: objtool: .text+0x2bc: unannotated intra-function call

Fix this warning by annotating intra-function call, using
ANNOTATE_INTRA_FUNCTION_CALL macro, to indicate that the branch target
is valid.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/kexec/relocate_32.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kexec/relocate_32.S b/arch/powerpc/kexec/relocate_32.S
index d9f0dd9b34ff..104c9911f406 100644
--- a/arch/powerpc/kexec/relocate_32.S
+++ b/arch/powerpc/kexec/relocate_32.S
@@ -8,6 +8,7 @@
  * 		Author: Suzuki Poulose <suzuki@in.ibm.com>
  */
 
+#include <linux/objtool.h>
 #include <asm/reg.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -349,6 +350,7 @@ write_utlb:
 	cmpwi	r10, PPC47x_TLB0_4K
 	bne	0f
 	li	r10, 0x1000			/* r10 = 4k */
+	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	1f
 
 0:
-- 
2.31.1

