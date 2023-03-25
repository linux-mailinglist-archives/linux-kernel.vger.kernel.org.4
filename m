Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FE6C8A47
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 03:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjCYChX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 22:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCYChV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 22:37:21 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20A619F24
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:37:20 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679711836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbJ5P4BKOqb4iS2A7y/+fQzC8w3jldyyCXASrx+9Klg=;
        b=A8AdZMKgicxUWLO6Gev3tL9/z5ysmGAXBhvs+u6A869cWjk52dFInEfDyA7B854p/Hbigs
        h23rU+YWhWRcB0prCOcYmL74bvzd08gF0qPMxH9Kyie3u3TKH8VZQYeqJiCDS+ywjXQxhq
        SgUJ0WTWuOuoRTTV5W8taSiNCmvrFPY=
Date:   Sat, 25 Mar 2023 02:37:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <fc39e67bdf397f0aa51f00c58d135ac0@linux.dev>
Subject: Re: [PATCH] cpufreq: schedutil: Combine two loops into one in
 sugov_start()
To:     "Lukasz Luba" <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, mingo@redhat.com, vschneid@redhat.com,
        bristot@redhat.com, bsegall@google.com, juri.lelli@redhat.com,
        peterz@infradead.org, mgorman@suse.de, viresh.kumar@linaro.org,
        rafael@kernel.org
In-Reply-To: <09ea63b7-7294-a143-c797-95eba87c765e@arm.com>
References: <09ea63b7-7294-a143-c797-95eba87c765e@arm.com>
 <20230324100023.900616-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

March 24, 2023 6:46 PM, "Lukasz Luba" <lukasz.luba@arm.com> wrote:=0A=0A>=
 Hi Yajun,=0A> =0A> On 3/24/23 10:00, Yajun Deng wrote:=0A> =0A>> The sug=
ov_start() function currently contains two for loops that=0A>> traverse t=
he CPU list and perform some initialization tasks. The first=0A>> loop in=
itializes each sugov_cpu struct and assigns the CPU number and=0A>> sugov=
_policy pointer. The second loop sets up the update_util hook for=0A>> ea=
ch CPU based on the policy type.=0A>> Since both loops operate on the sam=
e CPU list, it is possible to combine=0A>> them into a single for loop. T=
his simplifies the code and reduces the=0A>> number of times the CPU list=
 needs to be traversed, which can improve=0A>> performance.=0A>> Signed-o=
ff-by: Yajun Deng <yajun.deng@linux.dev>=0A>> ---=0A>> kernel/sched/cpufr=
eq_schedutil.c | 12 ++++--------=0A>> 1 file changed, 4 insertions(+), 8 =
deletions(-)=0A>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/=
sched/cpufreq_schedutil.c=0A>> index e3211455b203..9a28ebbb9c1e 100644=0A=
>> --- a/kernel/sched/cpufreq_schedutil.c=0A>> +++ b/kernel/sched/cpufreq=
_schedutil.c=0A>> @@ -766,14 +766,6 @@ static int sugov_start(struct cpuf=
req_policy *policy)=0A>>> sg_policy->need_freq_update =3D cpufreq_driver_=
test_flags(CPUFREQ_NEED_UPDATE_LIMITS);=0A>>> - for_each_cpu(cpu, policy-=
>cpus) {=0A>> - struct sugov_cpu *sg_cpu =3D &per_cpu(sugov_cpu, cpu);=0A=
>> -=0A>> - memset(sg_cpu, 0, sizeof(*sg_cpu));=0A>> - sg_cpu->cpu =3D cp=
u;=0A>> - sg_cpu->sg_policy =3D sg_policy;=0A>> - }=0A>> -=0A>> if (polic=
y_is_shared(policy))=0A>> uu =3D sugov_update_shared;=0A>> else if (polic=
y->fast_switch_enabled && cpufreq_driver_has_adjust_perf())=0A>> @@ -784,=
6 +776,10 @@ static int sugov_start(struct cpufreq_policy *policy)=0A>> f=
or_each_cpu(cpu, policy->cpus) {=0A>> struct sugov_cpu *sg_cpu =3D &per_c=
pu(sugov_cpu, cpu);=0A>>> + memset(sg_cpu, 0, sizeof(*sg_cpu));=0A>> + sg=
_cpu->cpu =3D cpu;=0A>> + sg_cpu->sg_policy =3D sg_policy;=0A>> +=0A>> cp=
ufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);=0A>> }=0A>> re=
turn 0;=0A> =0A> IMO the change might cause a race.=0A> There is a call t=
o set scheduler hook in the 2nd loop.=0A> If you combine two loops that h=
ook might be used=0A> from other CPU in the meantime, while still the res=
t CPUs are not=0A> finished.=0A> The first loop makes sure all CPUs in th=
e 'policy->cpus' get a clean=0A> context 'sg_cpu' and proper 'cpu' values=
 first (and 'sg_policy' as=0A> well). When the two loops are combined, th=
ere might be fast usage=0A> from scheduler on other CPU the sugov code pa=
th.=0A> =0A> If the policy is shared for many CPUs and any of them is abl=
e to=0A> change the freq, then some CPU can enter this code flow, where=
=0A> remotely wants to check the other CPUs' utilization:=0A> =0A> sugov_=
next_freq_shared()=0A> for each cpu in policy->cpus:=0A> sugov_get_util()=
=0A> where the 'sg_cpu->cpu' is used=0A> =0A> Therefore, IMO this optimiz=
ation in a start function (which is=0A> only called once and is not part =
of the 'hot path') is not=0A> worth the race risk.=0A>=0A=0AOk, Got it. T=
hanks!=0A =0A> Regards=0A> Lukasz
