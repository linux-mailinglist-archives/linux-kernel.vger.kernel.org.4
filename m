Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7D624C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiKJUqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJUq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:46:29 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA9E5F90
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:46:28 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m6so3120477pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=94TsYS9Lhx3savK/i0rFKWoF2OB6Clo4zum9Q7WKAV8=;
        b=QkagP8ACYR8CagjP1G4Y5wJdFJ+jYesXPOL5g2+j1fUnp1hkvLCMFRVI4ER/b/Z4mD
         y4j1EEZ9lHH1umfNxhML7hgO8CrD6hGaW+rezADHqexqePWUNB/Xr2fjmDOWqnFkEUbv
         X/wPF8DR34roo3Eytdk9XCQHJT80DCQ6LagvkAiE4uI7BLF3Q1hj/TsNvym4lH0/IidO
         Hk3F/KyLZiM2zsutznNdhHeSDs1fdiHxGYAXVxzjG1VOPv/4hYjHDMNIlJkrO2xEsXO/
         f6jcN4bd6HS1qoAJcUrknp8vuUgDY1k4ZKYNzLfqeCrrFYmyWg4m5Cqa4q/9NHVSDuWA
         EA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94TsYS9Lhx3savK/i0rFKWoF2OB6Clo4zum9Q7WKAV8=;
        b=KtuMPqgYKEHQ1gMo1ETtDK4cvgSZ+qNbPbAip59VfhGFM+zNRNsCLNQ7mBb7mK/Wo9
         eYMfl1nPvVm9MhWC00gOXg0x7JCwy4MKZFs3Ogn8QY6UTY9ZTMpwWDTcuMZNf+kFflh/
         wfpSvg3uw9C4Cg2bqf1y511H7zc124OK+SCiTB0v0MYYjMZuSLq31kqIFlofgh+xdVtj
         fENe0E9GPi3mZCEMa8htNnGVvSC6+4HFJayb9SPERa89W0M2IO3zW/ZqRNV4QpvPZbnA
         tMEB2eNj5N/U2eeLeGWqdGGV+ynO3pDiTkirlDIOHXj9TT1FITQlbEYiUq7ug20vq7IA
         BQuQ==
X-Gm-Message-State: ACrzQf1jcJXTnxdARedKIWE5+Cg8wFZ5MEtqOXqtDUUbUdTVGc1t9Uzv
        0s5lO2TFEAFha73i0yoJ24nSeX3llfDbdxTT7tvFsg==
X-Google-Smtp-Source: AMsMyM6lWyNpiBMuUpIxE8MbdlCB9fhr4E+gnLs9ulGDCERUWsGS/HRwd7uPd6QgpzzzWpmoyYXNSBqYsniomAJw+RU=
X-Received: by 2002:a05:6a00:1a4a:b0:56d:98e3:4df8 with SMTP id
 h10-20020a056a001a4a00b0056d98e34df8mr3400650pfv.37.1668113187475; Thu, 10
 Nov 2022 12:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20221109000306.1407357-1-nathan@kernel.org>
In-Reply-To: <20221109000306.1407357-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Nov 2022 12:46:16 -0800
Message-ID: <CAKwvOdkxLXLna0cfkA8ay54vU0NwMj2AFR8CZg3pgpvqOKeXjw@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: Conditionally export __vdso_sgx_enter_enclave
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>
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

On Tue, Nov 8, 2022 at 4:04 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Recently, ld.lld moved from '--undefined-version' to
> '--no-undefined-version' as the default, which breaks building the vDSO
> when CONFIG_X86_SGX is not set:
>
>   ld.lld: error: version script assignment of 'LINUX_2.6' to symbol '__vdso_sgx_enter_enclave' failed: symbol not defined
>
> __vdso_sgx_enter_enclave is only included in the vDSO when
> CONFIG_X86_SGX is set. Only export it if it will be present in the final
> object, which clears up the error.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1756
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>
> It would be nice if this could be picked up for an -rc release but I
> won't argue otherwise.

Sounds like the lld change got reverted, so this is less urgent now,
but the change still LGTM regardless. Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Fixes: 8466436952017 ("x86/vdso: Implement a vDSO for Intel SGX enclave call")


>
> Alternatively, we could add '--undefined-version' to the vDSO ldflags
> but this does not seem unreasonable to me.
>
>  arch/x86/entry/vdso/vdso.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
> index 4bf48462fca7..e8c60ae7a7c8 100644
> --- a/arch/x86/entry/vdso/vdso.lds.S
> +++ b/arch/x86/entry/vdso/vdso.lds.S
> @@ -27,7 +27,9 @@ VERSION {
>                 __vdso_time;
>                 clock_getres;
>                 __vdso_clock_getres;
> +#ifdef CONFIG_X86_SGX
>                 __vdso_sgx_enter_enclave;
> +#endif
>         local: *;
>         };
>  }
>
> base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
> --
> 2.38.1
>
>


-- 
Thanks,
~Nick Desaulniers
