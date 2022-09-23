Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A425E7533
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiIWHvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiIWHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:51:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE712870A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:51:18 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N7RiQN021805;
        Fri, 23 Sep 2022 07:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=7MbLR4PVl/QPaimY1DxV2Mx73E36ktNnZAiObx7PFHQ=;
 b=HYX9apiGDaHkI9rf0Q/s15YRmGfS1fStkdtm0JOuzxRL6FRU9nB2cyrrTNSI1rTLQjSp
 qn946DuM5j7w8ajM75lspvVFjcFvCG0bBOR3SNCkwaphAebQnDNtRA3MaHzU9Xiopfpk
 88d7OEOOpEbpzNzaC6v4Dpc5E1jCqWyATf1fHKgRDBv3u7vPses0OyRC7fLrUC42W24b
 yoQsyYhXX+wc3CIL9nAI7x9SUERljXTHA6N3AbpOmGZRRJNmrXAC3wU0rcVfHM3vTTLm
 U+dyXV85vJbS1DYqT7bNx9MZDxUK06dPC/1Xd7OSM4T+zIHujmsSmiUvhe64ym65Ek3s hg== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrpqntav9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:51:12 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28N7p9pN027934;
        Fri, 23 Sep 2022 07:51:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jnqnufjwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Sep 2022 07:51:09 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28N7p8Qc027925;
        Fri, 23 Sep 2022 07:51:09 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 28N7p8vQ027924;
        Fri, 23 Sep 2022 07:51:08 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 4A80D21029A4; Fri, 23 Sep 2022 15:51:07 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     rostedt@goodmis.org, mingo@redhat.com, tj@kernel.org,
        william.kucharski@oracle.com
Cc:     Kassey Li <quic_yingangl@quicinc.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] cgroup: align the comm length with TASK_COMM_LEN
Date:   Fri, 23 Sep 2022 15:51:05 +0800
Message-Id: <20220923075105.28251-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d5toZqgqwsVHRU-bOopcGMAUoKoUu4rx
X-Proofpoint-GUID: d5toZqgqwsVHRU-bOopcGMAUoKoUu4rx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxlogscore=444
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230050
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__string could get a dst string with length less than
TASK_COMM_LEN.

A task->comm may change that can cause out of bounds access
for the dst string buffer, e.g in the call trace of below:

Call trace:

    dump_backtrace.cfi_jt+0x0/0x4
    show_stack+0x14/0x1c
    dump_stack+0xa0/0xd8
    die_callback+0x248/0x24c
    notify_die+0x7c/0xf8
    die+0xac/0x290
    die_kernel_fault+0x88/0x98
    die_kernel_fault+0x0/0x98
    do_page_fault+0xa0/0x544
    do_mem_abort+0x60/0x10c
    el1_da+0x1c/0xc4
    trace_event_raw_event_cgroup_migrate+0x124/0x170
    cgroup_attach_task+0x2e8/0x41c
    __cgroup1_procs_write+0x114/0x1ec
    cgroup1_tasks_write+0x10/0x18
    cgroup_file_write+0xa4/0x208
    kernfs_fop_write+0x1f0/0x2f4
    __vfs_write+0x5c/0x200
    vfs_write+0xe0/0x1a0
    ksys_write+0x74/0xdc
    __arm64_sys_write+0x18/0x20
    el0_svc_common+0xc0/0x1a4
    el0_svc_compat_handler+0x18/0x20
    el0_svc_compat+0x8/0x2c

Change it as arrary with same length TASK_COMM_LEN,
This idea is from commit d1eb650ff413 ("tracepoint: Move signal sending
tracepoint to events/signal.h").

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 include/trace/events/cgroup.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index dd7d7c9efecd..b4ef0ffa38a4 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -130,7 +130,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 		__field(	u64,		dst_id			)
 		__field(	int,		pid			)
 		__string(	dst_path,	path			)
-		__string(	comm,		task->comm		)
+		__array(char, comm, TASK_COMM_LEN)
 	),
 
 	TP_fast_assign(
@@ -139,12 +139,12 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 		__entry->dst_level = dst_cgrp->level;
 		__assign_str(dst_path, path);
 		__entry->pid = task->pid;
-		__assign_str(comm, task->comm);
+		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
 	),
 
 	TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s pid=%d comm=%s",
 		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
-		  __get_str(dst_path), __entry->pid, __get_str(comm))
+		  __get_str(dst_path), __entry->pid, __entry->comm)
 );
 
 DEFINE_EVENT(cgroup_migrate, cgroup_attach_task,
-- 
2.17.1

