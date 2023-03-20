Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D334F6C09AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCTEb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCTEb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:31:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899241689C;
        Sun, 19 Mar 2023 21:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679286715; x=1710822715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uXmcZSJVUqvEO9HcOc8C5r/Be3mOVMDA+Tjn5ckkFtI=;
  b=m/LpPXtcCiLcZeEBiCPgrCunmS3N3UtPrZq2OYrYTt/Sf+5ftQOdtvi3
   M4f886AXH4go8K/qruzXnymRw2B2E59RFuSb/mf6AT5tQnbVjLeItz/4l
   pG7ZDGf2YoYMP1VvvhYxsLBNRomhguXP7pY/41rHEYWB5buJBO7eEFaGM
   nlpnWkAkLtJ7/Py+MAfqRTh4pBgoaF+bcnXyHWjfO+MXabq8AAnOqEhzm
   zWddYdPzIVGX3lBHMBB7s2KE3i/bBxSGb6ZQiAnTwyO0nAwYRQPD46R7F
   QPjM92GYxq50YRijYtsr0bnp7m3r5hNzHQrS90yqu7MTZam0TdpuA5Wqs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="337287503"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="337287503"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 21:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="926823978"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="926823978"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.14.183])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 21:31:54 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/6] CXL Poison List Retrieval & Tracing
Date:   Sun, 19 Mar 2023 21:31:45 -0700
Message-Id: <cover.1679284567.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v9:

Patch 3: cxl/memdev: Add trigger_poison_list sysfs attribute
- Make trigger_poison_list a driver attribute to protect against unbinds
  while poison is being read. (Dan)

Patch 4: cxl/region: Provide region info to the cxl_poison trace event
- Remove already held cxl_dpa_rwsem in cxl_get_poison_by_endpoint() (Ira)
- Add hold of cxl_region_rwsem in cxl_get_poison_by_endpoint()
- Move the 'remains' handling to memdev driver (Ira)
  Previously, after the region driver read poison for the last committed
  endpoint decoder, it also read poison for remaining unmapped resources.
  Add a context struct to pass the poison read state between memdev and
  region drivers, so that memdev driver can complete the poison read of
  unmapped resources.

Patches 1,2,5,6: no changes.

Link to v8:
 https://lore.kernel.org/linux-cxl/cover.1678468593.git.alison.schofield@intel.com/

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

 Documentation/ABI/testing/sysfs-bus-cxl |  14 +++
 drivers/cxl/core/core.h                 |  11 +++
 drivers/cxl/core/mbox.c                 |  74 ++++++++++++++++
 drivers/cxl/core/memdev.c               | 108 ++++++++++++++++++++++++
 drivers/cxl/core/region.c               |  63 ++++++++++++++
 drivers/cxl/core/trace.c                |  94 +++++++++++++++++++++
 drivers/cxl/core/trace.h                |  91 ++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  72 +++++++++++++++-
 drivers/cxl/mem.c                       |  36 ++++++++
 drivers/cxl/pci.c                       |   4 +
 tools/testing/cxl/test/mem.c            |  42 +++++++++
 11 files changed, 608 insertions(+), 1 deletion(-)


base-commit: e686c32590f40bffc45f105c04c836ffad3e531a
-- 
2.37.3

