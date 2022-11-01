Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFFA61426D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 01:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKAAwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 20:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKAAwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92FD14D3E;
        Mon, 31 Oct 2022 17:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F9461411;
        Tue,  1 Nov 2022 00:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B039C433D6;
        Tue,  1 Nov 2022 00:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667263940;
        bh=HWEyYhTRPVpxScw+Umz7p1bNJQ9QmOz14vkT8EGXetc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zs88KE0XmeUvH7SNcf3URWb5ISZx9zmIJ1IEYkN24oL2k3DWU7WEWQtbsdeH5Wo3e
         EzoouQ0U8xQstv4a4PARXwRDHiasUiTO89U7ZhXVD5cgNezbnMp457stM2vLNpoDL9
         B3QHsDxK4hNHY7OQ7Wflh+JCKNVjxOI5krJMJAwzEkqBdOWkLeL/9gY8okgneLMq5Y
         PnC8CyVlPOCQ4hBN93Tt2zqI/1O4nGlTA+hCS0E2YEnA1lJj3yRqRm39TFzxHLL8de
         gF4JoKt4cwJyuObEbitJ44ogEABH4h+b6UaU7JrmaL3rJIBoyvOoOKAMKGyRgqlEnM
         Q+tX/nnuPRs9w==
Date:   Tue, 1 Nov 2022 02:52:16 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, md.iqbal.hossain@intel.com,
        haitao.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Reduce delay and interference of enclave release
Message-ID: <Y2BtwGIfnW4fqkUg@kernel.org>
References: <06a5f478d3bfaa57954954c82dd5d4040450171d.1666130846.git.reinette.chatre@intel.com>
 <Y1WemizNZgFOVxja@kernel.org>
 <77943714-b988-bf14-8795-c72ff0424418@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77943714-b988-bf14-8795-c72ff0424418@intel.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:56:39AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 10/23/2022 1:06 PM, Jarkko Sakkinen wrote:
> > On Tue, Oct 18, 2022 at 03:42:47PM -0700, Reinette Chatre wrote:
> 
> ...
> 
> >> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> >> index 1ec20807de1e..f7365c278525 100644
> >> --- a/arch/x86/kernel/cpu/sgx/encl.c
> >> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> >> @@ -682,9 +682,12 @@ void sgx_encl_release(struct kref *ref)
> >>  	struct sgx_encl *encl = container_of(ref, struct sgx_encl, refcount);
> >>  	struct sgx_va_page *va_page;
> >>  	struct sgx_encl_page *entry;
> >> -	unsigned long index;
> >> +	unsigned long count = 0;
> >> +
> >> +	XA_STATE(xas, &encl->page_array, PFN_DOWN(encl->base));
> >>  
> >> -	xa_for_each(&encl->page_array, index, entry) {
> >> +	xas_lock(&xas);
> >> +	xas_for_each(&xas, entry, PFN_DOWN(encl->base + encl->size  - 1)) {
> > 
> > I would add to declarations:
> > 
> > unsigned long nr_pages = PFN_DOWN(encl->base + encl->size  - 1);
> > 
> > Makes this more readable.
> 
> Will do, but I prefer to name it "max_page_index" or something related instead.
> "nr_pages" implies "number of pages" to me, which is not what
> PFN_DOWN(encl->base + encl->size - 1) represents. What is represented is the
> highest possible index of a page in page_array, where an index is the
> pfn of a page.

Yeah, makes sense.

> 
> > 
> >>  		if (entry->epc_page) {
> >>  			/*
> >>  			 * The page and its radix tree entry cannot be freed
> >> @@ -699,9 +702,20 @@ void sgx_encl_release(struct kref *ref)
> >>  		}
> >>  
> >>  		kfree(entry);
> >> -		/* Invoke scheduler to prevent soft lockups. */
> >> -		cond_resched();
> >> +		/*
> >> +		 * Invoke scheduler on every XA_CHECK_SCHED iteration
> >> +		 * to prevent soft lockups.
> >> +		 */
> >> +		if (!(++count % XA_CHECK_SCHED)) {
> >> +			xas_pause(&xas);
> >> +			xas_unlock(&xas);
> >> +
> >> +			cond_resched();
> >> +
> >> +			xas_lock(&xas);
> >> +		}
> >>  	}
> > 
> >         WARN_ON(count != nr_pages);
> > 
> 
> nr_pages as assigned in your example does not represent a count of the
> enclave pages but instead a pfn index into the page_array. Comparing it
> to count, the number of removed enclave pages that are not being held
> by reclaimer, is not appropriate.
> 
> This check would be problematic even if we create a "nr_pages" from
> the range of possible indices. This is because of how enclave sizes are
> required to be power-of-two that makes it likely for there to be indices
> without pages associated with it.

Ok.

> 
> >> +	xas_unlock(&xas);
> >>  
> >>  	xa_destroy(&encl->page_array);
> >>  
> >> -- 
> >> 2.34.1
> >>
> 
> Reinette

BR, Jarkko
