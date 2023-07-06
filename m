Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1E74A360
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjGFRph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjGFRpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:45:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B781FDE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688665528; x=1720201528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NRDnbLMW0cXY6ygtX7nwHk3/rr1hm1CMmJHpi3gISkU=;
  b=fHMD+EiYJcU0b2O43+6AtVS4oBx5+0v3sEnHnaKzZvErLCqyE+VRXc99
   fgSk3q5DAejCfq5/PMBukmQ5dO4a3TmYm0DXxNEWMEHIfg7DSizCEBhYx
   FX+G0XiJXRNCNfZqZJNp3NS7o189J4n6ICGTRvZFd0YfdfWrtI/aCVZ4H
   /mLujn2SpgUR6bat0+tcLt/5rrUhCsxoDF9APO4E/2xZiwaLazy47Rsc7
   LDb6qkq36W1Dy7wseepavphha2Xr3SGznTPneYsC/L+GU116sXuJ0nDZ5
   M42t45iVqC1HYkYVqFAzSM5B2oA1p7UpBZnSPzZQfZRhKRjAQgpJiEh4z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="362544157"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="362544157"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 10:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="789631863"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="789631863"
Received: from adityan1-mobl1.amr.corp.intel.com (HELO [10.212.197.9]) ([10.212.197.9])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 10:45:26 -0700
Message-ID: <c32e45ed-da25-a7c7-2613-5c94ea89cc27@intel.com>
Date:   Thu, 6 Jul 2023 10:45:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 09:48, Michael Kelley (LINUX) wrote:
> When a page is transitioning, the caller can and should ensure
> that it is not being accessed during the transition.  But we have
> the load_unaligned_zeropad() wildcard.   So do the following for
> the transition sequence in __set_memory_enc_pgtable():
> 
> 1.  Remove aliasing mappings
> 2.  Remove the PRESENT bit from the PTEs of all transitioning pages
> 3.  Flush the TLB globally
> 4.  Flush the data cache if needed
> 5.  Set/clear the encryption attribute as appropriate
> 6.  Notify the hypervisor of the page status change
> 7.  Add back the PRESENT bit
> 
> With this approach, load_unaligned_zeropad() just takes the
> normal page-fault-based fixup path if it touches a page that is
> transitioning.

Yes, this does seem much simpler.  It funnels everything through the
page fault handler and also doesn't require because careful about the
ordering of the private<=>shared conversions.
