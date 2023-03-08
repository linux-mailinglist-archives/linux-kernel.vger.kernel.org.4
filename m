Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7C6B14E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCHWRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCHWRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:17:31 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189888DAF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:17:28 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-53d277c1834so155286707b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678313847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncfhrCpS1P9fhc/2j13MHGSrZrNoZGtzGt6BdpI5u5c=;
        b=LEa9vLflpeuYhw+ouFGy0nRrpxnMvd/qO4xLcFHKClLlgWiXSGJj/wJvU2tdLdzRtM
         8fkaZIpA9v+J+2fxBg8XKmU7PTdFG2+9Y/0h3FKx26VjdjukePTlLmgJ2Xi97jWpzVCI
         7NOkrVTe6b4UtZn4Cr62QRMe/QYRmzU04nn5wCFIKVE187ZcNhyPw0fOh0g/qfYAVa73
         z8P6dAwmz1TOyrlCRpybhkvic3KdtP4rtXtyScazD+bDBVbPSH82MS2A8ZIoOvGekV4c
         /i128BBPalN8uJon1jUJz60cENTPsJsVx8Hxx2vgHMkoJP0oNurUm1EJmLuYjFCef2jT
         exFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncfhrCpS1P9fhc/2j13MHGSrZrNoZGtzGt6BdpI5u5c=;
        b=jolpaX8xIhaPB3WCHwaNuqKIaRD0XmpJiE7rqw0Msdvswa8opLfvLTRAVLe8afJvzc
         YdRrqi1is+YTNJdGtohiTUmx2fHRSKfb17qiATmBqovLmQGE7trxrwPOPyp5y4Hb2Ewg
         NC2gQCmwJKJQ0lMFfiJ1kE+eumx/o0+krN7qd+BPaYeYo/Btc0VQWYNTEk87p8OQrAH2
         3urZRf3yKqWh4ahXqak3UjpxndOChbmb22tosH0/QJ7ZboAZW+fmIj6tC1toGZaObGaz
         aQV7CFunYOJj5VxB/J7JguUcfW1hCHU+bUhDDcA7tVafvqLI6OFvPmlUfReqy1mOTTuX
         Yg6A==
X-Gm-Message-State: AO0yUKWMLEPbmYC42HJJ5NVvE+0Fd+8ldRnb+4mzvD3UKbQ3rYHQNa4e
        FwYjVqM/Q13TYqh2Uhpagep0v65LyRFvcU9tLDeh5g==
X-Google-Smtp-Source: AK7set/jY+wDFdJxlgt4HTSi9tKXekbNF7x9coeeff+Lpjl95jbtsUQQqV8CQjULDHigA8h3T3Lkbv9CrggJ4hcrnz4=
X-Received: by 2002:a81:431e:0:b0:533:8080:16ee with SMTP id
 q30-20020a81431e000000b00533808016eemr12767819ywa.10.1678313847363; Wed, 08
 Mar 2023 14:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com> <20230306224127.1689967-4-vipinsh@google.com>
 <20230308223331.00000234@gmail.com>
In-Reply-To: <20230308223331.00000234@gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 8 Mar 2023 14:16:51 -0800
Message-ID: <CAHVum0cMAwyQamr5yxCB56DSy7QHuCvTG06qRrJCGiZWQV+ZTw@mail.gmail.com>
Subject: Re: [Patch v4 03/18] KVM: x86/mmu: Track count of pages in KVM MMU
 page caches globally
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com, jmattson@google.com, mizhang@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 8, 2023 at 12:33=E2=80=AFPM Zhi Wang <zhi.wang.linux@gmail.com>=
 wrote:
>
> On Mon,  6 Mar 2023 14:41:12 -0800
> Vipin Sharma <vipinsh@google.com> wrote:
> > +/**
> > + * Caller should hold mutex lock corresponding to cache, if available.
> > + */
> > +static int mmu_topup_sp_memory_cache(struct kvm_mmu_memory_cache *cach=
e,
> > +                                  int min)
> > +{
> > +     int orig_nobjs, r;
> > +
> > +     orig_nobjs =3D cache->nobjs;
> > +     r =3D kvm_mmu_topup_memory_cache(cache, min);
> > +     if (orig_nobjs !=3D cache->nobjs)
> > +             percpu_counter_add(&kvm_total_unused_cached_pages,
> > +                                (cache->nobjs - orig_nobjs));
> > +
> > +     return r;
> > +}
> > +
>
> Maybe kvm_mmu_topup_shadow_page_cache() would be better?
>
> As a user of kvm_mmu_topup_memory_cache(), mmu_topup_memory_cache() is no=
t
> supposed to directly touch the kvm_mmu_memory_cache meta data.
>
> The name "mmu_topup_sp_memory_cache()" seems similar with "mmu_topup_memo=
ry_cache()".
> Renaming it would make its level self-documenting.
>

Sounds good. I will rename it.

> > @@ -4396,25 +4438,28 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vc=
pu *vcpu,
> >       if (r !=3D RET_PF_INVALID)
> >               return r;
> >
> > +     mutex_lock(&vcpu->arch.mmu_shadow_page_cache_lock);
>
> Can you elaborate more why this lock is required? When will this lock con=
tend?

This lock is not needed in this patch. In the patch 4 when I am
freeing up the cache in MMU shrinker this lock is used. In an internal
discussion Sean also mentioned it. I will move it to the patch where
it is actually used.

>
> 1) Previously mmu_topup_memory_caches() works fine without a lock.
> 2) IMHO I was suspecting if this lock seems affects the parallelization
> of the TDP MMU fault handling.
>
> TDP MMU fault handling is intend to be optimized for parallelization faul=
t
> handling by taking a read lock and operating the page table via atomic
> operations. Multiple fault handling can enter the TDP MMU fault path
> because of read_lock(&vcpu->kvm->mmu_lock) below.
>
> W/ this lock, it seems the part of benefit of parallelization is gone
> because the lock can contend earlier above. Will this cause performance
> regression?

This is a per vCPU lock, with this lock each vCPU will still be able
to perform parallel fault handling without contending for lock.

>
> If the lock will not contend above, then I am not sure if we need it.
>

Not in this patch, but in patch 4 we will need it when clearing cache
via MMU shrinker. I will move it to the patch where it is actually
needed.
