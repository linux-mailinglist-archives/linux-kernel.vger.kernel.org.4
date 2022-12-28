Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762E865718A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiL1BIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiL1BIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:08:20 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC6E03C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:08:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w26so9813462pfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3Dq4wWbILHgSzdg9F0HvepnEYOyHWo5P75M1QcLm/s=;
        b=Fgalns0fr/AFzMRxFeH4/LwL0qZbL0snm2KwCCl2QnPyl5Kbj/+4zrKEcmy8PPTNsB
         7FbZ2XYBB4W4MucUlLZY9jZSYs202FFXLnztqFnlw75So6egAqI4XNC2nmCgHZVLhOrE
         1ffKuQRivqF0uBoREPBSAzm5QRibeBZ3I9Yt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3Dq4wWbILHgSzdg9F0HvepnEYOyHWo5P75M1QcLm/s=;
        b=bu0jkpgP0C1xlGYfUSC/xTvH9/qDwjYlumJsQPxZY7UaGmQqPcJ3gSxrAtSnM5oqUS
         TXSq5MkqWL/IlEDmY6FjAVP5rRk00ILeax7l6XXeoZGRQghwf0TbvaH4heil0gFgt/UN
         Hxe8zmlVhxZp/KjwYaTvSA66L+OEPyrn2xGtmJe8+Cm2TDh6dn8QC5GfiGEL2VlNT/2d
         uormtZiiq06RZXkJGQVbE9krhb4Ooas8nniIY4GYwYcHuhILK72GQ520rDH7IXkqZzto
         g1sVpyQa40g92YwZ6eYLxNFyXxwgFfUexgKZwPIHZjMC7rDAUO1WoNU64+ajKoeURzSC
         wQuw==
X-Gm-Message-State: AFqh2krE6/aE/Jx1lZPuip7X/8NcSNsNG6YUStmdaoa/6FyvX8N8Jom5
        bHvWDe6+JO9+MId3Xq7uXSw87z2qdp0dR8T1
X-Google-Smtp-Source: AMrXdXvprwqeO1sYyJAc2mcFG4t7ASTFUsJUdV61CCrza2i/K9kGZxDLNM1iO74sdjDDHZIEdiF7qg==
X-Received: by 2002:a62:5f43:0:b0:576:dc40:6db9 with SMTP id t64-20020a625f43000000b00576dc406db9mr24269467pfb.13.1672189699426;
        Tue, 27 Dec 2022 17:08:19 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.17.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:08:19 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH 07/10] platform/chrome: cros_ec_typec: Alter module name with hyphens
Date:   Wed, 28 Dec 2022 00:45:10 +0000
Message-Id: <20221228004648.793339-8-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221228004648.793339-1-pmalani@chromium.org>
References: <20221228004648.793339-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the Type-C module name from cros_ec_typec to cros-ec-typec. This
allows us to include more files in the same module (rather than relying
on the file name cros_ec_typec to also be the module name).

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/Kconfig  | 2 +-
 drivers/platform/chrome/Makefile | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index c1ca247987d2..5e420c27662a 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -226,7 +226,7 @@ config CROS_EC_TYPEC
 	  information from the Chrome OS EC.
 
 	  To compile this driver as a module, choose M here: the module will be
-	  called cros_ec_typec.
+	  called cros-ec-typec.
 
 config CROS_HPS_I2C
 	tristate "ChromeOS HPS device"
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index f6068d077a40..fd29fa74ba33 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -16,7 +16,8 @@ obj-$(CONFIG_CROS_TYPEC_SWITCH)		+= cros_typec_switch.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
-obj-$(CONFIG_CROS_EC_TYPEC)		+= cros_ec_typec.o
+cros-ec-typec-objs			:= cros_ec_typec.o
+obj-$(CONFIG_CROS_EC_TYPEC)		+= cros-ec-typec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
-- 
2.39.0.314.g84b9a713c41-goog

