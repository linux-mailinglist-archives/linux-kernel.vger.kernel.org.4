Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244A70D42F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjEWGnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjEWGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:43:26 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C544121
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=pnZxntDIL58qq5
        lLbg927fG2rOg+UQvQEoeeePBGWTw=; b=NlFQrF1SA5fOWp6H1M0fdnK32Rvv6z
        QOH3i+nXd8KqNcEp9jljz9WCJt8/npG4FWy+E8eTzvOuIonZ6wp4gTFVjzpEQgDu
        MZtEubob4BtqpMq2Z4JmjBAJCzN0UzxLWuaBF74CRoD5Yvhx/srNMhq75MnVKc0w
        n0OwL491ECVUY=
Received: (qmail 2628252 invoked from network); 23 May 2023 08:43:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 May 2023 08:43:22 +0200
X-UD-Smtp-Session: l3s3148p1@i0URtFb8/MgujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 3/5] gnss: ubx: 'vcc' can be optional
Date:   Tue, 23 May 2023 08:43:08 +0200
Message-Id: <20230523064310.3005-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are devices where 'vcc' is always on. The reset pin is used for
silencing the chip. Make the 'vcc' regulator optional.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gnss/ubx.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index c8d027973b85..d5281bfae9cb 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -25,9 +25,11 @@ static int ubx_set_active(struct gnss_serial *gserial)
 	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
 	int ret;
 
-	ret = regulator_enable(data->vcc);
-	if (ret)
-		return ret;
+	if (data->vcc) {
+		ret = regulator_enable(data->vcc);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -37,9 +39,11 @@ static int ubx_set_standby(struct gnss_serial *gserial)
 	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
 	int ret;
 
-	ret = regulator_disable(data->vcc);
-	if (ret)
-		return ret;
+	if (data->vcc) {
+		ret = regulator_disable(data->vcc);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -99,10 +103,13 @@ static int ubx_probe(struct serdev_device *serdev)
 
 	data = gnss_serial_get_drvdata(gserial);
 
-	data->vcc = devm_regulator_get(&serdev->dev, "vcc");
+	data->vcc = devm_regulator_get_optional(&serdev->dev, "vcc");
 	if (IS_ERR(data->vcc)) {
 		ret = PTR_ERR(data->vcc);
-		goto err_free_gserial;
+		if (ret == -ENODEV)
+			data->vcc = NULL;
+		else
+			goto err_free_gserial;
 	}
 
 	ret = devm_regulator_get_enable_optional(&serdev->dev, info->v_bckp_name);
-- 
2.35.1

