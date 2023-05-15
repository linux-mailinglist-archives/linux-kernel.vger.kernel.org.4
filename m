Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0608C703EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjEOUgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjEOUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:36:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DE4D848
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:36:33 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yevlpfkLqarguyevlp1xx0; Mon, 15 May 2023 22:36:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684182992;
        bh=kB1RD+4WplvIWh7fw3+/GdX+k7JLdrHPlj+idk3PIbE=;
        h=From:To:Cc:Subject:Date;
        b=J5Pigy85+HmGNs0GS2F6HLphCoLP0S7NibMZAauZTrWNyHEN3RIg+r3U9Tx5qbDZN
         WcHC3AbzXyYUl8XZhf5yEfgrlcnrfZueGGx8720ABz6C9hwPJFcdpEOmEOqepS1ZNq
         d5WdVm+YnBxDM7gXZGjCO262mrJAj3waSrA+CTwoQeX/efsXHBwxXOzI13RxaR/FFk
         5R/zQdFQAQUxuXDmhvksnVscuU6EmcF6e/WWQ25gGsCef1CogVHWdf5bAAioP3bYNY
         uQ1Kii5ELDl1MiRzL2aOnjW1hY3uItYvfIekuv0K9aN1bA7z/9UaTSoQvPW0waHgj/
         ezA13kKQFL+sA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 May 2023 22:36:32 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin Jerabek <martin.jerabek01@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] can: ctucanfd: Fix an error handling path in ctucan_probe_common()
Date:   Mon, 15 May 2023 22:36:28 +0200
Message-Id: <4b78c848826fde1b8a3ccd53f32b80674812cb12.1684182962.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If register_candev() fails, a previous netif_napi_add() needs to be undone.
Add the missing netif_napi_del() in the error handling path.

Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 64c349fd4600..59e1708e43d6 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -1429,7 +1429,7 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
 	ret = register_candev(ndev);
 	if (ret) {
 		dev_err(dev, "fail to register failed (err=%d)\n", ret);
-		goto err_deviceoff;
+		goto err_del_napi;
 	}
 
 	pm_runtime_put(dev);
@@ -1439,6 +1439,8 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
 
 	return 0;
 
+err_del_napi:
+	netif_napi_del(&priv->napi);
 err_deviceoff:
 	pm_runtime_put(priv->dev);
 err_pmdisable:
-- 
2.34.1

