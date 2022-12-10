Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B1648D5B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 07:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLJGSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 01:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLJGSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 01:18:48 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2FEE65
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 22:18:47 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BA4WPfm003298;
        Sat, 10 Dec 2022 06:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UQbTlOAFf8/nNDGREd/o6pN+2MjJGXKNUTTYkUOv9XI=;
 b=GO04eUGZla5/YfIa3DszWaog53hvpRUMcRdV0kHvkQTJBl6rZqNcX64nvfF5g7gXPQ67
 t4xDjAEp3Ih1WunpWJcK2Lrm5hd/NQ5SiDdirFBTZ/KueiW+CAer51t9ISZK/ZP2iXAl
 EBg46VNU54k7A8CfHkhsarobaUXQgvK6y3bOYpGkaJ/n+E7BoFA9qUaZSVTg0pzXqsFc
 34UfN5Qqy3U99iTsGMmxAcv3wfvnIp9nGizrO4OpB5addzMtNnWn96cJOoN9wjabZvS3
 eljgVBUWfAr8AS8Vq0G1W7DZekKX08jsC8naZdMOi4PE2zs+Yq+KnVTCtKd5FO+tPBUv NQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mcjky9tdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 06:18:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BA4Kntx007894;
        Sat, 10 Dec 2022 06:18:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mchcf05pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 06:18:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BA6IGZp50528694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Dec 2022 06:18:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FD1120043;
        Sat, 10 Dec 2022 06:18:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F20520040;
        Sat, 10 Dec 2022 06:18:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 10 Dec 2022 06:18:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id E9A13E0801; Sat, 10 Dec 2022 07:18:15 +0100 (CET)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2] jump_label: explicitly annotate inittext labels as init
Date:   Sat, 10 Dec 2022 07:18:15 +0100
Message-Id: <20221210061815.3140317-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ZY0L2kWHOqUTOSyFzAE1Vt-xEzxU8CP
X-Proofpoint-ORIG-GUID: 4ZY0L2kWHOqUTOSyFzAE1Vt-xEzxU8CP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-10_02,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=776 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212100052
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
could be left behind.

By contrast, checking whether a jump_label belongs to
the inittext code is enough.

Fixes: 19483677684b ("jump_label: Annotate entries that operate on __init code earlier")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 kernel/jump_label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 714ac4c3b556..7a20879b54dd 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -487,7 +487,7 @@ void __init jump_label_init(void)
 		if (jump_label_type(iter) == JUMP_LABEL_NOP)
 			arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
 
-		in_init = init_section_contains((void *)jump_entry_code(iter), 1);
+		in_init = is_kernel_inittext(jump_entry_code(iter));
 		jump_entry_set_init(iter, in_init);
 
 		iterk = jump_entry_key(iter);
-- 
2.34.1

