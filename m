Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9847C712F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbjEZVuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbjEZVu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:50:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E415FF7;
        Fri, 26 May 2023 14:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685137828; x=1716673828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VfEhsdKfsdRHsXF4n5Ad6c1ZfAY94T+oTXwCQNRuezI=;
  b=B2sgH/O2VuWvgVCpnayAWN+VcOkMh8YqN6rLiqp7WxQ86C2Ybfz82lC6
   YBofYT9+IQiOn9wg6r4MZw7t89P3daxHNqBJykc52YQxG0zvcDdcbkBL/
   Q+ftH4UZ+5DNwdw5+Whcbwa6EJqsTFX/Wp7vqDSw9ytZEw8L3IrBEUUMl
   2QcVsdV3YutqI5/givOQtHvmIgYK8iKg53n30o485hJ76tEzbdBMJNdpK
   TsstSPn2lgQSRWeF7RZuQJWwsdjF1cLusTJdQ/l1DpC/6rPNTkq6VZ63K
   h9UG2FV+8MiGa43iAhjr2xLX1wWhXPULH2LpUsZbh9tdWQh9r7Et009Ti
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="440669248"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="440669248"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 14:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="879673483"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="879673483"
Received: from svepakom-mobl1.amr.corp.intel.com (HELO [10.252.139.203]) ([10.252.139.203])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 14:50:27 -0700
Message-ID: <e0ba4d6a-1d6e-12ee-5bc2-5cb3c7096aef@linux.intel.com>
Date:   Fri, 26 May 2023 14:50:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCHv2 1/3] x86/mm: Allow guest.enc_status_change_prepare() to
 fail
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-2-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230526120225.31936-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/23 5:02 AM, Kirill A. Shutemov wrote:
> TDX code is going to provide guest.enc_status_change_prepare() that is
> able to fail. TDX will use the call to convert the GPA range from shared
> to private. This operation can fail.
> 
> Add a way to return an error from the callback.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  arch/x86/include/asm/x86_init.h | 2 +-
>  arch/x86/kernel/x86_init.c      | 2 +-
>  arch/x86/mm/mem_encrypt_amd.c   | 4 +++-
>  arch/x86/mm/pat/set_memory.c    | 3 ++-
>  4 files changed, 7 insertions(+), 4 deletions(-)
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
> index d82f4fa2f1bf..f230d4d7d8eb 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -130,7 +130,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
>  
>  static void default_nmi_init(void) { };
>  
> -static void enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { }
> +static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
>  static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
>  static bool enc_tlb_flush_required_noop(bool enc) { return false; }
>  static bool enc_cache_flush_required_noop(void) { return false; }
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
>  }>  
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
