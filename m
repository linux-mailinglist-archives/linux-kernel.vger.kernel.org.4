Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63DA6FEA58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 05:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjEKDxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 23:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKDxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 23:53:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5AF420B
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:53:18 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f396606ab0so664621cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683777197; x=1686369197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEnFZ3b0l12xZ9FfK/rY8jy10P1V5kN/l6JT2CZl8wg=;
        b=eMsesteKW69BSCBVof2zFprojUKDL2/ZGa1ZFGQYSYWINh/VOYm8xRNe+k+zQ0+Sk3
         n/FQkyqbJoBEbyoiibKrIFZ83W55ZTK/FoBXyUsoEQPiZaFw+599Z5cO0uvJWUtIWbMq
         p+gplDuXblN3txvyhOcg3jZrtgCxu5OL8F3QzRGNBSjh4eY4xmFdyu7rDHLbrNNFey7h
         sNL2ze8LvfqLqHHp38TpLwaTWPGXcg+W92WG8nJeCWHjWC0Ub5XfoVrnsC7pJL5QwqEs
         2/VqEH4IQ/fbNqewJ5a8KqxZYptTlvaEj4ljj1bH4F5bFSLqkm1B1/i56MGE172yJLl7
         LN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683777197; x=1686369197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEnFZ3b0l12xZ9FfK/rY8jy10P1V5kN/l6JT2CZl8wg=;
        b=WWaXxUi26SC4K/q1RRbiEDDH0/BAvLhby2HYk1Mmf7yhyyDy5rdvsHk8VWisd/H9V9
         zFdgCv1QD/rpf/HG1f2kW640GTGVS5b7LcMKb56bMBHcRGKWmWTdQSTZn4BwBaXwNeXK
         z/6OhYMo+vyTUqaVif4jTPwmJQ6u7bU8mtFvVW0IMZT3HyNL1CFUCn4krUFuL03kV5O3
         yoBoarPAzOXbfXTqDHws99hZbQXqCYl9HP0meHylsz9qWRthEXxNhRkTVZLg3be9J/tW
         9+JwMDWj1FaRLSDOyOZ9rPUaqgzDk9/J8Dr+c9++PJjOLcwdFtYNX30IvmaQacU9l02j
         umEA==
X-Gm-Message-State: AC+VfDxm2GII363FNkjw52APmZbda1Sw1QOMnxSPXnkxG/3fNtaBU8v/
        2JJBleBASufPnPKY1R3xG3VffxfrnSnAd374JhjGYw==
X-Google-Smtp-Source: ACHHUZ4aXC7oLv7s1rlgGpxqbUu6FGKhMrhFOJ8UUisecFOJ7K52Sa/Z8JCdD18AUJQ8fXOEpXogV1OOTdEYMV7AX1w=
X-Received: by 2002:ac8:7d4a:0:b0:3ef:a55:7f39 with SMTP id
 h10-20020ac87d4a000000b003ef0a557f39mr269916qtb.12.1683777197246; Wed, 10 May
 2023 20:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com> <ZFwIWz8kBL+bti1m@nvidia.com>
In-Reply-To: <ZFwIWz8kBL+bti1m@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 11 May 2023 11:52:41 +0800
Message-ID: <CAKHBV26rbPXr6QUAx1MSbX58Zr4B7iLhojOgfn9c0tc1wKaP+w@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add PASID support to SMMUv3 unmanaged domains
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

> Logically when an iommu_domain is attached to a device or a PASID a
> STE or CD is generated from the iommu_domain's configuration but the
> iommu_domain doesn't "hold" it
>

Ah yes, I was using iommu domain and arm_smmu_domain interchangeably
here since there's a 1:1 mapping between the two. In the current
smmuv3 implementation, arm_smmu_domain holds the s1cfg structure which
represents the s1 portion of an STE.

> I always thought of this as sort of a pre-calculation of the STE, that
> gets cached in the iommu_domain? Not sure the pre-calculation is that
> valuable though..

I think we can consider the case where an iommu domain is attached to
multiple masters as a form of pre-calculation and resource sharing.
When attaching an iommu domain that has been attached before, its
arm_smmu_domain contains an already finalized STE configuration that
can be immediately written to the smmu. I don't think there's anything
specific to SVA about this behavior however, SVA will do the same
amount of work whether the cd table is owned by some special iommu
domain or by the arm_smmu_master (since we require that special iommu
domain be attached to the master and disallow detaching it).

> Ideally the iommu_domain should only hold a pointer to some table
top. Depending on the domain type this would be a S1 IOPTE table, S2
IOPTE table or a CD table. Plus the non-table domains like IDENTITY
and blocked.

Gotcha. So this patch series should be less aggressive, but is
probably still workable with the nested domain patch series:
1. For (stage 1) unmanaged/dma and sva domains, arm_smmu_domains
should hold a single CD. For the nested domain series, arm_smmu_domain
can alternatively hold an entire s1cfg.
2. arm_smmu_master should own an s1cfg (which holds a cdtable) that is
used by unmanaged/dma and sva domains attached to this master.
3. arm_smmu_master also holds a pointer to the live s1cfg, which may
either points to its owned s1cfg, or the nested domain's s1cfg, or
null (bypass or stage2)







> > path forward for set_dev_pasid support? Or could a uAPI that only
> > exposes a single CD instead of the entire STE be an appropriate fit for
> > the nesting use cases?
>
> The uAPI is to create an iommu_domain that holds a CD Table Top
> located in user memory, it cannot deviate from this. These kinds of
> iommu_domain's can only be pointed at by STEs.
>
> Again it doesnt really "hold" the STE, but we can compute a STE that
> points to the SD Table that it does hold.
>
> Other than this, it is good to take this project on, getting PASID
> support aligned with the new API is something that needs to be done
> here!
>
> Thanks,
> Jason
