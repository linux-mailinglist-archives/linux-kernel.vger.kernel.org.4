Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940D1653314
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiLUPTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiLUPTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:19:47 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C64422B0E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:19:46 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NccTT6R75zJpNB;
        Wed, 21 Dec 2022 23:15:57 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 23:19:43 +0800
Message-ID: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
Date:   Wed, 21 Dec 2022 23:19:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
Subject: [bug-report] possible s64 overflow in max_vruntime()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi folks,

    I found problem about s64 overflow in max_vruntime().

    I create a task group GROUPA (path: /system.slice/xxx/yyy/CGROUPA) and run a task in this
group on each cpu, these tasks is while loop and 100% cpu usage.

    When unregister net devices, will queue a kwork on system_highpri_wq at flush_all_backlogs()
and wake up a high-priority kworker thread on each cpu. However, the kworker thread has been
waiting on the queue and has not been scheduled.

    After parsing the vmcore, the vruntime of the kworker is 0x918fdb05287da7c3 and the
cfs_rq->min_vruntime is 0x124b17fd59db8d02.

    why the difference between the cfs_rq->min_vruntime and kworker's vruntime is so large?
    1) the kworker of the system_highpri_wq sleep for long long time(about 300 days).
    2) cfs_rq->curr is the ancestor of the GROUPA, cfs->curr->load.weight is 2494, so when
the task belonging to the GROUPA run for a long time, its vruntime will increase by 420
times, cfs_rq->min_vruntime will also grow rapidly.
    3) when wakeup kworker thread, kworker will be set the maximum value between kworker's
vruntime and cfs_rq->min_vruntime. But at max_vruntime(), there will be a s64 overflow issue,
as follow:

---------

static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
{
	/*
	 * vruntime=0x124b17fd59db8d02
	 * min_vruntime=0x918fdb05287da7c3
	 * vruntime - min_vruntime = 9276074894177461567 > s64_max, will s64 overflow
	 */
	s64 delta = (s64)(vruntime - min_vruntime);
	if (delta < 0)
		min_vruntime = vruntime;

	return min_vruntime;
}

----------

max_vruntime() will return the kworker's old vruntime, it is incorrect and the correct result
shoud be cfs_rq->minvruntime. This incorrect result is greater than cfs_rq->min_vruntime and
will cause kworker thread starved.

    Does anyone have a good suggestion for slove this problem? or bugfix patch.
