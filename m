Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE17664658D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLHAB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLHABu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:01:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4004A5BD62;
        Wed,  7 Dec 2022 16:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670457709; x=1701993709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qlb/4/MOpVtK0Wz4xUZApPMqw5HrbXVQPBBo1lk3Rzk=;
  b=hijhfnAHWYhigHskBwlbbyT2KquvzgUHftISWZfZ6xyOcK+StetkrVfa
   4Z7B3Ac8iqx5dp4z0rLrzZ5qXfUaPt6d8ZkXiSEVWvzB0oOVYxV2FlCG6
   d2ENV5ItS0a5pXGN9k9n8Mk2kuF9aekd2DDNC98BeDTHQ5lCycH7d/0yu
   pcoOZRCDgU23U++BQmvsRguikQWzHRdOGbF4FYjgnT+ZHPlJfwtFcqalv
   +IqaN/3qjZosLeqkg2Bq/TU94yIzOmz8EMYZ1seQaBYlVTQNAtGawiwu2
   k7a/TZLJg6ppfuLO+WrvB0IHqw+UYpbkFkaTfKBEfxdO/mn9sqYQ5Wt9i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297391101"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="297391101"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 16:01:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="646799678"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="646799678"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.25.22])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 16:01:43 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/uapi: Add warning on CXL command enum
Date:   Wed,  7 Dec 2022 16:01:41 -0800
Message-Id: <20221208000141.701642-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
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

From: Ira Weiny <ira.weiny@intel.com>

The CXL command enum is exported to user space and must maintain
backwards compatibility.

Add comment that new defines must be added to the end of the list.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/uapi/linux/cxl_mem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c71021a2a9ed..459a3f7f764b 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -19,6 +19,10 @@
 #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
 #define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
 
+/*
+ * NOTE: New defines must be added to the end of the list to preserve
+ * compatibility because this enum is exported to user space.
+ */
 #define CXL_CMDS                                                          \
 	___C(INVALID, "Invalid Command"),                                 \
 	___C(IDENTIFY, "Identify Command"),                               \

base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e
-- 
2.37.2

