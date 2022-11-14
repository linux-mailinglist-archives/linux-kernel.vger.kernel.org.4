Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20403628850
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiKNSaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiKNSaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:30:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E625C47
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:30:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 287A0B81158
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF7DC433D6;
        Mon, 14 Nov 2022 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668450606;
        bh=KjLeGyUJTbZpSiKhaAFgRkOpgkH4ndx+JjCuYdxHGcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bY29PN+CyQgg6/VdgLjSq/jugOiRFtHQw+Xxc1h2PxY+BLAsSfEJ7e2CBv4KzGmfy
         9/aoiEiu5ZSpriSJuR0gSVUmS+zYRvGafuYYtqMPEQDS2NhqQ1kwYdncApO+p92FTX
         stqy0WYhQYHGIR+bGkXrE3FUPMGugEp+sWfx013Sj93aJjNN7z2YCazcoSLdPWMwYs
         QdyULgUxl+x46SDTihwnGa4I8eGqJGE7esekjFcM5kv73P444WCvBH9nP8vA/qDCO7
         rNn+jHctDyZHC5FSnsfooLElEb7u553FDcpbSBpBYlKV87QumPpjh6nmUZjpp5/d6T
         jXDfBuLGLo+CQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable 2/2] mm/damon/sysfs-schemes: skip schemes regions clearing if the scheme directory has removed
Date:   Mon, 14 Nov 2022 18:29:54 +0000
Message-Id: <20221114182954.4745-3-sj@kernel.org>
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
sysfs directory for the scheme, and then ask clearing of the scheme's
tried regions.  Because the schemes tried regions clearing logic doesn't
aware of the situation, it results in an invalid memory access.  Fix the
bug by checking if the scheme sysfs directory exists.

Fixes: bb9641eb3a3e ("mm/damon/sysfs-schemes: implement DAMOS-tried regions clear command") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 4df3c99983e8..e6baf55d617d 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1260,6 +1260,10 @@ int damon_sysfs_schemes_clear_regions(
 	damon_for_each_scheme(scheme, ctx) {
 		struct damon_sysfs_scheme *sysfs_scheme;
 
+		/* user could removed the scheme sysfs dir */
+		if (schemes_idx >= sysfs_schemes->nr)
+			break;
+
 		sysfs_scheme = sysfs_schemes->schemes_arr[schemes_idx++];
 		damon_sysfs_scheme_regions_rm_dirs(
 				sysfs_scheme->tried_regions);
-- 
2.25.1

