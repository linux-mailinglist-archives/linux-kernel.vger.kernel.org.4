Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39C77171A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjE3XYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjE3XYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:24:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FADAF7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:24:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso3847307b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685489076; x=1688081076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y478xapysK5Y6/1ukdDKp0Ru49aHZ8upe1tGcc0Bcjo=;
        b=lgr7oULerKqHszxccCrJYVgD/4Mb+Xf93whmI0BJUZ3Rk1zoloaPVLlE5mgGs0zvXC
         Hf2E5AFr6Mal6+7ICofW5MZOPuZN5QViJtY+7GNQcA/knXTMCcPkI455pTbJfnoRCh2Q
         azLiQmFSA0z8hhb0tOjHeEYHnwGauMCNSH3Wn9v7hwAKGgLiVTKiSsLkUQPkbWjkmm5e
         xcfmphymNFDSm7giK0ophLmOwbxkr2PkMsGTSLa62hlUXsUKiujKEFo8vbqPyQKblCDf
         fIYB/qS8IdzILlDY8kcqQzAaoOP9nm/DzWcJD7VYDSFAeeznLTJyaihwFULB+1VoVTCb
         fRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685489076; x=1688081076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y478xapysK5Y6/1ukdDKp0Ru49aHZ8upe1tGcc0Bcjo=;
        b=EXFLm+RIwEaieR+l0dVE/hL4gtSSVGbdVCVXV84tcoaiYjarJ12Jmhd6K0WtDYXrwc
         Kb3LRh8BospfDXiyZQtBHwEDg9v8kzT3acA8l/DvtC9B/S9osh5IgNRTyT4S1KmTLo5t
         AXxVKQ6zVWxBS2wDagXT4v6xATPMASCq1KhrxafN1NvKPoZkFXsjR5st4KzEIRyLbMl+
         9Mo2kKbkqxrmqfrl2UhFosy94OXtZpbPq3f6UHGkWDgooSFXENTeUKMVo6jtiZnwbfvb
         iezwvyrBal9qfij4Qg8vXJ+TffGppAXgbhnVRyXhFg5CkqlOYKdqh0Cff047qRG8aMvz
         tCyQ==
X-Gm-Message-State: AC+VfDz356jMbYut8f2gqP0gmpEs/k8zdOJE9HajORV9EZNQnHh1m+Z7
        BWAPteV8l4MeP4l3+zZ5Jt3RSpgux2I=
X-Google-Smtp-Source: ACHHUZ6XC6V+fXFIqsU0xTsnhBmbya3jQDX3MU9I649f2Oze9PzKhOQsiGByYvvfL11dpEabCVA0/Q==
X-Received: by 2002:a17:902:bb8d:b0:1ac:7ae7:3fdf with SMTP id m13-20020a170902bb8d00b001ac7ae73fdfmr3055806pls.41.1685489076332;
        Tue, 30 May 2023 16:24:36 -0700 (PDT)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902ac8600b001a1c721f7f8sm10821675plr.267.2023.05.30.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:24:36 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@meta.com
Subject: [PATCH v3] zswap: do not shrink if cgroup may not zswap
Date:   Tue, 30 May 2023 16:24:35 -0700
Message-Id: <20230530232435.3097106-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJD7tkaveZ44agL0-iLfHdX1Pm_xEwBSYo=n5Tnm7pVWbsdTug@mail.gmail.com>
References: <CAJD7tkaveZ44agL0-iLfHdX1Pm_xEwBSYo=n5Tnm7pVWbsdTug@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before storing a page, zswap first checks if the number of stored pages
exceeds the limit specified by memory.zswap.max, for each cgroup in the
hierarchy. If this limit is reached or exceeded, then zswap shrinking is
triggered and short-circuits the store attempt.

However, since the zswap's LRU is not memcg-aware, this can create the
following pathological behavior: the cgroup whose zswap limit is 0 will
evict pages from other cgroups continually, without lowering its own
zswap usage. This means the shrinking will continue until the need for
swap ceases or the pool becomes empty.

As a result of this, we observe a disproportionate amount of zswap
writeback and a perpetually small zswap pool in our experiments, even
though the pool limit is never hit.

More generally, a cgroup might unnecessarily evict pages from other
cgroups before we drive the memcg back below its limit.

This patch fixes the issue by rejecting zswap store attempt without
shrinking the pool when obj_cgroup_may_zswap() returns false.

Fixes: f4840ccfca25 ("zswap: memcg accounting")
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 59da2a415fbb..cff93643a6ab 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1174,9 +1174,14 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		goto reject;
 	}
 
+	/*
+	 * XXX: zswap reclaim does not work with cgroups yet. Without a
+	 * cgroup-aware entry LRU, we will push out entries system-wide based on
+	 * local cgroup limits.
+	 */
 	objcg = get_obj_cgroup_from_page(page);
 	if (objcg && !obj_cgroup_may_zswap(objcg))
-		goto shrink;
+		goto reject;
 
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
-- 
2.34.1
