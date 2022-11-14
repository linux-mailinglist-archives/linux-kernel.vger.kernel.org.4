Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367A96287AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiKNR74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiKNR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:59:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0734F26493
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:59:25 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEHklVA024432;
        Mon, 14 Nov 2022 17:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dyBUghkUThVFOwVmwP0oyNuWsyG4cQuJB7pPMLa1lk0=;
 b=PDuH617xqgC1q1DFbr+3rDsnd+cGHZrB/10aLhpOpiOFkhe+mfl2U8/TVwlUO280gACh
 UG/ZW3Gt39MLOo2DdyB2htbxy+vqdFDE0KkMTN06PVZS08ql8bXetX18byYeotf4O/vN
 bdz7GLb/LbXz87AyIBl55ey2SyMBPUn8aLjCDbRem4esqt1kH+Hol92oVfBU8knbTeY0
 +Sff2V4SwExuf9wO+5FH3yay4hYvMHh4Trku6r8T6RQKxwW/IzWJkA0xoW40JKGWjNZ0
 GYl/+Zo1fZ7vUaYxrDgYEkIg6vgZQXNhfQ+Ds+BqpWmHKxUewId9l1DZHauwqUUd48yc wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kutcbgapd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 17:59:10 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AEHknNY024505;
        Mon, 14 Nov 2022 17:59:10 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kutcbgan1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 17:59:09 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEHoeGu004448;
        Mon, 14 Nov 2022 17:59:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3kt348tyaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 17:59:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEHr9GR45547796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 17:53:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F2B911C054;
        Mon, 14 Nov 2022 17:59:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72BC811C052;
        Mon, 14 Nov 2022 17:59:00 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.116.246])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 17:59:00 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v6 05/16] powerpc: Skip objtool from running on drivers/crypto/vmx/aesp8-ppc.o
Date:   Mon, 14 Nov 2022 23:27:43 +0530
Message-Id: <20221114175754.1131267-6-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221114175754.1131267-1-sv@linux.ibm.com>
References: <20221114175754.1131267-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a5yoemNlYmPkuCY9z0ZShjYKpSU9M-2f
X-Proofpoint-GUID: -tkHoaPVU2D-XwC6mKsgEbYF7xOexBF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
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

With objtool enabled, below warnings are seen when trying to build:
drivers/crypto/vmx/aesp8-ppc.o: warning: objtool: aes_p8_set_encrypt_key+0x44: unannotated intra-function call
drivers/crypto/vmx/aesp8-ppc.o: warning: objtool: .text+0x2448: unannotated intra-function call
drivers/crypto/vmx/aesp8-ppc.o: warning: objtool: .text+0x2d68: unannotated intra-function call

Skip objtool from running on drivers/crypto/vmx/aesp8-ppc.o file for the
following reasons:

- Since this file comes from OpenSSL, and since it is a perl file which
  generates a .S file, it may not be the best choice to make too many
  code changes to such files, unless absolutely necessary.

- As far as the objtool --mcount functionality is concerned, we do not
  have to run objtool on this file because there are no calls to
  _mcount.

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 drivers/crypto/vmx/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
index 2560cfea1dec..7b41f0da6807 100644
--- a/drivers/crypto/vmx/Makefile
+++ b/drivers/crypto/vmx/Makefile
@@ -9,3 +9,5 @@ targets += aesp8-ppc.S ghashp8-ppc.S
 
 $(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S: $(obj)/%.S: $(src)/%.pl FORCE
 	$(call if_changed,perl)
+
+OBJECT_FILES_NON_STANDARD_aesp8-ppc.o := y
-- 
2.31.1

