Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF44704155
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245732AbjEOXOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245527AbjEOXOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:14:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C867DB4;
        Mon, 15 May 2023 16:14:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso7708633b3a.1;
        Mon, 15 May 2023 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684192473; x=1686784473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VaQXA0rLk0YWBwZ1wZcniUNBQ6saiJCrD4Phe/b6rLQ=;
        b=rYAFFZ2mDDmOvJST6aTRyN2HxQZM0mBgk0moG9nvGtr+ECVzRH8RBm4W34tH7qsuY4
         cGv/C1uXWIizhBh44enznbX18HcaWfCuvlHDISYeS31YJ2x0vpkgI6pcJFtyZyGbVYjQ
         5U6marh6lqChRSBVEqbIfR+1qWsTfJl73rmRRxafvwA80/F/YOMFaVpC5LhHsNIw3I8f
         z4a8RHvgfzLSSc748Ni9bZ0UhkNKOAIfUFNAMOYL8SjdUAjVizmySwqK07+bIKA+E9o9
         eEiVxJ8s4g3GHH/HM0Z7aTVdSBdUrjtFjqlG3WFdUbyEy2j6Ksi67qWF1TbWWtWIR84g
         8L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684192473; x=1686784473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaQXA0rLk0YWBwZ1wZcniUNBQ6saiJCrD4Phe/b6rLQ=;
        b=lDQirCacjkVWKbRJ+LKAIJJsu+ji3UVFnTAipx4f8FTJ6Drrsjxys4V/vEg2o3bDPC
         NhPvDhUzQD8c4fAgDXmn8P15PDMn8VgnJ8JvbreD/CDQTVbbSnnXlYI6aAGtSoEe272X
         GAKEqE/FVNn1DBEQC1gpEa4gRd6HMvTjquXawT4W/BxvkLMn0C240X1QaLNOIyNj+awP
         bUdAwLDUqfdoS2WIuV9dozXNVsLuLVvPYu4L7dxQ7OG0xMl6VYl2cPSlY1lO/0tpSr7u
         5seLQDedbWXXGo37jahrTw767FI58cpr5qSygIYZZYThG9bqAiQnGPwD940ZaHuKzqq3
         PYiw==
X-Gm-Message-State: AC+VfDxjYVwQfqWFB1lCX376UOkKLy+MyPty07ViTSAzGuJACSv3sWlr
        O4actd2kH6QAPQoJyWg8MCLSIWaP5DQ=
X-Google-Smtp-Source: ACHHUZ4Yru/Pmzkks6auozN21jJQrifP273TU40RowEf/uLl38fCPizr2g3qBP5Zbzc707QSi/k61w==
X-Received: by 2002:a05:6a00:cc8:b0:644:d220:64ac with SMTP id b8-20020a056a000cc800b00644d22064acmr46006949pfv.2.1684192473135;
        Mon, 15 May 2023 16:14:33 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6b9b:3792:cdb:652d])
        by smtp.gmail.com with ESMTPSA id j22-20020aa783d6000000b0062d7c0ccb3asm12214349pfn.103.2023.05.15.16.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 16:14:32 -0700 (PDT)
Date:   Mon, 15 May 2023 16:14:29 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] Input: libps2 - introduce common interrupt handler
Message-ID: <ZGK81cxqjr/KS1kA@google.com>
References: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
 <20230511185252.386941-7-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511185252.386941-7-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exposing inner workings of libps2 to drivers such as atkbd and
psmouse, have them define pre-receive and receive callbacks, and provide a
common handler that can be used with underlying serio port.

While at this add kerneldoc to the module.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/atkbd.c     |   81 +++++++------
 drivers/input/mouse/psmouse-base.c |   53 ++++----
 drivers/input/serio/libps2.c       |  226 ++++++++++++++++++++++++++----------
 include/linux/libps2.h             |   61 ++++++----
 4 files changed, 269 insertions(+), 152 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 2fb2ad73e796..c92e544c792d 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -399,46 +399,60 @@ static unsigned int atkbd_compat_scancode(struct atkbd *atkbd, unsigned int code
 }
 
 /*
- * atkbd_interrupt(). Here takes place processing of data received from
- * the keyboard into events.
+ * Tries to handle frame or parity error by requesting the keyboard controller
+ * to resend the last byte. This historically not done on x86 as controllers
+ * there typically do not implement this command.
  */
