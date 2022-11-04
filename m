Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE24061A4E8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiKDWwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiKDWwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:52:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B334E423
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667602220; x=1699138220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vqfTxlpErbNaQT6peaUAVe+NDRK4xxYm7fk/SiaY4PY=;
  b=jR8LGhewDNxq6hguidbGEnpc7OZrkCJmgwy0rqY1N+ggMEPAcXOlunmN
   5VKOgM4JbPurls2Su5OjLBn7nY47qmNJlbZtjpg6kO1mfNG78uxjEGWAu
   b+N4+xdT2lQzw1uDH6lhXX1/r4PR9wIY35cUyntV85YiKvpAX2+jpy2ew
   /5AX1TfNJDvlYXsjtvYKwTXmeQcaCxT9xwowmYybk25pgB21mgvHnjwlG
   39AJF/Q4P6cZgthBk5tY+fFCL0OaKwaWqWQACGKaYfFRKT3GBoTTm2hES
   dPRDDovay80Izl+74AXSyZe8UeHxX2fBUE4sOnT/Pn3F4gH/WUyacgRe3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="293420790"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="293420790"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:50:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="740798066"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="740798066"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:50:13 -0700
Message-ID: <ac179589-bd60-a47c-2d3b-78992b6cbea2@intel.com>
Date:   Fri, 4 Nov 2022 15:50:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] x86/tdx: Do not allow #VE due to EPT violation on the
 private memory
Content-Language: en-US
To:     Erdem Aktas <erdemaktas@google.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Cc:     Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com, bp@alien8.de,
        dan.j.williams@intel.com, david@redhat.com,
        elena.reshetova@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        x86@kernel.org
References: <20221028141220.29217-3-kirill.shutemov@linux.intel.com>
 <b5d04a6c-79b4-bbdc-b613-6958d9f75d53@linux.alibaba.com>
 <4bfcd256-b926-9b1c-601c-efcff0d16605@intel.com>
 <CAAYXXYy6xPPD0bLz9RrVO6FDWA9d8hiz4Po0hcEe0oupGq=L2g@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAAYXXYy6xPPD0bLz9RrVO6FDWA9d8hiz4Po0hcEe0oupGq=L2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 15:36, Erdem Aktas wrote:
> On Fri, Oct 28, 2022 at 7:12 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
>> +        *
>> +        * Kernel has no legitimate use-cases for #VE on private memory. It is
>> +        * either a guest kernel bug (like access of unaccepted memory) or
>> +        * malicious/buggy VMM that removes guest page that is still in use.
>> +        *
> 
> I think this statement is too strong and I have few concerns on this approach.
> I understand that there is an issue of handling #VEs on private pages
> but it seems like we are just hiding the problem with this approach
> instead of fixing it - I do not have any fix in my mind- .
> First there is a feature of injecting #VE to handle unaccepted pages
> at runtime and accept them on-demand, now the statement is saying this
> was an unnecessary feature (why is it there at all then?) at all as
> there is no legitimate use case.

We're doing on-demand page acceptance.  We just don't need a #VE to
drive it.  Why is it in the TDX module then?  Inertia?  Because it got
too far along in the process before anyone asked me or some of the other
x86 kernel folks to look at it hard.

> I wonder if this will limit how we can implement the lazy TDACCEPT.
> There are multiple ideas floating now.
> https://github.com/intel/tdx/commit/9b3ef9655b695d3c67a557ec016487fded8b0e2b
> has 3 implementation choices where "Accept a block of memory on the
> first use." option is implemented.  Actually it says "Accept a block
> of memory on the first use." but it is implemented as "Accept a block
> of memory on the first allocation".  The comments in this code also
> raises concerns on the performance.
> 
> As of now, we do not know which one of those ideas will provide an
> acceptable performance for booting large size VMs. If the performance
> overhead is high, we can always implement the lazy TDACCEPT as when
> the first time a guest accesses an unaccepted memory, #VE can do the TDACCEPT.

Could you please elaborate a bit on what you think the distinction is
between:

	* Accept on first use
and
	* Accept on allocation

Surely, for the vast majority of memory, it's allocated and then used
pretty quickly.  As in, most allocations are __GFP_ZERO so they're
allocated and "used" before they even leave the allocator.  So, in
practice, they're *VERY* close to equivalent.

Where do you see them diverging?  Why does it matter?

> I am not trying to solve the lazy TDACCEPT problem here but all I am
> trying to say is that, there might be legitimate use cases for #VE on
> private memory and this patch limits any future improvement we might
> need to do on lazy TDACCEPT implementation.

The kernel can't take exceptions on arbitrary memory accesses.  I have
*ZERO* idea how to handle page acceptance on an access to a per-cpu
variable referenced in syscall entry, or the NMI stack when we've
interrupted kernel code with a user GSBASE value.

So, we either find *ALL* the kernel memory that needs to be pre-accepted
at allocation time (like kernel stacks) or we just say that all
allocated memory needs to be accepted before we let it be allocated.

One of those is really easy.  The other means a boatload of code audits.
 I know.  I had to do that kind of exercise to get KPTI to work.  I
don't want to do it again.  It was worth it for KPTI when the world was
on fire.  TDX isn't that important IMNHO.  There's an easier way.
