Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411A74539E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 03:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGCBfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 21:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGCBfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 21:35:05 -0400
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A98C12E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 18:35:00 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,177,1684771200"; 
   d="scan'208";a="3449495"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 03 Jul 2023 09:34:55 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(94702:1:AUTH_RELAY)
        (envelope-from <jingle.wu@emc.com.tw>); Mon, 03 Jul 2023 09:34:55 +0800 (CST)
Received: from 110.28.49.88
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(102917:0:AUTH_LOGIN)
        (envelope-from <jingle.wu@emc.com.tw>); Mon, 03 Jul 2023 09:34:54 +0800 (CST)
From:   "jingle.wu" <jingle.wu@emc.com.tw>
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
Cc:     phoenix@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw,
        "jingle.wu" <jingle.wu@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit functions.
Date:   Mon,  3 Jul 2023 09:34:38 +0800
Message-Id: <20230703013438.570643-1-jingle.wu@emc.com.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add inhibit/uninhibit functions.

Due to some devices, the touchpad will be interfered with by
the screen noise when lid close.
---
 drivers/input/mouse/elan_i2c_core.c | 207 ++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 5f0d75a45c80..4ea57f4c7bd4 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -56,6 +56,7 @@ struct elan_tp_data {
 	struct input_dev	*input;
 	struct input_dev	*tp_input; /* trackpoint input node */
 	struct regulator	*vcc;
+	struct list_head list;	/* for list of devices needing input handler */
 
 	const struct elan_transport_ops *ops;
 
@@ -63,6 +64,11 @@ struct elan_tp_data {
 	struct completion	fw_completion;
 	bool			in_fw_update;
 
+	struct work_struct	lid_work;
+	bool			lid_switch;
+	int			lid_value;
+	bool			in_inhibit;
+
 	struct mutex		sysfs_mutex;
 
 	unsigned int		max_x;
@@ -96,6 +102,9 @@ struct elan_tp_data {
 	u32			quirks;		/* Various quirks */
 };
 
+static struct workqueue_struct *elan_mode_wq;
+static LIST_HEAD(elan_devices_with_lid_handler);
+
 static u32 elan_i2c_lookup_quirks(u16 ic_type, u16 product_id)
 {
 	static const struct {
@@ -329,6 +338,74 @@ static int elan_initialize(struct elan_tp_data *data, bool skip_reset)
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
+static int elan_inhibit(struct input_dev *input_dev)
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
+		return error;
+
+	disable_irq(client->irq);
+
+	error = elan_set_power(data, false);
+	if (error)
+		enable_irq(client->irq);
+
+	data->in_inhibit = true;
+	mutex_unlock(&data->sysfs_mutex);
+
+	return error;
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
+	data->in_inhibit = false;
+	mutex_unlock(&data->sysfs_mutex);
+
+	return error;
+}
+
 static int elan_query_device_info(struct elan_tp_data *data)
 {
 	int error;
@@ -1187,6 +1264,124 @@ static void elan_disable_regulator(void *_data)
 	regulator_disable(data->vcc);
 }
 
+static void lid_work_handler(struct work_struct *work)
+{
+	struct elan_tp_data *data = container_of(work, struct elan_tp_data,
+					    lid_work);
+
+	if (data->lid_value)
+		elan_inhibit(data->input);
+	else
+		elan_uninhibit(data->input);
+
+}
+
+static void elan_input_lid_event(struct input_handle *handle, unsigned int type,
+			     unsigned int code, int value)
+{
+	struct elan_tp_data *data, *n;
+
+	if (type == EV_SW && code == SW_LID) {
+		list_for_each_entry_safe(data, n, &elan_devices_with_lid_handler, list) {
+			data->lid_value = value;
+			queue_work(elan_mode_wq, &data->lid_work);
+		}
+	}
+
+}
+
+struct elan_input_lid {
+	struct input_handle handle;
+};
+
+static int elan_input_lid_connect(struct input_handler *handler,
+				struct input_dev *dev,
+				const struct input_device_id *id)
+{
+	struct elan_input_lid *lid;
+	char *name;
+	int error;
+
+	lid = kzalloc(sizeof(*lid), GFP_KERNEL);
+	if (!lid)
+		return -ENOMEM;
+	name = kasprintf(GFP_KERNEL, "elan-i2c-lid-%s", dev_name(&dev->dev));
+	if (!name) {
+		error = -ENOMEM;
+		goto err_free_lid;
+	}
+	lid->handle.dev = dev;
+	lid->handle.handler = handler;
+	lid->handle.name = name;
+	lid->handle.private = lid;
+	error = input_register_handle(&lid->handle);
+	if (error)
+		goto err_free_name;
+	error = input_open_device(&lid->handle);
+	if (error)
+		goto err_unregister_handle;
+	return 0;
+err_unregister_handle:
+	input_unregister_handle(&lid->handle);
+err_free_name:
+	kfree(name);
+err_free_lid:
+	kfree(lid);
+	return error;
+}
+
+static void elan_input_lid_disconnect(struct input_handle *handle)
+{
+	struct elan_input_lid *lid = handle->private;
+
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle->name);
+	kfree(lid);
+}
+
+static const struct input_device_id elan_input_lid_ids[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_SWBIT,
+		.evbit = { BIT_MASK(EV_SW) },
+		.swbit = { [BIT_WORD(SW_LID)] = BIT_MASK(SW_LID) },
+	},
+	{ },
+};
+
+static struct input_handler elan_input_lid_handler = {
+	.event =	elan_input_lid_event,
+	.connect =	elan_input_lid_connect,
+	.disconnect =	elan_input_lid_disconnect,
+	.name =		"elan-i2c-lid",
+	.id_table =	elan_input_lid_ids,
+};
+
+static int elan_create_lid_handler(struct elan_tp_data *data)
+{
+	int error = 0;
+
+	elan_mode_wq = create_singlethread_workqueue("elan-i2c-lid");
+	if (elan_mode_wq == NULL)
+		return -ENOMEM;
+	error = input_register_handler(&elan_input_lid_handler);
+	if (error)
+		goto remove_wq;
+
+	data->lid_switch = true;
+	INIT_LIST_HEAD(&data->list);
+	INIT_WORK(&data->lid_work, lid_work_handler);
+	list_add_tail(&data->list, &elan_devices_with_lid_handler);
+
+	return 0;
+
+remove_wq:
+	data->lid_switch = false;
+	destroy_workqueue(elan_mode_wq);
+	elan_mode_wq = NULL;
+	return error;
+}
+
 static int elan_probe(struct i2c_client *client)
 {
 	const struct elan_transport_ops *transport_ops;
@@ -1325,6 +1520,10 @@ static int elan_probe(struct i2c_client *client)
 		}
 	}
 
+	error = elan_create_lid_handler(data);
+	if (error)
+		dev_err(dev, "failed to create lid handler: %d\n", error);
+
 	return 0;
 }
 
@@ -1334,6 +1533,10 @@ static int elan_suspend(struct device *dev)
 	struct elan_tp_data *data = i2c_get_clientdata(client);
 	int ret;
 
+	/* Wait for switch on completion */
+	if (data->lid_switch)
+		flush_workqueue(elan_mode_wq);
+
 	/*
 	 * We are taking the mutex to make sure sysfs operations are
 	 * complete before we attempt to bring the device into low[er]
@@ -1371,6 +1574,10 @@ static int elan_resume(struct device *dev)
 	struct elan_tp_data *data = i2c_get_clientdata(client);
 	int error;
 
+	/* Wait for switch on completion */
+	if (data->lid_switch)
+		flush_workqueue(elan_mode_wq);
+
 	if (!device_may_wakeup(dev)) {
 		error = regulator_enable(data->vcc);
 		if (error) {
-- 
2.34.1

