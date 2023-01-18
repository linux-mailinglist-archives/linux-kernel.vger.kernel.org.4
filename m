Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF056710FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjARCQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjARCQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:16:19 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B3351C6D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:16:17 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4c24993965eso442982417b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=plQIjN2wQ9XQXBQ5PSme4vUCmLrYkEIK9If4doKFLBI=;
        b=LEYLSbN+VJha9Y8r6nX3W37X12OGy8n862kizG4i1KEMLBQvAcrAa7awSx1mGj6i1M
         UZO5TbjxfJVrwATY1r5dwUg8ulM2yFaaEytzlAWSqp+tigueh/wVI7At443/LMXGGcdV
         02aU2qgTw4KyyW2cVar/Q+JPbd/GajrGO3fhydG8cNxnsGEj2DNXX1lHjQcNta+ndKLq
         VlrCSw29Fmnei5ErjNjvLZbBUUKgepCwNTFqoqk9hXLiOqQJA6NxpzwZj5tNijHCrCY0
         zNFBA/nJjj38TAHajL1bHQYqy86Qx8fnD261/akARVMdMAHEV4rhTf3wbpcFOTD1vzhT
         StSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plQIjN2wQ9XQXBQ5PSme4vUCmLrYkEIK9If4doKFLBI=;
        b=NwkzPXdpLlh0xh/U+IP+fNmyZoXyAbXxBmIuJwdXnQVvY56CR3EwLAG1L7Cv+MRX+E
         v71le6DNc120vqn6T8+YQwX+C7n3oLQaPA6Xf50rXhjIuD4SqhkILZZKYLMi+zXlC83p
         ZFhrrzwuBE7QQY8nVAfa2s0kfSlQipIP1AJruW6HfgQ4fb2Rfiu1UFfBct90jc81QiZZ
         G7HHTvsFI88QyQL9fnFTMY2yo4I1ji6zttAL9XK0iHbv+LTmw/cMoETXDMGY5Cp9CVC3
         +ZCevcrqbCkbn1xozFrLAZiR0G479eQq+Df72SIIZgTD261oRaRpdzeRm/5OJBoSYjqS
         2wVg==
X-Gm-Message-State: AFqh2kqGKCrYxbwj3BZkdDmEUdV614tcKGbnp2kvi030Xg0HCZRSGEXV
        pTBB4jz7u9fCrs0c/HP24EzfqdYbq/mwNeF6BVYmqw==
X-Google-Smtp-Source: AMrXdXu0PzeQzUrtMPh6Q6gmLxuEYbH19qaRWq6JHAbxojJ61ekKXs60PExdWQAgVi5xOUd0vb27BXUobHRewBc0eVw=
X-Received: by 2002:a81:9105:0:b0:3dc:fd91:ef89 with SMTP id
 i5-20020a819105000000b003dcfd91ef89mr584557ywg.347.1674008176468; Tue, 17 Jan
 2023 18:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-10-surenb@google.com>
 <Y8av6HjRUvaujeEO@dhcp22.suse.cz>
In-Reply-To: <Y8av6HjRUvaujeEO@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 18:16:05 -0800
Message-ID: <CAJuCfpFNp5dZvhx168k0MC+oBTRLY2ZVWgMQL_8VTZDTY3URDg@mail.gmail.com>
Subject: Re: [PATCH 09/41] mm: rcu safe VMA freeing
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

On Tue, Jan 17, 2023 at 6:25 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-01-23 12:53:04, Suren Baghdasaryan wrote:
> [...]
> >  void vm_area_free(struct vm_area_struct *vma)
> >  {
> >       free_anon_vma_name(vma);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     call_rcu(&vma->vm_rcu, __vm_area_free);
> > +#else
> >       kmem_cache_free(vm_area_cachep, vma);
> > +#endif
>
> Is it safe to have vma with already freed vma_name? I suspect this is
> safe because of mmap_lock but is there any reason to split the freeing
> process and have this potential UAF lurking?

It should be safe because VMA is either locked or has been isolated
while locked, so no page fault handlers should have access to it. But
you are right, moving free_anon_vma_name() into __vm_area_free() does
seem safer. Will make the change in the next rev.

>
> >  }
> >
> >  static void account_kernel_stack(struct task_struct *tsk, int account)
> > --
> > 2.39.0
>
> --
> Michal Hocko
> SUSE Labs
