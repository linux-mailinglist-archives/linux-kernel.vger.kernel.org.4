Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B236790B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjAXGQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAXGQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:16:35 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28002E0E1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:16:34 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d3so13752690plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3qoCzkgMC3epjfmYnac3zJtIxKInIgHtPqJ9iFFjX4=;
        b=mR+amAtNWxbL3sA+wpkIkPIIcvTPSDrMy97m7q/pylWU/wwE2DWzPHkWp83Ckp+w6Z
         k98nQsH1uxTqwj+6sNcXWnj0XjYhSdcD3i30W7y4l24O83KOIiYmSSppmuZTO9+hFVyY
         HC70CkuaCOE//3gfhOvfA0fRDB2f8ddk2Sc2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3qoCzkgMC3epjfmYnac3zJtIxKInIgHtPqJ9iFFjX4=;
        b=eOssRYCw9pr5AcaiM0q8LxCqgKdJ0zEMZCt47N/XGDnhxFteAp5DvHnXxNufhucQ4B
         MeySxDnhPskcfjub/ltkGEOLdy9rz+cJgyU9coele/TkGNrPF1y1O9p8TZMGoQ+RnD5V
         T2hOsj1drEwDeDLYMOmly8EHqH9AjaKrxPBgm9qUxlSbSHU5D+0l6KzBAWECK3q6+aS9
         IKPJYD81sLIBg2+kkYk9ysX5nsVKyjwaU1yfi7/eNmNOlk3CV5kvM0U5XHfjPP8uaiox
         92ySemJHUla2/0ngSKSNhUq48WitlGc2/GnN3KfWrmHvRWNLkGERtuBkcux0j0ywHCkh
         LVgg==
X-Gm-Message-State: AFqh2kqCdAEW3SXScYOG4KqB2cASt+TD6C60kC3WGLXeV+TlxR0/aWiy
        C9EdJojvgn8/oLLtn3y01JqlgWXRKVJDny9F
X-Google-Smtp-Source: AMrXdXuz+AkjLaL4BZlGjmx7tJSWQRpncIw7ghQdyTfBKvKulfydLevszk+cR8nza8tt/b0H5uoc1A==
X-Received: by 2002:a17:902:bd95:b0:192:5282:6833 with SMTP id q21-20020a170902bd9500b0019252826833mr25801358pls.29.1674540994101;
        Mon, 23 Jan 2023 22:16:34 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:92d9:f31f:cbe8:b7e7])
        by smtp.gmail.com with UTF8SMTPSA id t1-20020a170902e84100b00187197c499asm752584plg.164.2023.01.23.22.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 22:16:33 -0800 (PST)
From:   Victor Ding <victording@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     dustin@howett.net, lee.jones@linaro.org, bleung@chromium.org,
        dnojiri@chromium.org, sebastian.reichel@collabora.com,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        gustavoars@kernel.org, groeck@chromium.org,
        enric.balletbo@collabora.com, tinghan.shen@mediatek.com,
        heikki.krogerus@linux.intel.com, tzungbi@kernel.org,
        Victor Ding <victording@chromium.org>
Subject: [PATCH v2] platform/chrome: cros_ec_typec: allow deferred probe of switch handles
Date:   Tue, 24 Jan 2023 06:16:24 +0000
Message-Id: <20230124061521.v2.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
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

Changes in v2:
- Coverted switch-block to nested if-blocks.

 drivers/platform/chrome/cros_ec_typec.c | 26 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 59de4ce01fab..580f3bdf091c 100644
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
@@ -423,9 +429,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 		}
 
 		ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
-		if (ret)
-			dev_dbg(dev, "No switch control for port %d\n",
-				port_num);
+		if (ret) {
+			dev_dbg(dev, "No switch control for port %d, err: %d\n", port_num, ret);
+			if (ret == -EPROBE_DEFER)
+				goto unregister_ports;
+		}
 
 		ret = cros_typec_register_port_altmodes(typec, port_num);
 		if (ret) {
-- 
2.39.1.405.gd4c25cc71f-goog

