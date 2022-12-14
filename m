Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E004064CC24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiLNO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:26:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F20120355;
        Wed, 14 Dec 2022 06:26:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38235FEC;
        Wed, 14 Dec 2022 06:27:29 -0800 (PST)
Received: from [10.57.10.207] (unknown [10.57.10.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 460FE3F73B;
        Wed, 14 Dec 2022 06:26:46 -0800 (PST)
Message-ID: <b26a4193-6d58-2bee-4d93-1337a4dbf226@arm.com>
Date:   Wed, 14 Dec 2022 14:26:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     =?UTF-8?Q?Adri=c3=a1n_Herrera_Arcila?= <adrian.herrera@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, songliubraving@fb.com, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com>
 <e3e123db-5321-c96e-1753-27059c729640@arm.com> <Y5iPsjF/lEsEldU8@kernel.org>
 <CAM9d7cj=Pu2QAONzd2JSVzd_X9DakeV=khcFGD_d-ES5zrx+KQ@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7cj=Pu2QAONzd2JSVzd_X9DakeV=khcFGD_d-ES5zrx+KQ@mail.gmail.com>
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



On 13/12/2022 16:40, Namhyung Kim wrote:
> Hi,
> 
> On Tue, Dec 13, 2022 at 6:44 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Mon, Aug 01, 2022 at 09:20:37AM +0100, James Clark escreveu:
>>>
>>>
>>> On 29/07/2022 17:12, Adrián Herrera Arcila wrote:
>>>> The described --delay behaviour is to delay the enablement of events, but
>>>> not the execution of the command, if one is passed, which is incorrectly
>>>> the current behaviour.
>>>>
>>>> This patch decouples the enablement from the delay, and enables events
>>>> before or after launching the workload dependent on the options passed
>>>> by the user. This code structure is inspired by that in perf-record, and
>>>> tries to be consistent with it.
>>>>
>>>> Link: https://lore.kernel.org/linux-perf-users/7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com
>>>> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
>>>> Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>
>>>> ---
>>>>  tools/perf/builtin-stat.c | 56 ++++++++++++++++++++++-----------------
>>>>  1 file changed, 32 insertions(+), 24 deletions(-)
>>>
>>> Looks good to me. Fixes the counter delay issue and the code is pretty
>>> similar to perf record now. Although I would wait for Leo's or Song's
>>> comment as well because they were involved.
>>
>> I think I didn't notice Leo's ack, it still applies, so I'm doing it
>> now.
> 
> I think the BPF counters should be enabled/disabled together.

I did notice that difference between the two, but I wasn't sure of the
exact reason that it was done that way on Adrián's version. It seems
like it's not separated in perf record so maybe you are right.

> 
> Thanks,
> Namhyung
