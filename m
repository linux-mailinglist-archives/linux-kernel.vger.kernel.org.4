Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5B711A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjEYX2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:28:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09574E7;
        Thu, 25 May 2023 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685057291; x=1716593291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wzVUQ0ik7P4MU6YX6IWh+1L6CekJa/ZiJxdTIjh1KYw=;
  b=H1Kg6ReeTrNe8/pkGPmdV1BDwTTs7m9SjCHvT2sFHrFyzRicTiscTa/N
   g6IJTRT/E8XnsKRYnyT7HOUl0dDmyT+Oa9Mbj4RJEuvTE9T9i0wJhNeAp
   17W0FoNeot52XpD23pUZvvRvXWGtHn615ZjhzuC5EIa+vq5/n13knKBN7
   ycvLTnHIs7AoDE/lsTN5omahgPQKcpBCIWhNp25SmdJ6DhnyZM4oLpp+V
   cOvVe+mecl445sKbcBn7aPHo4gJsZEjs0cgkkMDZK8VRy20E9AkYca784
   17WKQHKtSiSCtPyVdgLOejF6LzybwyPK+NWpQ2JIKLeCOFcFaLnw35kuG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="338653419"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="338653419"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 16:28:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="829288774"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="829288774"
Received: from mseamste-mobl1.amr.corp.intel.com (HELO [10.209.120.148]) ([10.209.120.148])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 16:28:08 -0700
Message-ID: <8a9ca63b-60d8-050c-30b5-a9bdc7a26940@linux.intel.com>
Date:   Thu, 25 May 2023 16:28:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] x86/mm: Allow guest.enc_status_change_prepare() to
 fail
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
 <20230525225847.28592-2-kirill.shutemov@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230525225847.28592-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/25/23 3:58 PM, Kirill A. Shutemov wrote:
> TDX code is going to provide guest.enc_status_change_prepare() that is
> able to fail.

You can add some info about why you need this?

> 
> Add a way to return an error from the callback.
> 
> While there, fix enc_status_change_finish_noop(). It is defined as
> always-fail now which doesn't make sense for noop.

IMO, since the above change is an independent fix, I think it is better to
split this into a separate patch.

Other than above suggestions, the rest of the changes looks fine.

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/include/asm/x86_init.h | 2 +-
>  arch/x86/kernel/x86_init.c      | 4 ++--
>  arch/x86/mm/mem_encrypt_amd.c   | 4 +++-
>  arch/x86/mm/pat/set_memory.c    | 3 ++-
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 88085f369ff6..1ca9701917c5 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -150,7 +150,7 @@ struct x86_init_acpi {
>   * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
>   */
>  struct x86_guest {
> -	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
> +	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
>  	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
>  	bool (*enc_tlb_flush_required)(bool enc);
>  	bool (*enc_cache_flush_required)(void);
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index d82f4fa2f1bf..64664311ac2b 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -130,8 +130,8 @@ struct x86_cpuinit_ops x86_cpuinit = {
>  
>  static void default_nmi_init(void) { };
>  
> -static void enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { }
> -static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
> +static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
> +static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
>  static bool enc_tlb_flush_required_noop(bool enc) { return false; }
>  static bool enc_cache_flush_required_noop(void) { return false; }
>  static bool is_private_mmio_noop(u64 addr) {return false; }
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index e0b51c09109f..4f95c449a406 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -319,7 +319,7 @@ static void enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
>  #endif
>  }
>  
> -static void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
> +static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
>  {
>  	/*
>  	 * To maintain the security guarantees of SEV-SNP guests, make sure
> @@ -327,6 +327,8 @@ static void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool
>  	 */
>  	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
>  		snp_set_memory_shared(vaddr, npages);
> +
> +	return true;
>  }
>  
>  /* Return true unconditionally: return value doesn't matter for the SEV side */
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 7159cf787613..b8f48ebe753c 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2151,7 +2151,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
>  
>  	/* Notify hypervisor that we are about to set/clr encryption attribute. */
> -	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
> +	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
> +		return -EIO;
>  
>  	ret = __change_page_attr_set_clr(&cpa, 1);
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
