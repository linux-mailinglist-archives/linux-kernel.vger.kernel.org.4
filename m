Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB426696317
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjBNMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjBNMHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:07:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECE66EA6;
        Tue, 14 Feb 2023 04:07:13 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E8MA2x018253;
        Tue, 14 Feb 2023 12:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=SRdv0mwY1mjW5CCdq+LWbNd2Y2xuZ8nNCpBpkpCRfC4=;
 b=bHDwmNZqAUKXonlnqLDL5cpq+CUCT+L2Ptr217SQUpYUYL6laVlrcNnIaIRZKxiSlqqW
 oz15yRXg7Z0eXqOOAeBeBaHu/gWzTLeYsJbIaJ3jnJy15CZY/RhsxIC0kJO/LRAW7hz8
 Nma3K/NlE/R86zQEevPYVpqiLSRivI+Io4MhzKzVKhXjBrRGn55dZOMhVzqMzdPr/TQx
 zxTZ/rN56Ry4m7PSljQ2fks+YDLTcJwVLr7OJ/dVLeR1BHOfvjyaZ9HPQxsyrp6VaaEc
 7Q2XpBBpkD1/ut7XItwDbncE8aTScijjTiuiTVm5uLO8fNWpdKFQekH4QmlvSywmYvTD Mg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6ps0he4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 12:07:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EC744l022245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 12:07:04 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 04:07:01 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>,
        <wanghai38@huawei.com>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] ring-buffer: Handle race between rb_move_tail and rb_check_pages
Date:   Tue, 14 Feb 2023 17:36:43 +0530
Message-ID: <1676376403-16462-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QhrLB9RCMbXZPuSs-i_ju3TxAF4X3P7P
X-Proofpoint-GUID: QhrLB9RCMbXZPuSs-i_ju3TxAF4X3P7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_07,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxlogscore=978 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems a data race between ring_buffer writing and integrity check.
That is, RB_FLAG of head_page is been updating, while at same time
RB_FLAG was cleared when doing integrity check rb_check_pages():

  rb_check_pages()            rb_handle_head_page():
  --------                    --------
  rb_head_page_deactivate()
                              rb_head_page_set_normal()
  rb_head_page_activate()

We do intergrity test of the list to check if the list is corrupted and
it is still worth doing it. So, let's refactor rb_check_pages() such that
we no longer clear and set flag during the list sanity checking.

[1] and [2] are the test to reproduce and the crash report respectively.

1:
``` read_trace.sh
  while true;
  do
    # the "trace" file is closed after read
    head -1 /sys/kernel/tracing/trace > /dev/null
  done
```
``` repro.sh
  sysctl -w kernel.panic_on_warn=1
  # function tracer will writing enough data into ring_buffer
  echo function > /sys/kernel/tracing/current_tracer
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
```

2:
------------[ cut here ]------------
WARNING: CPU: 9 PID: 62 at kernel/trace/ring_buffer.c:2653
rb_move_tail+0x450/0x470
Modules linked in:
CPU: 9 PID: 62 Comm: ksoftirqd/9 Tainted: G        W          6.2.0-rc6+
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
RIP: 0010:rb_move_tail+0x450/0x470
Code: ff ff 4c 89 c8 f0 4d 0f b1 02 48 89 c2 48 83 e2 fc 49 39 d0 75 24
83 e0 03 83 f8 02 0f 84 e1 fb ff ff 48 8b 57 10 f0 ff 42 08 <0f> 0b 83
f8 02 0f 84 ce fb ff ff e9 db
RSP: 0018:ffffb5564089bd00 EFLAGS: 00000203
RAX: 0000000000000000 RBX: ffff9db385a2bf81 RCX: ffffb5564089bd18
RDX: ffff9db281110100 RSI: 0000000000000fe4 RDI: ffff9db380145400
RBP: ffff9db385a2bf80 R08: ffff9db385a2bfc0 R09: ffff9db385a2bfc2
R10: ffff9db385a6c000 R11: ffff9db385a2bf80 R12: 0000000000000000
R13: 00000000000003e8 R14: ffff9db281110100 R15: ffffffffbb006108
FS:  0000000000000000(0000) GS:ffff9db3bdcc0000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005602323024c8 CR3: 0000000022e0c000 CR4: 00000000000006e0
Call Trace:
 <TASK>
 ring_buffer_lock_reserve+0x136/0x360
 ? __do_softirq+0x287/0x2df
 ? __pfx_rcu_softirq_qs+0x10/0x10
 trace_function+0x21/0x110
 ? __pfx_rcu_softirq_qs+0x10/0x10
 ? __do_softirq+0x287/0x2df
 function_trace_call+0xf6/0x120
 0xffffffffc038f097
 ? rcu_softirq_qs+0x5/0x140
 rcu_softirq_qs+0x5/0x140
 __do_softirq+0x287/0x2df
 run_ksoftirqd+0x2a/0x30
 smpboot_thread_fn+0x188/0x220
 ? __pfx_smpboot_thread_fn+0x10/0x10
 kthread+0xe7/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>
---[ end trace 0000000000000000 ]---

[ crash report and test reproducer credit goes to Zheng Yejian]

Reported-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/trace/ring_buffer.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c366a0a..b641cab 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1581,19 +1581,6 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 /**
- * rb_check_list - make sure a pointer to a list has the last bits zero
- */
-static int rb_check_list(struct ring_buffer_per_cpu *cpu_buffer,
-			 struct list_head *list)
-{
-	if (RB_WARN_ON(cpu_buffer, rb_list_head(list->prev) != list->prev))
-		return 1;
-	if (RB_WARN_ON(cpu_buffer, rb_list_head(list->next) != list->next))
-		return 1;
-	return 0;
-}
-
-/**
  * rb_check_pages - integrity check of buffer pages
  * @cpu_buffer: CPU buffer with pages to test
  *
@@ -1602,36 +1589,27 @@ static int rb_check_list(struct ring_buffer_per_cpu *cpu_buffer,
  */
 static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct list_head *head = cpu_buffer->pages;
-	struct buffer_page *bpage, *tmp;
+	struct list_head *head = rb_list_head(cpu_buffer->pages);
+	struct list_head *tmp;
 
-	/* Reset the head page if it exists */
-	if (cpu_buffer->head_page)
-		rb_set_head_page(cpu_buffer);
-
-	rb_head_page_deactivate(cpu_buffer);
-
-	if (RB_WARN_ON(cpu_buffer, head->next->prev != head))
-		return -1;
-	if (RB_WARN_ON(cpu_buffer, head->prev->next != head))
+	if (RB_WARN_ON(cpu_buffer,
+			rb_list_head(rb_list_head(head->next)->prev) != head))
 		return -1;
 
-	if (rb_check_list(cpu_buffer, head))
+	if (RB_WARN_ON(cpu_buffer,
+			rb_list_head(rb_list_head(head->prev)->next) != head))
 		return -1;
 
-	list_for_each_entry_safe(bpage, tmp, head, list) {
+	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
 		if (RB_WARN_ON(cpu_buffer,
-			       bpage->list.next->prev != &bpage->list))
+				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
 			return -1;
+
 		if (RB_WARN_ON(cpu_buffer,
-			       bpage->list.prev->next != &bpage->list))
-			return -1;
-		if (rb_check_list(cpu_buffer, &bpage->list))
+				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
 			return -1;
 	}
 
-	rb_head_page_activate(cpu_buffer);
-
 	return 0;
 }
 
-- 
2.7.4

