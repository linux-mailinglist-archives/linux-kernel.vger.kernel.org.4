Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2173064D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjFNRs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFNRsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:48:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17781FCA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:48:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25e3c0b50efso445419a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686764902; x=1689356902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAncbRxIINmHWj7OTH0lyMuX/I0YbKK+iTtLrxb1MJA=;
        b=unYfcwogVhaX8d5U/ZbjTjsyBK+mPbzxD32KqlBogLQH0oZa4JUq4lZ+weQT3wycBO
         YkteECZ8IGi8r85lV5Ui6MN4QZtJnF1KZP4t8E/Yyt+HCD0PaNZahdYv0uZiy3X62Xsq
         DRVQRDkv3xt67vS/ziBGRAFOWvQQ3rtYilNcEKEVoqVb2mWVvj8aZESqG+Kwic7htQeF
         Ssh5RGDemytzPaFSzon9QYWXdYxAh9kM2AoOCVYl7gRETYRZjuAhmaOK8ziZBgzTTA+m
         sGAmINF+OQBsyc3f3LJvKV7Hdo1/qnXj7e/PTy7FACFWnbL/zhisEhAGMDEswZoQ3J6g
         NJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764902; x=1689356902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAncbRxIINmHWj7OTH0lyMuX/I0YbKK+iTtLrxb1MJA=;
        b=W8FG1iD+lHP27eTVzqULA6X/J7lQSbwg/zPA1KwexmMnbRs5DAXaCeifUHk5yqFNCa
         6X0+61aGK+qpKjFiqmSA2Zd4PQMuHII9r9o5k5Vd5qLxtrKd7TqknP/J5IoO9Q9akSa3
         zrcyhzHKYU7oWpJBY9tlCARTy9Tokg3Ihoq5I6Pbw/flEMowt6CMdMDV0Beqhd6FXTHB
         lSsXAE2TF1zhjwKYZVhX6A9x/U03ofaKQiR2C8BEsI+OYLQvM6Ysom7r4QAy6kWsOEON
         Bqhas3mPG20E4xfEoWcLvyqybdztNFhsH6TqTsmvb5FfhEm6CPoUmI4e/h87zBhWQ1Eh
         jZXA==
X-Gm-Message-State: AC+VfDyc2wnjz2cL2vs1TumAnMkCQsbL7wzC92Lpv+kOMlgwMNg8PNr5
        IdVFJTGee0YpAp73pmXpMnDttO7Yp1lnIeSj6nALug==
X-Google-Smtp-Source: ACHHUZ7z/bryBojOKuiOXgsSM/VwrU7wojZF+iBTo0R6Nwj/ub7xwW3LRVkCG28t9iwDLsxdXPN7Qw==
X-Received: by 2002:a17:90b:1e4c:b0:259:5c6:39bc with SMTP id pi12-20020a17090b1e4c00b0025905c639bcmr1812050pjb.33.1686764902184;
        Wed, 14 Jun 2023 10:48:22 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:52fa:d6e7:fbc2:e917])
        by smtp.gmail.com with ESMTPSA id fs5-20020a17090af28500b002591f7ff90csm11406739pjb.43.2023.06.14.10.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:48:21 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:48:16 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Lee Jones <lee@kernel.org>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/mm/KASLR: Store pud_page_tramp into entry
 rather than page
Message-ID: <ZIn9YCcETx+Hlf6Z@google.com>
References: <20230614163859.924309-1-lee@kernel.org>
 <20230614163859.924309-2-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614163859.924309-2-lee@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:38:54PM +0100, Lee Jones wrote:
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

Nice work tracking this one down!

Fixes: 0925dda5962e ("x86/mm/KASLR: Use only one PUD entry for real mode trampoline")
Cc: <stable@vger.kernel.org>

> ---
>  arch/x86/mm/kaslr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
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
