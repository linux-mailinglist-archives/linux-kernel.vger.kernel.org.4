Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D7B712D09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbjEZTFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbjEZTFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:05:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E51AC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:05:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d30ab1ef2so1027323b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685127911; x=1687719911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnFdA77YJYoNvaGSmM9SYTrfoWB/SryNK9HkuvxiNTM=;
        b=OGBXkjOxdhzsn+GTp4skzKf/9mFAZR9igHQ85VIhE6oGqDNYCJyRhy6+YC1Bk6Vbpx
         Hm2Ia41KfyuFx5YrmJNBSI1FgLDwCbCmGrzmMs2MKFhONCBI6wIOWFUooT+SP80dOwGm
         IBIb/MW4cPCSwJWD81QPfC1dt5E4TYPxUfHRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685127911; x=1687719911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnFdA77YJYoNvaGSmM9SYTrfoWB/SryNK9HkuvxiNTM=;
        b=EAhPEI9eXGEON5B51xDNAhdqMg0RhZ+0UPq5oz+9Jom8rFw0cFySBf9Qhh95pmSvCO
         z27b58MiePjn4OCaE5bbq4EnyTGSQJ1ULVB5GwU9tUPegK/BRsYIgxY6yf9VGyhDDkeY
         ercIwRPrVKgvSELkXg6Kov7c50RDetACXqPypDlzYIfQaL5GUwgb/aPBV2qRQlIOQHlT
         dEEYkeq4TJd8f2xOvLPWwsEReusFPmdsylFCrgLJ+IZ1p69QBUxuRgwYanRsLcYWIwmp
         BX/KJoQiSJqWPRdn8+24Hqxl4Q1Dg6lsHCfcFsn3vSwTazIcZVFoko0TWS5H3oZdLxZT
         eEEA==
X-Gm-Message-State: AC+VfDySPVCljPM3NhKrm56lhmme2dOuD8LFHSMQKw33pQLU3tVTkhOQ
        GR+h3KWMsKsPSiqYA0EDRrcFuql1MoiZUw1abDTlKrq/bfEgJ5F3
X-Google-Smtp-Source: ACHHUZ4zNLZAxXKUdafod0VEFTQ+BADAdOr0aeEaChZydZH5qi1xIaFNWcWdQj7AyMqu7wIUTlqi6bg5OJUxmqAW4Yw=
X-Received: by 2002:a05:6a20:728c:b0:10f:13bb:5d4f with SMTP id
 o12-20020a056a20728c00b0010f13bb5d4fmr508561pzk.2.1685127911498; Fri, 26 May
 2023 12:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230517150321.2890206-1-revest@chromium.org> <20230517150321.2890206-5-revest@chromium.org>
 <ZGzrcOeXc/slVpCY@arm.com>
In-Reply-To: <ZGzrcOeXc/slVpCY@arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 26 May 2023 21:05:00 +0200
Message-ID: <CABRcYmLt2KsCoD8WzyCTxuY=6ppuWEqyLSDRXSsmXSxPLHtEzQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 6:36=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Wed, May 17, 2023 at 05:03:20PM +0200, Florent Revest wrote:
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 339fee3eff6a..320eae3b12ab 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -2368,9 +2368,25 @@ static inline int prctl_set_mdwe(unsigned long b=
its, unsigned long arg3,
> >       if (arg3 || arg4 || arg5)
> >               return -EINVAL;
> >
> > -     if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
> > +     if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
> >               return -EINVAL;
> >
> > +     /* NO_INHERIT only makes sense with REFUSE_EXEC_GAIN */
> > +     if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAI=
N))
> > +             return -EINVAL;
> > +
> > +     /* Can't gain NO_INHERIT from !NO_INHERIT */
> > +     if (bits & PR_MDWE_NO_INHERIT &&
> > +         test_bit(MMF_HAS_MDWE, &current->mm->flags) &&
> > +         !test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
> > +             return -EPERM;
> > +
> > +     if (bits & PR_MDWE_NO_INHERIT)
> > +             set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
> > +     else if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags)
> > +              && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
> > +             return -EPERM; /* Cannot unset the flag */

Ugh, I had to proofread this 3 times to figure out what I was trying
to do, not great. :(

> Is this about not unsetting the MMF_HAS_MDWE bit? We already have a
> check further down that covers this case.

Actually, this was about not being able to unset _both_ NO_INHERIT and
HAS_MDWE (this would gain capabilities)... While still being able to
unset NO_INHERIT only (this reduces capabilities)

> Related to this, do we want to allow unsetting MMF_HAS_MDWE_NO_INHERIT?
> It looks like it can't be unset but no error either.

But - sigh - as you point out, that second part wasn't implemented. It
looks like I intended to add an:

else
  clear_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);

after that block but forgot... The idea was that:
- setting no_inherit is always allowed
- unsetting it is allowed iff we don't also unset REFUSE_EXEC_GAIN

The "consecutive_prctl_flags" selftests in patch 5 were supposed to
make the assumptions here easier to read and verify. This logic was
meant to be covered by  "cant_disable_mdwe_no_inherit" and
"can_lower_privileges" but these tests only check that the "set" prctl
succeeds and not that the end result is the expected one so I missed
this. I'll improve the selftest in the next revision too so we can
catch this more easily next time.

> The above check,
> IIUC, looks more like ensuring we don't clear MMF_HAS_MDWE.

Indeed, without the else, it was useless.

> Maybe we should tighten the logic here a bit and not allow any changes
> after the initial flag setting:
>
> current->mm->flags =3D=3D 0, we allow:
>         bits =3D=3D 0 or
>         bits =3D=3D PR_MDWE_REFUSE_EXEC_GAIN or
>         bits =3D=3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT
>
> current->mm->flags !=3D 0 (some bits were set), we only allow the exactly
> the same bit combination or -EPERM.
>
> So basically build the flags based on the PR_* input bits and compare
> them with current->mm->flags when not 0, return -EPERM if different. I
> think this preserves the ABI as we only have a single bit currently and
> hopefully makes the logic here easier to parse.

On one hand, I thought it would be nice to have the ability to
transition from NO_INHERIT | REFUSE_EXEC_GAIN to REFUSE_EXEC_GAIN
because, conceptually, it seems to me that we shouldn't prevent a
process from dropping further capabilities.

On the other hand, I don't think I have an actual need for that
transition and I agree that if we don't try to handle it, the code
here would become a lot easier to reason about. I'd certainly sleep
better at night with the smaller likelihood of having screwed
something up... :)

Unless someone feels strongly otherwise, I'll do what you suggest in v3

> > @@ -2385,8 +2401,10 @@ static inline int prctl_get_mdwe(unsigned long a=
rg2, unsigned long arg3,
> >       if (arg2 || arg3 || arg4 || arg5)
> >               return -EINVAL;
> >
> > -     return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
> > -             PR_MDWE_REFUSE_EXEC_GAIN : 0;
> > +     return (test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
> > +             PR_MDWE_REFUSE_EXEC_GAIN : 0) |
> > +             (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags) ?
> > +             PR_MDWE_NO_INHERIT : 0);
> >  }
>
> Just personal preference, use explicit 'if' blocks and add bits to a
> local variable variable than multiple ternary operators.

Will do!
