Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597FC6FF996
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbjEKSxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbjEKSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:53:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7E919A6;
        Thu, 11 May 2023 11:52:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c690f7fa4so6025583a12.0;
        Thu, 11 May 2023 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831178; x=1686423178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmpqhd4kEVSfc34qTZPnmcAbaqtTD/WUYsFYDWaUQYA=;
        b=J0KpfIPyc27+FlEt8VAmD2SccAPF4n7ZCciZPT8YjZZ3OvVuBy6CXG0fheIGnSRwae
         pSYJzpOPHwXRaUvK9BoyDG564kWXnp709DFrpvOsFwSFCFm4PtRTHgGqXOLS6mGEvgiw
         5P0aOCHbZXSkky/PGZEKxR3jimkFN+8FpL27nE9qjNKEIHnsWuBP+9mJyimoPMvnMxbz
         a6PCxNlE3is/Wy0y1tOKnS6mf+HaXoZ+X3M7UlMggcbpOXxw4uqf3xSZcR7VOtojfTbu
         76y5GuuADkhlBTouj2pF2HpwYQEhX+UHGYMYowmMdrqENY0DkH7kD2QRq14zzdTd+8Io
         HjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831178; x=1686423178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmpqhd4kEVSfc34qTZPnmcAbaqtTD/WUYsFYDWaUQYA=;
        b=LV0b92E2Eb2RWUHbMAsgHcqSrHmSOLMvKJiC2ZM57CRVNnXtVZAW1ws+xPkKvmGvMV
         xxpGmKVngrdqMGoAGIxsV5T9wloeO5xG+eK7HHRUq8fJS9htj29vAfPpt5OqhsLwEIyT
         bKnlE5qt3iDtDXaPAs+W7uPj3RvOkngwBb6fZT28dwSZft+u6TTyIz2FfDfWVTUiHYXD
         0ekYaGKjnJW0H/BKcPqBAyjcYRWZFWlHwecaz6+EMiNW1n8wyTR+1qluOiOo5PDPPY9o
         YDoBpzx3KPdBevfRP8E0Ao8DDdpAEObGLfCux/N3QxnPUV/OLZDNLeYY5e4/fKyNAARQ
         Jh5g==
X-Gm-Message-State: AC+VfDy1+KLz36ed0Tk+xDXY0EQEBjQnIp5e9TTyQm7MqBC5oKORlep1
        33nhgdlyN/fIyUdBQln8PE8QEcot1j8=
X-Google-Smtp-Source: ACHHUZ741L7hlP7jXwh/IFnUETPT50KLKqUeoIuUpHADj/AKOZUcKoRqsYoN9P2PMbacALxCdl4+Tw==
X-Received: by 2002:a17:903:44c:b0:1ab:27e7:ad76 with SMTP id iw12-20020a170903044c00b001ab27e7ad76mr21361645plb.45.1683831178172;
        Thu, 11 May 2023 11:52:58 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:84a:ed9c:4024:c347])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001a980a23804sm6288995pll.4.2023.05.11.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:52:57 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] Input: libps2 - attach ps2dev instances as serio port's drvdata
Date:   Thu, 11 May 2023 11:52:41 -0700
Message-ID: <20230511185252.386941-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
References: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
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

In preparation of having unified interrupt handler for PS/2 devices,
instead of attaching instances of psmouse and atkbd structures as serio's
driver data, switch to attaching ps2dev instances.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/atkbd.c     | 23 +++++++++++++-------
 drivers/input/mouse/psmouse-base.c | 35 +++++++++++++++++-------------
 drivers/input/mouse/psmouse.h      |  2 ++
 drivers/input/mouse/synaptics.c    | 10 ++++-----
 drivers/input/mouse/trackpoint.c   |  2 +-
 drivers/input/serio/libps2.c       |  1 +
 6 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 246958795f60..2fb2ad73e796 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -309,12 +309,19 @@ static ssize_t atkbd_show_function_row_physmap(struct atkbd *atkbd, char *buf)
 	return vivaldi_function_row_physmap_show(&atkbd->vdata, buf);
 }
 
