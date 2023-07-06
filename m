Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0127492F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjGFBRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGFBRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:17:01 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805C2DA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:17:00 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bacf685150cso109966276.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688606219; x=1691198219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Sb08cFWgrv3wGlfRFRn6zfHbCpEJzACO/MXH/nqfSo=;
        b=uH4U4iCZ5BA9AW1gHcHpSugIZ7KluY0dTkOmcNZqfd06T2Oso+DF601AaV7geuZk1a
         5Wj7ReroDQKjEvQXs42RZ/WoIYfgtS2XflvvoRCcb7tF6EU7/WS9rL/xr+C6jM4F3MxZ
         fl89BHVgVZT1pnNZu/SlzteXyRVu1aqygIYtFXEfDBLAAXSFRKOXwa4AZtd0J/R374hT
         91Q9tfeoX2ISwOl9ZwTU7B+m5SFlaAddVcLdnB9TitQW4IHsqxK1+6t8E7wQ5CfN7rhs
         B0K1TWwjH+YY1C+GC/Jly4rV5HUSHIbziTv5a+zRBzD1BdnirWModMvd5+Lby37MMQce
         gh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688606219; x=1691198219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Sb08cFWgrv3wGlfRFRn6zfHbCpEJzACO/MXH/nqfSo=;
        b=TRdb11FhNns0TK7JyMph6KVt//b3yc0bwleCTl7/EDU7BOA3sT00G5dINOUm6/tcaa
         29++0B/hKH4vCDO5vT0LBUMi46crDkwImN/8q8FDtpCtKNpuSrBhAonki+df8jkNpo6t
         VG+FQ5oZ36BhVs5wGYNpkBpQF8ljAZFbGcu8Nq63PnxgmXsAoYJu3mbebuaImVeZRLzD
         mppcvdXDFrOgWdzOsX9L38ViM+F0J5EejG4LryjGnDagFUwasrNgI7thPaXU1rl1Hz32
         5L/4O3rDr4C44Y+AAIPAHZS/BPpJX/drsJjYE2LaPM6rrgeVV77kff9uR5IgPH5o+icR
         6RSw==
X-Gm-Message-State: ABy/qLbHb6k+9XAP5utD4ns8a7408Hdd9mrTuxBSCcTaYJgvslZSPmRQ
        eev3udJ6DlZURdtcNNMqKb+7uyQk/iJo3rkir7zOVA==
X-Google-Smtp-Source: APBJJlFV9NZNjmlo5zt2nLV7CJf7Oaffqx/acpr3b5jQNuT+4E+yTFrYTvwia1Q3dRHZVJzSNFxi7PrmxXP86KjUHyo=
X-Received: by 2002:a25:98c6:0:b0:c0b:7483:5cdb with SMTP id
 m6-20020a2598c6000000b00c0b74835cdbmr401542ybo.35.1688606219462; Wed, 05 Jul
 2023 18:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n> <CAJuCfpGHRfK1ZC3YmF1caKHiR7hD73goOXLKQubFLuOgzCr0dg@mail.gmail.com>
 <20230705172424.e505f5013bfdf44543d9c6be@linux-foundation.org>
 <CAJuCfpFLRePeOsrSg--5GtWbC1M5y21Sq7gzrs1vVEUE7C+30A@mail.gmail.com>
 <CAJuCfpGWW7wsrtqi4rZUz4vxW-N0CaUEeUqY4e7iX1hzgRsT2g@mail.gmail.com>
 <20230705174440.9adb53f2e362056867135b84@linux-foundation.org> <CAJuCfpEjytSBKN0gn0t7e5bCSmZLXU-86Ko0Kt-rkXD7hZeNNA@mail.gmail.com>
In-Reply-To: <CAJuCfpEjytSBKN0gn0t7e5bCSmZLXU-86Ko0Kt-rkXD7hZeNNA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 18:16:48 -0700
Message-ID: <CAJuCfpENo+xJOFjy7geYJjH54cT6e9t-Qw18AvcwNrcE2AMicw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 5:49=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Jul 5, 2023 at 5:44=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Wed, 5 Jul 2023 17:32:09 -0700 Suren Baghdasaryan <surenb@google.com=
> wrote:
> >
> > > On Wed, Jul 5, 2023 at 5:30=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > >
> > > > On Wed, Jul 5, 2023 at 5:24=E2=80=AFPM Andrew Morton <akpm@linux-fo=
undation.org> wrote:
> > > > >
> > > > > On Wed, 5 Jul 2023 13:33:26 -0700 Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > > >
> > > > > > I was hoping we could re-enable VMA locks in 6.4 once we get mo=
re
> > > > > > confirmations that the problem is gone. Is that not possible on=
ce the
> > > > > > BROKEN dependency is merged?
> > > > >
> > > > > I think "no".  By doing this we're effectively backporting a mino=
r
> > > > > performance optimization, which isn't a thing we'd normally do.
> > > >
> > > > In that case, maybe for 6.4 we send the fix and only disable it by
> > > > default without marking BROKEN? That way we still have a way to ena=
ble
> > > > it if desired?
> > >
> > > I'm preparing the next version with Liam's corrections. If the above
> > > option I suggested is acceptable I can send a modified second patch
> > > which would not have BROKEN dependency.
> >
> > I think just mark it broken and move on.  At some later time we can
> > consider backporting the fixes into 6.4.x and reenabling, but I don't
> > think it's likely that we'll do this.
>
> Uh, ok. I'll send the next version shortly with the patch fixing the
> issue and another one marking it BROKEN. Hopefully in the next version
> we can roll it our more carefully, removing BROKEN dependency but
> keeping it disabled by default?

v4 is posted at
https://lore.kernel.org/all/20230706011400.2949242-1-surenb@google.com/
Thanks,
Suren.

>
> >
