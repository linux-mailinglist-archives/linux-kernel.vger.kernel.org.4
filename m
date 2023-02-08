Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92B868E5BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBHCBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHCBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:01:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEAB41B74;
        Tue,  7 Feb 2023 18:01:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5931761460;
        Wed,  8 Feb 2023 02:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE63AC433EF;
        Wed,  8 Feb 2023 02:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675821670;
        bh=mgwYtaT9A8LtpqMbidmBxeGCLHmzFF3ZFWIdQRS2Nk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGqCotlvesXZ0LPeAGM0zmKUJsjU6gJOHm24l9+gpzlv2KLyiHmF49T7wutqVI2oP
         l6sLTB4WG7GQPYPU3s307E1MT7TwSfkIClr2mLPgF0UOQqrBOlytPmb/CwxO0O++Qm
         uBmQYWwrc6mUJZVNm1EPK937pywK8oq1MZB5Hk4SO1XUeFi4HWuLS5OvuO6e4NQLy/
         +zGJckybNjqHsX2WWeirNEgEg5XXA9ZBwK4EPDWuDBB6dflgBtufkdfhjPZ8nSA1XP
         D8Z5XY2PBQmef0dfCvr8NZutvHIdmn7HTgposiMoMfE6JTujK+2XTNx/3q/x9+HX9O
         NofTWgiEBOaew==
Date:   Wed, 8 Feb 2023 04:01:05 +0200
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
Subject: Re: [PATCH] x86/sgx: Avoid using iterator after loop in
 sgx_mmu_notifier_release()
Message-ID: <Y+MCYYQJ0G5w1H63@kernel.org>
References: <20230206-sgx-use-after-iter-v1-1-c09fb5300b5e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206-sgx-use-after-iter-v1-1-c09fb5300b5e@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 11:39:02AM +0100, Jakob Koschel wrote:
> If &encl_mm->encl->mm_list does not contain the searched 'encl_mm',
> 'tmp' will not point to a valid sgx_encl_mm struct.

Please explain.

Perhaps, extend with something like ", and can be turned into
transient gadget."

> 
> Since the code within the guarded block is just called when the element
> is found, it can simply be moved into the list iterator.
> Within the list iterator 'tmp' is guaranteed to point to a valid
> element.
> 
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
> Linus proposed to avoid any use of the list iterator variable after the
> loop, in the attempt to move the list iterator variable declaration into
> the marcro to avoid any potential misuse after the loop.
> Using it in a pointer comparision after the loop is undefined behavior
> and should be omitted if possible [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]

I would move all this to the commit message. It is useful information.

> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 2a0e90fe2abc..db585b780141 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -764,15 +764,13 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
>  	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
>  		if (tmp == encl_mm) {
>  			list_del_rcu(&encl_mm->list);
> -			break;
> +			spin_unlock(&encl_mm->encl->mm_lock);
> +			synchronize_srcu(&encl_mm->encl->srcu);
> +			mmu_notifier_put(mn);
> +			return;
>  		}
>  	}
>  	spin_unlock(&encl_mm->encl->mm_lock);
> -
> -	if (tmp == encl_mm) {
> -		synchronize_srcu(&encl_mm->encl->srcu);
> -		mmu_notifier_put(mn);
> -	}
>  }
>  
>  static void sgx_mmu_notifier_free(struct mmu_notifier *mn)
> 
> ---
> base-commit: d2d11f342b179f1894a901f143ec7c008caba43e
> change-id: 20230206-sgx-use-after-iter-f584c1d64c87
> 
> Best regards,
> -- 
> Jakob Koschel <jkl820.git@gmail.com>
> 

BR, Jarkko
