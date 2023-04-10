Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07666DC601
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDJK6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDJK6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:58:52 -0400
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A4B62706
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:58:51 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,333,1673884800"; 
   d="scan'208";a="2469240"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 10 Apr 2023 18:51:48 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(80140:0:AUTH_RELAY)
        (envelope-from <jingle.wu@emc.com.tw>); Mon, 10 Apr 2023 18:51:49 +0800 (CST)
Received: from 101.10.110.106
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(2477:1:AUTH_LOGIN)
        (envelope-from <jingle.wu@emc.com.tw>); Mon, 10 Apr 2023 18:51:47 +0800 (CST)
From:   "jingle.wu" <jingle.wu@emc.com.tw>
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
Cc:     phoenix@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw,
        "jingle.wu" <jingle.wu@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit functions.
Date:   Mon, 10 Apr 2023 18:51:25 +0800
Message-Id: <20230410105125.606481-1-jingle.wu@emc.com.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add inhibit/uninhibit functions.

Signed-off-by: Jingle.wu <jingle.wu@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c | 83 +++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 5f0d75a45c80..423f22fded59 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -329,6 +329,86 @@ static int elan_initialize(struct elan_tp_data *data, bool skip_reset)
 	return error;
 }
 
+static int elan_reactivate(struct elan_tp_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int error;
+
+	error = elan_set_power(data, true);
+	if (error)
+		dev_err(dev, "failed to restore power: %d\n", error);
+
+	error = data->ops->sleep_control(data->client, false);
+	if (error) {
+		dev_err(dev,
+			"failed to wake device up: %d\n", error);
+		return error;
+	}
+
+	return error;
+}
+
+static void elan_inhibit(struct input_dev *input_dev)
+{
+	struct elan_tp_data *data = input_get_drvdata(input_dev);
+	struct i2c_client *client = data->client;
+	int error;
+
+	dev_dbg(&client->dev, "inhibiting\n");
+	/*
+	 * We are taking the mutex to make sure sysfs operations are
+	 * complete before we attempt to bring the device into low[er]
+	 * power mode.
+	 */
+	error = mutex_lock_interruptible(&data->sysfs_mutex);
+	if (error)
+		return;
+
+	disable_irq(client->irq);
+
+	error = elan_set_power(data, false);
+	if (error)
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
+	int error;
+
+	dev_dbg(&client->dev, "uninhibiting\n");
+	error = mutex_lock_interruptible(&data->sysfs_mutex);
+	if (error)
+		return error;
+
+	error = elan_reactivate(data);
+	if (error == 0)
+		enable_irq(client->irq);
+
+	mutex_unlock(&data->sysfs_mutex);
+
+	return error;
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
@@ -1175,6 +1255,9 @@ static int elan_setup_input_device(struct elan_tp_data *data)
 				     0, ETP_FINGER_WIDTH * min_width, 0, 0);
 	}
 
+	input->open = elan_open;
+	input->close = elan_close;
+
 	data->input = input;
 
 	return 0;
-- 
2.34.1

