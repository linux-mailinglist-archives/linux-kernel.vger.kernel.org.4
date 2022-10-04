Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81275F4CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJDX0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJDX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:26:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3701E66138
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:26:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so251925pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 16:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7/Ozj3mcJHGAbiaTjJPeg1Cq0BOU1VOEYEwFpmEWKCM=;
        b=llPMwaCiE9svemlfZqli62QUjvnug0AjUfYmUGejcxHbeFLQzrs63Wval4R32RWsHg
         +Az6jF6ioPj+7Fo1t2L69xg0tVVHdFxCe0D/voKanm4stAdZgmX5t5qodEVHpZDgd0+9
         56jlkNiFTjn62io5dQDAzOfNUjkhCdtYYRpGoxxDGgQQznSmN7+9ms/r3VLqSw27je47
         J8PhqljQ1VWp5tNzLNZXgCU7ZqRYvwMf3ZKhF0Y8kcOXuUcx77j8vwD+/0La/xJ5oZFv
         15F+xfb1NOIy87TBxyHwpuO9j8I9PYX0kQ4b/HgxO2hq2bePBhWZV31DjFCmOn90fDQh
         b4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7/Ozj3mcJHGAbiaTjJPeg1Cq0BOU1VOEYEwFpmEWKCM=;
        b=QORBEs/VSEKxsnWtujecwaWMFtiZvQoBJahCHp6LdmJVr2oBaNbCGzY6U06v3sgiyB
         ggSDDAPw9bfAYmxn7q9C7QrFCxJ9NX2lcpxQa33QCCZqs2Gx6I4rT84/brUFld38X2K9
         OU0XoDVWJpRLlCUDoxYG2fJh1ULRxDzdsTXLJS5qIVEBuC/k1lmGiqSYwmiXtX4Wtdw5
         aCCTUb0tV8GA7kDthUk0la05HK3q37q4WL6NAz8XeTaVajHQKSAStAWsD769EDii9Ulu
         FMkDk/KauYxWhCiyiS7G61bB4xtBAEmcjVJUY29cWKcKRsRPLUDghygR036iI7MovGa8
         f9nA==
X-Gm-Message-State: ACrzQf2ke3NHQyRxqkHNps1BhDRW+ubu9zYxKGhG0iUENcNMM0JYtK60
        QL5pqxEC1EQLJyHOVEtHd92iE7H/kLXciu+Es3oTHA==
X-Google-Smtp-Source: AMsMyM5rQkHFdryWEFHJkT4DR3oJz6pJFO4t4FvddE/j05hxDwSkHKNVetdFAEuansIfTVvwPxLVRBpyv/iUCPONt+8=
X-Received: by 2002:a17:90b:33c3:b0:20a:ebc3:6514 with SMTP id
 lk3-20020a17090b33c300b0020aebc36514mr641575pjb.147.1664925977583; Tue, 04
 Oct 2022 16:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221004232359.285685-1-nathan@kernel.org> <20221004232359.285685-2-nathan@kernel.org>
In-Reply-To: <20221004232359.285685-2-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 4 Oct 2022 16:26:05 -0700
Message-ID: <CAKwvOdkrmMQVaQ6vD9f2BN_tYyxcjhwH28pGxkstmr-Pop-z6A@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/2] fs/ntfs3: Eliminate unnecessary ternary
 operator in ntfs_d_compare()
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

On Tue, Oct 4, 2022 at 4:24 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> 'a == b ? 0 : 1' is logically equivalent to 'a != b'.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v2: New patch.
>
>  fs/ntfs3/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index 5d3a6ce3f05f..6b0d2c01d6ff 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -432,7 +432,7 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
>         /* First try fast implementation. */
>         for (;;) {
>                 if (!lm--)
> -                       return len1 == len2 ? 0 : 1;
> +                       return len1 != len2;
>
>                 if ((c1 = *n1++) == (c2 = *n2++))
>                         continue;
> --
> 2.37.3
>


-- 
Thanks,
~Nick Desaulniers
