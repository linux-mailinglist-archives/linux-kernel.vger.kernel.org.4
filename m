Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441745ED6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiI1HvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiI1Huo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:50:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4016FC888A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:48:59 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S5stks025373;
        Wed, 28 Sep 2022 07:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Hd42+Ckr6MvDLYdOMrXx2uqRig++7DPqRlIQqBuQ7Vs=;
 b=neEG7eGqlXicLuNFWzBpYu0HxfXOKCGoZPWOnztGS8fV+/xFCpAyE3eDzDzPSi8Pskx0
 NWo8wXucoyDmEzDQGnNcAcwPdk56fP9bBPDKTTIoQdx2m1ayPzLAz4k2RiHF8IZVyrci
 c86BxPHjY7vH1MqBkwjHOB4E+vwF0cy2UQfvCrnisRZUe1rlaBIZUIJ++atf4zzlpXoe
 XuYiNpukBw54OGPOtihM8Qyge1nXB02Ci/CDn6uoYB6HSPVzdsU0ScpMegiqns06CVOp
 +I1BzvF+76SB6MGx6D0wDnk+IzMb1wWqItlVOEsL+5w1dD4tEAHkBAba0N3zUkLPS9xN vw== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juw2632j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 07:48:46 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28S7mim4026196;
        Wed, 28 Sep 2022 07:48:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3jstynkex5-1;
        Wed, 28 Sep 2022 07:48:44 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28S7mhbv026191;
        Wed, 28 Sep 2022 07:48:43 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 28S7mhvZ026190;
        Wed, 28 Sep 2022 07:48:43 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 210F22102E3F; Wed, 28 Sep 2022 15:48:42 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     Kassey Li <quic_yingangl@quicinc.com>,
        linux-kernel@vger.kernel.org, quic_namajain@quicinc.com
Subject: [PATCH v2] kernel/hung_task: add option to ignore task
Date:   Wed, 28 Sep 2022 15:48:41 +0800
Message-Id: <20220928074841.22545-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6EkTwACvb2GISERX_fDgbLXIazdOZ1zx
X-Proofpoint-ORIG-GUID: 6EkTwACvb2GISERX_fDgbLXIazdOZ1zx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=837 mlxscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280046
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, hung_task will iterate the tasklist and check
state in TASK_UNINTERRUPTIBLE with a given timeout value.

Here we add an option for task_struct so it can be ignored.
Set this flag to default true, it do not break the origin design.

This is useful when we set timeout value to 5s, where we just want
to detect some tasks interested.

Suggested-by: Naman Jain <quic_namajain@quicinc.com>
Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 include/linux/sched.h | 1 +
 kernel/fork.c         | 1 +
 kernel/hung_task.c    | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..7c8596fea1f6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1071,6 +1071,7 @@ struct task_struct {
 #ifdef CONFIG_DETECT_HUNG_TASK
 	unsigned long			last_switch_count;
 	unsigned long			last_switch_time;
+	bool			hung_task_detect;
 #endif
 	/* Filesystem information: */
 	struct fs_struct		*fs;
diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..5c461a37a26e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1552,6 +1552,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 #ifdef CONFIG_DETECT_HUNG_TASK
 	tsk->last_switch_count = tsk->nvcsw + tsk->nivcsw;
 	tsk->last_switch_time = 0;
+	tsk->hung_task_detect = 1;
 #endif
 
 	tsk->mm = NULL;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index bb2354f73ded..74bf4cef857f 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -119,7 +119,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (sysctl_hung_task_panic) {
 		console_verbose();
 		hung_task_show_lock = true;
-		hung_task_call_panic = true;
+		if (t->hung_task_detect)
+			hung_task_call_panic = true;
 	}
 
 	/*
-- 
2.17.1

