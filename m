Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16F06197C1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiKDNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKDNYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:24:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CB12EF72
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:24:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A4BSfIn023164;
        Fri, 4 Nov 2022 13:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=CTzZkdYew0DPlHbIGAIp1Rwug3/Dk1a9MVCylGSBae0=;
 b=AgrlF6zhSw/nJLodjO1KQ2Y9I4xtGSz7YmwzicRTw0XbaagaHXO65Iz32++TCarzXYZj
 MbSwLS2icQvSR13khuXgYOnzkmBRzCdWqTExjfG0CFkZvuhRPKtfKacvDZlJYio8CLEp
 LKw3pWQIf9VwSE7EvxV1fUFfD00cs3RlMH91IXhCU8kYsHqT6OYAEPkRTnPF6bi160Z6
 zKSw+whAvKGs5WX5n+J9kEWd6qp/q26gRX6kQqxwlr8L2wIF88plHlkeGTUt2I1FFlTT
 rcaueIA3xQJiduwo/ITxiDjj1HP4+KJkMnA2xPlizrkCXdIRIVDivJURaTcwMglkdBnm cQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmvcm94fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 13:23:58 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4DNw4m006061;
        Fri, 4 Nov 2022 13:23:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 3kkutpq3wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 13:23:58 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A4DNwT4006056;
        Fri, 4 Nov 2022 13:23:58 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 2A4DNvxF006055
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 13:23:58 +0000
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 4 Nov 2022 06:23:55 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <oberpar@linux.ibm.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <trix@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] gcov: clang: fix the buffer overflow issue
Date:   Fri, 4 Nov 2022 18:53:33 +0530
Message-ID: <1667568213-26227-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W2HLgX8w6dP-DCed8a5ghsePI-_KDth9
X-Proofpoint-ORIG-GUID: W2HLgX8w6dP-DCed8a5ghsePI-_KDth9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=869 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in clang version of gcov code when module is getting removed
gcov_info_add() incorrectly adds the sfn_ptr->counter to all the
dst->functions and it result in the kernel panic in below crash report.
Fix this by properly handling it.

[    8.899094][  T599] Unable to handle kernel write to read-only memory at virtual address ffffff80461cc000
[    8.899100][  T599] Mem abort info:
[    8.899102][  T599]   ESR = 0x9600004f
[    8.899103][  T599]   EC = 0x25: DABT (current EL), IL = 32 bits
[    8.899105][  T599]   SET = 0, FnV = 0
[    8.899107][  T599]   EA = 0, S1PTW = 0
[    8.899108][  T599]   FSC = 0x0f: level 3 permission fault
[    8.899110][  T599] Data abort info:
[    8.899111][  T599]   ISV = 0, ISS = 0x0000004f
[    8.899113][  T599]   CM = 0, WnR = 1
[    8.899114][  T599] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000ab8de000
[    8.899116][  T599] [ffffff80461cc000] pgd=18000009ffcde003, p4d=18000009ffcde003, pud=18000009ffcde003, pmd=18000009ffcad003, pte=00600000c61cc787
[    8.899124][  T599] Internal error: Oops: 9600004f [#1] PREEMPT SMP
[    8.899265][  T599] Skip md ftrace buffer dump for: 0x1609e0
....
..,
[    8.899544][  T599] CPU: 7 PID: 599 Comm: modprobe Tainted: G S         OE     5.15.41-android13-8-g38e9b1af6bce #1
[    8.899547][  T599] Hardware name: XXX (DT)
[    8.899549][  T599] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[    8.899551][  T599] pc : gcov_info_add+0x9c/0xb8
[    8.899557][  T599] lr : gcov_event+0x28c/0x6b8
[    8.899559][  T599] sp : ffffffc00e733b00
[    8.899560][  T599] x29: ffffffc00e733b00 x28: ffffffc00e733d30 x27: ffffffe8dc297470
[    8.899563][  T599] x26: ffffffe8dc297000 x25: ffffffe8dc297000 x24: ffffffe8dc297000
[    8.899566][  T599] x23: ffffffe8dc0a6200 x22: ffffff880f68bf20 x21: 0000000000000000
[    8.899569][  T599] x20: ffffff880f68bf00 x19: ffffff8801babc00 x18: ffffffc00d7f9058
[    8.899572][  T599] x17: 0000000000088793 x16: ffffff80461cbe00 x15: 9100052952800785
[    8.899575][  T599] x14: 0000000000000200 x13: 0000000000000041 x12: 9100052952800785
[    8.899577][  T599] x11: ffffffe8dc297000 x10: ffffffe8dc297000 x9 : ffffff80461cbc80
[    8.899580][  T599] x8 : ffffff8801babe80 x7 : ffffffe8dc2ec000 x6 : ffffffe8dc2ed000
[    8.899583][  T599] x5 : 000000008020001f x4 : fffffffe2006eae0 x3 : 000000008020001f
[    8.899586][  T599] x2 : ffffff8027c49200 x1 : ffffff8801babc20 x0 : ffffff80461cb3a0
[    8.899589][  T599] Call trace:
[    8.899590][  T599]  gcov_info_add+0x9c/0xb8
[    8.899592][  T599]  gcov_module_notifier+0xbc/0x120
[    8.899595][  T599]  blocking_notifier_call_chain+0xa0/0x11c
[    8.899598][  T599]  do_init_module+0x2a8/0x33c
[    8.899600][  T599]  load_module+0x23cc/0x261c
[    8.899602][  T599]  __arm64_sys_finit_module+0x158/0x194
[    8.899604][  T599]  invoke_syscall+0x94/0x2bc
[    8.899607][  T599]  el0_svc_common+0x1d8/0x34c
[    8.899609][  T599]  do_el0_svc+0x40/0x54
[    8.899611][  T599]  el0_svc+0x94/0x2f0
[    8.899613][  T599]  el0t_64_sync_handler+0x88/0xec
[    8.899615][  T599]  el0t_64_sync+0x1b4/0x1b8
[    8.899618][  T599] Code: f905f56c f86e69ec f86e6a0f 8b0c01ec (f82e6a0c)
[    8.899620][  T599] ---[ end trace ed5218e9e5b6e2e6 ]---

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/gcov/clang.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index cbb0bed..0aabb9a 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -271,15 +271,20 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
  */
 void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
 {
-	struct gcov_fn_info *dfn_ptr;
-	struct gcov_fn_info *sfn_ptr = list_first_entry_or_null(&src->functions,
-			struct gcov_fn_info, head);
+	struct gcov_fn_info *sfn_ptr;
+	struct gcov_fn_info *dfn_ptr = list_first_entry_or_null(
+			&dst->functions, struct gcov_fn_info, head);
 
-	list_for_each_entry(dfn_ptr, &dst->functions, head) {
+	list_for_each_entry(sfn_ptr, &src->functions, head) {
 		u32 i;
 
+		if (!dfn_ptr)
+			return;
+
 		for (i = 0; i < sfn_ptr->num_counters; i++)
 			dfn_ptr->counters[i] += sfn_ptr->counters[i];
+
+		dfn_ptr = list_next_entry(dfn_ptr, head);
 	}
 }
 
-- 
2.7.4