+static struct atkbd *atkbd_from_serio(struct serio *serio)
+{
+	struct ps2dev *ps2dev = serio_get_drvdata(serio);
+
+	return container_of(ps2dev, struct atkbd, ps2dev);
+}
+
 static umode_t atkbd_attr_is_visible(struct kobject *kobj,
 				struct attribute *attr, int i)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct serio *serio = to_serio_port(dev);
-	struct atkbd *atkbd = serio_get_drvdata(serio);
+	struct atkbd *atkbd = atkbd_from_serio(serio);
 
 	if (attr == &atkbd_attr_function_row_physmap.attr &&
 	    !atkbd->vdata.num_function_row_keys)
@@ -399,7 +406,7 @@ static unsigned int atkbd_compat_scancode(struct atkbd *atkbd, unsigned int code
 static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 				   unsigned int flags)
 {
-	struct atkbd *atkbd = serio_get_drvdata(serio);
+	struct atkbd *atkbd = atkbd_from_serio(serio);
 	struct input_dev *dev = atkbd->dev;
 	unsigned int code = data;
 	int scroll = 0, hscroll = 0, click = -1;
@@ -909,7 +916,7 @@ static int atkbd_reset_state(struct atkbd *atkbd)
 
 static void atkbd_cleanup(struct serio *serio)
 {
-	struct atkbd *atkbd = serio_get_drvdata(serio);
+	struct atkbd *atkbd = atkbd_from_serio(serio);
 
 	atkbd_disable(atkbd);
 	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_DEF);
@@ -922,7 +929,7 @@ static void atkbd_cleanup(struct serio *serio)
 
 static void atkbd_disconnect(struct serio *serio)
 {
-	struct atkbd *atkbd = serio_get_drvdata(serio);
+	struct atkbd *atkbd = atkbd_from_serio(serio);
 
 	atkbd_disable(atkbd);
 
@@ -1188,7 +1195,7 @@ static void atkbd_set_device_attrs(struct atkbd *atkbd)
 
 static void atkbd_parse_fwnode_data(struct serio *serio)
 {
-	struct atkbd *atkbd = serio_get_drvdata(serio);
+	struct atkbd *atkbd = atkbd_from_serio(serio);
 	struct device *dev = &serio->dev;
 	int n;
 
@@ -1295,7 +1302,7 @@ static int atkbd_connect(struct serio *serio, struct serio_driver *drv)
 
 static int atkbd_reconnect(struct serio *serio)
 {
-	struct atkbd *atkbd = serio_get_drvdata(serio);
+	struct atkbd *atkbd = atkbd_from_serio(serio);
 	struct serio_driver *drv = serio->drv;
 	int retval = -1;
 
@@ -1389,7 +1396,7 @@ static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
 				ssize_t (*handler)(struct atkbd *, char *))
 {
 	struct serio *serio = to_serio_port(dev);
-	struct atkbd *atkbd = serio_get_drvdata(serio);
+	struct atkbd *atkbd = atkbd_from_serio(serio);
 
 	return handler(atkbd, buf);
 }
@@ -1398,7 +1405,7 @@ static ssize_t atkbd_attr_set_helper(struct device *dev, const char *buf, size_t
 				ssize_t (*handler)(struct atkbd *, const char *, size_t))
 {
 	struct serio *serio = to_serio_port(dev);
-	struct atkbd *atkbd = serio_get_drvdata(serio);
+	struct atkbd *atkbd = atkbd_from_serio(serio);
 	int retval;
 
 	retval = mutex_lock_interruptible(&atkbd->mutex);
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index c9a7e87b273e..ed5376099fba 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -116,6 +116,13 @@ static DEFINE_MUTEX(psmouse_mutex);
 
 static struct workqueue_struct *kpsmoused_wq;
 
+struct psmouse *psmouse_from_serio(struct serio *serio)
+{
+	struct ps2dev *ps2dev = serio_get_drvdata(serio);
+
+	return container_of(ps2dev, struct psmouse, ps2dev);
+}
+
 void psmouse_report_standard_buttons(struct input_dev *dev, u8 buttons)
 {
 	input_report_key(dev, BTN_LEFT,   buttons & BIT(0));
@@ -336,7 +343,7 @@ static void psmouse_handle_oob_data(struct psmouse *psmouse, u8 data)
 static irqreturn_t psmouse_interrupt(struct serio *serio,
 				     u8 data, unsigned int flags)
 {
-	struct psmouse *psmouse = serio_get_drvdata(serio);
+	struct psmouse *psmouse = psmouse_from_serio(serio);
 
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
@@ -1344,7 +1351,7 @@ static void psmouse_resync(struct work_struct *work)
 		goto out;
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
-		parent = serio_get_drvdata(serio->parent);
+		parent = psmouse_from_serio(serio->parent);
 		psmouse_deactivate(parent);
 	}
 
@@ -1428,13 +1435,13 @@ static void psmouse_resync(struct work_struct *work)
  */
 static void psmouse_cleanup(struct serio *serio)
 {
-	struct psmouse *psmouse = serio_get_drvdata(serio);
+	struct psmouse *psmouse = psmouse_from_serio(serio);
 	struct psmouse *parent = NULL;
 
 	mutex_lock(&psmouse_mutex);
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
-		parent = serio_get_drvdata(serio->parent);
+		parent = psmouse_from_serio(serio->parent);
 		psmouse_deactivate(parent);
 	}
 
@@ -1476,7 +1483,7 @@ static void psmouse_cleanup(struct serio *serio)
  */
 static void psmouse_disconnect(struct serio *serio)
 {
-	struct psmouse *psmouse = serio_get_drvdata(serio);
+	struct psmouse *psmouse = psmouse_from_serio(serio);
 	struct psmouse *parent = NULL;
 
 	mutex_lock(&psmouse_mutex);
@@ -1489,7 +1496,7 @@ static void psmouse_disconnect(struct serio *serio)
 	mutex_lock(&psmouse_mutex);
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
-		parent = serio_get_drvdata(serio->parent);
+		parent = psmouse_from_serio(serio->parent);
 		psmouse_deactivate(parent);
 	}
 
@@ -1588,7 +1595,7 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	 * connected to this port can be successfully identified
 	 */
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
-		parent = serio_get_drvdata(serio->parent);
+		parent = psmouse_from_serio(serio->parent);
 		psmouse_deactivate(parent);
 	}
 
@@ -1604,8 +1611,6 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
-	serio_set_drvdata(serio, psmouse);
-
 	error = serio_open(serio, drv);
 	if (error)
 		goto err_clear_drvdata;
@@ -1676,7 +1681,7 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 
 static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
 {
-	struct psmouse *psmouse = serio_get_drvdata(serio);
+	struct psmouse *psmouse = psmouse_from_serio(serio);
 	struct psmouse *parent = NULL;
 	int (*reconnect_handler)(struct psmouse *);
 	enum psmouse_type type;
@@ -1695,7 +1700,7 @@ static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
 	}
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
-		parent = serio_get_drvdata(serio->parent);
+		parent = psmouse_from_serio(serio->parent);
 		psmouse_deactivate(parent);
 	}
 
@@ -1794,7 +1799,7 @@ ssize_t psmouse_attr_show_helper(struct device *dev, struct device_attribute *de
 {
 	struct serio *serio = to_serio_port(dev);
 	struct psmouse_attribute *attr = to_psmouse_attr(devattr);
-	struct psmouse *psmouse = serio_get_drvdata(serio);
+	struct psmouse *psmouse = psmouse_from_serio(serio);
 
 	if (psmouse->protocol->smbus_companion &&
 			devattr != &psmouse_attr_protocol.dattr)
@@ -1815,7 +1820,7 @@ ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *dev
 	if (retval)
 		goto out;
 
-	psmouse = serio_get_drvdata(serio);
+	psmouse = psmouse_from_serio(serio);
 
 	if (psmouse->protocol->smbus_companion &&
 			devattr != &psmouse_attr_protocol.dattr) {
@@ -1830,7 +1835,7 @@ ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *dev
 		}
 
 		if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
-			parent = serio_get_drvdata(serio->parent);
+			parent = psmouse_from_serio(serio->parent);
 			psmouse_deactivate(parent);
 		}
 
@@ -1925,7 +1930,7 @@ static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, co
 	}
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
-		parent = serio_get_drvdata(serio->parent);
+		parent = psmouse_from_serio(serio->parent);
 		if (parent->pt_deactivate)
 			parent->pt_deactivate(parent);
 	}
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 64c3a5d3fb3e..4d8acfe0d82a 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -130,6 +130,8 @@ struct psmouse {
 	void (*pt_deactivate)(struct psmouse *psmouse);
 };
 
+struct psmouse *psmouse_from_serio(struct serio *serio);
+
 void psmouse_queue_work(struct psmouse *psmouse, struct delayed_work *work,
 		unsigned long delay);
 int psmouse_reset(struct psmouse *psmouse);
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index fa021af8506e..ada299ec5bba 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -628,7 +628,7 @@ static void synaptics_set_rate(struct psmouse *psmouse, unsigned int rate)
  ****************************************************************************/
 static int synaptics_pt_write(struct serio *serio, u8 c)
 {
-	struct psmouse *parent = serio_get_drvdata(serio->parent);
+	struct psmouse *parent = psmouse_from_serio(serio->parent);
 	u8 rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
 	int error;
 
@@ -645,7 +645,7 @@ static int synaptics_pt_write(struct serio *serio, u8 c)
 
 static int synaptics_pt_start(struct serio *serio)
 {
-	struct psmouse *parent = serio_get_drvdata(serio->parent);
+	struct psmouse *parent = psmouse_from_serio(serio->parent);
 	struct synaptics_data *priv = parent->private;
 
 	serio_pause_rx(parent->ps2dev.serio);
@@ -657,7 +657,7 @@ static int synaptics_pt_start(struct serio *serio)
 
 static void synaptics_pt_stop(struct serio *serio)
 {
-	struct psmouse *parent = serio_get_drvdata(serio->parent);
+	struct psmouse *parent = psmouse_from_serio(serio->parent);
 	struct synaptics_data *priv = parent->private;
 
 	serio_pause_rx(parent->ps2dev.serio);
@@ -672,7 +672,7 @@ static int synaptics_is_pt_packet(u8 *buf)
 
 static void synaptics_pass_pt_packet(struct serio *ptport, u8 *packet)
 {
-	struct psmouse *child = serio_get_drvdata(ptport);
+	struct psmouse *child = psmouse_from_serio(ptport);
 
 	if (child && child->state == PSMOUSE_ACTIVATED) {
 		serio_interrupt(ptport, packet[1], 0);
@@ -688,7 +688,7 @@ static void synaptics_pass_pt_packet(struct serio *ptport, u8 *packet)
 static void synaptics_pt_activate(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
-	struct psmouse *child = serio_get_drvdata(priv->pt_port);
+	struct psmouse *child = psmouse_from_serio(priv->pt_port);
 
 	/* adjust the touchpad to child's choice of protocol */
 	if (child) {
diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 4a86b3e31d3b..5f6643b69a2c 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -216,7 +216,7 @@ static umode_t trackpoint_is_attr_visible(struct kobject *kobj,
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct serio *serio = to_serio_port(dev);
-	struct psmouse *psmouse = serio_get_drvdata(serio);
+	struct psmouse *psmouse = psmouse_from_serio(serio);
 
 	return trackpoint_is_attr_available(psmouse, attr) ? attr->mode : 0;
 }
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 3e19344eda93..764990723847 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -382,6 +382,7 @@ void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
 	lockdep_set_subclass(&ps2dev->cmd_mutex, serio->depth);
 	init_waitqueue_head(&ps2dev->wait);
 	ps2dev->serio = serio;
+	serio_set_drvdata(serio, ps2dev);
 }
 EXPORT_SYMBOL(ps2_init);
 
-- 
2.40.1.606.ga4b1b128d6-goog

