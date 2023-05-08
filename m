Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13286FAFB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjEHMMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjEHMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:12:38 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33176394AB
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:12:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517c01edaaaso2820496a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683547952; x=1686139952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhm2iuMs798BH3BBr1kXDWeqcKP/EaEB0LeOD1fdOvc=;
        b=amudl00aclp5eVgRfCiZdj8vsvdACj4/gj3CnKBYa29Pwuw+SXLwygXXgEgfdw4zMT
         DV0TW4D72p5zOdy0qrYqGlVpE4TfyPtp+eVj7/tmqWlbTV9cW0QB7NA1cfVz62mcDp9q
         RtjgMDkkYyNlF+7SHfPysmV81QqaFcwieNj0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683547952; x=1686139952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhm2iuMs798BH3BBr1kXDWeqcKP/EaEB0LeOD1fdOvc=;
        b=QklqH+WZOaEaKp8laUHfA83oEcoLxYTMHZnAgoizz1YFUigholZaweTBC4r+QMDyn5
         iRUwxEL7BCP4r4T1Po0do8n5cwipMgUUJkhD6Rjt0UcGvgPC1AyL6Hv7oFw9uc5v1Jrd
         fqXsKaFkYGTTiKzo23wR7ZVQ1Bj/DrIi+6Nqy/L4zD0iz33b0SmC5TDlJXwe4P5g0+GD
         dHtmGdsmSreTcdqQmXsKgLStiKP2a0hK6WXhR3crobJurrtZZ4BpfLe42PijI5F6tX9g
         Ok4Z8ASCCdk42JBgJ8UcWaDLbG3vvKP2yoqTk7pD/a/SeO9hEKF4Eo6eA53MUuunV4II
         v6uQ==
X-Gm-Message-State: AC+VfDwevmME3nqvhKPj/4Jzky0t3dUFKJM2P7UU3GnYMDNvZJwHwUmX
        pUfxwIe5uRCuCGVHiFLDl7dGBZmlsMoHB1pE5emaSQ==
X-Google-Smtp-Source: ACHHUZ6sn/H7nwrvtvCQBr4N81UPVX2I/AOYS5pTvgCjVgFzFXf6yiHJvrICK6ftzlpNBCP8c4YsesJplr4re7S9KZ4=
X-Received: by 2002:a05:6a20:6a15:b0:fa:3347:6e1 with SMTP id
 p21-20020a056a206a1500b000fa334706e1mr13169747pzk.51.1683547952595; Mon, 08
 May 2023 05:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230504170942.822147-1-revest@chromium.org> <ZFQQSKijXQHWlYaI@x1n>
 <CABRcYmJFcUs=3QYXz8iq7qvu2orJ4HL-cHdBKg9o7=Ma=nfPLw@mail.gmail.com> <ZFhQcwDBFWcRCC4N@x1n>
In-Reply-To: <ZFhQcwDBFWcRCC4N@x1n>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 8 May 2023 14:12:21 +0200
Message-ID: <CABRcYm+RquNGYUyfCEmLrcaoMSKagzwXgto-24ZCaLAdFUKUjg@mail.gmail.com>
Subject: Re: [PATCH 0/4] MDWE without inheritance
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, izbyshev@ispras.ru,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        toiwoton@gmail.com, lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 3:29=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, May 05, 2023 at 06:42:08PM +0200, Florent Revest wrote:
> > On Thu, May 4, 2023 at 10:06=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > On Thu, May 04, 2023 at 07:09:38PM +0200, Florent Revest wrote:
> > > > Joey recently introduced a Memory-Deny-Write-Executable (MDWE) prct=
l which tags
> > > > current with a flag that prevents pages that were previously not ex=
ecutable from
> > > > becoming executable.
> > > > This tag always gets inherited by children tasks. (it's in MMF_INIT=
_MASK)
> > > >
> > > > At Google, we've been using a somewhat similar downstream patch for=
 a few years
