Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C88C5FC122
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJLHPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJLHP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:15:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AF441D0B;
        Wed, 12 Oct 2022 00:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D7E6B8197F;
        Wed, 12 Oct 2022 07:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EB3C433D6;
        Wed, 12 Oct 2022 07:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665558922;
        bh=qqlR635PzppEAiQGjELnixZo3zbotYEv1VkSpdRxSsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1r+cA+t8KPyF5/zgjEZAC24fR4mWWCcp1qYxKnIzQYsVg3banZt3lsCITNoF2NJQ
         D5k9FHuE0j3JXBp6P/C2ln9tkJW2gbMyR6Z81LL3ljmkNr6LUAjCQeu6w50wio+WV4
         PW7z/S3fboRr5E83f4ghiQlT2K9ed2aHdXKZASQAuEResipoViplf3ypgdFtmch2CN
         gYk4xZ0jS0Kl/8hZVa/i5HlqgEwqEpliL9YPUlZs4Q/9GgGmAf5gcK7G7GxWftRE2c
         CqjcGR4hUVqBdh87jDIAX8ZhR0JbjVqJbZydm5UFXzENkP9wRT2389sNzkbSvt0C4a
         Y5cYdHgpVL0jA==
Date:   Wed, 12 Oct 2022 10:15:18 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Y0ZphugZZBhlv/vT@kernel.org>
References: <20220929160647.362798-1-kristen@linux.intel.com>
 <Y0BEV+Xgkrln8xoh@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0BEV+Xgkrln8xoh@iweiny-desk3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 08:23:03AM -0700, Ira Weiny wrote:
> On Thu, Sep 29, 2022 at 09:06:46AM -0700, Kristen Carlson Accardi wrote:
> > It is not necessary to disable page faults or preemption when
> > using kmap calls, so replace kmap_atomic() and kunmap_atomic()
> > calls with more the more appropriate kmap_local_page() and
> > kunmap_local() calls.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> Minor comment below.
> 
> > ---
> >  arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
> >  arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
> >  arch/x86/kernel/cpu/sgx/main.c  |  8 ++++----
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> > index f40d64206ded..63dd92bd3288 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -160,8 +160,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
> >  		return ret;
> >  
> >  	pginfo.addr = encl_page->desc & PAGE_MASK;
> > -	pginfo.contents = (unsigned long)kmap_atomic(b.contents);
> > -	pcmd_page = kmap_atomic(b.pcmd);
> > +	pginfo.contents = (unsigned long)kmap_local_page(b.contents);
> > +	pcmd_page = kmap_local_page(b.pcmd);
> >  	pginfo.metadata = (unsigned long)pcmd_page + b.pcmd_offset;
> >  
> >  	if (secs_page)
> > @@ -187,8 +187,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
> >  	 */
> >  	pcmd_page_empty = !memchr_inv(pcmd_page, 0, PAGE_SIZE);
> >  
> > -	kunmap_atomic(pcmd_page);
> > -	kunmap_atomic((void *)(unsigned long)pginfo.contents);
> > +	kunmap_local(pcmd_page);
> > +	kunmap_local((void *)(unsigned long)pginfo.contents);
> >  
> >  	get_page(b.pcmd);
> >  	sgx_encl_put_backing(&b);
> > @@ -197,10 +197,10 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
> >  
> >  	if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl, pcmd_first_page)) {
> >  		sgx_encl_truncate_backing_page(encl, PFN_DOWN(page_pcmd_off));
> > -		pcmd_page = kmap_atomic(b.pcmd);
> > +		pcmd_page = kmap_local_page(b.pcmd);
> >  		if (memchr_inv(pcmd_page, 0, PAGE_SIZE))
> >  			pr_warn("PCMD page not empty after truncate.\n");
> > -		kunmap_atomic(pcmd_page);
> > +		kunmap_local(pcmd_page);
> >  	}
> >  
> >  	put_page(b.pcmd);
> > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> > index ebe79d60619f..f2f918b8b9b1 100644
> > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > @@ -221,11 +221,11 @@ static int __sgx_encl_add_page(struct sgx_encl *encl,
> >  	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
> >  	pginfo.addr = encl_page->desc & PAGE_MASK;
> >  	pginfo.metadata = (unsigned long)secinfo;
> > -	pginfo.contents = (unsigned long)kmap_atomic(src_page);
> > +	pginfo.contents = (unsigned long)kmap_local_page(src_page);
> >  
> >  	ret = __eadd(&pginfo, sgx_get_epc_virt_addr(epc_page));
> >  
> > -	kunmap_atomic((void *)pginfo.contents);
> > +	kunmap_local((void *)pginfo.contents);
> >  	put_page(src_page);
> >  
> >  	return ret ? -EIO : 0;
> > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > index 515e2a5f25bb..4efda5e8cadf 100644
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -159,17 +159,17 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
> >  	pginfo.addr = 0;
> >  	pginfo.secs = 0;
> >  
> > -	pginfo.contents = (unsigned long)kmap_atomic(backing->contents);
> > -	pginfo.metadata = (unsigned long)kmap_atomic(backing->pcmd) +
> > +	pginfo.contents = (unsigned long)kmap_local_page(backing->contents);
> > +	pginfo.metadata = (unsigned long)kmap_local_page(backing->pcmd) +
> >  			  backing->pcmd_offset;
> >  
> >  	ret = __ewb(&pginfo, sgx_get_epc_virt_addr(epc_page), va_slot);
> >  	set_page_dirty(backing->pcmd);
> >  	set_page_dirty(backing->contents);
> >  
> > -	kunmap_atomic((void *)(unsigned long)(pginfo.metadata -
> > +	kunmap_local((void *)(unsigned long)(pginfo.metadata -
> >  					      backing->pcmd_offset));
> 
> For kunmap_local() one can use any address in the page.  So this can be:
> 
> 	kunmap_local((void *)(unsigned long)(pginfo.metadata));
> 
> 
> Regardless:
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

There's no data to show that this change would be useful to do.

Thus, as said earlier, the commit message is missing "why".

Definitive NAK with the current offering.

BR, Jarkko
