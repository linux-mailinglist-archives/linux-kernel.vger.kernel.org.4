Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35DC62884F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiKNSaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbiKNSaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:30:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E511A2BB35
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93279B8114B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E15C433C1;
        Mon, 14 Nov 2022 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668450605;
        bh=xilSGlQYchsVmmKikIJMaS8XjvWaQ2LB9bIwb65/qKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swj2BFaQreATJBLs249o+BEvmHBNmuMldNlErlB/B8b9dA22U3sLrY9JShtl3euSQ
         LUc6YwbdvRPS2ozuIqEQEBnl0d69Is6VtnYjjY9at5mu9FXSttoIGplB/W7oT1oETx
         Bg5vWylJKHenAihciGdnpQLmqsR40s7x4mCjxqZzarjbfJAhtbKOh3HvWpLRiufxuf
         swEFNl8tFd4BuigWfcY2gMP5XJhOtmtc1aftM+cJkC2hGYAE6ag8mqW8UZW3eWp4cW
         08HZe+AKn82IERaTJkXuoH6QLoQHIl9gbSUgUOtkzK/ZDCz5xXKMUIZZvT6toGxT7K
         rIhOCkkEEzaKA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable 1/2] mm/damon/sysfs-schemes: skip tried regions update if the scheme directory has removed
Date:   Mon, 14 Nov 2022 18:29:53 +0000
Message-Id: <20221114182954.4745-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114182954.4745-1-sj@kernel.org>
References: <20221114182954.4745-1-sj@kernel.org>
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

A DAMON sysfs interface user can start DAMON with a scheme, remove the
sysfs directory for the scheme, and then ask updates of the scheme's
tried regions.  Because the schemes tried regions update logic doesn't
aware of the situation, it results in an invalid memory access.  Fix the
bug by checking if the scheme sysfs directory exists.

Fixes: 1322c8148dfe ("mm/damon/sysfs: implement DAMOS tried regions update command") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a79aa32d3422..4df3c99983e8 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1231,6 +1231,11 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 			break;
 		schemes_idx++;
 	}
+
+	/* user could removed the scheme sysfs dir */
+	if (schemes_idx >= sysfs_schemes->nr)
+		return 0;
+
 	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
 	region = damon_sysfs_scheme_region_alloc(r);
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
-- 
2.25.1

