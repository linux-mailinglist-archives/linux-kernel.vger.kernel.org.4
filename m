Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505C95F22B3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJBKpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 06:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJBKo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 06:44:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0DCD52
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 03:44:34 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29298Ltb026598;
        Sun, 2 Oct 2022 10:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HlIWah+UUHq9SUa0rbY/ZhI2MEjFKo4f0r/nmY/tjXM=;
 b=jbAShfaU+B7YyWra9CkgAusuQXASYTl6Irm92lLGp5E2F83AvmqsXZfdQwWBnFTmVaEj
 UeQ+SdJc4a2XiKr5hQ1K719c2IcLjCFX0Nj6YvGWZHN3/Mcfnj7+TysxRivsm8SgCroJ
 Gs+5KbAT15ZiGmUPQljpFnVcPN/MKFVlMnAlNRY+/CV7SCXJVZVy+0LhlTx7yLdFBDjp
 7Epf1mJhaoEoXys4a4oNyMHo571fjfE0JPtpcbmYBdzzonszvGG1zg9Y5bc4+xcycLoR
 oLuxvR//6FIQFx0PKxaT7np2HBD1pPVu0JWNMSxQyPaSnKJSB6wmrfcA3wnULaSd6g8N Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jxyhg17ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Oct 2022 10:44:21 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 292Ah0Yl034373;
        Sun, 2 Oct 2022 10:44:20 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jxyhg17my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Oct 2022 10:44:20 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 292AaFkl022941;
        Sun, 2 Oct 2022 10:44:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3jxd691arb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Oct 2022 10:44:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 292AiFKv63832548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 2 Oct 2022 10:44:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 943F05204F;
        Sun,  2 Oct 2022 10:44:15 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.71.20])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 452BB5204E;
        Sun,  2 Oct 2022 10:44:11 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v4 10/16] objtool: Use target file class size instead of a compiled constant
Date:   Sun,  2 Oct 2022 16:12:34 +0530
Message-Id: <20221002104240.1316480-11-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221002104240.1316480-1-sv@linux.ibm.com>
References: <20221002104240.1316480-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZNqJoRaa98qndlyAwUuSSnukcAzAXToW
X-Proofpoint-ORIG-GUID: v2T52r4nVJzN3GQQwWJN_6pvCKHOkOO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_15,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxlogscore=947 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210020068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

In order to allow using objtool on cross-built kernels,
determine size of long from elf data instead of using
sizeof(long) at build time.

For the time being this covers only mcount.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
[Sathvika Vasireddy: Rename variable "size" to "addrsize" and function
"elf_class_size()" to "elf_class_addrsize()", and modify
create_mcount_loc_sections() function to follow reverse christmas tree
format to order local variable declarations.]
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/check.c               | 18 ++++++++++--------
 tools/objtool/elf.c                 |  8 ++++++--
 tools/objtool/include/objtool/elf.h |  8 ++++++++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c36e7a020d80..738de23cb9e8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -852,9 +852,9 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
-	struct section *sec;
-	unsigned long *loc;
+	int addrsize = elf_class_addrsize(file->elf);
 	struct instruction *insn;
+	struct section *sec;
 	int idx;
 
 	sec = find_section_by_name(file->elf, "__mcount_loc");
@@ -871,23 +871,25 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned long), idx);
+	sec = elf_create_section(file->elf, "__mcount_loc", 0, addrsize, idx);
 	if (!sec)
 		return -1;
 
+	sec->sh.sh_addralign = addrsize;
+
 	idx = 0;
 	list_for_each_entry(insn, &file->mcount_loc_list, call_node) {
+		void *loc;
 
-		loc = (unsigned long *)sec->data->d_buf + idx;
-		memset(loc, 0, sizeof(unsigned long));
+		loc = sec->data->d_buf + idx;
+		memset(loc, 0, addrsize);
 
-		if (elf_add_reloc_to_insn(file->elf, sec,
-					  idx * sizeof(unsigned long),
+		if (elf_add_reloc_to_insn(file->elf, sec, idx,
 					  R_X86_64_64,
 					  insn->sec, insn->offset))
 			return -1;
 
-		idx++;
+		idx += addrsize;
 	}
 
 	return 0;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c25e957c1e52..40c6d53b081f 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1124,6 +1124,7 @@ static struct section *elf_create_rela_reloc_section(struct elf *elf, struct sec
 {
 	char *relocname;
 	struct section *sec;
+	int addrsize = elf_class_addrsize(elf);
 
 	relocname = malloc(strlen(base->name) + strlen(".rela") + 1);
 	if (!relocname) {
@@ -1133,7 +1134,10 @@ static struct section *elf_create_rela_reloc_section(struct elf *elf, struct sec
 	strcpy(relocname, ".rela");
 	strcat(relocname, base->name);
 
-	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rela), 0);
+	if (addrsize == sizeof(u32))
+		sec = elf_create_section(elf, relocname, 0, sizeof(Elf32_Rela), 0);
+	else
+		sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rela), 0);
 	free(relocname);
 	if (!sec)
 		return NULL;
@@ -1142,7 +1146,7 @@ static struct section *elf_create_rela_reloc_section(struct elf *elf, struct sec
 	sec->base = base;
 
 	sec->sh.sh_type = SHT_RELA;
-	sec->sh.sh_addralign = 8;
+	sec->sh.sh_addralign = addrsize;
 	sec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
 	sec->sh.sh_info = base->idx;
 	sec->sh.sh_flags = SHF_INFO_LINK;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 16f4067b82ae..78b3aa2e546d 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -142,6 +142,14 @@ static inline bool has_multiple_files(struct elf *elf)
 	return elf->num_files > 1;
 }
 
+static inline int elf_class_addrsize(struct elf *elf)
+{
+	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
+		return sizeof(u32);
+	else
+		return sizeof(u64);
+}
+
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
-- 
2.31.1