> > > > now. To make the adoption of this feature easier, we've had it supp=
ort a mode in
> > > > which the W^X flag does not propagate to children. For example, thi=
s is handy if
> > > > a C process which wants W^X protection suspects it could start chil=
dren
> > > > processes that would use a JIT.
> > > >
> > > > I'd like to align our features with the upstream prctl. This series=
 proposes a
> > > > new NO_INHERIT flag to the MDWE prctl to make this kind of adoption=
 easier. It
> > > > sets a different flag in current that is not in MMF_INIT_MASK and w=
hich does not
> > > > propagate.
> > >
> > > I don't think I have enough context, so sorry if I'm going to ask a n=
aive
> > > question..
> >
> > Not at all! :) You're absolutely right, it's important to address these=
 points.
> >
> > > I can understand how current MDWE helps on not allowing any modifi-ab=
le
> > > content from becoming executable.  How could NO_INHERIT help if it wo=
n't
> > > inherit and not in MMF_INIT_MASK?
> >
> > The way I see it, enabling MDWE is just a small step towards hardening
> > a binary anyway. It can possibly make exploitation a bit harder in the
> > case where the attacker has _just_: a write primitive they can use to
> > write a shellcode somewhere and a primitive to make that page
> > executable later. It's a fairly narrow protection already and I think
> > it only really helps as part of a broader "defense in depth" strategy.
> >
> > > IIUC it means the restriction will only apply to the current process.=
  Then
> > > I assume the process can escape from this rule simply by a fork().  I=
f so,
> > > what's the point to protect at all?
> >
> > If we assume enough control from the attacker, then MDWE is already
> > useless since it can be bypassed by writing to a file and then
> > mmapping that file with PROT_EXEC. I think that's a good example of
> > how "perfect can be the enemy of good" in security hardening. MDWE
> > isn't a silver-bullet but it's a cheap trick and it makes a small dent
> > in reducing the attack surface so it seems worth having anyway ?
> >
> > But indeed, to address your question, if you choose to use this
> > NO_INHERIT flag: you're no longer protected if the attacker can fork()
> > as part of their exploitation. I think it's been a useful trade-off
> > for our internal users since, on the other hand, it also makes
> > adoption a lot easier: our C++ services developers can trivially opt
> > into a potpourri of hardening features without having to think too
> > much about how they work under-the-hood. The default behavior has been
> > to use a NO_INHERIT strategy so users don't get bad surprises the day
> > when they try to spawn a JITted subcommand. In the meantime, their C++
> > service still gets a little bit of extra protection.
> >
> > > And, what's the difference of this comparing to disabling MDWE after =
being
> > > enabled (which seems to be forbidden for now, but it seems fork() can=
 play
> > > a similar role of disabling it)?
> >
> > That would be functionally somewhat similar, yes. I think it mostly
> > comes down to ease of adoption. I imagine that users who would opt
> > into NO_INHERIT are those who are interested in MDWE for the binary
> > they are writing but aren't 100% confident in what subprocesses they
> > will run and so they don't have to think about disabling it after
> > every fork.
>
> Okay, that makes sense to me.  Thanks.
>
> Since the original MDWE was for systemd, I'm wondering what will happen i=
f
> some program like what you said is invoked by systemd and with MDWE enabl=
ed
> already.

Good question

> Currently in your patch IIUC MDWE_NO_INHERIT will fail directly on MDWE
> enabled process,

Yes, I tried to stay close to the spirit of the existing logic (which
doesn't allow any sort of privilege gains) but this is not
particularly a requirement on our side so I'm quite flexible here.
Maybe Joey has an input here ?

> but then it makes me think whether it makes more sense to
> allow converting MDWE->MDWE_NO_INHERIT in this case.  It seems to provide=
 a
> most broad coverage on system daemons using MDWE starting from systemd
> initial process, meanwhile allows specific daemons to fork into anything
> like a JIT process so it can make itself NO_INHERIT.  Attackers won't
> leverage this because MDWE_NO_INHERIT also means MDWE enabled.

I should have cc-ed systemd folks who could have opinions on this. I
will for v2.

+ cc Topi & Lennart
