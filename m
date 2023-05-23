Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663A970D42A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjEWGn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjEWGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:43:25 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E59611F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Z3IKHiDESnxgpp
        XaZi+dnogQqI5j7cdY2RUORWxIqRg=; b=mINKYsG+7CbwIeHubxfu3hxenfyL9T
        1F3jEIlLAwCT0yaHAPAhR2KHZ/iJsm+tlA+SYiQIXnCWHhTmTOHpTRt2tikYLH+w
        HiZOltuJBpER9CL0Bh7GIwXKs7w+YaqLkA/x3fQvUg2pPQhri/gO6WTt1hGjdxfj
        9gxjnN1/D2oR0=
Received: (qmail 2628194 invoked from network); 23 May 2023 08:43:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 May 2023 08:43:20 +0200
X-UD-Smtp-Session: l3s3148p1@VbX5s1b86MgujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/5] WIP: gnss: merge MTK driver into UBX driver
Date:   Tue, 23 May 2023 08:43:06 +0200
Message-Id: <20230523064310.3005-2-wsa+renesas@sang-engineering.com>
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

This is a proof-of-concept how easy it is to merge those two drivers as
they are extremly similar. The differences can be abstracted away
easily. Further work (renaming from 'ubx' to something more generic,
removing the MTK driver, ...) is postponed until there is agrement that
merging these drivers is actually wanted. I vote for it, though. I have
updates to the UBX driver which do make sense for the MTK driver as
well. Code saving is also a plus. We can always fork into a specific
driver again if we'd ever need that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gnss/ubx.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index c951be202ca2..c01e1e875727 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -63,12 +63,31 @@ static const struct gnss_serial_ops ubx_gserial_ops = {
 	.set_power = ubx_set_power,
 };
 
+struct ubx_info {
+	enum gnss_type type;
+	char *v_bckp_name;
+};
+
+const struct ubx_info ubx_info_ubx = {
+	.type = GNSS_TYPE_UBX,
+	.v_bckp_name = "v-bckp",
+};
+
+const struct ubx_info ubx_info_mtk = {
+	.type = GNSS_TYPE_MTK,
+	.v_bckp_name = "vbackup",
+};
+
 static int ubx_probe(struct serdev_device *serdev)
 {
+	const struct ubx_info *info = of_device_get_match_data(&serdev->dev);
 	struct gnss_serial *gserial;
 	struct ubx_data *data;
 	int ret;
 
+	if (!info)
+		return -ENOENT;
+
 	gserial = gnss_serial_allocate(serdev, sizeof(*data));
 	if (IS_ERR(gserial)) {
 		ret = PTR_ERR(gserial);
@@ -77,7 +96,7 @@ static int ubx_probe(struct serdev_device *serdev)
 
 	gserial->ops = &ubx_gserial_ops;
 
-	gserial->gdev->type = GNSS_TYPE_UBX;
+	gserial->gdev->type = info->type;
 
 	data = gnss_serial_get_drvdata(gserial);
 
@@ -87,7 +106,7 @@ static int ubx_probe(struct serdev_device *serdev)
 		goto err_free_gserial;
 	}
 
-	data->v_bckp = devm_regulator_get_optional(&serdev->dev, "v-bckp");
+	data->v_bckp = devm_regulator_get_optional(&serdev->dev, info->v_bckp_name);
 	if (IS_ERR(data->v_bckp)) {
 		ret = PTR_ERR(data->v_bckp);
 		if (ret == -ENODEV)
@@ -130,9 +149,10 @@ static void ubx_remove(struct serdev_device *serdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id ubx_of_match[] = {
-	{ .compatible = "u-blox,neo-6m" },
-	{ .compatible = "u-blox,neo-8" },
-	{ .compatible = "u-blox,neo-m8" },
+	{ .compatible = "u-blox,neo-6m", .data = &ubx_info_ubx, },
+	{ .compatible = "u-blox,neo-8", .data = &ubx_info_ubx, },
+	{ .compatible = "u-blox,neo-m8", .data = &ubx_info_ubx, },
+	{ .compatible = "globaltop,pa6h", .data = &ubx_info_mtk },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ubx_of_match);
-- 
2.35.1

