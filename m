Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E6651120
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiLSRSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiLSRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:18:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43913E15
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 09:18:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 579416108C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 17:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588B5C433F0;
        Mon, 19 Dec 2022 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671470293;
        bh=Az1DXboUgRl+YAMk48Zah7TQBLUIJ4ua1EMPirQ5/3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7iuXB5ZEm6O0EUjdxu5DQDi6cpCEpzeu3Zsa9iJyPi1H/rZSq/6M5VA7cUOv1WH8
         NVdoiSN3kxcVWbmlgVaZARrAW6n7M3KikLiJxzQKSc8wJkL+dPjnJs0eHGv1VmJFep
         4PejNW+g758e7hTjmRmXx/epWzJrVzgg9d3jH1rTSyByV7g1kCvlqvOJ3mtLtC+xwz
         107NmX9Um9h8GKmqextgzKBM75180RfQ0OKBM7t17wNxns3jG9UT+l8hhtX7ss46GO
         L8UX0b7e/kkSZJHB/zhPcbEiNjGNKHGkL+ERT9H9Rww1MgZRTiQVat2VYr0EDmOc7g
         wRi4h5+o1tB7Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH mm-unstable 1/2] mm/damon/sysfs-schemes: Fix leaking a filter for wrong cgroup path
Date:   Mon, 19 Dec 2022 17:18:06 +0000
Message-Id: <20221219171807.55708-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219171807.55708-1-sj@kernel.org>
References: <20221219171807.55708-1-sj@kernel.org>
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

Commit f36f860207efa ("mm/damon/sysfs-schemes: implement scheme
filters") on mm-unstable introduced 'damon_syfs_set_scheme_filters()',
which does not free newly allocated filter when it fails setting memcg
id for the filter.  As a result, the memory for the filter leaks.  Fix
it by freeing the filter before returning the error.

Coverity CID: 1530032

Fixes: f36f860207ef ("mm/damon/sysfs-schemes: implement scheme filters") on mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0501862534f2..5d3ac3107927 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1464,8 +1464,10 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
 			err = damon_sysfs_memcg_path_to_id(
 					sysfs_filter->memcg_path,
 					&filter->memcg_id);
-			if (err)
+			if (err) {
+				damos_destroy_filter(filter);
 				return err;
+			}
 		}
 		damos_add_filter(scheme, filter);
 	}
-- 
2.25.1

