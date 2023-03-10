Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508006B3285
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCJAF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCJAFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:05:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46FFE8A8D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:05:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a25so14079771edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 16:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678406750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOQ2JwrgXFV05O9tRlxq9mUvvX5cwHSFjxQP49GBiII=;
        b=s/togCRF/U8G5aJGup6+UUy1vUxgTglMyHmabUkcmccX9d1MOs200hR0ZT7xD0I0tR
         D0vbyE7VzURzFPRaW+7fNph0qGIDKejB9vhKBfXCETcj3GBtSZ4YCHJXdoaGaQVl2vNt
         /AMYSrr4m/26Yc5Sm8sugPnCFGCTvH6SZ4rcnjjTgFYZ6QqI6NlFEqv4z9sHNpSAHAxC
         kZ0e4NETFqkqAR5eqD5orN1/V+uox5TZSucGENw1KFZVMehbKNITeU4f8ImpWYvTxmYH
         EinLcP1hhyyOxjgoCFvZKmFIy8rPm6oOdn3pLqjOcAjG0EWnwzkY8d/r9Rry53bJAh4G
         UAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678406750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOQ2JwrgXFV05O9tRlxq9mUvvX5cwHSFjxQP49GBiII=;
        b=GS+16YkUQ5IidW0ysC2Kf619jXGyFsjOvxqvJJbj20Tt80Mt9s7gXRd+pIH9uOBGI9
         LlUKeRY7h5Ef80vWkOaM/a3qxfFB3zRk2xnQYyvXEHKB9VwdMTv4hnXZ7Y81k/o0AjTp
         xzqjYlh4lIAuocKo3RL0N2mlF3op5+Gbjm0l5KxtJ/JvL7UZrYyI1z+7xHIEdCa6UrYJ
         fIOHLjGmhfHTfc0mZrO7BiyeiLbre0gmNeQGPMcIlSrWGCHOieO8jkfSwSNCyGeWPzq/
         PHTfE/nWExnYccDmJoCh20jNvATikU5bHMaV7SbL3B27srFlpOsDxPYeIEU2n3ALunAx
         o9GA==
X-Gm-Message-State: AO0yUKVG5EV3h8yI9eWOGRZ7ZL4by+qn352MmhCAKZPzUh5bCS6v2mDO
        7OZ3ei7mKrkIaNETkCCgU4IvJVh3cgR92je7c5fbmnSEUEE55kludxRpsQ==
X-Google-Smtp-Source: AK7set/v4KpK5OJys67IvSPsijPpyucP+9dcxti8BzahB/SHxHqNo5m2OHgr4lu195qf+XV87sPuXopsDYEaFZ8Ur5M=
X-Received: by 2002:a17:906:7803:b0:8db:b5c1:7203 with SMTP id
 u3-20020a170906780300b008dbb5c17203mr12143219ejm.11.1678406749957; Thu, 09
 Mar 2023 16:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20230306235730.GA31451@monkey> <ZAaCISgq4A/GnkCk@x1n>
 <20230307004049.GC4956@monkey> <20230308190206.GA4005@monkey>
 <CAAa6QmSdTo77dP2q2nU==C_2PdyF611+PVF32uPOTUQbp1kc9Q@mail.gmail.com> <20230309233340.GC3700@monkey>
In-Reply-To: <20230309233340.GC3700@monkey>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 9 Mar 2023 16:05:13 -0800
Message-ID: <CAAa6QmSiuFF6Oe0-j+eD0ma2tZAbhZuwENDYSZQSBrh1oeaLdA@mail.gmail.com>
Subject: Re: THP backed thread stacks
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 3:33=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.co=
m> wrote:
>
> On 03/09/23 14:38, Zach O'Keefe wrote:
> > On Wed, Mar 8, 2023 at 11:02=E2=80=AFAM Mike Kravetz <mike.kravetz@orac=
le.com> wrote:
> > >
> > > On 03/06/23 16:40, Mike Kravetz wrote:
> > > > On 03/06/23 19:15, Peter Xu wrote:
> > > > > On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> > > > > >
> > > > > > Just wondering if there is anything better or more selective th=
at can be
> > > > > > done?  Does it make sense to have THP backed stacks by default?=
  If not,
