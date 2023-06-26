Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69773EB27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjFZTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFZTWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:22:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF6DE5A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687807331; x=1719343331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j0rt9a3HMWTGsfmAOU7+cW8cCUNLUvJa23+4J/SXbTM=;
  b=EB+OPB215+j8Md5Itr/g1/Pa3tC6VhYUBlDrN3BAp1aQW7mPIzCgzI+0
   xMjMb510AOD5XZzKfqIQuzr8d1rzaNWx4W38EgzpLlIU8LEJ3nq1RFE7S
   VZtpuXHYMieMuRChCvc34WoGb/+vU0B+Z28s+AdrzEFr2qwaq7InXPPDv
   MJI9ewBgRMgkAMNpl6f3zJy28a1CMpRmNbkC4pv9bYJArVLXEGN8t4owv
   W+9COR46fiwDsa2YAJKKVmKrvVgh5VwIsNRvyWRZz/R+bgGQdUxM+iUew
   ehGHFdwgZ9jgovugXjtWWyBlKQ2HiEfNdH7eHLwsqPE22kmSmGtp0IxMb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="346122766"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="346122766"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 12:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840394433"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="840394433"
Received: from viggo.jf.intel.com (HELO ray2.intel.com) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2023 12:22:10 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/platform for 6.5
Date:   Mon, 26 Jun 2023 12:22:09 -0700
Message-Id: <20230626192209.1529129-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/platform changes for 6.5. These allow CPUs in
SGX/HPE Ultraviolet to start using Sub-NUMA clustering (SNC) mode. SNC
has been around outside the UV world for a while but evidently never
worked on UV systems.

SNC is rather notorious for breaking bad assumptions of a 1:1
relationship between physical sockets and NUMA nodes.  The UV code
was rather prolific with these assumptions and took quite a bit
of refactoring to remove them.

--

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_6.5

for you to fetch changes up to 73b3108dfd9d53ea565c0777a27007c1c621467d:

  x86/platform/uv: Update UV[23] platform code for SNC (2023-05-31 09:35:00 -0700)

----------------------------------------------------------------
Add UV platform support for sub-NUMA clustering

----------------------------------------------------------------
Steve Wahl (8):
      x86/platform/uv: Add platform resolving #defines for misc GAM_MMIOH_REDIRECT*
      x86/platform/uv: Introduce helper function uv_pnode_to_socket.
      x86/platform/uv: Fix printed information in calc_mmioh_map
      x86/platform/uv: When searching for minimums, start at INT_MAX not 99999
      x86/platform/uv: Helper functions for allocating and freeing conversion tables
      x86/platform/uv: UV support for sub-NUMA clustering
      x86/platform/uv: Remove remaining BUG_ON() and BUG() calls
      x86/platform/uv: Update UV[23] platform code for SNC

 arch/x86/include/asm/uv/uv_hub.h   |  32 ++--
 arch/x86/include/asm/uv/uv_mmrs.h  |  18 ++-
 arch/x86/kernel/apic/x2apic_uv_x.c | 318 +++++++++++++++++++++++--------------
 3 files changed, 232 insertions(+), 136 deletions(-)
