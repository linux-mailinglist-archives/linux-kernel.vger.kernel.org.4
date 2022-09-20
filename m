Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F665BEE69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiITUXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiITUXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:23:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27374599B;
        Tue, 20 Sep 2022 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663705410; x=1695241410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h6Lk3Kl+Tj08loLMM88M6zJHOl87KGlYmN1WgADQzWE=;
  b=mtrzisQXIfZ5PUpay3iRPa6v+8D+WguNrBawnWIK1jlVjwGLheVNAsFE
   vFWou+6JX0ckHZjh+M2dEaecBm54XzjIFXP6u86UXprNP8GuhKbUmJDFt
   SQ/Vopab0CmSaGJ56kXNE7P5TL1G/nTwSFEmgU7OO5cEvOo8ADkcdeOV3
   7oOzBU8NFUryrCqmBOrTNpCVms7KXLPg8n64qetS54pyAktn1myin/WCS
   IQ/raM9Zb5ZyuF1FsZT/Xw8SCrK3i9PoYP+BNjNNDQbXpXcc8pxKat1eL
   AMvgKSSCMI+Xpl48DecLrz19i2bwGNC1y4vVeI5QwDsjtxeUuDSFv4+pp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="300648920"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="300648920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 13:23:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="649744727"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.25.89]) ([10.212.25.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 13:23:29 -0700
Message-ID: <afdac388-061e-a403-3b9e-1273cee98509@intel.com>
Date:   Tue, 20 Sep 2022 13:23:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-2-ira.weiny@intel.com>
 <20220824165058.00007d4f@huawei.com> <Yxgd51zdrk9pEXE6@iweiny-mobl>
 <20220908135240.00001217@huawei.com> <Yxun42yjtZREEeRv@iweiny-desk3>
 <20220920164904.00001be8@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220920164904.00001be8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/2022 8:49 AM, Jonathan Cameron wrote:
> On Fri, 9 Sep 2022 13:53:55 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
>
>> On Thu, Sep 08, 2022 at 01:52:40PM +0100, Jonathan Cameron wrote:
>>>    
>> [snip]
>>
>>>>>> diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..f4baeae66cf3
>>>>>> --- /dev/null
>>>>>> +++ b/include/trace/events/cxl-events.h
>>>>>> @@ -0,0 +1,127 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>> +#undef TRACE_SYSTEM
>>>>>> +#define TRACE_SYSTEM cxl_events
>>>>>> +
>>>>>> +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
>>>>>> +#define _CXL_TRACE_EVENTS_H
>>>>>> +
>>>>>> +#include <linux/tracepoint.h>
>>>>>> +
>>>>>> +#define EVENT_LOGS					\
>>>>>> +	EM(CXL_EVENT_TYPE_INFO,		"Info")		\
>>>>>> +	EM(CXL_EVENT_TYPE_WARN,		"Warning")	\
>>>>>> +	EM(CXL_EVENT_TYPE_FAIL,		"Failure")	\
>>>>>> +	EM(CXL_EVENT_TYPE_FATAL,	"Fatal")	\
>>>>>> +	EMe(CXL_EVENT_TYPE_MAX,		"<undefined>")
>>>>> Hmm. 4 is defined in CXL 3.0, but I'd assume we won't use tracepoints for
>>>>> dynamic capacity events so I guess it doesn't matter.
>>>> I'm not sure why you would say that.  I anticipate some user space daemon
>>>> requiring these events to set things up.
>>> Certainly a possible solution. I'd kind of expect a more hand shake based approach
>>> than a tracepoint.  Guess we'll see :)
>> Yea I think we should wait an see.
>>
>>>    
>>>>>      
>>>>>> +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
>>>>>> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
>>>>>> +)
>>>>>> +
>>>>>> +TRACE_EVENT(cxl_event,
>>>>>> +
>>>>>> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
>>>>>> +		 struct cxl_event_record_raw *rec),
>>>>>> +
>>>>>> +	TP_ARGS(dev_name, log, rec),
>>>>>> +
>>>>>> +	TP_STRUCT__entry(
>>>>>> +		__string(dev_name, dev_name)
>>>>>> +		__field(int, log)
>>>>>> +		__array(u8, id, UUID_SIZE)
>>>>>> +		__field(u32, flags)
>>>>>> +		__field(u16, handle)
>>>>>> +		__field(u16, related_handle)
>>>>>> +		__field(u64, timestamp)
>>>>>> +		__array(u8, data, EVENT_RECORD_DATA_LENGTH)
>>>>>> +		__field(u8, length)
>>>>> Do we want the maintenance operation class added in Table 8-42 from CXL 3.0?
>>>>> (only noticed because I happen to have that spec revision open rather than 2.0).
>>>> Yes done.
>>>>
>>>> There is some discussion with Dan regarding not decoding anything and letting
>>>> user space take care of it all.  I think this shows a valid reason Dan
>>>> suggested this.
>>> I like being able to print tracepoints with out userspace tools.
>>> This also enforces structure and stability of interface which I like.
>> I tend to agree with you.
>>
>>> Maybe a raw tracepoint or variable length trailing buffer to pass
>>> on what we don't understand?
>> I've already realized that we need to print all reserved fields for this
>> reason.  If there is something the kernel does not understand user space can
>> just figure it out on it's own.
>>
>> Sound reasonable?
> Hmm. Printing reserved fields would be unusual.  Not sure what is done for similar
> cases elsewhere, CPER records etc...
>
> We could just print a raw array of the whole event as well as decode version, but
> that means logging most of the fields twice...
>
> Not nice either.
>
> I'm a bit inclined to say we should maybe just ignore stuff we don't know about or
> is there a version number we can use to decide between decoded vs decoded as much as
> possible + raw log?

libtraceevent can pull the trace event data structure fields directly. 
So the raw data can be pulled directly from the kernel. And what gets 
printed to the trace buffer can be decoded data constructed from those 
fields by the kernel code. So with that you can have access both.

>
> Jonathan
>
>> Ira
>>
>>> Jonathan
>>>
>>>    
