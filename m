Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B33F62B68E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiKPJb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiKPJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:31:23 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6212AA7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:31:22 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NByTb1w0Qz15Mfc;
        Wed, 16 Nov 2022 17:30:59 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:31:20 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 17:31:20 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] regulator: rt5759: fix OOB in validate_desc()
Date:   Wed, 16 Nov 2022 17:29:43 +0800
Message-ID: <20221116092943.1668326-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following OOB report:

 BUG: KASAN: slab-out-of-bounds in validate_desc+0xba/0x109
 Read of size 8 at addr ffff888107db8ff0 by task python3/253
 Call Trace:
  <TASK>
  dump_stack_lvl+0x67/0x83
  print_report+0x178/0x4b0
  kasan_report+0x90/0x190
  validate_desc+0xba/0x109
  gpiod_set_value_cansleep+0x40/0x5a
  regulator_ena_gpio_ctrl+0x93/0xfc
  _regulator_do_enable.cold.61+0x89/0x163
  set_machine_constraints+0x140a/0x159c
  regulator_register.cold.73+0x762/0x10cd
  devm_regulator_register+0x57/0xb0
  rt5759_probe+0x3a0/0x4ac [rt5759_regulator]

The desc used in validate_desc() is passed from 'reg_cfg.ena_gpiod',
which is not initialized. Fix this by initializing 'reg_cfg' to 0.

Fixes: 7b36ddb208bd ("regulator: rt5759: Add support for Richtek RT5759 DCDC converter")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/regulator/rt5759-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/rt5759-regulator.c b/drivers/regulator/rt5759-regulator.c
index 6b96899eb27e..8488417f4b2c 100644
--- a/drivers/regulator/rt5759-regulator.c
+++ b/drivers/regulator/rt5759-regulator.c
@@ -243,6 +243,7 @@ static int rt5759_regulator_register(struct rt5759_priv *priv)
 	if (priv->chip_type == CHIP_TYPE_RT5759A)
 		reg_desc->uV_step = RT5759A_STEP_UV;
 
+	memset(&reg_cfg, 0, sizeof(reg_cfg));
 	reg_cfg.dev = priv->dev;
 	reg_cfg.of_node = np;
 	reg_cfg.init_data = of_get_regulator_init_data(priv->dev, np, reg_desc);
-- 
2.25.1

