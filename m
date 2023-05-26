Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9F7125EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbjEZLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243395AbjEZLtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:49:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF8E42;
        Fri, 26 May 2023 04:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685101752; x=1716637752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W+EPrAJSDWn4CQJBmzrJ2AEImuVypqMvuEFPEkmEPd4=;
  b=EShhsox/W0wnXZbz4CuzSgNLjspH7cQFM/RxC9N11qmvslT/hH/Se9k9
   PXD+LTr1ixlThtdkNmz4L0gqaUjRPKtBIpw3la2VjkwFfQFzR7+ou7sNq
   2SgrRqBPSt4TIluqrvPWUqRSyTbdHmyzbvG6uJb3Q03yVIOWS0GmXcBMi
   BBrHwylJnelXQUmkUE2K8SVZjX2KZ+gpiDuumUy4Ezh4Dd3jbSFVpsGz4
   w0669xFK1cKNZT3nRB8Oq7leYWcTMlnw4C4KVZavvxgFwx1sRQ20LIdJL
   7ZPj6lwVo+RPUqxOnj3rgHJz8gycu11ff5WsULcaiRcTHfOPTGxqW819X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="440539338"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="440539338"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 04:49:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="770317223"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="770317223"
Received: from fgarrona-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 04:49:08 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5D8DC10C61D; Fri, 26 May 2023 14:49:05 +0300 (+03)
Date:   Fri, 26 May 2023 14:49:05 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "Cui, Dexuan" <decui@microsoft.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/mm: Allow guest.enc_status_change_prepare() to
 fail
Message-ID: <20230526114905.ios6la7foypydsbe@box.shutemov.name>
References: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
 <20230525225847.28592-2-kirill.shutemov@linux.intel.com>
 <7e243a32436c1ef68f0fb191c098ba9b3fad30d1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e243a32436c1ef68f0fb191c098ba9b3fad30d1.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 02:17:12AM +0000, Huang, Kai wrote:
> On Fri, 2023-05-26 at 01:58 +0300, Kirill A. Shutemov wrote:
> > TDX code is going to provide guest.enc_status_change_prepare() that is
> > able to fail.
> > 
> > Add a way to return an error from the callback.
> > 
> > While there, fix enc_status_change_finish_noop(). It is defined as
> > always-fail now which doesn't make sense for noop.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/x86/include/asm/x86_init.h | 2 +-
> >  arch/x86/kernel/x86_init.c      | 4 ++--
> >  arch/x86/mm/mem_encrypt_amd.c   | 4 +++-
> >  arch/x86/mm/pat/set_memory.c    | 3 ++-
> >  4 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> > index 88085f369ff6..1ca9701917c5 100644
> > --- a/arch/x86/include/asm/x86_init.h
> > +++ b/arch/x86/include/asm/x86_init.h
> > @@ -150,7 +150,7 @@ struct x86_init_acpi {
> >   * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
> >   */
> >  struct x86_guest {
> > -	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
> > +	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
> > 
> 
> [...]
> 
> > @@ -2151,7 +2151,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
> >  		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
> >  
> >  	/* Notify hypervisor that we are about to set/clr encryption attribute. */
> > -	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
> > +	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
> > +		return -EIO;
> 
> The name "enc_status_change_prepare()" sounds like an action, but not some
> true/false condition check.  I think it's more reasonable to make it return
> 'int', and returning 0 means successful?

It copies convention of enc_status_change_finish(). I don't think we need
anything more than binary pass/fail. We can change it in the future if
needed.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
