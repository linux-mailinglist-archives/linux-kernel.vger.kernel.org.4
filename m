Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6EF6FF99F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbjEKSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjEKSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:53:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E281C49FA;
        Thu, 11 May 2023 11:53:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aad5245632so64988175ad.3;
        Thu, 11 May 2023 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831187; x=1686423187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3FHdxcnZDHBJfwaP/5YmMMNOS9nBKD4If1FaL3R/o8=;
        b=ec49sEyTE5xx2tkdVvEwvcakKrHRzVcHLnXJA2iPrdp29iMdhPkl+peowh9GGhMeby
         RyzV24uF5jeUp7LYejufSY9mWDxWI0GHjGcZDvBVbRCcue5ofVy+wLNq1UX13CWUbgj6
         xycCENFG8MLMeQ3KvsZa1MTXqJ4aVnME/GvxhYpDGf0WH/ewu4zOzL+tJ27cpRX4KUCW
         Hs11e0UtOZLlNdbAEJnCWSG9dLqCpbfmtInVdZ5SzKnnIpuolJQo6YtOV3vjp3E+qtVP
         Dv0iKOx1atQtPn4E2Gz0tb5GB4u4eS4Wda3TZIOCXUJiUpxgNPO5zXlCVDeQcJWLGInE
         P5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831187; x=1686423187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3FHdxcnZDHBJfwaP/5YmMMNOS9nBKD4If1FaL3R/o8=;
        b=NEHLjq5L9RAhqBV9GBgK3vnawOkRWkI5jfyn2fCaU3CLnIDnUL2HOVF5G9WKuHmlWx
         klleMQXLycEJu4thQ0LTh7dw/wYxObLAgi6Ws9YHE6nHICOIzGyHXYU+k/RRcSdgUnX2
         31Ax8hixl6fLb/sXA0qAa8EpKhMX2crRvptOV8NP3S+Q5e4LOKE8qbxFSOJD05QkG2Oe
         BcZ40ZRiPSSQ/dLpflPvblVszY8jm8MB7VBXBm6iqM4HSiDhhaHZnN0VglHy2oW0Cmjt
         umlO8yLlFcZt1/varPiIr/RQgTaz/LXrvPbL0IrEoTxpqrFk2P0zln2A+f/5sD2+4vwR
         Vezg==
X-Gm-Message-State: AC+VfDw8kqF2AzuJCKpAdG8BjAkgU/0LhCXtcGPLvtUoxetn+fsOzKpP
        wjMYNyY1Tf7+A5tvd8wz6pQjucPxbz4=
X-Google-Smtp-Source: ACHHUZ5PFqhArb3xXxeEE0naJWLQMFeiWuCjw2lAkk4uUP+2VZdnKQwzTZbSviNJEokbv5vbMHBrqQ==
X-Received: by 2002:a17:903:44c:b0:1ab:27e7:ad76 with SMTP id iw12-20020a170903044c00b001ab27e7ad76mr21361943plb.45.1683831186628;
        Thu, 11 May 2023 11:53:06 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:84a:ed9c:4024:c347])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001a980a23804sm6288995pll.4.2023.05.11.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:53:06 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] Input: libps2 - do not discard non-ack bytes when controlling LEDs
Date:   Thu, 11 May 2023 11:52:47 -0700
Message-ID: <20230511185252.386941-8-dmitry.torokhov@gmail.com>
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

Upon receiving a PS/2 command the device and controller are supposed to
stop sending normal data (scancodes or movement packets) and instead
immediately start delivering ACK/NAK and command response. Unfortunately
often EC has an output buffer which may contain latched data by the time
the EC receives a command from the host. The kernel used to ignore such
data, but that may cause "stuck" keys if the data dropped happens to be a
break code or a part of a break code. This occasionally happens, for
example, on Chromebooks when the kernel tries to toggle CapsLock LED on
a keyboard while user releases Alt+Search keyboard shortcut.

Fix this by passing the first non-ACK byte to the normal handler for a
handful of PS/2 commands that are expected to be used during normal device
operation (as opposed to probe/configuration time).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 7c5fc853072a..6d78a1fe00c1 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -21,7 +21,10 @@
 
 #define PS2_CMD_SETSCALE11	0x00e6
 #define PS2_CMD_SETRES		0x10e8
+#define PS2_CMD_EX_SETLEDS	0x20eb
+#define PS2_CMD_SETLEDS		0x10ed
 #define PS2_CMD_GETID		0x02f2
+#define PS2_CMD_SETREP		0x10f3 /* Set repeat rate/set report rate */
 #define PS2_CMD_RESET_BAT	0x02ff
 
 #define PS2_RET_BAT		0xaa
@@ -35,6 +38,7 @@
 #define PS2_FLAG_CMD1		BIT(2)	/* Waiting for the first byte of command response */
 #define PS2_FLAG_WAITID		BIT(3)	/* Command executing is GET ID */
 #define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
+#define PS2_FLAG_PASS_NOACK	BIT(5)	/* Pass non-ACK byte to receive handler */
 
 static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte,
 			   unsigned int timeout, unsigned int max_attempts)
@@ -281,9 +285,28 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 
 	serio_pause_rx(ps2dev->serio);
 
-	/* Some mice do not ACK the "get ID" command, prepare to handle this. */
-	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
 	ps2dev->cmdcnt = receive;
+
+	switch (command) {
+	case PS2_CMD_GETID:
+		/*
+		 * Some mice do not ACK the "get ID" command, prepare to
+		 * handle this.
+		 */
+		ps2dev->flags = PS2_FLAG_WAITID;
+		break;
+
+	case PS2_CMD_SETLEDS:
+	case PS2_CMD_EX_SETLEDS:
+	case PS2_CMD_SETREP:
+		ps2dev->flags = PS2_FLAG_PASS_NOACK;
+		break;
+
+	default:
+		ps2dev->flags = 0;
+		break;
+	}
+
 	if (receive) {
 		/* Indicate that we expect response to the command. */
 		ps2dev->flags |= PS2_FLAG_CMD | PS2_FLAG_CMD1;
@@ -512,14 +535,19 @@ static void ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
 		 * Do not signal errors if we get unexpected reply while
 		 * waiting for an ACK to the initial (first) command byte:
 		 * the device might not be quiesced yet and continue
-		 * delivering data.
+		 * delivering data. For certain commands (such as set leds and
+		 * set repeat rate) that can be used during normal device
+		 * operation, we even pass this data byte to the normal receive
+		 * handler.
 		 * Note that we reset PS2_FLAG_WAITID flag, so the workaround
 		 * for mice not acknowledging the Get ID command only triggers
 		 * on the 1st byte; if device spews data we really want to see
 		 * a real ACK from it.
 		 */
 		dev_dbg(&ps2dev->serio->dev, "unexpected %#02x\n", data);
-		ps2dev->flags &= ~PS2_FLAG_WAITID;
+		if (ps2dev->flags & PS2_FLAG_PASS_NOACK)
+			ps2dev->receive_handler(ps2dev, data);
+		ps2dev->flags &= ~(PS2_FLAG_WAITID | PS2_FLAG_PASS_NOACK);
 		return;
 	}
 
-- 
2.40.1.606.ga4b1b128d6-goog

