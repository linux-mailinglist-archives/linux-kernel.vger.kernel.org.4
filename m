Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE83465C2D7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbjACPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjACPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:16:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A42C1EA;
        Tue,  3 Jan 2023 07:16:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1F91516;
        Tue,  3 Jan 2023 07:16:45 -0800 (PST)
Received: from [10.57.41.181] (unknown [10.57.41.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5163F587;
        Tue,  3 Jan 2023 07:16:00 -0800 (PST)
Message-ID: <765577d3-cbdc-1371-f33e-ef6be42139dd@arm.com>
Date:   Tue, 3 Jan 2023 15:15:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/7] perf cs_etm: Record ts_source in AUXTRACE_INFO for
 ETMv4 and ETE
To:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221222160328.3639989-1-james.clark@arm.com>
 <20221222160328.3639989-7-james.clark@arm.com>
 <CAJ9a7VjbF2DFRHOtdCt=3o+iNrA++swpJBx9v5-R9Ky8tc4Mvw@mail.gmail.com>
 <5dad3c40-d4d2-57b8-e6f5-10fa5ef1a0b8@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <5dad3c40-d4d2-57b8-e6f5-10fa5ef1a0b8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 11:49, James Clark wrote:
> 
> 
> On 23/12/2022 09:28, Mike Leach wrote:
>> Hi,
>>
>> There was a discussion some time ago in one of our coresight regular
>> dev meetings about this.
>>
>> Can we just use only the necessary bits that TS source needs and leave
>> the remaining bits from the 64 as unused  for future expansion - i..e
>> use this as a bitfield rather than have 64 bits occupied for what is
>> effectively a 2 bit value.
>>
>> Perhaps call the full value something other than TS_SOURCE and have a
>> TS_SOURCE field with a known safe unset value.
> 
> If we did that, there wouldn't be any mechanism to detect if new values
> that were added were the value 0, or just not set/implemented/saved in
> the file. The current implementation of CS_ETM_NR_TRC_PARAMS allows us
> to add new fields, and detect if they exist or not without bumping the
> header version for each new sub field.
> 
> In this change HAS_PARAM() has been used to do this, but that can't be
> expanded to sub fields in the same 64 bits. I don't think space or
> performance are worth the extra complexity of dividing it up. And
> because this is just one block saved once in the header, so I'm not sure
> if it's worth it in this case. It would also make it harder to read the
> values on the raw dump mode.

I think it is fine to use the entire field for the time source, given
the header can be extended with new fields, without breaking
compatibility for future additions.

Suzuki

> 
> James

