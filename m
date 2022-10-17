Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98A26017F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiJQTpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiJQTp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C92378BF4;
        Mon, 17 Oct 2022 12:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAFAF6110F;
        Mon, 17 Oct 2022 19:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BF4C433C1;
        Mon, 17 Oct 2022 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666035922;
        bh=A0N8s8K+DtKwoI8LR2XF03YAu6qFGx6GfsIWdZuobYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pwn7MOFNwaAGZBvcj6myxzHfrQnprFnZX8PoUV9Q5ROmLa8B6vkLcxnbMTisNXQhA
         OlMMwdXQL/98jH6zX9gsJ8pSXzE4YlaTfcZb7W27r4a8XFAtFEXLF9iZFPikqYejc+
         pM0miM/UvMkj83B/k7LQtpYdHjJPk3mDJC3hE/EzI/hs+CsZvsiUBV28BPMixMmHoV
         lwGWWOaHEKnux/kBSBsRvYhhNQXDz5S8bFjnNd+avxu9BZJnpHp3TfQG3Mlu2pnor2
         GqWhbu/JnaCsJCxo/WAw475q3b7EzDgyRDWiHICr1twp1cPBkBuoRYUO7DQMwMXBW8
         6eQXK6uSNHGfQ==
Received: by mail-lf1-f43.google.com with SMTP id b1so19146876lfs.7;
        Mon, 17 Oct 2022 12:45:22 -0700 (PDT)
X-Gm-Message-State: ACrzQf3qTwf/lzgUQ2SGCBYkij9Bdago8QnP5pVrC3w/2WVZnzldD1Wg
        h161f2Vo+i5ZwVEIZKGXV3eW5EwhbXGzY4RM1+o=
X-Google-Smtp-Source: AMsMyM6qay7l6/gNOsgrTu8vnfA9BC4xVy7hUP6l9qh/KB6fFUU0oW0PZgFmrwRpsEwYGJ2QpyTmMEGWMw3ySuLcZBs=
X-Received: by 2002:a05:6512:c8:b0:4a4:5ef8:953b with SMTP id
 c8-20020a05651200c800b004a45ef8953bmr4597567lfp.539.1666035920172; Mon, 17
 Oct 2022 12:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com> <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook> <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
 <202210171237.DF5D4A3FD7@keescook>
In-Reply-To: <202210171237.DF5D4A3FD7@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Oct 2022 21:45:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
Message-ID: <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 at 21:40, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 17, 2022 at 09:33:06PM +0200, Ard Biesheuvel wrote:
> > On Mon, 17 Oct 2022 at 21:29, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Oct 17, 2022 at 08:14:14PM +0200, Ard Biesheuvel wrote:
> > > > So once we use the same size for input and output, I was curious
> > > > whether we could encrypt in place, and get rid of the big_oops_buf.
> > > > And the answer is 'yes', precisely because we have this horrid per-CPU
> > > > allocation which serves as a bounce buffer. And this is not specific
> > > > to acomp, the old comp algorithms get wrapped in scomps which receive
> > > > the same treatment.
> > >
> > > Ah, in the sense that "in place" is actually happening in the per-cpu
> > > allocation, and only if it succeeds does the input buffer get
> > > overwritten?
> >
> > Something like that IIRC.
> >
> > > > So at that point, I wondered what the point is of all this complexity.
> > > > Do we really need 6 different algorithms to compress a couple of K of
> > > > ASCII text on a code path that is ice cold by definition? Wouldn't it
> > > > be better to drop the crypto API altogether here, and just use GZIP
> > > > via the library interface?
> > >
> > > Well, my goal was to make the algo "pstore doesn't care". If someone
> > > picks deflate, do they still get all the per-cpu allocations?
> > >
> >
> > Not if you use the library interface directly.
> >
> > The issue with the percpu buffers is that they are only kept if any
> > scomp TFMs are active, but this is always the case for pstore, as you
> > don't want to allocate it on the panic path.
>
> Okay, so strictly speaking, eliminating the per-CPU allocation is an
> improvement. Keeping scomp and doing in-place compression will let
> pstore use "any" compressions method.
>

I'm not following the point you are making here.

> Is there a crypto API that does _not_ preallocate the per-CPU stuff?
> Because, as you say, it's a huge amount of memory on the bigger
> systems...
>

The library interface for each of the respective algorithms.
