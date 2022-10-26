Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC5C60E81D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiJZTCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiJZTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:00:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C43226AEF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:00:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118E223A;
        Wed, 26 Oct 2022 12:00:11 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.2.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F3073F792;
        Wed, 26 Oct 2022 12:00:02 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob.Herring@arm.com, sudeep.holla@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] cacheinfo: Decrement refcount in cache_setup_of_node()
Date:   Wed, 26 Oct 2022 20:59:54 +0200
Message-Id: <20221026185954.991547-1-pierre.gondois@arm.com>
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

Refcounts to DT nodes are only incremented in the function
and never decremented. Decrease the refcounts when necessary.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/base/cacheinfo.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 1448a329f66d..10ddb05a6e39 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -196,7 +196,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 
 static int cache_setup_of_node(unsigned int cpu)
 {
-	struct device_node *np;
+	struct device_node *np, *prev;
 	struct cacheinfo *this_leaf;
 	unsigned int index = 0;
 
@@ -206,19 +206,24 @@ static int cache_setup_of_node(unsigned int cpu)
 		return -ENOENT;
 	}
 
+	prev = np;
+
 	while (index < cache_leaves(cpu)) {
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
-		if (this_leaf->level != 1)
+		if (this_leaf->level != 1) {
 			np = of_find_next_cache_node(np);
-		else
-			np = of_node_get(np);/* cpu node itself */
-		if (!np)
-			break;
+			of_node_put(prev);
+			prev = np;
+			if (!np)
+				break;
+		}
 		cache_of_set_props(this_leaf, np);
 		this_leaf->fw_token = np;
 		index++;
 	}
 
+	of_node_put(np);
+
 	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
 		return -ENOENT;
 
-- 
2.25.1

