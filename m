Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61CF6F5C41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjECQwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjECQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:52:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A2655AD
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:52:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94eff00bcdaso1040674666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683132737; x=1685724737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHVhQYzfld0G3Q00SBMgtA1efoI8gmOuzAdIqG+F6L0=;
        b=A3P42I+ZvOl097Rp80s10pAIZb6piOqKWhBPqxaWRVb0MYtaIP81nlAQJsWyqO6AgR
         8SBalUVQhlI1JVxK5M4FeYbOpU5F2LoLARsq/+0rry05Hj2ZANE6mxCXD34XOmRza+/Z
         DSOyGfGA2Br6QazuoIeXeIkX78RSjbRQpDrIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683132737; x=1685724737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHVhQYzfld0G3Q00SBMgtA1efoI8gmOuzAdIqG+F6L0=;
        b=k0p1WLVtCLAApFC0ZPkI5Gx8Q9+1nWANVOu2vIgaZBvw9fKf4boIewAEvTBzTwY30z
         xqqEqpWnb3chliRYPfiyWpXPa1CGQT2YXRl9UxBNbd5bB0kR9QOET7MmACfqzE3WdnSt
         4kHNZeEL8qHhnDzyiXRlf0hMOLf1y0Ma99GLo2EMC50Z7Zvi+gbxU9mxOlX+m2bc6inV
         Ny2rBWGqeQK/QWTxJ6cFKh4hEvPLP0iYt1IOuyIfDmSOYm3gTIF42ydNwFjkJTA0krJk
         hbCpmWnw9U8zY8+/Ki+d6/dpURrtQqvFcO9TfmDWli46QFvxan2X9xwMeZxLL9Ep7CV5
         1qIg==
X-Gm-Message-State: AC+VfDwqXAFyvm/W7Jtb5VCgMUKLdM/nfKDcyIu5uwymR7h41LaocpyR
        1UtmndwPOGw8fDph+gya3iGIRNabIWeGHvO8OhxG0w==
X-Google-Smtp-Source: ACHHUZ6wu+hbUnNT/QA6aMnCvqUcE7dY4FK4yLXQYFgcmYODB2NxxpWjWqeYjifRlwrPXgQDq5Yy3A==
X-Received: by 2002:a17:907:70b:b0:94e:fa56:a74f with SMTP id xb11-20020a170907070b00b0094efa56a74fmr3466907ejb.14.1683132737499;
        Wed, 03 May 2023 09:52:17 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id jo2-20020a170906f6c200b009538cc79241sm17723830ejb.56.2023.05.03.09.52.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 09:52:16 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1042918166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:52:16 -0700 (PDT)
X-Received: by 2002:a17:907:6d83:b0:95f:2046:d20d with SMTP id
 sb3-20020a1709076d8300b0095f2046d20dmr4171169ejc.2.1683132736505; Wed, 03 May
 2023 09:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com> <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com> <95f17f84-f172-417c-fe7e-ca0a07b205fb@intel.com>
In-Reply-To: <95f17f84-f172-417c-fe7e-ca0a07b205fb@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 09:51:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOvcWrmwhqJrMhmGty46k+10Bd927UTTVVqB1q9Pj6Xg@mail.gmail.com>
Message-ID: <CAHk-=wgOvcWrmwhqJrMhmGty46k+10Bd927UTTVVqB1q9Pj6Xg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 9:45=E2=80=AFAM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 5/3/23 09:38, Linus Torvalds wrote:
> > If somebody actually tries to untag a kernel address, that would be a
> > bug anyway, as far as I can tell.
>
> Is it a bug?  The do_madvise() path, for instance, is passing a value in
> there that came right from userspace.

That's still a "user address" - just not a *valid* one.

So we do not want to mask the high bit off - because that is what will
catch people later doing things like vma address range comparisons on
it and notice "that's not a valid address", but it's also not a
"kernel address" that we need to preserve as such.

So yeah, it's a bit confusing in that it's _also_ true that "kernel
addresses have the high bit set" and "user addresses have the high bit
clear", and I'm basically using two different semantics for "kernel
address".

IOW: what I mean by "it's not valid to do 'untagged_addr()' on a
kernel address" is that you can't take a (valid) kernel address, do
'untagged_addr()' on it, and expect it to still work as a kernel
address.

But at the same time you *are* supposed to be able to use
'untagged_addr()' on a - untrusted and possibly invalid - user
pointer, and it's supposed to end up having the tag bits clear and
still be usable as a user pointer. And yet still also be caught by any
validity checks (ie a high bit set would never be a valid user
pointer, not even after doing 'untagged_addr()' on it).

                Linus
