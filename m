Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCE6FF99B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbjEKSxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbjEKSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:53:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C949FA;
        Thu, 11 May 2023 11:53:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ab0c697c84so69234255ad.3;
        Thu, 11 May 2023 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831181; x=1686423181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKXVPvgyQquk1TSIQ/OU7pvBBko0Yowmo5LV3A9+bSA=;
        b=YGArolRMbIDSSJke8TGKqCTntbcRR7Lo0Aq2TLUYrFxRcW80O8kX6d+iXPcW7ZgmH3
         a90HDabJvBrKVrd7xGL4AKttT9Xd1un9Wi+NvvSdxN1e3hqPVY+0zYGw06Kt5rjQYF5x
         TteODwJFs0qpMZ5yzX3izLpggoJ6pz5c6bjha1a3bRFlQoqEJuobpE23nr2YDjPRhXOp
         2+fKwcbFsS7QQHe7j1syiVq/6VAofn8C78hpAseTjpArAruJTgUmjWETo3rvb6jDxdfA
         MLOrITIrnuxA5QP/UEgIdEKbgZ4J0ia91cQpfgmjZASwFMhVULSmstIXU3ZebGqZnqDE
         6dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831181; x=1686423181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKXVPvgyQquk1TSIQ/OU7pvBBko0Yowmo5LV3A9+bSA=;
        b=d5FXh9FzU9fjc2JxSryJO2oYP+FTlxMjLq5oix6ZaGlFZ6ZV30Okg1aegSdDRCQScH
         vmxQTIc7nCUYYFuswmbLrZJ/hdWx9/tlCd5w5M84zxwfVIbGUwpBSGPwYblVHt+6kex0
         hoKbirkVqgNykffieH3qal7J6XEHomx7Wkck2qXfd42CLx3+gg3IdlYZESZHTf0YBfdw
         62yg/LaE7yqgx9Lg5bgXXGCv0FLJ0VDiz0i7JJCPD6PMF0DqXDUKpui/6WqzrMcbcaXX
         p9tyzXIbPKZTItQ/hHUUcUCoAZS10ljWJCQj0XokMPr8oy4sJb3l6iQY+bcM6H7URYlW
         G0WA==
X-Gm-Message-State: AC+VfDx8tdgxec8PknUrB3UQB8jCuS6GmMNdpSy8wbthv1DHzIH1XzoB
        9besB7nOgZn8n7OajkoR0hMFpstAeZk=
X-Google-Smtp-Source: ACHHUZ4iYtXDja/WYrLCsLdZdvRrKMJWXkSRRf2mDFbhxqu65bFNoZsLKcdkXTcODEYUt/FIKPHdbg==
X-Received: by 2002:a17:903:185:b0:1a9:6bd4:236a with SMTP id z5-20020a170903018500b001a96bd4236amr28122650plg.69.1683831181145;
        Thu, 11 May 2023 11:53:01 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:84a:ed9c:4024:c347])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001a980a23804sm6288995pll.4.2023.05.11.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:53:00 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] Input: libps2 - rework handling of command response
Date:   Thu, 11 May 2023 11:52:43 -0700
Message-ID: <20230511185252.386941-4-dmitry.torokhov@gmail.com>
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

It is not entirely correct that libps2 sets PS2_FLAG_CMD1 after
the device acknowledges each byte sent to the device by the host.
Rework the code so that PS2_FLAG_CMD1 and PS2_FLAG_CMD are set only once,
at the beginning of PS/2 command execution.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 399cda0d34f5..d09450eca9a7 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -247,14 +247,19 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 
 	serio_pause_rx(ps2dev->serio);
 
+	/* Some mice do not ACK the "get ID" command, prepare to handle this. */
 	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
 	ps2dev->cmdcnt = receive;
-	if (receive && param)
-		for (i = 0; i < receive; i++)
-			ps2dev->cmdbuf[(receive - 1) - i] = param[i];
+	if (receive) {
+		/* Indicate that we expect response to the command. */
+		ps2dev->flags |= PS2_FLAG_CMD | PS2_FLAG_CMD1;
+		if (param)
+			for (i = 0; i < receive; i++)
+				ps2dev->cmdbuf[(receive - 1) - i] = param[i];
+	}
 
 	/*
-	 * Some devices (Synaptics) peform the reset before
+	 * Some devices (Synaptics) perform the reset before
 	 * ACKing the reset command, and so it can take a long
 	 * time before the ACK arrives.
 	 */
@@ -434,11 +439,8 @@ bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
 		return true;
 	}
 
-	if (!ps2dev->nak) {
+	if (!ps2dev->nak)
 		ps2dev->flags &= ~PS2_FLAG_NAK;
-		if (ps2dev->cmdcnt)
-			ps2dev->flags |= PS2_FLAG_CMD | PS2_FLAG_CMD1;
-	}
 
 	ps2dev->flags &= ~PS2_FLAG_ACK;
 	wake_up(&ps2dev->wait);
-- 
2.40.1.606.ga4b1b128d6-goog

