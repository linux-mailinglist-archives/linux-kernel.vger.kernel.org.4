Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4106A60B714
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiJXTRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiJXTQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:16:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A18A1F0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666634041; x=1698170041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/K+Ts2+uttnCqwfQK/5MLuJXtpc4jM0NtwDTwTLflYE=;
  b=lwHQeleQxKBakQ2xSxogqPK2Fv5kMRCq+uxMfKqTDqkyrUQTi7IDPTe3
   CP46BCN6KgiaC85GA4vN1JicvytFIFYvhQQ6fk56hX5gjHnNrG4kDV6u+
   akeQ8ReuzECNYSS95Q1mNaiAtCb1bfuJsThKLAaHWm4oLBeFUq160Sd2D
   rsR3i43MSrPP8joBDIVZ8QU42rEnyQ3oCTwB7suIjaBdsJImQehmof+co
   VrlTLyEZrZJD2FcJpnKnsMh0lNXrc7TOGq4nmqi1x5knq+Z+cq88Q3wyk
   dKzK/0B57CP8M9T+c2RAaqxGOayO3IFNMP7DcvCG9DtgEket3AnD1/Oxg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308554821"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="308554821"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:14:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="773876638"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="773876638"
Received: from csun9-mobl.amr.corp.intel.com (HELO [10.209.104.152]) ([10.209.104.152])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:14:46 -0700
Message-ID: <b772127d-8729-553a-000c-27cf4ddbf926@intel.com>
Date:   Mon, 24 Oct 2022 09:14:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <seanjc@google.com>
References: <20221024114536.44686c83@gandalf.local.home>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221024114536.44686c83@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 08:45, Steven Rostedt wrote:
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -587,6 +587,10 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>  {
>  	unsigned long end;
>  
> +	/* Kernel text is rw at boot up */
> +	if (system_state == SYSTEM_BOOTING)
> +		return new;

Hi Steven,

Thanks for the report and the patch.  That seems reasonable, but I'm a
bit worried that it opens up a big hole (boot time) when a W+X mapping
could be created *anywhere*.

Could we restrict this bypass to *only* kernel text addresses during
boot?  Maybe something like this:

	if ((system_state == SYSTEM_BOOTING) &&
	    __kernel_text_address(start))
		return new;

That would be safe because we know that kernel_text_address() addresses
will be made read-only by the time userspace shows up and that
is_kernel_inittext() addresses will be freed.

Long-term, I wonder if we could teach the early patching code that it
can't just use memcpy().


