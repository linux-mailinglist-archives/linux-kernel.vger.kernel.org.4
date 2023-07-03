Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F682745DD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGCNwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjGCNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:52:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A38E5A;
        Mon,  3 Jul 2023 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688392352; x=1719928352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j+6esjbYYXaZyADUf0T58CNTxEPk1Xz526ckaXaqsJI=;
  b=jZLZx0Wect4h3xcGygGWqNTtnGG9IrojJUWR2WWkb1dtPrZ42fYhFoNS
   T7Q8CugTR8G5y4sNytBPBbOmneHZdK3FvcvBlVeI9Tel17uCQ1xEgkKjT
   Ekeg1tVzCygHPB3ocmyJ+JtYqMv5ggMcAfy7QqbcwTP3nMUKwihnQFwwh
   7TjvkkXQo0laVQArodoB8r9BywkvzzjW+R5sI80e8YV9VUgRsXDHKkra9
   Pr3XntRt0543EY5EFgYb4sOsDcgXyWOZfIOAqahmipk633FmS3TELjAet
   b8E4G0iXEaLtmYEfcUfZgdvweMUw5446NAlEqkxvy/v7hfgRfX1Uw3BcN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347673020"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="347673020"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 06:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="863093275"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="863093275"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 06:52:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC460170; Mon,  3 Jul 2023 16:52:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        David Lin <CTLIN0@nuvoton.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Antti Palosaari <crope@iki.fi>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 1/4] lib/math: Move dvb_math.c into lib/math/int_log.c
Date:   Mon,  3 Jul 2023 16:52:08 +0300
Message-Id: <20230703135211.87416-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703135211.87416-1-andriy.shevchenko@linux.intel.com>
References: <20230703135211.87416-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some existing and new users may benefit from the intlog2() and
intlog10() APIs, make them wide available.

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Link: https://lore.kernel.org/r/20230619172019.21457-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/kernel-api.rst                 |  7 +++++--
 Documentation/driver-api/media/dtv-common.rst         |  9 ---------
 drivers/media/dvb-core/Makefile                       |  2 +-
 drivers/media/dvb-frontends/af9013_priv.h             |  2 +-
 drivers/media/dvb-frontends/af9033_priv.h             |  2 +-
 drivers/media/dvb-frontends/cxd2820r_priv.h           |  2 +-
 drivers/media/dvb-frontends/cxd2841er.c               |  2 +-
 .../dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2_mon.c  |  2 +-
 .../dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt_mon.c   |  2 +-
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c     |  2 +-
 drivers/media/dvb-frontends/dib7000p.c                |  2 +-
 drivers/media/dvb-frontends/dib8000.c                 |  2 +-
 drivers/media/dvb-frontends/dib9000.c                 |  2 +-
 drivers/media/dvb-frontends/drxk_hard.c               |  2 +-
 drivers/media/dvb-frontends/lgdt3305.c                |  2 +-
 drivers/media/dvb-frontends/lgdt3306a.c               |  2 +-
 drivers/media/dvb-frontends/lgdt330x.c                |  2 +-
 drivers/media/dvb-frontends/m88ds3103_priv.h          |  2 +-
 drivers/media/dvb-frontends/mn88443x.c                |  2 +-
 drivers/media/dvb-frontends/mn88472_priv.h            |  2 +-
 drivers/media/dvb-frontends/mn88473_priv.h            |  2 +-
 drivers/media/dvb-frontends/or51132.c                 |  2 +-
 drivers/media/dvb-frontends/or51211.c                 |  2 +-
 drivers/media/dvb-frontends/rtl2830_priv.h            |  2 +-
 drivers/media/dvb-frontends/rtl2832_priv.h            |  2 +-
 drivers/media/dvb-frontends/si2165.c                  |  2 +-
 drivers/media/dvb-frontends/stv0367.c                 |  2 +-
 drivers/media/dvb-frontends/tc90522.c                 |  2 +-
 drivers/media/dvb-frontends/tda10048.c                |  2 +-
 include/{media/dvb_math.h => linux/int_log.h}         |  7 +++----
 lib/math/Makefile                                     |  2 +-
 .../media/dvb-core/dvb_math.c => lib/math/int_log.c   | 11 ++++++-----
 32 files changed, 42 insertions(+), 48 deletions(-)
 rename include/{media/dvb_math.h => linux/int_log.h} (92%)
 rename drivers/media/dvb-core/dvb_math.c => lib/math/int_log.c (95%)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index f2bcc5a7ea43..a526fbe06f86 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -162,8 +162,11 @@ Base 2 log and power Functions
 .. kernel-doc:: include/linux/log2.h
    :internal:
 
