Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF86FAFB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjEHMMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjEHMMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:12:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2239635B2C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:12:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6434e263962so3279870b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683547925; x=1686139925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e1jUGaTBuNemN6uR6TzC1pUueo581jEXtXPySa7NMk=;
        b=a5c1jTDDG5gv2r5BBUQRnVvCFTpLr78LkyhWbqWezobYgPQtmncW1NSYe9RDkaKjeJ
         jQQoduKka11DdJ9uONFmhl+ira9CIEpODEmbOJtZFGp2hozcKavCHxdZj2haJ9vMbnAh
         GyuFNfwN/2NWUM7Qe3m3LsFTQqhBIYDuz9usA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683547925; x=1686139925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e1jUGaTBuNemN6uR6TzC1pUueo581jEXtXPySa7NMk=;
        b=YEMJmS0SHfrAojswDdXJVZxn0Usoi/Vxk+gqRI+gJZxBJGRYl+LugfLpTvDkEb2Al/
         qyrHsFL9G/xa6ozC2+PwjjGOhx1Y8nprWGdsX8JXWMFA50AZZxEbndQpHAvfMtxdtHVK
         mEKANlAq6Gv2CDv2pBEEoNI2EQLOwKVhNZ8p/u2UPvJAiU4/iCM7A85xrac2j4Lap0TY
         KvyKClMeSrWzqyPjBXKt5Gg7tflQq9Zes0WDXaTT+two06yQItjhgG1ywX7cgi8ohBfC
         +kLBmIiWXH25QV7WG/Skq2uX2ePdp8gcrxJfOIILm4uQg3e84aoJfHWT0RjdvjULDHms
         JBbA==
X-Gm-Message-State: AC+VfDyTJCDIdFm3sUnqLTm3nveGNN635oTTEEta8jayXO3kgRsAyTph
        v1C5B49a+THL/nv1RCAjFcSuKl8ptIqwkXawbREFvQ==
X-Google-Smtp-Source: ACHHUZ7TBiJ/msXleYpLRRPvIC1oV6IgOG3qi1a+0OGSs6T0pyQ4avGRXWbvRbzC2K8iwZm2pVAOHPpHx+cjCDE+ouc=
X-Received: by 2002:a05:6a00:180f:b0:645:d02d:9a83 with SMTP id
 y15-20020a056a00180f00b00645d02d9a83mr4581132pfa.17.1683547925407; Mon, 08
 May 2023 05:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230504170942.822147-1-revest@chromium.org> <20230504170942.822147-4-revest@chromium.org>
 <ZFVMLQHObyP4Na+j@arm.com>
In-Reply-To: <ZFVMLQHObyP4Na+j@arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 8 May 2023 14:11:54 +0200
Message-ID: <CABRcYmJ+8vUHDamVhRosY-X_m4ecVyahSektRjaxg4n_gG5VXQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 8:34=E2=80=AFPM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Thu, May 04, 2023 at 07:09:41PM +0200, Florent Revest wrote:
> > This extends the current PR_SET_MDWE prctl arg with a bit to indicate
> > that the process doesn't want MDWE protection to propagate to children.
> >
> > To implement this no-inherit mode, the tag in current->mm->flags must b=
e
> > absent from MMF_INIT_MASK. This means that the encoding for "MDWE but
> > without inherit" is different in the prctl than in the mm flags. This
> > leads to a bit of bit-mangling in the prctl implementation.
>
> That bit mangling is not that bad but it complicates the code a bit,
> especially if we'll add new bits in the future. We also need to check
> both the original and the no-inherit bits for each feature.

I agree :)

> Another question is whether we want to support more fine-grained
> inheriting or just a big knob that disables inheriting for all the
> (future) MDWE flags.

Yep, I can't think of a more fine-grained inheritance model off the
top of my head but it would be good to have a sane base for when the
need arises.

> I think a somewhat simpler way would be to clear the flags on fork(),
> either based on a big MMF_HAS_MDWE_NO_INHERIT knob or individual ones.
> Something like below (completely untested):
>
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredum=
p.h
> index 0ee96ea7a0e9..ca83a0c8d19c 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -91,4 +91,12 @@ static inline int get_dumpable(struct mm_struct *mm)
>                                  MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK=
)
>
>  #define MMF_VM_MERGE_ANY       29
> +
> +#define MMF_INIT_FLAGS(flags)  ({                              \
> +       unsigned long new_flags =3D flags;                        \
> +       if (new_flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))       \
> +               new_flags &=3D ~(1UL << MMF_HAS_MDWE_MASK);       \
> +       new_flags & MMF_INIT_MASK;                              \
> +})
> +
>  #endif /* _LINUX_SCHED_COREDUMP_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ed4e01daccaa..53f0b68a5451 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1288,7 +1288,7 @@ static struct mm_struct *mm_init(struct mm_struct *=
mm, struct task_struct *p,
>         hugetlb_count_init(mm);
>
>         if (current->mm) {
> -               mm->flags =3D current->mm->flags & MMF_INIT_MASK;
> +               mm->flags =3D MMF_INIT_FLAGS(current->mm->flags);
>                 mm->def_flags =3D current->mm->def_flags & VM_INIT_DEF_MA=
SK;
>         } else {
>                 mm->flags =3D default_dump_filter;
>
> The checks in MMF_INIT_FLAGS() can grow in time if we add more bits in
> there but we still only keep a single flag that determines whether the
> feature is enabled (maybe that's more like bikeshedding at this moment
> when we have a single bit).

Sounds good!

I had considered something like this but I was afraid I'd spill too
much logic into fork.c... I didn't think of making it a neat macro in
coredump.h. That's a good point, I'll do this in v2.

> (fun remark: I see you cc'ed nd@arm.com'; that's not a real person, it's
> what our IT folk asked us to add on cc so that the Exchange server
> doesn't append the legal disclaimer; most lists are covered already
> without such cc but I guess people feel safer to add it, just in case)

Ahah! I mostly just copied the cc list from Joey's series. I remember
wondering why I couldn't find any patch sent by this mysterious ND but
I thought that if they got such a cool username, surely they must have
been at ARM since the early days and have some important role... :)
Then... mister nd won't get to see my v2! Thanks for the heads up.
