Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466F6636E65
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKWXaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiKWXaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:30:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B2BA59B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:30:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so698822ejh.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wf8IS7LBLI6Ge9Fs37RfpgFpN3Ge8A2OCNRPlD/970=;
        b=l93foQ+QzVlrQDBapN9RF3gbqW247Kxoo8J5P5RJPcVKNtJgwC0QhVeOSX0jujyIe4
         bctjjb4BAiZiSPiNJNPzs8NkdgLKvImZSN6cSs9VvEfw2RTESHmrDFh9o9cB1b0dGETZ
         HJgMGobape7p2cBs3DS/7IYG0A5W+SwUC8d0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wf8IS7LBLI6Ge9Fs37RfpgFpN3Ge8A2OCNRPlD/970=;
        b=iV+6aQqC7CUrBwWj3pJT+L4mcWQlER3ip/i0frN/5Jo2LLboua9cCDEejbZUN2I2g+
         pkSA7wObMp80Olo18hbRPms/id/Ufiro2E7MISOmJlsLP9Yt/a+IrlI8QBzYPLeB+uuZ
         9ULrP7IjFpZDsBDh0VPvAF4KQKdd53ulmnB6HdKF9BR8h26YDIshd43YcENPFlTcJ505
         Fv9i02p3ppOaGw31Jzu4PJ5zkmbXx0Z9wcohR/BaypWKC60tCfupDoq0Xk2nGL2d04CL
         hUEVC5Bxg4clQ/vlUcQH+dS0BvhbwzmOMuHFdVIS+Eqi0oNoxu66I80DbnaG9ryCWb6/
         jGeA==
X-Gm-Message-State: ANoB5pnqvs2PUTiF9azJsG2RNYZPNHY6ycbhpugGlrDYoQq3mD1s0HMq
        nGbbAccafSb9rOLAksj94s8XTQ==
X-Google-Smtp-Source: AA0mqf5SytSJxUQR3KfoAWRPtq9FE09MCoY0pvPbl3/8YqyzRGxHs9zBjHdo3u/wdHQl0YRMN6eqaA==
X-Received: by 2002:a17:907:3117:b0:7ae:6746:f26b with SMTP id wl23-20020a170907311700b007ae6746f26bmr25668188ejb.171.1669246205925;
        Wed, 23 Nov 2022 15:30:05 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7db45000000b004618a89d273sm1846799edt.36.2022.11.23.15.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 15:30:05 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 00:29:55 +0100
Subject: [PATCH v1 1/1] earlycon: Let users set the clock frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221123-serial-clk-v1-1-1f0554a46ad1@chromium.org>
References: <20221123-serial-clk-v1-0-1f0554a46ad1@chromium.org>
In-Reply-To: <20221123-serial-clk-v1-0-1f0554a46ad1@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=6mOSHiJz35cRDrWtplzM0mMkwz8A8nX82zxGpMQH5RY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjfqz6Ap/T+aDU49o+LcUZYb/O0Ys3N7HDDvDx6vGu
 lyqHCSGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY36s+gAKCRDRN9E+zzrEiKPZEA
 Ci53WqX3SRzXbLV+cjGUjBumv5OknDTU1gU62g57X0KW6vY9JDLQEKNdjOqsxrg6qyJm7bmCkjQzoo
 iI0ZzWEFiATkdttsqeMDTfJcm1XEGbOew7409rUxwX0wGLlHLALW77KXcYjRwJgrYmkoA+x0POP80W
 h4hmeTJ7hHFRA/Yvi6gvpTA4lvLuLA/QVbVF1p1b+lDwUB6xEPBa/ILwnVXMx1KphKmnhwGzi4E+Nu
 yqWE7Gj39kDhxbVkMNISZdUcAPjz/b/j6zL8R5YBVi97R2gdsF2cTRTW3Y07rkMt91McBvu+6nXV8G
 V51gJsOyDRQymrCgyahPbkRIFabP6xO9n6yH/uwGqG+dTI0a6dBxBCN6GhK4nKSjobMqsbMEw0t9lV
 cJ9HBUUVqMCwiRok8o2SFHlCs2HLsFG42QOahWaW8goWgKq3oV51vtZ/d2mwcgyuDYcLs6k5zS9FKH
 Ws4Txnga1lrS9SaOEdFUGsjwm5NTvC8pSwfJYNTrvz68Mdz+LtVVtwlrzo6zxfcpIf0m1KwG2ho0Hz
 54Od0sSReNu4r8P0QC9q6sV5VHrLkpZWANT45Sh7LkH036Xsv4eRawy60J6WaXbBEj72rI2JTeP9aU
 0NCnfGY6kkOVSqbJ2o4l4HjcyMGau5PSkfqlv7BzjrbMq0SCnkoey05hOHzQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms, namely AMD Picasso, use non standard uart clocks (48M),
witch makes it impossible to use with earlycon.

Let the user select its own frequency.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774..9efb6c3b0486 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1182,10 +1182,10 @@
 			specified, the serial port must already be setup and
 			configured.
 
-		uart[8250],io,<addr>[,options]
-		uart[8250],mmio,<addr>[,options]
-		uart[8250],mmio32,<addr>[,options]
-		uart[8250],mmio32be,<addr>[,options]
+		uart[8250],io,<addr>[,options[,uartclk]]
+		uart[8250],mmio,<addr>[,options[,uartclk]]
+		uart[8250],mmio32,<addr>[,options[,uartclk]]
+		uart[8250],mmio32be,<addr>[,options[,uartclk]]
 		uart[8250],0x<addr>[,options]
 			Start an early, polled-mode console on the 8250/16550
 			UART at the specified I/O port or MMIO address.
@@ -1194,7 +1194,9 @@
 			If none of [io|mmio|mmio32|mmio32be], <addr> is assumed
 			to be equivalent to 'mmio'. 'options' are specified
 			in the same format described for "console=ttyS<n>"; if
-			unspecified, the h/w is not initialized.
+			unspecified, the h/w is not initialized. 'uartclk' is
+			the uart clock frequency; if unspecified, it is set
+			to 'BASE_BAUD' * 16.
 
 		pl011,<addr>
 		pl011,mmio32,<addr>
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a5f380584cda..094611dc7209 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -120,7 +120,11 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 	}
 
 	if (options) {
+		char *uartclk;
 		device->baud = simple_strtoul(options, NULL, 0);
+		uartclk = strchr(options, ',');
+		if (uartclk)
+			port->uartclk = simple_strtoull(uartclk + 1, NULL, 0);
 		length = min(strcspn(options, " ") + 1,
 			     (size_t)(sizeof(device->options)));
 		strscpy(device->options, options, length);
@@ -139,7 +143,8 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 		buf = NULL;
 
 	spin_lock_init(&port->lock);
-	port->uartclk = BASE_BAUD * 16;
+	if (!port->uartclk)
+		port->uartclk = BASE_BAUD * 16;
 	if (port->mapbase)
 		port->membase = earlycon_map(port->mapbase, 64);
 

-- 
b4 0.11.0-dev-d93f8
