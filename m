Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A50694B18
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBMP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBMP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:27:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D03CDDB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676302056; x=1707838056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M84V6XBKxxvqemL74JR0FPeEEpGJvO9CPkW36vKglow=;
  b=jSxU+DkfRWKnzy/fuWO9h5Fof33GN7azm8lrO9P/5E3sZ949DgNfdhBZ
   oOu2YpAkRr5T00Y5KNFbnz2zuCdfo8DK+bKsF2fQb8iGy8aZPhuH+Nl3n
   Nmn1WZGt9weO+SGrBkGgvi3y3kfUseCCb8bXZLKZ28b2oYAJphdBiEROv
   j3X7N3EVqfLFN6KH8uWhE8CrQ6uVZ0zgfpa4IZ1P+ScimcjXGDYmka9ee
   qmj30WsBV6+6AkGcOWJP3w0y9zRkwXjKz0lrbVR2D1Gs4QcLKIMckX4tv
   GcGmnEql4EFRJW8KnShrU6qT1UUX8RYgeG6fNQNlW69/184RdyNO910zj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="395524000"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="395524000"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:27:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="670849685"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="670849685"
Received: from mlswanso-mobl.amr.corp.intel.com (HELO [10.251.26.232]) ([10.251.26.232])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:27:34 -0800
Message-ID: <23b851db-a2a6-a854-94fc-a747f360d509@intel.com>
Date:   Mon, 13 Feb 2023 07:27:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y+pTDFQlX9qNL35z@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 07:11, Borislav Petkov wrote:
> On Mon, Feb 13, 2023 at 04:03:07PM +0100, Borislav Petkov wrote:
>>> Wouldn't !cpu_feature_enabled(X86_FEATURE_HYPERVISOR) be enough?
>>>
>>> I'm not sure we won't need that for TDX guests, too.
>> See, that's the problem. I wanna have it simple too. Lemme check with
>> dhansen.
> He says MTRRs are enabled in TDX guests: "X86_FEATURE_MTRR is fixed to
> 1 in TDX guests."
> 
> So we will have to do the more finer-grained check I guess.

Yes, TDX guests see MTRRs as being supported.  But, the TDX module also
appears to inject a #VE for all RDMSR or WRMSR's to the MTRRs.  That
makes them effectively useless.

I actually don't know what the heck TDX guests are supposed to do if
they feel like mucking with the MSRs.  The architecture (CPUID) is
essentially telling them: "Sure, go ahead MTRRs are fiiiiiiine".  But
the TDX module is sitting there throwing exceptions (#VE) if the guest
tries to touch MTRRs.

It sounds like there are some guest<->host ABIs on Xen to help the
guests do this.  But I don't see anything in the TDX "GHCI" about it.
