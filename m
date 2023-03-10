Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F66B53C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCJWFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjCJWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:04:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626962B9F6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:02:36 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u5so7081780plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678485756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl9+UnJsuGtSL6Htf5pmFF2VpYUF7uQsk//bCajkwMA=;
        b=Fnl0nq/R0PR8v0EG9jkEbvFgb3uDWFfT/Q6iPUq/0uH3Zvv/NvCKB3krHXm9LccxFu
         YyV4m+roG57TGhT0gI35AOJ8cPJ420MqCsRi0iHsJV/fswg9d8O1jOvOMTohjmS+4DYf
         7G6Hrt+FrMhoOBblRkGvxQoHh4DCrR18Eo4MxC5Rxxf1p8BxjTwIL8w00KKJihPjVN5A
         /2NLhT2I2Cr/FlKc2U1zeKg58DoHzy67/cQKPu/CfDIo9u3HQG5gl3P0D1Ke7HBuRPQ9
         w2alaLB8XALXK7wrf+Gq14wqbN79UwYOgJ6bYfywogEqKTSYtKqiLVTDWBJrxdwpaueQ
         wcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678485756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl9+UnJsuGtSL6Htf5pmFF2VpYUF7uQsk//bCajkwMA=;
        b=dD16Ho2r9uNCBQEW7a334FD8NZneEaUQF+xtAv+TxGBo78vvu5usDfmQk902cQwJvV
         7+2wSLIoUSNiA/Yrh8gqQ0QtmAvzdmra2bfQ9w17BSTcP0K7h1a/uJDGbSvpC4Va4ZhF
         PTpXu5OpzfhpIRTA2G/lHG4yIolZr3tE2xwp/jv7SObloWwN1MgOh66TU8E6wVh0J14K
         2OxccwI6drIlkJlQCcjyrHoERwHVDCQxQ6+V4Wky6xhW0rPTXcM01z8o75naw/VVk3Cy
         ZlvU3iYltOvkMwOU46Lp3JxcXjuycmboI7tkI0imcETpe3LYuwPUlJsEI7BzD+m6+E2L
         2/tg==
X-Gm-Message-State: AO0yUKU+gRibXkGqMMaJsn5EdFWv/xdUjOczgCoiRDoO3LUJDWAXIM0V
        689qXWGgyp4/66cR58w/vJXi2nGGyB3nLxeTcTA=
X-Google-Smtp-Source: AK7set9293PF3gtVSLcSeKP7/GQJRUx7rj9DrZRTCwLJ7jGarBoSu/FzASHeQcoehpR0SaIfWNpVvSibgsUsbagRsLU=
X-Received: by 2002:a17:903:26d4:b0:19a:f9d5:684d with SMTP id
 jg20-20020a17090326d400b0019af9d5684dmr9923676plb.8.1678485755776; Fri, 10
 Mar 2023 14:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20230306235730.GA31451@monkey> <ZAaCISgq4A/GnkCk@x1n>
 <20230307004049.GC4956@monkey> <20230308190206.GA4005@monkey>
 <CAAa6QmSdTo77dP2q2nU==C_2PdyF611+PVF32uPOTUQbp1kc9Q@mail.gmail.com>
 <20230309233340.GC3700@monkey> <CAAa6QmSiuFF6Oe0-j+eD0ma2tZAbhZuwENDYSZQSBrh1oeaLdA@mail.gmail.com>
In-Reply-To: <CAAa6QmSiuFF6Oe0-j+eD0ma2tZAbhZuwENDYSZQSBrh1oeaLdA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Mar 2023 14:02:23 -0800
Message-ID: <CAHbLzkp5FGky1JeNLL=4WiKoXz-Y_2t1neyi0x0iBu8v3La7PA@mail.gmail.com>
Subject: Re: THP backed thread stacks
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 4:05=E2=80=AFPM Zach O'Keefe <zokeefe@google.com> wr=
ote:
>
> On Thu, Mar 9, 2023 at 3:33=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.=
com> wrote:
> >
> > On 03/09/23 14:38, Zach O'Keefe wrote:
> > > On Wed, Mar 8, 2023 at 11:02=E2=80=AFAM Mike Kravetz <mike.kravetz@or=
acle.com> wrote:
> > > >
> > > > On 03/06/23 16:40, Mike Kravetz wrote:
> > > > > On 03/06/23 19:15, Peter Xu wrote:
> > > > > > On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> > > > > > >
> > > > > > > Just wondering if there is anything better or more selective =
that can be
> > > > > > > done?  Does it make sense to have THP backed stacks by defaul=
t?  If not,
> > > > > > > who would be best at disabling?  A couple thoughts:
> > > > > > > - The kernel could disable huge pages on stacks.  libpthread/=
glibc pass
> > > > > > >   the unused flag MAP_STACK.  We could key off this and disab=
le huge pages.
> > > > > > >   However, I'm sure there is somebody somewhere today that is=
 getting better
