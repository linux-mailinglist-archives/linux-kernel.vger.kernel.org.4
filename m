Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3165718D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiL1BJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1BJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:09:53 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83483E01D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:09:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id k137so5031114pfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi/kOlETPyv2MAO1V2HCLkw/mua4WIbZ/Rd76axTkmw=;
        b=XPNNK/pdpQNeuytYJsaqiYwaemm2ickjJ1kbCPbCpJWFnmHwC6uAaZ28x8m+64qwaz
         FFUtco2Gwgngd8D+vIcoWIxYtQtyVLOwfdSWTCyUVqp55cjssGMrbyBnog5eY7EXtDe0
         RfbbXbxdQiJxzrOBANsD10JSlZIHMgGVzM1e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi/kOlETPyv2MAO1V2HCLkw/mua4WIbZ/Rd76axTkmw=;
        b=xomE3gbuDTY3AA8VcyHNZ8vY6XHW4NYEllp3TwE+6Z7/zzhWcjTH4WJSMHOlpBRhzy
         AqfIc7+lj6qbHgVo2BfU9+MfY0XvXzGrcgaErPgV0e6Om7qblHf3Zy+nxdEGmFMx85A9
         BCS+Z298IHBsrgS/crtNzTGKPab242vvWsU/q4JOEVnmmuKLucXzLmlqW/MW+BkYa6hT
         pztVKy2oGkFN0gC/rqa9YpSDIF9Qv1GvTDl5pMD9KjfGBj8+i6XWjiJM5L91oUntNcaX
         tzlkWv5swpOFoTCG5G1V2aM1xgYguOVL7KfK8k48Yvj1DhNQjIhzixYZ2Oem+pwqfuJO
         nElA==
X-Gm-Message-State: AFqh2kpEa+29/jUZRGI5r1TmKLMe2FBAKIgAZx9vuJfd2mI8y20Fo8cL
        Tx5/Fa4BKfMoVJu/OmB5r+7jEwPCqdsBtGX9
X-Google-Smtp-Source: AMrXdXuVBAPSSMLpM3oEwlDj1tsNz96oGf/u4MnYLpXIEQnfiMmpoI3CmcNWLbtoYAJyX+u2hvGGZg==
X-Received: by 2002:a62:a21e:0:b0:581:95a7:d2f4 with SMTP id m30-20020a62a21e000000b0058195a7d2f4mr757839pff.9.1672189791828;
        Tue, 27 Dec 2022 17:09:51 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.17.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:09:51 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH 08/10] platform/chrome: cros_ec_typec: Add initial VDM support
Date:   Wed, 28 Dec 2022 00:45:11 +0000
Message-Id: <20221228004648.793339-9-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221228004648.793339-1-pmalani@chromium.org>
References: <20221228004648.793339-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ops to support USB PD VDM (Vendor Defined Message) from the port
driver. This enables the port driver to interface with alternate mode
drivers and communicate with connected peripherals.

The initial support just contains an implementation of the Enter
Mode command.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 MAINTAINERS                              |  1 +
 drivers/platform/chrome/Makefile         |  2 +-
 drivers/platform/chrome/cros_ec_typec.c  |  3 ++
 drivers/platform/chrome/cros_typec_vdm.c | 43 ++++++++++++++++++++++++
 drivers/platform/chrome/cros_typec_vdm.h | 10 ++++++
 5 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/cros_typec_vdm.c
 create mode 100644 drivers/platform/chrome/cros_typec_vdm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8219b646ab50..cfccbbbb083f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5000,6 +5000,7 @@ L:	chrome-platform@lists.linux.dev
 S:	Maintained
 F:	drivers/platform/chrome/cros_ec_typec.*
 F:	drivers/platform/chrome/cros_typec_switch.c
+F:	drivers/platform/chrome/cros_typec_vdm.*
 
 CHROMEOS EC USB PD NOTIFY DRIVER
 M:	Prashant Malani <pmalani@chromium.org>
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index fd29fa74ba33..dae0ed3c8656 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_CROS_TYPEC_SWITCH)		+= cros_typec_switch.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
-cros-ec-typec-objs			:= cros_ec_typec.o
+cros-ec-typec-objs			:= cros_ec_typec.o cros_typec_vdm.o
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros-ec-typec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index a4eff590ca56..1e28d56b094d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -17,6 +17,7 @@
 #include <linux/usb/typec_tbt.h>
 
 #include "cros_ec_typec.h"
+#include "cros_typec_vdm.h"
 
 #define DRV_NAME "cros-ec-typec"
 
@@ -272,6 +273,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 		return PTR_ERR(amode);
 	port->port_altmode[CROS_EC_ALTMODE_DP] = amode;
 	typec_altmode_set_drvdata(amode, port);
+	amode->ops = &port_amode_ops;
 
 	/*
 	 * Register TBT compatibility alt mode. The EC will not enter the mode
@@ -286,6 +288,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 		return PTR_ERR(amode);
 	port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
 	typec_altmode_set_drvdata(amode, port);
+	amode->ops = &port_amode_ops;
 
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
diff --git a/drivers/platform/chrome/cros_typec_vdm.c b/drivers/platform/chrome/cros_typec_vdm.c
new file mode 100644
index 000000000000..df0102ca3a18
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_vdm.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * USB Power Delivery Vendor Defined Message (VDM) support code.
+ *
+ * Copyright 2023 Google LLC
+ * Author: Prashant Malani <pmalani@chromium.org>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/usb/pd_vdo.h>
+
+#include "cros_ec_typec.h"
+#include "cros_typec_vdm.h"
+
+static int cros_typec_port_amode_enter(struct typec_altmode *amode, u32 *vdo)
+{
+	struct cros_typec_port *port = typec_altmode_get_drvdata(amode);
+	struct ec_params_typec_control req = {
+		.port = port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_SEND_VDM_REQ,
+	};
+	struct typec_vdm_req vdm_req = {};
+	u32 hdr;
+
+	hdr = VDO(amode->svid, 1, SVDM_VER_2_0, CMD_ENTER_MODE);
+	hdr |= VDO_OPOS(amode->mode);
+
+	vdm_req.vdm_data[0] = hdr;
+	vdm_req.vdm_data_objects = 1;
+	vdm_req.partner_type = TYPEC_PARTNER_SOP;
+	req.vdm_req_params = vdm_req;
+
+	dev_dbg(port->typec_data->dev, "Sending EnterMode VDM, hdr: %x, port: %d\n",
+		hdr, port->port_num);
+
+	return cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
+			   sizeof(req), NULL, 0);
+}
+
+struct typec_altmode_ops port_amode_ops = {
+	.enter = cros_typec_port_amode_enter,
+};
diff --git a/drivers/platform/chrome/cros_typec_vdm.h b/drivers/platform/chrome/cros_typec_vdm.h
new file mode 100644
index 000000000000..7e282d168a98
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_vdm.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __CROS_TYPEC_VDM__
+#define __CROS_TYPEC_VDM__
+
+#include <linux/usb/typec_altmode.h>
+
+extern struct typec_altmode_ops port_amode_ops;
+
+#endif /*  __CROS_TYPEC_VDM__ */
-- 
2.39.0.314.g84b9a713c41-goog

