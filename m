Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A434A6D0235
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjC3Kzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjC3Kzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:55:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F298B9009;
        Thu, 30 Mar 2023 03:55:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDE4F2F4;
        Thu, 30 Mar 2023 03:56:05 -0700 (PDT)
Received: from [10.57.56.86] (unknown [10.57.56.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19F533F73F;
        Thu, 30 Mar 2023 03:55:18 -0700 (PDT)
Message-ID: <20c28979-53a7-19eb-16fd-4d8535454d4e@arm.com>
Date:   Thu, 30 Mar 2023 11:55:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Clark <james.clark@arm.com>
References: <20230329111422.3693-1-mike.leach@linaro.org>
 <20230329111422.3693-2-mike.leach@linaro.org> <ZCQx5HlPnxCIFaNQ@kernel.org>
 <ZCQyNnk/vfHZkSda@kernel.org>
 <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com>
 <ZCQ7nhrISA+jCfnI@kernel.org>
 <CAJ9a7VhJRnRe0A43=_X463432LvjL=S5buVgeq6rB8K8nDZb6A@mail.gmail.com>
 <ZCSRU8zvjjBHhq+x@kernel.org> <ZCS4XJaWg7NvaWb7@kernel.org>
 <20230330031307.GD252145@leoy-yangtze.lan>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230330031307.GD252145@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 04:13, Leo Yan wrote:
> On Wed, Mar 29, 2023 at 07:14:52PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
>>> Not here, I'll check after a call:
>>>
>>>    50     9.90 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
>>>      arch/arm/util/cs-etm.c: In function 'cs_etm_save_ete_header':
>>>      arch/arm/util/cs-etm.c:720:29: error: implicit declaration of function 'coresight_get_trace_id' [-Werror=implicit-function-declaration]
>>>        data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
>>>                                   ^~~~~~~~~~~~~~~~~~~~~~
>>
>> This function was removed in:
>>
>> Author: Mike Leach <mike.leach@linaro.org>
>> Date:   Wed Mar 29 12:14:21 2023 +0100
>>
>>      perf cs-etm: Update record event to use new Trace ID protocol
>>
>>      Trace IDs are now dynamically allocated.
>>
>> I'm removing this series from perf-tools-next, please address this issue
>> and send a v9.
> 
> I can reproduce this building failure.  I am curious for how to verify
> building for patch wise, the link [1] gives me some hints and below
> command works for me:
> 
>    $ git rebase -i --exec "make -C tools/perf clean && \
>      make -C tools/perf VF=1 DEBUG=1 CORESIGHT=1 && \
>      make -C tools/perf clean && \
>      make -C tools/perf VF=1 DEBUG=1" HEAD~3

Looks like perf-tools-next has some changes that has not reflected 
elsewhere. The ts_source patches are queued there, which is causing
the above build failure.

Mike,

Are you able to rebase your patches on perf-tools-next branch ?

Kind regards
Suzuki

> 
> Thanks,
> Leo
> 
> [1] https://stackoverflow.com/questions/26983700/git-run-shell-command-for-each-commit

