Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A85C66E870
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjAQV3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAQV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:29:12 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C69C1A4A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:51:38 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id v6so6406974ilq.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OSFcPHbwPU7VuQqTvb7CRygx4qEQJSCX4opQ3eOpE/E=;
        b=oK5gCq5xbP6niBRqF/QRL7Bq2gVthVqJQbspwhXXQ7OnRSHWI5AiE5QK1LTqtcMGRn
         HeyRbfCQAKtC4T3gzbb8Wzg7491gbqjvpVBGSplHQdv+8mbaq/6L7WWL28izPBjIqoix
         RcZwdqu/IkMGD9/tcQk+epsczoRPYFq75Ly73PSeVqekeXO1isqgk/+r+nTbDSVMXuGR
         7D+jZPUfzbSoBt77De0gD6WjMDA5N64/6EgjY16694eHJ1oNyDGZlC2jU7fD9KrrnhM9
         KHzaaaT+da49MDKCEZDrLz7ulbS8/gmsAhEEGJNDyRrKINMsAmuavctzqCV6f7UGaTFS
         kFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSFcPHbwPU7VuQqTvb7CRygx4qEQJSCX4opQ3eOpE/E=;
        b=3Q05DoWYZc6YPf+LNAkb15wCQN3kMm6prZ+iAST4W9iyM3bBMEHx0XcCDzkiO395qu
         WUriw9mGoCLkuRmHYJTqxChlKnQGn9RZ/zClAr9ct/rWaSE6eOKTS2haMaM9CY/vzFL2
         2IHOqgE1WMMVByff+iXECljiDCq137oi1JCabGpvVX6QvD+en90c9wamalpFBoUL5ct3
         1AIC7+Nq9Tc4mSwPLUUaDavbnYR3V69g804e+rcgJVG9N+3U5gyk1/zDQhy4DW/VRlLA
         NisHZi0BCMe1b3QT1tFxYjVoVkZefKaeuOMe3IADH4eoc6K3kpsfZPSo5ljBF0SanIz4
         2y0Q==
X-Gm-Message-State: AFqh2kqYeU4qQSkOQN9ktBue6amnPXmfZxt/83RZLPUgEOXplYae7vyZ
        UrQipoRovMDAxdKr8wel5SkFKo9/TBCjBBOJNGcbuA==
X-Google-Smtp-Source: AMrXdXtN2czWy7s7z6riYeL+TaWTkUjkEXdbo5Qe/e5v9zxAXm+Abj+Br8dn7RO1A0aNN2qhpP5AND12ti3Cn4146c8=
X-Received: by 2002:a92:c5c6:0:b0:30c:877:db26 with SMTP id
 s6-20020a92c5c6000000b0030c0877db26mr453316ilt.101.1673985097438; Tue, 17 Jan
 2023 11:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-33-surenb@google.com>
In-Reply-To: <20230109205336.3665937-33-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 20:51:01 +0100
Message-ID: <CAG48ez0Z-wnBLzCNDHgTviV0Ws+s4grX-sFRZ-43dxhJg+GzfA@mail.gmail.com>
Subject: Re: [PATCH 32/41] mm: prevent userfaults to be handled under per-vma lock
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
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

On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> Due to the possibility of handle_userfault dropping mmap_lock, avoid fault
> handling under VMA lock and retry holding mmap_lock. This can be handled
> more gracefully in the future.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 20806bc8b4eb..12508f4d845a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5273,6 +5273,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>         if (!vma->anon_vma)
>                 goto inval;
>
> +       /*
> +        * Due to the possibility of userfault handler dropping mmap_lock, avoid
> +        * it for now and fall back to page fault handling under mmap_lock.
> +        */
> +       if (userfaultfd_armed(vma))
> +               goto inval;

This looks racy wrt concurrent userfaultfd_register(). I think you'll
want to do the userfaultfd_armed(vma) check _after_ locking the VMA,
and ensure that the userfaultfd code write-locks the VMA before
changing the __VM_UFFD_FLAGS in vma->vm_flags.

>         if (!vma_read_trylock(vma))
>                 goto inval;
>
> --
> 2.39.0
>
