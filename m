Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B369A731F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbjFORnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbjFORnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:43:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2F8271E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:42:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9829b12b80fso170869566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686850973; x=1689442973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV291qEfmONYIAqLSJalSFl+ZR8TkYiaH92vMURo0h4=;
        b=bytVMWiI7zabvwzcVr6fjc4GRHdAi1U/4yw6a1CLMzhLX8u6kIB25Tz2ZAmZKKpCFb
         cywkwIOXYBzw3+4OBaKaXjIZXTa7YyJUlaBsr776/UJFxWoWquHTqeEkY2yE1Bdq06lr
         Aig6DnYlKKZn9WdqwYUikng+hlHz0d5sGoR3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850973; x=1689442973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV291qEfmONYIAqLSJalSFl+ZR8TkYiaH92vMURo0h4=;
        b=gf1qO8Ju581i0CIPoCtQy14IFyr4uOCswpHvyXA7AFKRJd+iJWY6uF0DfhMmv/pRri
         E77z47UpinvbVBqXY/+1+kEVcAq9t4j3di9OILf+daBpAarQkdW0pSTbTl36Go41h9I6
         GPgdAYVv27tr/EG/vls4f1/TapHMczbnSYJZbADdcXh9rHKJFuSpl5yAhoEIC9AgAzuD
         ZQVsziciX/ruEt8OUivddYxomirclPCZx21HpuJywU42NN3A608QyzKCJKx7hJ319NfH
         qHK/ktbcaDXmTBb8pDosfi3BrPCWt+hkO8n2wqB2eJl+LWRehYchLwTKjMypIUsM4+IG
         kvyA==
X-Gm-Message-State: AC+VfDyRxva+RAAtx8kS5Fk+ycHQ39Cnj9dbPVKtg+CGnJ4GlsnxDuaA
        9x6WIqad2W1nJuitSfCt1kY1Nw2bnfi+chsfW1cZTJxT
X-Google-Smtp-Source: ACHHUZ4Nkwx38Ed7o6TZnv5ZGbenMhZNKb7TzISwUiG3/kQK6XY10zlpiENvjHIG/xLCtzkk350SCg==
X-Received: by 2002:a17:907:3da0:b0:982:2278:bcef with SMTP id he32-20020a1709073da000b009822278bcefmr11897383ejc.60.1686850973286;
        Thu, 15 Jun 2023 10:42:53 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id dc18-20020a170906c7d200b0096ace7ae086sm9720596ejb.174.2023.06.15.10.42.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 10:42:52 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so929a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:42:51 -0700 (PDT)
X-Received: by 2002:a50:9fc4:0:b0:519:6a72:aeea with SMTP id
 c62-20020a509fc4000000b005196a72aeeamr138284edf.7.1686850970853; Thu, 15 Jun
 2023 10:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230614165904.1.I279773c37e2c1ed8fbb622ca6d1397aea0023526@changeid>
 <36565295-ebaa-2a66-3389-ba5eb714ab34@arm.com>
