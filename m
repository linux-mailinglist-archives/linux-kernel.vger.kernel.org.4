Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E135A74B7B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjGGUPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGGUPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:15:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E72E7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:15:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bff27026cb0so2564763276.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688760941; x=1691352941;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNpKXy7AFxltKv4uN+DycBwBsGRtWweYUYY9rGhaZYU=;
        b=m/Y0L9N1Ha8XkEN0zuqSzsZykfZT99fJBZExeWA5YQ/ctbMVRfut9kxGleMJksQk93
         o6wKkc+hj1/0cnv+rtL3aHH12HTdv7lsAddD03D1fP/Zd27pcAGefrAUIK9ULJ5nhadZ
         fbcHvPuLUNOhWf7sm4V7F7NV1H5bu1QKHFEXRtVe1OdvCdAllaXuY+TLC8y2DRklYDCV
         a6vOKyBqh8YtbwI7jGEtnGb4Y20188PzEDc9VICkPg+RWoLgRI5xll2xMyZ+4eXgxmaI
         zbzejy+1xTNhSJd9FTUkJtxxmsaoUXbuH5M9w264gh/7Y9oeN3RAPziorzkhHh6oPv4Q
         MuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688760941; x=1691352941;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNpKXy7AFxltKv4uN+DycBwBsGRtWweYUYY9rGhaZYU=;
        b=TPEBWW3sQ7ZHOmRRDeN4aLYy/vWmf+V52hNkppUBRV9MskxUXXV4isWrQoTUyOWiDH
         1dgRUFhv9RmLDNPml1vhNifg101hZyf+awmygRNe0qe9dsr4T3vv5ptNnLqUpd2vecWT
         28NNYw4WiqBAOAXQe54oWVtuBXdUf/VvB12xMQvqd4aoJGhc3apJugARjSCi1Yv4kS2e
         g1P+kwq3hWlaI1hmQMmbbk2ZALff0NV593UIYaQ3DMSS9Q7KlC1cAQRHeBsjjyrpjCVA
         ql0TdQheUPDP4eLKIKvxuooobvQoPDH5h9qtgDh0zfp0A5wopmLH0aejE42Ux2AFlCmu
         unwQ==
X-Gm-Message-State: ABy/qLZ4PA7y4wxgvF6zeQEbue8z/aD1UCb4s7DczGy1X6yi78z8HIMa
        oUxKfyhOaDEJoq6Dg0srUAgkTTxzM2m93InGdM9wEQ==
X-Google-Smtp-Source: APBJJlGElQexIBo1pPYN0IUfTDXFWBoRHXjH/BQWjQv2+HNUlfs2N/wgEwulUlEQU1dbMhD/xF1TMFid9Dd0E7oqp5Y=
X-Received: by 2002:a25:69c6:0:b0:c15:cfc4:45a8 with SMTP id
 e189-20020a2569c6000000b00c15cfc445a8mr5942453ybc.34.1688760940826; Fri, 07
 Jul 2023 13:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230707043211.3682710-1-surenb@google.com> <20230707043211.3682710-2-surenb@google.com>
 <20230707194829.u3p5zfjckmh6lktx@revolver>
In-Reply-To: <20230707194829.u3p5zfjckmh6lktx@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Jul 2023 13:15:29 -0700
Message-ID: <CAJuCfpEfhwU3hP+tWi=tpRGm2k6hyV7139oh1CH_E6v331wbeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: lock newly mapped VMA which can be modified after
 it becomes visible
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, ldufour@linux.ibm.com, hughd@google.com,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        rientjes@google.com, axelrasmussen@google.com, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 7:48=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [230707 00:32]:
> > mmap_region adds a newly created VMA into VMA tree and might modify it
> > afterwards before dropping the mmap_lock. This poses a problem for page
> > faults handled under per-VMA locks because they don't take the mmap_loc=
k
> > and can stumble on this VMA while it's still being modified. Currently
> > this does not pose a problem since post-addition modifications are done
> > only for file-backed VMAs, which are not handled under per-VMA lock.
> > However, once support for handling file-backed page faults with per-VMA
> > locks is added, this will become a race.
> > Fix this by write-locking the VMA before inserting it into the VMA tree=
.
> > Other places where a new VMA is added into VMA tree do not modify it
> > after the insertion, so do not need the same locking.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index c66e4622a557..84c71431a527 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2812,6 +2812,8 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
> >       if (vma->vm_file)
> >               i_mmap_lock_write(vma->vm_file->f_mapping);
> >
> > +     /* Lock the VMA since it is modified after insertion into VMA tre=
e */
>
> So it is modified, but that i_mmap_lock_write() directly above this
> comment is potentially moving below the insert and that is why this lock
> is needed.

Correct, we should not rely on i_mmap_lock_write() which can be moved
(and is suggested to be moved in
https://lore.kernel.org/all/20230606124939.93561-1-yu.ma@intel.com/).


>
> > +     vma_start_write(vma);
> >       vma_iter_store(&vmi, vma);
> >       mm->map_count++;
> >       if (vma->vm_file) {
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
