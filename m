Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A995F6C402F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCVCM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVCMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:12:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7394257D1E;
        Tue, 21 Mar 2023 19:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679451143; x=1710987143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tgknFT5svxoytfFvukmFEVzxzYULnJSsbUdnExl6zDM=;
  b=UzVtzCid35WNheIlpkTKMCjx64eNpES39tYqdb0fM/jIx5OAsyGwNZsU
   DHkObj2YOBRIu41r4T79WI9WgGrcj2TOaxjVGbQhgKloa02oS1NNU6J2o
   oGRS89Cr+BjypMJCKDcfJGX6VvEBRJMOfemTldbzMDRcbbQgqoc5VdT+L
   tM4G3hb3SaS1LOE4sxjLZdFqRUqk5CdyrYuMfy8O9xHcDNzCJw/nW9hCg
   ooiX52AQZxAfG4fDs77v4R/HLQCfFfRc1spv63bvOHlkAh+BHqsqXnPUD
   iw+JXBI8Lsy1i7T6b5Glfr7tMEfoBRgloZzW/q34M+ewm95L7dci/N8pH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="401677429"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="401677429"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746126819"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="746126819"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.21.85])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:21 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/6] CXL Poison List Retrieval & Tracing
Date:   Tue, 21 Mar 2023 19:12:13 -0700
Message-Id: <cover.1679448904.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v10:

Patch 2/6 cxl/trace: Add TRACE support for CXL media-error records
- Rename the cxl_poison trace event field 'length' to 'dpa_length' (Jonathan)
  The dpa_length here is the dpa length as reported by the device.
- Add a 'type' field to the cxl_poison TRACE_EVENT and define and 
  use type 'CXL_POISON_TRACE_LIST'. This is in preparation for adding
  more cxl_poison_trace_type's like CXL_POISON_TRACE_(INJECT | CLEAR)
- Use continuations in TP_printk to match the file convention.

Patch 4/6 cxl/region: Provide region info to the cxl_poison trace event 
- Add Jonathan Reviewed-by (for real) and Tested-by Tags (Jonathan)
- Tidy blank line at return in trigger_poison_list_store() (Jonathan)

Patches 1,3,5,6: no changes.

Cover Letter:
- Updated the example cxl_poison TRACE_EVENTs to show type=LIST

Link to v9:
https://lore.kernel.org/linux-cxl/cover.1679284567.git.alison.schofield@intel.com/

End Changelog

Add support for retrieving device poison lists and store the returned
error records as kernel trace events.

The handling of the poison list is guided by the CXL 3.0 Specification
Section 8.2.9.8.4.1. [1] 

Example trigger:
$ echo 1 > /sys/bus/cxl/devices/mem0/trigger_poison_list

Example Trace Events:

Poison found in a PMEM Region:
cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 type=LIST region=region11 region_uuid=d96e67ec-76b0-406f-8c35-5b52630dcad1 hpa=0xf100000000 dpa=0x70000000 dpa_length=0x40 source=Injected flags= overflow_time=0

Poison found in RAM Region:
cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 type=LIST region=region2 region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xf010000000 dpa=0x0 dpa_length=0x40 source=Injected flags= overflow_time=0

Poison found in an unmapped DPA resource:
cxl_poison: memdev=mem3 host=cxl_mem.3 serial=3 type=LIST region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 dpa_length=0x40 source=Injected flags= overflow_time=0


[1]: https://www.computeexpresslink.org/download-the-specification


Alison Schofield (6):
  cxl/mbox: Add GET_POISON_LIST mailbox command
  cxl/trace: Add TRACE support for CXL media-error records
  cxl/memdev: Add trigger_poison_list sysfs attribute
  cxl/region: Provide region info to the cxl_poison trace event
  cxl/trace: Add an HPA to cxl_poison trace events
  tools/testing/cxl: Mock support for Get Poison List

 Documentation/ABI/testing/sysfs-bus-cxl |  14 +++
 drivers/cxl/core/core.h                 |  15 ++++
 drivers/cxl/core/mbox.c                 |  75 ++++++++++++++++
 drivers/cxl/core/memdev.c               | 108 ++++++++++++++++++++++++
 drivers/cxl/core/region.c               |  63 ++++++++++++++
 drivers/cxl/core/trace.c                |  94 +++++++++++++++++++++
 drivers/cxl/core/trace.h                | 101 ++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  72 +++++++++++++++-
 drivers/cxl/mem.c                       |  36 ++++++++
 drivers/cxl/pci.c                       |   4 +
 tools/testing/cxl/test/mem.c            |  42 +++++++++
 11 files changed, 623 insertions(+), 1 deletion(-)


base-commit: e686c32590f40bffc45f105c04c836ffad3e531a
-- 
2.37.3

