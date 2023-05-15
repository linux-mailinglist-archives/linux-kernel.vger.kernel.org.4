Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21730702BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbjEOLzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241427AbjEOLzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:55:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE102D79
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:46:25 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FBiW0D014659;
        Mon, 15 May 2023 11:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G1cCigTeBEXMWy/c4bFSZiuVOkMEUGKj8ygFsmJL550=;
 b=SJ51dMeGcIGj3pUKJGxQomCAI3kd9ReY0rplOvRIFSruLHjfzumUQCtc8oNAcXxHGq2o
 3lQXs+aELZPNX4HSwDuiEecWjAxxy6TRPDuoUKUEUR9cwxsjqPCZu1c394M0ywUtAA7i
 ASNzmPJMazrspqnCyUGOO8Rvw2BFamRVmND6TPTeox5Z0fUCRdG3quFlXtTc2ubY1BVB
 H9280GHXNEin+nStRFP/lkGuIv/d76JjuU0C4TEY1cGSlTa5nv6lPpbdrH1+BtkhqSkM
 ThxRE7mC9pQaFf6fbXyqKRabDuNNrr8RSJ78nd3I5mbgh6mWk709GwzB49bBTymhAwkk yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qkm4ng2fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 11:46:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34FBj8gE017541;
        Mon, 15 May 2023 11:46:08 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qkm4ng2ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 11:46:08 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34F9aOct032315;
        Mon, 15 May 2023 11:46:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qj264rv7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 11:46:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34FBk3Ek3998296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 11:46:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6642620043;
        Mon, 15 May 2023 11:46:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F28E2004D;
        Mon, 15 May 2023 11:46:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.138.156])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 15 May 2023 11:46:03 +0000 (GMT)
From:   Tobias Huschle <huschle@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC 1/1] sched/fair: Consider asymmetric scheduler groups in load balancer
Date:   Mon, 15 May 2023 13:46:01 +0200
Message-Id: <20230515114601.12737-2-huschle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515114601.12737-1-huschle@linux.ibm.com>
References: <20230515114601.12737-1-huschle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z15x4WqIxXSZoEm-pRfMLGKWndy1Sh8u
X-Proofpoint-GUID: yZspnh9xaAth65j_Vvfj2UoWSDm6IlGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current load balancer implementation implies that scheduler groups,
within the same domain, all host the same number of CPUs. This is
reflected in the condition, that a scheduler group, which is load
balancing and classified as having spare capacity, should pull work
from the busiest group, if the local group runs less processes than
the busiest one. This implies that these two groups should run the
same number of processes, which is problematic if the groups are not 
of the same size.

The assumption that scheduler groups within the same scheduler domain
host the same number of CPUs appears to be true for non-s390 
architectures. Nevertheless, s390 can have scheduler groups of unequal 
size.

This introduces a performance degredation in the following scenario:

Consider a system with 8 CPUs, 6 CPUs are located on one CPU socket,
the remaining 2 are located on another socket:

Socket   -----1-----    -2-
CPU      1 2 3 4 5 6    7 8

Placing some workload ( x = one task ) yields the following
scenarios:

The first 5 tasks are distributed evenly across the two groups.

Socket   -----1-----    -2-
CPU      1 2 3 4 5 6    7 8
         x x x          x x

Adding a 6th task yields the following distribution:

Socket   -----1-----    -2-
CPU      1 2 3 4 5 6    7 8
SMT1     x x x          x x
SMT2                    x

The task is added to the 2nd scheduler group, as the scheduler has the
assumption that scheduler groups are of the same size, so they should
also host the same number of tasks. This makes CPU 7 run into SMT 
thread, which comes with a performance penalty. This means, that in 
the window of 6-8 tasks, load balancing is done suboptimally, because 
SMT is used although there is no reason to do so as fully idle CPUs 
are still available.

Taking the weight of the scheduler groups into account, ensures that
a load balancing CPU within a smaller group will not try to pull tasks
from a bigger group while the bigger group still has idle CPUs
available.

Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48b6f0ca13ac..b1307d7e4065 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10426,7 +10426,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 * group's child domain.
 	 */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
-	    busiest->sum_nr_running > local->sum_nr_running + 1)
+	    busiest->sum_nr_running * local->group_weight >
+			local->sum_nr_running * busiest->group_weight + 1)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded) {
-- 
2.34.1

