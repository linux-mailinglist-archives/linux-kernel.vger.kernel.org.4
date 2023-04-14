Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67066E2B27
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDNUfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDNUfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:35:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BFB5B9E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681504507; x=1713040507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7BSsLbY8tOejMePCFiWkY9De5oXFdkL9luABTcNIYtU=;
  b=HYFeW0FcuhPYBW6b+G7gmjQT+cLz/QlnhHiB8x8NEjhHY7mYHE2MYAF2
   8nuDk8+haOihORcLPm7o4TV37bfVysY6gTQVpztwteKE172TRtTcb2uH8
   eY0io6Mr6OD6TzvxABsy+vQU2RfRaMreErDNBqhfoQQ4Kq2PzXadvjQ3o
   lnyWzE3raJoQvni1we1VE6mL3LJuk+i2hdsqWJQAXO8AWdgIVwXJWJ2hA
   CpyNp9FkB/jd5DBB0xdzFldqPD5IlWYddD99+KBq70jkIWK9A7JVJOUWo
   ppsciskyVAyvc9KBKxo9LFtskpW7GmFU9JfdiuUQ7vdtlAhQPRXx3vfij
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="333346635"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="333346635"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 13:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="692548799"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="692548799"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 14 Apr 2023 13:34:48 -0700
Received: from [10.209.83.72] (kliang2-mobl1.ccr.corp.intel.com [10.209.83.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0169F5805CB;
        Fri, 14 Apr 2023 13:34:46 -0700 (PDT)
Message-ID: <2428e6a2-9578-1e1d-bdef-ffcc87301503@linux.intel.com>
Date:   Fri, 14 Apr 2023 16:34:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] perf: Support branch events logging
To:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
 <20230410204352.1098067-2-kan.liang@linux.intel.com>
 <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
 <20230414160945.GC761523@hirez.programming.kicks-ass.net>
 <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
 <20230414192407.GA778423@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230414192407.GA778423@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-14 3:24 p.m., Peter Zijlstra wrote:
> On Fri, Apr 14, 2023 at 01:53:24PM -0400, Liang, Kan wrote:
>>
>>
>> On 2023-04-14 12:09 p.m., Peter Zijlstra wrote:
>>> On Fri, Apr 14, 2023 at 11:56:41AM -0400, Liang, Kan wrote:
>>>>> If it were to only support 4, then
>>>>> we're in counter scheduling contraint hell again 
>>>>
>>>> Unfortunately, yes.
>>>>
>>>>> and we need to somehow
>>>>> group all these things together with the LBR event.
>>>>
>>>> Group will bring many limits for the usage. For example, I was told
>>>> there could be someone wants to use it with multiplexing.
>>>
>>> You can create two groups, each with an LBR event, no?
>>
>> If we put everything in a group, that will make the enabling much
>> simpler. I don't think the perf tool needs the order information
>> anymore. Because the kernel enables the events one by one in a group.
>> The kernel just need to convert the information from the counter order
>> to the enabling order and dump to user space.
> 
> I never understood the whole order thing. What was it trying to do?

Let's say we have three events with the LBR event logging feature as below.
    perf record -e branches,branches,instructions:ppp -j any,event

The counter 0 will be assigned to instructions:ppp, since the PDist is
only supported on GP 0 & 1.
The count 1 & 2 will be assigned to the other two branches.

If branches occurs 1 time and instructions occurs 3 times in a LBR
block, the LBR_INFO will have 0b010111 (counter order).

But as you can see from the perf command, the first event is actually
branches. Without the event IDs information, perf tool will interpret
that branches 3 branches 1 and instructions:ppp 1. That's wrong.

If there are multiple users, the situation becomes even worse.

> 
>> But if we have two groups with LBR event, the order information is still
>> required. Why we still want to group things?
> 
> Why would you need that; what is that whole order nonsense about?
> 
> {e1, e2, e3, e4}, {e5, e6, e7, e8} with e1 and e5 both having LBR on
> just works no?
> 
> Since they have LBR and that extra sample flag they all get a 0-3
> constraint.
> 
> Since both e1 and e5 use LBR, they're mutually exclusive, either e1 or
> e5 group runs.

It's possible that someone pins an event using LBR, and set more than 4
events for logging, e0:D,{e1, e2},{e3, e4},{e5, e6}. If so, those events
could do multiplexing. Without the event IDs information, perf tool has
no idea how to interpret the information.


Andi, do you have any other cases which require the multiplexing support
for LBR event logging.


Thanks,
Kan