> > > > > > who would be best at disabling?  A couple thoughts:
> > > > > > - The kernel could disable huge pages on stacks.  libpthread/gl=
ibc pass
> > > > > >   the unused flag MAP_STACK.  We could key off this and disable=
 huge pages.
> > > > > >   However, I'm sure there is somebody somewhere today that is g=
etting better
> > > > > >   performance because they have huge pages backing their stacks=
.
> > > > > > - We could push this to glibc/libpthreads and have them use
> > > > > >   MADV_NOHUGEPAGE on thread stacks.  However, this also has the=
 potential
> > > > > >   of regressing performance if somebody somewhere is getting be=
tter
> > > > > >   performance due to huge pages.
> > > > >
> > > > > Yes it seems it's always not safe to change a default behavior to=
 me.
> > > > >
> > > > > For stack I really can't tell why it must be different here.  I a=
ssume the
> > > > > problem is the wasted space and it exaggerates easily with N-thre=
ads.  But
> > > > > IIUC it'll be the same as thp to normal memories iiuc, e.g., ther=
e can be a
> > > > > per-thread mmap() of 2MB even if only 4K is used each, then if su=
ch mmap()
> > > > > is populated by THP for each thread there'll also be a huge waste=
.
> > >
> > > I may be alone in my thinking here, but it seems that stacks by their=
 nature
> > > are not generally good candidates for huge pages.  I am just thinking=
 about
> > > the 'normal' use case where stacks contain local function data and ar=
guments.
> > > Am I missing something, or are huge pages really a benefit here?
> > >
> > > Of course, I can imagine some thread with a large amount of frequentl=
y
> > > accessed data allocated on it's stack which could benefit from huge
> > > pages.  But, this seems to be an exception rather than the rule.
> > >
> > > I understand the argument that THP always means always and everywhere=
.
> > > It just seems that thread stacks may be 'special enough' to consider
> > > disabling by default
> >
> > Just my drive-by 2c, but would agree with you here (at least wrt
> > hugepages not being good candidates, in general). A user mmap()'ing
> > memory has a lot more (direct) control over how they fault / utilize
> > the memory: you know when you're running out of space and can map more
> > space as needed. For these stacks, you're setting the stack size to
> > 2MB just as a precaution so you can avoid overflow -- AFAIU there is
> > no intention of using the whole mapping (and looking at some data,
> > it's very likely you won't come close).
> >
> > That said, why bother setting stack attribute to 2MiB in size if there
> > isn't some intention of possibly being THP-backed? Moreover, how did
> > it happen that the mappings were always hugepage-aligned here?
>
> I do not have the details as to why the Java group chose 2MB for stack
> size.  My 'guess' is that they are trying to save on virtual space (altho=
ugh
> that seems silly).  2MB is actually reducing the default size.  The
> default pthread stack size on my desktop (fedora) is 8MB [..]

Oh, that's interesting -- I did not know that. That's huge.

> [..]  This also is
> a nice multiple of THP size.
>
> I think the hugepage alignment in their environment was somewhat luck.
> One suggestion made was to change stack size to avoid alignment and
> hugepage usage.  That 'works' but seems kind of hackish.

That was my first thought, if the alignment was purely due to luck,
and not somebody manually specifying it. Agreed it's kind of hackish
if anyone can get bit by this by sheer luck.

> Also, David H pointed out the somewhat recent commit to align sufficientl=
y
> large mappings to THP boundaries.  This is going to make all stacks huge
> page aligned.

I think that change was reverted by Linus in commit 0ba09b173387
("Revert "mm: align larger anonymous mappings on THP boundaries""),
until it's perf regressions were better understood -- and I haven't
seen a revamp of it.

> --
> Mike Kravetz
