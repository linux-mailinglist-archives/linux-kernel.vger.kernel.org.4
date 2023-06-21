Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA29737BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjFUGnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjFUGnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:43:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B0010DB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:43:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561eb6c66f6so63731017b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329795; x=1689921795;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e5OY6M282TnfWEbYmOhDm1hIj4tFoicvaXmqK7/yzuI=;
        b=hBA3ovpmEWj7N2Mma7LAPU4gXjRFktu7C2uZyug1Mz+u/bNNdHYT6sdAt6Y3Z7QMkE
         1w5uHGLCJXqJRZYOfs5OYL/FEUju9H2aI5Jb6Z9IM7WGjnfTx3Upunbyvz6BSG2aZUj9
         ggy5bH2lbm4yiNNIKIBgNqB4eYn9DnXxz8Pwyl70xuAXsGmc2S733pRhf8HUpMHODIgE
         Ve6rhOdziSoBHZaq5AzXhgmkd1eZ4krWNLyMt1qYBzbDu6rCWrYxiZlYecvnyFG3YCMA
         A0H4P7tiiob6FohRlPzVmgRLagPxRPDpvbbZ368jkVgaENT6RhRU/R7HNq/cmOQOy/aJ
         9acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329795; x=1689921795;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5OY6M282TnfWEbYmOhDm1hIj4tFoicvaXmqK7/yzuI=;
        b=Nb8w4wf0LUVOxEsXNhj6OwISKYbe3e0/Ek+w7nR+iVqLk5cqgb1UuIsZFeAeJdUy8P
         9x0bMSpX5lrC971Xtpl+K9QeOOejqvjPxVfNIlkX5Bv2hxwdhc+Iw64jfAz9EMmmwco8
         jdulalAOSwgKEcA+m0LJ+/g+ZAoBNhbToXqG7tcB4hqoWCceh6+CjVUC/k4ObK/nMuyo
         8oFosh22Hk7ODicNZMjuQ9T42pH3DdhBeEFfh03I/A10Kc6NCxs0EPmSulWykQmfbCvC
         fPfpQEmCMGnx5zaOmdHEcam7S4p2DBryXvBWuDSVdqF6QrbbaL6FKhRPXMJaEXsmYtR2
         pKmA==
X-Gm-Message-State: AC+VfDzSiO0501/g3ifKp9Fn9Wvh42/+22QH03OPEZOIYA0UqtSH/oso
        UGZIi/bJhrL3EQLqt+ze9oafWub5bblS
X-Google-Smtp-Source: ACHHUZ6ljJYeciVzTvS9xoX/3PR67Fy5ykTR3WoOGW9eRFKPwUjz57O17oDvVrhXJl36yuTa6IcVVX4qLFLu
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a25:748e:0:b0:bac:fd63:b567 with SMTP id
 p136-20020a25748e000000b00bacfd63b567mr5996641ybc.4.1687329795401; Tue, 20
 Jun 2023 23:43:15 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:37:12 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-1-mshavit@google.com>
Subject: [PATCH v4 00/13] Add PASID support to SMMUv3 unmanaged domains
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series implements the set_dev_pasid operation for DMA
and UNMANAGED iommu domains.

The bulk of the series involves a refactor of stage 1 domains so that
they describe a single CD entry. On attach, stage 1 domains are inserted
into a CD table that is now owned by the arm_smmu_master struct. This is
a pre-requisite to the set_dev_pasid implementation but also results in
a conceptually cleaner arm_smmu_domain. Note that this does not preclude
from attaching domains that represent a CD table, such as for the
proposed iommufd NESTED domains.

The last few patches of the series make drive-by cleanups to the smmu
SVA implementation. A follow-up patch-series is planned to further take
advantage of these refactorings so that the SVA set_dev_pasid
implementation can directly rely on the arm-smmu-v3.c's set_dev_pasid
implementation. See discussion on patch 14 of the v2 series.

This patch series is also available on gerrit with Jean's SMMU test
engine patches cherry-picked on top:
https://linux-review.googlesource.com/id/I0fcd9adc058d1c58a12d2599cc82fba73da7697a
This allowed testing of basic SVA functionality (e.g.: attaching, page
fault handling, and detaching).

Thanks,
Michael Shavit

Changelog
v4:
 * Fix build warning and error on patch 07. The error was introduced
   during a v1->v2 rebase and hidden by patch 09 which removed the
   offending line.
v3:
https://lore.kernel.org/all/20230614154304.2860121-1-mshavit@google.com/
 * Dropped the bulk of the SVA refactoring to re-work as a follow-up
   series.
 * Reworded cover letter to omit dropped changes.
 * Rebased on 6.4 tip
v2:
https://lore.kernel.org/all/20230606120854.4170244-1-mshavit@google.com/
 * Reworded cover letter and commits based on v1 feedback.
 * Split and reworked `iommu/arm-smmu-v3: Move cdtable to arm_smmu_master`
 * Added SVA clean-up and refactor.
 * A few other small bug fixes and cosmetics.
v1:
https://lore.kernel.org/all/20230510205054.2667898-1-mshavit@google.com/


Michael Shavit (13):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
  iommu/arm-smmu-v3: Refactor write_strtab_ent
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Use the master-owned s1_cfg
  iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
  iommu/arm-smmu-v3: Keep track of attached ssids
  iommu/arm-smmu-v3: Add helper for atc invalidation
  iommu/arm-smmu-v3: Implement set_dev_pasid
  iommu/arm-smmu-v3-sva: Remove bond refcount
  iommu/arm-smmu-v3-sva: Clean unused iommu_sva
  iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
  iommu/arm-smmu-v3-sva: Add check when enabling sva

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 156 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 447 ++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  49 +-
 3 files changed, 414 insertions(+), 238 deletions(-)


base-commit: b6dad5178ceaf23f369c3711062ce1f2afc33644
-- 
2.41.0.162.gfafddb0af9-goog