-Integer power Functions
------------------------
+Integer log and power Functions
+-------------------------------
+
+.. kernel-doc:: include/linux/int_log.h
+   :export:
 
 .. kernel-doc:: lib/math/int_pow.c
    :export:
diff --git a/Documentation/driver-api/media/dtv-common.rst b/Documentation/driver-api/media/dtv-common.rst
index f8b2c4dc8170..207a22bcaf4a 100644
--- a/Documentation/driver-api/media/dtv-common.rst
+++ b/Documentation/driver-api/media/dtv-common.rst
@@ -3,15 +3,6 @@
 Digital TV Common functions
 ---------------------------
 
-Math functions
-~~~~~~~~~~~~~~
-
-Provide some commonly-used math functions, usually required in order to
-estimate signal strength and signal to noise measurements in dB.
-
-.. kernel-doc:: include/media/dvb_math.h
-
-
 DVB devices
 ~~~~~~~~~~~
 
diff --git a/drivers/media/dvb-core/Makefile b/drivers/media/dvb-core/Makefile
index 62b028ded9f7..1cb3ca67bed9 100644
--- a/drivers/media/dvb-core/Makefile
+++ b/drivers/media/dvb-core/Makefile
@@ -8,6 +8,6 @@ dvb-vb2-$(CONFIG_DVB_MMAP) := dvb_vb2.o
 
 dvb-core-objs := dvbdev.o dmxdev.o dvb_demux.o			\
 		 dvb_ca_en50221.o dvb_frontend.o		\
-		 $(dvb-net-y) dvb_ringbuffer.o $(dvb-vb2-y) dvb_math.o
+		 $(dvb-net-y) dvb_ringbuffer.o $(dvb-vb2-y)
 
 obj-$(CONFIG_DVB_CORE) += dvb-core.o
diff --git a/drivers/media/dvb-frontends/af9013_priv.h b/drivers/media/dvb-frontends/af9013_priv.h
index 3b9b9424fe1a..bba7a9693a23 100644
--- a/drivers/media/dvb-frontends/af9013_priv.h
+++ b/drivers/media/dvb-frontends/af9013_priv.h
@@ -12,7 +12,7 @@
 #define AF9013_PRIV_H
 
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "af9013.h"
 #include <linux/firmware.h>
 #include <linux/i2c-mux.h>
