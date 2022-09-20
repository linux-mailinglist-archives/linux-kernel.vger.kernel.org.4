Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1235BEB07
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiITQVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiITQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:20:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262D2C652
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:20:05 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KEOY7n010250;
        Tue, 20 Sep 2022 16:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : to : subject : cc : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=slbSoAFDYn4hUZtLFSfeLj5eIn40jH3HhavxqrMyNoU=;
 b=NMZJqDw3jYWkeWQaIbRThyZHnWzVV5yUvsHPrffdSXoxqIUg67/zDVcpe/Ty9BZwfclV
 lGht+s6FC7fXcL6sPU2lkx+sdklHpOGIA7Vd5ByCcIJ0NiNbKNIQH2Tlsw1Vaq0uUMFu
 x5x1VcrNscKT0JiZ8omCzMNvwaad+pEOWrp4Ko3qyc8In/vJK3ARYLZOIYreIsIiy8gk
 WqbHDUVmpCBklGjpi2Z6M0EkliW7WjSQMa6dnUYq0RpxKAdid7IkHSSFJUNq1Rz3n7yQ
 /Ub6iYiexUNSw5K8HHRSCiCKnYEwMO40GoHTi7ymewNmyXPxX0kCJ0ZS3evqj2no9p2m GA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq4r0a8ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 16:19:55 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28KGJsPS029246;
        Tue, 20 Sep 2022 16:19:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jq7t0mgsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 16:19:54 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KGJsbK029241;
        Tue, 20 Sep 2022 16:19:54 GMT
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 28KGJrSu029240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 16:19:54 +0000
Received: from [10.216.9.124] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 09:19:51 -0700
Message-ID: <e1cb435a-4471-ac3a-344f-04448f167c9f@quicinc.com>
Date:   Tue, 20 Sep 2022 21:49:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>
Subject: locking/rwsem: RT throttling issue due to RT task hogging the cpu
CC:     <longman@redhat.com>, <linux-kernel@vger.kernel.org>,
        <"<boqun.feng"@gmail.com>, <quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2YnQDzDGfET-GIA1gS-PMKxPNC33SLA9
X-Proofpoint-GUID: 2YnQDzDGfET-GIA1gS-PMKxPNC33SLA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=761
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are observing one issue where, sem->owner is not set and sem->count=6 
[1] which means both RWSEM_FLAG_WAITERS and RWSEM_FLAG_HANDOFF bits are 
set. And if unfold the sem->wait_list we see the following order of 
process waiting  [2] where [a] is waiting for write, while [b],[c] are 
waiting for read and [d] is the RT task for which 
waiter.handoff_set=true and it is continuously running on cpu7 and not 
letting the first write waiter [a] on cpu7.

[1]

   sem = 0xFFFFFFD57DDC6680 -> (
     count = (counter = 6),
     owner = (counter = 0),

[2]

[a] kworker/7:0 pid: 32516 ==> [b] iptables-restor pid: 18625 ==> 
[c]HwBinder:1544_3  pid: 2024 ==> [d] RenderEngine pid: 2032 cpu: 7 
prio:97 (RT task)


Sometime back, Waiman has suggested this which could help in RT task
leaving the cpu.

https://lore.kernel.org/all/8c33f989-8870-08c6-db12-521de634b34e@redhat.com/

--------------------------------->O----------------------------

 From c6493edd7a5e4f597ea55ff0eb3f1d763b335dfc Mon Sep 17 00:00:00 2001
   2 From: Waiman Long <longman@redhat.com>
   3 Date: Tue, 20 Sep 2022 20:50:45 +0530
   4 Subject: [PATCH] locking/rwsem: Yield the cpu after doing handoff 
optimistic
   5  spinning
   6
   7 It is possible the new lock owner (writer) can be preempted before 
setting
   8 the owner field and if the current(e.g RT task) waiter is the task that
   9 preempts the new lock owner, it will hand_off spin loop for a long 
time.
  10 Avoid wasting cpu time and delaying the release of the lock by yielding
  11 the cpu if handoff optimistic spinning has been done multiple times 
with
  12 NULL owner.
  13
  14 Signed-off-by: Waiman Long <longman@redhat.com>
  15 Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
  16 ---
  17  kernel/locking/rwsem.c | 15 ++++++++++++++-
  18  1 file changed, 14 insertions(+), 1 deletion(-)
  19
  20 diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
  21 index 65f0262..a875758 100644
  22 --- a/kernel/locking/rwsem.c
  23 +++ b/kernel/locking/rwsem.c
  24 @@ -361,6 +361,8 @@ enum rwsem_wake_type {
  25   */
  26  #define MAX_READERS_WAKEUP     0x100
  27
  28 +#define MAX_HANDOFF_SPIN       10
  29 +
  30  static inline void
  31  rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter 
*waiter)
  32  {
  33 @@ -1109,6 +1111,7 @@ rwsem_down_write_slowpath(struct rw_semaphore 
*sem, int state)
  34  {
  35         struct rwsem_waiter waiter;
  36         DEFINE_WAKE_Q(wake_q);
  37 +       int handoff_spins = 0;
  38
  39         /* do optimistic spinning and steal lock if possible */
  40         if (rwsem_can_spin_on_owner(sem) && 
rwsem_optimistic_spin(sem)) {
  41 @@ -1167,6 +1170,14 @@ rwsem_down_write_slowpath(struct 
rw_semaphore *sem, int state)
  42                  * has just released the lock, OWNER_NULL will be 
returned.
  43                  * In this case, we attempt to acquire the lock again
  44                  * without sleeping.
  45 +                *
  46 +                * It is possible the new lock owner (writer) can 
be preempted
  47 +                * before setting the owner field and if the 
current(e.g RT task)
  48 +                * waiter is the task that preempts the new lock 
owner, it will
  49 +                * spin in this loop for a long time. Avoid wasting 
cpu time
  50 +                * and delaying the release of the lock by yielding 
the cpu if
  51 +                * handoff optimistic spinning has been done 
multiple times with
  52 +                * NULL owner.
  53                  */
  54                 if (waiter.handoff_set) {
  55                         enum owner_state owner_state;
  56 @@ -1175,8 +1186,10 @@ rwsem_down_write_slowpath(struct 
rw_semaphore *sem, int state)
  57                         owner_state = rwsem_spin_on_owner(sem);
  58                         preempt_enable();
  59
  60 -                       if (owner_state == OWNER_NULL)
  61 +                       if ((owner_state == OWNER_NULL) && 
(handoff_spins < MAX_HANDOFF_SPIN)) {
  62 +                               handoff_spins++;
  63                                 goto trylock_again;
  64 +                       }
  65                 }
  66
  67                 schedule();
  68 --
  69 2.7.4
  70


-Mukesh
