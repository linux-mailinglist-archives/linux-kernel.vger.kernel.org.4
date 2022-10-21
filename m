Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3F6079FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJUO4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJUO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:56:37 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B8230A97
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:56:35 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l145so3717318ybl.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MXszQBjZ98W1JNjl7z/CBVn21I8z5KCWI0YYK8AF+nY=;
        b=bXIrDbN3pFGsi0/VbTuqtGrpylburRM87bqjUFvrV+L6k6rbOrKzys6SfHq7BqpXun
         R7Uw5dLtiQshT8+7iHdmhQUbsXH1WRshh3XauTBdlHa41yrRPAfdo8/WPOnJzJLUXdtI
         SXoqjpdZTPLd8Hlbc5s30YVLXqcmd/QcSiQIkEnJu5uRJOOzH0tkdFEuQePNdlEZP+ZU
         IPrHzrRgdpoS+VW9mB5n/nmnVRaZCsR16aYLGSGL2Q8HmH2O66Z+wsrf0FHMWQsqCGfI
         md15SU4X3IZ76IY9rbDpAM2Lit2za2JJ62nCKp73W3KIaqUyNLhp0O133Zui1YZRjg6J
         I6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXszQBjZ98W1JNjl7z/CBVn21I8z5KCWI0YYK8AF+nY=;
        b=YmreDwgXscuEOVPp2kuLSvWV2OSqhfxFmQ/xR0igX/OGi64xhEgneGKmxLEBOGTUeS
         t7tT27Y+Al1O/6if0lkb86vDKFejuIcA8Kmmpe0ProsOf2Jv3n9casUQ4OV5zlM5Aekr
         yptcGNXU0Qjt9OxrACjjN6bxovQuS9nzAfhQmkPMqYkqhqJieS3sCjXEU2mEuATCtK9W
         vTlhRQ88PyPFsPj8uVnAvaz6zMyjj2H0cHiM85rszwYhhLLnBAe6FcLurbHjN87Zzg9i
         qKg5jnUkXn+SkLe2IyrIVpgaiAoOxSWsUbturPVWHtAELlr3Xma6Bc3eE+9J/vznhh2z
         0wvA==
X-Gm-Message-State: ACrzQf1T4vPmRm/ZaRNthhSNnJnrCzBEbQWeSQA3QZFgi5mrPOq6rDat
        IF53hxxCwmlX8NTUxAQHKVZrPjyGY6qqzcuNIAhwYw==
X-Google-Smtp-Source: AMsMyM79uhImRNYQ9Fl09Py/PgaQ05sW8HY/+b3/0XOGRRhKO8nGXWs9IofSAHn/9S/IsOQLV9Tlcq1GGrFY4LmA/To=
X-Received: by 2002:a05:6902:1542:b0:6ca:675a:fdee with SMTP id
 r2-20020a056902154200b006ca675afdeemr3590982ybu.125.1666364194126; Fri, 21
 Oct 2022 07:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221021115956.9947-1-ojeda@kernel.org> <20221021115956.9947-3-ojeda@kernel.org>
In-Reply-To: <20221021115956.9947-3-ojeda@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Fri, 21 Oct 2022 07:55:57 -0700
Message-ID: <CANpmjNMxKrpAL_3KHiey5-7dep2h5kTwqWjnqADrU2+AsHohww@mail.gmail.com>
Subject: Re: [PATCH 3/5] compiler-gcc: remove attribute support check for `__no_sanitize_thread__`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 at 05:00, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> The attribute was added in GCC 5.1, which matches the minimum GCC version
> supported by the kernel.
>
> Therefore, remove the check.
>
> Link: https://godbolt.org/z/vbxKejxbx
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Marco Elver <elver@google.com>

> ---
>  include/linux/compiler-gcc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index bfce7f4d0978..ba207deb77ca 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -84,7 +84,7 @@
>
>  #define __no_sanitize_address __attribute__((__no_sanitize_address__))
>
> -#if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
> +#if defined(__SANITIZE_THREAD__)
>  #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
>  #else
>  #define __no_sanitize_thread
> --
> 2.38.1
>
