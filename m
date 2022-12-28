Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0297D657189
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiL1BGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1BGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:06:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25E8B85E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:06:44 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e21so241920pfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhiBkh5UrcsoNdDiXRM07AJgxIo5p7Z6aIMZaYVIvlo=;
        b=PrdSKTukE+zAUoNbG7/Inyn4sNGFrt6NO9buKwzdkI3nP3vYEoq/SO44sr1/4E8qK1
         Qc2xHsUrCt6IrZy9dSOBoU1F3c/61MRLaMwbeN9RTCPuDkHswFbmzL2hHwEvqMcDtYHd
         pZT3+Wzwhcys+WXAZZp/7QG44mIShSSmYdlw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhiBkh5UrcsoNdDiXRM07AJgxIo5p7Z6aIMZaYVIvlo=;
        b=HApIwANi9+MzpLWyc2AyLa5bd1jxJHTZQkuequ67ClroJ2bUyZwjNLigipm+cZoQuG
         +6eG49kkh+ur65ZydFWQJDSAb+IQoYC/yb9592t4OQruF8AnRpPulzpRY7xyat4ql1Fl
         DyYX2J6eOh1Zq2TcURWhfhgXiKYNAtCXRUvJWWbhGFZItxl6BfD6ZBRB1TOrCfkmMetR
         N8YizYuev7QU/JPLPektCEhlSi1ZMjTRbLd98O9Zl4BdVwyKgrxGmJkLewz0/P4N7Tj5
         PCDqQWP7L21Vozpf6XwA0Q1ALPtJOVZpInOfTNCB8HVnh+Ezo0yA61Og9fBMp77+X51K
         f5ww==
X-Gm-Message-State: AFqh2kqeStEBzoJDWuEBuMelkyhFFQTr3AGYmeFFwxx7W/h65e/7+0er
        EqtUtI67aBiUAkZ9FNKLZWS+Pdyy7r9czV9w
X-Google-Smtp-Source: AMrXdXusSVTTr+/gOVAWeuwTjHDvy/AIwdLmwOkQNWcl+UYKgKn76RnQXJBLCdtBgP180NYFoubdaQ==
X-Received: by 2002:a05:6a00:b48:b0:581:dda:cec3 with SMTP id p8-20020a056a000b4800b005810ddacec3mr14718665pfo.16.1672189603892;
        Tue, 27 Dec 2022 17:06:43 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.17.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:06:43 -0800 (PST)
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
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH 06/10] platform/chrome: cros_ec_typec: Move structs to header
Date:   Wed, 28 Dec 2022 00:45:09 +0000
Message-Id: <20221228004648.793339-7-pmalani@chromium.org>
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

Move ChromeOS Type-C structs into their own header, so they can be
referenced by other files which can be added to the same module.

No functional changes introduced by this patch.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 MAINTAINERS                             |  2 +-
 drivers/platform/chrome/cros_ec_typec.c | 78 +----------------------
 drivers/platform/chrome/cros_ec_typec.h | 85 +++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 77 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_typec.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..8219b646ab50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4998,7 +4998,7 @@ CHROMEOS EC USB TYPE-C DRIVER
 M:	Prashant Malani <pmalani@chromium.org>
 L:	chrome-platform@lists.linux.dev
 S:	Maintained
-F:	drivers/platform/chrome/cros_ec_typec.c
+F:	drivers/platform/chrome/cros_ec_typec.*
 F:	drivers/platform/chrome/cros_typec_switch.c
 
 CHROMEOS EC USB PD NOTIFY DRIVER
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 665fa76e2416..a4eff590ca56 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -7,96 +7,22 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
-#include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
-#include <linux/usb/pd.h>
 #include <linux/usb/pd_vdo.h>
-#include <linux/usb/typec.h>
-#include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_dp.h>
-#include <linux/usb/typec_mux.h>
-#include <linux/usb/typec_retimer.h>
 #include <linux/usb/typec_tbt.h>
-#include <linux/usb/role.h>
+
+#include "cros_ec_typec.h"
 
 #define DRV_NAME "cros-ec-typec"
 
 #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
 				DP_CAP_DFP_D | DP_CAP_RECEPTACLE)
 
