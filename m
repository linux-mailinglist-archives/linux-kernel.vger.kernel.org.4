Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F76BFAEA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCROjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCROjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:39:40 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7410DE;
        Sat, 18 Mar 2023 07:39:36 -0700 (PDT)
Received: from laboratory-MS-7D42.. ([10.12.190.56])
        (user=jingfelix@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32IEcxOK023737-32IEcxOL023737
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Mar 2023 22:39:04 +0800
From:   Tianyi Jing <jingfelix@hust.edu.cn>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Tianyi Jing <jingfelix@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: hwmon: fix ioremap and memremap leak
Date:   Sat, 18 Mar 2023 22:38:51 +0800
Message-Id: <20230318143851.2191625-1-jingfelix@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: jingfelix@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:

drivers/hwmon/xgene-hwmon.c:757 xgene_hwmon_probe() warn:
'ctx->pcc_comm_addr' from ioremap() not released on line: 757.

This is because in drivers/hwmon/xgene-hwmon.c:701 xgene_hwmon_probe(),
ioremap and memremap is not released, which may cause a leak.

To fix this, ioremap and memremap is modified to devm_ioremap and
devm_memremap.

Signed-off-by: Tianyi Jing <jingfelix@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v1 -> v2: use devm_ioremap and devm_memremap instead.
 drivers/hwmon/xgene-hwmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 5cde837bfd09..a25fae9b19b7 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -698,11 +698,13 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 		ctx->comm_base_addr = pcc_chan->shmem_base_addr;
 		if (ctx->comm_base_addr) {
 			if (version == XGENE_HWMON_V2)
-				ctx->pcc_comm_addr = (void __force *)ioremap(
+				ctx->pcc_comm_addr = (void __force *)devm_ioremap(
+							&pdev->dev,
 							ctx->comm_base_addr,
 							pcc_chan->shmem_size);
 			else
-				ctx->pcc_comm_addr = memremap(
+				ctx->pcc_comm_addr = devm_memremap(
+							&pdev->dev,
 							ctx->comm_base_addr,
 							pcc_chan->shmem_size,
 							MEMREMAP_WB);
-- 
2.34.1

