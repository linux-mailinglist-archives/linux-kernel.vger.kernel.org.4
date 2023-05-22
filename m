Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8194D70CAE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjEVUZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjEVUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:24:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70343B5;
        Mon, 22 May 2023 13:24:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51190fd46c3so85279a12.1;
        Mon, 22 May 2023 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684787086; x=1687379086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laUbyFg9PPjdGbaKz0yrkX7bzWb1Nq4VWWkbufsOMeo=;
        b=oOTsYTnjPLgELSL22TQa70jsdL8/Z7KuhidixophngljW2ek+6kCRHtpUB35v4wtTO
         zC0JtzAQDLJixffK2LwgmgzdlZyHCn9k0lyesQl7kJFn2nZjQ5KCRYih/yOh/6zAkPUw
         tL4dtbPLhzMvlFMXhuIQCPoZdlbadXQ4ddlCw9IOMKtVc5raejfQUMysoN6ayOnKzpmM
         HN4NnlSOUj1NWXLTTNDHstya7YOPOTpDW0QYRHleAbKn5Kk6/ZPVzjnTZp07E3zor8uO
         6nZmMAvl8WixxTzDdK70b11mw/gPDhhVah838Uc4tuJyH3Xmo4bTM2ZKj/5c5fikcnfK
         L0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787086; x=1687379086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laUbyFg9PPjdGbaKz0yrkX7bzWb1Nq4VWWkbufsOMeo=;
        b=O13aCeaGJkRmZUktWOM7vBt7wnB061VtN3ByWmqmU1si+8nPBPq1HA7sl4cXU5NRki
         Ex0eVpEs2r3KcrafhJ+qKDq7BcK4upqM7oChfm+3GQl7ZD6PeI76SQCTl39PMHu26FcP
         T2bXEjt9zayuFrfU522ifF/C6Pb1Azp+XLQMUKJKM41i8fX5LTn3Vzrj02oS6p5w+LPZ
         YZtHfDtce+llgAhN4KiRTCcBLYNqumTIZstYK1a8PmD7IDwzRErS705kqDH2+dWT4rlq
         9m6TXZqHSkqA2hM+wySe55L84PrBRTLM4fwZAfuDF86jvdsdcwJVMTpTgEdbJiW7bYVj
         5qNQ==
X-Gm-Message-State: AC+VfDzXD5wxO067Dk679pHLcIATZLzY50UL1nKRTXpKMFL6W/gOgM0t
        ED++qlqfEuMqHGNg0CqXgdHF3/Jg1P0=
X-Google-Smtp-Source: ACHHUZ779+BClsNOzuq2xyDG7cNsHnCrnYEDhEtdJ6kuaVtWdsI+8Lrwev/Z831p74Ki7f+OtdATUQ==
X-Received: by 2002:aa7:c25a:0:b0:50b:d221:248a with SMTP id y26-20020aa7c25a000000b0050bd221248amr9169837edo.19.1684787085691;
        Mon, 22 May 2023 13:24:45 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c459-f400-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c459:f400::e63])
        by smtp.googlemail.com with ESMTPSA id v2-20020a056402184200b0050d56dffc93sm3265031edy.12.2023.05.22.13.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:24:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v2 4/4] wifi: rtw88: Add support for the SDIO based RTL8723DS chipset
Date:   Mon, 22 May 2023 22:24:25 +0200
Message-Id: <20230522202425.1827005-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522202425.1827005-1-martin.blumenstingl@googlemail.com>
References: <20230522202425.1827005-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up RTL8723DS chipset support using the rtw88 SDIO HCI code as well
as the existing RTL8723D chipset code.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- added Ping-Ke's Reviewed-by (thank you!)


 drivers/net/wireless/realtek/rtw88/Kconfig    | 11 +++++
 drivers/net/wireless/realtek/rtw88/Makefile   |  3 ++
 .../net/wireless/realtek/rtw88/rtw8723ds.c    | 41 +++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723ds.c

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 29eb2f8e0eb7..cffad1c01249 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -111,6 +111,17 @@ config RTW88_8723DE
 
 	  802.11n PCIe wireless network adapter
 
+config RTW88_8723DS
+	tristate "Realtek 8723DS SDIO wireless network adapter"
+	depends on MMC
+	select RTW88_CORE
+	select RTW88_SDIO
+	select RTW88_8723D
+	help
+	  Select this option will enable support for 8723DS chipset
+
+	  802.11n SDIO wireless network adapter
+
 config RTW88_8723DU
 	tristate "Realtek 8723DU USB wireless network adapter"
 	depends on USB
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 82979b30ae8d..fd212c09d88a 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -50,6 +50,9 @@ rtw88_8723d-objs		:= rtw8723d.o rtw8723d_table.o
 obj-$(CONFIG_RTW88_8723DE)	+= rtw88_8723de.o
 rtw88_8723de-objs		:= rtw8723de.o
 
+obj-$(CONFIG_RTW88_8723DS)	+= rtw88_8723ds.o
+rtw88_8723ds-objs		:= rtw8723ds.o
+
 obj-$(CONFIG_RTW88_8723DU)	+= rtw88_8723du.o
 rtw88_8723du-objs		:= rtw8723du.o
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
new file mode 100644
index 000000000000..e5b6960ba0a0
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ */
+
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/module.h>
+#include "main.h"
+#include "rtw8723d.h"
+#include "sdio.h"
+
+static const struct sdio_device_id rtw_8723ds_id_table[] =  {
+	{
+		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
+			    SDIO_DEVICE_ID_REALTEK_RTW8723DS_1ANT),
+		.driver_data = (kernel_ulong_t)&rtw8723d_hw_spec,
+	},
+	{
+		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
+			    SDIO_DEVICE_ID_REALTEK_RTW8723DS_2ANT),
+		.driver_data = (kernel_ulong_t)&rtw8723d_hw_spec,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(sdio, rtw_8723ds_id_table);
+
+static struct sdio_driver rtw_8723ds_driver = {
+	.name = "rtw_8723ds",
+	.probe = rtw_sdio_probe,
+	.remove = rtw_sdio_remove,
+	.id_table = rtw_8723ds_id_table,
+	.drv = {
+		.pm = &rtw_sdio_pm_ops,
+		.shutdown = rtw_sdio_shutdown,
+	}
+};
+module_sdio_driver(rtw_8723ds_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_DESCRIPTION("Realtek 802.11n wireless 8723ds driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.40.1

