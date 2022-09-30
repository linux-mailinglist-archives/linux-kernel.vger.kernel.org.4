Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5142A5F0E05
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiI3Owu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiI3OwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:52:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50A075814A;
        Fri, 30 Sep 2022 07:50:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C18E143D;
        Fri, 30 Sep 2022 07:49:59 -0700 (PDT)
Received: from pierre123.nice.arm.com (pierre123.nice.arm.com [10.34.100.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 87A083F792;
        Fri, 30 Sep 2022 07:49:51 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH] of: base: Shift refcount decrement in of_find_last_cache_level()
Date:   Fri, 30 Sep 2022 16:49:36 +0200
Message-Id: <20220930144936.2882481-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, of_find_next_cache_node() and of_property_read_u32()
are called on objects after their refcount have been decremented.
Re-order the calls to decrement the refcount after the function
calls.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/of/base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7fa960bd3df1..227819768c6e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2088,12 +2088,13 @@ int of_find_last_cache_level(unsigned int cpu)
 	struct device_node *prev = NULL, *np = of_cpu_device_node_get(cpu);
 
 	while (np) {
+		of_node_put(prev);
 		prev = np;
-		of_node_put(np);
 		np = of_find_next_cache_node(np);
 	}
 
 	of_property_read_u32(prev, "cache-level", &cache_level);
+	of_node_put(prev);
 
 	return cache_level;
 }
-- 
2.25.1

