Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C26B147B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCHVs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCHVsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:48:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D518C94F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:48:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l1so2384wry.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678312120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSi6Beth8Hd606NS4V715NDwa0mm95xS/EhiukW+s4A=;
        b=s6QYhBdP4xz1DCwwEoxAGKi1ZWo634kvMmuIClnvYe1bD7KyDs4Pt+l2UGtPZaHKWX
         sYfJSWEk4DSD6oQMZTxMdn9TkZ97eARWubG7zg/JIxCAa3Q9/2aCRZ7E5qoNBClSnNvb
         plkJISAvvYC2DYpTm1dMEOG21vnT2p8VeVDSK+0TRWDSzy6pzofQmDhwK8+DMs1Y4Sda
         7rUNdsF2BXDNxe/MBCxV9cvN0fqFIt6b+88U3WLzPo/g0UWdhyNfV7eWtk7FVHOiVbFy
         8mtL4imBVP0o3acwsFIGlyKSp3nqP2X26+VTLiOPg5UKxgw7BPiy1DIG9sOvzI62JazG
         blRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678312120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSi6Beth8Hd606NS4V715NDwa0mm95xS/EhiukW+s4A=;
        b=JLhW2RASgX9kfTRwrNHzunGIzpg5HnN4DiZQGnHajba/z2Al60kgz283eD4Ed+eks9
         qocdWj/qqYiQlNYtBbKyoDr6H7CdkzPkCrnCUXvkwz5RuhUlsozrplVFh7xhqgiPZZVt
         aNMFzdAxEBZbB65eE/lguyh6NniCnBYxtmi97cXvyDCFd3Ods2sLgmaUzxcwfahajEHd
         tm1u8UUn/klTpy3lljCc97pMzB3lCKR/ePx26ad6XJcjr/WOwL+WALkMipLBmAVbfRPO
         3w9lNnGK4zb/ZQs3/ijJCbWplYRgvulkA7ftOE1eWsL5HI3TxOVjiuXbzEI6Oq2wxlED
         nnnQ==
X-Gm-Message-State: AO0yUKVjy6OnXF9BPXH5GoadO2sPRs+pACKQ8EoVUsLNzZu/F9dr0Zif
        Dx5JHs/L8UFU9Bq8SSRGpwPr4g==
X-Google-Smtp-Source: AK7set9vuN8INCmFZBDldnjaZzya3b21KVx/xTSSssDzxqlXf8GDST84z4Er4IgIf1dKoCZy3qx6pw==
X-Received: by 2002:adf:df8f:0:b0:2c8:dc8f:3951 with SMTP id z15-20020adfdf8f000000b002c8dc8f3951mr12301392wrl.5.1678312119704;
        Wed, 08 Mar 2023 13:48:39 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:fbda:65f5:e873:7527])
        by smtp.gmail.com with ESMTPSA id z6-20020adfd0c6000000b002c55efa9cbesm16065713wrh.39.2023.03.08.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:48:39 -0800 (PST)
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
Subject: [PATCH 2/2] thermal/drivers/imx: Use the thermal framework for the trip point
Date:   Wed,  8 Mar 2023 22:48:22 +0100
Message-Id: <20230308214822.1317086-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308214822.1317086-1-daniel.lezcano@linaro.org>
References: <20230308214822.1317086-1-daniel.lezcano@linaro.org>
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

The thermal framework provides an API to get the trip related to a
trip point id. We want to consolidate the generic trip points code,
thus preventing the different drivers to deal with the trip points
after they registered them.

The set_trip_temp ops will be changed regarding the above changes but
first we need to rework a bit the different implementation in the
drivers.

The goal is to prevent using the trip id but use a trip point passed
as parameter which will contain all the needed information.

As we don't have the trip point passed as parameter yet, we get the
trip point using the generic trip thermal framewrok APIs and use it to
take exactly the same decisions.

The difference with this change and the previous code is from where we
get the thermal trip point (which is the same).

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_thermal.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 69ed482167f7..e4e82bdf34f1 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -330,26 +330,29 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
+static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip_id,
 			     int temp)
 {
 	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
+	struct thermal_trip trip;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(data->dev);
 	if (ret < 0)
 		return ret;
 
+	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
+
 	/* do not allow changing critical threshold */
-	if (trip == IMX_TRIP_CRITICAL)
+	if (trip.type == THERMAL_TRIP_CRITICAL)
 		return -EPERM;
-
+	
 	/* do not allow passive to be set higher than critical */
 	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
 		return -EINVAL;
 
-	trips[IMX_TRIP_PASSIVE].temperature = temp;
-
 	imx_set_alarm_temp(data, temp);
 
 	pm_runtime_put(data->dev);
-- 
2.34.1

