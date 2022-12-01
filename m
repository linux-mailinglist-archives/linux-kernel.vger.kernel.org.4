Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7533563E937
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLAFLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLAFLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:11:53 -0500
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.149.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B3D97917
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:11:52 -0800 (PST)
Received: from atl1wswcm03.websitewelcome.com (unknown [50.6.129.164])
        by atl3wswob05.websitewelcome.com (Postfix) with ESMTP id A851C12500
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:47:00 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 0bTOpLUTIPUI80bTPp4Uvj; Thu, 01 Dec 2022 04:47:00 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=a8sHx3T2VDeL3fegfd6hkMq1v2763qASnm4AuQfNaJU=; b=hxyKPInE+kMPMHDFRtfWsg3b61
        RNtOx/S/5AURsyESZohEwJiiYnAsSZmHr62CmFIYmDHh5vR5FWZ6Ggd2LHkag7P2aMxaQipOpFZA7
        gqory90ncb6IqKfxfnewYqW+DTGkFleOBNVVyRSHwO3s1gHMYHqXaSan9/1bSFCyzj+H4Mes9HTVS
        2nCqvlCm6NPCH0IrZcnc7d6RiaBTZ9DNyiSXPHx7abIByk1RDsEqtytW63o4mkUggVwIe3HbZKPGI
        ydh7LJLt1a5BCxsxpsh/7UkiTiGMlOImIlnoCkmYyJfX8Y+e45AZ/vhIeHq3kvb2XosIGd3ApOWCq
        Md3SltCg==;
Received: from [223.187.112.123] (port=34121 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p0bTM-003t5m-Qr;
        Thu, 01 Dec 2022 04:46:56 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v2 1/4] hwmon: pm_bus: core: Add min_uV in pmbus regulator helper macro
Date:   Thu,  1 Dec 2022 05:46:40 +0100
Message-Id: <20221201044643.1150870-2-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201044643.1150870-1-saravanan@linumiz.com>
References: <20221201044643.1150870-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 223.187.112.123
X-Source-L: No
X-Exim-ID: 1p0bTM-003t5m-Qr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [223.187.112.123]:34121
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 14
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGoUxgtQFGDT2DWr52GbBRGCftuQuBFlorD/ih5AX3k086LVW1WI1SLeuABRgaal53G7pE/9ZV8msaWVXsOMHAKmjlBF1VL/B0U7ntdAs70ZC8jBNvQq
 3IC/hdQ3oxDoFSW2nM2ttuiNCCg1UDVwQJZSdasbDL/jjWDS7BwADPXVz8wwrsGjA6E97bE52J0mVEMe2QUTykILvXTluXqwz4g=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some regulator operates in a range of voltage which should not allow
below the lower threshold.

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 drivers/hwmon/pmbus/ltc2978.c | 16 ++++++++--------
 drivers/hwmon/pmbus/pmbus.h   |  5 +++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 6d2592731ba3..406a36885ef3 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -569,14 +569,14 @@ MODULE_DEVICE_TABLE(i2c, ltc2978_id);
 #define LTC2978_N_VOLTAGES	((LTC2978_MAX_UV / LTC2978_UV_STEP) + 1)
 
 static const struct regulator_desc ltc2978_reg_desc[] = {
-	PMBUS_REGULATOR_STEP("vout", 0, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
-	PMBUS_REGULATOR_STEP("vout", 1, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
-	PMBUS_REGULATOR_STEP("vout", 2, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
-	PMBUS_REGULATOR_STEP("vout", 3, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
-	PMBUS_REGULATOR_STEP("vout", 4, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
-	PMBUS_REGULATOR_STEP("vout", 5, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
-	PMBUS_REGULATOR_STEP("vout", 6, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
-	PMBUS_REGULATOR_STEP("vout", 7, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
+	PMBUS_REGULATOR_STEP("vout", 0, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
+	PMBUS_REGULATOR_STEP("vout", 1, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
+	PMBUS_REGULATOR_STEP("vout", 2, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
+	PMBUS_REGULATOR_STEP("vout", 3, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
+	PMBUS_REGULATOR_STEP("vout", 4, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
+	PMBUS_REGULATOR_STEP("vout", 5, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
+	PMBUS_REGULATOR_STEP("vout", 6, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
+	PMBUS_REGULATOR_STEP("vout", 7, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
 };
 
 static const struct regulator_desc ltc2978_reg_desc_default[] = {
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 7daaf0caf4d3..b8c7810c812a 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -464,7 +464,7 @@ struct pmbus_driver_info {
 extern const struct regulator_ops pmbus_regulator_ops;
 
 /* Macros for filling in array of struct regulator_desc */
-#define PMBUS_REGULATOR_STEP(_name, _id, _voltages, _step)  \
+#define PMBUS_REGULATOR_STEP(_name, _id, _voltages, _step, _min_uV)  \
 	[_id] = {						\
 		.name = (_name # _id),				\
 		.supply_name = "vin",				\
@@ -476,9 +476,10 @@ extern const struct regulator_ops pmbus_regulator_ops;
 		.owner = THIS_MODULE,				\
 		.n_voltages = _voltages,			\
 		.uV_step = _step,				\
+		.min_uV = _min_uV,				\
 	}
 
-#define PMBUS_REGULATOR(_name, _id)	PMBUS_REGULATOR_STEP(_name, _id, 0, 0)
+#define PMBUS_REGULATOR(_name, _id)   PMBUS_REGULATOR_STEP(_name, _id, 0, 0, 0)
 
 /* Function declarations */
 
-- 
2.34.1

