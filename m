Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DC6FE5B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbjEJUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbjEJUvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:51:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE57A9D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba6386e6f7aso2797595276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683751860; x=1686343860;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0aTcNguqiO/niELSSlE0no2SkBRP8ATZbw67QF2nRQk=;
        b=InN7niDjvzNlMwZgp0X9PCi1hbm0hme3DLwHHM5cbEXnMvmESf+lItvZ2we7PiP1Jd
         iLasW0mWeEsw/7kx+e6+kKCfDxx7N2Hl7BcQmGrR/74N30v/F/dWlu/SF+UaIO8w2XBB
         idN/Ia6wRZOmZs/VXu3MDhsdNVyujZDnTEiue2pDp6fIfpSOieczl3CwyRbg+5BrpkXC
         ySVpOJjpzRVdtPumfPRya4b3kryklFvW/BIEu8ip0n1Dl3pc7L6IdHwgFv2o30B7W5hO
         eN3QoISqVFpr/AJINCNJjcbi6smtzfWkgmXLKHmXoWBpHs4OwLFy4+S8LwoRg/J+1nUA
         nkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751860; x=1686343860;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aTcNguqiO/niELSSlE0no2SkBRP8ATZbw67QF2nRQk=;
        b=gCZH1PfyKx4n6BrNZ5HsRTddU0asifKquHZRC5zQR53JXzHgqZ+Cmn4RvgDBtUdNBN
         9YFb5YoFHzo4zry6/hLxTN7U9YQ91BxeU2G9ZVIdts40AVl692EIMUw5ossWRKaXOCBG
         DIzik5n3K727lrJNgiOQPjzOJYzMx+j5P1s6UaEKTM/vMtBbmHzEFIXhMqcy0kYQE1QY
         uvUQ6GRD4J7qMSucQg59rjeXSP6X/yIQWVkpGC5pNEo30rdNTqUYBceHqDd+DYczBN6A
         gvHynPfPcwwHtXKZHL2BMEIec79iKwAuKWELs4BjJKDH+JNMfhP2x2tSy0Um/DwLNJ9H
         LC9A==
X-Gm-Message-State: AC+VfDzHOg1sTv/pl5Vb4ELuKSFT/qhmag0vQNxEfXxo9d5Tfa5VSAdn
        JqlD1oaLQ3z06gTaJjtL8ikRZZgBI9M7
X-Google-Smtp-Source: ACHHUZ6XDxciOSOZKWEtzReVx1XmwiYfQqL7Y6E0xduItNMYMJ6iVpUbs7uRnvW/l+NA/wzkD1JgMzygf63o
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:2b1f:8d06:7923:f154])
 (user=mshavit job=sendgmr) by 2002:a25:6782:0:b0:b9d:894f:c9a8 with SMTP id
 b124-20020a256782000000b00b9d894fc9a8mr8218792ybc.0.1683751859947; Wed, 10
 May 2023 13:50:59 -0700 (PDT)
Date:   Thu, 11 May 2023 04:50:47 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510205054.2667898-1-mshavit@google.com>
Subject: [PATCH v1 0/5] Add PASID support to SMMUv3 unmanaged domains
From:   Michael Shavit <mshavit@google.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series refactors the arm-smmu-v3 driver and implements the
set_dev_pasid functionality for DMA and UNMANAGED iommu domains. As part
of this effort, we also refactor the arm-smmu-v3 driver such that each
iommu domain represent a single address space. In particular, stage 1
domains hold a single ContextDescriptor instead of the entire STE entry.

The refactor is arguably valuable independently from the set_dev_pasid
feature since an iommu_domain is conceptually closer to a single address
space than an entire STE. In addition this unlocks some nice clean-up of
the arm SVA implementation which today piggybacks SVA domains on the
"primary" domain.

This patch series makes some changes to SVA and PCIe, but I haven't
tested those features. The cd table allocations could also be further
optimized for masters that don't support multiple context.  However, the
SMMUv3 Nested translation patch series has me worried about this
change. At a glance, it seems like this refactor conflicts with its
proposed uAPI. Is this refactor no longer an appropriate clean-up or
path forward for set_dev_pasid support? Or could a uAPI that only
exposes a single CD instead of the entire STE be an appropriate fit for
the nesting use cases?

Thanks,
Michael Shavit

Link: https://lore.kernel.org/all/CAKHBV24u9b-=cJCF=Kt=3B4hynOyNr6gmi0F6zpO6b1mHc0Z7g@mail.gmail.com
Link: https://lore.kernel.org/all/cover.1683688960.git.nicolinc@nvidia.com/

Michael Shavit (5):
  iommu/arm-smmu-v3: Move cdtable to arm_smmu_master
  iommu/arm-smmu-v3: Add has_stage1 field
  iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
  iommu/arm-smmu-v3: Keep track of attached ssids
  iommu/arm-smmu-v3: Implement set_dev_pasid

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  46 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 432 ++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  44 +-
 3 files changed, 344 insertions(+), 178 deletions(-)

-- 
2.40.1.521.gf1e218fcd8-goog

