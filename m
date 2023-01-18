Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270A36729D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjARVAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjARU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:59:58 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2623F6049C;
        Wed, 18 Jan 2023 12:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674075589; x=1705611589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UZr+y7YjygeR8zirILd/pq2MOnSrrVweQbKlUNOy8GU=;
  b=SSYtiGZTVTtEJK7PJgyPQhIyt7rI4f49Q14oo2knSGq64ybvzPc7lk7U
   yYPPW9fK5YkIiEMqK7zW5NR2QFzkzqQWxHcSdDrtplC518RfkZRDrCGp7
   76y/EoSLaUbIJYlWzqs90BNZAhfTjrjYtVnIZc3HobfnzWH6gytAqnX9Z
   fO+ZAh1QjLHonZIgMNy5EFIFO7UDL3GZLVGzCGxOkQ8ayGoiVdsoQzHkS
   hYNK1AvjcyqWinnCbhz/9e5cgv+Q+6p6e9fze+bcTBTOUn6TV8sW70PdV
   WHUIRxA71uub08CHZZ/Va53Qu3Yr5yGArH08RyGQesDM8VId4bmJnVVaP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308660500"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="308660500"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:59:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="692160802"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="692160802"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.119.104])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:59:48 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] CXL Poison List Retrieval & Tracing
Date:   Wed, 18 Jan 2023 12:59:45 -0800
Message-Id: <cover.1674070170.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1674070170.git.alison.schofield@intel.com>
References: 
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

**RESENDING this cover letter previously mis-threaded.

Changes in v5:
- Rebase on cxl/next 
- Use struct_size() to calc mbox cmd payload .min_out
- s/INTERNAL/INJECTED mocked poison record source
- Added Jonathan Reviewed-by tag on Patch 3

Link to v4:
https://lore.kernel.org/linux-cxl/cover.1671135967.git.alison.schofield@intel.com/

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
 drivers/cxl/core/mbox.c                 | 78 +++++++++++++++++++++++
 drivers/cxl/core/memdev.c               | 45 ++++++++++++++
 drivers/cxl/core/region.c               | 33 ++++++++++
 drivers/cxl/core/trace.h                | 83 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    | 69 +++++++++++++++++++-
 drivers/cxl/pci.c                       |  4 ++
 tools/testing/cxl/test/mem.c            | 42 +++++++++++++
 8 files changed, 381 insertions(+), 1 deletion(-)


base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
-- 
2.37.3

