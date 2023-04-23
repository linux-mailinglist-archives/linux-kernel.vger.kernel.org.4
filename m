Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664656EBD57
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 08:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjDWGMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 02:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWGMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 02:12:51 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E42700;
        Sat, 22 Apr 2023 23:12:48 -0700 (PDT)
Received: from localhost.localdomain ([222.20.126.128])
        (user=ysxu@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33N6Bugb007746-33N6Bugc007746
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 23 Apr 2023 14:12:00 +0800
From:   Yingsha Xu <ysxu@hust.edu.cn>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Yingsha Xu <ysxu@hust.edu.cn>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: remove return value check of debugfs_create_dir()
Date:   Sun, 23 Apr 2023 14:11:54 +0800
Message-Id: <20230423061155.2540-1-ysxu@hust.edu.cn>
X-Mailer: git-send-email 2.17.1
X-FEAS-AUTH-USER: ysxu@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that:
dw_spi_debugfs_init() warn: 'dws->debugfs' is an error pointer
 or valid

Debugfs checks are generally not supposed to be checked for errors
and it is not necessary here.

Just delete the dead code.

Signed-off-by: Yingsha Xu <ysxu@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/spi/spi-dw-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c3bfb6c84cab..64eb6dcdaac3 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -63,8 +63,6 @@ static int dw_spi_debugfs_init(struct dw_spi *dws)
 
 	snprintf(name, 32, "dw_spi%d", dws->master->bus_num);
 	dws->debugfs = debugfs_create_dir(name, NULL);
-	if (!dws->debugfs)
-		return -ENOMEM;
 
 	dws->regset.regs = dw_spi_dbgfs_regs;
 	dws->regset.nregs = ARRAY_SIZE(dw_spi_dbgfs_regs);
-- 
2.17.1

