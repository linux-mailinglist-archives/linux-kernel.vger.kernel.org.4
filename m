Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9957668F6AF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjBHSNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHSND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:13:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA2E1BACB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675879982; x=1707415982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jbli7xfR68iVXzQ0pgj5/0O25sBe9dbuYE36QYk6OHk=;
  b=njkRPl4KrN21JBRrZyBl8TSm9j2nxN2PHwa7CimYIuPXZq27LksIk4MX
   X7Vn7oA5jZZAuW5FNeWSc4iLt8azRkyFWn5Zlzm223DnIPJ3MO8kbLiKZ
   1bkLpXaWNOaqUdp8ZiU1XDQoGwV+ymGz7JFM78VlPVQFnW56oH/2qmxlY
   C4V3PojTAgQiHOw7H+KWs7jkBF8gdzBhGBGW1I+XwldZNpttNDZfJ6GGs
   0iuwhTeWyyoS46bRVGrZ6s5Ifx9aGHk2/1ay5q9AkqpQLrgyY0wsSIkk1
   obGKtGvlblNBqtdJocPEMnTfRR0VR2ec6BLvxSHOwN8qU+J3B1etSojn3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331165817"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331165817"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 10:12:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="644958934"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="644958934"
Received: from tbacklun-mobl.amr.corp.intel.com (HELO [10.209.14.225]) ([10.209.14.225])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 10:12:46 -0800
Message-ID: <4808d3fa-bb68-d4c8-681f-0b2770d78041@intel.com>
Date:   Wed, 8 Feb 2023 10:12:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        tglx@linutronix.de, yue.li@memverge.com,
        Ravikumar.Bangoria@amd.com, ying.huang@intel.com
References: <20230208073533.715-1-bharata@amd.com>
 <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/23 10:03, Peter Zijlstra wrote:
>> - Hardware provided access information could be very useful for driving
>>   hot page promotion in tiered memory systems. Need to check if this
>>   requires different tuning/heuristics apart from what NUMA balancing
>>   already does.
> I think Huang Ying looked at that from the Intel POV and I think the
> conclusion was that it doesn't really work out. What you need is
> frequency information, but the PMU doesn't really give you that. You
> need to process a *ton* of PMU data in-kernel.

Yeah, there were two big problems.

First, IIRC, Intel PEBS at the time only gave guest virtual addresses in
the PEBS records.  They had to be translated back to host addresses to
be usable.  That was extra expensive.

Second, it *did* take a lot of processing to turn raw memory accesses
into actionable frequency data.  That meant that we started in a hole
performance-wise and had to make *REALLY* good decisions about page
migration to make up for it.

The performance data here don't look awful, but they don't seem to add
up to a clear win either.  I'm having a hard time imagining who would
turn this on and how widely it would get used in practice.
