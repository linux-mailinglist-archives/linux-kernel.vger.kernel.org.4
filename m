Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22007241B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjFFMJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjFFMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:09:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3DE78
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:09:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565a336caa0so97973267b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053358; x=1688645358;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nnyvtjh+kF3RLE+cug+CO0eM4y0oqNNfVmWbOcSnIjQ=;
        b=utkX65Vz0L6sR2kZ/cV8/Bs95MrkpKlOYv55JrePCNTvQTBAgFotFEAPUv6jg38AXp
         pPL3iz7Ctht5pHtoRtBxwvw9x2NfbiqVTKpH2ZNeguEbnOsevwaiOBVDfxeOXEONADZ2
         DcmayF+B0d7NbXxLFqYu5iprNU0JTO5D03WCzRj83Hzfx3cVFfrlTxjUf7ltPXdwUf7k
         RyHBqhu2S/M83S/KCELU8K0i9QH1/vAIzQPKdQMc5oOsm5Bn5Y4Z0DaAOpgdKXj/XIux
         6eaZI5eRA+8QJuJImLEteMOOIXGGVJz2OAbBfK0GjVcUQQ35CBdkE3LyH0rgUwR31OxJ
         g/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053358; x=1688645358;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnyvtjh+kF3RLE+cug+CO0eM4y0oqNNfVmWbOcSnIjQ=;
        b=Hq4jl9vCleovDBsMXiBKpVDPl/JQQsevKaIOUBtLM0pYYapoHMlMd8hVWvgZ5Hw78n
         hbdFBReBNVbZ4wtts1GkVyVQxRV90oVi1enEHsu5jldaP7uZxBHOVHy+BV1rdt8imzSr
         TwRqJa46k8LvTgQV6d2PNW7RH0r2Kx6gE6iO3gK5y0OEcFT49L+J6LCE+HI9fod/QxcI
         nwQ0gBNZs8I7CMaPvzpO83qS6XSdNlhUq8zQZiIVT2ics49NfCO5Y+gTAJlJxOkG5ZjF
         467kKeo9tIw/ji+9PkVykJf8MiTr4WjuzXQzHOYO+c4yAXfGSsVyE91KAUUCwt2TIuZ6
         piVw==
X-Gm-Message-State: AC+VfDyKgzny9XH9i0/39jSmvKiRsGkWbV7RpIlDeeebYTwbyf0uhaNA
        AOEYaeR83e/f062lJwpI4KtCeODmDu95
X-Google-Smtp-Source: ACHHUZ6aSekWgWC0uGTChOHJuA02dRoV0LxXIWREsHrUrDfzJsBIcspGSrMwdLO1U5pFvSvOs25/Qr7k3QY6
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a5b:5ca:0:b0:b9d:b6cd:2dfd with SMTP id
 w10-20020a5b05ca000000b00b9db6cd2dfdmr958857ybp.8.1686053358499; Tue, 06 Jun
 2023 05:09:18 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:36 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-1-mshavit@google.com>
Subject: [PATCH v2 00/18] Add PASID support to SMMUv3 unmanaged domains
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

As a first step, the patch series refactors stage 1 domains so that
they describe a single CD entry. On attach, stage 1 domains are
inserted into a CD table that is now owned by the arm_smmu_master
struct. Note that this does not preclude from attaching domains that
represent a CD table, such as for the proposed iommufd NESTED domains.

The patch series also heavily refactors the arm-smmu-v3-sva
implementation. The first set of clean-up patches were enabled by
earlier changes in the iommu pasid framework. Later patches take
advantage of the arm-smmu-v3 changes and makes use of its set_dev_pasid
implementation.

This patch series is also available on gerrit with Jean's SMMU test
engine patches rebased on top:
https://linux-review.googlesource.com/id/I0fcd9adc058d1c58a12d2599cc82fba73da7697a
This allowed testing of basic SVA functionality (e.g.: attaching, page
fault handling, and detaching).

Thanks,
Michael Shavit

Changelog
v2:
 * Reworded cover letter and commits based on v1 feedback.
 * Added SVA clean-up and refactor.
 * Split and reworked iommu/arm-smmu-v3: Move cdtable to
arm_smmu_master
 * A few other small bug fixes and cosmetics.
v1: https://lore.kernel.org/all/20230510205054.2667898-1-mshavit@google.com/

Michael Shavit (18):
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
  iommu/arm-smmu-v3: Support domains with shared CDs
  iommu/arm-smmu-v3: Allow more re-use for SVA
  iommu/arm-smmu-v3-sva: Attach S1_SHARED_CD domain
  iommu/arm-smmu-v3-sva: Alloc notifier for {smmu,mn}
  iommu/arm-smmu-v3-sva: Remove atc_inv_domain_ssid

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 164 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 493 ++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  62 ++-
 3 files changed, 457 insertions(+), 262 deletions(-)


base-commit: 884fe9da1b7ccbea31b118f902fbc78f58366b4a
-- 
2.41.0.rc0.172.g3f132b7071-goog

