Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2EB5EED09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiI2FHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiI2FHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:07:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73715E5FB2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 22:07:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MdLvZ196nz4xGh;
        Thu, 29 Sep 2022 15:07:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1664428044;
        bh=LNJLwf4icNuP92vlonmeVOhbmhMWAvb1KZSRpI5pNFE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RmmwtB+Lq8bjkFuvWqmHzVzaEXURluSYEX7ndiVyuWqzynjHwOkXEd7d55TdcPdR3
         AKsLc+bQH8LwodnZNM/TXhnavHNQdaIehmVr9TluOfPyWQZui7tDuKbQsH01FhSC8V
         wr1p2UI1BPVSJA0f/V9l1JzFzgT04uDvRNZ3B9hv9k4fxW8theuwzRQdlgNILubYhq
         ZK/ymFMP+bM4hv0Q2p4PRL+P9isFHyJhX6hL74EqHJrJiR4ExrEOSFWffFokEb+amQ
         C7cL/kWRJkajfUPucTviskOUV95IRNe3nZ8ugIFg3iEXJ1+raAUC75VfQfduJLiaJD
         XlroTz/ZLvaTw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alex Sierra <alex.sierra@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] mm/memory.c: Fix race when faulting a device
 private page
In-Reply-To: <875yh7osye.fsf@nvdebian.thelocal>
References: <cover.f15b25597fc3afd45b144df863eeca3b2c13f9f4.1664171943.git-series.apopple@nvidia.com>
 <af2ea89799b08e0a5e592df0da0dcb9a5bf8533b.1664171943.git-series.apopple@nvidia.com>
 <87fsgbf3gh.fsf@mpe.ellerman.id.au> <875yh7osye.fsf@nvdebian.thelocal>
Date:   Thu, 29 Sep 2022 15:07:17 +1000
Message-ID: <87bkqyg456.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Alistair Popple <apopple@nvidia.com> writes:
>>> When the CPU tries to access a device private page the migrate_to_ram()
>>> callback associated with the pgmap for the page is called. However no
>>> reference is taken on the faulting page. Therefore a concurrent
>>> migration of the device private page can free the page and possibly the
>>> underlying pgmap. This results in a race which can crash the kernel due
>>> to the migrate_to_ram() function pointer becoming invalid. It also means
>>> drivers can't reliably read the zone_device_data field because the page
>>> may have been freed with memunmap_pages().
>>>
>>> Close the race by getting a reference on the page while holding the ptl
>>> to ensure it has not been freed. Unfortunately the elevated reference
>>> count will cause the migration required to handle the fault to fail. To
>>> avoid this failure pass the faulting page into the migrate_vma functions
>>> so that if an elevated reference count is found it can be checked to see
>>> if it's expected or not.
>>>
>>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>>> ---
>>>  arch/powerpc/kvm/book3s_hv_uvmem.c       | 15 ++++++-----
>>>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 +++++++------
>>>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |  2 +-
>>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 11 +++++---
>>>  include/linux/migrate.h                  |  8 ++++++-
>>>  lib/test_hmm.c                           |  7 ++---
>>>  mm/memory.c                              | 16 +++++++++++-
>>>  mm/migrate.c                             | 34 ++++++++++++++-----------
>>>  mm/migrate_device.c                      | 18 +++++++++----
>>>  9 files changed, 87 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
>>> index 5980063..d4eacf4 100644
>>> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
>>> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
>>> @@ -508,10 +508,10 @@ unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
...
>>> @@ -994,7 +997,7 @@ static vm_fault_t kvmppc_uvmem_migrate_to_ram(struct vm_fault *vmf)
>>>
>>>  	if (kvmppc_svm_page_out(vmf->vma, vmf->address,
>>>  				vmf->address + PAGE_SIZE, PAGE_SHIFT,
>>> -				pvt->kvm, pvt->gpa))
>>> +				pvt->kvm, pvt->gpa, vmf->page))
>>>  		return VM_FAULT_SIGBUS;
>>>  	else
>>>  		return 0;
>>
>> I don't have a UV test system, but as-is it doesn't even compile :)
>
> Ugh, thanks. I did get as far as installing a PPC cross-compiler and
> building a kernel. Apparently I did not get as far as enabling
> CONFIG_PPC_UV :)

No worries, that's really on us. If we're going to keep the code in the
tree then it should really be enabled in at least one of our defconfigs.

cheers
