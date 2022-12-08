Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4A6469B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiLHH3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiLHH3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:29:12 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEBF442E8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 23:29:07 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B87EACK032204;
        Thu, 8 Dec 2022 07:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/vWbz5KhwgjEw42c2phzV4dm5XkZc5kuH6Tqe0s+h0c=;
 b=A+Hm7Lbp45WoV2HBnIntToDBO6gpi7SIeFijdqeOUiO8u9Z0c9uEQCxUTrK1u7lD4tyf
 2BOMCJ6HxKuwobYJLmq+nqQdzGc+pj4VcbwkY/5fiNP/2+yr0HE2OzIFcVQ9/APUpDTl
 BYm2a4YmwIFtQ3jEfW69G0Yav1ZvOItKeDpJssW+yaItcudjCvxrIQjvB1KZXaak5RrD
 BFamFf0rDfFHzHkqja504o9rc5w62CsSjeGmxdaSc/vsgfVt8FRnuP4ny45JWc7vOea0
 FrC3rZv0DIm/2ibPW5qInOiaAgGdPo8RYzS/lFDAUeU1lhRvMvYlsOYpLoscv7HOfZoy rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbbbpg8pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 07:28:25 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B87HPAG001175;
        Thu, 8 Dec 2022 07:28:24 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbbbpg8nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 07:28:24 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B7HHdrP018440;
        Thu, 8 Dec 2022 07:28:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3m9m7raxaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 07:28:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B87SK4K40894962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Dec 2022 07:28:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4207F20043;
        Thu,  8 Dec 2022 07:28:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1DFE20040;
        Thu,  8 Dec 2022 07:28:16 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.in.ibm.com (unknown [9.109.198.140])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  8 Dec 2022 07:28:16 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, aik@ozlabs.ru,
        mpe@ellerman.id.au, mingo@redhat.com, christophe.leroy@csgroup.eu,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        sfr@canb.auug.org.au, naveen.n.rao@linux.vnet.ibm.com,
        sv@linux.ibm.com
Subject: [PATCH] objtool: continue if find_insn() fails in decode_instructions()
Date:   Thu,  8 Dec 2022 12:58:13 +0530
Message-Id: <20221208072813.25799-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AySpy7Cdu0YWMaH4C-tvSb10BlArRF6k
X-Proofpoint-ORIG-GUID: YHdJbgeL6N5dvbpLGt1TXBw6vcAR7tIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_04,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, decode_instructions() is failing if it is not able to find
instruction, and this is happening since commit dbcdbdfdf137b4
("objtool: Rework instruction -> symbol mapping") because it is
expecting instruction for STT_NOTYPE symbols.

Due to this, the following objtool warnings are seen:
 [1] arch/powerpc/kernel/optprobes_head.o: warning: objtool: optprobe_template_end(): can't find starting instruction
 [2] arch/powerpc/kernel/kvm_emul.o: warning: objtool: kvm_template_end(): can't find starting instruction
 [3] arch/powerpc/kernel/head_64.o: warning: objtool: end_first_256B(): can't find starting instruction

The warnings are thrown because find_insn() is failing for symbols that
are at the end of the file, or at the end of the section. Given how
STT_NOTYPE symbols are currently handled in decode_instructions(),
continue if the instruction is not found, instead of throwing warning
and returning.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/check.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4350be739f4f..bce2be5ebf36 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -430,11 +430,8 @@ static int decode_instructions(struct objtool_file *file)
 			if (func->return_thunk || func->alias != func)
 				continue;
 
-			if (!find_insn(file, sec, func->offset)) {
-				WARN("%s(): can't find starting instruction",
-				     func->name);
-				return -1;
-			}
+			if (!find_insn(file, sec, func->offset))
+				continue;
 
 			sym_for_each_insn(file, func, insn) {
 				insn->sym = func;
-- 
2.31.1

