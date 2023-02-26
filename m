Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41EA6A2EA8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBZGwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZGwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:52:40 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9FBE14997;
        Sat, 25 Feb 2023 22:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CgKfI
        DTe7iV4Ey58WdGr3+soXUsjSl47zqi0NmIEK+E=; b=UZTcm52Seih1hSUrqYgeY
        5WR+ajYOaTkT8TkjjZRMcqF2IUgyTwNuHeicuhlDtI74r8dUrcSQbSSoFFenZFus
        SHTeFTBuUuaOJws5nox2AHtJXC+ASJJvGHz8Rh9ZCAzrV7aIscWHfybr59qaXZXe
        y7h/Tn/pPRPZeTacv7h05g=
Received: from lizhe.. (unknown [120.245.132.180])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wAXpb1vAftjDbgABQ--.19532S4;
        Sun, 26 Feb 2023 14:52:10 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     broonie@kernel.org, heiko@sntech.de
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH v1] drivers/spi-rockchip.c : Use devm_platform_get_and_ioremap_resource makes code better
Date:   Sun, 26 Feb 2023 14:51:25 +0800
Message-Id: <20230226065125.14086-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXpb1vAftjDbgABQ--.19532S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1UAF1kZF18CFyrXF1DZFb_yoWfGFX_ua
        1Uur4xGr48ArsYya1Ykw13CFWIvanYgr97GF4jqFZxtF4DXr12vrWrurn5JF1UZwsrAr9r
        Gr9Fqr1avF98AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [120.245.132.180]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBlwAiq2I0YM1zuQAAsv
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use devm_platform_get_and_ioremap replace platform_get_resource()
and devm_ioremap_resource()

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/spi/spi-rockchip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 79242dc5272d..4f69c38d5a67 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -775,8 +775,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ctlr->slave = slave_mode;
 
 	/* Get basic io resource and map it */
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rs->regs = devm_ioremap_resource(&pdev->dev, mem);
+	rs->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(rs->regs)) {
 		ret =  PTR_ERR(rs->regs);
 		goto err_put_ctlr;
-- 
2.34.1

