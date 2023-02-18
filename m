Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979569B7B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 03:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBRCTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 21:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBRCTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 21:19:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D87D48E27;
        Fri, 17 Feb 2023 18:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676686739; x=1708222739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y/gFdXl17RDyGmXyQHiDE1ocFPNVYnxg/oNSahGPjW8=;
  b=kPlogmr9CdRwc51tyZNL+XkFy6JZy8IkUImXb+BqQzMoFIZIFwhwEB3R
   hHEOD15SogAcp+tgUPs+ipyMGVEY9SvKXwygoXNxN/Erj7vvuK7Wnzuo6
   x6c8UX6Xd3Y8b8OUMv3nacPZ8sdU3HvxpyPoo1OEAk5hKdW8yk7JeV2Vy
   M7raUp+1klwp4FRu5ucrGPbIZPYIodi6EFbGDQe00Z9c84xaIr6KqChzZ
   4AvcSaV3joB0bPY09fwDeJTtkJD3HX3prDDIzJjr1DaLFmEy+iDp2s9ih
   SBY6hOkpOBBEtYoTTyHMK+ntMg6dV2qKy2annDzy+2TooM5uyffYQZQm/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="320244201"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="320244201"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 18:18:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="672787872"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="672787872"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.133.15])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 18:18:57 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] CXL Poison List Retrieval & Tracing
Date:   Fri, 17 Feb 2023 18:18:48 -0800
Message-Id: <cover.1676685180.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

This is not targeting the 6.3 merge window.

Changes in v7:
- Update commit log wrt poison read for unmapped after mapped (Jonathan)
- Update comment wrt decoder modes and pmem/ram separation (Jonathan)
- Add dev_dbg() if mixed mode decoder appears
- Read poison on skip range first (Jonathan)
- trace: order fields (memdev, host, serial)
- trace: simplify host name get
- trace: use typical tabs
Link to v6: https://lore.kernel.org/linux-cxl/cover.1675983077.git.alison.schofield@intel.com/

Add support for retrieving device poison lists and store the returned
error records as kernel trace events.

The handling of the poison list is guided by the CXL 3.0 Specification
Section 8.2.9.8.4.1. [1] 

Example:
$ echo 1 > /sys/bus/cxl/devices/mem0/trigger_poison_list
cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 region=region4 region_uuid=117b2cf4-b160-4090-9361-ba31b9649317 hpa=0xf0d0000000 dpa=0x40000000 length=0x40 source=Internal flags= overflow_time=0

[1]: https://www.computeexpresslink.org/download-the-specification


Alison Schofield (6):
  cxl/mbox: Add GET_POISON_LIST mailbox command
  cxl/trace: Add TRACE support for CXL media-error records
  cxl/memdev: Add trigger_poison_list sysfs attribute
  cxl/region: Provide region info to the cxl_poison trace event
  cxl/trace: Add an HPA to cxl_poison trace events
  tools/testing/cxl: Mock support for Get Poison List

 Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++
 drivers/cxl/core/core.h                 |  5 ++
 drivers/cxl/core/mbox.c                 | 74 +++++++++++++++++++
 drivers/cxl/core/memdev.c               | 68 ++++++++++++++++++
 drivers/cxl/core/region.c               | 89 +++++++++++++++++++++++
 drivers/cxl/core/trace.c                | 94 +++++++++++++++++++++++++
 drivers/cxl/core/trace.h                | 91 ++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    | 69 +++++++++++++++++-
 drivers/cxl/pci.c                       |  4 ++
 tools/testing/cxl/test/mem.c            | 42 +++++++++++
 10 files changed, 549 insertions(+), 1 deletion(-)


base-commit: a5fcd228ca1db9810ba1ed461c90b6ee933b9daf
-- 
2.37.3

