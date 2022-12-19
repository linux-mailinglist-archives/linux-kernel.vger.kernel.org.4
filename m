Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846C6650E88
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiLSPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiLSPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:21:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335363EE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:21:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so6666083wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ah1XfLb1oRte6SMokDx7hbNvXEAvKr70rzYhUhq1E7Y=;
        b=ijDMPek0chBV48nDJ22NRicFT+sTyv5d6nyklbgFNwaHDJhYRxoWPpa+RfxeZunQja
         MeGuhx8KrFtQ+kXi+hrxxqUF5vRB5sBUnN7nFBsM6CrUoDoeSOBSuLjkM5dYf1f836x8
         BlpVNOmclJhCD7SDoeR/s21zS5FoDZY0ndQkm9C6L/2mP1g/vTcH4dlSeL5YVOd/mTeD
         vfqjk5zYLO57xT1SDyuQO+/qXPgdShK/l58LQvpolVEdbkYjnZ1VAldJ0acDdJu+rCQ/
         lpHA1aZFX2TIlla9GEEaOSZCFXR+ToxYWT7wsBatlzsnS7ao1JUzJSPO9AagpUQLw1Xm
         RMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ah1XfLb1oRte6SMokDx7hbNvXEAvKr70rzYhUhq1E7Y=;
        b=0wehBoxKK+5/W7L+2Wt8gce45gt1O13HHA8r1WSbSE+38z3AQoSSKjOORqHh0Yj1/B
         HvAtKvi1sBOBa2ajy1xGI7BA8NmSb4nlaDsnW4mTu6DzM5+iTZEhWKnYBJeYue2mUSR7
         gyTXzmcNSfpJDNPff7dbYN2knbLxfmYCj7nrgQv4dhWAvKIlu3WUtkCMiaPbM1IQpjvi
         bDOohdx0ChEQHr2/HuZ4ZpW6gftF5khKz57Ndha8sT43vR+L+AfsjpZ48/yvAsU6/7W+
         x6w5Y+MXk+F/aKAlFUzx1Pva7dBVz/sL1EoinLoEw6XrbFeLKp2vVuKYbW3QIKp0daEO
         rHEQ==
X-Gm-Message-State: ANoB5pkSTyDNe5tjO68kbSguhiVVTr5bhNSZxSLiWIDnHeEt3dpC+eSC
        +ETPJ9SMK0nD8+uwGm6uF09JaNegzSBlRs4LCCSvGg==
X-Google-Smtp-Source: AA0mqf4IUPBiTbYGN4SrkL+NSourN3QywnwqvdYhkVuocdmUXY+YASSPmrR5bIBRumwhhcl30Waa52cRa+ZI7FcIO5g=
X-Received: by 2002:a05:600c:1c99:b0:3cf:71e4:75b with SMTP id
 k25-20020a05600c1c9900b003cf71e4075bmr1615009wms.114.1671463303463; Mon, 19
 Dec 2022 07:21:43 -0800 (PST)
MIME-Version: 1.0
References: <39636675da60fc6c54cc8bbab64ddbac@codethink.co.uk>
 <mhng-d601613f-1c73-48e0-bb06-7f87acd60cfa@palmer-ri-x1c9a>
 <CAO8XFHth5tJWi8EYag1FnOgD38i2pDe87G3u2dkkP+-gkYBZkg@mail.gmail.com> <E9917D44-4C61-4806-8A79-7F24AF504DA3@kernel.org>
In-Reply-To: <E9917D44-4C61-4806-8A79-7F24AF504DA3@kernel.org>
From:   Saleem Abdulrasool <abdulras@google.com>
Date:   Mon, 19 Dec 2022 07:21:32 -0800
Message-ID: <CAO8XFHvf9UE8abprkjiKx0RvMCDkyGdpc_MSoFk2pQCyA2qmxA@mail.gmail.com>
Subject: Re: [PATCH] riscv: avoid enabling vectorized code generation
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, ben.dooks@codethink.co.uk,
        ndesaulniers@google.com, nathan@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
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

On Fri, Dec 16, 2022 at 6:02 PM Conor Dooley <conor@kernel.org> wrote:
>
>
>
> On 16 December 2022 12:56:23 GMT-08:00, Saleem Abdulrasool <abdulras@google.com> wrote:
> >On Fri, Dec 16, 2022 at 11:54 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>
> >> On Fri, 16 Dec 2022 11:45:21 PST (-0800), ben.dooks@codethink.co.uk wrote:
> >> >
> >> >
> >> > On 2022-12-16 18:50, Saleem Abdulrasool wrote:
> >> >> The compiler is free to generate vectorized operations for zero'ing
> >> >> memory.  The kernel does not use the vector unit on RISCV, similar to
> >> >> architectures such as x86 where we use `-mno-mmx` et al to prevent the
> >> >> implicit vectorization.  Perform a similar check for
> >> >> `-mno-implicit-float` to avoid this on RISC-V targets.
> >> >
> >> > I'm not sure if we should be emitting either of the vector or floating
> >> > point instrucitons in the kernel without explicitly marking the section
> >> > of code which is using them such as specific accelerator blocks.
> >>
> >> Yep, we can't let the compiler just blindly enable V or F/D.  V would
> >> very much break things as we have no support, but even when that's in
> >> we'll we at roughly the same spot as F/D are now where we need to handle
> >> the lazy save/restore bits.
> >>
> >> This looks like an LLVM-only option, I see at least some handling here
> >>
> >> https://github.com/llvm/llvm-project/blob/a72883b7612f5c00b592da85ed2f1fd81258cc08/clang/lib/Driver/ToolChains/Clang.cpp#L2098
> >>
> >> but I don't really know LLVM enough to understand if there's some
> >> default for `-mimplicit-float` and I can't find anything in the docs.
> >> If it can be turned on by default and that results in F/D/V instructions
> >> then we'll need to explicitly turn it off, and that would need to be
> >> backported.
> >
> >Yes, this is an LLVM option, but I think that the `cc-option` wrapping
> >should help ensure that we do not break the gcc build.  This only
> >recently was added to clang, so an older clang would also miss this
> >flag.  The `-mimplicit-float` is the default AFAIK, which is why we
> >needed to add this flag in the first place.  Enabling V exposed this,
> >which is why the commit message mentions vector.
>
> You've said "enabling V" in the comment and here.
> By that, do you mean when V support is enabled in clang or when it is enabled in Linux?

Excellent distinction.  I meant enabled in the compiler, enabling it
in the kernel is not yet possible without the pending patchset.  This
makes us robust to when that patchset is merged, but in the meantime,
this protects against the V extension being enabled in the toolchain.
