Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F3D67777C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjAWJgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjAWJgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:36:47 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ABD19681
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:36:45 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w2so8280086pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFYzShK5REiM5CKMrVZytypQd+WfwC4rc1Yywb/Eki8=;
        b=KEd/7q40xnCCvJ/LmtQxG11kIuVJDt9n6RS0gxD4tXS0+IvlgcY0oLp1AMwkfsuJ7A
         /k3gbdBtyBc54S9CsIkJr3XbApvmP/hGGGhunLr94b6R1MQGxwcwYrh5VEZP4qhDrSR8
         wyEPVyvToL4EWm+agqnIh/Bk2K0KWIyWu6GxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFYzShK5REiM5CKMrVZytypQd+WfwC4rc1Yywb/Eki8=;
        b=MEL5b7mDGmRVauXOAJ8F2qvHcFITBFfRv6rOeVeqPyHQIDe9adhAViNlYiZSt2WVL9
         JyCJ5q4nbA255pJjQJ3HYy1H4o9yqzeUM0yTGeAJoN/WuxsaC9fwap8vZpvMQfK6hO4G
         qRP4kBqNIhahRa6dhpxXxsf6npyExw7h8HpQNvEWICZ7b/CzrpJUiMfzHmhySJD7lGU6
         wTPjeiM8aNZ7tl6cpoIaGtkrQfS0d9GzlEM4MmbVKfr6M3SxBEsatKaxMAghkRfpU6Zy
         XwrgJ7eVoYYkfCU8SAFzjNiPx/ueuKCkPIPUv1Xr7oacV9JdDrlQfxHzpq+/JMabkj/s
         jfSw==
X-Gm-Message-State: AFqh2kpa9aQVXKYMy0L7WJycIs0sWj/xUfQFhQirdI3M9qyLnZM2IkII
        etIIqr/hdCJqqXzcMIX9uzrfPmB25sRqBmiEqiw=
X-Google-Smtp-Source: AMrXdXuBya1dQ6d3uii7yx3u6Pukr1ObaBXUwgPT4hfUQ+czkewaLHVKhuAcAOb0HnUGsDjItVpldQ==
X-Received: by 2002:a05:6a00:f07:b0:581:61a7:c8f0 with SMTP id cr7-20020a056a000f0700b0058161a7c8f0mr24701076pfb.4.1674466605148;
        Mon, 23 Jan 2023 01:36:45 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:92d9:f31f:cbe8:b7e7])
        by smtp.gmail.com with UTF8SMTPSA id 190-20020a6219c7000000b00589d91962d5sm25319731pfz.195.2023.01.23.01.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:36:44 -0800 (PST)
From:   Victor Ding <victording@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     gustavoars@kernel.org, heikki.krogerus@linux.intel.com,
        dnojiri@chromium.org, dustin@howett.net, lee.jones@linaro.org,
        tzungbi@kernel.org, groeck@chromium.org,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        tinghan.shen@mediatek.com, sebastian.reichel@collabora.com,
        enric.balletbo@collabora.com, bleung@chromium.org,
        Victor Ding <victording@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: allow deferred probe of switch handles
Date:   Mon, 23 Jan 2023 09:36:20 +0000
Message-Id: <20230123093609.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
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

`fwnode_typec_{retimer,mux,switch}_get()` could return `-EPROBE_DEFER`,
which is called from `cros_typec_get_switch_handles`. When this happens,
it does not indicate absence of switches; instead, it only hints that
probing of switches should occur at a later time.

Progagate `-EPROBE_DEFER` to upper layer logic so that they can re-try
probing switches as a better time.

Signed-off-by: Victor Ding <victording@chromium.org>
---

 drivers/platform/chrome/cros_ec_typec.c | 30 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 59de4ce01fab..f4b3fc788491 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -145,31 +145,37 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 					 struct fwnode_handle *fwnode,
 					 struct device *dev)
 {
+	int ret = 0;
+
 	port->mux = fwnode_typec_mux_get(fwnode, NULL);
 	if (IS_ERR(port->mux)) {
-		dev_dbg(dev, "Mux handle not found.\n");
+		ret = PTR_ERR(port->mux);
+		dev_dbg(dev, "Mux handle not found: %d.\n", ret);
 		goto mux_err;
 	}
 
 	port->retimer = fwnode_typec_retimer_get(fwnode);
 	if (IS_ERR(port->retimer)) {
-		dev_dbg(dev, "Retimer handle not found.\n");
+		ret = PTR_ERR(port->retimer);
+		dev_dbg(dev, "Retimer handle not found: %d.\n", ret);
 		goto retimer_sw_err;
 	}
 
 	port->ori_sw = fwnode_typec_switch_get(fwnode);
 	if (IS_ERR(port->ori_sw)) {
-		dev_dbg(dev, "Orientation switch handle not found.\n");
+		ret = PTR_ERR(port->ori_sw);
+		dev_dbg(dev, "Orientation switch handle not found: %d\n", ret);
 		goto ori_sw_err;
 	}
 
 	port->role_sw = fwnode_usb_role_switch_get(fwnode);
 	if (IS_ERR(port->role_sw)) {
-		dev_dbg(dev, "USB role switch handle not found.\n");
+		ret = PTR_ERR(port->role_sw);
+		dev_dbg(dev, "USB role switch handle not found: %d\n", ret);
 		goto role_sw_err;
 	}
 
-	return 0;
+	return ret;
 
 role_sw_err:
 	typec_switch_put(port->ori_sw);
@@ -181,7 +187,7 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 	typec_mux_put(port->mux);
 	port->mux = NULL;
 mux_err:
-	return -ENODEV;
+	return ret;
 }
 
 static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
@@ -423,9 +429,15 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 		}
 
 		ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
-		if (ret)
-			dev_dbg(dev, "No switch control for port %d\n",
-				port_num);
+		switch (ret) {
+		case 0:
+			break;
+		case -EPROBE_DEFER:
+			dev_err(dev, "Deferring getting switch handles at port %d\n", port_num);
+			goto unregister_ports;
+		default:
+			dev_dbg(dev, "No switch control for port %d, err: %d\n", port_num, ret);
+		}
 
 		ret = cros_typec_register_port_altmodes(typec, port_num);
 		if (ret) {
-- 
2.39.0.246.g2a6d74b583-goog

