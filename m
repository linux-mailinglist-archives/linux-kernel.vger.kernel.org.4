Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708946CA6FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjC0OLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjC0OLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:11:22 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5481731
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1679926265;
        bh=aGOWdDAvblJvkxft0rb7GEZJ7xaotpHuUGK3Z7HZpVY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NhHuyw7bzH5BtPkQv56V+s+cmamsR555WlDnNG2q7J+Sq1I7D8FdjgHeNopQGeSy7
         Fwl7j+baiBVRb5RmjPx7AezqSiTyB9qH0mZ7EtQ7ZH7piWHVkT06Z/fPb97YgaW+fg
         bKxaiPH426S/+merlxicOR8s488McmJOZgoYaSrYET4PdgddjI6xzxIa7tbF4ZDM4l
         Bt4OzCKHHjJeY3q69nVK1AgHNn7DNqjyxo8bjLUjRiPEovwIHkSqo8KfqeHMw1lGcC
         Cxacg+Bu4f2K7/ErQhXuM7njizi+FnJIObAkHHemDeVA54OO+XOo1IxhlLk0ahbiU9
         X35/Q/zzMH0Kw==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PlZVK59xVzshS;
        Mon, 27 Mar 2023 10:11:05 -0400 (EDT)
Message-ID: <e3ce9a99-cd58-2e0f-8d4e-7881da8d99ec@efficios.com>
Date:   Mon, 27 Mar 2023 10:11:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: rq lock contention due to commit af7f588d8f73
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20230327080502.GA570847@ziqianlu-desk2>
 <b5e09943-36e6-c89b-4701-5af6408223e8@efficios.com>
 <20230327140425.GA1090@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230327140425.GA1090@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 10:04, Aaron Lu wrote:
> On Mon, Mar 27, 2023 at 09:20:44AM -0400, Mathieu Desnoyers wrote:
>> On 2023-03-27 04:05, Aaron Lu wrote:
>>> Hi Mathieu,
>>>
>>> I was doing some optimization work[1] for kernel scheduler using a
>>> database workload: sysbench+postgres and before I submit my work, I
>>> rebased my patch on top of latest v6.3-rc kernels to see if everything
>>> still works expected and then I found rq's lock became very heavily
>>> contended as compared to v6.2 based kernels.
>>>
>>> Using the above mentioned workload, before commit af7f588d8f73("sched:
>>> Introduce per-memory-map concurrency ID"), the profile looked like:
>>>
>>>        7.30%     0.71%  [kernel.vmlinux]            [k] __schedule
>>>        0.03%     0.03%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
>>>
>>> After that commit:
>>>
>>>       49.01%     0.87%  [kernel.vmlinux]            [k] __schedule
>>>       43.20%    43.18%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
>>>
>>> The above profile was captured with sysbench's nr_threads set to 56; if
>>> I used more thread number, the contention would be more severe on that
>>> 2sockets/112core/224cpu Intel Sapphire Rapids server.
>>>
>>> The docker image I used to do optimization work is not available outside
>>> but I managed to reproduce this problem using only publicaly available
>>> stuffs, here it goes:
>>> 1 docker pull postgres
>>> 2 sudo docker run --rm --name postgres-instance -e POSTGRES_PASSWORD=mypass -e POSTGRES_USER=sbtest -d postgres -c shared_buffers=80MB -c max_connections=250
>>> 3 go inside the container
>>>     sudo docker exec -it $the_just_started_container_id bash
>>> 4 install sysbench inside container
>>>     sudo apt update and sudo apt install sysbench
>>> 5 prepare
>>>     root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=56 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua prepare
>>> 6 run
>>>     root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=56 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua run
>>>
>>> Let it warm up a little bit and after 10-20s you can do profile and see
>>> the increased rq lock contention. You may need a machine that has at
>>> least 56 cpus to see this, I didn't try on other machines.
>>>
>>> Feel free to let me know if you need any other info.
>>
>> While I setup my dev machine with this reproducer, here are a few
>> questions to help figure out the context:
>>
>> I understand that pgsql is a multi-process database. Is it strictly
>> single-threaded per-process, or does each process have more than
>> one thread ?
> 
> I do not know the details of Postgres, according to this:
> https://wiki.postgresql.org/wiki/FAQ#How_does_PostgreSQL_use_CPU_resources.3F
> I think it is single-threaded per-process.
> 
> The client, sysbench, is single process multi-threaded IIUC.
> 
>>
>> I understand that your workload is scheduling between threads which
>> belong to different processes. Are there more heavily active threads
>> than there are scheduler runqueues (CPUs) on your machine ?
> 
> In the reproducer I described above, 56 threads are started on the
> client side and if each client thread is served by a server process,
> there would be about 112 tasks. I don't think the client thread and
> the server process are active at the same time but even if they are,
> 112 is still smaller than the machine's CPU number: 224.
> 
>>
>> When I developed the mm_cid feature, I originally implemented two additional
>> optimizations:
>>
>>      Additional optimizations can be done if the spin locks added when
>>      context switching between threads belonging to different memory maps end
>>      up being a performance bottleneck. Those are left out of this patch
>>      though. A performance impact would have to be clearly demonstrated to
>>      justify the added complexity.
>>
>> I suspect that your workload demonstrates the need for at least one of those
>> optimizations. I just wonder if we are in a purely single-threaded scenario
>> for each process, or if each process has many threads.
> 
> My understanding is: the server side is single threaded and the client
> side is multi threaded.

Indeed, I just validated this by successfully running your reproducer 
locally, and htop confirms that the client is single-process with many 
threads, and the server is multi-process, each with a single thread.

So in this case, the simple "single-threaded process" optimization would 
not work, because the client-side is multi-threaded. So the scheduler 
will switch back and forth between the client process and the server 
processes.

So this appears to call for my mm_cid runqueue cache.

Thanks,

Mathieu


> 
> Thanks,
> Aaron

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

