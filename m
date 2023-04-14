Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF266E2C8A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDNWrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNWrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:47:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE965A8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681512454; x=1713048454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mdvcKvvzI8mYjdKCgB9vqCf/BvQrC4CWWX0mpgwmlFI=;
  b=W0rHmW25AAcfkB+wHsClxAkkrioAqu9c6bbt+e24aMazJCbVqhHRznKb
   pCZKLUfz6sDbSreZ5wklnSN+PgkT0mKmB140lVs7S4Tn4bpoPgLDkDpls
   w1U/batq1lDwsHTcfFBH2+P0wMB5qNYDsJG2vMMNuMpmRjKUst78p79qW
   hzZLEMsAy6ladurGhXcuQ6ukY4DK51MdIvRJjHRU5cOtaDc4JOx9xMo/O
   3cax5EUX8lEArntpAsqG/OAruV9nOticcqce7/pG0uMo607S8Jnv1E9ND
   cKjBUMGrXnq+tarYDzVgaPhiprAXlwklDmnFwKbxI3FSTA8urO9SHD+YN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="430879447"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="430879447"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 15:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="801354329"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="801354329"
Received: from akleen-mobl3.amr.corp.intel.com (HELO [10.251.29.213]) ([10.251.29.213])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 15:47:33 -0700
Message-ID: <d53d4df7-d0b8-2fbc-4912-f89686b5d931@linux.intel.com>
Date:   Fri, 14 Apr 2023 15:47:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
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
 <2428e6a2-9578-1e1d-bdef-ffcc87301503@linux.intel.com>
 <20230414220106.GC778423@hirez.programming.kicks-ass.net>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20230414220106.GC778423@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah, don't do this. There is no guarantee what so ever you'll get any
> of those events in the 0-3 range.


The kernel can simply force to 0-3 if LBR is enabled and the feature 
too. It's in Kan's patch

and it isn't particularly complicated.

>
> You really *must* make then a group such that perf knows what events to
> associated with the LBR event and constain them to the 0-3 range of
> PMCs.
>
> If you want multiplexing, simply create multiple groups with an LBR
> event in them.


Well if you force groups then you require user space or a user which 
understands all the constraints

to create groups. I thought one of the basic ideas of perf was to be 
able to abstract those things.

There are tools today (e.g. the perf builtin metrics[1] and I believe 
others) that don't have enough

knowledge to set up real groups and rely on the kernel.  While they 
could be fixed it's a lot of work

(I do it in pmu-tools, and it's quite hairy code)


-Andi


[1] Given they are are not supported by perf record yet, but since perf 
script already supports

evaluating them they could be at some point, and then it would make 
sense to use them

with this feature too.

