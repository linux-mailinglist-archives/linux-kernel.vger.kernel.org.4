Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34B1692A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBJW6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBJW6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:58:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58212F39
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676069910; x=1707605910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mh0zooOUAQYuLPgusu7lqvn1pK/p6iAkU1snPUOtILE=;
  b=ZliJ8FhFDyqO4YF/+QuHvU4Y803HBma+NPHngYkqn45hKzQdDjk4FbOB
   GIEly6W7bQlJqrmo7+D2L7h6OiM4tRf5kikctUV+WAs/pe/sbqKRchyI2
   q5rwPqdvjyZItFAu5u0cHw+bA18BpMYK2jDYl4Wp9FASeI750PRCZON2T
   H8l+7rM4JrYDPj2KSjvDRs9YDiDz2AR6S1atfAgpeX/mEEuZouSwT/e1c
   ITCxtzHXhdI4B8Pe0YpUsGaUI/N5QaNiF3HDZg9UdOaEkDoAirwnh6C/o
   sAFPNrbHM8Ah3eyJGmpjy3FccfRC0nhX2cY8bj8xh20FroV3E90QzlVp5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310179476"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310179476"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="777093491"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="777093491"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2023 14:58:29 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/2] Remove VT-d virtual command interface
Date:   Fri, 10 Feb 2023 15:02:04 -0800
Message-Id: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set removes unused VT-d virtual command interface followed by
clean up in the IOASID code.

This has only been tested on x86 platforms, need help with testing on ARM
SMMU and other architectures.

I also hope to collect feedback on the upcoming clean up and enhancements
below:
1. Consolidate VT-d private SVA PASID array with IOASID common code
2. As we retain the global IOASID allocator, we need some level of resource
management. I want to restart the effort to include IOASID under misc
cgroup.
(https://lore.kernel.org/linux-iommu/20210303160205.151d114e@jacob-builder/)

Thanks,

Jacob

Jacob Pan (2):
  iommu/vt-d: Remove virtual command interface
  iommu/ioasid: Remove custom IOASID allocator

 drivers/iommu/intel/cap_audit.c |   2 -
 drivers/iommu/intel/dmar.c      |   2 -
 drivers/iommu/intel/iommu.c     |  85 ---------
 drivers/iommu/intel/iommu.h     |   8 -
 drivers/iommu/ioasid.c          | 293 +-------------------------------
 include/linux/ioasid.h          |  28 ---
 6 files changed, 9 insertions(+), 409 deletions(-)

-- 
2.25.1

