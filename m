Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5769179E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjBJEkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBJEkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:40:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7753A59C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676004015; x=1707540015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7nMwTcP+iq7uKvjjcoMQMMMq/DesyLZuMxTSuuEj5+M=;
  b=Flm/WC7//E3eN6tYjClSQOR3Ni4+WM+TNJ+RBqJ2HpJ7HLIwuWGenwUd
   B4xurJbvNlH7UYXD/MO79FrrLyKLWU472Pcp2KAg/dYdOZbXpKbumymka
   5RhTXQZiWjzbyLHzror+GWosrrpqYAA18a+XrB5jeya9oZpdROl1vW3zu
   fYZHz+AQ/j+/bVTh+7EDOSXZDKTx7XwYmJOZYStmBYqGHcU8TVCZZOwIM
   rPDsQ28OFYJEINlC7Ne+gQX21b47j4yqvJNiYswdPrgOuFmAVgBzYam/m
   6sp8qUHdL+j2k7RXD0F7SjqQrhHEKgt+lWSGexggk8xC6vfcdZK7TQQHX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328026927"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="328026927"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 20:40:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667926623"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="667926623"
Received: from cmontgom-mobl.amr.corp.intel.com (HELO [10.209.41.234]) ([10.209.41.234])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 20:40:11 -0800
Message-ID: <fbd1cf44-3643-4274-5a42-3516d4842830@intel.com>
Date:   Thu, 9 Feb 2023 20:40:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        tglx@linutronix.de, yue.li@memverge.com,
        Ravikumar.Bangoria@amd.com, ying.huang@intel.com
References: <20230208073533.715-1-bharata@amd.com>
 <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
 <4808d3fa-bb68-d4c8-681f-0b2770d78041@intel.com>
 <369bef08-92cc-9b55-823f-1fe780532967@amd.com>
 <9848226e-2574-b8e0-4fb4-316957f57fb5@intel.com>
 <e0a8ff65-b0f9-1f63-a3a0-2986eb79846f@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <e0a8ff65-b0f9-1f63-a3a0-2986eb79846f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 20:28, Bharata B Rao wrote:
> On 2/9/2023 7:58 PM, Dave Hansen wrote:
>> On 2/8/23 22:04, Bharata B Rao wrote:
>>>> First, IIRC, Intel PEBS at the time only gave guest virtual addresses in
>>>> the PEBS records.  They had to be translated back to host addresses to
>>>> be usable.  That was extra expensive.
>>> Just to be clear, I am using IBS in host only and it can give both virtual
>>> and physical address.
>> Could you talk a little bit about how IBS might get used for NUMA
>> balancing guest memory?
> IBS can work for guest, but will not provide physical address. Also
> the support for virtualized IBS isn't upstream yet.
> 
> However I am not sure how effective or useful NUMA balancing within a guest
> is, as the actual physical addresses are transparent to the guest.
> 
> Additionally when using IBS in host, it is possible to prevent collection
> of samples from secure guests by using the PreventHostIBS feature.
> (https://lore.kernel.org/linux-perf-users/20230206060545.628502-1-manali.shukla@amd.com/T/#)
I was wondering specifically about how a host might use IBS to balance
guest memory transparently to the guest.  Now how a guest might use IBS
to balance its own memory.
