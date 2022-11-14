Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD76287C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiKNSCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiKNSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:01:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AE12AC5E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:00:36 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEHnEA9036434;
        Mon, 14 Nov 2022 18:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UtGwYCsSM0mcJ+jDU77Z0rdFYcWowm7LUk5Kym9Ox/M=;
 b=GNp9VIiXHd9RK0FcA0fuN+V8LvbS+f4DP3SOm2/QBW+7MqeN40xC/1MrQeXhXTTygPxe
 Rkc2T7TWuGzZXMBKuPcIqWHI/gL6oUT7ITOEqsfUqsl1mFMbrCOH++DeQbu6oSmn0bYV
 9dOU1F5esWNdpvSCJGLXll+GvUB9K/6B7YpFjlNsEMo2qQ/E6kVDD/ZHPYxTbksw94zh
 xnwrtOr+vSxxwARNXxZgu033Z3+cfb5FAldamdHLkHP+0js70GqKOE5C+1FRjqmo1pqD
 o2TtyMkKRddGejI6w6GUf+1Ey19pWU78/Mj3ZaGPnXegOfC9BwNkiRZvNQpYul8XU/s0 Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kutdp08m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:00:22 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AEHq1vx007480;
        Mon, 14 Nov 2022 18:00:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kutdp08ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:00:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEHoaUL004436;
        Mon, 14 Nov 2022 18:00:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kt348tydu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:00:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEI0GA07340664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 18:00:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BABA111C04C;
        Mon, 14 Nov 2022 18:00:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FE7B11C052;
        Mon, 14 Nov 2022 18:00:11 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.116.246])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 18:00:11 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v6 16/16] objtool/powerpc: Add --mcount specific implementation
Date:   Mon, 14 Nov 2022 23:27:54 +0530
Message-Id: <20221114175754.1131267-17-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221114175754.1131267-1-sv@linux.ibm.com>
References: <20221114175754.1131267-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KMmWB0lAw2IpK5Z-gzV9W2Ibce_BujOf
X-Proofpoint-GUID: PL5kgp21H86HVBSpwx9c3DhYN-s_8kYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables objtool --mcount on powerpc, and adds implementation
specific to powerpc.

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/Kconfig                          |  1 +
 tools/objtool/arch/powerpc/decode.c           | 16 ++++++++++++++++
 tools/objtool/arch/powerpc/include/arch/elf.h |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 82e3e5e175ae..170a3a354a4a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -240,6 +240,7 @@ config PPC
 	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
 	select HAVE_OPTPROBES
 	select HAVE_OBJTOOL			if PPC32 || MPROFILE_KERNEL
+	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index dcd0975cad6b..01cade98b49e 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -9,6 +9,11 @@
 #include <objtool/builtin.h>
 #include <objtool/endianness.h>
 
+int arch_ftrace_match(char *name)
+{
+	return !strcmp(name, "_mcount");
+}
+
 unsigned long arch_dest_reloc_offset(int addend)
 {
 	return addend;
@@ -50,6 +55,17 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	typ = INSN_OTHER;
 	imm = 0;
 
+	switch (opcode) {
+	case 18: /* b[l][a] */
+		if ((insn & 3) == 1) /* bl */
+			typ = INSN_CALL;
+
+		imm = insn & 0x3fffffc;
+		if (imm & 0x2000000)
+			imm -= 0x4000000;
+		break;
+	}
+
 	if (opcode == 1)
 		*len = 8;
 	else
diff --git a/tools/objtool/arch/powerpc/include/arch/elf.h b/tools/objtool/arch/powerpc/include/arch/elf.h
index 3c8ebb7d2a6b..73f9ae172fe5 100644
--- a/tools/objtool/arch/powerpc/include/arch/elf.h
+++ b/tools/objtool/arch/powerpc/include/arch/elf.h
@@ -4,5 +4,7 @@
 #define _OBJTOOL_ARCH_ELF
 
 #define R_NONE R_PPC_NONE
+#define R_ABS64 R_PPC64_ADDR64
+#define R_ABS32 R_PPC_ADDR32
 
 #endif /* _OBJTOOL_ARCH_ELF */
-- 
2.31.1

