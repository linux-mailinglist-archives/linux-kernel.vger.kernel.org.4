Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0CC680CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjA3MHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjA3MHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:07:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E9F836089;
        Mon, 30 Jan 2023 04:06:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A6D31713;
        Mon, 30 Jan 2023 04:06:38 -0800 (PST)
Received: from [10.57.46.219] (unknown [10.57.46.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D3383F71E;
        Mon, 30 Jan 2023 04:05:54 -0800 (PST)
Message-ID: <f17a40d4-2a37-fe7a-eac9-4ac1215e2c20@arm.com>
Date:   Mon, 30 Jan 2023 12:05:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] perf: cs-etm: Update decoder code for OpenCSD version 1.4
Content-Language: en-US
To:     "acme@kernel.org" <acme@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Ian Rogers <irogers@google.com>
References: <20230120153706.20388-1-mike.leach@linaro.org>
 <77f9eab5-4fb2-cf96-9628-2a816d519d61@arm.com>
 <CAP-5=fWNT9XXMN+97TcprxWA+FRJpAy4T=XC9RHrOdKfcKi8_w@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWNT9XXMN+97TcprxWA+FRJpAy4T=XC9RHrOdKfcKi8_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/01/2023 21:50, Ian Rogers wrote:
> On Fri, Jan 20, 2023 at 7:47 AM James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 20/01/2023 15:37, Mike Leach wrote:
>>> OpenCSD version 1.4 is released with support for FEAT_ITE.
>>> This adds a new packet type, with associated output element ID in
>>> the packet type enum - OCSD_GEN_TRC_ELEM_INSTRUMENTATION.
>>>
>>> As we just ignore this packet in perf, add to the switch statement
>>> to avoid the "enum not handled in switch error", but conditionally
>>> so as not to break the perf build for older OpenCSD installations.
>>>
>>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>>> ---
>>>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> index fa3aa9c0fb2e..48e7121880a9 100644
>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> @@ -604,6 +604,9 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>>>       case OCSD_GEN_TRC_ELEM_CUSTOM:
>>>       case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
>>>       case OCSD_GEN_TRC_ELEM_MEMTRANS:
>>> +#if (OCSD_VER_NUM >= 0x010400)
>>> +     case OCSD_GEN_TRC_ELEM_INSTRUMENTATION:
>>> +#endif
>>>       default:
>>>               break;
>>>       }
>>
>> Checked the build with both old and new versions of OpenCSD and it's ok:
>>
>> Reviewed-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian

Hi Arnaldo,

Is it ok to merge this change? If anyone is building with the latest
OpenCSD they will get a build error on the unhandled switch case, and we
just got it in our CI too.

I suppose we could disable the warning around this switch, but it's
pretty rare to add new packets so might be best to leave it.

Thanks
James
