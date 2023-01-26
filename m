Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0E67C1FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjAZAv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjAZAv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:51:57 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDD75EFAC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:51:56 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id c124so265375ybb.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=erqaH/f6aiKK2Y2revDVg8Kw4fhimJKEevbWpDvyDBg=;
        b=hw634KVELmZovB0koBFlTAd5HhJuv9a7pYcJyRWRKHoGtoQdRC7yF8vjOQ2U0bypmG
         bxJMDOSqi6YCIMq0O0u7h7DlvsucKb2iKlM/NvE7Dmx0WmnHc7FtctOsvR0ZSG7Pdi/c
         RIAivTP216iTEOjdE9b7cFfM4NXSuPy059FKCQhl9h+cH8k+Q2vVGluOc8e9Sq0ojcpT
         3LP64M2kOZduDnYP/DTPERa7qITWr9LoSvGDwwlcByzhMus0GTtyhtr99lMEUJLUgkVM
         Nvw0hslXpJWDqz1wU+kVDqiaq4XhMZ7lGAb1fmx6jFLYgoaep29ldxo9/UK06Uu6JPcS
         mLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erqaH/f6aiKK2Y2revDVg8Kw4fhimJKEevbWpDvyDBg=;
        b=QAyxDXyPjei6StZg6qHuIQF4CZQ5SKPHlHsg//CLKvigcCWnZmk2FoDfyyS5j+LTnV
         n2GjoaroKfpTP9rI9HI7sNxBbm9xoZtkmQXpofPct7cRpE9cbo5fMKGn/FOJuM3yCW4F
         xqTlRLy8xPbDf0c/LJ9xa/AEbgW6jdF8s/HF4xQV/TcKr0KZEjbAb5MgjPZMV0ieUmu8
         +/Xug4jX0iIMBAPiQe+apfFauDu1bDnNsZGRDWS3SP16hXVgZ7BN5iyP4DuL/TwL4OKn
         sp8zCDNVlSb9i/WNB+JwOAFQKcJK8pcgLxkWoY1IoOr+gKHqq+CcqzG9IOPAvEnnULi9
         BDDQ==
X-Gm-Message-State: AFqh2krSQ7bmM9fss6K4c9z3epTPGoUuMzpE5OfqtI6RiPYYQfgJmDrw
        SEYvPkbBpb9TNrLA32MPleZXmMwS9lHC6Va7HAwAnA==
X-Google-Smtp-Source: AMrXdXuWS62n/voZpqLFx7lY106TWS0DFfvcP0at+KMVcEseFA31+u6DR/UW+7IKRl7uOX0L8iaQWbLpM1VsRjvwvbM=
X-Received: by 2002:a25:f305:0:b0:7b8:6d00:ef23 with SMTP id
 c5-20020a25f305000000b007b86d00ef23mr3939970ybs.119.1674694315876; Wed, 25
 Jan 2023 16:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-3-surenb@google.com>
 <20230125162419.13379944d6c0d4253d7bc88c@linux-foundation.org>
In-Reply-To: <20230125162419.13379944d6c0d4253d7bc88c@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 25 Jan 2023 16:51:44 -0800
Message-ID: <CAJuCfpF21a7seLpEcoWbDLDWUznAOdQo9P6LERmi-iyKMgQGXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm: introduce vma->vm_flags wrapper functions
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
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

On Wed, Jan 25, 2023 at 4:24 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 25 Jan 2023 15:35:49 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > vm_flags are among VMA attributes which affect decisions like VMA merging
> > and splitting. Therefore all vm_flags modifications are performed after
> > taking exclusive mmap_lock to prevent vm_flags updates racing with such
> > operations. Introduce modifier functions for vm_flags to be used whenever
> > flags are updated. This way we can better check and control correct
> > locking behavior during these updates.
> >
> > ...
> >
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > +static inline void init_vm_flags(struct vm_area_struct *vma,
> > +static inline void reset_vm_flags(struct vm_area_struct *vma,
> > +static inline void set_vm_flags(struct vm_area_struct *vma,
> > +static inline void clear_vm_flags(struct vm_area_struct *vma,
> > +static inline void mod_vm_flags(struct vm_area_struct *vma,
>
> vm_flags_init(), vm_flags_reset(), etc?
>
> This would be more idiomatic and I do think the most-significant-first
> naming style is preferable.

Thanks for the suggestion! I will rename them in the next version.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
