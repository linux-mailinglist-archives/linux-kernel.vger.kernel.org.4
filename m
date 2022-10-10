Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56AC5FA7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJJWnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJJWnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C079ED2;
        Mon, 10 Oct 2022 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441783; x=1696977783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GHg+OpdCAwwsgQj0WcbIsY4FFI2ZaIFvO/2D/JGuRHQ=;
  b=hXCwXTYjizVAlpUhfZaQqBkUvqVZm/BBMujAr/BapK5QzrhLDnitQsUr
   gQWF/zqZGjrTPrLKy1Meq5XN1jlO3ezFLez3HIbTfkTBgczHRukChg2LF
   9iAb4MfXH/N7ow41zRAvkluUjt1EE4Ztx4wntrYtCjGcukQUi4WOjbQiw
   BG38skXbzm/QNWR8vuSvcJUomLIDXf9OPgd1AnUQV/PNf76cBOX3o/5EU
   0EWBTDVKnmzvraHphuN7nVFqDdmaNvGUCVlwQY033f97u6LRjk7QDsodf
   XAKTZ4ws8+pfSj41qdC8d1C2xU1LogFjjvjlv2pLqVChMvP7QDfXQyVLI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615372"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615372"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191323"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191323"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:02 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [RFC V2 PATCH 00/11] CXL: Process event logs
Date:   Mon, 10 Oct 2022 15:41:20 -0700
Message-Id: <20221010224131.1866246-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
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

From: Ira Weiny <ira.weiny@intel.com>

Changes from RFC v1
	Add event irqs
	General simplification of the code.
	Resolve field alignment questions
	Update to rev 3.0 for comments and structures
	Add reserved fields and output them

Event records inform the OS of various device events.  Events are not needed
for any kernel operation but various user level software will want to track
events.

Add event reporting through the trace event mechanism.  On driver load read and
clear all device events.

Enable all event logs for interrupts and process each log on interrupt.

Testing of this was performed with additions to QEMU posted here:

	https://lore.kernel.org/all/20221010222944.3923556-1-ira.weiny@intel.com/

Ira Weiny (11):
  cxl/mbox: Add debug of hardware error code
  cxl/mem: Implement Get Event Records command
  cxl/mem: Implement Clear Event Records command
  cxl/mem: Clear events on driver load
  cxl/mem: Trace General Media Event Record
  cxl/mem: Trace DRAM Event Record
  cxl/mem: Trace Memory Module Event Record
  cxl/test: Add generic mock events
  cxl/test: Add specific events
  cxl/test: Simulate event log overflow
  cxl/mem: Wire up event interrupts

 MAINTAINERS                     |   1 +
 drivers/cxl/core/mbox.c         | 186 ++++++++++++-
 drivers/cxl/cxlmem.h            | 193 +++++++++++++
 drivers/cxl/pci.c               | 154 ++++++++++
 include/trace/events/cxl.h      | 478 ++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h    |   4 +
 tools/testing/cxl/test/Kbuild   |   2 +-
 tools/testing/cxl/test/events.c | 329 ++++++++++++++++++++++
 tools/testing/cxl/test/events.h |   9 +
 tools/testing/cxl/test/mem.c    |  34 +++
 10 files changed, 1388 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/cxl.h
 create mode 100644 tools/testing/cxl/test/events.c
 create mode 100644 tools/testing/cxl/test/events.h


base-commit: e2302539dd4f1c62d96651c07ddb05aa2461d29c
-- 
2.37.2

