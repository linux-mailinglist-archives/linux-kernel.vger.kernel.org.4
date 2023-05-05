Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCF26F86EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjEEQmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:42:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC81913284
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:42:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaef97652fso13666105ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683304940; x=1685896940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7v06Z2KE6UgDkNy7vxoQMtDkj1FvtkQwtTi1j/U3CnQ=;
        b=C71QWIQ+VPVvQHucoVXDHQr+P8OfEaR5pAyJFWp+VdrT2k8ZNsmsUmprIu97eTCS7S
         T+YpuIApCG05mDXG95KuevANMZcbkicvhJmKzHChh/mSVduaNIabHsaZkv/ZN00g9zRD
         lwI2oa0h4LI4CM5kCUcI5OpcCMiQIMbbcWz+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683304940; x=1685896940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v06Z2KE6UgDkNy7vxoQMtDkj1FvtkQwtTi1j/U3CnQ=;
        b=eFq+R6Ibhim7FEiQ169N8pkfOfvUSEH14t93vRtXHg9BKTdJsgCEq40jV6zUkPMmsz
         uWyjOnI58PSA+CkMXp0Ps5GmG860UPvDDILntvNkQAU8ePi4uNDh5R8fFZYmDVMyKc5j
         FEHvLOesAIQDBIAZip85l8XuigzY5+PJ5I88MbOP2vtoPYsE+oQHgpocpJrInvUxOg8i
         Qt0boXrJ6K0HJVZnvwZ7qqRP5S6dqMSRLz63jIH/zxX6BGoDsribrPmi5pk1jQfpR2cv
         742NjIpNzM+R21wbdpS5S/pMF6ECg7e/T1NYkultui9ha2/7O7ZSSZeoeRrXjLkD8Vlr
         zeIg==
X-Gm-Message-State: AC+VfDxPO91i6pgsSg1EV2wJLOQ58m29tiU+5kaunSyyfnzywtzqPbUF
        zAr83zc4mHOPOblun1ZNuREQheqKbeJ3JyW9Of/OrT10av0s2XyO
X-Google-Smtp-Source: ACHHUZ7Ya6ILoZVkfhEQL2NYyOE12mCFI4hsF3ESUndB7Vg8bDLqakqmdS+2sPJwVQWsyZzlIT8ORPJU3brZ1qahnP0=
X-Received: by 2002:a17:902:e852:b0:1a6:c595:d7c3 with SMTP id
 t18-20020a170902e85200b001a6c595d7c3mr2434089plg.22.1683304940092; Fri, 05
 May 2023 09:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230504170942.822147-1-revest@chromium.org> <ZFQQSKijXQHWlYaI@x1n>
In-Reply-To: <ZFQQSKijXQHWlYaI@x1n>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 5 May 2023 18:42:08 +0200
Message-ID: <CABRcYmJFcUs=3QYXz8iq7qvu2orJ4HL-cHdBKg9o7=Ma=nfPLw@mail.gmail.com>
Subject: Re: [PATCH 0/4] MDWE without inheritance
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, izbyshev@ispras.ru,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 10:06=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, May 04, 2023 at 07:09:38PM +0200, Florent Revest wrote:
> > Joey recently introduced a Memory-Deny-Write-Executable (MDWE) prctl wh=
ich tags
> > current with a flag that prevents pages that were previously not execut=
able from
> > becoming executable.
> > This tag always gets inherited by children tasks. (it's in MMF_INIT_MAS=
K)
> >
> > At Google, we've been using a somewhat similar downstream patch for a f=
ew years
> > now. To make the adoption of this feature easier, we've had it support =
a mode in
> > which the W^X flag does not propagate to children. For example, this is=
 handy if
> > a C process which wants W^X protection suspects it could start children
> > processes that would use a JIT.
> >
> > I'd like to align our features with the upstream prctl. This series pro=
poses a
> > new NO_INHERIT flag to the MDWE prctl to make this kind of adoption eas=
ier. It
> > sets a different flag in current that is not in MMF_INIT_MASK and which=
 does not
> > propagate.
>
> I don't think I have enough context, so sorry if I'm going to ask a naive
> question..

Not at all! :) You're absolutely right, it's important to address these poi=
nts.

> I can understand how current MDWE helps on not allowing any modifi-able
> content from becoming executable.  How could NO_INHERIT help if it won't
> inherit and not in MMF_INIT_MASK?

The way I see it, enabling MDWE is just a small step towards hardening
a binary anyway. It can possibly make exploitation a bit harder in the
case where the attacker has _just_: a write primitive they can use to
write a shellcode somewhere and a primitive to make that page
executable later. It's a fairly narrow protection already and I think
it only really helps as part of a broader "defense in depth" strategy.

> IIUC it means the restriction will only apply to the current process.  Th=
en
> I assume the process can escape from this rule simply by a fork().  If so=
,
> what's the point to protect at all?

If we assume enough control from the attacker, then MDWE is already
useless since it can be bypassed by writing to a file and then
mmapping that file with PROT_EXEC. I think that's a good example of
how "perfect can be the enemy of good" in security hardening. MDWE
isn't a silver-bullet but it's a cheap trick and it makes a small dent
in reducing the attack surface so it seems worth having anyway ?

But indeed, to address your question, if you choose to use this
NO_INHERIT flag: you're no longer protected if the attacker can fork()
as part of their exploitation. I think it's been a useful trade-off
for our internal users since, on the other hand, it also makes
adoption a lot easier: our C++ services developers can trivially opt
into a potpourri of hardening features without having to think too
much about how they work under-the-hood. The default behavior has been
to use a NO_INHERIT strategy so users don't get bad surprises the day
when they try to spawn a JITted subcommand. In the meantime, their C++
service still gets a little bit of extra protection.

> And, what's the difference of this comparing to disabling MDWE after bein=
g
> enabled (which seems to be forbidden for now, but it seems fork() can pla=
y
> a similar role of disabling it)?

That would be functionally somewhat similar, yes. I think it mostly
comes down to ease of adoption. I imagine that users who would opt
into NO_INHERIT are those who are interested in MDWE for the binary
they are writing but aren't 100% confident in what subprocesses they
will run and so they don't have to think about disabling it after
every fork.
