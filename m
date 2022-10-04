Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704355F4C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJDW5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJDW5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:57:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D155A27B37
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:56:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b2so9028570plc.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 15:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QyAhz6ALR6OknrHi21cM45DVng3FrSfTwVHduk++aVc=;
        b=T8c6l4OEzQQlUGOM/Wu/f8con4dQ+VQ7A4dDgGymjbAxIfZBa/pDz3Z7i81RA37Jra
         bSFirZ7L7kRWgVWJszfW/uoy37k+Tb/Kv5tyfQ8KXrsC1wtkGRdtWR2xKau0IkqKmKUC
         Hp48AQ6aqlOAejj63soiAFfOaC7ZkDGYE2Cwy70INzcUOljB8/9yCXYXSF5yCIP41GYu
         8eDRtuYL3xU32myu+awpCVrEnp9yEpUnqasxIFjQBazADn78lfKPCIfwB08bv40x3kQy
         nA7nktqzR3SxWXByjG2jJwBXK4of04+CTc+3mGV6U7XaDCPtzJVpe+KsX0LSU6RWZnwV
         GgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QyAhz6ALR6OknrHi21cM45DVng3FrSfTwVHduk++aVc=;
        b=rlxIz5rKjiZw8HXfOsD9S6w4R1iche9sNAfHp2vhi2Nn0YOiWz56DJoxC6gmyb8IJ+
         uzbIabImBfAsVZigxVlf8YiT0KXpJSG59w2c8sfQ/9EMj1qyMHLUxaOlP2DpFyZtLqds
         3PPTEI9Umme9eOv8yCli1x2S2Y6rN5m//tHktwlq6s2AWq6OEtbouCMZYKRIH8Nkj2R+
         ILESn58uGlTTpAFEgcIiluh9liMr0hI40AT68r91Eu375nRV+XtWmZfZlIiASBoFjwQe
         OZAp4jJsu8Ytiht+uYDN0V7JjQFfoS4eOI8IdkwKGqg/09p6lGkwdspYKprivXbtdyRW
         wYTg==
X-Gm-Message-State: ACrzQf3gOMlWpYyFyABubJWLY1197rpTPsPWuLZoxX6Kr1KFTuXbJDmC
        EurfcPN7sVnMmtFZ5QcgsKSM6ES6parGj0synAzlkFmjkrB0/g==
X-Google-Smtp-Source: AMsMyM7fvdim6OhTKFokNtsHeGXAckZrL5jgxA67YFYqvLFqCJUb8Qamapk9O7Ss5n/7Iv0KW5fe1mFEG9uGLxXpPlk=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr1985982pjb.102.1664924217153; Tue, 04
 Oct 2022 15:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221004144145.1345772-1-nathan@kernel.org>
In-Reply-To: <20221004144145.1345772-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 4 Oct 2022 15:56:45 -0700
Message-ID: <CAKwvOdm=ZHjoF+j+ivj17t3OMpTA-5Dx71+g3KRSHO=L6RRpEA@mail.gmail.com>
Subject: Re: [PATCH -next] fs/ntfs3: Don't use uni1 uninitialized in ntfs_d_compare()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Tom Rix <trix@redhat.com>, ntfs3@lists.linux.dev,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 4, 2022 at 7:42 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
>   fs/ntfs3/namei.c:445:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>                   if (toupper(c1) != toupper(c2)) {
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/linux/ctype.h:64:20: note: expanded from macro 'toupper'
>   #define toupper(c) __toupper(c)
>                     ^
>   fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
>           __putname(uni1);
>                     ^~~~
>   ./include/linux/fs.h:2789:65: note: expanded from macro '__putname'
>   #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
>                                                                         ^~~~
>   fs/ntfs3/namei.c:445:3: note: remove the 'if' if its condition is always false
>                   if (toupper(c1) != toupper(c2)) {
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   fs/ntfs3/namei.c:434:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>                   if (!lm--) {
>                       ^~~~~
>   fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
>           __putname(uni1);
>                     ^~~~
>   ./include/linux/fs.h:2789:65: note: expanded from macro '__putname'
>   #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
>                                                                         ^~~~
>   fs/ntfs3/namei.c:434:3: note: remove the 'if' if its condition is always false
>                   if (!lm--) {
>                   ^~~~~~~~~~~~
>   fs/ntfs3/namei.c:430:22: note: initialize the variable 'uni1' to silence this warning
>           struct cpu_str *uni1, *uni2;
>                               ^
>                               = NULL
>   2 errors generated.
>
> There is no point in calling __putname() in these particular error
> paths, as there has been no corresponding __getname() call yet. Just
> return directly in these blocks to clear up the warning.
>
> Fixes: a3a956c78efa ("fs/ntfs3: Add option "nocase"")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1729
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  fs/ntfs3/namei.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index 315763eb05ff..5d3a6ce3f05f 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -431,10 +431,8 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
>
>         /* First try fast implementation. */
>         for (;;) {
> -               if (!lm--) {
> -                       ret = len1 == len2 ? 0 : 1;
> -                       goto out;
> -               }
> +               if (!lm--)
> +                       return len1 == len2 ? 0 : 1;

I know the code originally used this, but I can't help but look at
this and think that it should be:

return len1 != len2;

Do you mind cleaning it up while you're here?

Otherwise LGTM;

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

You may retain my RB tag whether you send that suggestion in a v2 or not.

>
>                 if ((c1 = *n1++) == (c2 = *n2++))
>                         continue;
> @@ -442,10 +440,8 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
>                 if (c1 >= 0x80 || c2 >= 0x80)
>                         break;
>
> -               if (toupper(c1) != toupper(c2)) {
> -                       ret = 1;
> -                       goto out;
> -               }
> +               if (toupper(c1) != toupper(c2))
> +                       return 1;
>         }
>
>         /*
>
> base-commit: d45da67caedacd500879de5e649360cc70777af7
> --
> 2.37.3
>


-- 
Thanks,
~Nick Desaulniers
