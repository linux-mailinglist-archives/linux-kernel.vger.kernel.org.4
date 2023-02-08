Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9636468E5BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBHCCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBHCCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:02:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0574042BDC;
        Tue,  7 Feb 2023 18:02:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3B8AB81B9B;
        Wed,  8 Feb 2023 02:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F7BC433EF;
        Wed,  8 Feb 2023 02:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675821727;
        bh=n6VBQo5q5XCgu3tif1UN274nK7btjUz+GbhtJxA6VLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iH1WDIWoGle+U4tGTeIuqYfU2yQ1+hZrdzPALLBAF7RN5muQuBEvOR99OIKdGdpYH
         otkQFB8V9YV19TcLhJ3I/DHG4h/md9w3Ewq9+szhPviNLw3kUNPFcCNUOXnHYt5mbd
         olIRJE2/0/5EccujvQF1vpH+yxkQQY/YOy5ValTr5l8gPPQxJDAlZc+pv+CvyXnWMx
         s7I7uwLNv9P6cv0Gz3KeVGL4FdJUCH5M66ZBFSzH4Ik806kri3AjH+//tF9YRMVBLe
         KHUXMmZBZwUliCIzc2UPRaqLVuuC1a0kp4SlZ2HXvA87mBah9J0Tis0gRHfYZbso+a
         jr9bS1Mx4ppvA==
Date:   Wed, 8 Feb 2023 04:02:02 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jakob Koschel <jkl820.git@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] x86/sgx: Avoid using iterator after loop in
 sgx_mmu_notifier_release()
Message-ID: <Y+MCmhoAnayUwHam@kernel.org>
References: <20230206-sgx-use-after-iter-v1-1-c09fb5300b5e@gmail.com>
 <1dbc9402-5baf-4a92-96b3-8b3a9c108f01@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbc9402-5baf-4a92-96b3-8b3a9c108f01@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:10:53AM -0800, Dave Hansen wrote:
> On 2/6/23 02:39, Jakob Koschel wrote:
> > If &encl_mm->encl->mm_list does not contain the searched 'encl_mm',
> > 'tmp' will not point to a valid sgx_encl_mm struct.
> > 
> > Since the code within the guarded block is just called when the element
> > is found, it can simply be moved into the list iterator.
> > Within the list iterator 'tmp' is guaranteed to point to a valid
> > element.
> > 
> > Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> > ---
> > Linus proposed to avoid any use of the list iterator variable after the
> > loop, in the attempt to move the list iterator variable declaration into
> > the marcro to avoid any potential misuse after the loop.
> > Using it in a pointer comparision after the loop is undefined behavior
> > and should be omitted if possible [1].
> 
> I think there's a big difference between "undefined behavior" and
> "someone wants to flip a switch to *make* this undefined behavior".  My
> understanding is that this patch avoids behavior which _is_ defined today.
> 
> Is there some effort to change this behavior across the tree that I missed?
> 
> In any case, this patch also kinda breaks the rule that you're supposed
> to make the common path through the code at the lowest nesting level.
> It makes the common case look like some kind of error handling.  Would
> something like the attached patch work?

> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 68f8b18d2278..e1bd2a5790a7 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -755,6 +755,7 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
>  {
>  	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
>  	struct sgx_encl_mm *tmp = NULL;
> +	bool mm_found = false;

Maybe just "found" ? (nit)

>  
>  	/*
>  	 * The enclave itself can remove encl_mm.  Note, objects can't be moved
> @@ -764,12 +765,13 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
>  	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
>  		if (tmp == encl_mm) {
>  			list_del_rcu(&encl_mm->list);
> +			mm_found = true;
>  			break;
>  		}
>  	}
>  	spin_unlock(&encl_mm->encl->mm_lock);
>  
> -	if (tmp == encl_mm) {
> +	if (mm_found) {
>  		synchronize_srcu(&encl_mm->encl->srcu);
>  		mmu_notifier_put(mn);
>  	}

BR, Jarkko