diff --git a/drivers/media/dvb-frontends/af9033_priv.h b/drivers/media/dvb-frontends/af9033_priv.h
index 0e64da0cdeab..7560da75ef00 100644
--- a/drivers/media/dvb-frontends/af9033_priv.h
+++ b/drivers/media/dvb-frontends/af9033_priv.h
@@ -14,7 +14,7 @@
 #include <linux/math64.h>
 #include <linux/regmap.h>
 #include <linux/kernel.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 
 struct reg_val {
 	u32 reg;
diff --git a/drivers/media/dvb-frontends/cxd2820r_priv.h b/drivers/media/dvb-frontends/cxd2820r_priv.h
index 9b4d9cf8563d..605320bbc12b 100644
--- a/drivers/media/dvb-frontends/cxd2820r_priv.h
+++ b/drivers/media/dvb-frontends/cxd2820r_priv.h
@@ -11,7 +11,7 @@
 
 #include <linux/dvb/version.h>
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "cxd2820r.h"
 #include <linux/gpio/driver.h> /* For gpio_chip */
 #include <linux/math64.h>
diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-frontends/cxd2841er.c
index 5431f922f55e..ef403a9fb753 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -22,7 +22,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/kernel.h>
 
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include <media/dvb_frontend.h>
 #include "cxd2841er.h"
 #include "cxd2841er_priv.h"
diff --git a/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2_mon.c b/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2_mon.c
index 604580bf7cf7..4e173dd87ecf 100644
--- a/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2_mon.c
+++ b/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2_mon.c
@@ -11,7 +11,7 @@
 #include "cxd2880_tnrdmd_dvbt2.h"
 #include "cxd2880_tnrdmd_dvbt2_mon.h"
 
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 
 static const int ref_dbm_1000[4][8] = {
 	{-96000, -95000, -94000, -93000, -92000, -92000, -98000, -97000},
diff --git a/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt_mon.c b/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt_mon.c
index fedc3b4a2fa0..86d5a1e4022a 100644
--- a/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt_mon.c
+++ b/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt_mon.c
@@ -11,7 +11,7 @@
 #include "cxd2880_tnrdmd_dvbt.h"
 #include "cxd2880_tnrdmd_dvbt_mon.h"
 
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 
 static const int ref_dbm_1000[3][5] = {
 	{-93000, -91000, -90000, -89000, -88000},
diff --git a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
index d5b1b3788e39..f67b6d24b8d4 100644
--- a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
+++ b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
@@ -11,7 +11,7 @@
 #include <linux/spi/spi.h>
 
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 
 #include "cxd2880.h"
 #include "cxd2880_tnrdmd_mon.h"
diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index a90d2f51868f..b791e687d2e2 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -13,7 +13,7 @@
 #include <linux/mutex.h>
 #include <asm/div64.h>
 
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include <media/dvb_frontend.h>
 
 #include "dib7000p.h"
diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index fe19d127abb3..2abda7d1cb6e 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -13,7 +13,7 @@
 #include <linux/mutex.h>
 #include <asm/div64.h>
 
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 
 #include <media/dvb_frontend.h>
 
diff --git a/drivers/media/dvb-frontends/dib9000.c b/drivers/media/dvb-frontends/dib9000.c
index 914ca820c174..1c57587a917a 100644
--- a/drivers/media/dvb-frontends/dib9000.c
+++ b/drivers/media/dvb-frontends/dib9000.c
@@ -11,7 +11,7 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include <media/dvb_frontend.h>
 
 #include "dib9000.h"
diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 3301ef75d441..6ad4f202f1bf 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -20,7 +20,7 @@
 #include <media/dvb_frontend.h>
 #include "drxk.h"
 #include "drxk_hard.h"
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 
 static int power_down_dvbt(struct drxk_state *state, bool set_power_mode);
 static int power_down_qam(struct drxk_state *state);
diff --git a/drivers/media/dvb-frontends/lgdt3305.c b/drivers/media/dvb-frontends/lgdt3305.c
index 62d743988919..c15d3735d34c 100644
--- a/drivers/media/dvb-frontends/lgdt3305.c
+++ b/drivers/media/dvb-frontends/lgdt3305.c
@@ -10,7 +10,7 @@
 #include <asm/div64.h>
 #include <linux/dvb/frontend.h>
 #include <linux/slab.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "lgdt3305.h"
 
 static int debug;
diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
index 70258884126b..3c6650f6e9a3 100644
--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -12,7 +12,7 @@
 #include <asm/div64.h>
 #include <linux/kernel.h>
 #include <linux/dvb/frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "lgdt3306a.h"
 #include <linux/i2c-mux.h>
 
diff --git a/drivers/media/dvb-frontends/lgdt330x.c b/drivers/media/dvb-frontends/lgdt330x.c
index 83565209c3b1..97a10996c7fa 100644
--- a/drivers/media/dvb-frontends/lgdt330x.c
+++ b/drivers/media/dvb-frontends/lgdt330x.c
@@ -28,7 +28,7 @@
 #include <asm/byteorder.h>
 
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "lgdt330x_priv.h"
 #include "lgdt330x.h"
 
diff --git a/drivers/media/dvb-frontends/m88ds3103_priv.h b/drivers/media/dvb-frontends/m88ds3103_priv.h
index aa5306f40201..594ad9cbc2cc 100644
--- a/drivers/media/dvb-frontends/m88ds3103_priv.h
+++ b/drivers/media/dvb-frontends/m88ds3103_priv.h
@@ -10,7 +10,7 @@
 
 #include <media/dvb_frontend.h>
 #include "m88ds3103.h"
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include <linux/firmware.h>
 #include <linux/i2c-mux.h>
 #include <linux/regmap.h>
diff --git a/drivers/media/dvb-frontends/mn88443x.c b/drivers/media/dvb-frontends/mn88443x.c
index 2ce5692bc22c..db2921c736af 100644
--- a/drivers/media/dvb-frontends/mn88443x.c
+++ b/drivers/media/dvb-frontends/mn88443x.c
@@ -10,7 +10,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 
 #include "mn88443x.h"
 
diff --git a/drivers/media/dvb-frontends/mn88472_priv.h b/drivers/media/dvb-frontends/mn88472_priv.h
index 337562723f88..41f14bd67bfd 100644
--- a/drivers/media/dvb-frontends/mn88472_priv.h
+++ b/drivers/media/dvb-frontends/mn88472_priv.h
@@ -9,7 +9,7 @@
 #define MN88472_PRIV_H
 
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "mn88472.h"
 #include <linux/firmware.h>
 #include <linux/regmap.h>
diff --git a/drivers/media/dvb-frontends/mn88473_priv.h b/drivers/media/dvb-frontends/mn88473_priv.h
index eca7f4e2b769..e9daaacfa22f 100644
--- a/drivers/media/dvb-frontends/mn88473_priv.h
+++ b/drivers/media/dvb-frontends/mn88473_priv.h
@@ -9,7 +9,7 @@
 #define MN88473_PRIV_H
 
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "mn88473.h"
 #include <linux/math64.h>
 #include <linux/firmware.h>
diff --git a/drivers/media/dvb-frontends/or51132.c b/drivers/media/dvb-frontends/or51132.c
index 24de1b115158..355f3598627b 100644
--- a/drivers/media/dvb-frontends/or51132.c
+++ b/drivers/media/dvb-frontends/or51132.c
@@ -27,7 +27,7 @@
 #include <linux/slab.h>
 #include <asm/byteorder.h>
 
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include <media/dvb_frontend.h>
 #include "or51132.h"
 
diff --git a/drivers/media/dvb-frontends/or51211.c b/drivers/media/dvb-frontends/or51211.c
index ddcaea5c9941..ae732dc5116e 100644
--- a/drivers/media/dvb-frontends/or51211.c
+++ b/drivers/media/dvb-frontends/or51211.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <asm/byteorder.h>
 
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include <media/dvb_frontend.h>
 #include "or51211.h"
 
diff --git a/drivers/media/dvb-frontends/rtl2830_priv.h b/drivers/media/dvb-frontends/rtl2830_priv.h
index fae78ed78522..ae1fc24a4d84 100644
--- a/drivers/media/dvb-frontends/rtl2830_priv.h
+++ b/drivers/media/dvb-frontends/rtl2830_priv.h
@@ -9,7 +9,7 @@
 #define RTL2830_PRIV_H
 
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "rtl2830.h"
 #include <linux/i2c-mux.h>
 #include <linux/math64.h>
diff --git a/drivers/media/dvb-frontends/rtl2832_priv.h b/drivers/media/dvb-frontends/rtl2832_priv.h
index 5f79f95b9475..f11ba038d5f0 100644
--- a/drivers/media/dvb-frontends/rtl2832_priv.h
+++ b/drivers/media/dvb-frontends/rtl2832_priv.h
@@ -14,7 +14,7 @@
 #include <linux/bitops.h>
 
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "rtl2832.h"
 
 struct rtl2832_dev {
diff --git a/drivers/media/dvb-frontends/si2165.c b/drivers/media/dvb-frontends/si2165.c
index 72810efd1a96..434d003bf397 100644
--- a/drivers/media/dvb-frontends/si2165.c
+++ b/drivers/media/dvb-frontends/si2165.c
@@ -19,7 +19,7 @@
 #include <linux/regmap.h>
 
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "si2165_priv.h"
 #include "si2165.h"
 
diff --git a/drivers/media/dvb-frontends/stv0367.c b/drivers/media/dvb-frontends/stv0367.c
index 95e376f23506..a93f40617469 100644
--- a/drivers/media/dvb-frontends/stv0367.c
+++ b/drivers/media/dvb-frontends/stv0367.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 
 #include "stv0367.h"
 #include "stv0367_defs.h"
diff --git a/drivers/media/dvb-frontends/tc90522.c b/drivers/media/dvb-frontends/tc90522.c
index 879f028f9682..1f8cbf45554a 100644
--- a/drivers/media/dvb-frontends/tc90522.c
+++ b/drivers/media/dvb-frontends/tc90522.c
@@ -21,7 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/dvb/frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "tc90522.h"
 
 #define TC90522_I2C_THRU_REG 0xfe
diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
index 0b3f6999515e..3cb4e5270e4f 100644
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -16,7 +16,7 @@
 #include <linux/math64.h>
 #include <asm/div64.h>
 #include <media/dvb_frontend.h>
-#include <media/dvb_math.h>
+#include <linux/int_log.h>
 #include "tda10048.h"
 
 #define TDA10048_DEFAULT_FIRMWARE "dvb-fe-tda10048-1.0.fw"
diff --git a/include/media/dvb_math.h b/include/linux/int_log.h
similarity index 92%
rename from include/media/dvb_math.h
rename to include/linux/int_log.h
index 8690ec42954d..332306202464 100644
--- a/include/media/dvb_math.h
+++ b/include/linux/int_log.h
@@ -1,6 +1,5 @@
 /*
- * dvb-math provides some complex fixed-point math
- * operations shared between the dvb related stuff
+ * Provides fixed-point logarithm operations.
  *
  * Copyright (C) 2006 Christoph Pfister (christophpfister@gmail.com)
  *
@@ -15,8 +14,8 @@
  * GNU Lesser General Public License for more details.
  */
 
-#ifndef __DVB_MATH_H
-#define __DVB_MATH_H
+#ifndef __LINUX_INT_LOG_H
+#define __LINUX_INT_LOG_H
 
 #include <linux/types.h>
 
diff --git a/lib/math/Makefile b/lib/math/Makefile
index bfac26ddfc22..91fcdb0c9efe 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
+obj-y += div64.o gcd.o lcm.o int_log.o int_pow.o int_sqrt.o reciprocal_div.o
 
 obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
diff --git a/drivers/media/dvb-core/dvb_math.c b/lib/math/int_log.c
similarity index 95%
rename from drivers/media/dvb-core/dvb_math.c
rename to lib/math/int_log.c
index dc90564d7f34..322df25a22d6 100644
--- a/drivers/media/dvb-core/dvb_math.c
+++ b/lib/math/int_log.c
@@ -1,6 +1,5 @@
 /*
- * dvb-math provides some complex fixed-point math
- * operations shared between the dvb related stuff
+ * Provides fixed-point logarithm operations.
  *
  * Copyright (C) 2006 Christoph Pfister (christophpfister@gmail.com)
  *
@@ -16,10 +15,12 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/int_log.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/types.h>
+
 #include <asm/bug.h>
-#include <media/dvb_math.h>
 
 static const unsigned short logtable[256] = {
 	0x0000, 0x0171, 0x02e0, 0x044e, 0x05ba, 0x0725, 0x088e, 0x09f7,
@@ -53,7 +54,7 @@ static const unsigned short logtable[256] = {
 	0xe82a, 0xe8ef, 0xe9b3, 0xea77, 0xeb3b, 0xebfe, 0xecc1, 0xed83,
 	0xee45, 0xef06, 0xefc8, 0xf088, 0xf149, 0xf209, 0xf2c8, 0xf387,
 	0xf446, 0xf505, 0xf5c3, 0xf680, 0xf73e, 0xf7fb, 0xf8b7, 0xf973,
-	0xfa2f, 0xfaea, 0xfba5, 0xfc60, 0xfd1a, 0xfdd4, 0xfe8e, 0xff47
+	0xfa2f, 0xfaea, 0xfba5, 0xfc60, 0xfd1a, 0xfdd4, 0xfe8e, 0xff47,
 };
 
 unsigned int intlog2(u32 value)
-- 
2.40.0.1.gaa8946217a0b

