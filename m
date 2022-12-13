Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045CB64C039
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiLMXGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiLMXGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:06:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511433889
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:06:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so5151262pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gfY9SoTee3EZfG+2GksijgMhXy5soJud6c/PL62EovE=;
        b=q+jiqGbU2B/BB8WwCZG+WNfd8+StTAJUM8yeY8lrPAZVnU3+xBG9L/NwIHYotkdVlU
         iLyF378FtFxO5qF9FFS3lSZfo8YcOUUDL06uGMXgxT/NaFR3VdPLbjz8dkk4mWi8oRXO
         CS8+/KiW16y1XpaAlHTMPzpNGX21XTyui5wLf30t12VJHlJGZj7vZ+I+VdkuIJPhBJ+c
         O8DbRyOT2QTULNTMtD3La1yLMM/uq0pKFsQB4AloZQ8RPN8jiYiII/0UW34/CtHb/1HL
         PdKs7N/sVcr+hChQIGzVQ1hdkiUBVAnUdrrGlSukBnjg1vdVnANPtzIWnnbgMqyJ9Xbm
         4N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfY9SoTee3EZfG+2GksijgMhXy5soJud6c/PL62EovE=;
        b=2K/QVZV+6E6O4ZTzFfnPoaOFuliVPSwLDw/qb+LKrrjRKmr0sghyvXF6VwwJhEUhTw
         i/rph2VHYIS2KiyKN7GKgM5IOwTUzpdBmdZAYeOq0OxcEtJLUUDw8GMq2uaKoMdsBB5K
         kG6Zz90urRG9ORIT0P3JnDj8yDcW0QefAIgt52OeOgze1g+tVbEvi5E9RA9XzWTZa8Az
         c3Gyb+8xmBrS1fg7p5pxvCXGtvoxZ25eFEmjEZaaekHpZFs36dUNLCxElEwIdcJYKk/m
         PxIc3Mh6FUb/eyifDjpMyBBJXVg/QDL0uai2L5OQuPcDVmIw8YcElqsyVSfis5rLC2JQ
         h2gA==
X-Gm-Message-State: ANoB5pkRXmhT0LjbGCKtTrdB9n0vHJ7atEs3Z4+noQHjjmoRaI9VNjlg
        iDhPWd9sWLoWV+pVBvDvv6D9SmhOA74hVHua+uiUhA==
X-Google-Smtp-Source: AA0mqf4fP2Z14LlLZRDbviMdNfqOrCLOgYzTISeAkWFLEBVOZgWI6FEWIPQvWDoJWGDdm493oPcC2PPuU1Ufcjxa8xE=
X-Received: by 2002:a17:902:ec04:b0:189:894c:6b58 with SMTP id
 l4-20020a170902ec0400b00189894c6b58mr54167047pld.172.1670972764571; Tue, 13
 Dec 2022 15:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <20221209160453.3246150-7-jeffxu@google.com>
 <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
 <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com> <CAHC9VhQKsjiGv3Af0iqg_TLNzCvdTaLnhw+BRTF9OEtJg1hX7g@mail.gmail.com>
In-Reply-To: <CAHC9VhQKsjiGv3Af0iqg_TLNzCvdTaLnhw+BRTF9OEtJg1hX7g@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 13 Dec 2022 15:05:28 -0800
Message-ID: <CALmYWFvU7-+oUEhfvbpQLrYV90iNfWUiF5bsEs_YM4QbZn8kcQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
To:     Paul Moore <paul@paul-moore.com>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:22 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Dec 13, 2022 at 10:00 AM Jeff Xu <jeffxu@google.com> wrote:
> > On Fri, Dec 9, 2022 at 10:29 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
> > > >
> > > > From: Jeff Xu <jeffxu@google.com>
> > > >
> > > > The new security_memfd_create allows lsm to check flags of
> > > > memfd_create.
> > > >
> > > > The security by default system (such as chromeos) can use this
> > > > to implement system wide lsm to allow only non-executable memfd
> > > > being created.
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h | 1 +
> > > >  include/linux/lsm_hooks.h     | 4 ++++
> > > >  include/linux/security.h      | 6 ++++++
> > > >  mm/memfd.c                    | 5 +++++
> > > >  security/security.c           | 5 +++++
> > > >  5 files changed, 21 insertions(+)
> > >
> > > We typically require at least one in-tree LSM implementation to
> > > accompany a new LSM hook.  Beyond simply providing proof that the hook
> > > has value, it helps provide a functional example both for reviewers as
> > > well as future LSM implementations.  Also, while the BPF LSM is
> > > definitely "in-tree", its nature is such that the actual
> > > implementation lives out-of-tree; something like SELinux, AppArmor,
> > > Smack, etc. are much more desirable from an in-tree example
> > > perspective.
> >
> > Thanks for the comments.
> > Would that be OK if I add a new LSM in the kernel  to block executable
> > memfd creation ?
>
> If you would be proposing the LSM only to meet the requirement of
> providing an in-tree LSM example, no that would definitely *not* be
> okay.
>
> Proposing a new LSM involves documenting a meaningful security model,
> implementing it, developing tests, going through a (likely multi-step)
> review process, and finally accepting the long term maintenance
> responsibilities of this new LSM.  If you are proposing a new LSM
> because you feel the current LSMs do not provide a security model
> which meets your needs, then yes, proposing a new LSM might be a good
> idea.  However, if you are proposing a new LSM because you don't want
> to learn how to add a new hook to an existing LSM, then I suspect you
> are misguided/misinformed with the amount of work involved in
> submitting a new LSM.
>
> > Alternatively,  it might be possible to add this into SELinux or
> > landlock, it will be a larger change.
>
> It will be a much smaller change than submitting a new LSM, and it
> would have infinitely more value to the community than a throw-away
> LSM where the only use-case is getting your code merged upstream.
>
Thanks, my original thought is this LSM will be used by ChromeOS,
since all of its memfd shall be non-executable. That said, I see the community
will benefit more with this in SELinux.

I will work to add this in SELinux, appreciate help while I'm learning
to add this.

Jeff

> --
> paul-moore.com
