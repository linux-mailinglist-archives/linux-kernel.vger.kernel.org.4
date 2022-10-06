Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDCC5F6D0B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJFRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiJFReq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:34:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F277CE0AC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:34:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 10so2398182pli.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ghBJM42G0KH3A4rEkgMKs2X2YiXX1kslk/eYANHkbyI=;
        b=dIUetA9vI2wF6FKjXZ7oI3FgqJ6bnyadTiQ4jL0fS6n+EJgQ2gwa5TiI4Y8RfRniiz
         76AY/1kJCEUj6/DgBf8PSzSPJayh7n2fv784ao5UF8kBN/8nuCjTDRHyvv+aeecD2iQk
         o9EuyIN5BPXi9NQqSq/3S8Bg5lrmWlVPY6InZ9yxbLFvHndFJUzBhCThPYTr1x+vEj/u
         cvn3/AtmlZNzwp98dqUtNepe+36DZa3hZM0kXUnPbmvAwW9pAT6h5NjQDA5Y+OyvHBsX
         XlbSnf4raWys3qBwbbCM3WjGNFlqQQGmLIEOGtka+K1s1zcTILbfy/PoMtzDjx2NkXt5
         I/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ghBJM42G0KH3A4rEkgMKs2X2YiXX1kslk/eYANHkbyI=;
        b=wU1rDDekzAvUQHGyg9L0k82NYvxPUD2UOdURnttcPXGTA+JKA6dEQK/klQQkVTvgX7
         yMKIFLqF0rq2MOoY8GCcXNFgbzyVzX6wummmZUQErLM2PrGx3zSc7VM6gRUT43WU2Lcm
         mu/h6OZpzzTy3ylDrin9h4ORht526BggAYkrEncak6XWk6YjHykO5a6hvahNI2R0V5AZ
         Fv5zv3YbUlb0sVyed19h3RMcP2KfqCG3kvbQ3lbqpv2OuuBNEeO/j8qdGbEdK2XkxmZT
         pF1K8y8HWkGsSTnGcS0ohIakTwTNSvTzUpcxApVRUZGiggyN4jBOIAoPBuyGg3BAsz3U
         njiw==
X-Gm-Message-State: ACrzQf3GRIGuME9NEQs2r+b6eRuHWW64MhYaJAaPrwy9+sXZVqtCaWym
        22NCwa6NE7/ctVJ2ORT4G0jAAEtj5/NBZJJOdTmDQg==
X-Google-Smtp-Source: AMsMyM4TOOpaPFr5Tk9MELDJvxwsGKOnqp5BEv3M/IH9RPJS87tOpmHKzK6tz/6zRelNtebCNFvjmeVczd/NxobmFww=
X-Received: by 2002:a17:90b:33c3:b0:20a:ebc3:6514 with SMTP id
 lk3-20020a17090b33c300b0020aebc36514mr10240383pjb.147.1665077682625; Thu, 06
 Oct 2022 10:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220925153151.2467884-1-me@inclyc.cn> <20221006141442.2475978-1-me@inclyc.cn>
In-Reply-To: <20221006141442.2475978-1-me@inclyc.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 Oct 2022 10:34:31 -0700
Message-ID: <CAKwvOd=sS3zMj4LxyM_FeMDCtyirgawcv-ek2ApY5fjaYL6MyQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
To:     YingChi Long <me@inclyc.cn>
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
        david.laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 7:15 AM YingChi Long <me@inclyc.cn> wrote:
>
> WG14 N2350 made very clear that it is an UB having type definitions with
> in "offsetof". This patch change the implementation of macro
> "TYPE_ALIGN" to builtin "_Alignof" to avoid undefined behavior.
>
> I've grepped all source files to find any type definitions within
> "offsetof".
>
>     offsetof\(struct .*\{ .*,
>
> This implementation of macro "TYPE_ALIGN" seemes to be the only case of
> type definitions within offsetof in the kernel codebase.
>
> I've made a clang patch that rejects any definitions within
> __builtin_offsetof (usually #defined with "offsetof"), and tested
> compiling with this patch, there are no error if this patch applied.
>
> ISO C11 _Alignof is subtly different from the GNU C extension
> __alignof__. __alignof__ is the preferred alignment and _Alignof the
> minimal alignment. For 'long long' on x86 these are 8 and 4
> respectively.
>
> The macro TYPE_ALIGN we're replacing has behavior that matches
> _Alignof rather than __alignof__.
>
> Signed-off-by: YingChi Long <me@inclyc.cn>
> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
> Link: https://godbolt.org/z/sPs1GEhbT
> Link: https://gcc.gnu.org/onlinedocs/gcc/Alignment.html
> Link: https://reviews.llvm.org/D133574

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v3:
> - commit message changes suggested by Nick and David
>
> v2: https://lore.kernel.org/all/20220927153338.4177854-1-me@inclyc.cn/
> ---
>  arch/x86/kernel/fpu/init.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index 621f4b6cac4a..de96c11e1fe9 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -133,9 +133,6 @@ static void __init fpu__init_system_generic(void)
>         fpu__init_system_mxcsr();
>  }
>
> -/* Get alignment of the TYPE. */
> -#define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
> -
>  /*
>   * Enforce that 'MEMBER' is the last field of 'TYPE'.
>   *
> @@ -143,8 +140,8 @@ static void __init fpu__init_system_generic(void)
>   * because that's how C aligns structs.
>   */
>  #define CHECK_MEMBER_AT_END_OF(TYPE, MEMBER) \
> -       BUILD_BUG_ON(sizeof(TYPE) != ALIGN(offsetofend(TYPE, MEMBER), \
> -                                          TYPE_ALIGN(TYPE)))
> +       BUILD_BUG_ON(sizeof(TYPE) !=         \
> +                    ALIGN(offsetofend(TYPE, MEMBER), _Alignof(TYPE)))
>
>  /*
>   * We append the 'struct fpu' to the task_struct:
> --
> 2.35.1
>


-- 
Thanks,
~Nick Desaulniers
