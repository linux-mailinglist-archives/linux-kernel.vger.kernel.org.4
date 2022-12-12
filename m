Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215B06497DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiLLCLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiLLCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:11:10 -0500
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Dec 2022 18:11:06 PST
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A52C2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:11:05 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670810740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bwXKTDhn3IwcBwhgVdwbQXe6w3acdV0zTCH6qBI6v14=;
        b=IaKLGPaXey3volonxg6iTmMvb6wyw1pKhu/g7aBgFeFNyVEHy3q3XMKHH8SaNIzncXeC8q
        9D07skGJNY5uf71nRcaWiM8V8rbcLyIADJA5kMCEfPZIw7LkVHlsTfb8nzR4tM7YSL1P0J
        oSB3z5Cv+q3G6NaRmk+0VFdcy9KEdzk=
Date:   Mon, 12 Dec 2022 02:05:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <7687e119c7b6beab06c4da41a6b4dcca@linux.dev>
Subject: Re: [PATCH] sched/rt: Add pid and comm when RT throttling
 activated
To:     "Steven Rostedt" <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20221209163606.53a2370e@gandalf.local.home>
References: <20221209163606.53a2370e@gandalf.local.home>
 <20221206083641.103832-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 10, 2022 5:36 AM, "Steven Rostedt" <rostedt@goodmis.org> wrote:=
=0A=0A> On Tue, 6 Dec 2022 16:36:41 +0800=0A> Yajun Deng <yajun.deng@linu=
x.dev> wrote:=0A> =0A>> It is difficult to know which process consumes ti=
me when RT throttling=0A>> activated.=0A>> =0A>> So add pid and comm for =
this case.=0A> =0A> Unfortunately, that only shows the process that "brok=
e the camel's=0A> back"[1]. The things is, it is the amount of time *all*=
 RT tasks use to=0A> trigger throttling. You are only printing the task t=
hat the throttling=0A> occurred on.=0A> =0A> Try running https://rostedt.=
org/code/migrate.c . It will create a bunch of=0A> RT tasks, and they all=
 will throttle once it hits 950ms ever second.=0A> =0A> trace-cmd record =
-e sched_switch ./migrate=0A> kernelshark=0A> =0A> Then plot all the migr=
ate tasks.=0A> =0A> The above will demonstrate it very well.=0A=0AThanks =
for your patient answer, I'll test it.=0A=0A> =0A> -- Steve=0A> =0A> [1] =
https://en.wikipedia.org/wiki/Straw_that_broke_the_camel's_back=0A> =0A>>=
 Signed-off-by: Yajun Deng <yajun.deng@linux.dev>=0A>> ---=0A>> kernel/sc=
hed/rt.c | 4 +++-=0A>> 1 file changed, 3 insertions(+), 1 deletion(-)=0A>=
> =0A>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c=0A>> index ed2=
a47e4ddae..1f267ab1b59a 100644=0A>> --- a/kernel/sched/rt.c=0A>> +++ b/ke=
rnel/sched/rt.c=0A>> @@ -1012,6 +1012,7 @@ static int sched_rt_runtime_ex=
ceeded(struct rt_rq *rt_rq)=0A>> =0A>> if (rt_rq->rt_time > runtime) {=0A=
>> struct rt_bandwidth *rt_b =3D sched_rt_bandwidth(rt_rq);=0A>> + struct=
 task_struct *curr =3D rq_of_rt_rq(rt_rq)->curr;=0A>> =0A>> /*=0A>> * Don=
't actually throttle groups that have no runtime assigned=0A>> @@ -1019,7=
 +1020,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)=0A>=
> */=0A>> if (likely(rt_b->rt_runtime)) {=0A>> rt_rq->rt_throttled =3D 1;=
=0A>> - printk_deferred_once("sched: RT throttling activated\n");=0A>> + =
printk_deferred_once("pid: %d, comm: %s, sched: RT throttling activated\n=
",=0A>> + curr->pid, curr->comm);=0A>> } else {=0A>> /*=0A>> * In case we=
 did anyway, make it go away,
