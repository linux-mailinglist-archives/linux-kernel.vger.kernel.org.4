Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEA867264F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjARSIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjARSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:07:32 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0158B47E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:06:50 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4c24993965eso473195327b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DP2jTh2XCGgairHOGKy1hg7eoz80OguUV+dRLV5vdAs=;
        b=JiA4PBg0EH7+0/76J3FenR1bnlSGaQgdYOG4b+AglPSOYgfmCcBfM2ErnvDHL4NFM3
         xzqZTQIqEjQ7PPX+1LzBhtUDNEk3yB9vFIDmaQSEgWuFp+80LEAWhkoKhNjeIyguxfi9
         IcVLilDvjfgehE8DgUarM2edSxsBEPquLtlfDaMXkql9MVVejNVEQ1MrjYhWtOtK9eyN
         NSxlm5igyPDlNkDxm+4IwWYaT5nE1kzWmkwzXV4INsZk1EToceOcNYpFDzz/xRE0hSNF
         M6yMgEvu9cHqWkl44Z252S3wbtzdKexOyOHGlp1AVXAzplYZutMDn1Cqdg5ZcfOCxrOc
         +ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DP2jTh2XCGgairHOGKy1hg7eoz80OguUV+dRLV5vdAs=;
        b=PwIxLv/2ux6BD7cAsEEsxjawoBA9lirfsK0L2Mw88LXBeuIZeCLDjvFrw8hoxAmkWg
         n3Qg49j5XdnqB19J5QkpeIQsT1GzGyLf2cgKIGS5u9qYViwWFrZE+mZ5QQp2eXbTAlyA
         4vQJp8ly98OGiNpMoGrf+AwttGl3IY0qU4bCYEphtABY5MTXg8Jzi6/1ZLJqB9Uz4pjU
         J/j/Tx9BNhPxVSwFHXYus32VhixQ97ykDJe3qSdUQppAtPwzAvF+fUlH2pf1Rki1EAib
         HOc/nydEopMfRmj7540YlWFXrKeESF9zgxf/rw/Q7wkT1jHkY+3JVJJbOfm8MICvDBjJ
         O2wQ==
X-Gm-Message-State: AFqh2kp1hJMShBihvdzSTHDrdZuS9VBgn50AkLYmbW9VNJNgUQynTySd
        ffrU7FJEHSzgq3sBHb7Ke3HJaAgtsl/+0jJ9CMjdmw==
X-Google-Smtp-Source: AMrXdXsZwoic0rKFMDYo0tkFJ6J1kb0TvUIjw3JJelHbDs2OjFUo53z0pnyKmSUsdBlmQsDCtwccF60TcE0BtbKLEzo=
X-Received: by 2002:a0d:d484:0:b0:4dc:4113:f224 with SMTP id
 w126-20020a0dd484000000b004dc4113f224mr1111332ywd.455.1674065209076; Wed, 18
 Jan 2023 10:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-27-surenb@google.com>
 <Y8bB3TFLQV2HJZQ+@dhcp22.suse.cz> <CAJuCfpH8-wNiPXQcS=0j-Ex7iMqoBkUhjSN8QiAvq6FdXudRGQ@mail.gmail.com>
 <Y8e/N1m+YGFmxy+L@dhcp22.suse.cz>
In-Reply-To: <Y8e/N1m+YGFmxy+L@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 10:06:38 -0800
Message-ID: <CAJuCfpEcQZSJMoeNyeFb=0xxCFS=bWWz6K6QPkYKTc=4nLLDVw@mail.gmail.com>
Subject: Re: [PATCH 26/41] kernel/fork: assert no VMA readers during its destruction
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

On Wed, Jan 18, 2023 at 1:43 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Tue 17-01-23 17:53:00, Suren Baghdasaryan wrote:
> > On Tue, Jan 17, 2023 at 7:42 AM 'Michal Hocko' via kernel-team
> > <kernel-team@android.com> wrote:
> > >
> > > On Mon 09-01-23 12:53:21, Suren Baghdasaryan wrote:
> > > > Assert there are no holders of VMA lock for reading when it is about to be
> > > > destroyed.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  include/linux/mm.h | 8 ++++++++
> > > >  kernel/fork.c      | 2 ++
> > > >  2 files changed, 10 insertions(+)
> > > >
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index 594e835bad9c..c464fc8a514c 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -680,6 +680,13 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > > >       VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
> > > >  }
> > > >
> > > > +static inline void vma_assert_no_reader(struct vm_area_struct *vma)
> > > > +{
> > > > +     VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock) &&
> > > > +                   vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq),
> > > > +                   vma);
> > >
> > > Do we really need to check for vm_lock_seq? rwsem_is_locked should tell
> > > us something is wrong on its own, no? This could be somebody racing with
> > > the vma destruction and using the write lock. Unlikely but I do not see
> > > why to narrow debugging scope.
> >
> > I wanted to ensure there are no page fault handlers (read-lockers)
> > when we are destroying the VMA and rwsem_is_locked(&vma->lock) alone
> > could trigger if someone is concurrently calling vma_write_lock(). But
> > I don't think we expect someone to be write-locking the VMA while we
>
> That would be UAF, no?

Yes. That's why what I have is an overkill (which is also racy).

>
> > are destroying it, so you are right, I'm overcomplicating things here.
> > I think I can get rid of vma_assert_no_reader() and add
> > VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock)) directly in
> > __vm_area_free(). WDYT?
>
> Yes, that adds some debugging. Not sure it is really necessary buyt it
> is VM_BUG_ON so why not.

I would like to keep it if possible. If it triggers that would be a
clear signal what the issue is. Otherwise it might be hard to debug
such a corner case.

> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