-
-static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
-				   unsigned int flags)
+static bool __maybe_unused atkbd_handle_frame_error(struct ps2dev *ps2dev,
+						    u8 data, unsigned int flags)
 {
-	struct atkbd *atkbd = atkbd_from_serio(serio);
-	struct input_dev *dev = atkbd->dev;
-	unsigned int code = data;
-	int scroll = 0, hscroll = 0, click = -1;
-	int value;
-	unsigned short keycode;
+	struct atkbd *atkbd = container_of(ps2dev, struct atkbd, ps2dev);
+	struct serio *serio = ps2dev->serio;
 
-	dev_dbg(&serio->dev, "Received %02x flags %02x\n", data, flags);
-
-#if !defined(__i386__) && !defined (__x86_64__)
-	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && !atkbd->resend && atkbd->write) {
+	if ((flags & (SERIO_FRAME | SERIO_PARITY)) &&
+	    (~flags & SERIO_TIMEOUT) &&
+	    !atkbd->resend && atkbd->write) {
 		dev_warn(&serio->dev, "Frame/parity error: %02x\n", flags);
 		serio_write(serio, ATKBD_CMD_RESEND);
 		atkbd->resend = true;
-		goto out;
+		return true;
 	}
 
 	if (!flags && data == ATKBD_RET_ACK)
 		atkbd->resend = false;
+
+	return false;
+}
+
+static enum ps2_disposition atkbd_pre_receive_byte(struct ps2dev *ps2dev,
+						   u8 data, unsigned int flags)
+{
+	struct serio *serio = ps2dev->serio;
+
+	dev_dbg(&serio->dev, "Received %02x flags %02x\n", data, flags);
+
+#if !defined(__i386__) && !defined (__x86_64__)
+	if (atkbd_handle_frame_error(ps2dev, data, flags))
+		return PS2_IGNORE;
 #endif
 
-	if (unlikely(atkbd->ps2dev.flags & PS2_FLAG_ACK))
-		if  (ps2_handle_ack(&atkbd->ps2dev, data))
-			goto out;
+	return PS2_PROCESS;
+}
 
-	if (unlikely(atkbd->ps2dev.flags & PS2_FLAG_CMD))
-		if  (ps2_handle_response(&atkbd->ps2dev, data))
-			goto out;
+static void atkbd_receive_byte(struct ps2dev *ps2dev, u8 data)
+{
+	struct serio *serio = ps2dev->serio;
+	struct atkbd *atkbd = container_of(ps2dev, struct atkbd, ps2dev);
+	struct input_dev *dev = atkbd->dev;
+	unsigned int code = data;
+	int scroll = 0, hscroll = 0, click = -1;
+	int value;
+	unsigned short keycode;
 
 	pm_wakeup_event(&serio->dev, 0);
 
 	if (!atkbd->enabled)
-		goto out;
+		return;
 
 	input_event(dev, EV_MSC, MSC_RAW, code);
 
@@ -460,16 +474,16 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 	case ATKBD_RET_BAT:
 		atkbd->enabled = false;
 		serio_reconnect(atkbd->ps2dev.serio);
-		goto out;
+		return;
 	case ATKBD_RET_EMUL0:
 		atkbd->emul = 1;
-		goto out;
+		return;
 	case ATKBD_RET_EMUL1:
 		atkbd->emul = 2;
-		goto out;
+		return;
 	case ATKBD_RET_RELEASE:
 		atkbd->release = true;
-		goto out;
+		return;
 	case ATKBD_RET_ACK:
 	case ATKBD_RET_NAK:
 		if (printk_ratelimit())
@@ -477,18 +491,18 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 				 "Spurious %s on %s. "
 				 "Some program might be trying to access hardware directly.\n",
 				 data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
-		goto out;
+		return;
 	case ATKBD_RET_ERR:
 		atkbd->err_count++;
 		dev_dbg(&serio->dev, "Keyboard on %s reports too many keys pressed.\n",
 			serio->phys);
-		goto out;
+		return;
 	}
 
 	code = atkbd_compat_scancode(atkbd, code);
 
 	if (atkbd->emul && --atkbd->emul)
