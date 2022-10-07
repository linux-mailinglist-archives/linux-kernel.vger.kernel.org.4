Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228005F7C82
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJGRxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJGRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:53:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB156102DE4;
        Fri,  7 Oct 2022 10:53:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C1A7106F;
        Fri,  7 Oct 2022 10:53:13 -0700 (PDT)
Received: from [10.57.66.34] (unknown [10.57.66.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6906B3F792;
        Fri,  7 Oct 2022 10:53:05 -0700 (PDT)
Message-ID: <55170f1f-99f7-6e25-55d3-5d7247737afc@arm.com>
Date:   Fri, 7 Oct 2022 18:53:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v3 03/13] coresight: stm: Update STM driver to use Trace
 ID API
To:     Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
References: <20220809223401.24599-1-mike.leach@linaro.org>
 <20220809223401.24599-4-mike.leach@linaro.org>
 <65e70db9-9f85-7285-0602-f2d29887550a@arm.com>
 <CAJ9a7Vgz+0xEQO-MvGUzbsr_LBh4pDep7JJtFoA+cAeiAERJFw@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7Vgz+0xEQO-MvGUzbsr_LBh4pDep7JJtFoA+cAeiAERJFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 14:54, Mike Leach wrote:
> Hi Suzuki,
> 
> On Mon, 3 Oct 2022 at 10:04, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> On 09/08/2022 23:33, Mike Leach wrote:
>>> Updates the STM driver to use the trace ID allocation API.
>>> This uses the _system_id calls to allocate an ID on device poll,
>>> and release on device remove.
>>>
>>> The sysfs access to the STMTRACEIDR register has been changed from RW
>>> to RO. Having this value as writable is not appropriate for the new
>>> Trace ID scheme - and had potential to cause errors in the previous
>>> scheme if values clashed with other sources.
>>>
>>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>>> @@ -854,7 +830,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
>>>
>>>    static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>>>    {
>>> -     int ret;
>>> +     int ret, trace_id;
>>>        void __iomem *base;
>>>        struct device *dev = &adev->dev;
>>>        struct coresight_platform_data *pdata = NULL;
>>> @@ -938,12 +914,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>>>                goto stm_unregister;
>>>        }
>>>
>>> +     trace_id = coresight_trace_id_get_system_id();
>>> +     if (trace_id < 0) {
>>
>> The above API returns "INVALID_ID" and not a negative error status.
>> I think it is better to fix the API to return:
>>
>>     ret < 0  - If there is any error
>>              - Otherwise a positive integer
>> And the users should be kept unaware of which ID is valid or invalid.
>>
> 
> coresight_trace_id_get_system_id() returns the ID if one can be
> allocated or -EINVAL if not.
> 
> Not sure what you are looking at here.

Sorry, indeed I was mistaken there. It is the get_cpu_id() which
returns the INVALID_ID on failure. Please could we make that
consistent with this scheme ? i.e, < 0 on error.

Also, please could we add a comment above the exported functions
on their entry/exit criteria ? It is not clearly evident, unless
we follow the code and figure out.

Cheers
Suzuki

