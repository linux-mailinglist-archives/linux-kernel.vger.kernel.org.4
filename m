Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76F16CDB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjC2NrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2NrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:47:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A2EB0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097630; x=1711633630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ze+P/jCeStEoXlFymkbQzwvhBlVD/1D1Zt3CCXdAZb4=;
  b=VhRrCP0l5WS3WAjKoXK+8uDmg54DZI0YzXai45OVogyoYM68D/QuFiJx
   elGg3v4wXa9m8fAKb9QamE3YE7COARoH/KrK/ZyzaYljNNWbY58kAb/dn
   b/VzJIIEDEemJLclQBc026WGcBaW23A8+9sAfcKlb14Vx2r1W6kbsB8RQ
   1pDdAnQnqA6rECFPE+kqsFSAnO7tnATB/vnawW6j028A9mDPsA4hRmx1F
   LdwC9hwk7WUc+cXSms+Aiuj8Q1DYaeeNknq1tGUz600uUOPVooFSylPZV
   4uOQlAazVbur4Oc1P5qsdLGVFd/mrVy70l2nh3KdDYhLhVe5hGy245YCB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403506221"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="403506221"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677783322"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="677783322"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 06:47:03 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.3-rc4
Date:   Wed, 29 Mar 2023 21:47:18 +0800
Message-Id: <20230329134721.469447-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Some fixes have been queued for v6.3. They aim to:

- Fix a lockdep splat
- Fix a supplement of the specification
- Fix a warning in perfmon code

This series is also available at github.
https://github.com/LuBaolu/intel-iommu/commits/vtd-fix-for-v6.3-rc4

Please consider them for the iommu/fix branch.

Best regards,
Lu Baolu

Kan Liang (1):
  iommu/vt-d: Fix an IOMMU perfmon warning when CPU hotplug

Lu Baolu (2):
  iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()
  iommu/vt-d: Allow zero SAGAW if second-stage not supported

 include/linux/cpuhotplug.h          |  1 -
 drivers/iommu/intel/iommu.h         |  2 +
 drivers/iommu/intel/dmar.c          |  3 +-
 drivers/iommu/intel/irq_remapping.c |  6 ---
 drivers/iommu/intel/perfmon.c       | 68 +++++++++++++++++++----------
 5 files changed, 48 insertions(+), 32 deletions(-)

-- 
2.34.1

