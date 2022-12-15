Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAC64E2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLOVSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLOVSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:18:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C4630F4A;
        Thu, 15 Dec 2022 13:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671139079; x=1702675079;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N6nCgppkHdC2791QKsGpKt/qkhp9jDpIuTReWa9daUI=;
  b=HFui2O/UGG/joWUXd63I+DF/XMW1ql2dW8rbsQW4RDLurHFVnry8+z6B
   6OJW/AG9bA18riuhRjlov7pAOdSicBq0UZJsIja4L1myOlKgWDaKfLN7M
   w+wKy0xemec+Nhrh8P5fyxbItEwNri7YiSpl3P8FveZ0Qx9h8h3uPalxL
   15rj+9LQVZmokjeFhNIowZMGklyMlkWA1xkAn/gx0VWB/tFbg+d3jAMjy
   l4BYdIK74m38h53A2HXRlPAggESRICxuGXcyS1ZixqOkNwz54aXlTXzV9
   R2Z4ntTiBjI5yAXsHOQMmVBF4lO3Y6wTCdMoF564x7ZnHl2bPjfqLyOAs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="302230289"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="302230289"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="649570074"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="649570074"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.178])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:49 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] CXL Poison List Retrieval & Tracing
Date:   Thu, 15 Dec 2022 13:17:42 -0800
Message-Id: <cover.1671135967.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v4:
- Rebase on cxl/preview
- Squash 2 mock patches into 1 mock patch
- Apply Jonathan Reviewed-by tags on Patches 1,2,4,5
- Don't return an error on failure to read volatile range poison (Jonathan)
- Use strong types in trace event arguments supplying dev_names (Dan)
- Pass the media-error record structure to trace event. (Steve, Ira)
- Re-order Patches 1 & 2 to make the change above work
- Use a poison state struct to hold buffer, lock (and max_mer) (Dan)
- Allocate the poison list payload buffer once (Dan)
- Request poison length in multiples of 64 bytes per CXL Spec
- Test for enabled when storing Identify commands max_mer
- Use get_unaligned_le24() on poison max_mer (Jonathan)
- Use decimal values for size (rsvd[20]) (Dan)
- cxl_test: mock with a valid DPA address
- s/includes/'consists of' (Jonathan)

Link to v3:
https://lore.kernel.org/linux-cxl/cover.1668115235.git.alison.schofield@intel.com/

Add support for retrieving device poison lists and store the returned
error records as kernel trace events.

The handling of the poison list is guided by the CXL 3.0 Specification
Section 8.2.9.8.4.1. [1] 

Example, triggered by memdev:
$ echo 1 > /sys/bus/cxl/devices/mem3/trigger_poison_list
cxl_poison: memdev=mem3 pcidev=cxl_mem.3 region= region_uuid=00000000-0000-0000-0000-000000000000 dpa=0x0 length=0x40 source=Internal flags= overflow_time=0

Example, triggered by region:
$ echo 1 > /sys/bus/cxl/devices/region5/trigger_poison_list
cxl_poison: memdev=mem0 pcidev=cxl_mem.0 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0

[1]: https://www.computeexpresslink.org/download-the-specification

Alison Schofield (5):
  cxl/mbox: Add GET_POISON_LIST mailbox command
  cxl/trace: Add TRACE support for CXL media-error records
  cxl/memdev: Add trigger_poison_list sysfs attribute
  cxl/region: Add trigger_poison_list sysfs attribute
  tools/testing/cxl: Mock support for Get Poison List

 Documentation/ABI/testing/sysfs-bus-cxl | 28 +++++++++
 drivers/cxl/core/mbox.c                 | 79 +++++++++++++++++++++++
 drivers/cxl/core/memdev.c               | 45 ++++++++++++++
 drivers/cxl/core/region.c               | 33 ++++++++++
 drivers/cxl/core/trace.h                | 83 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    | 69 +++++++++++++++++++-
 drivers/cxl/pci.c                       |  4 ++
 tools/testing/cxl/test/mem.c            | 42 +++++++++++++
 8 files changed, 382 insertions(+), 1 deletion(-)


base-commit: a6591693d912a1cb88cc5a6d91a7b583481d3a84
-- 
2.37.3

