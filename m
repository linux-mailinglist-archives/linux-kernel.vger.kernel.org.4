Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4012750643
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGLLib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGLLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:38:29 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0141FF5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=IaSSkUShHNsHf6Hcd7JI1DA9Dk1NQz4OjpXmmsS2XZs=; b=kjseum
        Cm5xuq2vtQdu7bornhxj0aQLSbuFsmfDHBzjhV/woyt0WBkCvugSYZtRFw8IgTgx
        5hpD29dAeiAGGOX0NpRYC1gOMk4nPcfK/121tn89n7kOVluD+5BZOGwKblTqxBQs
        AKq2MDpEg145H1bKyhrUnyIFxu41BbmhvollbBh91eTmJBnZLCDH8Bw2YGKy8xKe
        fjmMQc0hdLrNprQQuVVJIm3N1uDfAWtLPP6n8jlH73VrBMf9gYhety5LpaKXq7s9
        IbLFOoeZJaxOMWjF0+rOYwINANyP7uxZVQKZsP+uIBne9wj06lPDY/qycaMnnl/w
        oEDcA9mRcBkY5M2g==
Received: (qmail 1596777 invoked from network); 12 Jul 2023 13:37:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 13:37:44 +0200
X-UD-Smtp-Session: l3s3148p1@AgjkpEgATqUujnvL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] gnss: ubx: use new helper to remove open coded regulator handling
Date:   Wed, 12 Jul 2023 13:37:29 +0200
Message-Id: <20230712113731.3306-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230712113731.3306-1-wsa+renesas@sang-engineering.com>
References: <20230712113731.3306-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v_bckp shall always be enabled as long as the device exists. We now have
a regulator helper for that, use it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gnss/ubx.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index c951be202ca2..9b76b101ba5e 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -17,7 +17,6 @@
 #include "serial.h"
 
 struct ubx_data {
-	struct regulator *v_bckp;
 	struct regulator *vcc;
 };
 
@@ -87,30 +86,16 @@ static int ubx_probe(struct serdev_device *serdev)
 		goto err_free_gserial;
 	}
 
-	data->v_bckp = devm_regulator_get_optional(&serdev->dev, "v-bckp");
-	if (IS_ERR(data->v_bckp)) {
-		ret = PTR_ERR(data->v_bckp);
-		if (ret == -ENODEV)
-			data->v_bckp = NULL;
-		else
-			goto err_free_gserial;
-	}
-
-	if (data->v_bckp) {
-		ret = regulator_enable(data->v_bckp);
-		if (ret)
-			goto err_free_gserial;
-	}
+	ret = devm_regulator_get_enable_optional(&serdev->dev, "v-bckp");
+	if (ret < 0 && ret != -ENODEV)
+		goto err_free_gserial;
 
 	ret = gnss_serial_register(gserial);
 	if (ret)
-		goto err_disable_v_bckp;
+		goto err_free_gserial;
 
 	return 0;
 
-err_disable_v_bckp:
-	if (data->v_bckp)
-		regulator_disable(data->v_bckp);
 err_free_gserial:
 	gnss_serial_free(gserial);
 
@@ -120,11 +105,8 @@ static int ubx_probe(struct serdev_device *serdev)
 static void ubx_remove(struct serdev_device *serdev)
 {
 	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
-	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
 
 	gnss_serial_deregister(gserial);
-	if (data->v_bckp)
-		regulator_disable(data->v_bckp);
 	gnss_serial_free(gserial);
 }
 
-- 
2.30.2

