Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9749161FCC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiKGSG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiKGSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:06:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6B02A252
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667844168; x=1699380168;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fDIy9GNTqYrRaEubc/ZHCrZPmxPfpeXIk3PMc/Gyqec=;
  b=c68OYk9tZSXmJ8jCOPSEpjwn1321r/PurhpVfnV9daOcZvb9QrZVkFSy
   3evjHV1Rjel6ReUEDVNZAzLEru7EO3NtiYD73V0EfzqKwlupDAhJjGs4K
   eOjOjrFBJyR/U/euok33o2uiKezamnqsX3rKOFQEk/WOs//jpwobHEQrV
   btCliQ5A7mT0xAJfCO2OiXoWraaYIOIfmnHy6Klcg614KqW1fafq6+Tdq
   uZxEGGe/KkCIp7sq3YG0TiEIpGpqmG36qIWRqoMrJ443B9zv5Uopa5wkh
   Bg3ouLBNFL1QB8QVspisxgFBZ1MD4RKqFqvS/mp/dctfk+r50PnwvDh0R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290870719"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="290870719"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 10:02:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="741598319"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="741598319"
Received: from peggykes-mobl.amr.corp.intel.com (HELO [10.251.7.244]) ([10.251.7.244])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 10:02:47 -0800
Message-ID: <b778fcdd-5c20-e897-9d17-1a884172a826@intel.com>
Date:   Mon, 7 Nov 2022 10:02:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHv11 04/16] x86/mm: Handle LAM on context switch
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
 <20221025001722.17466-5-kirill.shutemov@linux.intel.com>
 <b38f15de-436e-489c-b8db-9beff4466748@kernel.org>
 <20221107171419.k33qd4rz3tyfrovs@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221107171419.k33qd4rz3tyfrovs@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 09:14, Kirill A. Shutemov wrote:
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -561,7 +561,15 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  	if (real_prev == next) {
>  		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
>  			   next->context.ctx_id);
> -		VM_WARN_ON(prev_lam != new_lam);
> +
> +		/*
> +		 * 'prev_lam' does not necessary match 'new_lam' here. In case
> +		 * of race with LAM enabling, the updated 'lam_cr3_mask' can be
> +		 * been before LAM-enabling IPI kicks in.
> +		 *
> +		 * The race is harmless: it is okay to update CR3 with new LAM
> +		 * mode. The IPI will rewrite CR3 shortly.
> +		 */

So, let's do something like this in switch_mm_irqs_off():

		/* Not actually switching mm's */
		VM_WARN_ON(this_cpu_read(cpu_tlbstate....

		/*
		 * If this races with another thread that enables
		 * lam, 'new_lam' might not match 'prev_lam'.
		 */

Then, in enable_lam_func(), something like this:

	/*
	 * Update CR3 to get LAM active on the CPU
	 *
	 * This might not actually need to update CR3 if a context
	 * switch happened between updating 'lam_cr3_mask' and
	 * running this IPI handler.  Update it unconditionally for
	 * simplicity.
	 */
	cr3 = __read_cr3();
	cr3 &= ~(X86_CR3_LAM_U48 | X86_CR3_LAM_U57);
	cr3 |= lam_mask;
	write_cr3(cr3);
	set_tlbstate_cr3_lam_mask(lam_mask);


I'd much rather get folks thinking about IPI races in the IPI handler
rather than thinking about the IPI handler in the context switch path.

It's kinda silly to be describing the occasional superfluous
enable_lam_func() activity from switch_mm_irqs_off().
