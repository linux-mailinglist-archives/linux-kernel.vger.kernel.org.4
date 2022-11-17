Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8467D62E7C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbiKQWIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbiKQWHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:07:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79512FC3C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668722850; x=1700258850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZRc5Z8KEnyqF+oNa/JCKbmm1r+pD3OUqdyUtmMFcDIo=;
  b=hNm7tYhmWY26RGTNjs1kkpFzms3T0i21Y5zNUpvAh97eaP4is4uLDlxV
   k3heh0ADiWeCbUbkpD7QFmG0xlJU4+dNjWrFkMzf+ti1WrynsNNFVBrog
   u3/+1o12Szv3hXLgfP6fqFqyVCZ10zCS/Nji6Oaxvymat0OX3JPa8e5wo
   yhmfE6hmqlA1oH2DoMIkoXtjox67eIiC0iRWLr0dcZ1yEYiyvrZ6lBdvA
   h7ni+3aYvMWuOdIYco4ctAg4+5X2+V7afUKisqiP11E/37AqeViUnX5Pw
   QmtIgKNjwBjTX8QrkttcYqB3538iwg3WI38+B5++7kBtempGHppq23K6R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="311693030"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="311693030"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 14:07:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="969043181"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="969043181"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.78.240]) ([10.209.78.240])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 14:07:30 -0800
Message-ID: <289e03d2-be50-4249-343a-75dae302b0e5@linux.intel.com>
Date:   Thu, 17 Nov 2022 14:07:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 18/46] entry, lto: Mark raw_irqentry_exit_cond_resched()
 as __visible
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-19-jirislaby@kernel.org> <87a64qo4th.ffs@tglx>
 <Y3XzkxNVTvdB4a/1@hirez.programming.kicks-ass.net>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <Y3XzkxNVTvdB4a/1@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I still don't understand any of it -- this symbol is not static (and
> thus lives in the global namespace and it's name must not be mangled
> lest it breaks ABI), this symbol has it's address taken, so it must not
> be eliminated.

It's not eliminated, but is still manged because gcc turns it into 
static due to

-fwhole-program. Maybe this could avoided in gcc, but at least that's 
what it does currently.

I believe disabling -fwhole-program would likely avoid it, but it would 
also prevent some code

transformations because gcc would need to assume that every function can 
be called by

someone it doesn't see.

> WTF does this crazy LTO thing require __visible on it?
>
> The original Changelog babbles something about multiple object files,
> which doesn't make sense either, there is only a single object file with
> LTO -- that's sort of the whole point. The translation unit output
> becomes some intermediate gunk -- to be used as input for the LTO pass,
> but it is not an ELF object file.
>
> The linker takes all these intermediate files, does the global
> optimization thing and then generates a real ELF object file.

That would be a single threaded very very slow global compilation. 
Instead gcc WHOPR uses

partitioning to generate smaller units that can be compiled in parallel 
based on their call dependencies,

and these use different object files from the individual assembler 
invocations.

>
> Anyway; I think we can drop all this crazy on the floor again, since per
> the 0/n (which I didn't get) there isn't any actual benefit from using
> GCC-LTO, so why should we bother with all this ugly.

At least in the past it generated smaller kernels for small configurations.

One benefit that wasn't mentioned is doing type and other checks (e.g. 
constant propagation

through inlining) across files.

In general LTO gives the compiler a lot more freedom to optimize code, 
so even if it's not quite there

yet I think it's beneficial to let users play around with it and see if 
they can get benefits.



-Andi

