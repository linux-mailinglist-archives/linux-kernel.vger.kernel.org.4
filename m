Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228767304EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjFNQbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjFNQa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8342718
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:30:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC2064478
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ED2C433C0;
        Wed, 14 Jun 2023 16:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686760240;
        bh=BTRpdtoeEYlLDtLE5Hz7bt0AbC5snDe5AP82plYvJB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhOQgO8G7rjuCicC7gc96DgmWWy5WmsW0DPUJAHvRFytzAflm2xm/wTrFaJiKc5QR
         /ucL6nOYDR+QO7DpHsmcygaAaASqwz4lC+0uQAU9ylqrB88mAOD5mU4HW6+5RR3/Sq
         BuevYHU8Rhd44fxypacea7cRdKgB0oXwbZj4qRbBBSX4+jR98pCfiebWP5P6RRR3ui
         7woSZEChE9xIRJI8rJnXknXln3W0PtKEfujbIholja0O0vCXlrQ/P+P+8mDcpkxFwv
         8+DnTNZ9DkBBzZh3WDvIA3fJusUpTF9on5k+Lk2ZZIRyZzq8xkxfXood8rIvnNFhfp
         Rb0bOAtfaV5gQ==
Date:   Wed, 14 Jun 2023 17:30:34 +0100
From:   Lee Jones <lee@kernel.org>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/mm/KASLR: Store pud_page_tramp into entry rather
 than page
Message-ID: <20230614163034.GB3635807@google.com>
References: <20230614155223.905222-1-lee@kernel.org>
 <20230614155223.905222-2-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614155223.905222-2-lee@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023, Lee Jones wrote:

> set_pgd() expects to be passed whole pages to operate on, whereas
> trampoline_pgd_entry is, as the name suggests, an entry.  The
> ramifications for using set_pgd() here are that the following thread of
> execution will not only place the suggested value into the
> trampoline_pgd_entry (8-Byte globally stored [.bss]) variable, PTI will
> also attempt to replicate that value into the non-existent neighboring
> user page (located +4k away), leading to the corruption of other global
> [.bss] stored variables.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  arch/x86/mm/kaslr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 557f0fe25dff4..ee6f22f3385b6 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -175,7 +175,7 @@ void __meminit init_trampoline_kaslr(void)
>  		set_pgd(&trampoline_pgd_entry,
>  			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));

This needs converting too.

v2 in test.

>  	} else {
> -		set_pgd(&trampoline_pgd_entry,
> -			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> +		trampoline_pgd_entry =
> +			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
>  	}
>  }

-- 
Lee Jones [李琼斯]
