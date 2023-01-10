Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA4B663F01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjAJLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbjAJLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:07:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA601EEFB;
        Tue, 10 Jan 2023 03:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673348836; x=1704884836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rVhJmEIPGip77/doSmIyFH6N4wuSe2EOVqkHy4zJTJM=;
  b=MIKStdG8ONY+3CPdc0beg1TZuGsXBoparQGrNjpOC/DIEvZ2wbfj/m3T
   NrxQmt3ovC6Liifr9aYKzx9xYUDHagztjo+dR6j+fHjkdr5bH0bncoi47
   1Uwdw8U2YbewknyAjW6ZkVNKaN6gWshLneuLVdIb1KlsZ2lkAfKEG2Ur3
   hPlaiBHKz0C31tA3R/Z0XnmZ9kmOuyi8BD2xdZxXJG1Kn0MqoZ3bV+IdV
   Y65lzN3mS1Ov/60lE+0H03e+Y67E2zmFG1Wmjl7IOiSOvU8rat7T4Rj/P
   p5Wxo7oYECXP1TBc0vucjhadvlKHJTEZ1KRCgezXj3lDTc85mM8++iVpi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="325123958"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="325123958"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 03:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="745739146"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="745739146"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2023 03:07:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFCT8-006ztV-3A;
        Tue, 10 Jan 2023 13:07:02 +0200
Date:   Tue, 10 Jan 2023 13:07:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC DO NOT MERGE] treewide: use __xchg in most obvious places
Message-ID: <Y71G1tkmUzM4BLxn@smile.fi.intel.com>
References: <Y7b6/7coJEVlTVxK@phenom.ffwll.local>
 <20230110105306.3973122-1-andrzej.hajda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110105306.3973122-1-andrzej.hajda@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 11:53:06AM +0100, Andrzej Hajda wrote:
> This patch tries to show usability of __xchg helper.
> It is not intended to be merged, but I can convert
> it to proper patchset if necessary.
> 
> There are many more places where __xchg can be used.
> This demo shows the most spectacular cases IMHO:
> - previous value is returned from function,
> - temporary variables are in use.
> 
> As a result readability is much better and diffstat is quite
> nice, less local vars to look at.
> In many cases whole body of functions is replaced
> with __xchg(ptr, val), so as further refactoring the whole
> function can be removed and __xchg can be called directly.

...

>  arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>  				  struct pt_regs *regs)
>  {
> -	unsigned long orig_ret_vaddr;
> -
> -	orig_ret_vaddr = regs->ARM_lr;
> -	/* Replace the return addr with trampoline addr */
> -	regs->ARM_lr = trampoline_vaddr;
> -	return orig_ret_vaddr;
> +	return __xchg(&regs->ARM_lr, trampoline_vaddr);
>  }

If it's not a callback, the entire function can be killed.
And this is a good example of the function usage.
OTOH, these places might have a side effect (if it's in deep CPU
handlers), means we need to do this carefully.

...

>  static inline void *qed_chain_produce(struct qed_chain *p_chain)
>  {
> -	void *p_ret = NULL, *p_prod_idx, *p_prod_page_idx;
> +	void *p_prod_idx, *p_prod_page_idx;
>  
>  	if (is_chain_u16(p_chain)) {
>  		if ((p_chain->u.chain16.prod_idx &
> @@ -390,11 +391,8 @@ static inline void *qed_chain_produce(struct qed_chain *p_chain)
>  		p_chain->u.chain32.prod_idx++;
>  	}
>  
> -	p_ret = p_chain->p_prod_elem;
> -	p_chain->p_prod_elem = (void *)(((u8 *)p_chain->p_prod_elem) +
> -					p_chain->elem_size);
> -
> -	return p_ret;
> +	return __xchg(&p_chain->p_prod_elem,
> +		      (void *)(((u8 *)p_chain->p_prod_elem) + p_chain->elem_size));

Wondering if you still need a (void *) casting after the change. Ditto for the
rest of similar cases.

>  }

...

Btw, is it done by coccinelle? If no, why not providing the script?

-- 
With Best Regards,
Andy Shevchenko


