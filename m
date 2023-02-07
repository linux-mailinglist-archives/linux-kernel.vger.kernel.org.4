Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A868CD63
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBGDV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:21:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F44B478
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675740083; x=1707276083;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Pvxe3FdxO9kUZ5MO9sjzGY3UudHAcGeZSwIecuYVLd8=;
  b=AhVMnDZNkRmEQe7Wu3OLEIVYDQGTSD5X4wBPGFggahb0OTm9A2Ds6cMb
   lMpBtwD2B0etZVKbeDjxw/nc+bBOA48TXeaZGQyOB5pO3HAlzI5cCRJEZ
   Xwkbhl/pRqwRyi8a3KGrjxN08uZMJKp1rqgya4Uf8CkSYhQDzrvj4S+mq
   Y+t+dlbNI/ECU/60C6XGJx8GtafyDiNK1jW2pPJWJBPsd8ertqRl/pI47
   KTyrehRmGC2KNBHUCd0HCzqgbLxusbJFPnrN3MAUx7SXudC5BihJw08ua
   DjKN1RJWCkWxt7zEgfjt/XboX9ORYfb9quIqj2V/vNm9T2tABsP/ZoWgl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317408758"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="317408758"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 19:21:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="730243108"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="730243108"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.238.212.95]) ([10.238.212.95])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 19:21:19 -0800
Message-ID: <faac69f3-3885-8cab-ea33-49922d7a6b6d@intel.com>
Date:   Tue, 7 Feb 2023 11:21:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 7/7] x86/kvm: Expose LASS feature to VM guest
Content-Language: en-US
To:     Yian Chen <yian.chen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-8-yian.chen@intel.com>
From:   "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <20230110055204.3227669-8-yian.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you also CC the KVM mailing list (kvm@vger.kernel.org) for KVM guys to review?

BR,
Lei

On 1/10/2023 1:52 PM, Yian Chen wrote:
> From: Paul Lai <paul.c.lai@intel.com>
> 
> Expose LASS feature which is defined in the CPUID.7.1.EAX
> bit and enabled via the CR4 bit for VM guest.
> 
> Signed-off-by: Paul Lai <paul.c.lai@intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 3 ++-
>  arch/x86/kvm/cpuid.c            | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index f35f1ff4427b..bd39f45e9b5a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -125,7 +125,8 @@
>  			  | X86_CR4_PGE | X86_CR4_PCE | X86_CR4_OSFXSR | X86_CR4_PCIDE \
>  			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
>  			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
> -			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP))
> +			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
> +			  | X86_CR4_LASS))
>  
>  #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
>  
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index b14653b61470..e0f53f85f5ae 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -664,7 +664,7 @@ void kvm_set_cpu_caps(void)
>  
>  	kvm_cpu_cap_mask(CPUID_7_1_EAX,
>  		F(AVX_VNNI) | F(AVX512_BF16) | F(CMPCCXADD) | F(AMX_FP16) |
> -		F(AVX_IFMA)
> +		F(AVX_IFMA) | F(LASS)
>  	);
>  
>  	kvm_cpu_cap_init_kvm_defined(CPUID_7_1_EDX,
