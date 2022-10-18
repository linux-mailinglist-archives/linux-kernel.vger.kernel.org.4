Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7FD603551
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJRV6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJRV6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDBBB56F8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666130281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r4dmGN2ClYG8b9hKGjnfBlOmjS2ytfWR3jFMVVszIM0=;
        b=bkbQ17WaFM3LKiF/iNS89FKSi6N86QKO+yZ2G6Mvcs138kBOySWwzMnUs1Uin9qgRXv/iF
        JSkrGs7QcTzQakUUx4c6hpN+J/TLFky7gmhYioKJJsJouODvGxSaOZDfttsKJHfTtS0Wn5
        9+fh1vCuZv94dihlyxLFfEU87rlCdT0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-KThcux_3MVSTD03k9G0qKg-1; Tue, 18 Oct 2022 17:57:59 -0400
X-MC-Unique: KThcux_3MVSTD03k9G0qKg-1
Received: by mail-il1-f200.google.com with SMTP id d6-20020a056e02214600b002fa23a188ebso13593915ilv.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4dmGN2ClYG8b9hKGjnfBlOmjS2ytfWR3jFMVVszIM0=;
        b=DfFh9VkKE2i3d5KhfvCfR7TW+x+SkuaA0NdI3yWG6nrruVHRWZ2i+sqDFQJEpA1XoO
         w8DoKoOZ61R9zXwY1VLru1Q9te5rpp0gSbkWnBzqY1w1lk/Mi5vVpmva9SD/wrddqs1A
         LEe3ivZpD7bQBNWMvKdbkMOpUlx231lw8nFIgaP3J54Bp1MJC7igowvxW9s/flkuHgK0
         VooeFcvSIcl5VodkysnKOIl+9BY4H26u1/yBRQuwxuCLzaqb1yKQ+ZgTODTqSa2BYUE2
         0Qz4mFD8R+t1m3ukEFSL6Gdmx4INtOuoYvgCAabp04F3qrsqA/aih+0hHsup6kVg+SCQ
         fNag==
X-Gm-Message-State: ACrzQf2ul8q9HQ0aLwQcG5fpnX3VQY6+864eNqDlKekF3wFGM3lQeiKV
        mkw5D3V5pC8/56gieg1KXizFjQ2+AZfLZrPtYob9INNPyjC+DcrC5bQnn1uyfrrFRwk16sl3Zye
        VYy/sJqmNnTihmF79Q/xgzE9J
X-Received: by 2002:a05:6e02:16c8:b0:2fa:d5f4:e9cb with SMTP id 8-20020a056e0216c800b002fad5f4e9cbmr3265927ilx.108.1666130279233;
        Tue, 18 Oct 2022 14:57:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sxQp2rOy4BFy7AIHM7b9ZbzGpb8deVvbnULkqR7SItJ/yiO005oP58/68D6+gf6/YlFZvkA==
X-Received: by 2002:a05:6e02:16c8:b0:2fa:d5f4:e9cb with SMTP id 8-20020a056e0216c800b002fad5f4e9cbmr3265908ilx.108.1666130278972;
        Tue, 18 Oct 2022 14:57:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id e9-20020a028609000000b003636cb862d0sm1477855jai.42.2022.10.18.14.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 14:57:58 -0700 (PDT)
Date:   Tue, 18 Oct 2022 15:57:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/vt-d: Fix lockdep splat in intel_iommu_init()
Message-ID: <20221018155756.55095893.alex.williamson@redhat.com>
In-Reply-To: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
References: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 13:31:07 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi folks,
> 
> As commit c919739ce472 ("iommu/vt-d: Handle race between registration
> and device probe") highlights, a lockdep splat issue happens after
> moving iommu probing device process into iommu_device_register().
> 
> This is due to a conflict that get_resv_regions wants hold the
> dmar_global_lock, but it's also possible to be called from within a
> section where intel_iommu_init() already holds the lock.
> 
> Historically, before commit 5f64ce5411b46 ("iommu/vt-d: Duplicate
> iommu_resv_region objects per device list"), the rcu_lock is used in
> get_resv_regions. This commit converted it to dmar_global_lock in order
> to allowing sleeping in iommu_alloc_resv_region().
> 
> This aims to fix the lockdep issue by making iommu_alloc_resv_region()
> available in critical section and rolling dmar_global_lock back to rcu
> lock in get_resv_regions of the Intel IOMMU driver.
> 
> Best regards,
> baolu
> 
> Lu Baolu (2):
>   iommu: Add gfp parameter to iommu_alloc_resv_region
>   iommu/vt-d: Use rcu_lock in get_resv_regions
> 
>  include/linux/iommu.h                       |  2 +-
>  drivers/acpi/arm64/iort.c                   |  3 ++-
>  drivers/iommu/amd/iommu.c                   |  7 ++++---
>  drivers/iommu/apple-dart.c                  |  2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
>  drivers/iommu/intel/iommu.c                 | 12 +++++++-----
>  drivers/iommu/iommu.c                       |  7 ++++---
>  drivers/iommu/mtk_iommu.c                   |  3 ++-
>  drivers/iommu/virtio-iommu.c                |  9 ++++++---
>  10 files changed, 29 insertions(+), 20 deletions(-)

Resolves the regression for me.  Hopefully Joerg will queue this for
6.1-rc.  Thanks!

Tested-by: Alex Williamson <alex.williamson@redhat.com>

