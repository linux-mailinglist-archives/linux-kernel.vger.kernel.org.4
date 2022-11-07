Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FC96203C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiKGXao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiKGXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:30:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D7F1741C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667863840; x=1699399840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vE5QctfufmPeyV4e3LhXXDTySHAfnG5CaA9bs3sDIwY=;
  b=Ad+Z6L+15KTkhl1CljMECXWor0wY5w7B3qYqpUCA1W+/B4XuL2ByzsZ7
   /mblkay17T8xc5nneK2IhAmxqak+pY6/HNQI27XNwNe+6QMBlulZFwPcQ
   RAMGxqBw099hCaN3YXI6mbVLmbCdmcuIXT/+cuRKjul+rJ18vscNJWT8k
   TQUNS+PkqytfMHvG4DgGqQccimxhzm7er0v2/GlI22RJ2V1CthBNIhMRo
   NQjzzs5DHc7iyOrer4Bm2bCRc3ezbqH3AoOuiOfPqy5Cjf97uKYeVO+ur
   qFShfeXVBU4kU5RoxMzA3qxeEDV5eoSVqzQVQlsdhywkmDSJV8McDiFm1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337273941"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337273941"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 15:30:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="705072783"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="705072783"
Received: from peggykes-mobl.amr.corp.intel.com (HELO [10.251.7.244]) ([10.251.7.244])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 15:30:38 -0800
Message-ID: <77b79116-951a-7ff9-c19b-73af2af98ce9@intel.com>
Date:   Mon, 7 Nov 2022 15:30:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] x86/tdx: Do not allow #VE due to EPT violation on the
 private memory
Content-Language: en-US
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     "Nakajima, Jun" <jun.nakajima@intel.com>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
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
 <ac179589-bd60-a47c-2d3b-78992b6cbea2@intel.com>
 <CAAYXXYw1YpZx1AaOu0TgR9yR9Foi6_jh8XkbGU4ZM2TFTM=nSA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAAYXXYw1YpZx1AaOu0TgR9yR9Foi6_jh8XkbGU4ZM2TFTM=nSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 14:53, Erdem Aktas wrote:
> On Fri, Nov 4, 2022 at 3:50 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> Could you please elaborate a bit on what you think the distinction is
>> between:
>>
>>         * Accept on first use
>> and
>>         * Accept on allocation
>>
>> Surely, for the vast majority of memory, it's allocated and then used
>> pretty quickly.  As in, most allocations are __GFP_ZERO so they're
>> allocated and "used" before they even leave the allocator.  So, in
>> practice, they're *VERY* close to equivalent.
>>
>> Where do you see them diverging?  Why does it matter?
> 
> For a VM with a very large memory size, let's say close to 800G of
> memory, it might take a really long time to finish the initialization.
> If all allocations are __GFP_ZERO, then I agree it would not matter
> but -- I need to run some benchmarks to validate --  what I remember
> was, that was not what we were observing. Let me run a few tests to
> provide more input on this but meanwhile if you have already run some
> benchmarks, that would be great.
> 
> What I see in the code is that the "accept_page" function will zero
> all the unaccepted pages even if the __GFP_ZERO flag is not set and if
> __GFP_ZERO is set, we will again zero all those pages. I see a lot of
> concerning comments like "Page acceptance can be very slow.".

I'm not following you at all here.  Yeah, page acceptance is very slow.
But, the slowest part is the probably cache coherency dance that the TDX
module has to do flushing and zeroing all the memory to initialize the
new integrity metadata.  Second to that is the cost of the TDCALL.
Third is the cost of the #VE.

Here's what Kirill is proposing, in some peudocode:

	alloc_page(order=0, __GFP_ZERO) {
		TD.accept(size=4M) {
			// TDX Module clflushes/zeroes 4M of memory
		}
		memset(4k);
		// leave 1023 accepted 4k pages in the allocator
	}

To accept 4M of memory, you do one TDCALL.  You do zero #VE's.  Using
the #VE handler, you do:

	alloc_page(order=0, __GFP_ZERO) {
		memset(4k) {
			-> #VE handler
			TD.accept(size=4k); // flush/zero 4k
		}
		// only 4k was accepted
	}
	... Take 1023 more #VE's later on for each 4k page

You do 1024 #VE's and 1024 TDCALLs.  So, let's summarize.  To do 4M
worth of 4k pages, here's how the two approaches break down if
__GFP_ZERO is in play:

	      #VE	Accept-in-allocator
#VE's:	     1024			0
TDCALLS:     1024			1
clflushes: 4k x 1024		4k x 1024
memset()s: 4k x 1024		4k x 1024

The *ONLY* downside of accept-at-allocate as implemented is that it does
4M at a time, so the TDCALL is long compared to a 4k one.  But, this is
a classing bandwidth versus latency compromise.  In this case, we choose
bandwidth.

*Both* cases need to memset() the same amount of memory.  Both cases
only memset() 4k at a time.

The *ONLY* way the #VE approach is better is if you allocate 4k and then
never touch the rest of the 4M page.  That might happen, maybe *ONE*
time per zone.  But the rest of the time, the amortization of the TDCALL
cost is going to win.

I'll be shocked if any benchmarking turns up another result.

