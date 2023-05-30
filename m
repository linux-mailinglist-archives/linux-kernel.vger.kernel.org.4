Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277367166DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjE3PUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjE3PUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DF8F1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA31626E6
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA54C433D2;
        Tue, 30 May 2023 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685460018;
        bh=aLPX3PSOw/E88e7TFUeDuK2/gbHOlb5J/baDelX6riE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmggXXhRMDcRxte+RzkEIylCRuhOKU1BlJz27xtHfjwU+4rHLMD7qDBmYm7w0MAp4
         6pY2GhpDXn0QpIwWL+1S4+RoiQ9/y8XIBWcQne/mgc+7dvTYn35wS8RgEwXN7CAInq
         k9VG5iVrgCVAKxfgG/ITWXLnQpZMccZ41UHEllLuOzixKnmnP2gbmJayQLJzNW8bRn
         6mPf74goHA42qkUMzr/8nVaOXP9iyWl+b5TrRQibKK9Rd+5Y5IbfadebHxJOIaeyD8
         yJBe63Otg1q67bgB14yO017SZnWNOl0B+s/pjsD1+mMAi4I0CamzTQ7nvKRyHZDzZ0
         Vf+q6wLQHjhJA==
Date:   Tue, 30 May 2023 08:20:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        ndesaulniers@google.com, goldstein.w.n@gmail.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/csum: Move csum_tail result parameter to a local
 variable.
Message-ID: <20230530152016.GA3503416@dev-arch.thelio-3990X>
References: <20230530135953.3341174-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530135953.3341174-1-trix@redhat.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, May 30, 2023 at 09:59:53AM -0400, Tom Rix wrote:
> clang with W=1 reports
> arch/x86/lib/csum-partial_64.c:74:20: error: variable
>   'result' is uninitialized when used here [-Werror,-Wuninitialized]
>                 return csum_tail(result, temp64, odd);
>                                  ^~~~~~
> This is a false positive, but there is never an intermediate value
> of result to pass into csum_trail, so move the parameter result to
> a local variable.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch. I sent the same one last Friday, which should be
in your inbox:

https://lore.kernel.org/20230526-csum_partial-wuninitialized-v1-1-ebc0108dcec1@kernel.org/

Dave picked it up yesterday, I guess -tip's auto-latest was not
refreshed for today's -next:

https://git.kernel.org/tip/2fe1e67e6987b6f05329740da79c8150a2205b0d

Cheers,
Nathan

> ---
>  arch/x86/lib/csum-partial_64.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index fe5861951b15..cea25ca8b8cf 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -21,8 +21,10 @@ static inline unsigned short from32to16(unsigned a)
>  	return b;
>  }
>  
> -static inline __wsum csum_tail(unsigned int result, u64 temp64, int odd)
> +static inline __wsum csum_tail(u64 temp64, int odd)
>  {
> +	unsigned int result;
> +
>  	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
>  	if (unlikely(odd)) {
>  		result = from32to16(result);
> @@ -45,7 +47,7 @@ static inline __wsum csum_tail(unsigned int result, u64 temp64, int odd)
>  __wsum csum_partial(const void *buff, int len, __wsum sum)
>  {
>  	u64 temp64 = (__force u64)sum;
> -	unsigned odd, result;
> +	unsigned odd;
>  
>  	odd = 1 & (unsigned long) buff;
>  	if (unlikely(odd)) {
> @@ -71,7 +73,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  		    "adcq $0,%[res]"
>  		    : [res] "+r"(temp64)
>  		    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
> -		return csum_tail(result, temp64, odd);
> +		return csum_tail(temp64, odd);
>  	}
>  	if (unlikely(len >= 64)) {
>  		/*
> @@ -141,7 +143,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  		    : [res] "+r"(temp64)
>  		    : [trail] "r"(trail));
>  	}
> -	return csum_tail(result, temp64, odd);
> +	return csum_tail(temp64, odd);
>  }
>  EXPORT_SYMBOL(csum_partial);
>  
> -- 
> 2.27.0
> 