-		goto out;
+		return;
 
 	keycode = atkbd->keycode[code];
 
@@ -564,8 +578,6 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 	}
 
 	atkbd->release = false;
-out:
-	return IRQ_HANDLED;
 }
 
 static int atkbd_set_repeat_rate(struct atkbd *atkbd)
@@ -1229,7 +1241,8 @@ static int atkbd_connect(struct serio *serio, struct serio_driver *drv)
 		goto fail1;
 
 	atkbd->dev = dev;
-	ps2_init(&atkbd->ps2dev, serio);
+	ps2_init(&atkbd->ps2dev, serio,
+		 atkbd_pre_receive_byte, atkbd_receive_byte);
 	INIT_DELAYED_WORK(&atkbd->event_work, atkbd_event_work);
 	mutex_init(&atkbd->mutex);
 
@@ -1385,7 +1398,7 @@ static struct serio_driver atkbd_drv = {
 	},
 	.description	= DRIVER_DESC,
 	.id_table	= atkbd_serio_ids,
-	.interrupt	= atkbd_interrupt,
+	.interrupt	= ps2_interrupt,
 	.connect	= atkbd_connect,
 	.reconnect	= atkbd_reconnect,
 	.disconnect	= atkbd_disconnect,
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index ed5376099fba..a0aac76b1e41 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -336,17 +336,14 @@ static void psmouse_handle_oob_data(struct psmouse *psmouse, u8 data)
 	}
 }
 
