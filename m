Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9E6BE508
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCQJKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCQJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:10:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48EF546BF;
        Fri, 17 Mar 2023 02:10:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE051480;
        Fri, 17 Mar 2023 02:10:56 -0700 (PDT)
Received: from [10.57.53.217] (unknown [10.57.53.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77A043F64C;
        Fri, 17 Mar 2023 02:10:10 -0700 (PDT)
Message-ID: <d304145e-dcc6-60db-fca2-920a0e75ef3e@arm.com>
Date:   Fri, 17 Mar 2023 09:10:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] coresight: core: Add sysfs node to reset all sources and
 sinks
To:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230208111630.20132-1-quic_jinlmao@quicinc.com>
 <CAJ9a7ViBS9K6cKsOi3btw1b5cM9VTSb-q8s6W3WUAgeW3-T2Sg@mail.gmail.com>
 <CAJ9a7ViA5BsbLjRWMsttmpmcPh1yUXK8J79k-pqYybVZkMQHXQ@mail.gmail.com>
 <bb6c9df9-af9b-873e-85bd-a29d00bb39d7@arm.com>
 <1d9b8ee8-c3f2-99bc-cd4e-8c2dd0f04b2b@quicinc.com>
 <CAJ9a7Vh08A8b7YLF=pYPudB0CZ0XjEpF=4YHrNNd7xo_JQGYaA@mail.gmail.com>
 <0308d380-bc8b-cb66-55cd-b0934d8f9676@quicinc.com>
 <6320e079-4fc8-f435-52e5-6d5ad1369d84@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <6320e079-4fc8-f435-52e5-6d5ad1369d84@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 06:18, Jinlong Mao wrote:
> 
> On 3/1/2023 11:04 PM, Jinlong Mao wrote:
>> Hi Mike & Suzuki,
>>
>> On 2/9/2023 10:56 PM, Mike Leach wrote:
>>> Hi,
>>>
>>> On Thu, 9 Feb 2023 at 03:02, Jinlong Mao <quic_jinlmao@quicinc.com> 
>>> wrote:
>>>>
>>>> On 2/9/2023 12:36 AM, Suzuki K Poulose wrote:
>>>>> On 08/02/2023 16:20, Mike Leach wrote:
>>>>>> Quick correction - you need to look for enable_source  / enable_sink
>>>>>> files and disable those that are currently '1'
>>>>>>
>>>>>> Mike
>>>>>>
>>>>>> On Wed, 8 Feb 2023 at 16:16, Mike Leach <mike.leach@linaro.org> 
>>>>>> wrote:
>>>>>>> Hi
>>>>>>>
>>>>>>> As this is a sysfs only update - would it not be easier to simply 
>>>>>>> use
>>>>>>> a shell script to iterate through coresight/devices/ looking for
>>>>>>> disable_source / disable_sink files and setting those accordingly?
>>>>>>>
>>>>>>> See tools/perf/tests/shell/test_arm_coresight.sh for an example of a
>>>>>>> script that does similar iteration to test coresight in perf
>>>>>>>
>>>>> +1
>>>>>
>>>>> Suzuki
>>>> Hi Mike & Suzuki,
>>>>
>>>> Sometimes user just want to have some quick test from PC with adb 
>>>> commands.
>>>> It is very easy to reset all sources and sinks' status by command 
>>>> below.
>>>> echo 1 > /sys/bus/coresight/reset_source_sink
>>>>
>>> Users of coresight via sysfs will have to know how to use the
>>> coresight infrastructure in order to enable the sources and sinks in
>>> the first place -
>>> e.g
>>> echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
>>> echo 1 > /sys/bus/coresight/devices/etm0/enable_source
>>>
>>> Given that they are aware of which sources and sinks they enabled -
>>> disabling them should be simple.
>>>
>>>
>>>> Preparing the script for test is not easy for users who are not 
>>>> familiar
>>>> with the coresight framework.
>>>>
>>> If there is a genuine use case were a user has opened so many sources
>>> on the command line that they need a simpler way of closing them than
>>> repeating the enabled commands with an
>>> echo 0 > ...
>>> then any script could be shipped as part of kernel/tools/coresight or
>>> kernel/samples/coresight - they would not have to write it themselves,
>>> and just run it from the command line - for example :-
>>> ./kernel/tools/coresight/scripts/sysfs_disable_sources_and_sinks.sh
>>>
>>> Realistically users will only try out a couple of devices as the
>>> usefulness of the sysfs interface is really limited to testing or
>>> board bring up.
>>> Any complex use with sysfs - as in the coresight tests I mentioned
>>> earlier is really going to be done by scripting.
>>>
>>>
>>> Regards
>>>
>>> Mike
>>
>> There is also requirement that reset all the sources and sinks in an 
>> user space daemon.
>> For such requirement, I think it is better to use only once sysfs node 
>> instead of iterating through coresight/device folder in an user space 
>> daemon.
> 
> Hi Mike & Suzuki,
> 
> In our internal build, there is binary executable which can configure 
> coresight source/sink.
> Before running the case, it will disable all the sources and sinks by 
> writing reset_source_sink node to
> avoid any other source packet's impact.

How does that justify this patch ? Your internal build depending on
something is your code. It looks like there is more to these patches
than what you are disclosing. e.g., with the dummy device series.

Please could you paint a complete picture and call out the dependencies
/ requirements for what you are trying to achieve ?

Kind regards
Suzuki

> 
> 
> Thanks
> Jinlong Mao
> 
>>
>> Thanks
>> Jinlong Mao
>>
>>>> Thanks
>>>> Jinlong Mao
>>>>
>>>>>
>>>
>>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org

