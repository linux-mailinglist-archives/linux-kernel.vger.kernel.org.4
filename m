Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE99701D13
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 13:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjENLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjENLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 07:25:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E901982
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 04:25:48 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id y9rEps5u40mnzy9rEpymsF; Sun, 14 May 2023 13:25:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684063546;
        bh=Tk5vW0hntOxhf9yNrtaC6tGBir59FsySHi0FcdBXXAI=;
        h=From:To:Cc:Subject:Date;
        b=FV2bx2ix6lKtmL7MYGq8pRxmng1uDjs+Xs2Kw89KaEbCz660xESHOksEtl/mA6Y6f
         mWYet7tuNG1qLo6fQCaW+5rLv7BM9gsnz8Arv6CNNhVukWxc5JTHtcNxJLSpLBhA4K
         x3/zwsBsy6n/9oZxuunAXoHED3ntqDWeLEzYCfolEscH+fSiVxE4669/chJSGfPKam
         TX9Ueo8I/oMN/pB2hjXG0XfnaWBS7Lyx5JES0SR39M8JsRIwqvs3HMQb2Ney8ov7yi
         bfjUysLAdqgcAzT/mbkFeZCA0ze8q1CMOrtoOFpnCKFTYyL/QS4EZ9rM+pTrB6e9tx
         fdYhXYHd6QgaQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 May 2023 13:25:46 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jeff Brasen <jbrasen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] serial: 8250_tegra: Fix an error handling path in tegra_uart_probe()
Date:   Sun, 14 May 2023 13:25:42 +0200
Message-Id: <f8130f35339cc80edc6b9aac4bb2a60b60a226bf.1684063511.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after reset_control_deassert(), it must be re-asserted,
as already done in the .remove() function.

Fixes: c6825c6395b7 ("serial: 8250_tegra: Create Tegra specific 8250 driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/8250/8250_tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index 2509e7f74ccf..89956bbf34d9 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -113,13 +113,15 @@ static int tegra_uart_probe(struct platform_device *pdev)
 
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
-		goto err_clkdisable;
+		goto err_ctrl_assert;
 
 	platform_set_drvdata(pdev, uart);
 	uart->line = ret;
 
 	return 0;
 
+err_ctrl_assert:
+	reset_control_assert(uart->rst);
 err_clkdisable:
 	clk_disable_unprepare(uart->clk);
 
-- 
2.34.1

