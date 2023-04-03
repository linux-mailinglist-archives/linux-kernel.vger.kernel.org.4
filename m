Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF56D51D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjDCUEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BCA1728
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51BE562124
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 20:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1113C433EF;
        Mon,  3 Apr 2023 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680552251;
        bh=uKL7799fDYCIk1oIRYYxbDwmU1HnkOg8MZI/5uqJOcw=;
        h=From:Date:Subject:To:Cc:From;
        b=nSauXv4tR1sV566ZWCYZFpwkxijbPwswBYdm2hPi/HpRLgx0WLWYjB6Dft9NsZAvS
         yzWA1R0mIGML+grHJWqQctf+Y7x9sMJcY64ub6eysH2Z9BwjLrnl/FA+KEDuOS8som
         c/5VTkTHA5turHjoLZ64vs8Tf95BS1/+a05Op2yEbZYAyTbI+XX7cxdDkdOjPGd6xc
         1H+Z4wyolUng8Vwb2CAEU9xmZ9qKJ26OOQiGt2BAexQhNcyT+u9wBQkWYte6L2at1g
         4K8/dbGNeErHrcatsKFWLbvYVcNexz8BpO5ECiI2MT5LiU3yv9YO/2Pzc7bvT7OqMG
         iyZVrCNCAjYsQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 03 Apr 2023 21:02:39 +0100
Subject: [PATCH] regmap: Fix double unlock in the maple cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-regmap-maple-unlock-v1-1-89998991b16c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN4wK2QC/x2NywqDQAxFf0WybmCqI1p/pXQR06hBnZEMfYD47
 x27uItz4XB2SGIqCbpiB5O3Jo0hw/VSAE8URkF9ZobSlZXzrkKTcaUN8xbBV1giz3hriVrP7Ju
 hhmz2lAR7o8DT6X6izee9mQz6/cfuj+P4AaWAle58AAAA
To:     Liam.Howlett@Oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uKL7799fDYCIk1oIRYYxbDwmU1HnkOg8MZI/5uqJOcw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkKzE5rGUCZgJbyOewX95msrYoXSZ5YAHswnkVF8An
 tqHmm9OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZCsxOQAKCRAk1otyXVSH0Bi9B/
 wOc73skUgpb7dv93+EQLtllqEPZP9dRLr42t0weINyxyccdWmkVHOzv3RqU/NWFy/+H/eIqzDYs7OZ
 mpyfG9HQF7EqpBugq2CXzZUbYn2YzXeLs/HBcnt4fL00pYBX3nwYgq6p+h3dInwweEwpnnyFDqxdBV
 UPxkldRlm4aTceW8in79PLDgOVywS8NIe+X8XdcYpIprESQdMkwR834vqtKHg89EXLNAhN/OKoWqy2
 YZ9IRIb+j3Hw2Xa703upoVTeXKf8XfFVKsF4Qy3t+AstBCR+MH2DqlH+ucMEa9oYLmfWLAZbQ4Wg5a
 Lv4y/+oDWl/xeWfTSq8ssdxbgzQCkA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing the dance to drop the maple tree's internal spinlock means we need
multiple exit paths in our error handling.

Reported-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache-maple.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 497cc708d277..20fb7228fc6b 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -137,7 +137,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 					GFP_KERNEL);
 			if (!lower) {
 				ret = -ENOMEM;
-				goto out;
+				goto out_unlocked;
 			}
 		}
 
@@ -151,7 +151,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 					GFP_KERNEL);
 			if (!upper) {
 				ret = -ENOMEM;
-				goto out;
+				goto out_unlocked;
 			}
 		}
 
@@ -179,6 +179,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 
 out:
 	mas_unlock(&mas);
+out_unlocked:
 	kfree(lower);
 	kfree(upper);
 

---
base-commit: f033c26de5a5734625d2dd1dc196745fae186f1b
change-id: 20230403-regmap-maple-unlock-98aa84cc47f5

Best regards,
-- 
Mark Brown <broonie@kernel.org>

