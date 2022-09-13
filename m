Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384295B798A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiIMS3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiIMS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:27:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944D76CD04
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49295B80DCB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BE6C433D6;
        Tue, 13 Sep 2022 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091106;
        bh=TpMHecuKvtdBhnIMulCBOg8dzHSBCxkP4seXXVnf3o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdCE6iWv9HhVPN7MDQ52uUfmE9OXzgOLz0P+fJP2LIXptahcOXvoBkHEsLBhTSNwj
         xrLhrofoeYdhxmr0yF7a9NMGGDXsSOljaMebIelpbFB5SJEFGCEXreNc8EtkI7kSdn
         r33Ic3xkizh+xPUXJkZ/yCPD+mWOBL4ziEy43+5GPf9xdeZC+m7ehB8eMXmCyQdqPl
         AWMHQKAJUvl3RTuI9Qf8lDnEWxDh20IBq6s3CQddOaQefJP/7BVsq3f5l0pR4NKxK8
         bqS/45DdTR5fiyGxW4N3AFYecqAu2+uW3DvrNqhWmbaZOUBIpyE940+uN56FuVnODK
         ezKyQ6CsrnXmA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/22] mm/damon/modules-common: implement damos time quota params generator
Date:   Tue, 13 Sep 2022 17:44:46 +0000
Message-Id: <20220913174449.50645-20-sj@kernel.org>
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

DAMON_LRU_SORT have module parameters for DAMOS time quota only but size
quota.  This commit implements a macro for generating the module
parameters so that we can reuse later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index 3e99810b4689..5a4921851d32 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -17,12 +17,15 @@
 	module_param_named(max_nr_regions, attrs.max_nr_regions, ulong,	\
 			0600);
 
-#define DEFINE_DAMON_MODULES_DAMOS_QUOTAS(quota)			\
+#define DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(quota)			\
 	module_param_named(quota_ms, quota.ms, ulong, 0600);		\
-	module_param_named(quota_sz, quota.sz, ulong, 0600);		\
 	module_param_named(quota_reset_interval_ms,			\
 			quota.reset_interval, ulong, 0600);
 
+#define DEFINE_DAMON_MODULES_DAMOS_QUOTAS(quota)			\
+	DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(quota)			\
+	module_param_named(quota_sz, quota.sz, ulong, 0600);
+
 #define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
 	module_param_named(wmarks_interval, wmarks.interval, ulong,	\
 			0600);						\
-- 
2.25.1

