Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FB16E4A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjDQNhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDQNha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:37:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A1BA26D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681738641; x=1713274641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hbO/1scnM9QuUF/UNExOVwhll8HImOqOebXmS3aAvxc=;
  b=eNhW75K/I5WtCNA+Tg7T4DOP4TntFm3Z7tKgL5toE/ZX0ui+/qhUCqA+
   DckMUhaWjIsto6EvdQbQsvk9OsmvklWPvisrw0jlPivelUsLezomzHG25
   chh97V9xSl1iZvKdcz2ypGSzhc17UH9TRnQIo4d8iCc4lZn0f//ZPaeEo
   X/JzFy0B9WBahtrsOdmQPF1uVYXitfRBGozucOJO5v1sHT37/lQew7se4
   G0op6YoJPn76/dK4+3aNn4V5KFS5VPbb9A3UYS/zoO3hfmPTXSw829eYd
   k95j316jpoZaF4ngvgc6IqKNODrcu1dLz9gi/yepby69SOSLBw6TgLX4o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="431182910"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="431182910"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 06:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684157552"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="684157552"
Received: from akleen-mobl3.amr.corp.intel.com (HELO [10.209.71.14]) ([10.209.71.14])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 06:37:20 -0700
Message-ID: <b008c6c8-5c6a-7a65-d123-058d7e8456b0@linux.intel.com>
Date:   Mon, 17 Apr 2023 06:37:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com
References: <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
 <20230414160945.GC761523@hirez.programming.kicks-ass.net>
 <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
 <20230414192407.GA778423@hirez.programming.kicks-ass.net>
 <2428e6a2-9578-1e1d-bdef-ffcc87301503@linux.intel.com>
 <20230414220106.GC778423@hirez.programming.kicks-ass.net>
 <d53d4df7-d0b8-2fbc-4912-f89686b5d931@linux.intel.com>
 <20230417114654.GL83892@hirez.programming.kicks-ass.net>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20230417114654.GL83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2023 4:46 AM, Peter Zijlstra wrote:
> On Fri, Apr 14, 2023 at 03:47:29PM -0700, Andi Kleen wrote:
>>> Yeah, don't do this. There is no guarantee what so ever you'll get any
>>> of those events in the 0-3 range.
>>
>> The kernel can simply force to 0-3 if LBR is enabled and the feature too.
>> It's in Kan's patch
>>
>> and it isn't particularly complicated.
> And what, totally leave 4-7 unused even if those counters were not
> related to LBR at all? That seems exceedingly daft.


Only for the events which enabled LBR and also only if the branch events 
feature is enabled

-j event -e '{event1:b,event2:b,event3:b,event4:b,event5,event6}'

event5 and 6 can go > 3

Given there is currently no syntax to control branch events inside a 
group other than fully enabling/disabling LBR.

Kan, I guess that could be added to the user tools.

-Andi

