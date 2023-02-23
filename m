Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D926A01A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjBWD71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWD70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:59:26 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913D25293
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:59:24 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id x14so13010433vso.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677124763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H32nxJKYLFgX94VN5oR58FHUZwCnE+gpSinuTrZzCc0=;
        b=V4Q5l6WLAj/WwxnVZRzvheA/iOME8vS7OMCgLQWsVt/tZ1p+FehahQQjYkfBEwnn5l
         TKqvMJ4ouOnvNtwLpkdvRKTTNQhJdK8GWjwAgSM5gu2EhnU0opER4l31mwe55domXE0w
         Hh/RGdOf2a1K2z7Re8lyE0yCVzCTzILxkZUcQXewKdfJ3nDh+Cx8jTMdJZGQX0pZkZUY
         4CAifutvKd9vpOwllaoBeMHWTAZ8SHL+wtWN3Q2twnpq3HAsmolU0vVpaO0k7gzLbvmc
         s3sDmxNfwKOsOYTnd2jaudx9jqxs70BYLlpqGNm2hwnZxrqrv9nxqoKIAVBvW5yE8AKf
         bHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677124763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H32nxJKYLFgX94VN5oR58FHUZwCnE+gpSinuTrZzCc0=;
        b=E1cvTjY30e3S4sxbmZZ0JCM42HkbIWQg9QEh6qGL/brc4byDFlWT0eRU96iQ4y9aqc
         I2oT0GxqosEcIncjCQNlFBZS1fGjtrBPVG84pKB5zXEwcWUvQ+SmUCRY50afRBZbXZ+z
         4BAiJvnMSE4fDrKC4TWp8N6Bt858eJytsU5dZx7LgwdtUDPjcuTbbUdeEnF+B5zh01iy
         nhLSHuElIReR8LiT6VioM8gI0MU/ALBZ9+5l4bMm98EgpBCzGpIUaLGlXL4mi5dNDVkE
         +7KJ7IAXbIOzoakmTfu+O+sAvZn3h+fP+J1dulZBVVi4OJa4jBuvB6PsZ/GLEhKVa+Ny
         W+jA==
X-Gm-Message-State: AO0yUKU4+KUG+udQs8siAxwMKCg2+bEao+O5SDp5Zs1vpeFTK5DrnDy5
        IVdnicRknDzh+Yp1e04QxUsqJL28Lx7cUAou7sn2FzszkTgoP1UB
X-Google-Smtp-Source: AK7set8d4Kt8nwIvSPEaytrIpcGaTkhsSfI3kbZZEBvM/1NXFxRlVl/iWmVtGErpsTF5b/RMhuHUh6LwD5LpoKFSFjM=
X-Received: by 2002:a1f:aa41:0:b0:412:948:73ff with SMTP id
 t62-20020a1faa41000000b00412094873ffmr143108vke.13.1677124763494; Wed, 22 Feb
 2023 19:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20230217041230.2417228-1-yuzhao@google.com> <20230217041230.2417228-4-yuzhao@google.com>
 <CAOUHufYSx-edDVCZSauOzwOJG6Av0++0TFT4ko8qWq7vLi_mjw@mail.gmail.com> <86lekwy8d7.wl-maz@kernel.org>
In-Reply-To: <86lekwy8d7.wl-maz@kernel.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 22 Feb 2023 20:58:47 -0700
Message-ID: <CAOUHufbbs2gG+DPvSOw_N_Kx7FWdZvpdJUvLzko-BDQ8vfd6Xg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 3/5] kvm/arm64: add kvm_arch_test_clear_young()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-mm@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>
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

On Fri, Feb 17, 2023 at 2:00=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Fri, 17 Feb 2023 04:21:28 +0000,
> Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Thu, Feb 16, 2023 at 9:12 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > This patch adds kvm_arch_test_clear_young() for the vast majority of
> > > VMs that are not pKVM and run on hardware that sets the accessed bit
> > > in KVM page tables.
>
> I'm really interested in how you can back this statement. 90% of the
> HW I have access to is not FEAT_HWAFDB capable, either because it
> predates the feature or because the feature is too buggy to be useful.

This is my expericen too -- most devices are pre v8.2.

> Do you have numbers?

Let's do a quick market survey by segment. The following only applies
to ARM CPUs:

1. Phones: none of the major Android phone vendors sell phones running
VMs; no other major Linux phone vendors.
2. Laptops: only a very limited number of Chromebooks run VMs, namely
ACRVM. No other major Linux laptop vendors.
3. Desktops: no major Linux desktop vendors.
4. Embedded/IoT/Router: no major Linux vendors run VMs (Android Auto
can be a VM guest on QNX host).
5. Cloud: this is where the vast majority VMs come from. Among the
vendors available to the general public, Ampere is the biggest player.
Here [1] is a list of its customers. The A-bit works well even on its
EVT products (Neoverse cores).

[1] https://en.wikipedia.org/wiki/Ampere_Computing

> > > It relies on two techniques, RCU and cmpxchg, to safely test and clea=
r
> > > the accessed bit without taking the MMU lock. The former protects KVM
> > > page tables from being freed while the latter clears the accessed bit
> > > atomically against both the hardware and other software page table
> > > walkers.
> > >
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_host.h       |  7 +++
> > >  arch/arm64/include/asm/kvm_pgtable.h    |  8 +++
> > >  arch/arm64/include/asm/stage2_pgtable.h | 43 ++++++++++++++
> > >  arch/arm64/kvm/arm.c                    |  1 +
> > >  arch/arm64/kvm/hyp/pgtable.c            | 51 ++--------------
> > >  arch/arm64/kvm/mmu.c                    | 77 +++++++++++++++++++++++=
+-
> > >  6 files changed, 141 insertions(+), 46 deletions(-)
> >
> > Adding Marc and Will.
> >
> > Can you please add other interested parties that I've missed?
>
> The MAINTAINERS file has it all:
>
> KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
> M:      Marc Zyngier <maz@kernel.org>
> M:      Oliver Upton <oliver.upton@linux.dev>
> R:      James Morse <james.morse@arm.com>
> R:      Suzuki K Poulose <suzuki.poulose@arm.com>
> R:      Zenghui Yu <yuzenghui@huawei.com>
> L:      kvmarm@lists.linux.dev
>
> May I suggest that you repost your patch and Cc the interested
> parties yourself? I guess most folks will want to see this in context,
> and not as a random, isolated change with no rationale.

This clarified it. Thanks. (I was hesitant to spam people with the
entire series containing changes to other architectures.)
