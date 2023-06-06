Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC1B724D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbjFFTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbjFFTsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:48:51 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498D311B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:48:50 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-568f9caff33so64639857b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686080929; x=1688672929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYYAA3RhtrdXesbSXVAKg9SAMg9cz+VHDutK0lbbEnQ=;
        b=eJ71o31oQjhPioKEp+k0fZ2Rkf/rhy8zXW/KjoNUcr7x7pCammCChXximi+wbiEOze
         RVlUbcqJULNTcwArntaaduxtmT8bBm/RxMcnUbZH2LShvZRl97RzvKKTFYY8oYHiD3pF
         Mu6F+/C5OYXZLkujh60sbF47kjFi7HXdKGPj3Ctr5HnpcbdxkXxoKxXPc9yuTcmjzbXe
         2EUpdOm3YfZizDLAGzF3vqquCj+/Xt9zGOntJMslih9Qmcy89Hf6FWMsFpFezmFLNA29
         f3VUumJ5Aa+kZ1JyeXCnc51EffdVqf3LclB+wxBEhpv8dMRbAxsrcoSDF49dwfNxFOqJ
         X47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080929; x=1688672929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYYAA3RhtrdXesbSXVAKg9SAMg9cz+VHDutK0lbbEnQ=;
        b=MBZWQYSdlsyI3imcS+gpVx489hoPP+v6EXZ2QchPqBtl50q83bdtheRj+zS5RXz5sK
         GXD3T7ccswqtKGTIz4qcCKxTPFtC2roDb20/PT3AVPnjR/f4n+cSFr5MimJbXp6OXfBD
         aOx5QLsEyU4Rg9OqCsacJ7v7rL6EGTfWLzpdNUbfBb8Z5ggupD5GuIxFXA4SQ7eZAOlZ
         07Jj8RF3uDPOjTU1hsImU2EG03wlY/hFJvyj6hBEq+jWz406ARkWI6n7o+S7fBPe8pze
         IVNsvgYgM4zG1GP3OaMD1JwcAOOqa2b0tnTdkqUcDHMRH1MdmkRdYpa1l3HCDbd9olaf
         GalQ==
X-Gm-Message-State: AC+VfDzdKfsH1gEFoJphEyvULZmvxbSApUn05DceskV8XrecGrtCZQk0
        CqoANz+7KXQDJaDZnoIt3dfUVXdi6SJTxT0APP1kBUTwYEPo0VRm//bnUg==
X-Google-Smtp-Source: ACHHUZ6bImh0yLK+J9ye97KdoSZSC2EQZoOrFipbdJDnmp7fpHgg+mU8SsYLzmDlhX3HHgDG3xc2M6y93+Nga6FlFmc=
X-Received: by 2002:a81:5212:0:b0:565:bd70:69e3 with SMTP id
 g18-20020a815212000000b00565bd7069e3mr3534041ywb.10.1686080929287; Tue, 06
 Jun 2023 12:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531221955.GD102494@cmpxchg.org> <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
 <20230605180013.GD221380@cmpxchg.org> <f3f15b6a-8618-f755-f21c-4193c502e65c@quicinc.com>
In-Reply-To: <f3f15b6a-8618-f755-f21c-4193c502e65c@quicinc.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 6 Jun 2023 12:48:38 -0700
Message-ID: <CAJuCfpFB33GLbwvYspg966b6AGMopS3ca68hjL94kgpM7et7CQ@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        minchan@kernel.org, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

Hi Charan,

On Tue, Jun 6, 2023 at 7:54=E2=80=AFAM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Thanks Johannes for the detailed review comments...
>
> On 6/5/2023 11:30 PM, Johannes Weiner wrote:
> >> Agree that we shouldn't be really silence the thrashing. My point is w=
e
> >> shouldn't be  considering the folios as thrashing If those were gettin=
g
> >> reclaim by the user him self through MADV_PAGEOUT under the assumption
> >> that __user knows they are not real working set__.  Please let me know
> >> if I am not making sense here.
> > I'm not sure I agree with this. I think it misses the point of what
> > the madvise is actually for.
> >
> > The workingset is defined based on access frequency and available
> > memory. Thrashing is defined as having to read pages back shortly
> > after their eviction.
> >
> > MADV_PAGEOUT is for the application to inform the kernel that it's
> > done accessing the pages, so that the kernel can accelerate their
> > eviction over other pages that may still be in use. This is ultimately
> > meant to REDUCE reclaim and paging.
> >
> > However, in this case, the MADVISE_PAGEOUT evicts pages that are
> > reused after and then refault. It INCREASED reclaim and paging.
> >
> I agree here...
> > Surely that's a problem? And the system would have behaved better
> > without the madvise() in the first place?
> >
> Yes, the system behavior could be much better without this PAGEOUT
> operation...
> > In fact, I would argue that the pressure spike is a great signal for
> > detecting overzealous madvising. If you're redefining the workingset
> > from access frequency to "whatever the user is saying", that will take
> > away an important mechanism to detect advise bugs and unnecessary IO.
> currently wanted to do the PAGEOUT operation but what information lacks
> is if I am really operating on the workingset pages. Had the client
> knows that he is operating on the workingset pages, he could have backed
> off from madvising.
>
> I now note that I shouldn't be defining the workingset from "whatever
> user is saying". But then, IMO, there should be a way from the kernel to
> the user that his madvise operation is being performed on the workingset
> pages.
>
> One way the user can do is monitoring the PSI events while PAGEOUT is
> being performed and he may exclude those VMA's from next time.
>
> Alternatively kernel itself can support it may be through like
> MADV_PAGEOUT_INACTIVE which doesn't pageout the Workingset pages.
>
> Please let me know your opinion about this interface.
>
> This has the usecase on android where it just assumes that 2nd
> background app will most likely to be not used in the future thus
> reclaim those app pages. It works well for most of the times but such
> assumption will go wrong with the usecase I had mentioned.

Hi Folks. Sorry for being late to the party.
Yeah, userspace does not have a crystal ball to predict future user
behavior, so there will always be pathological cases when usual
assumptions and resulting madvise() would make things worse.

I think this discussion can be split into several questions/issues:
1. Inconsistency in how madvise(MADV_PAGEOUT) would affect PSI
calculation when the page is refaulted, based on the path it took
before being evicted by madvise(). In your initial description case
(a) is inconsistent with (b) and (c) and it's probably worth fixing.
IMHO (a) should be made consistent with others, not the other way
around. My reasoning is that page was expelled from the active list,
so it was part of the active workingset.

2. Whether refaults caused by incorrect madvise(MADV_PAGEOUT) should
be counted as workingset refault and affect PSI.
This one I think is trickier. IMHO it should be counted as workingset
refault simply because it was refaulted and it was part of the
workingset. Whether it should affect PSI, which is supposed to be an
indicator of "pressure" is, I think, debatable. With madvise() in the
mix, refault might happen without any real memory pressure... So, the
answer is not obvious to me.

3. Should refaults caused by incorrect madvise(MADV_PAGEOUT) be
distinguished from the ones which were evicted by kernel reclaim
mechanisms.
I can see use for that from userspace to detect incorrect madvise()
and adjust its aggressiveness. I think the API might get a bit complex
because of the need to associate refaults with specific madvise()/VMAs
to understand which hint was incorrect and adjust the behavior.

Hope my feedback is useful and if we can improve Android's userspace
behavior, I'm happy to help make that happen.
Thanks,
Suren.

>
> --Thanks.
