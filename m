Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960BF5B55EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiILIW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiILIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526FD2DA93
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:17 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28C8C3tr029599;
        Mon, 12 Sep 2022 08:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TaPMOj5i5T7nsgHq4rawF1xYU+uBmpQvWTWCTPedx3c=;
 b=QkQ9Cd25XNwp0S8eWIcoAZzB6sx3v21GnzlqSf6CTrMuHkZ9fz6zFW6lnUv4cRePF3T+
 Y79NvrLkz2bq+7l404q4RJUp2g2V9nbAf+ELlbDQ00rbUln6z00nxkTsJd3LbK2XvxZt
 DIqpChfOj2tBC+3UWmLuo5VP/vEPKZoP9zbgSu8k7TSbGioXYc6pOwSYym4nU48jdKbI
 reP7/47v/p7Prli1/JZvUrIyryMjuLLDaYu9j75rRDPSM+7TH5xO1DkxW61R9LfnFU/V
 O4ctfymp+mKsxy9Cry8P9G36TG4AxeGeG0/MCgbGS7T/6kNEmz8DIqrLCUgZ85SYKqZ/ TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jj11v88vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:21:51 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28C8DC79003343;
        Mon, 12 Sep 2022 08:21:50 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jj11v88ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:21:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28C86PrB002695;
        Mon, 12 Sep 2022 08:21:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3jgj78sh31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:21:48 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28C8Lj6q36110776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 08:21:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63E2BA4040;
        Mon, 12 Sep 2022 08:21:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11874A4051;
        Mon, 12 Sep 2022 08:21:41 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.91.220])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Sep 2022 08:21:40 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v3 13/16] objtool: Use macros to define arch specific reloc types
Date:   Mon, 12 Sep 2022 13:50:17 +0530
Message-Id: <20220912082020.226755-14-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220912082020.226755-1-sv@linux.ibm.com>
References: <20220912082020.226755-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N1GHDKTLTrHZp0kJ--kiRmaEmd32x8H0
X-Proofpoint-ORIG-GUID: POESi89yT42zxLejql2TE9RsgJiBQNxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=929 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120027
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make relocation types architecture specific.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/arch/x86/include/arch/elf.h | 2 ++
 tools/objtool/check.c                     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/include/arch/elf.h b/tools/objtool/arch/x86/include/arch/elf.h
index 69cc4264b28a..ac14987cf687 100644
--- a/tools/objtool/arch/x86/include/arch/elf.h
+++ b/tools/objtool/arch/x86/include/arch/elf.h
@@ -2,5 +2,7 @@
 #define _OBJTOOL_ARCH_ELF
 
 #define R_NONE R_X86_64_NONE
+#define R_ABS64 R_X86_64_64
+#define R_ABS32 R_X86_64_32
 
 #endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6457dac6d58..35bcd4f90acd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -885,7 +885,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		memset(loc, 0, addrsize);
 
 		if (elf_add_reloc_to_insn(file->elf, sec, idx,
-					  R_X86_64_64,
+					  addrsize == sizeof(u64) ? R_ABS64 : R_ABS32,
 					  insn->sec, insn->offset))
 			return -1;
 
-- 
2.31.1

