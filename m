Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DEB72B8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjFLHn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjFLHnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:43:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6941995
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:42:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8byE-0002bj-Fa; Mon, 12 Jun 2023 09:28:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8byD-006pif-Qh; Mon, 12 Jun 2023 09:28:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q8byC-00DQhk-Uo; Mon, 12 Jun 2023 09:28:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] w1: ds2482: Switch back to use struct i2c_driver's .probe()
Date:   Mon, 12 Jun 2023 09:28:07 +0200
Message-Id: <20230612072807.839689-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=F1tfiz6xeXVPZ1tOCA3JD5eV1SuaWUfQF3XHAx6RGFQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkhskGPoV3XrU1Ob0KI3BPIAtbGzzh8xQksIYiM RFHEtZQc0KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZIbJBgAKCRCPgPtYfRL+ TgOyB/9MiXFKsmAFTEPON2f7rbbMzFmJ25UuJU0QN4hqlfSKeTVLuH5mvHYEGXQteWNn5MBhscd c7EtHnVLT7ZjTO6MLuCSNX12TtO/TFRD7iunn/56uSLFPKfLLaWmJltSctiLVmimIgZ7IC/MZoE RfC6mYSIQJmZ8Uw5nVF8NC/LEl1MgrYumNVjPuNpwiiXIRranY/b6dAt5tpozw4OaKKZoPIDXoj 4AHKDWQVpWarq0NvYYoF/TwvVKDsHlvgaV5itr2NkKtke1hORHZHqqQxldgceq46nTCfJ5waWuJ N5S0SEqe6rDHWjhORjXuoMEITgu6VsGSgYt0naJHSG5JmshY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
commit 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
convert back to (the new) .probe() to be able to eventually drop
.probe_new() from struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/w1/masters/ds2482.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index c1de8a92e144..b2d76c1784bd 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -551,7 +551,7 @@ static struct i2c_driver ds2482_driver = {
 	.driver = {
 		.name	= "ds2482",
 	},
-	.probe_new	= ds2482_probe,
+	.probe		= ds2482_probe,
 	.remove		= ds2482_remove,
 	.id_table	= ds2482_id,
 };

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

