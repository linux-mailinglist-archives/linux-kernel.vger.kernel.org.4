Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4FB5FCD23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJLV23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJLV20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:28:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11DB11C247;
        Wed, 12 Oct 2022 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665610105; x=1697146105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0FMCWRAI1dAKY7B5R+gBxchbC3XUDnaCz6eatb4vhas=;
  b=b/mrMbg6YbfjcN49pkYiXLDJcND3pFYXj+Hd6o44HKnTQRQelyvzksVV
   XQys9zjBfAVaS90ZCOf15uUIpz17RLqt+i+HB9xfLa1KzKRL/1N5mwhMg
   CWfiv9hLkzb+536kYQAKOa8+iu5RPpWCOiIBinDPdLAPhKKhFo/IcoZid
   T5rQ3pe4hr97Yw1R9SvPAbKpqGNtyNYQH3UxFv+fI+6ERcwCrSOlW2g5t
   cuNapHzbjHSwW6RUGppwiYgOkz8eV+/pqC7aJ6x3ULeuNwbXaOtkfqKz2
   0kPb2t9WXCGdPdz++dJGUUi8mOHmJEBNyWZWO1eR8K/9hn56wX2V6ESV0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="306543864"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="306543864"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:28:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="689834222"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="689834222"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.3.191])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:28:23 -0700
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
Subject: [PATCH v2 0/4] CXL Poison List Retrieval & Tracing
Date:   Wed, 12 Oct 2022 14:28:16 -0700
Message-Id: <cover.1665606782.git.alison.schofield@intel.com>
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

Adds support for retrieving device poison lists and
store the returned error records as kernel trace events.

The handling of the poison list is guided by the CXL 3.0 Spec
Section 8.2.9.8.4.1. [1] 

Example command line usage:

Triggered by memdev:
$ echo 1 > /sys/bus/cxl/devices/mem1/trigger_poison_list

cxl_poison:           pid:981 region: memdev:mem1 pcidev:cxl_mem.1 hpa:0x0 dpa:0xc0 length:0xc0 source:Internal flags: overflow_time:0
cxl_poison:           pid:981 region: memdev:mem1 pcidev:cxl_mem.1 hpa:0x0 dpa:0x180 length:0x100 source:Injected flags: overflow_time:0

Triggered by region: (region name is included in the trace)
$ echo 1 > /sys/bus/cxl/devices/region5/trigger_poison_list

cxl_poison:           pid:1132 region:region5 memdev:mem2 pcidev:cxl_mem.2 hpa:0x0 dpa:0x0 length:0x40 source:Unknown flags: overflow_time:0
cxl_poison:           pid:1132 region:region5 memdev:mem2 pcidev:cxl_mem.2 hpa:0x0 dpa:0x40 length:0x80 source:External flags: overflow_time:0

Changes v1->v2
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

Alison Schofield (4):
  trace, cxl: Introduce a TRACE_EVENT for CXL poison records
  cxl/mbox: Add GET_POISON_LIST mailbox command
  cxl/memdev: Add trigger_poison_list sysfs attribute
  cxl/region: Add trigger_poison_list sysfs attribute

 Documentation/ABI/testing/sysfs-bus-cxl | 28 ++++++++
 drivers/cxl/core/mbox.c                 | 69 +++++++++++++++++++
 drivers/cxl/core/memdev.c               | 41 ++++++++++++
 drivers/cxl/core/region.c               | 34 ++++++++++
 drivers/cxl/cxlmem.h                    | 42 ++++++++++++
 include/trace/events/cxl.h              | 88 +++++++++++++++++++++++++
 6 files changed, 302 insertions(+)
 create mode 100644 include/trace/events/cxl.h


base-commit: 1985cf58850562e4b960e19d46f0d8f19d6c7cbd
-- 
2.37.3

