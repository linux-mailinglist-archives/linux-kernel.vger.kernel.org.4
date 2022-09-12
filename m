Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1855B55F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiILIXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiILIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4192DA92
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:16 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28C7pkuE032555;
        Mon, 12 Sep 2022 08:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1rvSf2iuCLnoiJcot/xjG5iRWVtDFPUxk3p0Us2WnjM=;
 b=cSkq/qfYcT7CmlZKpGntGgaEa/JjHIcQ6Sq5nxLyOvz+vhNGX4c/pmgt91dBQbQfCB3g
 jga/F9MqB8tMpHIzY7Zz3RqJXYKPgbMC7gX/R37CSr66DwnPCQuhZ8WShcym0B4A8pUn
 /izkvLIp3kjVBEfgerQIqnIouGEDpxHLy7cJ/9YQ2vPvO7iIbngAcqc7RQ23TKcxEEZN
 GTbmuLTZ9WKY5oa+OM853s7ffIFyleBlqKnbL64/UJ3A60R7D/cbMxtRsDQ1uEzb21h/
 3zoI4Fs/m2NQHsiEpkxhzcRhcJEBjNWCgkpgsZeCHpxOiQ4rO3we+rOEWX+bKe+kmbXW 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jj0rk8trt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:21:56 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28C7qjms002620;
        Mon, 12 Sep 2022 08:21:56 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jj0rk8tqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:21:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28C86mVG015977;
        Mon, 12 Sep 2022 08:21:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jgj79j34e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 08:21:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28C8Lp3W32702778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 08:21:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D3E0A4040;
        Mon, 12 Sep 2022 08:21:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A868DA404D;
        Mon, 12 Sep 2022 08:21:46 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.91.220])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Sep 2022 08:21:46 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v3 14/16] objtool: Add arch specific function arch_ftrace_match()
Date:   Mon, 12 Sep 2022 13:50:18 +0530
Message-Id: <20220912082020.226755-15-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220912082020.226755-1-sv@linux.ibm.com>
References: <20220912082020.226755-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r8aF57cHTStbYvyl4J9GNBRjxH_A3a1e
X-Proofpoint-ORIG-GUID: bZDpfdYT08XdDhQj3BuZXJvci6Nv9i94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120027
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific function to look for relocation records
pointing to architecture specific symbols.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/arch/x86/decode.c      | 5 +++++
 tools/objtool/check.c                | 2 +-
 tools/objtool/include/objtool/arch.h | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c260006106be..28263e231c58 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -23,6 +23,11 @@
 #include <objtool/builtin.h>
 #include <arch/elf.h>
 
+int arch_ftrace_match(char *name)
+{
+	return !strcmp(name, "__fentry__");
+}
+
 static int is_x86_64(const struct elf *elf)
 {
 	switch (elf->ehdr.e_machine) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 35bcd4f90acd..856ea80b1cfc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2296,7 +2296,7 @@ static int classify_symbols(struct objtool_file *file)
 			if (arch_is_rethunk(func))
 				func->return_thunk = true;
 
-			if (!strcmp(func->name, "__fentry__"))
+			if (arch_ftrace_match(func->name))
 				func->fentry = true;
 
 			if (is_profiling_func(func->name))
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index beb2f3aa94ff..5149330f400f 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -69,6 +69,8 @@ struct stack_op {
 
 struct instruction;
 
+int arch_ftrace_match(char *name);
+
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
-- 
2.31.1

