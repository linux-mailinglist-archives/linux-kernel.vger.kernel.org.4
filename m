Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14E5BE0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiITIt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiITIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:49:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A967766F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:49:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xZDm032759;
        Tue, 20 Sep 2022 08:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=6jkUXooAPLXN6KE5hYz4E9aDYCWRE+N9v8u5VbEuIcE=;
 b=EWooieDiPFQh0hoRqDE5x5S7y0yzjDa/nHUkwjM27WfXwbdNvydHFDeH+MY5V67CrriW
 TTgxuW/u4h9G5JHGwRqhrox9pBwToYpNDP03S7rHIC2CrM7P7Nj4fxMEU3hj+3RssZMp
 4SiQBFGbSQXleBhVs8V0bczxdn8WIRhgSjfBEAtKFIvpv4yCY8M37axeebnlCSylJtSg
 gSrm/Lhx2BTrPyApm9daoM+Fcgmb5EBGgupEMKY5SHKTQi+eoAwqViDFesyL+/GpuDe0
 oAxVGSy4BP2em5Ii8Ga8TUyAsj9U21Fy7bL4AnEqsD9qle7yNCE0R99LwM1MVf1yOX60 5w== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq7320sg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 08:49:30 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28K8nREU003494;
        Tue, 20 Sep 2022 08:49:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jnqs1xsu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 08:49:27 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28K8nQMG003487;
        Tue, 20 Sep 2022 08:49:26 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 28K8nQJU003485;
        Tue, 20 Sep 2022 08:49:26 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id CE1972102E37; Tue, 20 Sep 2022 16:49:24 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     rostedt@goodmis.org, mingo@redhat.com, tj@kernel.org,
        william.kucharski@oracle.com
Cc:     Kassey Li <quic_yingangl@quicinc.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: align the comm length with TASK_COMM_LEN
Date:   Tue, 20 Sep 2022 16:49:23 +0800
Message-Id: <20220920084923.18476-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 55pg6wCUyDjKhNUH-tmAv6VVtlI7MO2y
X-Proofpoint-GUID: 55pg6wCUyDjKhNUH-tmAv6VVtlI7MO2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=563 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200054
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

a task->comm possbile change dynamic that can cause
out of bounds access for the dst string buffer.

change it as arrary with same length TASK_COMM_LEN,
this aligns the same usage of include/trace on task->comm.

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 include/trace/events/cgroup.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index dd7d7c9efecd..d0c5f93e3611 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -130,7 +130,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 		__field(	u64,		dst_id			)
 		__field(	int,		pid			)
 		__string(	dst_path,	path			)
-		__string(	comm,		task->comm		)
+		__array(char,   comm, TASK_COMM_LEN)
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

