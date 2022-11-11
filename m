Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7AB625153
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiKKDMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKDMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:12:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCF72F002;
        Thu, 10 Nov 2022 19:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668136370; x=1699672370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WgsIHQ7cBq3X+wX4cmKs6enEa7opFzpuRhwIqRJdRRg=;
  b=btgw4n/4pDKkNQvSScmH++zYlua0QFtlewSpC4Vbg3JsdaMLPRlS+iUv
   GShrdckHbs7MkJ1WXVgW9UEZtUxcBFeqo6C7/UP4dHyVbzTZR+cXWr5W2
   FVDMdcbCtJhCfWXAKwMLV9z/C4kXvhoDybRZyIZFOFcIir7wjTuQCmQSm
   ZQ9razrkbLYQ+r2IrncFtw9PCTXgMzSEv8Yl1WEgwAG4zQwgTDlcuDaZl
   aBqGmpcJVwqhffi9uRZzQ5ExYzboEqO54WP4K0tirCKDt8ZSo+ODv2Wus
   Pf7GKNGwMixkqAsVGnpQJb1DacdP3PNSG4ALAoHVB1niOBlBpQoI4FqaI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310224393"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="310224393"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812296037"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="812296037"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.161.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:48 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] CXL Poison List Retrieval & Tracing
Date:   Thu, 10 Nov 2022 19:12:38 -0800
Message-Id: <cover.1668115235.git.alison.schofield@intel.com>
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

Changes in v3:
- Rebase to 6.1-rc4
- Rebase picked up cxl_dpa_resource_start() (Jonathan)
- Move poison source defines to cxlmem.h from events/cxl.h
- TRACE_printk helper macros display 'Reserved' for illegal poison sources
  rather than failing to parse.
- Add region uuid to the trace event.
- Always get poison, but only parse records if tracing is enabled.(Steve)
  There was a little foresight on not moving the calcs to the event
  definition itself, as Steve also suggested. The DPA->HPA translation
  is coming, and that work seems better kept in the driver itself.
- Remove unused hpa trace field. Add back when hpa is available.
- Remove pid from cxl_poison event. Find in common event field. (Steve)
- cxl_test: Add mock support for get poison

Changes in v2:
- Added per region poison collection 
- Protect poison list w mutex
- Replace range usage w resource
- S/poison_max_mer/poison_max in cxl_dev_state kdoc (Ira)
- Renamed sysfs attribute to 'trigger_poison_list'
- _store() rm chatty dev_err() msgs (Jonathan, Dan)
- _store() use kstrtobool (Jonathan, Dan)
- _store() simplify return (Jonathan)
- cxl_memdev_visible() skip local vars on way enabled_cmds (Jonathan)
- cxl_memdev_visible() use kobj_to_dev() helper (Dan)
- Misc name shortenings and cleanups.
- Replace goto w break in cxl_mem_get_poison() do-while loop.
- Don't error out on FLAGS, record in trace event.
- Add kernel CXL_POISON__LIST_MAX (64) and guard against exceeding (Dan)
- Add current->pid to trace  (Dan)
- Return the poison length as multiple of 64 per spec (Jonathan)
- Mask starting address from record->address (Jonathan)
- Move range selection to sysfs_store and make cxl_mem_get_poison() accept it.
- Get both the volatile & persistent ranges per memdev.
- Add pci device name to trace (Dan)

[1]: https://www.computeexpresslink.org/download-the-specification

Alison Schofield (6):
  trace, cxl: Introduce a TRACE_EVENT for CXL poison records
  cxl/mbox: Add GET_POISON_LIST mailbox command
  cxl/memdev: Add trigger_poison_list sysfs attribute
  cxl/region: Add trigger_poison_list sysfs attribute
  tools/testing/cxl: Mock the max err records field of Identify cmd
  tools/testing/cxl: Mock the Get Poison List mbox command

 Documentation/ABI/testing/sysfs-bus-cxl | 28 +++++++++
 drivers/cxl/core/mbox.c                 | 81 +++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               | 41 +++++++++++++
 drivers/cxl/core/region.c               | 33 ++++++++++
 drivers/cxl/cxlmem.h                    | 51 ++++++++++++++++
 include/trace/events/cxl.h              | 80 ++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c            | 35 +++++++++++
 7 files changed, 349 insertions(+)
 create mode 100644 include/trace/events/cxl.h


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.37.3

