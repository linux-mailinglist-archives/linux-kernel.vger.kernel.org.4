Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434476D4E98
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjDCRC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjDCRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:02:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1E52270E;
        Mon,  3 Apr 2023 10:02:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05706FEC;
        Mon,  3 Apr 2023 10:03:07 -0700 (PDT)
Received: from [10.57.20.195] (unknown [10.57.20.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1165B3F6C4;
        Mon,  3 Apr 2023 10:02:18 -0700 (PDT)
Message-ID: <cd91905d-2bf2-bd66-92d2-f6fb42f669e3@arm.com>
Date:   Mon, 3 Apr 2023 18:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] schedutil: trace: Add tracing to capture filter out
 requests
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
References: <20230322151843.14390-1-lukasz.luba@arm.com>
 <20230322151843.14390-4-lukasz.luba@arm.com>
 <20230403134646.shc2m57yvvnf2o54@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230403134646.shc2m57yvvnf2o54@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/23 14:46, Qais Yousef wrote:
> On 03/22/23 15:18, Lukasz Luba wrote:
>> Some of the frequency update requests coming form the task scheduler
>> might be filter out. It can happen when the previous request was served
>> not that long ago (in a period smaller than provided by the cpufreq driver
>> as minimum for frequency update). In such case, we want to know if some of
>> the frequency updates cannot make through.
>> Export the new tracepoint as well. That would allow to handle it by a
>> toolkit for trace analyzes.
> 
> I think you can use register_kretprobe() for this one. When functions are not
> inlined it should be easy to hook into them and you can get the return value of
> the function too.

Could be possible, but that's a different pattern to what we have in
terms of LISa. It's also a bit complicated for downstream folks to
understand when I would ask about the trace with a particular name.
The integration would be a bit more complicated and our tooling and CI
might be impacted but this different design approach. Therefore,
I prefer to be aligned with the old-school.

> 
> Check the usage in lib/test_kprobes.c. Creating the event in sched_tp should be
> the same way when registering for a tracepoint. They both are essentially the
> same.
> 
> Patches to sched_tp module would be welcome ;-)

I cannot promise, but I'll try to find some cycles for it :)

Cheers,
Lukasz

> 
> 
> Cheers
> 
> --
> Qais Yousef
> 
