Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1C5B3CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiIIQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiIIQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:19:28 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51120224
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:19:23 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g5so3382782ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=2KJtyG0OrgeeUZ3tbEzNZEApZJ2MVSJ3tdGvELtllWA=;
        b=Vtzxz/3WnYzehsvxEe5bYGVLVOYdFWrSTvZz1vALAWuaevC3U5WtB+f78lFCZF324w
         FiscSmbXyU+XOB2/F7lOYLYlIX8OuFWYPchdz5uYxmpm9O//MmQsACLWQpqvEvhHp78u
         Fqcicq6ClSVver2X4O9EIw1QxejGbytPeJEB/dU6IAFURZmla+3iGvObrXUwU6kzrvty
         vvKRbbaLhKfEVSQiX5d/rnqzs2MN5BTC2/L2bdEQkmQOw6LxzvEJ4w2N+ZccRlBLFUqE
         QBiGhcqj/PQWmuf5DYdZqpxP0dQ13hOo5+doY9eqgJ0sxS0rfuqgmlMiu7e7iSGtWTIp
         SMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2KJtyG0OrgeeUZ3tbEzNZEApZJ2MVSJ3tdGvELtllWA=;
        b=rKrRU3MtWvDpo3wcA6PLB+0UYF5HvioQBMKPL+Ugq3liI6F7rZM6fuFhGhSBNknc1z
         cU+Qra071DxOwXFBP/YHz1wqBxxLhxLt7J25W1wt5nIaWwEYCttemtQ5fE70+cJattLV
         73UMEd2YMAoCqf20rj61uIK7hyRNcNLcv1GMX6zbY31odeiEdh/TmHdNsa7bdvtcysgN
         n0IeeUTzhice3mGxmOW9ipSJSv1c4scU5x37mZT2XH5O0x/zgODdJu77qtwBpABCcJgp
         X8ELs8Eaky8GUitatV8TxwOsgVpLMhqA3vWvzNqjUBnh/RZyvnLWx8f27n2cJGvzvtpS
         oV8g==
X-Gm-Message-State: ACgBeo335s1zXSuDcrTMc7GigIWSbRbEZVCUFrOS3BoU0KPli6Z7F4yR
        IwH7SlHn3RHjJRl0oxVF/e/RiKE9yb4rC6H3AH+QsQ==
X-Google-Smtp-Source: AA6agR5nRzGlVojCwvyK5XF84Xj8sLR9CtuVgi9z+gwaNZrGge2Gh6ZuqKhqShhWXfC987DrYFOeiSZ3ndHTh5gSVbA=
X-Received: by 2002:a05:6902:2d0:b0:694:d257:4c4b with SMTP id
 w16-20020a05690202d000b00694d2574c4bmr12464223ybh.316.1662740362348; Fri, 09
 Sep 2022 09:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-17-surenb@google.com>
 <acf01185-0b34-0e92-770e-8417f4cc3cf3@linux.ibm.com>
In-Reply-To: <acf01185-0b34-0e92-770e-8417f4cc3cf3@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Sep 2022 09:19:11 -0700
Message-ID: <CAJuCfpHgLSbc-JgQRruTS=A_aQpj5b2bFkdbReFSPY01RXMVgQ@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 16/28] kernel/fork: assert no VMA readers
 during its destruction
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 6:56 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:35, Suren Baghdasaryan a =C3=A9crit :
> > Assert there are no holders of VMA lock for reading when it is about to=
 be
> > destroyed.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h | 8 ++++++++
> >  kernel/fork.c      | 2 ++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index dc72be923e5b..0d9c1563c354 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -676,6 +676,13 @@ static inline void vma_assert_write_locked(struct =
vm_area_struct *vma, int pos)
> >       VM_BUG_ON_VMA(vma->vm_lock_seq !=3D READ_ONCE(vma->vm_mm->mm_lock=
_seq), vma);
> >  }
> >
> > +static inline void vma_assert_no_reader(struct vm_area_struct *vma)
> > +{
> > +     VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock) &&
> > +                   vma->vm_lock_seq !=3D READ_ONCE(vma->vm_mm->mm_lock=
_seq),
> > +                   vma);
> > +}
> > +
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline void vma_init_lock(struct vm_area_struct *vma) {}
> > @@ -685,6 +692,7 @@ static inline bool vma_read_trylock(struct vm_area_=
struct *vma)
> >  static inline void vma_read_unlock(struct vm_area_struct *vma) {}
> >  static inline void vma_assert_locked(struct vm_area_struct *vma) {}
> >  static inline void vma_assert_write_locked(struct vm_area_struct *vma,=
 int pos) {}
> > +static inline void vma_assert_no_reader(struct vm_area_struct *vma) {}
> >
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 1872ad549fed..b443ba3a247a 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -487,6 +487,8 @@ static void __vm_area_free(struct rcu_head *head)
> >  {
> >       struct vm_area_struct *vma =3D container_of(head, struct vm_area_=
struct,
> >                                                 vm_rcu);
> > +     /* The vma should either have no lock holders or be write-locked.=
 */
> > +     vma_assert_no_reader(vma);
>
> I'm wondering if this can be hit in the case the thread freeing a VMA is
> preempted before incrementing the mm ref count, like this:
>
> VMA is about to be freed
> write lock VMA
> free vma -> call_rcu
> ..
> <--- thread preempted
>         rcu handler runs
>         rcu calls __vm_area_free() <<<<<<

At this point the VMA is still write-locked (mm seq count hasn't been
incremented yet), correct? If so then vma_assert_no_reader() will not
assert because the second condition of VMA being write-locked is
satisfied. Did I miss anything?

> unlock mmap_lock and increase the mm seq count
>
>
> >       kmem_cache_free(vm_area_cachep, vma);
> >  }
> >  #endif
>
