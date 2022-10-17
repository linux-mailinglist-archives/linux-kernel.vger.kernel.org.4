Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C601660192C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiJQUQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiJQUQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C172D4F193;
        Mon, 17 Oct 2022 13:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24A346125E;
        Mon, 17 Oct 2022 20:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACE8C433D6;
        Mon, 17 Oct 2022 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666037645;
        bh=fv8LcVgLmvJ3fsy6a+z06fkZwSDK7CSRoZb3xPTfeO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F1bwEppZHzPyGGsS2pppvRC09r4ZMo7HWar1tH7wUXaByRZVRhx1ZCs4bEax7Y0pf
         r7N8sNd5VQX5IB8M9rKKjMRS5qo4A8NiEZgzfiqzate+UE0GX3/bjk8tlZNMShdz/S
         MJY6JABMRnP9vV3nRYtHmsLnQlDcVkCEYsfbQ3YKTRyp0Aa7tRXFOiXDKKrxZd6p+/
         o0f+JKwHPDAWbtVKs7G534YaNPQnI8NThVrdljt2VjZGYZ9MrGxlxpQo4tLvwZPgbo
         ZE/N8PMLbFwGw7KWltwgEAgGymp5zp4ykrgUt7LU//Y6dPxpWV0VZYVebjhTRW2GH7
         eBIiCzD+EVGNA==
Received: by mail-lf1-f52.google.com with SMTP id b2so19277515lfp.6;
        Mon, 17 Oct 2022 13:14:05 -0700 (PDT)
X-Gm-Message-State: ACrzQf3qUcqim8dZKh5zxBnwS1F7KldX+RiO3Pa4ItcVGY4YB8SHTT1S
        iWEkDQEYSftIha+gcKLWkbIg7qxObqxxv1ATIyU=
X-Google-Smtp-Source: AMsMyM4fxm/vhiCKENBxbsUccQii5PYdkgAJ9zmEt4HisJJ+xMwA2uDfYLOSDI+xwYyc9izXrZkfd6Zp716BdC0NpU0=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr4790631lfb.637.1666037643562; Mon, 17
 Oct 2022 13:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com> <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook> <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
 <202210171237.DF5D4A3FD7@keescook> <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
 <202210171307.32A5D9C07@keescook>
In-Reply-To: <202210171307.32A5D9C07@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Oct 2022 22:13:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHced1khwsrHqMUmECh_7irYOckFd+Sx3z9KSmsL7tPxw@mail.gmail.com>
Message-ID: <CAMj1kXHced1khwsrHqMUmECh_7irYOckFd+Sx3z9KSmsL7tPxw@mail.gmail.com>
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

On Mon, 17 Oct 2022 at 22:11, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 17, 2022 at 09:45:08PM +0200, Ard Biesheuvel wrote:
> > On Mon, 17 Oct 2022 at 21:40, Kees Cook <keescook@chromium.org> wrote:
> > > Okay, so strictly speaking, eliminating the per-CPU allocation is an
> > > improvement. Keeping scomp and doing in-place compression will let
> > > pstore use "any" compressions method.
> >
> > I'm not following the point you are making here.
>
> Sorry, I mean to say that if I leave scomp in pstore, nothing is "worse"
> (i.e. the per-cpu allocation is present in both scomp and acomp). i.e.
> no regression either way, but if we switch to a distinct library call,
> it's an improvement on the memory utilization front.
>
> > > Is there a crypto API that does _not_ preallocate the per-CPU stuff?
> > > Because, as you say, it's a huge amount of memory on the bigger
> > > systems...
> >
> > The library interface for each of the respective algorithms.
>
> Where is the crypto API for just using the library interfaces, so I
> don't have to be tied to a specific algo?
>

That doesn't exist, that is the point.

But how does the algo matter when you are dealing with mere kilobytes
of ASCII text?