-/*
- * psmouse_interrupt() handles incoming characters, either passing them
- * for normal processing or gathering them as command response.
- */
-static irqreturn_t psmouse_interrupt(struct serio *serio,
-				     u8 data, unsigned int flags)
+static enum ps2_disposition psmouse_pre_receive_byte(struct ps2dev *ps2dev,
+						     u8 data,
+						     unsigned int flags)
 {
-	struct psmouse *psmouse = psmouse_from_serio(serio);
+	struct psmouse *psmouse = container_of(ps2dev, struct psmouse, ps2dev);
 
 	if (psmouse->state == PSMOUSE_IGNORE)
-		goto out;
+		return PS2_IGNORE;
 
 	if (unlikely((flags & SERIO_TIMEOUT) ||
 		     ((flags & SERIO_PARITY) &&
@@ -357,27 +354,25 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 				     "bad data from KBC -%s%s\n",
 				     flags & SERIO_TIMEOUT ? " timeout" : "",
 				     flags & SERIO_PARITY ? " bad parity" : "");
-		ps2_cmd_aborted(&psmouse->ps2dev);
-		goto out;
+		return PS2_ERROR;
 	}
 
 	if (flags & SERIO_OOB_DATA) {
 		psmouse_handle_oob_data(psmouse, data);
-		goto out;
+		return PS2_IGNORE;
 	}
 
-	if (unlikely(psmouse->ps2dev.flags & PS2_FLAG_ACK))
-		if  (ps2_handle_ack(&psmouse->ps2dev, data))
-			goto out;
+	return PS2_PROCESS;
+}
 
-	if (unlikely(psmouse->ps2dev.flags & PS2_FLAG_CMD))
-		if  (ps2_handle_response(&psmouse->ps2dev, data))
-			goto out;
+static void psmouse_receive_byte(struct ps2dev *ps2dev, u8 data)
+{
+	struct psmouse *psmouse = container_of(ps2dev, struct psmouse, ps2dev);
 
-	pm_wakeup_event(&serio->dev, 0);
+	pm_wakeup_event(&ps2dev->serio->dev, 0);
 
 	if (psmouse->state <= PSMOUSE_RESYNCING)
-		goto out;
+		return;
 
 	if (psmouse->state == PSMOUSE_ACTIVATED &&
 	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
@@ -386,7 +381,7 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		psmouse->badbyte = psmouse->packet[0];
 		__psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
 		psmouse_queue_work(psmouse, &psmouse->resync_work, 0);
-		goto out;
+		return;
 	}
 
 	psmouse->packet[psmouse->pktcnt++] = data;
@@ -395,21 +390,21 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 	if (unlikely(psmouse->packet[0] == PSMOUSE_RET_BAT && psmouse->pktcnt <= 2)) {
 		if (psmouse->pktcnt == 1) {
 			psmouse->last = jiffies;
-			goto out;
+			return;
 		}
 
 		if (psmouse->packet[1] == PSMOUSE_RET_ID ||
 		    (psmouse->protocol->type == PSMOUSE_HGPK &&
 		     psmouse->packet[1] == PSMOUSE_RET_BAT)) {
 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
-			serio_reconnect(serio);
-			goto out;
+			serio_reconnect(ps2dev->serio);
+			return;
 		}
 
 		/* Not a new device, try processing first byte normally */
 		psmouse->pktcnt = 1;
 		if (psmouse_handle_byte(psmouse))
-			goto out;
+			return;
 
 		psmouse->packet[psmouse->pktcnt++] = data;
 	}
@@ -424,14 +419,11 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		psmouse->badbyte = psmouse->packet[0];
 		__psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
 		psmouse_queue_work(psmouse, &psmouse->resync_work, 0);
-		goto out;
+		return;
 	}
 
 	psmouse->last = jiffies;
 	psmouse_handle_byte(psmouse);
-
- out:
-	return IRQ_HANDLED;
 }
 
 /*
@@ -1604,7 +1596,8 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	if (!psmouse || !input_dev)
 		goto err_free;
 
-	ps2_init(&psmouse->ps2dev, serio);
+	ps2_init(&psmouse->ps2dev, serio,
+		 psmouse_pre_receive_byte, psmouse_receive_byte);
 	INIT_DELAYED_WORK(&psmouse->resync_work, psmouse_resync);
 	psmouse->dev = input_dev;
 	snprintf(psmouse->phys, sizeof(psmouse->phys), "%s/input0", serio->phys);
@@ -1786,7 +1779,7 @@ static struct serio_driver psmouse_drv = {
 	},
 	.description	= DRIVER_DESC,
 	.id_table	= psmouse_serio_ids,
-	.interrupt	= psmouse_interrupt,
+	.interrupt	= ps2_interrupt,
 	.connect	= psmouse_connect,
 	.reconnect	= psmouse_reconnect,
 	.fast_reconnect	= psmouse_fast_reconnect,
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 09eb605364bb..7c5fc853072a 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -19,9 +19,22 @@
 
 #define DRIVER_DESC	"PS/2 driver library"
 
-MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
-MODULE_DESCRIPTION("PS/2 driver library");
-MODULE_LICENSE("GPL");
+#define PS2_CMD_SETSCALE11	0x00e6
+#define PS2_CMD_SETRES		0x10e8
+#define PS2_CMD_GETID		0x02f2
+#define PS2_CMD_RESET_BAT	0x02ff
+
+#define PS2_RET_BAT		0xaa
+#define PS2_RET_ID		0x00
+#define PS2_RET_ACK		0xfa
+#define PS2_RET_NAK		0xfe
+#define PS2_RET_ERR		0xfc
+
+#define PS2_FLAG_ACK		BIT(0)	/* Waiting for ACK/NAK */
+#define PS2_FLAG_CMD		BIT(1)	/* Waiting for a command to finish */
+#define PS2_FLAG_CMD1		BIT(2)	/* Waiting for the first byte of command response */
+#define PS2_FLAG_WAITID		BIT(3)	/* Command executing is GET ID */
+#define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
 
 static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte,
 			   unsigned int timeout, unsigned int max_attempts)
@@ -76,14 +89,17 @@ static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte,
 	return error;
 }
 
