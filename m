Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DB364F2D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiLPU4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:56:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D268FC6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:56:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o5so3684832wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v+Af/DEV4PdtRUjyfJ2iTdV76TVrp0C2ayMFKFEVB2c=;
        b=E5nwDI3bKXkw8yYS054w9i5MakXEtfxaEfjrTsaWzDT8rID7jNtodv6vGdTjzbVLTn
         HzkuP1U8qOky4kZukAUFJq8+rJFejRpTu087aZqdvfHilYSouF9Z87dFsx8Y7dyrZFN0
         FCdPQBiS3t6TDK9xjH9TNlf4intPX5+yA85JIhA2ivJgfOK717jVa/qgHsCjlRa9vUfB
         XF0Aqz42To+vwDyVoRRkUqxSGlfW0JNq7CQTws9X5bUP4+sYkd+o4maTBS382zHIGdgB
         UxRHqhHNTFlXWxIqn40vi8jHkgKf3tIQ7ycUfHCFWuZN06WkAdR+GXcTNRLd9zxZxihr
         7VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+Af/DEV4PdtRUjyfJ2iTdV76TVrp0C2ayMFKFEVB2c=;
        b=HY4+fYV7WQJN9yicf5ba0eJJSwjBCm2xDDyVIL4x58kb9X4Q7hscbvlWeUauuh2so2
         GvPz+43Khlj1VIvx1li5K4b6+7XcAJAtuvS02QqeWo5Bk1ubpuv8rffFM2BUweMGmv8A
         bL6RgtYCH3OnGwlC6MkuiGnE9Ol9lo6rhejpyNgnLqWMnHPcWshiJWZlURHnqpETAdbQ
         KPmJDTCP8reqAgvE4lnrRISQK86Y0L3MA9hGtgjBKcO08r5cRj12n8xwQSNRrdmxqUEG
         K/7uAW48PCQxsDUuwLiIKTh0OrJRxepccWSXsmjq3ImEXdd7d7YjHU02zVc8pjDT1IP8
         lpVA==
X-Gm-Message-State: ANoB5pnGZFbpZsQE31xo8CqS0KNWEZBykrfjKLUlf12AxtRowHJhtlbx
        hCYK0tiOCe12VD5llPxp32MlBz7OvzZzkG7F95ESHg==
X-Google-Smtp-Source: AA0mqf7EZWN+aK6uCCQcaEO8qTPQ06ENG2JaQIflqu52uZFG510VEzbCZSsopN8buqhZukBi5ngAKcwlaSZnZU4P/cg=
X-Received: by 2002:a5d:5e89:0:b0:242:739d:7f85 with SMTP id
 ck9-20020a5d5e89000000b00242739d7f85mr7843187wrb.407.1671224194704; Fri, 16
 Dec 2022 12:56:34 -0800 (PST)
MIME-Version: 1.0
References: <39636675da60fc6c54cc8bbab64ddbac@codethink.co.uk> <mhng-d601613f-1c73-48e0-bb06-7f87acd60cfa@palmer-ri-x1c9a>
In-Reply-To: <mhng-d601613f-1c73-48e0-bb06-7f87acd60cfa@palmer-ri-x1c9a>
From:   Saleem Abdulrasool <abdulras@google.com>
Date:   Fri, 16 Dec 2022 12:56:23 -0800
Message-ID: <CAO8XFHth5tJWi8EYag1FnOgD38i2pDe87G3u2dkkP+-gkYBZkg@mail.gmail.com>
Subject: Re: [PATCH] riscv: avoid enabling vectorized code generation
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     ben.dooks@codethink.co.uk, ndesaulniers@google.com,
        nathan@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
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

On Fri, Dec 16, 2022 at 11:54 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 16 Dec 2022 11:45:21 PST (-0800), ben.dooks@codethink.co.uk wrote:
> >
> >
> > On 2022-12-16 18:50, Saleem Abdulrasool wrote:
> >> The compiler is free to generate vectorized operations for zero'ing
> >> memory.  The kernel does not use the vector unit on RISCV, similar to
> >> architectures such as x86 where we use `-mno-mmx` et al to prevent the
> >> implicit vectorization.  Perform a similar check for
> >> `-mno-implicit-float` to avoid this on RISC-V targets.
> >
> > I'm not sure if we should be emitting either of the vector or floating
> > point instrucitons in the kernel without explicitly marking the section
> > of code which is using them such as specific accelerator blocks.
>
> Yep, we can't let the compiler just blindly enable V or F/D.  V would
> very much break things as we have no support, but even when that's in
> we'll we at roughly the same spot as F/D are now where we need to handle
> the lazy save/restore bits.
>
> This looks like an LLVM-only option, I see at least some handling here
>
> https://github.com/llvm/llvm-project/blob/a72883b7612f5c00b592da85ed2f1fd81258cc08/clang/lib/Driver/ToolChains/Clang.cpp#L2098
>
> but I don't really know LLVM enough to understand if there's some
> default for `-mimplicit-float` and I can't find anything in the docs.
> If it can be turned on by default and that results in F/D/V instructions
> then we'll need to explicitly turn it off, and that would need to be
> backported.

Yes, this is an LLVM option, but I think that the `cc-option` wrapping
should help ensure that we do not break the gcc build.  This only
recently was added to clang, so an older clang would also miss this
flag.  The `-mimplicit-float` is the default AFAIK, which is why we
needed to add this flag in the first place.  Enabling V exposed this,
which is why the commit message mentions vector.

>
> Maybe Nick or Nathan knows what's up here?
