Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86255672A89
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjARVdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARVdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:33:13 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC83366A2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:33:12 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e130so132382yba.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rP4CDQ2rpOjfvUbagwjxVJ0xf2zruAnQYoFEPU2Sx3k=;
        b=RAx0+izBCRm2tPZzHrzNMeV6yl1INYuQtaInBJs+HEtFcs9ehbV3S57t4xI2FGTk+o
         Nm9+7LQuQzUFxnOvZC8XTpJcvBMXvxHgbvLSMwDNq6KfnZedW5E1uac49w7t6LTr2JyH
         za5erQrgnDyQhV4bXkLC5t7GA3lhS35zYsHEzZ6hD7VQ4zGiiG8DMoreMn8dGQSWx8tN
         LZwhO7xQgIjmuygrUt/h3Fz7Q19IjE0pPjnWpyUU+o0RAeR0mlrSp9HDF5JXpKsyPDiV
         /YVKORU/Rlqff/8XrR965fSIgplok91JlbkLjIlq7fqhvwA/DSwWlGpreXn6844JvC7p
         5KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP4CDQ2rpOjfvUbagwjxVJ0xf2zruAnQYoFEPU2Sx3k=;
        b=rusqNPtLdnQmJswFUmU51+SoDzzOqprzXOQeKn0/NNgM7A34efwdDIEgRXZ0NFKn2T
         9FsuxeXltYnNuWNigoSYxLsB2w1jXpMYTSpIYrwG6YufrqBwV5lyb8BcJiYKvjHE/zCK
         vr5E0yklku1Qt+Q/XaWmgMJVpmjAjly+nIYfzyyPnIuzykbSJeIFM+3jPnoDoiZMxbLe
         K/32rc811n++DvPEAemRFSt1aedlUtVPX30n+VQhDWZFDrlyHBXpc/gG99IS4hTzY9Ku
         /sHvoJKnWRWrpeqpuSYvkdDfeEMLlPe1S4C1rhFH3qyyDIAoF1Ibsk4iMShRCVa7VRth
         9/3Q==
X-Gm-Message-State: AFqh2ko5l7V8qFVtROc81uG6hruF4JbDs882FoS25B8dcgyW9rn3ZLn/
        s8wYdrWHZwG5oWoaA2xAx0LB7WM0/J154gv/bV4eoA==
X-Google-Smtp-Source: AMrXdXts0kmfZrhZ7FxbKkRKglCXXMtc+rHyBRTuF6TCj2lVfRNxrsSD1Xcm2xLH+Hr72eVJepI/lUb8MxAVQx4Rs4E=
X-Received: by 2002:a05:6902:11cd:b0:7d6:c4f6:b4ea with SMTP id
 n13-20020a05690211cd00b007d6c4f6b4eamr901759ybu.59.1674077591451; Wed, 18 Jan
 2023 13:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-29-surenb@google.com>
 <Y8bDAVC/aiL9tCyz@dhcp22.suse.cz> <CAJuCfpHRRsUMNHp2H3UiB4EZbe9CXTVcAC+oOR1dscENjp1Jbw@mail.gmail.com>
 <Y8ddI7vcKw8oecsr@casper.infradead.org>
In-Reply-To: <Y8ddI7vcKw8oecsr@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 13:33:00 -0800
Message-ID: <CAJuCfpGOmTO_HbCLZ1CytAGpbNgqe5PF2Q-G83T32H9hnmzGgA@mail.gmail.com>
Subject: Re: [PATCH 28/41] mm: introduce lock_vma_under_rcu to be used from
 arch-specific code
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
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

On Tue, Jan 17, 2023 at 6:44 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jan 17, 2023 at 05:06:57PM -0800, Suren Baghdasaryan wrote:
> > On Tue, Jan 17, 2023 at 7:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 09-01-23 12:53:23, Suren Baghdasaryan wrote:
> > > > Introduce lock_vma_under_rcu function to lookup and lock a VMA during
> > > > page fault handling. When VMA is not found, can't be locked or changes
> > > > after being locked, the function returns NULL. The lookup is performed
> > > > under RCU protection to prevent the found VMA from being destroyed before
> > > > the VMA lock is acquired. VMA lock statistics are updated according to
> > > > the results.
> > > > For now only anonymous VMAs can be searched this way. In other cases the
> > > > function returns NULL.
> > >
> > > Could you describe why only anonymous vmas are handled at this stage and
> > > what (roughly) has to be done to support other vmas? lock_vma_under_rcu
> > > doesn't seem to have any anonymous vma specific requirements AFAICS.
> >
> > TBH I haven't spent too much time looking into file-backed page faults
> > yet but a couple of tasks I can think of are:
> > - Ensure that all vma->vm_ops->fault() handlers do not rely on
> > mmap_lock being read-locked;
>
> I think this way lies madness.  There are just too many device drivers
> that implement ->fault.  My plan is to call the ->map_pages() method
> under RCU without even read-locking the VMA.  If that doesn't satisfy
> the fault, then drop all the way back to taking the mmap_sem for read
> before calling into ->fault.

Sounds reasonable to me but I guess the devil is in the details...

>
