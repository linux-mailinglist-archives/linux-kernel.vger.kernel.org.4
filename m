Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453AF672E71
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjASBt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjASBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823A06CCC3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:38:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC56DB81FB1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FDAC433EF;
        Thu, 19 Jan 2023 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674092318;
        bh=fkjQwp0vLjtzRNvd4VhBq2nF7CfFg6frjzTnDoBz50k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnXTVAitPDgUvsOiX6vW9aROGzCslmoqZfT8CZ2eLQCt4U75qjK1GOtsmFX5Hh1mL
         GHkICAtA9fIez2uteqBjb+qkYlDqDgZoVFOyaA4k/GTtblnEyhvBhAtb4e4LVws6Qp
         DA9xynr2yHeQuGfMie535L77J68Rf4loZ8vsr36yvq7yvQL4QJvvOEOs1qtxUHHtBx
         eUoZBktQdw6BQ+9ajw8kIqoYs6Jgg2rVBMLS5qY0Iq/Jrrd97ra5R6/NBQbhXbH+Sh
         OBWxwozsw+MPupdH+wpqF7B5X13pWPDxxv1U/jyd8aViHxPxoVK+3G1FYOFKLnTa3g
         k+lZHNQuKqP+A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/damon: update comments in damon.h for damon_attrs
Date:   Thu, 19 Jan 2023 01:38:29 +0000
Message-Id: <20230119013831.1911-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119013831.1911-1-sj@kernel.org>
References: <20230119013831.1911-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cbeaa77b0449 ("mm/damon/core: use a dedicated struct for
monitoring attributes") moved monitoring intervals from damon_ctx to a
new struct, damon_attrs, but a comment in the header file has not
updated for the change.  Update it.

Fixes: cbeaa77b0449 ("mm/damon/core: use a dedicated struct for monitoring attributes")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index dfb245bb3053..d5d4d19928e0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -354,10 +354,10 @@ struct damon_ctx;
  * users should register the low level operations for their target address
  * space and usecase via the &damon_ctx.ops.  Then, the monitoring thread
  * (&damon_ctx.kdamond) calls @init and @prepare_access_checks before starting
- * the monitoring, @update after each &damon_ctx.ops_update_interval, and
+ * the monitoring, @update after each &damon_attrs.ops_update_interval, and
  * @check_accesses, @target_valid and @prepare_access_checks after each
- * &damon_ctx.sample_interval.  Finally, @reset_aggregated is called after each
- * &damon_ctx.aggr_interval.
+ * &damon_attrs.sample_interval.  Finally, @reset_aggregated is called after
+ * each &damon_attrs.aggr_interval.
  *
  * Each &struct damon_operations instance having valid @id can be registered
  * via damon_register_ops() and selected by damon_select_ops() later.
-- 
2.25.1

