Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB3E710DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbjEYOCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbjEYOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:02:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62A1B5
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-309d3e8777cso796543f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685023320; x=1687615320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUbH3AqqDl8CE94ueCQYCD3fcBOZcuYmHQxQOWzVdSI=;
        b=AB/2sJFSbuTqwsZTCrfgFt0hVWsnb/KsgsZvmfNIJ/vK0a8oqMv1d5VqO+0UXeGcqC
         WNmVQURw2sdgCCZv2evGfdvntSL9XeVy7KQIio/WVhMEEWuRkFMYfDq8Nwg/DahYA5zy
         egQSSPXTeS52CzY8Bd1kfbW+OFdLCwoBKT/jkG7tCa5iRqLXAJRZtsfkr0V7d/FGDrqa
         8h2UGsOQHanQlZTXB1y644pZaRDcfNFSFHfjU5XvOTetWyShK4SwDSBraE7w7DUZiSVN
         9IPrrwyvzX4KGugorH2+x1cOBhmY8zb+uqKHmkyHmToSDvbK20MDgJEUWTpCUrXA22CL
         922g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023320; x=1687615320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUbH3AqqDl8CE94ueCQYCD3fcBOZcuYmHQxQOWzVdSI=;
        b=gJHA8MfLQma/0sTuh8jcG7P565zH1iNQszmJu9caQm8SBmADfAX7i5uYD5M6XIFM9c
         PJLN0Aq50OXXw5WftGeIoBDZwtUyVHaqDakqJpeUUzcSKn6yxrA0w0KTkQFcLugCpS/d
         vuFVv1vFJ6B1SNd0Yy5gYH+9WjmAD4jIznTyg00lgqrYDUnPbPLRdequggeYdqIzbSPN
         VMcbzAFJEPyEkEC+a7/8pEc9juPMYzptB+31xkWnNj2gVr47etnO96DeZ/xYFEbXWPX8
         +/0HDlWsSo/kKc/ilS6FM2uEarByUg2a63RO7rOp2N+p3mx68dUSC3DS8TjT6BN0OTLf
         w8/A==
X-Gm-Message-State: AC+VfDxn7H85bXUlcyuLFdidnYBn1OG9zPOflZ3hP4WRcVvjACRAmmYv
        GcGeLoTY86SIACNPVRD0QGR+JA==
X-Google-Smtp-Source: ACHHUZ4tXSENb+Vpjdf1ltyggjuSDPeNMOgHYDIP1ZGt4QKGSuaeGFxeAHpbVKgbP5ttyGtPZ1y0ew==
X-Received: by 2002:adf:f644:0:b0:309:6fe4:a20d with SMTP id x4-20020adff644000000b003096fe4a20dmr2025859wrp.9.1685023320556;
        Thu, 25 May 2023 07:02:00 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdd44000000b003063176ef09sm1944866wrm.6.2023.05.25.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:01:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Sandipan Patra <spatra@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/8] net/mlx5: Update the driver with the recent thermal changes
Date:   Thu, 25 May 2023 16:01:28 +0200
Message-Id: <20230525140135.3589917-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework is migrating to the generic trip points. The set
of changes also implies a self-encapsulation of the thermal zone
device structure where the internals are no longer directly accessible
but with accessors.

Use the new API instead, so the next changes can be pushed in the
thermal framework without this driver failing to compile.

No functional changes intended.

Cc: Sandipan Patra <spatra@nvidia.com>
Cc: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/thermal.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/thermal.c b/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
index e47fa6fb836f..20bb5eb266c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
@@ -45,7 +45,7 @@ static int mlx5_thermal_get_mtmp_temp(struct mlx5_core_dev *mdev, u32 id, int *p
 static int mlx5_thermal_get_temp(struct thermal_zone_device *tzdev,
 				 int *p_temp)
 {
-	struct mlx5_thermal *thermal = tzdev->devdata;
+	struct mlx5_thermal *thermal = thermal_zone_device_priv(tzdev);
 	struct mlx5_core_dev *mdev = thermal->mdev;
 	int err;
 
@@ -81,12 +81,13 @@ int mlx5_thermal_init(struct mlx5_core_dev *mdev)
 		return -ENOMEM;
 
 	thermal->mdev = mdev;
-	thermal->tzdev = thermal_zone_device_register(data,
-						      MLX5_THERMAL_NUM_TRIPS,
-						      MLX5_THERMAL_TRIP_MASK,
-						      thermal,
-						      &mlx5_thermal_ops,
-						      NULL, 0, MLX5_THERMAL_POLL_INT_MSEC);
+	thermal->tzdev = thermal_zone_device_register_with_trips(data,
+								 NULL,
+								 MLX5_THERMAL_NUM_TRIPS,
+								 MLX5_THERMAL_TRIP_MASK,
+								 thermal,
+								 &mlx5_thermal_ops,
+								 NULL, 0, MLX5_THERMAL_POLL_INT_MSEC);
 	if (IS_ERR(thermal->tzdev)) {
 		dev_err(mdev->device, "Failed to register thermal zone device (%s) %ld\n",
 			data, PTR_ERR(thermal->tzdev));
-- 
2.34.1