-/*
- * ps2_sendbyte() sends a byte to the device and waits for acknowledge.
- * It doesn't handle retransmission, the caller is expected to handle
+/**
+ * ps2_sendbyte - sends a byte to the device and wait for acknowledgement
+ * @ps2dev: a PS/2 device to send the data to
+ * @byte: data to be sent to the device
+ * @timeout: timeout for sending the data and receiving an acknowledge
+ *
+ * The function doesn't handle retransmission, the caller is expected to handle
  * it when needed.
  *
  * ps2_sendbyte() can only be called from a process context.
  */
-
 int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
 {
 	int retval;
@@ -99,6 +115,13 @@ int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
 }
 EXPORT_SYMBOL(ps2_sendbyte);
 
+/**
+ * ps2_begin_command - mark beginning of execution of a complex command
+ * @ps2dev: a PS/2 device executing the command
+ *
+ * Serializes a complex/compound command. Once command is finished
+ * ps2_end_command() should be called.
+ */
 void ps2_begin_command(struct ps2dev *ps2dev)
 {
 	struct mutex *m = ps2dev->serio->ps2_cmd_mutex ?: &ps2dev->cmd_mutex;
@@ -107,6 +130,10 @@ void ps2_begin_command(struct ps2dev *ps2dev)
 }
 EXPORT_SYMBOL(ps2_begin_command);
 
+/**
+ * ps2_end_command - mark end of execution of a complex command
+ * @ps2dev: a PS/2 device executing the command
+ */
 void ps2_end_command(struct ps2dev *ps2dev)
 {
 	struct mutex *m = ps2dev->serio->ps2_cmd_mutex ?: &ps2dev->cmd_mutex;
@@ -115,11 +142,13 @@ void ps2_end_command(struct ps2dev *ps2dev)
 }
 EXPORT_SYMBOL(ps2_end_command);
 
-/*
- * ps2_drain() waits for device to transmit requested number of bytes
- * and discards them.
+/**
+ * ps2_drain - waits for device to transmit requested number of bytes
+ * and discards them
+ * @ps2dev: the PS/2 device that should be drained
+ * @maxbytes: maximum number of bytes to be drained
+ * @timeout: time to drain the device
  */
