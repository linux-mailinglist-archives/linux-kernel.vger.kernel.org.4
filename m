Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E666E626
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjAQSfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjAQSbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:31:50 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEB94391A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:03:42 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id u8so15760022ilq.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2LfIzIDKNfdwhzRI4wk4tbto15PFLzQqPn6IM74K1Nc=;
        b=Mooewx5NuvmBi8G3lPeDVvjeMhDwam4J3V5WoYrMGEaACQq8r01FTJwg9r5gNAqKHv
         BcT+clyjtziDoHfDoZgf8mXwiyxjshQK9AVHMyb/QWVVp32ww9ingtrVqod0LDfOJImz
         Y0TwcaekYYsJ//YdVBtdZXByqq9WLLeZf19Z8v3wfd8Qhfwfau1IdSR4Tc4e6jr2szha
         MfdiYZLdlOAFeQe7T4M3d15TPoEEp9r20dwRTcjDofABHxa96XnhDW06/jzXCIqYK82c
         D9cdjVUUN6zid8FXGy9WF8BxgN6Gta9IfDG+F3FYzRS4GL6vM308WQjFQsyY7d5ObtDP
         aykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LfIzIDKNfdwhzRI4wk4tbto15PFLzQqPn6IM74K1Nc=;
        b=ue3cCaTDhkGE9BGN/rFtkVSQ62GS+rT+D6UwDU4p5asd5zTJQf0nlHEWCjuSA4u+/M
         db6hBT67I7AoaX6KmZImFG0yTpp/goemW9Prl3TXzZp6jJlmHzRTG3GFad/UQ/46oAg3
         dwSuf7q008OoNitTf8G/IlplZfR+w7UsUn6w397pY46TnHvm6ptWRvZaISlJtgX2j11p
         7HYOijLogNJGoqV1pqNzer9GwMrHEL3bmpR5rD7CPWnkrdNBCmbtis46N0sB9A4If+dW
         QbKchykdZDQEnSMYSGmUWGNT2kGjbZufoD+W6gr0DwJBDLLzcRDzJjalDppuSqpKT0SG
         muxQ==
X-Gm-Message-State: AFqh2kra+xKSHwJTERcDQEZ/LpyytNxmQMKc+IDUCtKxOzhfi48VPEEV
        cCl4YVX558b4YuEYq+Il3OvUGsjZtBluUTnG8yISyA==
X-Google-Smtp-Source: AMrXdXuYG9pfhe3BEDdAxOrlJ5FMm60eG9MzyrHap4mGomMoh4ycHHb4WuecCt1NKPItKhuNPMbigXyQKtN6iEbWTIk=
X-Received: by 2002:a92:a043:0:b0:30b:f4af:87bd with SMTP id
 b3-20020a92a043000000b0030bf4af87bdmr425702ilm.254.1673978611685; Tue, 17 Jan
 2023 10:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-13-surenb@google.com>
In-Reply-To: <20230109205336.3665937-13-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 19:02:55 +0100
Message-ID: <CAG48ez0RhQ6=W01brLUXDXqQxz2M1FEMNqd2OvL+LhcJQY=NqA@mail.gmail.com>
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
To:     Suren Baghdasaryan <surenb@google.com>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com,
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

+locking maintainers

On Mon, Jan 9, 2023 at 9:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> Introduce a per-VMA rw_semaphore to be used during page fault handling
> instead of mmap_lock. Because there are cases when multiple VMAs need
> to be exclusively locked during VMA tree modifications, instead of the
> usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> mmap_write_lock holder is done with all modifications and drops mmap_lock,
> it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> locked.
[...]
> +static inline void vma_read_unlock(struct vm_area_struct *vma)
> +{
> +       up_read(&vma->lock);
> +}

One thing that might be gnarly here is that I think you might not be
allowed to use up_read() to fully release ownership of an object -
from what I remember, I think that up_read() (unlike something like
spin_unlock()) can access the lock object after it's already been
acquired by someone else. So if you want to protect against concurrent
deletion, this might have to be something like:

rcu_read_lock(); /* keeps vma alive */
up_read(&vma->lock);
rcu_read_unlock();

But I'm not entirely sure about that, the locking folks might know better.

Also, it might not matter given that the rw_semaphore part is removed
in the current patch 41/41 anyway...
