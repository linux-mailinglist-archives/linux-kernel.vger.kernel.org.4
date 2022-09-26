Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCE5EA810
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiIZOM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiIZOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:11:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAA35F7E2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:22:51 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QAuc1s019328;
        Mon, 26 Sep 2022 11:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0hfI42veZJ2IGcvtIPV7Q926xBIKMX6NOqBrEtE6vf8=;
 b=bluk/W8nBPI+2O12zF25f/wrr7FCOnMbWOiFiMHVBla57KfTy3AdqyMfo0VxLwK8dokw
 ybB5H8GGqpcDWULJzOypdrQD6MjGFtudh7bxPhjfyecFQe3uiFJvcmzxTFHE+vEgDlHO
 OZkL3zGU56XtIFhpApb0fvmh8NSMu6YnHEl94oEiazFIECQOSowQr8dtSpx2xqpemc1g
 AfOqSex1q1S8o1fd/ylYx0+kYCnuXnu6Gvw99D71/ODm1YK7dbOLOaZ1ISov6/F0Yyqi
 n2b+v2fBCNJ/3z8M0zOSeEp7XYBaOJnXWiPR3eMXUr/x+rfMzVsLk0YM74d+GyCTdDEL Ew== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ju8e18g25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 11:46:46 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28QBhaDn003037;
        Mon, 26 Sep 2022 11:46:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 3jstykmv78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 11:46:46 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28QBkkK4009227;
        Mon, 26 Sep 2022 11:46:46 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 28QBkkGR009191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 11:46:46 +0000
Received: from [10.216.61.244] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:46:43 -0700
Message-ID: <4a4952a8-3d1b-8197-4cb6-b1de7eecf21f@quicinc.com>
Date:   Mon, 26 Sep 2022 17:16:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: locking/rwsem: RT throttling issue due to RT task hogging the cpu
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>
CC:     <longman@redhat.com>, <linux-kernel@vger.kernel.org>,
        <"<boqun.feng"@gmail.com>
References: <e1cb435a-4471-ac3a-344f-04448f167c9f@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <e1cb435a-4471-ac3a-344f-04448f167c9f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: whT35Kw2Lwr3QSHPv3X_vz35BXXavKlO
X-Proofpoint-ORIG-GUID: whT35Kw2Lwr3QSHPv3X_vz35BXXavKlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=907 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260074
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any comments on this issue would be helpful.

Thanks,
Mukesh

On 9/20/2022 9:49 PM, Mukesh Ojha wrote:
> Hi,
> 
> We are observing one issue where, sem->owner is not set and sem->count=6 
> [1] which means both RWSEM_FLAG_WAITERS and RWSEM_FLAG_HANDOFF bits are 
> set. And if unfold the sem->wait_list we see the following order of 
> process waiting  [2] where [a] is waiting for write, while [b],[c] are 
> waiting for read and [d] is the RT task for which 
> waiter.handoff_set=true and it is continuously running on cpu7 and not 
> letting the first write waiter [a] on cpu7.
> 
> [1]
> 
>    sem = 0xFFFFFFD57DDC6680 -> (
>      count = (counter = 6),
>      owner = (counter = 0),
> 
> [2]
> 
> [a] kworker/7:0 pid: 32516 ==> [b] iptables-restor pid: 18625 ==> 
> [c]HwBinder:1544_3  pid: 2024 ==> [d] RenderEngine pid: 2032 cpu: 7 
> prio:97 (RT task)
> 
> 
> Sometime back, Waiman has suggested this which could help in RT task
> leaving the cpu.
> 
> https://lore.kernel.org/all/8c33f989-8870-08c6-db12-521de634b34e@redhat.com/ 
> 
> 
> --------------------------------->O----------------------------
> 
>  From c6493edd7a5e4f597ea55ff0eb3f1d763b335dfc Mon Sep 17 00:00:00 2001
>    2 From: Waiman Long <longman@redhat.com>
>    3 Date: Tue, 20 Sep 2022 20:50:45 +0530
>    4 Subject: [PATCH] locking/rwsem: Yield the cpu after doing handoff 
> optimistic
>    5  spinning
>    6
>    7 It is possible the new lock owner (writer) can be preempted before 
> setting
>    8 the owner field and if the current(e.g RT task) waiter is the task 
> that
>    9 preempts the new lock owner, it will hand_off spin loop for a long 
> time.
>   10 Avoid wasting cpu time and delaying the release of the lock by 
> yielding
>   11 the cpu if handoff optimistic spinning has been done multiple times 
> with
>   12 NULL owner.
>   13
>   14 Signed-off-by: Waiman Long <longman@redhat.com>
>   15 Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>   16 ---
>   17  kernel/locking/rwsem.c | 15 ++++++++++++++-
>   18  1 file changed, 14 insertions(+), 1 deletion(-)
>   19
>   20 diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>   21 index 65f0262..a875758 100644
>   22 --- a/kernel/locking/rwsem.c
>   23 +++ b/kernel/locking/rwsem.c
>   24 @@ -361,6 +361,8 @@ enum rwsem_wake_type {
>   25   */
>   26  #define MAX_READERS_WAKEUP     0x100
>   27
>   28 +#define MAX_HANDOFF_SPIN       10
>   29 +
>   30  static inline void
>   31  rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter 
> *waiter)
>   32  {
>   33 @@ -1109,6 +1111,7 @@ rwsem_down_write_slowpath(struct rw_semaphore 
> *sem, int state)
>   34  {
>   35         struct rwsem_waiter waiter;
>   36         DEFINE_WAKE_Q(wake_q);
>   37 +       int handoff_spins = 0;
>   38
>   39         /* do optimistic spinning and steal lock if possible */
>   40         if (rwsem_can_spin_on_owner(sem) && 
> rwsem_optimistic_spin(sem)) {
>   41 @@ -1167,6 +1170,14 @@ rwsem_down_write_slowpath(struct 
> rw_semaphore *sem, int state)
>   42                  * has just released the lock, OWNER_NULL will be 
> returned.
>   43                  * In this case, we attempt to acquire the lock again
>   44                  * without sleeping.
>   45 +                *
>   46 +                * It is possible the new lock owner (writer) can 
> be preempted
>   47 +                * before setting the owner field and if the 
> current(e.g RT task)
>   48 +                * waiter is the task that preempts the new lock 
> owner, it will
>   49 +                * spin in this loop for a long time. Avoid wasting 
> cpu time
>   50 +                * and delaying the release of the lock by yielding 
> the cpu if
>   51 +                * handoff optimistic spinning has been done 
> multiple times with
>   52 +                * NULL owner.
>   53                  */
>   54                 if (waiter.handoff_set) {
>   55                         enum owner_state owner_state;
>   56 @@ -1175,8 +1186,10 @@ rwsem_down_write_slowpath(struct 
> rw_semaphore *sem, int state)
>   57                         owner_state = rwsem_spin_on_owner(sem);
>   58                         preempt_enable();
>   59
>   60 -                       if (owner_state == OWNER_NULL)
>   61 +                       if ((owner_state == OWNER_NULL) && 
> (handoff_spins < MAX_HANDOFF_SPIN)) {
>   62 +                               handoff_spins++;
>   63                                 goto trylock_again;
>   64 +                       }
>   65                 }
>   66
>   67                 schedule();
>   68 --
>   69 2.7.4
>   70
> 
> 
> -Mukesh
