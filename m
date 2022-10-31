Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38520613B89
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiJaQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJaQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:42:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986692AC2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667234537; x=1698770537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4Bordm8n7C3xVeQBvOSrA59fGvKoYiwKyVINkpri/O0=;
  b=VZIdpQkZxS2b3gM5m5ijvAsBfn4X9j3pShvxgUmJEnXOzxWqsdIwVgGd
   YytZXDzD8jh3kDAa6gm25vGAvjwY1q5Zfzp2dIRsp3CRj9AHRum6XDKGg
   vliTfP31ArQ2u3R5AJr7hWGUsHmpsB+b8eQkLs9v6c3r5oNNKRu1AU8/6
   IZvGLTxABWgHlj7x+PxlTlij0Wqc3+2Gq2aNHeYBjKYyKTr49mFiqMCxI
   2sXifC2Nn2aIwd9j5ueLKj69wgIgUaddUYMcKfIdoQ5bBfSP7UiPoqY4q
   3ioOh95X56Q7Pk/i+StYf/E4bIkBvikTZu16MbLhSTh0iNbs3rsjXu5Uh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310033805"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="310033805"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 09:42:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="808611623"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="808611623"
Received: from jfbondi-mobl1.amr.corp.intel.com (HELO [10.212.163.129]) ([10.212.163.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 09:42:16 -0700
Message-ID: <812cb868-1729-8d78-cf91-1e63c7933fae@intel.com>
Date:   Mon, 31 Oct 2022 09:42:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
 <c97e9273-60b6-2ca7-1993-05bfbf471f3f@intel.com>
 <20221028235951.p2vdu7drbbf3ccg7@box.shutemov.name>
 <20221031041252.mdcjocqn6k4k4gvy@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221031041252.mdcjocqn6k4k4gvy@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 21:12, Kirill A. Shutemov wrote:
> On Sat, Oct 29, 2022 at 02:59:51AM +0300, Kirill A. Shutemov wrote:
>>> Can you please take a look through this and make sure I didn't botch
>>> anything:
>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=tdxbadve
>>>
>>> The end result is about 50 lines less than what was there before.  Most
>>> of it is comment removal but the code is simpler too.
>>>
>>> Acks and Tested-by's would be appreciated.
> 
> One thing that I must bring up is that it seems that there's no way to get
> the panic message to user. I tried to convinced myself that it is qemu
> misconfiguration on my part or some race, but no: it is just too early for
> earlyprintk.
> 
> We only get earlyprintk working after parse_early_options() which happens
> well after tdx_early_init().
> 
> Moving panic() after earlyprintk working is not good idea as it exposes
> kernel more: by the time we already have full #VE handler.

How about we soften the panic() to a pr_err() if it's a debug guest?

The first thing a user is going to do if they get an early boot failure
is flip the debug switch and try it again.  That gets us safe,
well-defined behavior when we need security and also lets us figure out
what went wrong.

Also, did anyone ever actually implement that TDX earlyprintk simple
console thing?  A TDCALL up to the host with some characters in a
register or two is as dirt simple of a console as you can get.  It would
be very easy to improve the user experience here if there were a:

	tdx_puts("uh oh");

interface.  It's a shame if it didn't get done by now.  I asked for it
years ago.

And, yeah, I know it wouldn't help us in this precise situation because
earlyprintk doesn't work yet.  But, it *would* be one of those really,
really early bitbanging-style consoles that _could_ be in use very, very
early if the printk() infrastructure could take advantage of it.

> We can move it earlier into decompresser which has different earlyprintk
> implementation. Not sure if it worth this. What do you think?

There's the puts()/printf() gunk that's really early like in
validate_cpu().  Is that what you were thinking of?

