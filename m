Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2EA6728EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjARUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjARUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:02:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FB140BFD;
        Wed, 18 Jan 2023 12:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674072145; x=1705608145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w0nJF/SfMtqsQfQcdbCPiAVqR25TX/a6TRjUl0sBc+g=;
  b=MeF7Yh6hV9M7FW+X0hAszv5i/5SCTdEhnAihwIojoVYaeXQB9ewg9OKE
   0FLO2nqYSRRLys0lP2Rw7H67xBXThudVofSjabdbxm1Wd+31o/0VB0BXi
   sNaogop6UkR8dM5G9juMhfDG2p2g2jUsVVcHpG+fE8RX3z0X4IF9hrDeM
   RAx7UCkNdlEDE5XyjN8c5nnJyCd6nuWOd3ObtcMG26XnK2hA/0oCD6/9B
   1nEnb8K5A3M0nh7TG8Njt3mCc5zbKsnt0zgItwYcS50T90n4JHi738FkT
   G+jj1Hjr0vvGPX2GAK3leNhDoR9so89FAiVOdN6srQ+9Cmn7KnoMP10hr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322776770"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322776770"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:02:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661861657"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661861657"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.119.104])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:02:24 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
Date:   Wed, 18 Jan 2023 12:02:16 -0800
Message-Id: <cover.1674070170.git.alison.schofield@intel.com>
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

Subject: [PATCH v5 0/5] CXL Poison List Retrieval & Tracing

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

