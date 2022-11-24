Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF326375D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKXKCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKXKCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:02:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CA71C121
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:02:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so3049258ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nO9Vy3fwrjuAAleBhHMp2gpM4FHmEXbBSGqIubhkXQ=;
        b=IYiKyuG/XZATFbUZnH36r+Oy0z+GIPoTPYSJhl1AcG/3XI8GGKbYm/CkEX7wg69WLN
         KQmtEWNDJ+7EfTvitoma90jso3B2cMp5eTGFUOZN3OHa0jsihBS1E6qcC9LZIeJL8HkD
         Pb3bUzqu5hvvKxpWsVuOku3ERM3WB82+Y6kLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nO9Vy3fwrjuAAleBhHMp2gpM4FHmEXbBSGqIubhkXQ=;
        b=xrN9zIEU+Ev2dd6ihVXOtw9w/dOnRgjLjIz4UOgyF9aksaDpl0bO2LyGTcoIKNGceU
         4u2z/cDr7lQ2wNGEfkg7ufhXQHvPquqiHFLO7dWUXEENhJJzWYd1j+VOiQfDLCViAnA6
         pXzkrp31x2WPpPBu13djLWvS2kWf0RyqkSD9dn+0/b9Gzlf0Ft5ShOkugnXyLzkrDP3v
         UXHyVOM0nqIqGregAS1XGfFAA+keekM8n/T/Sgrj0MpzhcN66NV3p0BJMJkHAzlEexI5
         l8ncJmgsecZwFMdE6Zer3nGeYp1UbONfyM6MgP2+NIhWc3vNiMxdgp4sXUbkdw6EC1Jw
         uuIw==
X-Gm-Message-State: ANoB5pneTM+D9ttTdwCCmNFnEki5LBEKBrQoAt71zIhw9Wc8f2slzz8H
        2JXQNKHkUMbmG07piLcsuvUt8Q==
X-Google-Smtp-Source: AA0mqf4JGzlWXowwkf5ea+Hqesxhryyxri4nH1A1UtNwCP+TWSGdceDIW7i8pJE3N4Rts17zbZ3qoQ==
X-Received: by 2002:a17:907:80cd:b0:7bb:35b4:777d with SMTP id io13-20020a17090780cd00b007bb35b4777dmr1875336ejc.302.1669284161929;
        Thu, 24 Nov 2022 02:02:41 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:2a85:84f4:13a1:b293])
        by smtp.gmail.com with ESMTPSA id i29-20020a50d75d000000b0046a44b2b5e6sm335548edj.32.2022.11.24.02.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:02:41 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 11:02:19 +0100
Subject: [PATCH v2 2/2] earlycon: Let users set the clock frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221123-serial-clk-v2-2-9c03ce8940d8@chromium.org>
References: <20221123-serial-clk-v2-0-9c03ce8940d8@chromium.org>
In-Reply-To: <20221123-serial-clk-v2-0-9c03ce8940d8@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=GlzxTbonDjobCDC3muIMtEy4z/d1wWcFQi0sGS7Ze3M=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjf0E4cqJyUa0NGKEMHf8aC+joQ7el/D694QZq89aQ
 2GbUHESJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY39BOAAKCRDRN9E+zzrEiGEdEA
 Ch5v0zJ+TqOsTTaZUU7j93gNYqnfSYf7UJArX7kocRTbBKo6bFkTPHjR4fyqquZCXGjZI75ziQEiM3
 f906Fnl0YiINUkMOEV1eDTg0x+w9wla37We0ngUYdiQDYV+Db1MPVdwW/B6afyhNE9DlTDCFeTVEuc
 F1E/eI8CkvNiZactTfcZ3roCljsU/8ZL+ywLFGaCqLZ+hhVYF5Bvizzda9vQ7yPcvc2JF8EGz8mzKj
 ODw3Vf5iapLOzTS3OqCdtFdkNf5anTryD2ul+saYiNYhPOAy9kQbB+zTuXMDT2M7nft0/sevTHvM/G
 rm8WtcANRFlk0REqhAXTAs1+fADq8g1FzqND4XwPAA8B37eA1LTnSJr4C999DuRYa9qVCsq4WQg+LR
 PcHdEe8rgW058ww4yYzD4VMhd9ekcmHqTgUwNam3sF1PvrSeprQ4p9AvtDw6QaVSr8A2vYewzuIXdR
 cpnLl1bh0Djy1M0IPwQ4vCJd9O0zu8COjRHCP63SCGjqRmJ500zTOwin6gOiJZ22tMedzP1gKWyQOw
 3GInPSAPzvm0R3TESW8HwSZhvXXgfZr16WPXEkf1RwtZPhFRUqlNm8rwRUWBCkXGCUxE9pr7nc9JA/
 O29slWnPzT2uTyA5behSWax26SouNwAHpOsyYv+oxv8Pc1NoKTaFbFXmISag==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 5b73da9487b1..2db92d36351b 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -120,9 +120,15 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 	}
 
 	if (options) {
+		char *uartclk;
+
 		if (kstrtouint(options, 0, &device->baud) < 0)
 			pr_warn("[%s] unsupported earlycon baud rate option\n",
 				options);
+		uartclk = strchr(options, ',');
+		if (uartclk && kstrtouint(uartclk, 0, &port->uartclk) < 0)
+			pr_warn("[%s] unsupported earlycon uart clkrate option\n",
+				options);
 		length = min(strcspn(options, " ") + 1,
 			     (size_t)(sizeof(device->options)));
 		strscpy(device->options, options, length);
@@ -141,7 +147,8 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 		buf = NULL;
 
 	spin_lock_init(&port->lock);
-	port->uartclk = BASE_BAUD * 16;
+	if (!port->uartclk)
+		port->uartclk = BASE_BAUD * 16;
 	if (port->mapbase)
 		port->membase = earlycon_map(port->mapbase, 64);
 

-- 
b4 0.11.0-dev-d93f8
