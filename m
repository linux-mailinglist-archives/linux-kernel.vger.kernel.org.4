Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8809B6E3C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 00:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDPWOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 18:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPWOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 18:14:49 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E2F2126
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 15:14:47 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id oAdvpfmXF7JnhoAdwpmfbm; Mon, 17 Apr 2023 00:14:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681683285;
        bh=f4Jh1YKOoXycqM/ekvBOa/gB5r5j8s3SNJI5ciLqyyU=;
        h=From:To:Cc:Subject:Date;
        b=WfyEaNEIr5MFNeyZw6p+zChJC8j4ilHvVGniPI6rCLbM1VhXcmU2psKUNWjjGnmpf
         5cFh3OlgrZYsfaIVVSvLt2S9qOgEm/Y8n+FKPjYELR3dkB98/IwcfB1/VRnlIpzYai
         rlRQETn2jkZQPjTj9gVy0w/dlgWX6Zb7O53KiaKHjnYKElLd9xdSIpSuZr7YnOlzVs
         MnkRg7MYy+DxqoR4CU9SUG+BYoBTZaae9ZRRmXtaLJreNRdPIQij8J9dQiuVxxZ6AC
         VpJZ31qUQEcDetEzYF1hc+TPD+oNCd3gtKxPabN9a+sdijGrzIyVNqKrxRLtW2VdMs
         zrBg1muOmQcpA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Apr 2023 00:14:45 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: i2c: imx296: Fix error handling while reading temperature
Date:   Mon, 17 Apr 2023 00:14:42 +0200
Message-Id: <827f94730c85b742f9ae66209b383a50ca79ec43.1681683246.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If imx296_read() returns an error, its returned value is a negative value.
But because of the "& IMX296_TMDOUT_MASK" (i.e. 0x3ff), 'tmdout' can't be
negative.

So the error handling does not work as expected and a wrong value is used
to compute the temperature.

Apply the IMX296_TMDOUT_MASK mask after checking for errors to fix it.

Fixes: cb33db2b6ccf ("media: i2c: IMX296 camera sensor driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/i2c/imx296.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx296.c b/drivers/media/i2c/imx296.c
index 4f22c0515ef8..c3d6d52fc772 100644
--- a/drivers/media/i2c/imx296.c
+++ b/drivers/media/i2c/imx296.c
@@ -922,10 +922,12 @@ static int imx296_read_temperature(struct imx296 *sensor, int *temp)
 	if (ret < 0)
 		return ret;
 
-	tmdout = imx296_read(sensor, IMX296_TMDOUT) & IMX296_TMDOUT_MASK;
+	tmdout = imx296_read(sensor, IMX296_TMDOUT);
 	if (tmdout < 0)
 		return tmdout;
 
+	tmdout &= IMX296_TMDOUT_MASK;
+
 	/* T(°C) = 246.312 - 0.304 * TMDOUT */;
 	*temp = 246312 - 304 * tmdout;
 
-- 
2.34.1

