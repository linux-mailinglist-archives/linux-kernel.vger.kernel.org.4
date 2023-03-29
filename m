Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBFD6CEEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC2QMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2QMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:12:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00FB05FD6;
        Wed, 29 Mar 2023 09:11:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C8D72F4;
        Wed, 29 Mar 2023 09:12:12 -0700 (PDT)
Received: from [10.57.19.43] (unknown [10.57.19.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E9B23F6C4;
        Wed, 29 Mar 2023 09:11:26 -0700 (PDT)
Message-ID: <6dcf83ad-bfbc-7e59-7c86-bed334bd09e8@arm.com>
Date:   Wed, 29 Mar 2023 17:11:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Yang Shi <shy828301@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mathieu.poirier@linaro.org, adrian.hunter@intel.com,
        Jiri Olsa <jolsa@kernel.org>, acme@redhat.com,
        mike.leach@linaro.org, Will Deacon <will@kernel.org>,
        suzuki.poulose@arm.com
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com>
 <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan>
 <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
 <20230313121420.GB2426758@leoy-yangtze.lan>
 <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
 <20230314003610.GD2426758@leoy-yangtze.lan>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230314003610.GD2426758@leoy-yangtze.lan>
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



On 14/03/2023 00:36, Leo Yan wrote:
> On Mon, Mar 13, 2023 at 11:15:44AM -0700, Yang Shi wrote:
> 
> [...]
> 
>>> Just a quick summary, here we have two issues:
>>>
>>> - With command:
>>>   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
>>>   -- taskset --cpu-list 1 uname",
>>>
>>>   perf doesn't enable "text poke" attribution.
>>
>> No, it enables "text poke" and perf fails to decode coresight trace
>> data too. It doesn't matter whether "--kcore" is after or before "-e
>> cs/etm/@tmc_etf63/k".
> 
> Understand now.  Thanks for correction, if so we can ignore this one.
> 
> Leo

To me it looks like it's only --per-thread and --kcore together that
cause the issue. I can't see if that was mentioned previously in this
thread.

If it is --per-thread that's causing the issue then I think I have an
idea why it might be. There are some assumptions and different paths
taken in decoding in that mode that aren't correct. It causes some other
issues to do with ordering and timestamps as well and I wanted to fix it
previously. I wouldn't say that the text-poke change has caused a
regression, as decoding in this mode was always a bit buggy.

Maybe this is another reason to fix it properly.
