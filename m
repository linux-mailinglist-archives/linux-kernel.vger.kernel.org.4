Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FC67873F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjAWUIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjAWUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:08:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B177A9C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:08:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k16so9941490wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx0+AS/R5cTFxTer1KPJhFwelUzEZqlaudVJ4C5UqlM=;
        b=RyYyVfXdy0EOGXtjgeoYEX0CSfXeDuawJy3LtwRKGEXH7xPRUd7FzH5vM0ZD/5/uNP
         fWBSe/Vuek0fbxHy7ulBo2tzxgjytQXIhDoKjaRk3SO4pUlWanXPzUwdk9sCfPJMgGQV
         p18xwdky3Y0ZFWjj2oRsWB1r8iCofsyuM+DRRi3eBUWKYZ0nN2FXeurkdZEHXIwEXyHo
         0hKaiu62QCi9O+hzr1ZvTjmsOHLWnqe2N/6m1fgfhTobQv9HYlX2hUiV/odvHm54lxez
         NCc0aIPRkybQcRORZZdU5UX7FU9qwPmbIdE06KG8aUUiUZFG2ePpUffvAsR6tWHeElFT
         rYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xx0+AS/R5cTFxTer1KPJhFwelUzEZqlaudVJ4C5UqlM=;
        b=CNTyybfjS8U+APbUmqCYi0KdEOs/q8dz/nLGfCMhVi787SF1+Et9hfUdE51/3jrCFK
         kQwWf4IsxPTAHytBw9lYucgXk6ZD2X6eXGz6zz3ZPcMbml9m0s4MQhECwi4/N0tPelch
         TgAI+rAqu9DN4BoDh8Y0Mh2OJ6jcwxaUw91P1e5czdlWybBErrORBlfFiFw63ZwPBLzr
         8XMXyUTu2dvxodU0SvG/0K0ckv4wG8rdOe6/cTg05jqG1dg+EMo8pkX88gWY3jBcLCzz
         DQ0waeIjRbUduZNNesDsJmolZME9X2N4UFEOwobQAQyb+r0k/7aWAP9kOVLPD0LLzWfy
         qWNw==
X-Gm-Message-State: AFqh2krVOPgYayMCLCrW76kFgTzyWrcHOIm9gcf3fY0rxEMxYTH4uAyS
        VPkW7xtMNXz5E50hAcqDE7MnB/ZPb+d9o/D+gBgVOQ==
X-Google-Smtp-Source: AMrXdXsAYItHDpk4yH6h+tdfdbjpmDtWUNcVfzcOaPv8ocdm14en5egjG3x9mr/LGbfmiQJ1437Ba8Qp+R4Oyn+yujs=
X-Received: by 2002:a05:600c:3412:b0:3d0:a619:c445 with SMTP id
 y18-20020a05600c341200b003d0a619c445mr1027494wmp.17.1674504514768; Mon, 23
 Jan 2023 12:08:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
 <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz> <CAJuCfpG86qc4odkpUbzuROb+jThQgXGWjcFXb0e-c2i0wEGg4g@mail.gmail.com>
 <Y868Fadajv27QMXh@dhcp22.suse.cz> <CAJuCfpGSCHpnZwwVV_922fmMBpFPZL0HAHMABuDzMfuURF2sWg@mail.gmail.com>
 <Y87A2CEKAugfgfHC@dhcp22.suse.cz> <CAJuCfpGJRZATfc8eUurvV5kGkSNkG=vK=sfwJbU72PESOyATSw@mail.gmail.com>
 <Y87QjHH2aDG5XCGv@casper.infradead.org> <Y87djZwQpXazRd00@dhcp22.suse.cz>
 <Y87gY7fhi5OJ35WQ@casper.infradead.org> <Y87nVydD7oF9BGMb@dhcp22.suse.cz>
In-Reply-To: <Y87nVydD7oF9BGMb@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Jan 2023 12:08:21 -0800
Message-ID: <CAJuCfpEz_Qm3BeY5a0O+OBgZTTLSgvkqDE4XieCYyGMMv3Hykw@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jan 23, 2023 at 12:00 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 23-01-23 19:30:43, Matthew Wilcox wrote:
> > On Mon, Jan 23, 2023 at 08:18:37PM +0100, Michal Hocko wrote:
> > > On Mon 23-01-23 18:23:08, Matthew Wilcox wrote:
> > > > On Mon, Jan 23, 2023 at 09:46:20AM -0800, Suren Baghdasaryan wrote:
> > > [...]
> > > > > Yes, batching the vmas into a list and draining it in remove_mt() and
> > > > > exit_mmap() as you suggested makes sense to me and is quite simple.
> > > > > Let's do that if nobody has objections.
> > > >
> > > > I object.  We *know* nobody has a reference to any of the VMAs because
> > > > you have to have a refcount on the mm before you can get a reference
> > > > to a VMA.  If Michal is saying that somebody could do:
> > > >
> > > >   mmget(mm);
> > > >   vma = find_vma(mm);
> > > >   lock_vma(vma);
> > > >   mmput(mm);
> > > >   vma->a = b;
> > > >   unlock_vma(mm, vma);
> > > >
> > > > then that's something we'd catch in review -- you obviously can't use
> > > > the mm after you've dropped your reference to it.
> > >
> > > I am not claiming this is possible now. I do not think we want to have
> > > something like that in the future either but that is really hard to
> > > envision. I am claiming that it is subtle and potentially error prone to
> > > have two different ways of mass vma freeing wrt. locking. Also, don't we
> > > have a very similar situation during last munmaps?
> >
> > We shouldn't have two ways of mass VMA freeing.  Nobody's suggesting that.
> > There are two cases; there's munmap(), which typically frees a single
> > VMA (yes, theoretically, you can free hundreds of VMAs with a single
> > call which spans multiple VMAs, but in practice that doesn't happen),
> > and there's exit_mmap() which happens on exec() and exit().
>
> This requires special casing remove_vma for those two different paths
> (exit_mmap and remove_mt).  If you ask me that sounds like a suboptimal
> code to even not handle potential large munmap which might very well be
> a rare thing as you say. But haven't we learned that sooner or later we
> will find out there is somebody that cares afterall? Anyway, this is not
> something I care about all that much. It is just weird to special case
> exit_mmap, if you ask me. Up to Suren to decide which way he wants to
> go. I just really didn't like the initial implementation of batching
> based on a completely arbitrary batch limit and lazy freeing.

I would prefer to go with the simplest sufficient solution. A
potential issue with a large munmap might prove to be real but I think
we know how to easily fix that with batching if the issue ever
materializes (I'll have a fix ready implementing Michal's suggestion).
So, I suggest going with Liam's/Matthew's solution and converting to
Michal's solution if regression shows up anywhere else. Would that be
acceptable?

> --
> Michal Hocko
> SUSE Labs
