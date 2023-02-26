Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8C6A2E98
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBZGfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZGfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:35:08 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D01C3B771
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 22:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IvUAk
        44qX53mrmFeOTcMDnglMNl9yyPwVkGy2yi2D1Y=; b=QV4sIn1p8CQDw71lxR4UL
        MbzvVFJveAbBp2CfL97jqs1HH8WI/IbLMukbwXmWnczpJ0bW05bqSvAi/+clBhVn
        YiXzWg9ePy/XA8gYgbiqFELqSbSBvdBvsZ45i6XM6ynDJtfszipgQhqOautKaZFH
        jvPAwC2BNEJPGjiBXXOEOA=
Received: from lizhe.. (unknown [120.245.132.180])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wC3FrdB_fpj1ZL2BA--.35734S4;
        Sun, 26 Feb 2023 14:34:16 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     broonie@kernel.org, heiko@sntech.de
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH v1] drivers/spi-rockchip.c : Remove redundant variable slave
Date:   Sun, 26 Feb 2023 14:33:34 +0800
Message-Id: <20230226063334.7489-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3FrdB_fpj1ZL2BA--.35734S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWxKr17Ww1DXw4rtr43Wrg_yoW3Grc_ua
        1UuF4xWw48trsaya18K343CrZYvFsagr1v9F4qqFWSg3yDAr18ZwnYvay5J3WUZw4xCr97
        CFyjqw1akF98CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [120.245.132.180]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSAsiq1+FhCf6VQAAsc
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable slave in spi_alloc_master() or spi_alloc_slave()
has been assigned. it is not necessary to be assigned again

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/spi/spi-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 79242dc5272d..a45717eb8890 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -772,7 +772,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctlr);
 
 	rs = spi_controller_get_devdata(ctlr);
-	ctlr->slave = slave_mode;
 
 	/* Get basic io resource and map it */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.34.1

