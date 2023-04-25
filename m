Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE76EEA50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjDYW3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjDYW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:29:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C200D14443
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682461791; x=1713997791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m40LO4zU2cr5G6B0sLHNH6L6vAl4ntL8Zd7e76IQPgc=;
  b=TIYZ1rMeVqOZ1wM0pXfLtuLWpSCXEFeDRZeObEeNuTfLczapsqKW0LMN
   4jLg1WKAAb5EMTBukNUpn4MZ/DqJNeQNghrwOOkONEFhQlRefVk3o2Eau
   iQLv5vXDbu0Dp/2wi6sIFVzIEsz0pm/jvIzHWvSqjiHGcx7XMVNtD8DL/
   3UOVLpSAeI7iK7KB1qdzPxI9NebpCYdBIUbw/xu8Sfm5GofvzhRJaLyfW
   ECfWgMLKrRuMD9UPPvZUvIV1fxxOL0UWlMbLzejEUZJTlN8Wx7a0e/n9A
   xSz/yuDRmvhTy0TGCuBUncN4DuioWKiVAJLfWrpdDy82w8v1T16hOuVeI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="409884195"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="409884195"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 15:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="671107681"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="671107681"
Received: from smahadev-mobl.amr.corp.intel.com (HELO [10.209.78.92]) ([10.209.78.92])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 15:29:51 -0700
Message-ID: <ecdea7a8-a748-6ecb-5fc1-93d7eda3c54d@intel.com>
Date:   Tue, 25 Apr 2023 15:29:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <87o7nbzn8w.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 14:05, Thomas Gleixner wrote:
> The only consequence of looking at bit 0 of some random other leaf is
> that all CPUs which run stop_this_cpu() issue WBINVD in parallel, which
> is slow but should not be a fatal issue.
> 
> Tony observed this is a 50% chance to hang, which means this is a timing
> issue.

I _think_ the system in question is a dual-socket Westmere.  I don't see
any obvious errata that we could pin this on:

> https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-5600-specification-update.pdf

Andi Kleen had an interesting theory.  WBINVD is a pretty expensive
operation.  It's possible that it has some degenerative behavior when
it's called on a *bunch* of CPUs all at once (which this path can do).
If the instruction takes too long, it could trigger one of the CPU's
internal lockup detectors and trigger a machine check.  At that point,
all hell breaks loose.

I don't know the cache coherency protocol well enough to say for sure,
but I wonder if there's a storm of cache coherency traffic as all those
lines get written back.  One of the CPUs gets starved from making enough
forward progress and trips a CPU-internal watchdog.

Andi also says that it _should_ log something in the machine check banks
when this happens so there should be at least some kind of breadcrumb.

Either way, I'm hoping this hand waving satiates tglx's morbid curiosity
about hardware that came out from before I even worked at Intel. ;)
