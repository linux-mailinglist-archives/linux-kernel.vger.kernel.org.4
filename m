Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495106E6FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDRW6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDRW6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:58:40 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692F72B4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:58:38 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id o11so11591141ybk.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681858718; x=1684450718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvYEot/5uPo2yTiZUwgFRQERBlrKMXbkA+R9nVGIhZs=;
        b=ypRebcfY7uVsRRBGCbwjczNtpsGKEYG/LJYUgFn5aRrgwHezDeSgDNDtB1vIJVSL9k
         whA28RwOITWSFhUQi3/xRtw0wiTblGhbFqok0pv9LyNqlwkIoT+TTKuy5dJin1KnH9HS
         itySWSaGVjuMod6EWJCLoQRULeKOQREAeCf4a4/JT6iyTSC74XSc0Rbp/RYXQPuE0VHi
         ODmp65ImNG5zt3jdMvR/vz1LjAtFkzO0bKt2HeMsIG3Hq+FPRcWgMHV07uGFqj4UXlow
         ZIFSItxszVyEfdAn5IiA4hdehPJuS6o+JOtAvJJKoNVvY4ozZFAV1ArsSlxioKNW+xLZ
         B8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858718; x=1684450718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvYEot/5uPo2yTiZUwgFRQERBlrKMXbkA+R9nVGIhZs=;
        b=RfRsi9c2miWleSyZvgZpc92fKw5EzZ/JB8XfHGCxtxsMbCpeT2qIZtCHI129oarXel
         5mwu/GHT9KLA3ovrxWouaIep+shyA2TuXKx/VDm4kCjvg98AXIQbrauEQECRllz86NnO
         3Qjxb3s3nVC9LwYE+4f5CXGeFXiy2POOZS5sp0r2N0l4jR4GkAj+fXqxQfTqG3mDvTbg
         MpnpPFT7y8amQrYo0vqGbDIkGIz0EYb93OzMGM1fBebTCjUzd6zkkbDfK1DNCioGYsDS
         RbDPiCxvbiMRk5NbEQcye11mREFJYFb/jWjivWaWYtPYu0MICywZ/1yEYbJ5DtbFqHVN
         YThQ==
X-Gm-Message-State: AAQBX9e+KNCNmnoaiW2g8aDwKU7AvUjF0O9135cf2E14p//kkdIJdvAQ
        CmDRTLSCb7tg2I2cooq60bTEot5HPkB3+lRabbGI3g==
X-Google-Smtp-Source: AKy350Ydxh/rfN3DOvIJciBOMR/gM/ter7C1iQatB8w0ubPTTGvXRRGsqJwj5QM5lpxB4b2fb6n1juma6aZLrz2vPmg=
X-Received: by 2002:a25:bc5:0:b0:b67:54e8:417d with SMTP id
 188-20020a250bc5000000b00b6754e8417dmr602902ybl.0.1681858717526; Tue, 18 Apr
 2023 15:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230415000818.1955007-1-surenb@google.com> <ZD2gsbN2K66oXT69@x1n>
 <ZD3Nk0u+nxOT4snZ@casper.infradead.org> <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
 <ZD6oVgIi/yY1+t1L@casper.infradead.org> <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
 <ZD6yirD6Ob+1xG32@casper.infradead.org> <ZD6/805XpvfZde0Y@x1n>
 <CAJuCfpGZAALQbPFGymJOgkMp2knKoos697L8jd1v2jDyBSbdYA@mail.gmail.com>
 <CAJuCfpFFsKkdnHLSojSo0pP-=nQFiY408tpVDHVy6TpGSv1B9g@mail.gmail.com> <ZD8dj3Tk2b1TWVK5@x1n>
In-Reply-To: <ZD8dj3Tk2b1TWVK5@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 Apr 2023 15:58:26 -0700
Message-ID: <CAJuCfpFyetOXEMB2+b3LRO9-ESdDTdEyOyfUGsr0FbsWJi1-kA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Tue, Apr 18, 2023 at 3:45=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 18, 2023 at 02:48:58PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Apr 18, 2023 at 10:17=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > >
> > > On Tue, Apr 18, 2023 at 9:06=E2=80=AFAM Peter Xu <peterx@redhat.com> =
wrote:
> > > >
> > > > On Tue, Apr 18, 2023 at 04:08:58PM +0100, Matthew Wilcox wrote:
> > > > > On Tue, Apr 18, 2023 at 07:54:01AM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > On Tue, Apr 18, 2023 at 7:25=E2=80=AFAM Matthew Wilcox <willy@i=
nfradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 17, 2023 at 04:17:45PM -0700, Suren Baghdasaryan =
wrote:
> > > > > > > > On Mon, Apr 17, 2023 at 3:52=E2=80=AFPM Matthew Wilcox <wil=
ly@infradead.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 17, 2023 at 03:40:33PM -0400, Peter Xu wrote:
> > > > > > > > > > >     /*
> > > > > > > > > > > -    * We don't do accounting for some specific fault=
s:
> > > > > > > > > > > -    *
> > > > > > > > > > > -    * - Unsuccessful faults (e.g. when the address w=
asn't valid).  That
> > > > > > > > > > > -    *   includes arch_vma_access_permitted() failing=
 before reaching here.
> > > > > > > > > > > -    *   So this is not a "this many hardware page fa=
ults" counter.  We
> > > > > > > > > > > -    *   should use the hw profiling for that.
> > > > > > > > > > > -    *
> > > > > > > > > > > -    * - Incomplete faults (VM_FAULT_RETRY).  They wi=
ll only be counted
> > > > > > > > > > > -    *   once they're completed.
> > > > > > > > > > > +    * Do not account for incomplete faults (VM_FAULT=
_RETRY). They will be
> > > > > > > > > > > +    * counted upon completion.
> > > > > > > > > > >      */
> > > > > > > > > > > -   if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > > > > > > > > > +   if (ret & VM_FAULT_RETRY)
> > > > > > > > > > > +           return;
> > > > > > > > > > > +
> > > > > > > > > > > +   /* Register both successful and failed faults in =
PGFAULT counters. */
> > > > > > > > > > > +   count_vm_event(PGFAULT);
> > > > > > > > > > > +   count_memcg_event_mm(mm, PGFAULT);
> > > > > > > > > >
> > > > > > > > > > Is there reason on why vm events accountings need to be=
 explicitly
