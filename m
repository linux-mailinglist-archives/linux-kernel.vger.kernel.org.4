Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82204710A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbjEYLOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjEYLOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:14:04 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5366DE7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:14:03 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:59b9:3473:f0ae:e2b7])
        by baptiste.telenet-ops.be with bizsmtp
        id 0zE02A0055NiV2701zE0g8; Thu, 25 May 2023 13:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q28ue-00349i-N8;
        Thu, 25 May 2023 13:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q28uu-00DnlU-EX;
        Thu, 25 May 2023 13:14:00 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Osama Muhammad <osmtendev@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/2] regulator: core: Fix more error checking for debugfs_create_dir()
Date:   Thu, 25 May 2023 13:13:58 +0200
Message-Id: <ee980a108b5854dd8ce3630f8f673e784e057d17.1685013051.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1685013051.git.geert+renesas@glider.be>
References: <cover.1685013051.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of failure, debugfs_create_dir() does not return NULL, but an
error pointer.  Most incorrect error checks were fixed, but the one in
create_regulator() was forgotten.

Fix the remaining error check.

Fixes: 2bf1c45be3b8f3a3 ("regulator: Fix error checking for debugfs_create_dir")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Re-add accidentally dropped opening curly brace,

v2:
  - Split off from "regulator: core: Streamline debugfs operations".
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 698ab7f5004bf6b7..c1bc4729301d5fed 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1911,7 +1911,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 
 	if (err != -EEXIST)
 		regulator->debugfs = debugfs_create_dir(supply_name, rdev->debugfs);
-	if (!regulator->debugfs) {
+	if (IS_ERR(regulator->debugfs)) {
 		rdev_dbg(rdev, "Failed to create debugfs directory\n");
 	} else {
 		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
-- 
2.34.1

