Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC6696A32
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBNQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjBNQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:47:42 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306165A0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:47:38 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-52ee632329dso140769567b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ayL3I3lSJXQSr5Jm+VXTau51rl41gfRsh35PsMQ4l4=;
        b=p2TLRP1LQYRQFLiyDUgbiLevDu32jCQ1L/y8KHXKpM3qk3yQMC/KRusxiAUo/2I5FR
         akQzZTLXnxb+P1qBmss9iIWLDGKg0C359syK073euM8tuN5Sl/8WYF11lclUeYyAUpMT
         hAGRMYI/iF5fhJver2jb4sWSYvtAFyiBKJIPjFvWpjnoUJwPU0kqPytUKfvSHAYHbAg2
         M09YNljijJZij+Yr4ZSoVYpX0jHEwLPIiBY9qadnh3wJ0BvnRF1uG1ci8Ku87aTVb1aO
         81XWgOzFKio+DbidG2VtE3NpZSUFQFw5KG2e47GfYfbWHge6uJXUOgMZ4f80jBrT9T8b
         1Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ayL3I3lSJXQSr5Jm+VXTau51rl41gfRsh35PsMQ4l4=;
        b=DoOrkA8LiNj8tBHnr3og63bOv+vOJt6A04E4FL87XvjKnYzpJ3aC4njqlfLM9AwiPw
         uk8aiCH/svvC+pYYFGwl5nYo+GS6c+pQF2hitC6ZES4MyJDr3066rsTAEXxOzBnYl6H8
         XdJnopjXltqvc7mbukwPLpKDn9MA+UlwM+u26VAk/Uav5R6wvVecoDmJDv2uUEz5SsYi
         no3TjF8k4vSUuvwcOQ4mt5LSbgwxaRC0OHpkPwiO0jsUTzIXJUCbylBbE2zUB5EIEO5Y
         m+0oZu0HIgV/lpIi5RzOl/fgxXgjywbIMt6a4/2uK5DRMlw1tPEeKDHpNe3m2ts7ixve
         9L0Q==
X-Gm-Message-State: AO0yUKV2fMkzYH052VVS+ZXwVGJfSWK5ywKfEZOKTYmziRdB0xdQQOnh
        GryyKA96DIjNkLD6dPBXRHeWKxvCMIGILeeoO9zUaA==
X-Google-Smtp-Source: AK7set/mxOKdHn92cBwjyApj3R28pXKEhuPBGovIRR6cczvfLCLR3WjxmhojkFsLR3cVOKM9zEYVw0ts4tZUpyJ11zo=
X-Received: by 2002:a0d:f5c4:0:b0:52e:c93a:bb36 with SMTP id
 e187-20020a0df5c4000000b0052ec93abb36mr319927ywf.277.1676393257997; Tue, 14
 Feb 2023 08:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com> <20230127145138.8cc44bf00ebf289dffec0975@linux-foundation.org>
 <Y9Rdmy5h2F1z5yR3@casper.infradead.org> <CAJuCfpEq2F4EwWAeP6nLqS9m9XLpUss8n=35ZTgYgtiAJyvsxQ@mail.gmail.com>
In-Reply-To: <CAJuCfpEq2F4EwWAeP6nLqS9m9XLpUss8n=35ZTgYgtiAJyvsxQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 14 Feb 2023 08:47:26 -0800
Message-ID: <CAJuCfpG8Lq9xOce4yaNm1XzdAxVWTJYA85zjDbcpJ5MxxHr+4g@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] Per-VMA locks
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Fri, Jan 27, 2023 at 4:00 PM Suren Baghdasaryan <surenb@google.com> wrot=
e:
>
> On Fri, Jan 27, 2023 at 3:26 PM Matthew Wilcox <willy@infradead.org> wrot=
e:
> >
> > On Fri, Jan 27, 2023 at 02:51:38PM -0800, Andrew Morton wrote:
> > > On Fri, 27 Jan 2023 11:40:37 -0800 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > Per-vma locks idea that was discussed during SPF [1] discussion at =
LSF/MM
> > > > last year [2], which concluded with suggestion that =E2=80=9Ca read=
er/writer
> > > > semaphore could be put into the VMA itself; that would have the eff=
ect of
> > > > using the VMA as a sort of range lock. There would still be content=
ion at
> > > > the VMA level, but it would be an improvement.=E2=80=9D This patchs=
et implements
> > > > this suggested approach.
> > >
> > > I think I'll await reviewer/tester input for a while.

Over the last two weeks I did not receive any feedback on the mailing
list but off-list a couple of people reported positive results in
their tests and Punit reported a regression on his NUMA machine when
running pft-threads workload. I found the source of that regression
and have two small fixes which were confirmed to improve the
performance (hopefully Punit will share the results here).
I'm planning to post v3 sometime this week. If anyone has additional
feedback, please let me know soon so that I can address it in the v3.
Thanks,
Suren.


>
> Sure, I don't expect the review to be very quick considering the
> complexity, however I would appreciate any testing that can be done.
>
> > >
> > > > The patchset implements per-VMA locking only for anonymous pages wh=
ich
> > > > are not in swap and avoids userfaultfs as their implementation is m=
ore
> > > > complex. Additional support for file-back page faults, swapped and =
user
> > > > pages can be added incrementally.
> > >
> > > This is a significant risk.  How can we be confident that these as ye=
t
> > > unimplemented parts are implementable and that the result will be goo=
d?
> >
> > They don't need to be implementable for this patchset to be evaluated
> > on its own terms.  This patchset improves scalability for anon pages
> > without making file/swap/uffd pages worse (or if it does, I haven't
> > seen the benchmarks to prove it).
>
> Making it work for all kinds of page faults would require much more
> time. So, this incremental approach, when we tackle the mmap_lock
> scalability problem part-by-part seems more doable. Even with
> anonymous-only support, the patch shows considerable improvements.
> Therefore I would argue that the patch is viable even if it does not
> support the above-mentioned cases.
>
> >
> > That said, I'm confident that I have a good handle on how to make
> > file-backed page faults work under RCU.
>
> Looking forward to collaborating on that!
> Thanks,
> Suren.
