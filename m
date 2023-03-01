Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151526A778E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCAXHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCAXHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:07:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91A7C679;
        Wed,  1 Mar 2023 15:07:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73887B81183;
        Wed,  1 Mar 2023 23:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6E5C433D2;
        Wed,  1 Mar 2023 23:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677712047;
        bh=MPAF0lc8e93iLREsuT568rLIQ02nJyznEJo0U+MXk+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AHIFrmULcxtWKVU/v2fGIY5TfMCstozE57pE6KNu9pta7rMSzV1KRY1pV5faONDcZ
         la9NXlyWFgwap7TFPQcBm34hjZnHZWmv8LYZAA8TE2qh260IbTezNbHFvFLKYFhsIx
         pJJyLHEbMClh4Tp2ImxTpiLOlrzWPuGpP/TE6ox+R9Z5iBfdAaF7a+K1MXj99FaEop
         aKAZ0b1TlH7db87zgwygnHRnALMI4uWpArKpqEVJIyMLC4GunWG/5IFpqQTHNTzHqE
         cMxa7ISZm0oCphH6Yye/VZcJ9vlAVihzUqjQiXyVIfhE/PCmDEl0rsZVOjPr/BJMoL
         7hqB6q9eoz31g==
Date:   Thu, 2 Mar 2023 01:07:24 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jakob Koschel <jkl820.git@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH v2] x86/sgx: Avoid using iterator after loop in
 sgx_mmu_notifier_release()
Message-ID: <Y//arJZXs4JtqnHt@kernel.org>
References: <20230206-sgx-use-after-iter-v2-1-736ca621adc3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206-sgx-use-after-iter-v2-1-736ca621adc3@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:17:29PM +0100, Jakob Koschel wrote:
> If &encl_mm->encl->mm_list does not contain the searched 'encl_mm',
> 'tmp' will not point to a valid sgx_encl_mm struct.
> 
> Linus proposed to avoid any use of the list iterator variable after the
> loop, in the attempt to move the list iterator variable declaration into
> the marcro to avoid any potential misuse after the loop.
> Using it in a pointer comparision after the loop is undefined behavior
> and should be omitted if possible [1].
> 
> Instead we'll just use a 'found' boolean to indicate if an element
> was found.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
> Changes in v2:
> - refactor to use 'found' variable instead of moving code into the loop
> - add cover letter info into the patch
> - Link to v1: https://lore.kernel.org/r/20230206-sgx-use-after-iter-v1-1-c09fb5300b5e@gmail.com
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 2a0e90fe2abc..91fa70e51004 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -755,6 +755,7 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
>  {
>  	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
>  	struct sgx_encl_mm *tmp = NULL;
> +	bool found = false;
>  
>  	/*
>  	 * The enclave itself can remove encl_mm.  Note, objects can't be moved
> @@ -764,12 +765,13 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
>  	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
>  		if (tmp == encl_mm) {
>  			list_del_rcu(&encl_mm->list);
> +			found = true;
>  			break;
>  		}
>  	}
>  	spin_unlock(&encl_mm->encl->mm_lock);
>  
> -	if (tmp == encl_mm) {
> +	if (found) {
>  		synchronize_srcu(&encl_mm->encl->srcu);
>  		mmu_notifier_put(mn);
>  	}
> 
> ---
> base-commit: d2d11f342b179f1894a901f143ec7c008caba43e
> change-id: 20230206-sgx-use-after-iter-f584c1d64c87
> 
> Best regards,
> -- 
> Jakob Koschel <jkl820.git@gmail.com>
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
