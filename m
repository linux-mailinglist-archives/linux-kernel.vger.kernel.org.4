Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42340691480
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjBIXe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjBIXey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:34:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5DB656AE;
        Thu,  9 Feb 2023 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675985670; x=1707521670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HaeM+wilmzH9lkMsRKAaYMvtL58J3QbWvK5gMOvUqJU=;
  b=KXdWqpOkfiQM4cqG7hzlu0dWBPRYHli2PFbhd0s8CYZQwBNROqZX3oy4
   bY0h0ateX+vr0BtZHJwX7nN6DMpDrqHb9c+4dmHz4LN1E6+r3at1Anw3X
   AJa2fLO+vNePrWtkl22hVyxRY8aXK/HvXbibFXxZMaIRMPSxVr/lhbB0h
   gL1ZLakHMmuV4IR6jTXie7vCpeONxZrFX2ixmkAj0twXzfR15kw24fev1
   7KYk8mWhvNoBuQWQmzzHOg4Xf2Vne2zumJIQuTJFzk6rmSfE8BjLH9JnU
   q21C7H89xZ9owlXdN55IuNWX5S+SaBCcwkabC+OThkRqGKIMHaIZ6HIkp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416508686"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="416508686"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756592021"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="756592021"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.13.232])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:01 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] CXL Poison List Retrieval & Tracing
Date:   Thu,  9 Feb 2023 15:32:53 -0800
Message-Id: <cover.1675983077.git.alison.schofield@intel.com>
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

This is not targeting the 6.3 merge window.

Changes in v6:
- Remove the ABI that collected poison per region, and added the
  region info to the per memdev collection.  (Dan)
  This means Patch 4 is brand new:
  	cxl/region: Provide region info to the cxl_poison trace event

- Also added Patch 5: cxl/trace: Add an HPA to cxl_poison trace events
  to this set. It comes w a couple of Review Tags, and is unchanged,
  from a v2 last posted upstream.
- Dropped Jonathan's Review on Patch 3 because of changes
- Remove local var 'cxlps' (cxl_poison_state) (Dan)
- Trigger sysfs attr on boolean truisms only (Dan)
- Remove unneeded param pcidev from trace call. 
- Mock: add __packed, and le64_to_cpu(() (Dan)
- Abbreviate less: s/max_mer/max_errors (Dan)
- Rename trace field 'pcidev', 'host' (Dan)
- getpoison_po/payload_out (Dan)
- Add serial no. to trace (Dan)
- s/getpoison_lock/lock (Dan)
- s/tmp/trigger

Link to v5: https://lore.kernel.org/linux-cxl/cover.1674070170.git.alison.schofield@intel.com/

Add support for retrieving device poison lists and store the returned
error records as kernel trace events.

The handling of the poison list is guided by the CXL 3.0 Specification
Section 8.2.9.8.4.1. [1] 

Example:
$ echo 1 > /sys/bus/cxl/devices/mem0/trigger_poison_list
cxl_poison: memdev=mem0 serial=0 host=cxl_mem.0 region=region4 region_uuid=117b2cf4-b160-4090-9361-ba31b9649317 hpa=0xf0d0000000 dpa=0x40000000 length=0x40 source=Internal flags= overflow_time=0

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
 drivers/cxl/core/region.c               | 82 +++++++++++++++++++++
 drivers/cxl/core/trace.c                | 94 +++++++++++++++++++++++++
 drivers/cxl/core/trace.h                | 92 ++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    | 69 +++++++++++++++++-
 drivers/cxl/pci.c                       |  4 ++
 tools/testing/cxl/test/mem.c            | 42 +++++++++++
 10 files changed, 543 insertions(+), 1 deletion(-)


base-commit: dbe9f7d1e155b97a42f7da81e22acc98fe0a9072
-- 
2.37.3

