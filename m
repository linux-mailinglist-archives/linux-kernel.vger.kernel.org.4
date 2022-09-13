Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE15F5B798B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiIMS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiIMS1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C85B6BCFD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA3661547
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E44C433D7;
        Tue, 13 Sep 2022 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091106;
        bh=9TcztpKUfo8rJO30rUXY908EwJFNjnWv9MscjxP6KRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjrzuvWzKjr0o1tHWC3oa/x8CqWNP5PZKYZP/XDN92cM7jK70J4mKUV9vausd238e
         riryqkMtUWxyD/gX5tYUkxQ3P/3zszg9T3RTTLtE0phE7ILox45K92oYXyhMSPTCOk
         CUNOQPWXe34ewcWLx1MgGlrJyzyOtADspV8a+qY/3IG+E/X81uLk0fLip6jGYk58PE
         FkgLBer7nq3bHOUfHrrTi3o8B4uGR+XFGVk2qGgBqPc6twV724Olv2YWOMdKH8HKky
         vCgcKNxYMVV143k4OapjzmPrZd+gqTrVaC9FHYff8un/H22Cc6xjvgRvM0iApFhA0P
         HixvJiwLik+1A==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/22] mm/damon/modules-common: implement a damos quota params generator
Date:   Tue, 13 Sep 2022 17:44:45 +0000
Message-Id: <20220913174449.50645-19-sj@kernel.org>
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

DAMON_RECLAIM and DAMON_LRU_SORT have module parameters for DAMOS quotas
that having same names.  This commit implements a macro for generating
such module parameters so that we can reuse later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index ed973e0770ae..3e99810b4689 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -17,6 +17,12 @@
 	module_param_named(max_nr_regions, attrs.max_nr_regions, ulong,	\
 			0600);
 
+#define DEFINE_DAMON_MODULES_DAMOS_QUOTAS(quota)			\
+	module_param_named(quota_ms, quota.ms, ulong, 0600);		\
+	module_param_named(quota_sz, quota.sz, ulong, 0600);		\
+	module_param_named(quota_reset_interval_ms,			\
+			quota.reset_interval, ulong, 0600);
+
 #define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
 	module_param_named(wmarks_interval, wmarks.interval, ulong,	\
 			0600);						\
@@ -33,5 +39,5 @@
 			0400);						\
 	module_param_named(bytes_##succ_name, stat.sz_applied, ulong,	\
 			0400);						\
-	module_param_named(qt_exceed_name, stat.qt_exceeds, ulong,	\
+	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
-- 
2.25.1

