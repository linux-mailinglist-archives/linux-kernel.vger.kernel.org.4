Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F06716184
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjE3NVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjE3NVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:21:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A65D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685452861; x=1716988861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X6n3CkRI8+JwdQaW9dpMbGRfCFGiJrQnTVujHVVXh0w=;
  b=X/yJ+m8fGMMGbbJ21tUcoIQrm9Hwa+o1pojEbQ++ueMhnXdZy5mcZgQI
   0wOSFRHCilbBGqE++jd6gx0aAQ+JclANZMN7FVPFMn2oPrNjdCugwU0RD
   MdtgEVXMGXQ2kRNPgM1VfxiaKt4Rfdis6H2iLhXhFyLAZ+957lWsv0+yl
   JSYvEUWYtrzyk5xEYHpS2dfVa+VbL9l0ACq3vQKOtCGNM0OkzO/9Rza4/
   6NvGhW0WABcIgZqMKqIdZHrhZcs6o7vXbvVJ7Sp3fHUI3lON5wOkQ8oSV
   1XWUMRddOyX94jdJRTmyGLuUFEx0VZaGZBuBwNsM0NMb/0znK9p0xhdl6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383166361"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383166361"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 06:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="656853648"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="656853648"
Received: from ndesilva-mobl1.amr.corp.intel.com (HELO [10.209.101.99]) ([10.209.101.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 06:21:00 -0700
Message-ID: <d92c6deb-e73c-9425-52ae-230285388d8e@linux.intel.com>
Date:   Tue, 30 May 2023 06:20:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCHv2 3/3] x86/mm: Fix enc_status_change_finish_noop()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-4-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230526120225.31936-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/23 5:02 AM, Kirill A. Shutemov wrote:
> enc_status_change_finish_noop() defined as always-fail now which
> doesn't make sense for noop.
> 
> The change doesn't have user-visible effect because it only gets
> called if the platform has CC_ATTR_MEM_ENCRYPT. All platforms with
> the attribute override the callback with own implementation.
> 

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/x86_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index f230d4d7d8eb..64664311ac2b 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -131,7 +131,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
>  static void default_nmi_init(void) { };
>  
>  static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
> -static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
> +static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
>  static bool enc_tlb_flush_required_noop(bool enc) { return false; }
>  static bool enc_cache_flush_required_noop(void) { return false; }
>  static bool is_private_mmio_noop(u64 addr) {return false; }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
