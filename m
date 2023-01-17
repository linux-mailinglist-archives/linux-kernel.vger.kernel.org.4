Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB45670D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjAQXV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAQXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:20:38 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D14B6B997
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:09:34 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 123so2557521ybv.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E1pw3vOO82Ds9w0163Mtmi7QOVEF9Qab6422FSilTSc=;
        b=mTi6Cm+rzRtxi6oZLIJ91mSXwfcEY4a81qq/xNecU7vlrtpUR0JpUZwhomKtKdV/bH
         yATQfErPbZeyxcdUyrwsBWOSQi8RryHvk++rcz/w37nplP0mXTMxsOfNDarssjFI59pq
         xr/7egPGkEYgrPd2M84+OJzl0Gvc+HM4EftCB2pHv8VhI8/KQoFHXoj87lciP06arJYR
         b6NCAoEFSNtxVpc2Xa35GvApYPnqkvaTscxeFceDY0/WXM2I2CsL2bwcuP4vAlthafgX
         e/k0u6+zh4JdfVmiWfJDx6EnicyeOXe5BqhJwpOAEOaXveBALnLC//9uWtAWOKl1MqIc
         ZOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1pw3vOO82Ds9w0163Mtmi7QOVEF9Qab6422FSilTSc=;
        b=P0q17sBGcOLlGCpbzMvK3i6SisOvOX9TRORxCyhtdut4Vuo1wbUihovcgZ4XBshmOj
         epzQ7Jh8d+PPnhJPU+KIGBYbFiENVjxOrIggPSqT70TAx9Ezj+sPBcN/lj9nGddgpvPY
         tz7kPzEzAb1epULDvJyJm/fRtyP28ZjQinrs44BxLD5EF6SWBictHXe0VCgA7Pa1OjsQ
         jXVImPqRoSEPqiLuafWaiyPHi4nf0rqCKZTXodhKGExuXeKT0p1bpLxl7j2nuiDxnlYM
         AdokCUSRFA6MYuevEYbS7Y2xAU87cjzGFCBHJZoWdiAuJUYmvwp9hgJBvhk1LQFjWSXx
         Gf9A==
X-Gm-Message-State: AFqh2krcMCIED1EYi5GymWu3rXr5cC+Q8lMnK1u7BgQHxBFnKIHqt/7K
        BUvS7EU38ydy0y6NDdwG0bGogG42gKIcBeshREwMbA==
X-Google-Smtp-Source: AMrXdXsOr+GEGkBosigfUHXu92KjE9VznkpfG3TQiLvk8vecH24hbrAEBO8q8YfqiqTC9f7Q1FqDZlNhJ6QWePgl6iw=
X-Received: by 2002:a05:6902:685:b0:7e9:646d:2da3 with SMTP id
 i5-20020a056902068500b007e9646d2da3mr667784ybt.340.1673989773689; Tue, 17 Jan
 2023 13:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-13-surenb@google.com>
 <Y8a5lRr+qNVwau5G@dhcp22.suse.cz>
In-Reply-To: <Y8a5lRr+qNVwau5G@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 13:09:13 -0800
Message-ID: <CAJuCfpGGWLsagSsXbe8mshm9fTD0CZ=Hmv8c_5Uj2+YFStLaEw@mail.gmail.com>
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
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

On Tue, Jan 17, 2023 at 7:07 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-01-23 12:53:07, Suren Baghdasaryan wrote:
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 5986817f393c..c026d75108b3 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -474,6 +474,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> >                */
> >               *new = data_race(*orig);
> >               INIT_LIST_HEAD(&new->anon_vma_chain);
> > +             vma_init_lock(new);
> >               dup_anon_vma_name(orig, new);
> >       }
> >       return new;
> > @@ -1145,6 +1146,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
> >       seqcount_init(&mm->write_protect_seq);
> >       mmap_init_lock(mm);
> >       INIT_LIST_HEAD(&mm->mmlist);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     WRITE_ONCE(mm->mm_lock_seq, 0);
> > +#endif
>
> The mm shouldn't be visible so why WRITE_ONCE?

True. Will change to a simple assignment.

>
> --
> Michal Hocko
> SUSE Labs
