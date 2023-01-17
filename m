Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF90670D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjAQXTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjAQXRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:17:25 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF50485B2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:03:57 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y69so992578iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nhao4yhxvo1b0ca4/4XXHiPX2DFuPMAuoXXjxRqWTzk=;
        b=Ugmy2ZqKnLRTOnr8n+vgJmW7jKcWi4hXccBOn2Gki6Zrag7MoLWtZ+TwC6KAa1rMXw
         wXpyQ8nmNJOrUrseDG9EzHysaXMjM04aS5x2xNylWaAN9xvvdISifj6fE++htaLmbddR
         j81VjCX2xsB852mW5SqUWN0nd9IvIVdfgHX33Hh2tu0XchQY05liQxtto9CUhXsnf9k7
         f6y6oOhGyoxCPLOEL45q+HGd9pmFyOS5F/LZR7OgkHsj8ga1IKTsgBSDZYIAGdZSdz8P
         SnaqeJ4jBFGrrKdUvkPzy7SEBae8MWN4qiEkG94kK43jVC7Q6PfwYVJUCo/XaiKekGkY
         8s8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhao4yhxvo1b0ca4/4XXHiPX2DFuPMAuoXXjxRqWTzk=;
        b=Blc3yaoMBBp1A2u+yF1N8KfPZtQbbvuui6MPLv5rzEisaW/z9gAsqe1AVX3u0NCPY5
         4u6jP1u5ByeMsOvkoY86BJquH9iF+vn8ZBskd35YLsgGb5j7q6wUTUKNyinwyYHwzzz6
         w2Tr5aHyP5Hr2bQde3aDhhewQDuANlNmnuamY5S+aMcze0zgW26JdghYYVP28MXKGJW3
         acZweJQ3lN+JnurDcNZoF7ES4ZD47XwigVMuU5YpjufZ/pCVEXQZATkIlv5XtditFc9M
         F8Hk5XtR6EU07hP7t98ZcKkzMrXyY7hFgSrK8V7sCKpsU7Dc11LnD4V92iSZplX1Al2X
         91bg==
X-Gm-Message-State: AFqh2kq01vbxqwcSLw4M3t75DC46GXFbjCWZt6HcZP1YE31cS6Z1+Jfc
        Yy0/h7ZOzoXc8NorUlGn3R2LdcKJTXn9zTfSMNINog==
X-Google-Smtp-Source: AMrXdXsMeP8M6U4I8iASTh2mqrZYLm+ikxBgVtUSVf76IGFGfS0Npq61yI+0jkuo5OgGYf5QPFQKrSgcpAZ1h7kJHBc=
X-Received: by 2002:a02:cb45:0:b0:39e:6dd8:6c96 with SMTP id
 k5-20020a02cb45000000b0039e6dd86c96mr345507jap.246.1673989436533; Tue, 17 Jan
 2023 13:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-29-surenb@google.com>
In-Reply-To: <20230109205336.3665937-29-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 22:03:20 +0100
Message-ID: <CAG48ez2cK1M=fgkYi4bPdWX7uOm15Omv6EjFgXUkS2QsqiwGSg@mail.gmail.com>
Subject: Re: [PATCH 28/41] mm: introduce lock_vma_under_rcu to be used from
 arch-specific code
To:     Suren Baghdasaryan <surenb@google.com>, willy@infradead.org,
        liam.howlett@oracle.com
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
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

On Mon, Jan 9, 2023 at 9:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> Introduce lock_vma_under_rcu function to lookup and lock a VMA during
> page fault handling. When VMA is not found, can't be locked or changes
> after being locked, the function returns NULL. The lookup is performed
> under RCU protection to prevent the found VMA from being destroyed before
> the VMA lock is acquired. VMA lock statistics are updated according to
> the results.
> For now only anonymous VMAs can be searched this way. In other cases the
> function returns NULL.
[...]
> +struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> +                                         unsigned long address)
> +{
> +       MA_STATE(mas, &mm->mm_mt, address, address);
> +       struct vm_area_struct *vma, *validate;
> +
> +       rcu_read_lock();
> +       vma = mas_walk(&mas);
> +retry:
> +       if (!vma)
> +               goto inval;
> +
> +       /* Only anonymous vmas are supported for now */
> +       if (!vma_is_anonymous(vma))
> +               goto inval;
> +
> +       if (!vma_read_trylock(vma))
> +               goto inval;
> +
> +       /* Check since vm_start/vm_end might change before we lock the VMA */
> +       if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
> +               vma_read_unlock(vma);
> +               goto inval;
> +       }
> +
> +       /* Check if the VMA got isolated after we found it */
> +       mas.index = address;
> +       validate = mas_walk(&mas);

Question for Maple Tree experts:

Are you allowed to use mas_walk() like this? If the first mas_walk()
call encountered a single-entry tree, it would store mas->node =
MAS_ROOT, right? And then the second call would go into
mas_state_walk(), mas_start() would return NULL, mas_is_ptr() would be
true, and then mas_state_walk() would return the result of
mas_start(), which is NULL? And we'd end up with mas_walk() returning
NULL on the second run even though the tree hasn't changed?

> +       if (validate != vma) {
> +               vma_read_unlock(vma);
> +               count_vm_vma_lock_event(VMA_LOCK_MISS);
> +               /* The area was replaced with another one. */
> +               vma = validate;
> +               goto retry;
> +       }
> +
> +       rcu_read_unlock();
> +       return vma;
> +inval:
> +       rcu_read_unlock();
> +       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> +       return NULL;
> +}
