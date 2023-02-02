Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572DB6872CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBBBJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBBBJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:09:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE7246174;
        Wed,  1 Feb 2023 17:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675300142; x=1706836142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MmA/+gLVYlCrWM54OgGMSsjZO5kDppV+ZBRtY3CYSqs=;
  b=hGvxJRNW5Ar8lsa3s+3GYq8+lZzbsZ6jIMY8p3N/+6zYpF/MCDLrv71P
   QLku44ib6x22vepuL9MARyKijpYchByO/1h6nCplsQxc9oFDO/KjDFT6i
   5Ts2vC9OGA4+EhefUIv0oFn0u7Dd3bdYxa8JX6ocSuUvqnL+JwdQXHkUX
   tiUENxa9IGzXopQh4SrXln6zGtA/VzR3hwyZE6ndgHfQUVkbxhS8LHjl4
   8LFM2YG59Gc3qCXYOYE+8f28xGUfIHIocXtpq/NZ1xW7OpCU3LYO11ilI
   INaCeFxMWK8FmdM8KGYw4+ED/d2in9qWHlHJgBw3gX8z3hl/N+SNB8xIz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355654310"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="355654310"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665087926"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665087926"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 17:08:15 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 3/7] platform/x86/intel/vsec: Support private data
Date:   Wed,  1 Feb 2023 17:07:34 -0800
Message-Id: <20230202010738.2186174-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fields to struct intel_vsec_device, so that core module (which
creates aux bus devices) can pass private data to the client drivers.

For example there is one vsec device instance per CPU package. On a
multi package system, this private data can be used to pass the package
ID. This package id can be used by client drivers to change power
settings for a specific CPU package by targeting MMIO space of the
correct PCI device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index d02c340fd458..ae8fe92c5595 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -38,6 +38,8 @@ struct intel_vsec_device {
 	struct ida *ida;
 	struct intel_vsec_platform_info *info;
 	int num_resources;
+	void *priv_data;
+	size_t priv_data_size;
 };
 
 int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
-- 
2.31.1

