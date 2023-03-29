Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8990D6CD96D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC2Mgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC2Mgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:36:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 432204201
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:36:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4045A1FB;
        Wed, 29 Mar 2023 05:37:36 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE0543F6C4;
        Wed, 29 Mar 2023 05:36:49 -0700 (PDT)
Message-ID: <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
Date:   Wed, 29 Mar 2023 14:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230328125624.GA6130@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 14:56, Aaron Lu wrote:
> Hi Dietmar,
> 
> Thanks for taking a look.
> 
> On Tue, Mar 28, 2023 at 02:09:39PM +0200, Dietmar Eggemann wrote:
>> On 27/03/2023 07:39, Aaron Lu wrote:

[...]

> Did you test with a v6.3-rc based kernel?
> I encountered another problem on those kernels and had to temporarily use
> a v6.2 based kernel, maybe you have to do the same:
> https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/

No, I'm also on v6.2.

>> Is your postgres/sysbench running in a cgroup with cpu controller
>> attached? Mine isn't.
> 
> Yes, I had postgres and sysbench running in the same cgroup with cpu
> controller enabled. docker created the cgroup directory under
> /sys/fs/cgroup/system.slice/docker-XXX and cgroup.controllers has cpu
> there.

I'm running postgresql service directly on the machine. I boot now with
'cgroup_no_v1=all systemd.unified_cgroup_hierarchy=1' so I can add the
cpu controller to:

  system.slice/system-postgresql.slice/postgresql@11-main.service

where the 96 postgres threads run and to

  user.slice/user-1005.slice/session-4.scope

where the 96 sysbench threads run.

Checked with systemd-cgls and `cat /sys/kernel/debug/sched/debug` that
those threads are really running there.

Still not seeing `update_load_avg` or `update_cfs_group` in perf report,
only some very low values for `update_blocked_averages`.

Also added CFS BW throttling to both cgroups. No change.

Then I moved session-4.scope's shell into `postgresql@11-main.service`
so that `postgres` and `sysbench` threads run in the same cgroup.

Didn't change much.

>> Maybe I'm doing something else differently?
> 
> Maybe, you didn't mention how you started postgres, if you start it from
> the same session as sysbench and if autogroup is enabled, then all those
> tasks would be in the same autogroup taskgroup then it should have the
> same effect as my setup.

This should be now close to my setup running `postgres` and `sysbench`
in `postgresql@11-main.service`.

> Anyway, you can try the following steps to see if you can reproduce this
> problem on your Arm64 server:
> 
> 1 docker pull postgres
> 2 sudo docker run --rm --name postgres-instance -e POSTGRES_PASSWORD=mypass -e POSTGRES_USER=sbtest -d postgres -c shared_buffers=80MB -c max_connections=250
> 3 go inside the container
>   sudo docker exec -it $the_just_started_container_id bash
> 4 install sysbench inside container
>   apt update and apt install sysbench
> 5 prepare
>   root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=224 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua prepare
> 6 run
>   root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=224 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua run

I would have to find time to learn how to set up docker on my machine
... But I use very similar values for the setup and sysbench test.

> Note that I used 224 threads where this problem is visible. I also tried
> 96 and update_cfs_group() and update_load_avg() cost about 1% cycles then.

True, I was hopping to see at least the 1% ;-)
