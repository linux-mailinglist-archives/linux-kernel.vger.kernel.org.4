Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4181E73DAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjFZJAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjFZI7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD7A3A96;
        Mon, 26 Jun 2023 01:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EB3760CF4;
        Mon, 26 Jun 2023 08:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551BBC433C8;
        Mon, 26 Jun 2023 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687769696;
        bh=DEIMe5XDnPx9xmBprqQ4BwzUKNcmLu7DPgVnu+X2mBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPz/03UFZKoppLCLlRCHYWZ+OA1yeujxHkjvqDTtpPj2lLWm4Jt2bfzuqsK2MC9Fe
         GpVACk/1wB/rbPlli3yts3ixM6U7QP2+CF/iVBEu7IwRLH1iUUhlNGt63MmnGlqCV2
         ORqBEGc/TNHcpT+96MGN+gubQZFUCTk+X4uexo0IBeAyistYA9ouPyTsgmBzytICiN
         qC2vR5JM0CxD4Obrg0nhN1RLGe7KN4noB6heXJyJf35XJnVQlCDbeHREPZYKnx7LzL
         530MlrGSE07S0sszDhsPA9kTMEggV1cUFkj/qa22JNRk3kqegO1WqPrDean1Sb4rPR
         3Ni8zcOkbLuaw==
Date:   Mon, 26 Jun 2023 09:54:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Avoid using set_pgd() outside of real
 PGD pages
Message-ID: <20230626085450.GA1344014@google.com>
References: <168694160067.404.13343792487331756749.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <168694160067.404.13343792487331756749.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stable,

On Fri, 16 Jun 2023, tip-bot2 for Lee Jones wrote:

> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     d082d48737c75d2b3cc1f972b8c8674c25131534
> Gitweb:        https://git.kernel.org/tip/d082d48737c75d2b3cc1f972b8c8674c25131534
> Author:        Lee Jones <lee@kernel.org>
> AuthorDate:    Wed, 14 Jun 2023 17:38:54 +01:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Fri, 16 Jun 2023 11:46:42 -07:00
> 
> x86/mm: Avoid using set_pgd() outside of real PGD pages
> 
> KPTI keeps around two PGDs: one for userspace and another for the
> kernel. Among other things, set_pgd() contains infrastructure to
> ensure that updates to the kernel PGD are reflected in the user PGD
> as well.
> 
> One side-effect of this is that set_pgd() expects to be passed whole
> pages.  Unfortunately, init_trampoline_kaslr() passes in a single entry:
> 'trampoline_pgd_entry'.
> 
> When KPTI is on, set_pgd() will update 'trampoline_pgd_entry' (an
> 8-Byte globally stored [.bss] variable) and will then proceed to
> replicate that value into the non-existent neighboring user page
> (located +4k away), leading to the corruption of other global [.bss]
> stored variables.
> 
> Fix it by directly assigning 'trampoline_pgd_entry' and avoiding
> set_pgd().
> 
> [ dhansen: tweak subject and changelog ]
> 
> Fixes: 0925dda5962e ("x86/mm/KASLR: Use only one PUD entry for real mode trampoline")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/all/20230614163859.924309-1-lee@kernel.org/g
> ---
>  arch/x86/mm/kaslr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 557f0fe..37db264 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(void)
>  		set_p4d(p4d_tramp,
>  			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
>  
> -		set_pgd(&trampoline_pgd_entry,
> -			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> +		trampoline_pgd_entry =
> +			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
>  	} else {
> -		set_pgd(&trampoline_pgd_entry,
> -			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> +		trampoline_pgd_entry =
> +			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
>  	}
>  }

Could we have this expedited please?  There are users waiting for it.

Upstream commit is:

  d082d48737c75 ("x86/mm: Avoid using set_pgd() outside of real PGD pages")

Thanks muchly.

-- 
Lee Jones [李琼斯]
