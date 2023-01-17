Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDA966E660
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjAQSqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjAQSk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:40:27 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA5B2B601
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:12:03 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n85so7625002iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dcrz3u05liU0MW9kY4AJIlBTNw63wTKDLbyoxh2Gq7o=;
        b=LOjmK81sP9RZFAMR4E8fCCpKxP67Nz6qc4uKkLVPkpHjSZ0SakfGstIAUpYIpSI07l
         aiQ3xDCMFAyArWyIbdn9MV2vFoK0FOFT9fpzj3uJjiQuKN+gHMlFt9Sz0VcR5i+Bzwe3
         Kx6DzAEpRZ+6HJ/hEuT2a0SqHWa/T36LxiDrEewq7V3aM5yNWU4iXZYCAoNVQkEY7sdw
         6eQQ9GO4uGLBoOuC/ENtRzBdFIOLybzL/F0OeALa9dyEoJtEvEBKcNkVp1GqE5OEw78i
         QradsZza/j1i5r7w3V7jkhtJPrbMQH+Z5nrzIVonts+Wo9joxZLWOtKfFMNC3Ueb23YO
         utyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcrz3u05liU0MW9kY4AJIlBTNw63wTKDLbyoxh2Gq7o=;
        b=YfOGBOETyZrYfnHNdXlaB7z1UpAk2qkBos1dwHFYxX1WKz+1j1+dMEVGaSqx63X4W/
         pGdlW+5exopb0epn5wLvbffhzEp9kFtsJeF8zd3Bnd+jPYsLX9ZjAN2PoMjFp0WtiubX
         V4J9LX1RSoCw9exXzzOjrSL0a5YQ4LjpYuOk9yFJhmwhYOLz6jC/1SahTY1R8rSrGlxL
         gl4SkGnQDsvTRvTL2pLZlHr5GQmKcK1h9iYyU5d+7tl4hzVKVOesDx2flBR26weD7pZE
         2hikjD4f6TxIipUHaYAXHtsoiv6+oQU0TEkjOL1J0fytzhWXyauEUmiXIocewcVnH4eI
         ozsA==
X-Gm-Message-State: AFqh2kqHRisDG3v4shRb1GZ72nY8G88u/vKWNbTf/ecyOwQIcsOJIBYZ
        QCFPR8wyoZK6TIZ5Ln8e1tCUDbm6RfpIFf2ex+DtUA==
X-Google-Smtp-Source: AMrXdXsgW7Mw7qSRUXKXfN+rdxMVcw5NgXHaFtzV+np+Si6HoBmXxOeDmNDFe8VfWaSsmByezu+xjIBOp9/ez1+o9/0=
X-Received: by 2002:a02:c884:0:b0:39e:9d33:a47 with SMTP id
 m4-20020a02c884000000b0039e9d330a47mr264435jao.58.1673979122352; Tue, 17 Jan
 2023 10:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
In-Reply-To: <20230109205336.3665937-42-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 19:11:26 +0100
Message-ID: <CAG48ez3ZNt+B3XvAMP1OaeEYuwpXJ1epmT9YtNonFLEJ6yANVQ@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
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
> rw_semaphore is a sizable structure of 40 bytes and consumes
> considerable space for each vm_area_struct. However vma_lock has
> two important specifics which can be used to replace rw_semaphore
> with a simpler structure:
[...]
>  static inline void vma_read_unlock(struct vm_area_struct *vma)
>  {
> -       up_read(&vma->vm_lock->lock);
> +       if (atomic_dec_and_test(&vma->vm_lock->count))
> +               wake_up(&vma->vm_mm->vma_writer_wait);
>  }

I haven't properly reviewed this, but this bit looks like a
use-after-free because you're accessing the vma after dropping your
reference on it. You'd have to first look up the vma->vm_mm, then do
the atomic_dec_and_test(), and afterwards do the wake_up() without
touching the vma. Or alternatively wrap the whole thing in an RCU
read-side critical section if the VMA is freed with RCU delay.
