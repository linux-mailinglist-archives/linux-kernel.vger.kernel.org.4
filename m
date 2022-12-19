Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71D0651373
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiLSTvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiLSTu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:50:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B50D117;
        Mon, 19 Dec 2022 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AlvpYVcs/x5S41hvTdL+jGslAuM/L8CEpzIkpPoNAWg=; b=dJCjhk4sC2g9tG/uSFGrtuUSwT
        HpWlXFxcvqRPHdwpBloZNZCHHWvGC8YbVA8mvQV8jemQxEKUQ6kOqbprKjiLBy/ViaDyDBgYaXK6G
        BRgbXJFPm+eMP5jakYxWtcyLSqPcJXKk9Uo23YtoPncW24C7uR4V/Fz+RIeWtwWKHlKPiFNjTFYmL
        m5vH7dqxWiF2TdHKoxaxj8DttEJNEtTo66QLMpg7HEkKVG/FsNScjTx9Clhtw8WD1SmvgKi7wrbll
        tndVgcSmX8Ccefc5ySuASy7SOTR4tqHaMKJ566kDPhWZICTcysJ5rYNj9q07TnB4nHZ6TUQUFXd3Q
        ZqLlIbMw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7MA1-001MzD-2K; Mon, 19 Dec 2022 19:50:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     dave@stgolabs.net, a.manzanares@samsung.com, mcgrof@kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl_test: require 64-bit
Date:   Mon, 19 Dec 2022 11:50:50 -0800
Message-Id: <20221219195050.325959-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

size_t is limited to 32-bits and so the gen_pool_alloc() using
the size of SZ_64G would map to 0, triggering a low allocation
which is not expected. Force the dependency on 64-bit for cxl_test
as that is what it was designed for.

This issue was found by build test reports when converting this
driver as a proper upstream driver.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/cxl/config_check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/cxl/config_check.c b/tools/testing/cxl/config_check.c
index c4c457e59841..99b56b5f6edf 100644
--- a/tools/testing/cxl/config_check.c
+++ b/tools/testing/cxl/config_check.c
@@ -7,6 +7,7 @@ void check(void)
 	 * These kconfig symbols must be set to "m" for cxl_test to load
 	 * and operate.
 	 */
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_64BIT));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_BUS));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_ACPI));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_PMEM));
-- 
2.35.1

