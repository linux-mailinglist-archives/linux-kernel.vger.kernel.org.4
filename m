Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5417F6D2463
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjCaPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjCaPst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:48:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00C692032D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:48:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A96A416F2;
        Fri, 31 Mar 2023 08:49:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D7083F6C4;
        Fri, 31 Mar 2023 08:48:21 -0700 (PDT)
Message-ID: <7360f190-784c-8e49-7b3c-bea28e0456d9@arm.com>
Date:   Fri, 31 Mar 2023 17:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
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
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230330195157.afbqtusnnbnvtlyz@parnassus.localdomain>
 <20230331040609.GA184843@ziqianlu-desk2>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230331040609.GA184843@ziqianlu-desk2>
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

On 31/03/2023 06:06, Aaron Lu wrote:
> Hi Daniel,
> 
> Thanks for taking a look.
> 
> On Thu, Mar 30, 2023 at 03:51:57PM -0400, Daniel Jordan wrote:
>> On Thu, Mar 30, 2023 at 01:46:02PM -0400, Daniel Jordan wrote:
>>> Hi Aaron,
>>>
>>> On Wed, Mar 29, 2023 at 09:54:55PM +0800, Aaron Lu wrote:
>>>> On Wed, Mar 29, 2023 at 02:36:44PM +0200, Dietmar Eggemann wrote:
>>>>> On 28/03/2023 14:56, Aaron Lu wrote:
>>>>>> On Tue, Mar 28, 2023 at 02:09:39PM +0200, Dietmar Eggemann wrote:
>>>>>>> On 27/03/2023 07:39, Aaron Lu wrote:

[...]

>>> AMD EPYC 7J13 64-Core Processor
>>>     2 sockets * 64 cores * 2 threads = 256 CPUs
> 
> I have a vague memory AMD machine has a smaller LLC and cpus belonging
> to the same LLC is also not many, 8-16?
> 
> I tend to think cpu number of LLC play a role here since that's the
> domain where idle cpu is searched on task wake up time.
> 
>>>
>>> sysbench: nr_threads=256
>>>
>>> All observability data was taken at one minute in and using one tool at
>>> a time.
>>>
>>>     @migrations[1]: 1113
>>>     @migrations[0]: 6152
>>>     @wakeups[1]: 8871744
>>>     @wakeups[0]: 9773321

Just a thought: Could the different behaviour come from different
CPU numbering schemes (consecutive/alternate)?

(1) My Arm server:

numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
node 2 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
node 3 cpus: 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95


(2) Intel(R) Xeon(R) Silver 4314

$ numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62
node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63

[...]
