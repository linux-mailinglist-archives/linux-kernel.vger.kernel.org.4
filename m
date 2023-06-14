Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FBF73040D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbjFNPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjFNPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:43:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D71FF9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:43:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565d1b86a64so11159257b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757407; x=1689349407;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mAfUZAOawoyT8CZyBzszrXXIQaEA3XJLD6s2UAVMv7M=;
        b=klcb7noUuAhdnyf4XlxZkBVy6m4Tak9FnBDCYLv6vayg10s9lLLt3qPnVLxLMx4V/h
         pzPnayfvfuzQEUOB5XX/2G4ghnontqIKTbMe/zek+dZYqjblajQdwzG5A5/4xyYyQv0d
         uNT6JXsDQ4tSPqvuddMCl0Qt2DTW0J2AIZ9hpB9C/p7k2dqijFS2u2wBiti+po7ZBLXc
         EUD2/i+KUUbqSkgvN3ngtvMFkwb8ug7x3Ak6EEbKeN8Lm1RGfOZajT7aoy+JasZ6nVLM
         be92jLBxtpRiPyw9LnERbrec0UvRLfJPdL+sInjK5bYmS+0vcPh/N9mBFQSxzlY0jGVK
         J6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757407; x=1689349407;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAfUZAOawoyT8CZyBzszrXXIQaEA3XJLD6s2UAVMv7M=;
        b=kzKGSKLRA1eUx6WZ8aj0xLOCayPXGEbLYcyNqMDkLjLvBpsdaqdogbZgko0FuQDNUz
         WBdG2C2xvYBaUIAiEhsy5XeuMZyza3QTb3W017mDENd4FB5Pmx2nYL/qtk3HchbJp4mh
         FRaYEOzkmXSvGwC1dM6HoDKJ2gOE+to6Ti8zRmE6Fmd5D/5RQrpVeJ06twOWEsN4Wn9J
         w2FdXDHiaqqmbDwLYL9vNLGXTckQNgGUuhkAiV2Vp+TbC8JcVDdeEEbiL53weFc975Vo
         sccwpTZjZgC03Q1Js23GNk9UH9wReOAjvBQIIlIlpFNrLgyN9PDrUClQFehoLmawKQCD
         na8A==
X-Gm-Message-State: AC+VfDwtGJMFyc+XaCEY7Fjpg93Ln+G7ZeZXjf6w6GXgoO0hd1SwpH3l
        htJ92/DCUtjYF5Rgeyf7PjdbLxMB2kaX
X-Google-Smtp-Source: ACHHUZ7xIpowVbdQXt1AFVkmjdLe/ViKNLhbx2+GqU5cx7xGsa3h+wqyu0XBexhlSmG0mpwgu06VfPb3ROLc
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a81:b64a:0:b0:56c:fffd:49db with SMTP id
 h10-20020a81b64a000000b0056cfffd49dbmr1019861ywk.7.1686757406946; Wed, 14 Jun
 2023 08:43:26 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:41:52 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-1-mshavit@google.com>
Subject: [PATCH v3 00/13] Add PASID support to SMMUv3 unmanaged domains
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
SVA implementation. A follow-up patch-series is planned so that the SVA
implementation can further take advantages of the changes introduced here. See
discussion on patch 14 of the v2 series.

This patch series is also available on gerrit with Jean's SMMU test
engine patches cherry-picked on top:
https://linux-review.googlesource.com/id/I0fcd9adc058d1c58a12d2599cc82fba73da7697a
This allowed testing of basic SVA functionality (e.g.: attaching, page
fault handling, and detaching).

Thanks,
Michael Shavit

Changelog
v3:
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

