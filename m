Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9368AA55
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 14:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjBDNq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 08:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjBDNqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:46:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B82385A;
        Sat,  4 Feb 2023 05:46:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v13so7574576eda.11;
        Sat, 04 Feb 2023 05:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4ghapI4q6dNHqD6cXMOO0iyx2zSt5s40nsfdBhe7Xo=;
        b=GdcCA2+4ALdPbJl47fleI0zNrFm2ilDwhr8DSUNPK99FrergL6PAi6MQFsg3i7lzU9
         Z3VkhPPKyYSy8Zxlg83Gs/UXrGlk+vLleH0gnrkmmOs5LHwTnArttHP7yTlPWxhr6Keu
         s94AGN/wUYNFG51F0JeakRyAFGTddsCqXp6F8EURVHeWWoCxCKSbQUGbeYYhr0EduE8r
         PJO2vt2UeLFNI2Nx0NEEjxuhZj0bcRbBsYh7mQzVXISk/sLFRta3/o8RCU72H0VdlkTx
         8i2kzrY08euuaY1N+odQu3Sc+D8WJMU/6L34cxy4/1FuyrB/DZy2IrXpm1b+jSGYh22T
         DoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4ghapI4q6dNHqD6cXMOO0iyx2zSt5s40nsfdBhe7Xo=;
        b=CggO+4eHh4uEIBXY9DZinmr+XM0fxxVGT9se/UKps01D6kOOpWEadxjz5LCaBhaAx0
         NQa9zo/dsl45zX8KQht+eaoenf06Ji7tAydKkexUv7YpWz5sbhjm4Ca6VDNEwjpvNO9B
         1nSTaVL4naKDamAgHAiyA2SHbVHnwsUg/hZGHisQVbUplDj56Rb11KrPJfZiHxt+0HAN
         OHhMQFnd7CFAYPbBsUbLoIKiMlzI+Jh6rS2tJb4/oA7KQOuuWnkidj1I3o3JSekzlrvM
         PiI73FN4Kw8Q0JJgciKzA4PTyEjAV9Kt6hFgO8dQAumb9CTDAMk5+IQLq+WuYb3wac5m
         U/LQ==
X-Gm-Message-State: AO0yUKWEC5+2sv5xvtjjjF4LNxytIdgLmLYVDNLKyyG1ZBfdy5fn016D
        KDQUAHdmF4a6hHBZRNZbBX8PMH0guOQ=
X-Google-Smtp-Source: AK7set9RYkEZF2gAT5pOqCJW8lapvfGI37PM1dMntPyLFGzOJ6Q36E5AspEKErl5e6UUjJcwMIUg7A==
X-Received: by 2002:a05:6402:2206:b0:492:bf3d:1a16 with SMTP id cq6-20020a056402220600b00492bf3d1a16mr12208655edb.4.1675518412970;
        Sat, 04 Feb 2023 05:46:52 -0800 (PST)
Received: from nam-dell (ip-80-113-101-30.ip.prioritytelecom.net. [80.113.101.30])
        by smtp.gmail.com with ESMTPSA id rl6-20020a170907216600b008775b8a5a5fsm2808510ejb.198.2023.02.04.05.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 05:46:52 -0800 (PST)
From:   Nam Cao <namcaov@gmail.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nam Cao <namcaov@gmail.com>
Subject: [PATCH] USB: serial: whiteheat: use stack instead of heap memory
Date:   Sat,  4 Feb 2023 14:46:51 +0100
Message-Id: <20230204134651.22569-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some buffers in whiteheat_attach() are small and only used locally. Move
them to the stack to avoid complications with heap memory.

Compile-tested only.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/usb/serial/whiteheat.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index 7f82d40753ee..4ad8915b536b 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -220,22 +220,16 @@ static int whiteheat_attach(struct usb_serial *serial)
 	int pipe;
 	int ret;
 	int alen;
-	__u8 *command;
-	__u8 *result;
+	__u8 command[2];
+	__u8 result[sizeof(*hw_info) + 1];
 
 	command_port = serial->port[COMMAND_PORT];
 
 	pipe = usb_sndbulkpipe(serial->dev,
 			command_port->bulk_out_endpointAddress);
-	command = kmalloc(2, GFP_KERNEL);
-	if (!command)
-		goto no_command_buffer;
+
 	command[0] = WHITEHEAT_GET_HW_INFO;
 	command[1] = 0;
-
-	result = kmalloc(sizeof(*hw_info) + 1, GFP_KERNEL);
-	if (!result)
-		goto no_result_buffer;
 	/*
 	 * When the module is reloaded the firmware is still there and
 	 * the endpoints are still in the usb core unchanged. This is the
@@ -283,7 +277,7 @@ static int whiteheat_attach(struct usb_serial *serial)
 	command_info = kmalloc(sizeof(struct whiteheat_command_private),
 								GFP_KERNEL);
 	if (!command_info)
-		goto no_command_private;
+		return -ENOMEM;
 
 	mutex_init(&command_info->mutex);
 	command_info->port_running = 0;
@@ -291,8 +285,6 @@ static int whiteheat_attach(struct usb_serial *serial)
 	usb_set_serial_port_data(command_port, command_info);
 	command_port->write_urb->complete = command_port_write_callback;
 	command_port->read_urb->complete = command_port_read_callback;
-	kfree(result);
-	kfree(command);
 
 	return 0;
 
@@ -307,16 +299,7 @@ static int whiteheat_attach(struct usb_serial *serial)
 	dev_err(&serial->dev->dev,
 		"%s: please contact support@connecttech.com\n",
 		serial->type->description);
-	kfree(result);
-	kfree(command);
 	return -ENODEV;
-
-no_command_private:
-	kfree(result);
-no_result_buffer:
-	kfree(command);
-no_command_buffer:
-	return -ENOMEM;
 }
 
 static void whiteheat_release(struct usb_serial *serial)
-- 
2.34.1

