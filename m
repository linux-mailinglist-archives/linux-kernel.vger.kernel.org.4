Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65570F58A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjEXLpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjEXLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:45:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B19718D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:45:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2af2f4e719eso11212011fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1684928705; x=1687520705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxFXcwp2KnfN6WfggDOxiqogMxrc5sx45bjEc2jiNEc=;
        b=idOOCGtl8Gvzq3fTgMOsAHaVhlMChHZ87Xxxtp2/cNpUdINRjTLanOO2xrS2Iq5xUQ
         scPCBhTWJnLaV4qE5V6/pzIlkEvmjIq9neZbwm8ATSEmZfBOLefJOywd/bTuMe/7vqNS
         ovOPX+q3Cu+sCI4xwxf/MiPef4QpT1pppPSAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684928705; x=1687520705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxFXcwp2KnfN6WfggDOxiqogMxrc5sx45bjEc2jiNEc=;
        b=c2IFGFDKPXzfv6X/BWUXs0YoWyoKC+ptV1GKMqEdhVnV43q12MfNJT32B8/IaK0kJt
         pT72lDfM5G8BCXB867YaX/i3AspzuafsMpbga3l646khNF4NlNmy+a21o1WpU6JFL5K8
         deiDKKahBdj+UDsRfdESIWRG565cO89sLAdANrG5VloiaaVAVxBRK2y1A5ixE68Z2lNd
         e4qDTqaL1lkC2kPxFFXMyGv3SxYTXWI9SrFKW9WeTpjhKaSLlqARlWwIQkjyZPMP7P8b
         XNxHYzdKMhaRy64J0+j5okAdZFJ34qx0LFvs1KTzLlLazHibH46O/jVDFCvBu6MinRYL
         wClw==
X-Gm-Message-State: AC+VfDwlusWYCIhoLoay/Jap2AVEzA7PbkVPRfBzEDWlGQG79nsbFxEN
        f39QKBAYSm0uC9Q8fKJoyD+t8TfcNxPpWlDG54V33g==
X-Google-Smtp-Source: ACHHUZ7OlS/25SA5JwHoCR32eh6C+S2Gz6zZTBrh0jBQ9fTAYpYXGFV5S93n+cC3qQh1+WgZuTZKig==
X-Received: by 2002:a2e:9cce:0:b0:2a8:e642:8cdb with SMTP id g14-20020a2e9cce000000b002a8e6428cdbmr5822406ljj.49.1684928705242;
        Wed, 24 May 2023 04:45:05 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q4-20020a2e8744000000b002adb98fdf81sm2057499ljj.7.2023.05.24.04.45.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 04:45:02 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f3a873476bso768086e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:45:02 -0700 (PDT)
X-Received: by 2002:ac2:46ef:0:b0:4f3:a556:61b6 with SMTP id
 q15-20020ac246ef000000b004f3a55661b6mr5236948lfo.3.1684928701827; Wed, 24 May
 2023 04:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com>
 <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com> <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com>
 <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com>
 <b2bf7ae9-983d-6c20-0781-7f37a4454bfd@google.com> <CAHk-=wi6L6yZnGCYVEmLgQY+KEHNsAW2V69mfdUCMk4qS=GnKA@mail.gmail.com>
 <a74dc41a-d00f-e207-000f-90efa8ee82c9@redhat.com>
In-Reply-To: <a74dc41a-d00f-e207-000f-90efa8ee82c9@redhat.com>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Wed, 24 May 2023 06:44:50 -0500
X-Gmail-Original-Message-ID: <CAFbkSA3+GMkPzptM1=iYATSRrjWKwF0cXqsgO76pUpT5dDq_Og@mail.gmail.com>
Message-ID: <CAFbkSA3+GMkPzptM1=iYATSRrjWKwF0cXqsgO76pUpT5dDq_Og@mail.gmail.com>
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM checks
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 3:42=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.05.23 03:47, Linus Torvalds wrote:
> > On Mon, May 22, 2023 at 5:52=E2=80=AFPM David Rientjes <rientjes@google=
.com> wrote:
> >>
> >> Right now kernel.panic_on_warn can either be 0 or 1.  We can keep the
> >> lowest bit to be "panic on all warnings" and then bit-1 as "panic on d=
ebug
> >> VM warnings."  When CONFIG_DEBUG_VM is enabled, set the new bit by
> >> default so there's no behavior change.
> >
> > So right now CONFIG_DEBUG_VM being off means that there's nothing at
> > all - not just no output, but also no code generation.
> >
> > I don't think CONFIG_DEBUG_VM in itself should enable that bit-1 behavi=
or.
> >
> > That may be what *you* as a VM person wants, but VM people are not
> > exactly the common case.
> >
> > So I think we've got several cases:
> >
> >   (a) the "don't even build it" case (CONFIG_DEBUG_VM being off)
> >
> >   (b) the "build it, and it is a WARN_ON_ONCE()" case
> >
> >   (c) the *normal* "panic_on_warn=3D1" case, which by default would pan=
ic
> > on all warnings, including any warnings from CONFIG_DEBUG_VM
> >
> >   (d) the "VM person" case, which might not panic on normal warnings,
> > but would panic on the VM warnings.
> >
> > and I think the use-cases are for different classes of kernel use:
> >
> >   (a) is for people who disable debugging code until they feel it is
> > needed (which I think covers a lot of kernel developers - I certainly
> > personally tend to not build with debug support unless I'm chasing
> > some issue down)
> >
> >   (b) would probably be most distros - enable the warning so that the
> > distro can report it, but try not to kill the machine of random people
> >
> >   (c) would be most cloud use cases, presumably together with reboot-on=
-panic
> >
> >   (d) would be people who are actual VM developers, and basically want
> > the *current* behavior of VM_BUG_ON() with a machine that stops
> >
> > and I think (d) is the smallest set of cases of all, but is the one
> > you're personally interested in.
>
> Just as a side note, I stumbled yesterday over [1], which apparently
> disables CONFIG_DEBUG_VM on !debug Fedora builds.
>
> The commit description does not contain a rational ( it's empty :) ),
> and I don't know if this is just a temporary change.
>
> I'll CC Justin, maybe Fedora also would like to keep building with
> CONFIG_DEBUG_VM, but default to WARN_ON_ONCE() instead.
>
>
> [1]
> https://gitlab.com/cki-project/kernel-ark/-/commit/ade780e10ae1fdcb575ab1=
00bf02d61eb12dd406

Do not read too much into this right now.  The RHEL performance folks
did a comparison of the RHEL config vs the Fedora config for 6.3 and
found Fedora was considerably slower in a couple of tests. We are
re-running those tests with some DEBUG configs turned off to see which
is the culprit. FWIW, CONFIG_DEBUG_VM made very little difference. As
we have not found the specific cause yet though, final configs have
not been restored.
As for my prefeernce, WARN_ON_ONCE() behavior would be much preferred.

Justin

> --
> Thanks,
>
> David / dhildenb
>
