Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE7F6E3269
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDOQZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDOQZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:25:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482340F5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:25:45 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id niicpmmuPuZFDniidpv4WH; Sat, 15 Apr 2023 18:25:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681575943;
        bh=0ZTOsuOe5l/P6twE7yNwHhcSMb6Pv10MoGFjviDm2bw=;
        h=From:To:Cc:Subject:Date;
        b=WnBrPLQlml6/G/jNEyBVszuiG/RwCDn37wK4n8S+LoObPNkZ9TcP2hFH7w6ol2xBN
         rtO1i01P4QcRbBhjWuJEPbGNaGWocBaeITZxDtjT7PUvHy9KkkLt+OeFM6bR1F2dWR
         G3T/rIkPkbsLEMuNgpxFinU5HWsW6SAV+6pu/44vRMHMCKocHWVDpODZ3pvoXu5X4h
         1hVdfTszaFhd23+HoB0bzCP0PEI5V/NtPPtHWQ5qMMvv3FF3cerxybjkdTSbaTKwa/
         jmQDaCigvvvFIs60bIOUBSnd4w8XL6FQrsN7y4elxI1NjNjkQKnx8l4W8NpXSuxyrB
         4gE+WdoZOhUZQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 15 Apr 2023 18:25:43 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: bma400: Simplify an error message
Date:   Sat, 15 Apr 2023 18:25:41 +0200
Message-Id: <9373d41b0a1f3dc3fc0d31c1daaa19d9a7ec4dcd.1681575924.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already display the error code. There is no need to
duplicate it explicitly in the error message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/accel/bma400_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index a68b845f5b4f..e90e2f01550a 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -868,8 +868,7 @@ static int bma400_init(struct bma400_data *data)
 					     ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Failed to get regulators: %d\n",
-				     ret);
+		return dev_err_probe(data->dev, ret, "Failed to get regulators\n");
 
 	/* Try to read chip_id register. It must return 0x90. */
 	ret = regmap_read(data->regmap, BMA400_CHIP_ID_REG, &val);
-- 
2.34.1

