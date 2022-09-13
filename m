Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828475B7979
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiIMS2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIMS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C1659C5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 415C6B80CBC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92E0C43142;
        Tue, 13 Sep 2022 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091101;
        bh=kK1sxLOXEkaoDNnV++Rope2Ec8RZDVijxu5erLk09sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdVSywTxsq0Xeh3ZASYyycbEgiYJiKaQ5ta5McLxvRu2AiXwWQowXtIqqKC41LuQw
         hNgbHrDkc2xHScq2yRGwn6raCF4mMNpeuEtyZd4GNyM1cuxyYgOG5mgrURSS4LNa8D
         IK+Ip4ztkqRC7f8WiHYYRDMxavuASn6po6rLCFsQuPVfL7U/D40W7VsMfLMcCT6rjp
         Pie2gHvvQwJBFQq4xoJaJ6J5hEuuMj7Nn3eTT1yiN1/HuRhLEdLX5ZLyQPMDwAXDcO
         PHWGYlKXvIW2ZUztbr9nMwaqDBkUGZuq57AAB7uZrwRhk/K5KawdsTv8P/lpsXOSZm
         Sez7g0v2A+9Mg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH 09/22] mm/damon: implement a monitoring attributes module parameters generator macro
Date:   Tue, 13 Sep 2022 17:44:36 +0000
Message-Id: <20220913174449.50645-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON_RECLAIM and DAMON_LRU_SORT have module parameters for monitoring
attributes that having same names.  This commot implements a macro for
generating such module parameters so that we can reuse later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 mm/damon/modules-common.h

diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
new file mode 100644
index 000000000000..0abd0636bc64
--- /dev/null
+++ b/mm/damon/modules-common.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common Primitives for DAMON Modules
+ *
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#include <linux/moduleparam.h>
+
+#define DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(attrs)			\
+	module_param_named(sample_interval, attrs.sample_interval,	\
+			ulong, 0600);					\
+	module_param_named(aggr_interval, attrs.aggr_interval, ulong,	\
+			0600);						\
+	module_param_named(min_nr_regions, attrs.min_nr_regions, ulong,	\
+			0600);						\
+	module_param_named(max_nr_regions, attrs.max_nr_regions, ulong,	\
+			0600);
-- 
2.25.1

