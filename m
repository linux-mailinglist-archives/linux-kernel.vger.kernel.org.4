Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD59660DEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiJZKof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiJZKoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:44:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3874610051
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:44:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27A3523A;
        Wed, 26 Oct 2022 03:44:37 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A1C13F7B4;
        Wed, 26 Oct 2022 03:44:26 -0700 (PDT)
Message-ID: <9d06c9ce-d4b3-23a8-9f9c-c1054de1aeb5@arm.com>
Date:   Wed, 26 Oct 2022 12:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 7/7] sched/fair: Add latency list
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Youssef Esmat <youssefesmat@chromium.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, joel@joelfernandes.org
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-8-vincent.guittot@linaro.org>
 <CA+q576OoP6Ebax8aGM234JRf+WOJFEwChs25qB9M_rt7+r1wuA@mail.gmail.com>
 <CAKfTPtAh30v=XoJPvAeFxu274CDW0uf2UY4Z8ySJz123ko5xgw@mail.gmail.com>
 <CA+q576Po0bskXfBP3EXUGG9jFLAP66iH6EamXfPUg9LC6qQyCg@mail.gmail.com>
 <20221012152130.GA20993@vingu-book>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221012152130.GA20993@vingu-book>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 17:21, Vincent Guittot wrote:
> Le mardi 11 oct. 2022 ï¿½ 18:54:27 (-0500), Youssef Esmat a ï¿½crit :
>> Hi Vincent,
>>
>> On Tue, Oct 11, 2022 at 12:10 PM Vincent Guittot
>> <vincent.guittot@linaro.org> wrote:

[...]

> @@ -10894,12 +10898,17 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
>  static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
>  				    struct cftype *cft)
>  {
> +	unsigned long period = sysctl_sched_latency;
>  	int last_delta = INT_MAX;
>  	int prio, delta;
>  	s64 weight;
>  
> +	if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +		period >>= 1;
> +
>  	weight = css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
> -	weight = div_s64(weight, sysctl_sched_latency);
> +	period = sysctl_sched_latency;

Looks like this line is wrong here, period has been set already for
GENTLE_FAIR_SLEEPERS and !GENTLE_FAIR_SLEEPERS?

> +	weight = div_s64(weight, period);
>  
>  	/* Find the closest nice value to the current weight */
>  	for (prio = 0; prio < ARRAY_SIZE(sched_latency_to_weight); prio++) {

[...]

