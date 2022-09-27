Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA65ECA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiI0RLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiI0RK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:10:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B20DFB32E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664298656; x=1695834656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r8qgJjScy6RDWKbO5ZguVDjydkbLQqYVIQpzxlqrb7g=;
  b=VEISxDmmVXIIa1aOmjH5bXKwGJfXktHinokr4mvdXqQ1/aezSHaMMiss
   h8UlX5FQlrV/7FB1NBuGFogu8EdhoXCJ6e+37h1GXMicnl7xfJWwlkhez
   5TkutaRSe3UQt07o6Nl+/QnacM+MMcXe672iXNF9Y5eb1OPUyaK3cSBcU
   2140TlmT2Muduo5FkekcdlIOXKWiYy/OdGGrvW/gV5weQTFRxQfybxOww
   GQIUmETg6SFTXzDc5KFLbU/VnxhX87xv7A6ZnaRtKCPU4gE6Y6AFyFRsc
   MWOYsKZTBy9+fopS0iEQ5bFLpj1KyXeUXKW0JDFffgdQtCE2Lm8CuzkG6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302853943"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="302853943"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 10:10:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="616903090"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="616903090"
Received: from mgateho-mobl1.amr.corp.intel.com (HELO [10.255.229.33]) ([10.255.229.33])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 10:10:55 -0700
Message-ID: <51eeb843-204f-5b9d-9f7f-9bf3c22d2c00@intel.com>
Date:   Tue, 27 Sep 2022 10:10:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/6] x86/sev: Fix calculation of end address based on
 number of pages
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1664298261.git.thomas.lendacky@amd.com>
 <afd222473c7b18ea942e754a6c4df26ed74eedee.1664298261.git.thomas.lendacky@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <afd222473c7b18ea942e754a6c4df26ed74eedee.1664298261.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 10:04, Tom Lendacky wrote:
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -649,7 +649,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
>  	int rc;
>  
>  	vaddr = vaddr & PAGE_MASK;
> -	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> +	vaddr_end = vaddr + ((unsigned long)npages << PAGE_SHIFT);

Could we please just fix the fragile typing that cascaded down to this
point?

Shouldn't 'npages' in this interface be a long?

> struct x86_guest {
>         void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
>         bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
>         bool (*enc_tlb_flush_required)(bool enc);
>         bool (*enc_cache_flush_required)(void);
> };
