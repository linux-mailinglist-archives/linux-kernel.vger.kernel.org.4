Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6878669511
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbjAMLL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjAMLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:10:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E9F7CDC4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:03:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 662ED61274
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95287C433EF;
        Fri, 13 Jan 2023 11:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673607803;
        bh=NfhxdsF9edW7RUM7O/BWU6t/1TksrMVcjhvCbku6DiI=;
        h=Date:From:To:Cc:Subject:From;
        b=GTvrUyodgEq/1CfEY5eKYHHmnQBJyM3eXNjBekKyOnjThnhJlCeAeVnGL12H0+tsG
         MsjjeHKoBH1AsFg2g8q4bVgcpZzN3W+4K9A8KUe7p+ROuIO3LeV/CpmwLx+fh2F83x
         j0xOgODrHbHrT0AB9hDB2fLaa4jLmS4tACgSPcxTrFS7iH4QqKtUgBLUVJ7D4bJytl
         vSiq5DX0GRps/YSMGseyMSyrOaLiM92dzNX0kgUogFOevvPCuuJsqmrFhaPkH2Hexp
         47t2fzpc6x2DzcNkfEuQVwgqsEA4nutNzJ5Yc6bA6lQbpzm1pwVvb6Uwn+TNfLFx/c
         CnaURoKFJ5BGA==
Date:   Fri, 13 Jan 2023 11:03:18 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 6.2
Message-ID: <20230113110318.GA12771@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please can you pull these Arm SMMU fixes for 6.2? The summary is in the
tag, but the main thing is fixing a VFIO regression due to the way in
which IOMMU_CAP_CACHE_COHERENCY is reported for SMMUv2 devices.

Cheers,

Will

--->8

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

for you to fetch changes up to f1ba05a70f7df4e2e4d2d7fed2d4e63a1e700660:

  iommu/arm-smmu-v3: Don't unregister on shutdown (2023-01-11 12:20:00 +0000)

----------------------------------------------------------------
Arm SMMU fixes for 6.2

- Fix VFIO regression on NXP SoCs by reporting IOMMU_CAP_CACHE_COHERENCY

- Fix SMMU shutdown paths to avoid device unregistration race

----------------------------------------------------------------
Robin Murphy (1):
      iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY even betterer

Vladimir Oltean (2):
      iommu/arm-smmu: Don't unregister on shutdown
      iommu/arm-smmu-v3: Don't unregister on shutdown

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 +++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 32 ++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 11 deletions(-)