-
 void ps2_drain(struct ps2dev *ps2dev, size_t maxbytes, unsigned int timeout)
 {
 	if (maxbytes > sizeof(ps2dev->cmdbuf)) {
@@ -142,11 +171,11 @@ void ps2_drain(struct ps2dev *ps2dev, size_t maxbytes, unsigned int timeout)
 }
 EXPORT_SYMBOL(ps2_drain);
 
-/*
- * ps2_is_keyboard_id() checks received ID byte against the list of
- * known keyboard IDs.
+/**
+ * ps2_is_keyboard_id - checks received ID byte against the list of
+ *   known keyboard IDs
+ * @id_byte: data byte that should be checked
  */
-
 bool ps2_is_keyboard_id(u8 id_byte)
 {
 	static const u8 keyboard_ids[] = {
@@ -167,7 +196,6 @@ EXPORT_SYMBOL(ps2_is_keyboard_id);
  * response and tries to reduce remaining timeout to speed up command
  * completion.
  */
-
 static int ps2_adjust_timeout(struct ps2dev *ps2dev,
 			      unsigned int command, unsigned int timeout)
 {
@@ -217,13 +245,19 @@ static int ps2_adjust_timeout(struct ps2dev *ps2dev,
 	return timeout;
 }
 
-/*
- * ps2_command() sends a command and its parameters to the mouse,
- * then waits for the response and puts it in the param array.
+/**
+ * __ps2_command - send a command to PS/2 device
+ * @ps2dev: the PS/2 device that should execute the command
+ * @param: a buffer containing parameters to be sent along with the command,
+ *   or place where the results of the command execution will be deposited,
+ *   or both
+ * @command: command word that encodes the command itself, as well as number of
+ *   additional parameter bytes that should be sent to the device and expected
+ *   length of the command response
  *
- * ps2_command() can only be called from a process context
+ * Not serialized. Callers should use ps2_begin_command() and ps2_end_command()
+ * to ensure proper serialization for complex commands.
  */
-
 int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 {
 	unsigned int timeout;
@@ -327,6 +361,20 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 }
 EXPORT_SYMBOL(__ps2_command);
 
+/**
+ * ps2_command - send a command to PS/2 device
+ * @ps2dev: the PS/2 device that should execute the command
+ * @param: a buffer containing parameters to be sent along with the command,
+ *   or place where the results of the command execution will be deposited,
+ *   or both
+ * @command: command word that encodes the command itself, as well as number of
+ *   additional parameter bytes that should be sent to the device and expected
+ *   length of the command response
+ *
+ * Note: ps2_command() serializes the command execution so that only one
+ * command can be executed at a time for either individual port or the entire
+ * 8042 controller.
+ */
 int ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 {
 	int rc;
@@ -339,14 +387,16 @@ int ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 }
 EXPORT_SYMBOL(ps2_command);
 
-/*
- * ps2_sliced_command() sends an extended PS/2 command to the mouse
- * using sliced syntax, understood by advanced devices, such as Logitech
- * or Synaptics touchpads. The command is encoded as:
+/**
+ * ps2_sliced_command - sends an extended PS/2 command to a mouse
+ * @ps2dev: the PS/2 device that should execute the command
+ * @command: command byte
+ *
+ * The command is sent using "sliced" syntax understood by advanced devices,
+ * such as Logitech or Synaptics touchpads. The command is encoded as:
  * 0xE6 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+(tt*4)+uu
  * is the command.
  */
-
 int ps2_sliced_command(struct ps2dev *ps2dev, u8 command)
 {
 	int i;
@@ -372,12 +422,22 @@ int ps2_sliced_command(struct ps2dev *ps2dev, u8 command)
 }
 EXPORT_SYMBOL(ps2_sliced_command);
 
-/*
- * ps2_init() initializes ps2dev structure
+/**
+ * ps2_init - initializes ps2dev structure
+ * @ps2dev: structure to be initialized
+ * @serio: serio port associated with the PS/2 device
+ * @pre_receive_handler: validation handler to check basic communication state
+ * @receive_handler: main protocol handler
+ *
+ * Prepares ps2dev structure for use in drivers for PS/2 devices.
  */
-
-void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
+void ps2_init(struct ps2dev *ps2dev, struct serio *serio,
+	      ps2_pre_receive_handler_t pre_receive_handler,
+	      ps2_receive_handler_t receive_handler)
 {
+	ps2dev->pre_receive_handler = pre_receive_handler;
+	ps2dev->receive_handler = receive_handler;
+
 	mutex_init(&ps2dev->cmd_mutex);
 	lockdep_set_subclass(&ps2dev->cmd_mutex, serio->depth);
 	init_waitqueue_head(&ps2dev->wait);
@@ -387,11 +447,35 @@ void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
 EXPORT_SYMBOL(ps2_init);
 
 /*
- * ps2_handle_ack() is supposed to be used in interrupt handler
- * to properly process ACK/NAK of a command from a PS/2 device.
+ * ps2_handle_response() stores device's response to a command and notifies
+ * the process waiting for completion of the command. Note that there is a
+ * distinction between waiting for the first byte of the response, and
+ * waiting for subsequent bytes. It is done so that callers could shorten
+ * timeouts once first byte of response is received.
  */
+static void ps2_handle_response(struct ps2dev *ps2dev, u8 data)
+{
+	if (ps2dev->cmdcnt)
+		ps2dev->cmdbuf[--ps2dev->cmdcnt] = data;
 
-bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
+	if (ps2dev->flags & PS2_FLAG_CMD1) {
+		ps2dev->flags &= ~PS2_FLAG_CMD1;
+		if (ps2dev->cmdcnt)
+			wake_up(&ps2dev->wait);
+	}
+
+	if (!ps2dev->cmdcnt) {
+		ps2dev->flags &= ~PS2_FLAG_CMD;
+		wake_up(&ps2dev->wait);
+	}
+}
+
+/*
+ * ps2_handle_ack() processes ACK/NAK of a command from a PS/2 device,
+ * possibly applying workarounds for mice not acknowledging the "get ID"
+ * command.
+ */
+static void ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
 {
 	switch (data) {
 	case PS2_RET_ACK:
@@ -436,53 +520,25 @@ bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
 		 */
 		dev_dbg(&ps2dev->serio->dev, "unexpected %#02x\n", data);
 		ps2dev->flags &= ~PS2_FLAG_WAITID;
-		return true;
+		return;
 	}
 
 	if (!ps2dev->nak)
 		ps2dev->flags &= ~PS2_FLAG_NAK;
 
 	ps2dev->flags &= ~PS2_FLAG_ACK;
-	wake_up(&ps2dev->wait);
 
 	if (!ps2dev->nak && data != PS2_RET_ACK)
 		ps2_handle_response(ps2dev, data);
-
-	return true;
-}
-EXPORT_SYMBOL(ps2_handle_ack);
-
-/*
- * ps2_handle_response() is supposed to be used in interrupt handler
- * to properly store device's response to a command and notify process
- * waiting for completion of the command.
- */
-
-bool ps2_handle_response(struct ps2dev *ps2dev, u8 data)
-{
-	if (ps2dev->cmdcnt)
-		ps2dev->cmdbuf[--ps2dev->cmdcnt] = data;
-
-	if (ps2dev->flags & PS2_FLAG_CMD1) {
-		ps2dev->flags &= ~PS2_FLAG_CMD1;
-		if (ps2dev->cmdcnt)
-			wake_up(&ps2dev->wait);
-	}
-
-	if (!ps2dev->cmdcnt) {
-		ps2dev->flags &= ~PS2_FLAG_CMD;
+	else
 		wake_up(&ps2dev->wait);
-	}
-
-	return true;
 }
-EXPORT_SYMBOL(ps2_handle_response);
 
 /*
  * Clears state of PS/2 device after communication error by resetting majority
  * of flags and waking up waiters, if any.
  */
-void ps2_cmd_aborted(struct ps2dev *ps2dev)
+static void ps2_cleanup(struct ps2dev *ps2dev)
 {
 	unsigned long old_flags = ps2dev->flags;
 
@@ -494,6 +550,46 @@ void ps2_cmd_aborted(struct ps2dev *ps2dev)
 
 	if (old_flags & (PS2_FLAG_ACK | PS2_FLAG_CMD))
 		wake_up(&ps2dev->wait);
+}
 
+/**
+ * ps2_interrupt - common interrupt handler for PS/2 devices
+ * @serio: serio port for the device
+ * @data: a data byte received from the device
+ * @flags: flags such as %SERIO_PARITY or %SERIO_TIMEOUT indicating state of
+ *   the data transfer
+ *
+ * ps2_interrupt() invokes pre-receive handler, optionally handles command
+ * acknowledgement and response from the device, and finally passes the data
+ * to the main protocol handler for future processing.
+ */
+irqreturn_t ps2_interrupt(struct serio *serio, u8 data, unsigned int flags) {
+	struct ps2dev *ps2dev = serio_get_drvdata(serio);
+	enum ps2_disposition rc;
+
+	rc = ps2dev->pre_receive_handler(ps2dev, data, flags);
+	switch (rc) {
+	case PS2_ERROR:
+		ps2_cleanup(ps2dev);
+		break;
+
+	case PS2_IGNORE:
+		break;
+
+	case PS2_PROCESS:
+		if (ps2dev->flags & PS2_FLAG_ACK)
+			ps2_handle_ack(ps2dev, data);
+		else if (ps2dev->flags & PS2_FLAG_CMD)
+			ps2_handle_response(ps2dev, data);
+		else
+			ps2dev->receive_handler(ps2dev, data);
+		break;
+	}
+
+	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL(ps2_cmd_aborted);
+EXPORT_SYMBOL(ps2_interrupt);
+
+MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
+MODULE_DESCRIPTION("PS/2 driver library");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index 193dd53ad18b..9ca9ce4e6e64 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -8,43 +8,59 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
-#define PS2_CMD_SETSCALE11	0x00e6
-#define PS2_CMD_SETRES		0x10e8
-#define PS2_CMD_GETID		0x02f2
-#define PS2_CMD_RESET_BAT	0x02ff
+struct ps2dev;
 
-#define PS2_RET_BAT		0xaa
-#define PS2_RET_ID		0x00
-#define PS2_RET_ACK		0xfa
-#define PS2_RET_NAK		0xfe
-#define PS2_RET_ERR		0xfc
+/**
+ * enum ps2_disposition - indicates how received byte should be handled
+ * @PS2_PROCESS: pass to the main protocol handler, process normally
+ * @PS2_IGNORE: skip the byte
+ * @PS2_ERROR: do not process the byte, abort command in progress
+ */
+enum ps2_disposition {
+	PS2_PROCESS,
+	PS2_IGNORE,
+	PS2_ERROR,
+};
 
-#define PS2_FLAG_ACK		BIT(0)	/* Waiting for ACK/NAK */
-#define PS2_FLAG_CMD		BIT(1)	/* Waiting for a command to finish */
-#define PS2_FLAG_CMD1		BIT(2)	/* Waiting for the first byte of command response */
-#define PS2_FLAG_WAITID		BIT(3)	/* Command executing is GET ID */
-#define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
+typedef enum ps2_disposition (*ps2_pre_receive_handler_t)(struct ps2dev *, u8,
+							  unsigned int);
+typedef void (*ps2_receive_handler_t)(struct ps2dev *, u8);
 
+/**
+ * struct ps2dev - represents a device using PS/2 protocol
+ * @serio: a serio port used by the PS/2 device
+ * @cmd_mutex: a mutex ensuring that only one command is executing at a time
+ * @wait: a waitqueue used to signal completion from the serio interrupt handler
+ * @flags: various internal flags indicating stages of PS/2 command execution
+ * @cmdbuf: buffer holding command response
+ * @cmdcnt: outstanding number of bytes of the command response
+ * @nak: a byte transmitted by the device when it refuses command
+ * @pre_receive_handler: checks communication errors and returns disposition
+ * (&enum ps2_disposition) of the received data byte
+ * @receive_handler: main handler of particular PS/2 protocol, such as keyboard
+ *   or mouse protocol
+ */
 struct ps2dev {
 	struct serio *serio;
-
-	/* Ensures that only one command is executing at a time */
 	struct mutex cmd_mutex;
-
-	/* Used to signal completion from interrupt handler */
 	wait_queue_head_t wait;
-
 	unsigned long flags;
 	u8 cmdbuf[8];
 	u8 cmdcnt;
 	u8 nak;
+
+	ps2_pre_receive_handler_t pre_receive_handler;
+	ps2_receive_handler_t receive_handler;
 };
 
-void ps2_init(struct ps2dev *ps2dev, struct serio *serio);
+void ps2_init(struct ps2dev *ps2dev, struct serio *serio,
+	      ps2_pre_receive_handler_t pre_receive_handler,
+	      ps2_receive_handler_t receive_handler);
 int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout);
 void ps2_drain(struct ps2dev *ps2dev, size_t maxbytes, unsigned int timeout);
 void ps2_begin_command(struct ps2dev *ps2dev);
@@ -52,9 +68,8 @@ void ps2_end_command(struct ps2dev *ps2dev);
 int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command);
 int ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command);
 int ps2_sliced_command(struct ps2dev *ps2dev, u8 command);
-bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data);
-bool ps2_handle_response(struct ps2dev *ps2dev, u8 data);
-void ps2_cmd_aborted(struct ps2dev *ps2dev);
 bool ps2_is_keyboard_id(u8 id);
 
+irqreturn_t ps2_interrupt(struct serio *serio, u8 data, unsigned int flags);
+
 #endif /* _LIBPS2_H */
