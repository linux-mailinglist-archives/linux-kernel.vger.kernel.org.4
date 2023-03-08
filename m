Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5196B0BFA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCHO4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCHO4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:56:48 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1C8399250;
        Wed,  8 Mar 2023 06:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1/N3h
        jcEE32fI6fL0Z3K+IWx7N5W1QPfJk9RK/70oxw=; b=fCEy6aRtuIDUpeHjL6IP/
        0EpnbGHbwt+uWbpS3ypliZ05qmljgdqt4FF74LgPT1htUBTIkFLrPC2oTzakqbIL
        VpFETSpv7CxfXdPNKuadtN3zxbhI4w6PfxskNgqioGEqP3iPBYkmG/v2t4CHZ1ZL
        Y0bHG9OB4zLxYchZIx5y10=
Received: from lizhe.. (unknown [120.245.132.200])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wC3TkP7oQhkdGRNCg--.27004S4;
        Wed, 08 Mar 2023 22:56:27 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     fancer.lancer@gmail.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH v1] drivers/spi-dw-core.c : remove redundant function spi_controller_set_devdata
Date:   Wed,  8 Mar 2023 22:55:51 +0800
Message-Id: <20230308145551.3240-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3TkP7oQhkdGRNCg--.27004S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWrZr13GF4DJFyxWw4fuFg_yoWDWrbE9a
        1UA34xWr47JFn7tFn7ur48Xr9IvFW5ur4vkF4ktFZ3WF98Ww4DC3srWr4Y9FyUAwsxArWk
        C3s0g3yS934rAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [120.245.132.200]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKAIsq17WMQlXGwAAsR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in spi_alloc_master() already exists master_controller_set_devdata()
called, add the struct dw_spi is passed to the spi_alloc_master() as
the second parameter.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/spi/spi-dw-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c3bfb6c84cab..ad776c7eb66c 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -892,7 +892,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (!dws)
 		return -EINVAL;
 
-	master = spi_alloc_master(dev, 0);
+	master = spi_alloc_master(dev, sizeof(*dws));
 	if (!master)
 		return -ENOMEM;
 
@@ -901,8 +901,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	dws->master = master;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
 
-	spi_controller_set_devdata(master, dws);
-
 	/* Basic HW init */
 	dw_spi_hw_init(dev, dws);
 
-- 
2.34.1

