Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDB6FF99A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjEKSxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjEKSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:53:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E212240E0;
        Thu, 11 May 2023 11:53:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so65247925ad.0;
        Thu, 11 May 2023 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831180; x=1686423180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o+RBiVTUR0DwkNdBEw9knQ1VGeDnk1pNXEP3ntY+eU=;
        b=UqOBntZpH/hTxsSnqz6tqittgDaSy8/jKh9JGoQD2vwaYlDE1I4i5F0jBM7KlIss6m
         GWh/4BzyyZnyi/Osozdzroc8kydLSG1vSH6ny+FmMdfkrQl0IFA6XiIazPxJ8ENZW8Re
         qtTUOSr4JLt8ChpKuMV9uIvLVb+SQylG9waLkaSbR2sSFUmo5GTT0KrCgaAE74e1lrr3
         SCJI4yDXl2e92y5Fe3aUx+VrOe4s93XEWxbR7nE8ikb5BhMr1wTiCCpl2cntTtDHYOxV
         0H6LFeoMC8d/vYo2eD+Q9VA4BYVRbfB2dyzTz9d/b/jLsGeY9vdJQp9calmojFD4b/O3
         Mwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831180; x=1686423180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o+RBiVTUR0DwkNdBEw9knQ1VGeDnk1pNXEP3ntY+eU=;
        b=UKsANxMu33Qt9IsMG4WyCX804QeDoHTAK6NBT9uAY562BjBonJmnvuK+9PAFuJADJf
         R+fkXZv0qvMYURE1+bbW1i5gMTrwAAJIQWK2PXogpnPFP+qbtUM6qJ5gGAlP7wLUi2Va
         owu0IL0MAGNvWV1w3E7I5gUdOg69KQG6nCwoeJp9LYc58hPBNmy6jAKjCUlH5QapqQMW
         857Gjqwal+OaFPjkHmsgd2AMztywiotD1dLoI+JyKeIpLTSsIbYhO5rqeov0DVIRrn/l
         x0sJRSJNFlAwV24UOAX4R/EWVGDvoJRdr4RRC0z/ZY6eYBpmrcIgOjLAJLY3g91kFZuA
         MrhQ==
X-Gm-Message-State: AC+VfDw/feXdTrYzsFI6ncPc2vgzNCFeL8dawjsuyMwWVg1ncNNUm466
        k3jM3X+k+JwKXodrLxfwK3xv+yUkR7M=
X-Google-Smtp-Source: ACHHUZ70yb4hK5Vbnzzkv1SlgUrq3839eTz9Wvz8+q/sIhLk6M8C93hOhcBVB75jsS89Wm45+FTPWQ==
X-Received: by 2002:a17:902:c40b:b0:1aa:fd48:f5e2 with SMTP id k11-20020a170902c40b00b001aafd48f5e2mr29678853plk.32.1683831179734;
        Thu, 11 May 2023 11:52:59 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:84a:ed9c:4024:c347])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001a980a23804sm6288995pll.4.2023.05.11.11.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:52:58 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] Input: libps2 - remove special handling of ACK for command byte
Date:   Thu, 11 May 2023 11:52:42 -0700
Message-ID: <20230511185252.386941-3-dmitry.torokhov@gmail.com>
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

When getting unexpected data while waiting for an acknowledgement it does
not matter what command phase is currently executed, and ps2_handle_ack()
should indicate that no further processing is needed for the received data
byte. Remove PS2_FLAG_ACK_CMD and associated handling.

Note that while it is possible to make ps2_handle_ack (and
ps2_handle_repsonse) return void, it will be done when the code will be
converted to common PS/2 interrupt handler later.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 9 ++-------
 include/linux/libps2.h       | 1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 764990723847..399cda0d34f5 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -253,9 +253,6 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 		for (i = 0; i < receive; i++)
 			ps2dev->cmdbuf[(receive - 1) - i] = param[i];
 
-	/* Signal that we are sending the command byte */
-	ps2dev->flags |= PS2_FLAG_ACK_CMD;
-
 	/*
 	 * Some devices (Synaptics) peform the reset before
 	 * ACKing the reset command, and so it can take a long
@@ -267,9 +264,7 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 	if (rc)
 		goto out_reset_flags;
 
-	/* Now we are sending command parameters, if any */
-	ps2dev->flags &= ~PS2_FLAG_ACK_CMD;
-
+	/* Send command parameters, if any. */
 	for (i = 0; i < send; i++) {
 		rc = ps2_do_sendbyte(ps2dev, param[i], 200, 2);
 		if (rc)
@@ -436,7 +431,7 @@ bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
 		 */
 		dev_dbg(&ps2dev->serio->dev, "unexpected %#02x\n", data);
 		ps2dev->flags &= ~PS2_FLAG_WAITID;
-		return ps2dev->flags & PS2_FLAG_ACK_CMD;
+		return true;
 	}
 
 	if (!ps2dev->nak) {
diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index 53f7e4d0f4b7..193dd53ad18b 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -28,7 +28,6 @@
 #define PS2_FLAG_CMD1		BIT(2)	/* Waiting for the first byte of command response */
 #define PS2_FLAG_WAITID		BIT(3)	/* Command executing is GET ID */
 #define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
-#define PS2_FLAG_ACK_CMD	BIT(5)	/* Waiting to ACK the command (first) byte */
 
 struct ps2dev {
 	struct serio *serio;
-- 
2.40.1.606.ga4b1b128d6-goog