> > > > > > >   performance because they have huge pages backing their stac=
ks.
> > > > > > > - We could push this to glibc/libpthreads and have them use
> > > > > > >   MADV_NOHUGEPAGE on thread stacks.  However, this also has t=
he potential
> > > > > > >   of regressing performance if somebody somewhere is getting =
better
> > > > > > >   performance due to huge pages.
> > > > > >
> > > > > > Yes it seems it's always not safe to change a default behavior =
to me.
> > > > > >
> > > > > > For stack I really can't tell why it must be different here.  I=
 assume the
> > > > > > problem is the wasted space and it exaggerates easily with N-th=
reads.  But
> > > > > > IIUC it'll be the same as thp to normal memories iiuc, e.g., th=
ere can be a
> > > > > > per-thread mmap() of 2MB even if only 4K is used each, then if =
such mmap()
> > > > > > is populated by THP for each thread there'll also be a huge was=
te.
> > > >
> > > > I may be alone in my thinking here, but it seems that stacks by the=
ir nature
> > > > are not generally good candidates for huge pages.  I am just thinki=
ng about
> > > > the 'normal' use case where stacks contain local function data and =
arguments.
> > > > Am I missing something, or are huge pages really a benefit here?
> > > >
> > > > Of course, I can imagine some thread with a large amount of frequen=
tly
> > > > accessed data allocated on it's stack which could benefit from huge
> > > > pages.  But, this seems to be an exception rather than the rule.
> > > >
> > > > I understand the argument that THP always means always and everywhe=
re.
> > > > It just seems that thread stacks may be 'special enough' to conside=
r
> > > > disabling by default
> > >
> > > Just my drive-by 2c, but would agree with you here (at least wrt
> > > hugepages not being good candidates, in general). A user mmap()'ing
> > > memory has a lot more (direct) control over how they fault / utilize
> > > the memory: you know when you're running out of space and can map mor=
e
> > > space as needed. For these stacks, you're setting the stack size to
> > > 2MB just as a precaution so you can avoid overflow -- AFAIU there is
> > > no intention of using the whole mapping (and looking at some data,
> > > it's very likely you won't come close).
> > >
> > > That said, why bother setting stack attribute to 2MiB in size if ther=
e
> > > isn't some intention of possibly being THP-backed? Moreover, how did
> > > it happen that the mappings were always hugepage-aligned here?
> >
> > I do not have the details as to why the Java group chose 2MB for stack
> > size.  My 'guess' is that they are trying to save on virtual space (alt=
hough
> > that seems silly).  2MB is actually reducing the default size.  The
> > default pthread stack size on my desktop (fedora) is 8MB [..]
>
> Oh, that's interesting -- I did not know that. That's huge.
>
> > [..]  This also is
> > a nice multiple of THP size.
> >
> > I think the hugepage alignment in their environment was somewhat luck.
> > One suggestion made was to change stack size to avoid alignment and
> > hugepage usage.  That 'works' but seems kind of hackish.
>
> That was my first thought, if the alignment was purely due to luck,
> and not somebody manually specifying it. Agreed it's kind of hackish
> if anyone can get bit by this by sheer luck.
>
> > Also, David H pointed out the somewhat recent commit to align sufficien=
tly
> > large mappings to THP boundaries.  This is going to make all stacks hug=
e
> > page aligned.
>
> I think that change was reverted by Linus in commit 0ba09b173387
> ("Revert "mm: align larger anonymous mappings on THP boundaries""),
> until it's perf regressions were better understood -- and I haven't
> seen a revamp of it.

The regression has been fixed and it is not related to this commit. I
suggested Andrew to resurrect this commit a couple of months ago, but
it has not been.

>
> > --
> > Mike Kravetz
>