In-Reply-To: <36565295-ebaa-2a66-3389-ba5eb714ab34@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Jun 2023 10:42:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7HXYRJ7RUeVH0hQ7KjYtEvNABCi-F4iN_wRO6uuC34w@mail.gmail.com>
Message-ID: <CAD=FV=W7HXYRJ7RUeVH0hQ7KjYtEvNABCi-F4iN_wRO6uuC34w@mail.gmail.com>
Subject: Re: [PATCH] Revert "Revert "Revert "arm64: dma: Drop cache
 invalidation from arch_dma_prep_coherent()"""
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, andersson@kernel.org,
        amit.pundir@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sumit.semwal@linaro.org, Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 15, 2023 at 3:13=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-06-15 00:59, Douglas Anderson wrote:
> > This reverts commit 7bd6680b47fa4cd53ee1047693c09825e212a6f5.
> >
> > When booting a sc7180-trogdor based device on mainline, I see errors
> > that look like this:
> >
> >   qcom_scm firmware:scm: Assign memory protection call failed -22
> >   qcom_rmtfs_mem 94600000.memory: assign memory failed
> >   qcom_rmtfs_mem: probe of 94600000.memory failed with error -22
> >
> > The device still boots OK, but WiFi doesn't work.
> >
> > The failure only seems to happen when
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy. When I don't have that set then
> > everything is peachy. Presumably something about the extra
> > initialization disagrees with the change to drop cache invalidation.
>
> AFAICS init_on_alloc essentially just adds __GFP_ZERO to the page
> allocation.

Right, but it does so without `__GFP_ZERO` getting into the page
flags. That means that this removal of "__GFP_ZERO" in
dma_direct_alloc() doesn't actually remove the zeroing when
CONFIG_INIT_ON_ALLOC_DEFAULT_ON IS USED:

  /* we always manually zero the memory once we are done */
  page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);


> This should make no difference to a DMA allocation given
> that dma_alloc_attrs explicitly zeros its allocation anyway. However...
> for the non-coherent case, the DMA API's memset will be done through the
> non-cacheable remap, while __GFP_ZERO can leave behind cached zeros for
> the linear map alias. Thus what I assume must be happening here is that
> "DMA" from the firmware is still making cacheable accesses to the buffer
> and getting those zeros instead of whatever actual data which was
> subsequently written non-cacheably direct to RAM. So either the firmware
> still needs fixing to make non-cacheable accesses, or the SCM driver
> needs to correctly describe it as coherent.

I'm a little confused, but that's pretty normal for me. :-P Looking at
the SCM driver, I see it doing the allocation in qcom_scm_assign_mem()
as:

  dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);

Isn't that the SCM driver describing it as coherent?

I guess the reason that the SCM driver is doing this is that it's
passing a chunk of memory to the firmware but it passes it to firmware
via a _physical_ address, not a virtual one. I guess this makes sense
to do when passing a chunk of memory to firmware since you wouldn't
want to pass the kernel's virtual address there...

Presumably the fact that the firmware gets a physical address means
that the firmware needs to map this address somehow itself. I can try
to dig up what the firmware is doing if needed (what attributes it
uses to map), but I guess the hope is that it shouldn't matter. As
long as the kernel can guarantee that the contents that it needs have
been flushed out to memory then I think we're supposed to be good,
right?

In any case, I dumped a stack crawl to try to show the path where the
init happens, since there are lots of conditionals. I see this:

 kernel_init_pages+0x68/0x6c
 post_alloc_hook+0x40/0x90
 prep_new_page+0x34/0x68
 get_page_from_freelist+0x894/0xe64
 __alloc_pages+0x12c/0xd24
 __dma_direct_alloc_pages+0x9c/0x170
 dma_direct_alloc+0x254/0x4bc
 dma_alloc_attrs+0xe4/0x1e4
 qcom_scm_assign_mem+0xb0/0x258


So looking at dma_direct_alloc(), I guess:

1. We call __dma_direct_alloc_pages() to allocate the page. We try to
turn off __GFP_ZERO but CONFIG_INIT_ON_ALLOC_DEFAULT_ON overrides us.

2. As part of __dma_direct_alloc_pages(), we use the existing
(cachable) mapping of the page and write zeros.

3. The "remap" variable is set for arm64 so we call
arch_dma_prep_coherent(). That used to do a "clean and invalidate" but
now does just a "clean" and that's what broke me.


Talking out of my rear end, I guess the issue here might be that it
_does_ matter how the firmware maps this memory because it has to
match how the kernel has it mapped because if you map the same
physical memory twice then the attributes need to match. Maybe the old
"invalidate" just worked around this issue? If this wild guessing is
correct, maybe a more correct solution would be to simply unmap the
memory from the kernel before passing the physical address to the
firmware, if that's possible...



-Doug
