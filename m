Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C856A6287B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiKNSBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiKNSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:00:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C383286F7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:00:23 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEHXTIi007600;
        Mon, 14 Nov 2022 18:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nDWq7QQBOjmjtNDRoBo0bB4ENp6TlGvH17dZAulBXEs=;
 b=J0k9KWi0wTYqllNNBRewZZf+2ba8EuhlbLWRIWBCmD6hlDoOqvBpQaWdWimIG2emUBr3
 ExStaI2els7rfnQhhTCykJuPPAw6n1mqiBzFFgAAdNMwh1fQ86vT+O/dIwP10YhenWTY
 mebVTT3K2HDw6R99scRA1DY5M/B/3fYT7NVP7TXihangpoJkoXwSf/fnrgPOn5gsork2
 RivW0pNASxkslrWpe2ip2j9QHYQGIPCib87GKiN5okAwmYOHDmaELi/d1Xcxsabjdq2T
 46trZmLB6V1NN9p7ppkUjgUAmTjUNu6eEKZEQGDqKPDOvJEMaxGp/vgPX4R+Apkik4+M hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kut698p8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:00:09 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AEHsjI1030960;
        Mon, 14 Nov 2022 18:00:09 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kut698p6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:00:08 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEHpKgD006774;
        Mon, 14 Nov 2022 18:00:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3kt34925ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:00:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEI03rN8192326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 18:00:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6794F11C050;
        Mon, 14 Nov 2022 18:00:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBBE211C04A;
        Mon, 14 Nov 2022 17:59:58 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.116.246])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 17:59:58 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v6 14/16] objtool: Add arch specific function arch_ftrace_match()
Date:   Mon, 14 Nov 2022 23:27:52 +0530
Message-Id: <20221114175754.1131267-15-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221114175754.1131267-1-sv@linux.ibm.com>
References: <20221114175754.1131267-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2f9Mda7TwWS6Kt_6btlKSVMu1EzxF37p
X-Proofpoint-GUID: XncYFbUyYFnqR2XtcuCI3SVYqNjIhIaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific function to look for relocation records
pointing to architecture specific symbols.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/arch/x86/decode.c      | 5 +++++
 tools/objtool/check.c                | 2 +-
 tools/objtool/include/objtool/arch.h | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 1c253b4b7ce0..af7ad09c926c 100644
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
index 2d7153b5d5d1..7580c66ca5c8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2316,7 +2316,7 @@ static int classify_symbols(struct objtool_file *file)
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

