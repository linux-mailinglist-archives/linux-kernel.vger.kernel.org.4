Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8685E72CB01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjFLQH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFLQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:07:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E64187
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:07:55 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CFprtR010773;
        Mon, 12 Jun 2023 16:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5LHI5t0StJcJrbHOtOpufQOCNbXC/Bb5sjF/Qx21CiQ=;
 b=toe3rVYt7CvozLKS4tCQ9kMNnEBbuqwyt142XMc9+OftOfB4ZrNV/olWoCLU4D2IJc5l
 +56DU7CymIcA5qiDA1IAjB9X1E3Y4HWT7WFNN0BSlnsJMMPTBBJBJUGqQcrBQ4WldfcJ
 s6dQF3SWBi1FMKwzLJ18AT9sOZ3PtWTazDlfkKH9swbr00wH2Q8GQ4JceV0VsQFk86Il
 nsaE8q9hN0HaQgwZPsxRk+7LuFUTyoZ7lYYE3ViUm0k2x/xrp+je0Qyi9YX+FLR5sKjA
 zM+InFVFUungmByZT5+EDcncyR2R/mfO//UPFOUgT9mBGa7EEoGe/LoiVYhtB3Q+h2rg bQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r66cn0gyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 16:07:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35C1mpvR017394;
        Mon, 12 Jun 2023 16:07:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r4gee1kh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 16:07:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CG7nRO21365484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 16:07:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42A562004F;
        Mon, 12 Jun 2023 16:07:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32BB02004E;
        Mon, 12 Jun 2023 16:07:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 12 Jun 2023 16:07:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id E8A17E12CB; Mon, 12 Jun 2023 18:07:48 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix memcpy size when copying stack entries
Date:   Mon, 12 Jun 2023 18:07:48 +0200
Message-Id: <20230612160748.4082850-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -wj8A83xApT9KRWtwZj54Y5oaG279GPw
X-Proofpoint-ORIG-GUID: -wj8A83xApT9KRWtwZj54Y5oaG279GPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 mlxlogscore=848
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120138
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed the following warning during boot:

[    2.316341] Testing tracer wakeup:
[    2.383512] ------------[ cut here ]------------
[    2.383517] memcpy: detected field-spanning write (size 104) of single field "&entry->caller" at kernel/trace/trace.c:3167 (size 64)

The reason seems to be that the maximum number of entries is calculated
from the size of the fstack->calls array which is 128. But later the same
size is used to memcpy() the entries to entry->callers, which has only
room for eight elements. Therefore use the minimum of both arrays as limit.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 64a4dde073ef..988d664c13ec 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3146,7 +3146,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	barrier();
 
 	fstack = this_cpu_ptr(ftrace_stacks.stacks) + stackidx;
-	size = ARRAY_SIZE(fstack->calls);
+	size = min(ARRAY_SIZE(entry->caller), ARRAY_SIZE(fstack->calls));
 
 	if (regs) {
 		nr_entries = stack_trace_save_regs(regs, fstack->calls,
-- 
2.39.2

