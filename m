Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2E5BFDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIUMS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIUMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:18:54 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CE1F46;
        Wed, 21 Sep 2022 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663762733; x=1695298733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6wtC0IfCnVFcjtOxWfn6dqJt4E95Xn9a4eSwGRpOEsA=;
  b=mvWV7YBHyTReruwUwi6IYgp0mTH4+I7tIPCPrwr9FrCqLI/I1kOvS6lu
   LTCrFHkcQoeLIcmnoyMc1Xz8zE5lDhBCFhmhvv3/z7ISiiz3oYOhrJQYI
   ZLf37/49R5xzHa3Z3kctpZjszSjXWfEuJ0dbwZv695BPSQT5++msKcbJv
   g=;
X-IronPort-AV: E=Sophos;i="5.93,333,1654560000"; 
   d="scan'208";a="132383358"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 12:18:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com (Postfix) with ESMTPS id 87DF6C042C;
        Wed, 21 Sep 2022 12:18:49 +0000 (UTC)
Received: from EX19D013UWB001.ant.amazon.com (10.13.138.52) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 21 Sep 2022 12:18:45 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB001.ant.amazon.com (10.13.138.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 21 Sep 2022 12:18:45 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 21 Sep 2022 12:18:45
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id A72534B01; Wed, 21 Sep 2022 12:18:44 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@intel.com>, <sudipm.mukherjee@gmail.com>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 1/2] hwmon: (mr75203) modify the temperature equation according to series 5 datasheet
Date:   Wed, 21 Sep 2022 12:18:43 +0000
Message-ID: <20220921121844.8059-2-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921121844.8059-1-farbere@amazon.com>
References: <20220921121844.8059-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the equation and coefficients used to convert the digital output
to temperature according to series 5 of the Moortec Embedded Temperature
Sensor (METS) datasheet:
T = G + H * (n / cal5 - 0.5) + J * F

Where:
*) G = 60, H = 200, cal5 = 4094, J = -0.1.
*) F = frequency clock in MHz.
*) n is the digital output.

In code, the G, H and J coefficients are multiplied by a factor of 1000
to get the temperature in milli-Celsius.
Final result is clamped in case it exceeds min/max thresholds.

Change is done since it is unclear where the current equation and
coefficients came from.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
V5 -> V4:
- fix undefined reference to `__divdi3'

V4 -> V3:
- Change 'not clear' to 'unclear' in commit message.
- Add _mC prefix to temperature mix/max defines.
- Add SERIES5 to coefficient defines.

V3 -> V2:
- Protect from overflow.
- Add temperature clamping.
- Add better documentation.

 drivers/hwmon/mr75203.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 8a6ae72fed20..fb262fd2b511 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -102,13 +102,19 @@
 
 #define PVT_POLL_DELAY_US	20
 #define PVT_POLL_TIMEOUT_US	20000
-#define PVT_H_CONST		100000
-#define PVT_CAL5_CONST		2047
-#define PVT_G_CONST		40000
 #define PVT_CONV_BITS		10
 #define PVT_N_CONST		90
 #define PVT_R_CONST		245805
 
+#define PVT_TEMP_MIN_mC		-40000
+#define PVT_TEMP_MAX_mC		125000
+
+/* Temperature coefficients for series 5 */
+#define PVT_SERIES5_H_CONST	200000
+#define PVT_SERIES5_G_CONST	60000
+#define PVT_SERIES5_J_CONST	-100
+#define PVT_SERIES5_CAL5_CONST	4094
+
 #define PRE_SCALER_X1	1
 #define PRE_SCALER_X2	2
 
@@ -174,13 +180,26 @@ static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
 	return 0;
 }
 
+static long pvt_calc_temp(struct pvt_device *pvt, u32 nbs)
+{
+	/*
+	 * Convert the register value to degrees centigrade temperature:
+	 * T = G + H * (n / cal5 - 0.5) + J * F
+	 */
+	s64 tmp = PVT_SERIES5_G_CONST +
+		div_s64(PVT_SERIES5_H_CONST * (s64)nbs, PVT_SERIES5_CAL5_CONST) -
+		PVT_SERIES5_H_CONST / 2 +
+		div_s64(PVT_SERIES5_J_CONST * (s64)pvt->ip_freq, HZ_PER_MHZ);
+
+	return clamp_val(tmp, PVT_TEMP_MIN_mC, PVT_TEMP_MAX_mC);
+}
+
 static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct pvt_device *pvt = dev_get_drvdata(dev);
 	struct regmap *t_map = pvt->t_map;
 	u32 stat, nbs;
 	int ret;
-	u64 tmp;
 
 	switch (attr) {
 	case hwmon_temp_input:
@@ -201,9 +220,7 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 		 * Convert the register value to
 		 * degrees centigrade temperature
 		 */
-		tmp = nbs * PVT_H_CONST;
-		do_div(tmp, PVT_CAL5_CONST);
-		*val = tmp - PVT_G_CONST - pvt->ip_freq;
+		*val = pvt_calc_temp(pvt, nbs);
 
 		return 0;
 	default:
@@ -337,7 +354,7 @@ static int pvt_init(struct pvt_device *pvt)
 		    (key >> 1) << CLK_SYNTH_HI_SFT |
 		    (key >> 1) << CLK_SYNTH_HOLD_SFT | CLK_SYNTH_EN;
 
-	pvt->ip_freq = sys_freq * 100 / (key + 2);
+	pvt->ip_freq = clk_get_rate(pvt->clk) / (key + 2);
 
 	if (t_num) {
 		ret = regmap_write(t_map, SDIF_SMPL_CTRL, 0x0);
-- 
2.37.1

