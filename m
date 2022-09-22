Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA55C5E5EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIVJey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIVJeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:34:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 047C72F003
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:34:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55A2D16F8;
        Thu, 22 Sep 2022 02:34:55 -0700 (PDT)
Received: from [10.57.1.91] (unknown [10.57.1.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF463F73D;
        Thu, 22 Sep 2022 02:34:47 -0700 (PDT)
Message-ID: <adc70f4a-83f8-2bcc-87f1-28db004ae8e8@arm.com>
Date:   Thu, 22 Sep 2022 10:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/1] arm64: defconfig: Add Coresight as module
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220921140535.152627-1-james.clark@arm.com>
 <Yyso42iP40niLTxO@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Yyso42iP40niLTxO@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/09/2022 16:08, Catalin Marinas wrote:
> On Wed, Sep 21, 2022 at 03:05:34PM +0100, James Clark wrote:
>> As suggested by Catalin here's the change to add Coresight to defconfig.
>>
>> Unfortunately I don't think we should add CONFIG_CORESIGHT_SOURCE_ETM4X
>> which builds a few files until [1] is merged because of the overhead
>> of CONFIG_PID_IN_CONTEXTIDR.
>>
>> [1]: https://lore.kernel.org/lkml/20211021134530.206216-1-leo.yan@linaro.org/T/
> 
> I thought the overhead wasn't the problem, it's mostly negligible. We
> can probably save a few more cycles on the __switch_to() path by
> replacing several isb()s in those functions with a single one just
> before cpu_switch_to().
> 
> IIRC the issue is that unless a process runs in the root pid namespace,
> the actual pid written to contextidr is meaningless.

This is true, and Leo has recently disabled it in that scenario in
aab473867fed.

> 
> Now that you reminded me of that thread, I see three options (sorry, not
> entirely related to the defconfig updates):
> 
> 1. Remove CONFIG_PID_IN_CONTEXTIDR and corresponding code completely,
>    find other events to correlate the task with the trace.

Unfortunately when tracing per core we would need kernel timestamps in
the trace to correlate to the switch records. At the moment Coresight is
using a different clock source so it's not possible and we're still
using the context ID to correlate samples.

With FEAT_TRF in v8.4 it will be possible to do this and we've started
working towards that here: 0f00b223ea22. But we'd still have to support
older hardware too, so CONFIG_PID_IN_CONTEXTIDR can't be removed completely.

For SPE it's not required because we already have the right timestamps
in the samples and we've added support for no context IDs in the decoder
here: 27d113cfe892

> 
> 2. Always on CONFIG_PID_IN_CONTEXTIDR (we might as well remove the
>    Kconfig entry). This would write the root pid namespace value
>    (task_pid_nr()).

If we're not worried about the overhead after all, this would be the
easiest solution. And then SPE or Coresight already decide whether they
want to use the value or not, so no further changes are needed.

From Leo's patch there is a table that shows a 1% overhead with it
enabled permanently, and I've heard a figure like that mentioned before.
So I could also resurrect that patch to use static keys? Although it's a
bit more complicated, that would be my preference. And then we can have
that mode always on.

> 
> 3. Similar to (2) but instead write task_pid_nr_ns(). An alternative
>    here is to write -1 if the task is not in the root pid namespace.
> 
> Strong preference for (1).
> 
