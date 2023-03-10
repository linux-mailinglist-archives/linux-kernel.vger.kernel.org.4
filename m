Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2647F6B4F95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCJRym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjCJRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:54:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA012DC1E;
        Fri, 10 Mar 2023 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678470865; x=1710006865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yg7rLleJHpQrJEZr9+dilAMgQAds5aikhGZNVyfiArY=;
  b=b5LzyzZG4Si4qpFnYPyRW/tPa1u3JyZTDlHSdP0jtD9UL449YRprUX/j
   DCYSeJ8sh7YzVz1zqUasgaTASJRSD3FVS1rCzoHR3zL4ETKhq5mzl/3Y9
   6LyJ6bLUqy4dQMgrkOUx+5mdjxNVpG9hNa6Z5Q2Hg8RjqQOLs/4fR0eUU
   umYRG0cGzK3xGz8FAb8MWPsfaPhO5cXkRMdzKIdij6szhzsN7Xe1XMGdS
   8kiAp90Zax3GkjlfekwvYoeJvp9P9NTKgWWB5wDqqHSiQgHEyArTmjlei
   yDRmMkH76aXkTWIXeeWZyiwxy9/54I2HnuDB0MfbEQ9viR5SBDNSwyP7j
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="339154030"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="339154030"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="680276537"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="680276537"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.255.228.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:54:22 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/6] CXL Poison List Retrieval & Tracing
Date:   Fri, 10 Mar 2023 09:54:14 -0800
Message-Id: <cover.1678468593.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v8:

Patch 4: cxl/region: Provide region info to the cxl_poison trace event
- Don't percolate non-error rc in trigger_poison_list_store() (Jonathan)
- Use the entire dpa_res, not pmem_res, when calculating remaining length
  after a PMEM decoder. (Jonathan)
- Calculate skip relative to current endpoint. (Jonathan)
- Always use local vars for offset & length (Tidy-up)

Patch 3: cxl/memdev: Add trigger_poison_list sysfs attribute
- Update dates and version in Patch 3: ABI doc (Jonathan)
- Added Jonathan Reviewed-by to Patch 3 (Jonathan)

Link to v7: https://lore.kernel.org/linux-cxl/cover.1676685180.git.alison.schofield@intel.com/#r

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
 drivers/cxl/core/memdev.c               | 71 ++++++++++++++++++
 drivers/cxl/core/region.c               | 96 +++++++++++++++++++++++++
 drivers/cxl/core/trace.c                | 94 ++++++++++++++++++++++++
 drivers/cxl/core/trace.h                | 91 +++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    | 69 +++++++++++++++++-
 drivers/cxl/pci.c                       |  4 ++
 tools/testing/cxl/test/mem.c            | 42 +++++++++++
 10 files changed, 559 insertions(+), 1 deletion(-)


base-commit: e686c32590f40bffc45f105c04c836ffad3e531a
-- 
2.37.3

