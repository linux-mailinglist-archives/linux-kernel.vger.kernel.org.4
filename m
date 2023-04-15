Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0C6E3266
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDOQXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDOQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:23:44 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA094205
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:23:42 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nigdpWagKzvWynigdpJpvG; Sat, 15 Apr 2023 18:23:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681575820;
        bh=MAu6FtQocPfF7HLftUeIz5L/LjWmrKfwqCeX9Eip2zs=;
        h=From:To:Cc:Subject:Date;
        b=MQexySYLp4AK43xDaS2eH2jE+/tLInYnZZZtFldvpZqTrZ5vInwfiaB6Kw1DO/EpX
         dcaFupj8Wl8wECUb5kxyydHW9OSUxvPzkWnxWFbKsXHi7Z78CPKmCztmeKjDkoLN9y
         t+H9b19kkLUgVoaJV1qwuNL+ANuct4X8JwdHDZG8jF/bfRrQeZzePDpTQbkjGJNfxL
         7O45Db1USkV7v5LBA0f8gmelrH1/1GwN6ughha1ZNTvemwKSIJAs+MLhECion1eyDI
         c8JoUEelAIMTxU34c988bmnUM7qVMCJJb42zPpswesP23xOuXZnK9+6rrgp/LWp6NB
         OdPo2ALpKyDQQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 15 Apr 2023 18:23:40 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (sfctemp) Simplify error message
Date:   Sat, 15 Apr 2023 18:23:37 +0200
Message-Id: <f32a6e877f399e11ca130476002f85c2b48ba7ec.1681575790.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already display the error code. There is no need to
duplicate it explicitly in the error message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hwmon/sfctemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sfctemp.c b/drivers/hwmon/sfctemp.c
index d7484e2b8100..fb1da93383d7 100644
--- a/drivers/hwmon/sfctemp.c
+++ b/drivers/hwmon/sfctemp.c
@@ -303,7 +303,7 @@ static int sfctemp_probe(struct platform_device *pdev)
 
 	ret = sfctemp_enable(sfctemp);
 	if (ret)
-		return dev_err_probe(dev, ret, "error enabling temperature sensor: %d\n", ret);
+		return dev_err_probe(dev, ret, "error enabling temperature sensor\n");
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sfctemp", sfctemp,
 							 &sfctemp_chip_info, NULL);
-- 
2.34.1

