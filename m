Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592F86B147C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCHVtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCHVs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:48:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90296C3E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:48:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so22209wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678312118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9b973OIjh2A0q4it2tRxdKfeAcI3pT5uZD5jTJWInpI=;
        b=YMAZmJORveNcNQt8Xuwzh04+SXOMfA0xiAPvb6CaAqKSZGmF0QwHOHB2Qmu1jT1yxQ
         Y4WWPCF9Nj+IS21dbGu7Hh1bRdn5iwZJTGmgxGn7OfVXfTLVjaCxt0puIxF/msRd9np4
         pgszGCaIjfQCdHQDxsxpzWwcopep3sj7QnEz6xk0unVb+rg3gKtoWSh4Vm8cNuqPDGae
         vR1lm6gamA6AnRxa+PiJ/QrI1Hd4fA7PifMMitRNmRPWjXnALM8Mp9FQBVCeMe/af4L3
         8Y/FDU9hCDAOqDc61m5MYZugAa9DLbj1B4t696f0Pyx3K7WoL+OZUWBm7d/Lhky4Nhjw
         ms4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678312118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9b973OIjh2A0q4it2tRxdKfeAcI3pT5uZD5jTJWInpI=;
        b=W7sGDE1jZSIr14Uoo5XOJs5nt9F4CQBONtGT99jZVCgiH7i7P/FkQSwN92vNWZUiCz
         I05Obzb9YQfNnBTIXcfKriQJZFvHa32XGlN1pg1daoKKjr4WsDk4C7LZRwvRkcNfeHrQ
         NYAcmbnCsw13ESGZ4bmTE52R/WhbAxDVBJza4TTpU4MgE8A95lndqNnqZ6asQcxeCKeB
         6B3uXIhicC0bcoFUd02Gy3yI+W0YGJECZnrewzvTpTIpI4VJ3kV4RwplbwB8OUZTbyQx
         GYwok3NgbKRzfNbe+6uqHe2i4DDtjxvErcD5XPvZOLW9PeQk/mb6aL7Jw9swDZe1/cyS
         5UQQ==
X-Gm-Message-State: AO0yUKUZIxHpx1zE1ATLItgZVBFg4SR2hFipvFJAQSq3EfKVWKBJ7Znf
        781WB9YAwkg4Zvu2QnM7XGvfrA==
X-Google-Smtp-Source: AK7set9dNQIoqJwJ1YDp+pOXC2yzZe8SPtUpY47j+15NDVfKGPTAxNPVDJYhNaO50DjaF0ITnaNgKQ==
X-Received: by 2002:a5d:62c3:0:b0:2c5:5237:3b21 with SMTP id o3-20020a5d62c3000000b002c552373b21mr13902966wrv.69.1678312118499;
        Wed, 08 Mar 2023 13:48:38 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:fbda:65f5:e873:7527])
        by smtp.gmail.com with ESMTPSA id z6-20020adfd0c6000000b002c55efa9cbesm16065713wrh.39.2023.03.08.13.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:48:38 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 1/2] thermal/drivers/imx: Remove get_trip_temp ops
Date:   Wed,  8 Mar 2023 22:48:21 +0100
Message-Id: <20230308214822.1317086-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX thermal sensor uses the generic trip points. The thermal
framework can return the critical temperature directly.

Remove the pointless get_trip_temp ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_thermal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c3136978adee..69ed482167f7 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -330,13 +330,6 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp)
-{
-	*temp = trips[IMX_TRIP_CRITICAL].temperature;
-
-	return 0;
-}
-
 static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 			     int temp)
 {
@@ -384,7 +377,6 @@ static struct thermal_zone_device_ops imx_tz_ops = {
 	.unbind = imx_unbind,
 	.get_temp = imx_get_temp,
 	.change_mode = imx_change_mode,
-	.get_crit_temp = imx_get_crit_temp,
 	.set_trip_temp = imx_set_trip_temp,
 };
 
-- 
2.34.1

