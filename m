Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203EB6BE1D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCQHSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCQHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:18:12 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Mar 2023 00:18:10 PDT
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34F13CC36
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:18:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,268,1673884800"; 
   d="scan'208";a="2219544"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 17 Mar 2023 15:16:59 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(80150:0:AUTH_RELAY)
        (envelope-from <jingle.wu@emc.com.tw>); Fri, 17 Mar 2023 15:16:59 +0800 (CST)
Received: from 101.10.109.20
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(2479:0:AUTH_LOGIN)
        (envelope-from <jingle.wu@emc.com.tw>); Fri, 17 Mar 2023 15:16:58 +0800 (CST)
From:   "jingle.wu" <jingle.wu@emc.com.tw>
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
Cc:     phoenix@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw,
        "jingle.wu" <jingle.wu@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit functions.
Date:   Fri, 17 Mar 2023 15:16:46 +0800
Message-Id: <20230317071646.977357-1-jingle.wu@emc.com.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add inhibit/uninhibit functions.

Signed-off-by: Jingle.wu <jingle.wu@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c | 86 +++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 5f0d75a45c80..cc0375265659 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -329,6 +329,89 @@ static int elan_initialize(struct elan_tp_data *data, bool skip_reset)
 	return error;
 }
 
+static int elan_reactivate(struct elan_tp_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	ret = elan_set_power(data, true);
+	if (ret)
+		dev_err(dev, "failed to restore power: %d\n", ret);
+
+	ret = data->ops->sleep_control(data->client, false);
+		if (ret) {
+			dev_err(dev,
+				"failed to wake device up: %d\n", ret);
+			return ret;
+		}
+
+	return ret;
+}
+
+static void elan_inhibit(struct input_dev *input_dev)
+{
+	struct elan_tp_data *data = input_get_drvdata(input_dev);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	if (data->in_fw_update)
+		return;
+
+	dev_dbg(&client->dev, "inhibiting\n");
+	/*
+	 * We are taking the mutex to make sure sysfs operations are
+	 * complete before we attempt to bring the device into low[er]
+	 * power mode.
+	 */
+	ret = mutex_lock_interruptible(&data->sysfs_mutex);
+	if (ret)
+		return;
+
+	disable_irq(client->irq);
+
+	ret = elan_set_power(data, false);
+	if (ret)
+		enable_irq(client->irq);
+
+	mutex_unlock(&data->sysfs_mutex);
+
+}
+
+static void elan_close(struct input_dev *input_dev)
+{
+	if ((input_dev->users) && (!input_dev->inhibited))
+		elan_inhibit(input_dev);
+
+}
+
+static int elan_uninhibit(struct input_dev *input_dev)
+{
+	struct elan_tp_data *data = input_get_drvdata(input_dev);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	dev_dbg(&client->dev, "uninhibiting\n");
+	ret = mutex_lock_interruptible(&data->sysfs_mutex);
+	if (ret)
+		return ret;
+
+	ret = elan_reactivate(data);
+	if (ret == 0)
+		enable_irq(client->irq);
+
+	mutex_unlock(&data->sysfs_mutex);
+
+	return ret;
+}
+
+static int elan_open(struct input_dev *input_dev)
+{
+	if ((input_dev->users) && (input_dev->inhibited))
+		return elan_uninhibit(input_dev);
+
+	return 0;
+}
+
 static int elan_query_device_info(struct elan_tp_data *data)
 {
 	int error;
@@ -1175,6 +1258,9 @@ static int elan_setup_input_device(struct elan_tp_data *data)
 				     0, ETP_FINGER_WIDTH * min_width, 0, 0);
 	}
 
+	input->open = elan_open;
+	input->close = elan_close;
+
 	data->input = input;
 
 	return 0;
-- 
2.34.1

