Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A046872CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBBBJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBBJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:09:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B286D3F2A9;
        Wed,  1 Feb 2023 17:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675300139; x=1706836139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2E9LVcJw3Kk6q7B8/ENCBNmYX418E19egKvZ3PU0pdA=;
  b=npLb678luk+QFjh54XlgrmchfiBAoHOkqe/4ExF6vOxZ3oLkjc51e6qc
   gGjYHEmlEGpJZC9wWjp1+Wjt09jT9PKQoJbF9e7rRtopat9oPJHNt1+A2
   sYOSGxB0rnTNBkYm0nXxWWUPToHRwbPW3B8bN4MrmCapZOyuAmWUQCS4/
   Ru+wmguKXIUVanFU830hxbSQCej6kCD6YWRUK8xDgElzTOjpsVJXiiXub
   cdxIrxRElK+3WsXIj4DVAUoP1riEzgJ8J2uemG47ljCjjC7xz9X0z1GGp
   GmpqbrfCqo5ZKsI63mzYMHknOGyrOdexpeYWsAd6VU4U2SMfbI8xnv76R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355654298"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="355654298"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:08:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665087923"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665087923"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 17:08:15 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/7]  Add TPMI support
Date:   Wed,  1 Feb 2023 17:07:31 -0800
Message-Id: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

The TPMI (Topology Aware Register and PM Capsule Interface) provides a
flexible, extendable and PCIe enumerable MMIO interface for PM features.

For example Intel Speed Select Technology (Intel SST) can replace all
mailbox commands with direct MMIO access. This reduces latency for
SST commands and also defines an architectural interface which will
persist for several next generations.

Also Intel RAPL (Running Average Power Limit) provides a MMIO
interface using TPMI. This has advantage over traditional MSR
(Model Specific Register) interface, where a thread needs to be scheduled
on the target CPU to read or write. Also the RAPL features vary between
CPU models, and hence lot of model specific code. Here TPMI provides an
architectural interface by providing hierarchical tables and fields,
which will not need any model specific implementation.

Same value is for Intel Uncore frequency where MSR interface can't
be used because of multiple domains.

The TPMI interface uses a PCI VSEC structure to expose the location of
MMIO region, which is handled by Intel VSEC driver. Intel VSEC driver is
already present in upstream kernel.

This series contains the base driver, which parses TPMI MMIO region
and creates device nodes for supported features. The current set of
PM feature support includes, Intel Speed Select, RAPL, Uncore frequency
scaling.

The first there patches updates Intel VSEC driver to add TPMI VSEC ID
and enhance to reuse the code.
The next three patches adds TPMI base driver support.
The last patch adds MAINTAINERS entry.

The TPMI documentation can be downloaded from:
https://github.com/intel/tpmi_power_management

This series cleanly applies on 6.2-rc1.

Srinivas Pandruvada (7):
  platform/x86/intel/vsec: Add TPMI ID
  platform/x86/intel/vsec: Enhance and Export intel_vsec_add_aux()
  platform/x86/intel/vsec: Support private data
  platform/x86/intel: Intel TPMI enumeration driver
  platform/x86/intel/tpmi: Process CPU package mapping
  platform/x86/intel/tpmi: ADD tpmi external interface for tpmi feature
    drivers
  MAINTAINERS: Add entry for TPMI driver

 MAINTAINERS                         |   6 +
 drivers/platform/x86/intel/Kconfig  |  13 +
 drivers/platform/x86/intel/Makefile |   4 +
 drivers/platform/x86/intel/tpmi.c   | 415 ++++++++++++++++++++++++++++
 drivers/platform/x86/intel/vsec.c   |  21 +-
 drivers/platform/x86/intel/vsec.h   |   6 +
 include/linux/intel_tpmi.h          |  30 ++
 7 files changed, 490 insertions(+), 5 deletions(-)
 create mode 100644 drivers/platform/x86/intel/tpmi.c
 create mode 100644 include/linux/intel_tpmi.h

-- 
2.31.1