-/* Supported alt modes. */
-enum {
-	CROS_EC_ALTMODE_DP = 0,
-	CROS_EC_ALTMODE_TBT,
-	CROS_EC_ALTMODE_MAX,
-};
-
-/* Container for altmode pointer nodes. */
-struct cros_typec_altmode_node {
-	struct typec_altmode *amode;
-	struct list_head list;
-};
-
-/* Per port data. */
-struct cros_typec_port {
-	struct typec_port *port;
-	int port_num;
-	/* Initial capabilities for the port. */
-	struct typec_capability caps;
-	struct typec_partner *partner;
-	struct typec_cable *cable;
-	/* SOP' plug. */
-	struct typec_plug *plug;
-	/* Port partner PD identity info. */
-	struct usb_pd_identity p_identity;
-	/* Port cable PD identity info. */
-	struct usb_pd_identity c_identity;
-	struct typec_switch *ori_sw;
-	struct typec_mux *mux;
-	struct typec_retimer *retimer;
-	struct usb_role_switch *role_sw;
-
-	/* Variables keeping track of switch state. */
-	struct typec_mux_state state;
-	uint8_t mux_flags;
-	uint8_t role;
-
-	struct typec_altmode *port_altmode[CROS_EC_ALTMODE_MAX];
-
-	/* Flag indicating that PD partner discovery data parsing is completed. */
-	bool sop_disc_done;
-	bool sop_prime_disc_done;
-	struct ec_response_typec_discovery *disc_data;
-	struct list_head partner_mode_list;
-	struct list_head plug_mode_list;
-
-	/* PDO-related structs */
-	struct usb_power_delivery *partner_pd;
-	struct usb_power_delivery_capabilities *partner_src_caps;
-	struct usb_power_delivery_capabilities *partner_sink_caps;
-
-	struct cros_typec_data *typec_data;
-};
-
-/* Platform-specific data for the Chrome OS EC Type C controller. */
-struct cros_typec_data {
-	struct device *dev;
-	struct cros_ec_device *ec;
-	int num_ports;
-	unsigned int pd_ctrl_ver;
-	/* Array of ports, indexed by port number. */
-	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
-	struct notifier_block nb;
-	struct work_struct port_work;
-	bool typec_cmd_supported;
-	bool needs_mux_ack;
-};
-
 static int cros_typec_parse_port_props(struct typec_capability *cap,
 				       struct fwnode_handle *fwnode,
 				       struct device *dev)
diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/chrome/cros_ec_typec.h
new file mode 100644
index 000000000000..deda180a646f
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_typec.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __CROS_EC_TYPEC__
+#define __CROS_EC_TYPEC__
+
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/usb/pd.h>
+#include <linux/usb/role.h>
+#include <linux/usb/typec.h>
+#include <linux/usb/typec_altmode.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
+#include <linux/workqueue.h>
+
+/* Supported alt modes. */
+enum {
+	CROS_EC_ALTMODE_DP = 0,
+	CROS_EC_ALTMODE_TBT,
+	CROS_EC_ALTMODE_MAX,
+};
+
+/* Container for altmode pointer nodes. */
+struct cros_typec_altmode_node {
+	struct typec_altmode *amode;
+	struct list_head list;
+};
+
+/* Platform-specific data for the Chrome OS EC Type C controller. */
+struct cros_typec_data {
+	struct device *dev;
+	struct cros_ec_device *ec;
+	int num_ports;
+	unsigned int pd_ctrl_ver;
+	/* Array of ports, indexed by port number. */
+	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
+	struct notifier_block nb;
+	struct work_struct port_work;
+	bool typec_cmd_supported;
+	bool needs_mux_ack;
+};
+
+/* Per port data. */
+struct cros_typec_port {
+	struct typec_port *port;
+	int port_num;
+	/* Initial capabilities for the port. */
+	struct typec_capability caps;
+	struct typec_partner *partner;
+	struct typec_cable *cable;
+	/* SOP' plug. */
+	struct typec_plug *plug;
+	/* Port partner PD identity info. */
+	struct usb_pd_identity p_identity;
+	/* Port cable PD identity info. */
+	struct usb_pd_identity c_identity;
+	struct typec_switch *ori_sw;
+	struct typec_mux *mux;
+	struct typec_retimer *retimer;
+	struct usb_role_switch *role_sw;
+
+	/* Variables keeping track of switch state. */
+	struct typec_mux_state state;
+	uint8_t mux_flags;
+	uint8_t role;
+
+	struct typec_altmode *port_altmode[CROS_EC_ALTMODE_MAX];
+
+	/* Flag indicating that PD partner discovery data parsing is completed. */
+	bool sop_disc_done;
+	bool sop_prime_disc_done;
+	struct ec_response_typec_discovery *disc_data;
+	struct list_head partner_mode_list;
+	struct list_head plug_mode_list;
+
+	/* PDO-related structs */
+	struct usb_power_delivery *partner_pd;
+	struct usb_power_delivery_capabilities *partner_src_caps;
+	struct usb_power_delivery_capabilities *partner_sink_caps;
+
+	struct cros_typec_data *typec_data;
+};
+
+#endif /*  __CROS_EC_TYPEC__ */
-- 
2.39.0.314.g84b9a713c41-goog