> > > > > > > > > > different from perf events right below on handling ERRO=
R?
> > > > > > > > >
> > > > > > > > > I think so.  ERROR is quite different from RETRY.  If we =
are, for
> > > > > > > > > example, handling a SIGSEGV (perhaps a GC language?) that=
 should be
> > > > > > > > > accounted.  If we can't handle a page fault right now, an=
d need to
> > > > > > > > > retry within the kernel, that should not be accounted.
> > > > > > > >
> > > > > > > > IIUC, the question was about the differences in vm vs perf =
accounting
> > > > > > > > for errors, not the difference between ERROR and RETRY case=
s. Matthew,
> > > > > > > > are you answering the right question or did I misunderstand=
 your
> > > > > > > > answer?
> > > > > > >
> > > > > > > Maybe I'm misunderstanding what you're proposing.  I thought =
the
> > > > > > > proposal was to make neither ERROR nor RETRY increment the co=
unters,
> > > > > > > but if the proposal is to make ERROR increment the perf count=
ers
> > > > > > > instead, then that's cool with me.
> > > > > >
> > > > > > Oh, I think now I understand your answer. You were not highligh=
ting
> > > > > > the difference between the who but objecting to the proposal of=
 not
> > > > > > counting both ERROR and RETRY. Am I on the same page now?
> > > > >
> > > > > I think so.  Let's see your patch and then we can be sure we're t=
alking
> > > > > about the same thing ;-)
> > > >
> > > > IMHO if there's no explicit reason to differenciate the events, we =
should
> > > > always account them the same way for vm,perf,... either with ERROR
> > > > accounted or not.
> > > >
> > > > I am not sure whether accounting ERROR faults would matter for a mp=
rotect()
> > > > use case, because they shouldn't rely on the counter to work but th=
e SIGBUS
> > > > itself to be generated on page accesses with the sighandler doing w=
ork.
> > >
> > > For that example with GC, these are valid page faults IIUC and curren=
t
> > > PGFAULT counters do register them. Do we want to change that and
> > > potentially break assumptions about these counters?
> > >
> > > >
> > > > One trivial benefit of keep accounting ERROR is we only need to mod=
ify vm
> > > > account ABI so both RETRY & ERROR will be adjusted to match perf,ta=
sk
> > > > counters.  OTOH we can also change all to take ERROR into account, =
but then
> > > > we're modifying ABI for all counters.
> > >
> > > So, not accounting them in both vm and perf would be problematic for
> > > that GC example and similar cases.
> > > Are we left with only two viable options?:
> > > 1. skip RETRY for vm and skip ERROR for both vm and perf (this patch)
> > > 2. skip RETRY for both vm and perf, account ERROR for both
> > >
> > > #2 would go against the comment in mm_account_fault() saying that we
> > > don't account for unsuccessful faults. I guess there must have been
> > > some reason we were not accounting for them (such as access to a
> > > faulty address is neither major nor minor fault)?
> >
> > I did some digging in the history and looks like the check for ERROR
> > was added after this discussion:
> > https://lore.kernel.org/all/20200624203412.GB64004@xz-x1/ and IIUC the
> > reason was that previous code also skipped VM_FAULT_ERROR. Peter, is
> > that correct?
>
> I think so.
>
> It's a few years ago, what I remember is that we did change some of the
> counters at least on some archs, and I don't remember anything is broken
> for real after that.
>
> >
> > It seems this discussion is becoming longer than it should be. How
> > about we keep the behavior of all counters as they are to avoid
> > breaking any possible usecases and just fix the double-counting issue
> > for RETRY cases?
>
> Sure, though again I hope we can add some comment explaining, because the
> outcome of the code can look a bit weird on handling different counters
> differently.
>
> IMHO it can be as simple as "we did accounting differently on different
> types of counters for historical reasons, here just to make them compatib=
le
> with old kernels", maybe it will still help a bit when we read again on
> this chunk of code?

Sure. How about replacing my prior "Register both successful and
failed faults in PGFAULT counters." comment with "To preserve the
behavior of older kernels, PGFAULT counters record both successful and
failed faults, as opposed to perf counters which ignore failed cases"
?

>
> Thanks,
>
> --
> Peter Xu
>
