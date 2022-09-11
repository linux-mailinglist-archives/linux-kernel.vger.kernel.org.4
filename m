Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750A95B4C86
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIKHbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 03:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIKHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 03:31:08 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B3772D1E1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 00:31:03 -0700 (PDT)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 577DB221169;
        Sun, 11 Sep 2022 09:31:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1662881462;
        bh=dpn0tsJQ0Z4NLTovO/Oi/8+2RqkOs+LGUNaqt/NRQb4=;
        h=Date:From:To:Cc:Subject:From;
        b=yYIY31f6klOoMmD5DkK4KNwYQZADj5lHsPaBpatpcAlgJ9ho26pl5pi1Gtg7PDxJo
         BTdYVhNrAytJPzkUM1onYpMJNReT+iaYccSyMpOUZuMShevgU//gE5JdTmCQwRz6n4
         0WmnjL4EYU9P+WmqHrRLA81nBPVdlSZ1zpit3FZqISg9OCbzb+IiV9aA5F3iZpwOxU
         qrhuRylX50at/K0TF96Sr92VCq2VSgZ3f/FDsO6ED25DHWnZdOnN0BK8mxxWVTVk72
         igsjr0mpUC2SjbCAEYv6dxzTi51CrHPTmXlXJHYw2hp6YzBZ25lSTuqUU26/AwPXRv
         hV8H2sek4ScwA==
Date:   Sun, 11 Sep 2022 09:31:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.0-rc4
Message-ID: <Yx2Otdo+oqAeDG6s@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.0-rc4

for you to fetch changes up to 2380f1e8195ef612deea1dc7a3d611c5d2b9b56a:

  iommu: Fix false ownership failure on AMD systems with PASID activated (2022-09-11 08:30:41 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.0-rc4

Including:

	- Intel VT-d fixes from Lu Baolu

	  - Boot kdump kernels with VT-d scalable mode on

	  - Calculate the right page table levels

	  - Fix two recursive locking issues

	  - Fix a lockdep splat issue

	- AMD IOMMU fixes:

	  - Fix for completion-wait command to use full 64 bits of data

	  - Fix PASID related issue where GPU sound devices failed to
	    initialize

	- Fix for Virtio-IOMMU to report correct caching behavior, needed for
	  use with VFIO

----------------------------------------------------------------
Jason Gunthorpe (1):
      iommu: Fix false ownership failure on AMD systems with PASID activated

Jean-Philippe Brucker (1):
      iommu/virtio: Fix interaction with VFIO

John Sperbeck (1):
      iommu/amd: use full 64-bit value in build_completion_wait()

Lu Baolu (5):
      iommu/vt-d: Fix kdump kernels boot failure with scalable mode
      iommu/vt-d: Correctly calculate sagaw value of IOMMU
      iommu/vt-d: Fix recursive lock issue in iommu_flush_dev_iotlb()
      iommu/vt-d: Fix lockdep splat due to klist iteration in atomic context
      iommu/vt-d: Fix possible recursive locking in intel_iommu_init()

 drivers/iommu/amd/iommu.c    |   3 +-
 drivers/iommu/amd/iommu_v2.c |   2 +
 drivers/iommu/intel/dmar.c   |   7 ++
 drivers/iommu/intel/iommu.c  | 241 ++++++++++++++++++++-----------------------
 drivers/iommu/intel/iommu.h  |   9 +-
 drivers/iommu/iommu.c        |  21 +++-
 drivers/iommu/virtio-iommu.c |  11 ++
 include/linux/dmar.h         |   4 +-
 8 files changed, 163 insertions(+), 135 deletions(-)

Please pull.

Thanks,

	Joerg
