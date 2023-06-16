Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB60733701
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbjFPRB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343594AbjFPRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:00:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459AB295B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD41B626E0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 17:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28EBC433CA;
        Fri, 16 Jun 2023 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686934830;
        bh=bBDGc7l+rp9aL56+CDe+wYli295kdN5xV+/yUxzXB2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RoXjZJcKmF7VUovmc25dlYZ7bZupC6kQfX7pDjiQaODyhpOeGZxCiFf21vPXfAwfP
         8+F5YkVnbWNFVt6sYpMarSafwIkFNaSWz0K8q01rE2tfoQ+TwBt4o5RNcK63i/Zsyj
         8nXF0skvL2WB5z/6v0lBUdAx7g1OZlHRMrMsx8uIFsxmRuRA/m7/w3ylzDhgoCsHvO
         KzSH1LXsvvp9EVK04jY8eO+kL0O8W3sa5xnwcPCzYCu7dNZzvl7BDCrZ6dRFaNt3OV
         Mz2ZLS+mfc13zG/Ih5VW1mOHdZquspBxinKG9cK1y3HB+xxMtITAXuBfgtqWM82073
         943N4gMUeY2Jg==
Date:   Fri, 16 Jun 2023 18:00:27 +0100
From:   Lee Jones <lee@kernel.org>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/mm/KASLR: Store pud_page_tramp into entry
 rather than page
Message-ID: <20230616170027.GM3635807@google.com>
References: <20230614163859.924309-1-lee@kernel.org>
 <20230614163859.924309-2-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614163859.924309-2-lee@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
>  arch/x86/mm/kaslr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Is there any more you need from me at this point?

Would you like me to resubmit with the Fixes: tag applied, or is
someone happy to apply it on merge?

> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 557f0fe25dff4..37db264866b64 100644
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
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 
Lee Jones [李琼斯]
