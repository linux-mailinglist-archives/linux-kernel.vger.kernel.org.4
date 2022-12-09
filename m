Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA69647D90
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLIGIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:08:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D00801DC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 22:08:17 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B94mJ1H026310;
        Fri, 9 Dec 2022 06:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=n26JXWuIL0Cc2+Ws1zdvTJ3r1ZE7iGezxFyFGf7Pb/Q=;
 b=BprFmqpA6OiCf892PzVBl2Ysz0GiKuo0cvyLPh2Dj8hhbl+I3tJA5D+eUjB940V16anS
 gRiTEF143StHE7H77fVrFNMsfCmuxdg2NyQLtve3B9ykgi8ruldqKuGuRD/rzFNI08ds
 5bp04vrWeVcf6FKlNNwpqWMHPyJPQ6dmfgU92LyDqrXpQKadWOJdTi9wqw1B/ON0vSBK
 UZtZynu8lrbnJvkZ1sRoU+pspIKG0Up9cXp3HNIpp31JxwKR+4AwGugXC7RIg/vfaJML
 EIs06ooDXtuwJG18WmNmCli7VK00hU6fbpQGcqwoJhcDnpVRhT61AFOPNVDQi7hzEJEx 2w== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbxak9fgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 06:07:46 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8DGqBa002539;
        Fri, 9 Dec 2022 06:07:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3m9mb242de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 06:07:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B967eQm45810096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 06:07:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E9582004B;
        Fri,  9 Dec 2022 06:07:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DA9320043;
        Fri,  9 Dec 2022 06:07:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 06:07:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 2F8C4E027E; Fri,  9 Dec 2022 07:07:40 +0100 (CET)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] jump_label: explicitly annotate inittext labels as init
Date:   Fri,  9 Dec 2022 07:07:40 +0100
Message-Id: <20221209060740.2785164-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9b4LnyhgRxdOnNjqVQ84JJrDLYgQsTZ2
X-Proofpoint-ORIG-GUID: 9b4LnyhgRxdOnNjqVQ84JJrDLYgQsTZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_02,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxlogscore=879 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inittext code may be out of [__init_begin, __init_end]
range on some architectures. Yet, the jump_label_init()
only calls init_section_contains() function to check if
a label needs to be annotated as init and inittext code
is left behind.

Fixes: 19483677684b ("jump_label: Annotate entries that operate on __init code earlier")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 kernel/jump_label.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 714ac4c3b556..77680665d374 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -481,13 +481,16 @@ void __init jump_label_init(void)
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
 		struct static_key *iterk;
+		unsigned long addr;
 		bool in_init;
 
 		/* rewrite NOPs */
 		if (jump_label_type(iter) == JUMP_LABEL_NOP)
 			arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
 
-		in_init = init_section_contains((void *)jump_entry_code(iter), 1);
+		addr = jump_entry_code(iter);
+		in_init = init_section_contains((void *)addr, 1) ||
+			  is_kernel_inittext(addr);
 		jump_entry_set_init(iter, in_init);
 
 		iterk = jump_entry_key(iter);
-- 
2.34.1

