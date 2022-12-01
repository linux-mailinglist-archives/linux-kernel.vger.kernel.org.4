Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E563E8C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLAEIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLAEIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:08:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142657743A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867730; x=1701403730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wDFL+yM/dCNG+ZwuVw9ZgnAnjVMbNp4Dy+Z5/rRcjE0=;
  b=ZYwMcofkipKTEdf3XQHoOzuTK0NaLCBYzN2MUowMfYZ1BgpjnRIyC97m
   pir5EP/tXmgtqkZNtmeb493PA30Qw7Aeed6Lg3urPRP78hd6oa5Wg+cs5
   Id6pQb51e/4flncC6QkTwyN/FB87/ee1ZWp74ZewmuUkXqbKqaMJW+M3H
   TEnGTEiN1eLq7l+mq6zcIcw4mrAMjfYQ+9t8ZjaHnkOxsjSfbD+QIIGlw
   EZT8HVKMHp405zgiMQKX9s6OPNy+g0x4booXFgit0rDJlnYLIssY47lKh
   B8E9WOA3yxY0R2FVeCGkkI25j5ILutdr6aIoChG7v1oQiNLGSjYIgrm85
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377745727"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="377745727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707911652"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="707911652"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 20:08:41 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc8
Date:   Thu,  1 Dec 2022 12:01:23 +0800
Message-Id: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Below fixes are queued for v6.1. They aim to:

- Add a fix to handle a QAT device quirk.
- Fix 3 PCI device refcount leaks.

This series is also available at github.
https://github.com/LuBaolu/intel-iommu/commits/vtd-fix-for-v6.1-rc8

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Jacob Pan (1):
  iommu/vt-d: Add a fix for devices need extra dtlb flush

Xiongfeng Wang (2):
  iommu/vt-d: Fix PCI device refcount leak in has_external_pci()
  iommu/vt-d: Fix PCI device refcount leak in dmar_dev_scope_init()

Yang Yingliang (1):
  iommu/vt-d: Fix PCI device refcount leak in prq_event_thread()

 drivers/iommu/intel/iommu.h |  4 ++
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 73 +++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/svm.c   | 19 +++++++---
 4 files changed, 88 insertions(+), 9 deletions(-)

-- 
2.34.1

