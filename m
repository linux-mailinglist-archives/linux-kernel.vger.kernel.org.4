Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163076A7598
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCAUs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCAUsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:48:54 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272433D099
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:48:50 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536be69eadfso388765237b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677703729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJ2NmEPepPcvJe3Ak3yvSzcJWQBbkK4dHDuYNukFsA4=;
        b=ZxKqVSfGUt6z5p9e4Sh1vteLyfGnKL+sAJJBJkTnttLJNPVFFrb6Q8lkW4nTVy/X2l
         N5/JO3+zD3LYuIc2tT3uQ9kIHFoLQRkCFwDLNeck6pX6qG69jf8xc79xIfmdgBxeS2ae
         gPO0iZxFqzN5e0MFXgXFukI6ZT1Qrza33kJHQMolayOC/Za+3ACrukE+LUqaukvDjFBr
         OCIs7/uvb4O8rRAJLPZcEaseFUhGWxhoiyvpdWyK/dTN0FhnoLz0yXoGm3A/ONfizmTE
         f5SPURgiWH8B09lMfmeWhs9AhcPquBUDJmmxlJq+e+o8001eO34zMlf4yk7u8TJKsluk
         F2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677703729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJ2NmEPepPcvJe3Ak3yvSzcJWQBbkK4dHDuYNukFsA4=;
        b=RFSbTFAbK2SE/LudVKzu+CXh2cAsXWbcUJckiOg0SzCB0lRGA0qoSAp6d4r/zcx7MT
         l5lsVKDmxHo+MZaRJwzR5Q77+G19JtMKnVDqGgtqMLE44seayPVPdM/wQiwK6PSBAP/z
         JSe/VSI+iavJ9FJZ4P+/alVBx3FgMfN0WUNnjuDJNRJqgGnyfW3oJyIFrLS8kD2vUTOi
         wPb4BM31DP705j0K1cU0UTOxhBgDfkttkToN2u4RNvBQ02+6pocttTbPV5K+1K1eFD6f
         0ASlz3rot6+LguwQjUHIqybNMS263Uw6II3T1/Jh4GtpigRPuMU33Ag/hg8B7uja+S+5
         OjMw==
X-Gm-Message-State: AO0yUKW+ztxd8qTqVQyW7rVhJAxx0d+qGhnyThXiF/wivIjdzD5YbavZ
        MnCWA6L5fi5npY0NWt54+y9JOtLtoLst4fWf3p60Aw==
X-Google-Smtp-Source: AK7set8e8aN8lhe1v2IkmF76VC5t9F6FyKK9q3rCkR0EKsJvTiU9L2roDVQILALGedIxz/crcfjfzcHKNZduJg/PH8w=
X-Received: by 2002:a81:ad03:0:b0:530:bbd3:798b with SMTP id
 l3-20020a81ad03000000b00530bbd3798bmr4793692ywh.0.1677703729203; Wed, 01 Mar
 2023 12:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20230301193403.1507484-1-surenb@google.com> <Y/+wlg5L8A1iebya@cmpxchg.org>
In-Reply-To: <Y/+wlg5L8A1iebya@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Mar 2023 12:48:38 -0800
Message-ID: <CAJuCfpHhA4XpoE96u5CPktDcSChUkQG_Ax58NzJOiOoF2K+3qQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: remove 500ms min window size limitation for triggers
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, peterz@infradead.org,
        johunt@akamai.com, mhocko@suse.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 12:07=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Mar 01, 2023 at 11:34:03AM -0800, Suren Baghdasaryan wrote:
> > Current 500ms min window size for psi triggers limits polling interval
> > to 50ms to prevent polling threads from using too much cpu bandwidth by
> > polling too frequently. However the number of cgroups with triggers is
> > unlimited, so this protection can be defeated by creating multiple
> > cgroups with psi triggers (triggers in each cgroup are served by a sing=
le
> > "psimon" kernel thread).
> > Instead of limiting min polling period, which also limits the latency o=
f
> > psi events, it's better to limit psi trigger creation to authorized use=
rs
> > only, like we do for system-wide psi triggers (/proc/pressure/* files c=
an
> > be written only by processes with CAP_SYS_RESOURCE capability). This al=
so
> > makes access rules for cgroup psi files consistent with system-wide one=
s.
> > Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
> > remove the psi window min size limitation.
> >
> > Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@qu=
icinc.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  kernel/cgroup/cgroup.c | 10 ++++++++++
> >  kernel/sched/psi.c     |  4 +---
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 935e8121b21e..b600a6baaeca 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -3867,6 +3867,12 @@ static __poll_t cgroup_pressure_poll(struct kern=
fs_open_file *of,
> >       return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
> >  }
> >
> > +static int cgroup_pressure_open(struct kernfs_open_file *of)
> > +{
> > +     return (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOUR=
CE)) ?
> > +             -EPERM : 0;
> > +}
>
> I agree with the change, but it's a bit unfortunate that this check is
> duplicated between system and cgroup.
>
> What do you think about psi_trigger_create() taking the file and
> checking FMODE_WRITE and CAP_SYS_RESOURCE against file->f_cred?

That's definitely doable and we don't even need to pass file to
psi_trigger_create() since it's called only when we write to the file.
However by moving the capability check into psi_trigger_create() we
also postpone the check until write() instead of failing early in
open(). I always assumed failing early is preferable but if
consolidating the code here makes more sense then I can make the
switch. Please let me know if you still prefer to move the check.
