Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB56339EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiKVKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiKVKWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:22:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F111818
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o30so10380017wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j23hZnphv0jcgZfiOY9qWXNDpMCFFj9PRM3bEUKGmc4=;
        b=fDNYsQ3j2gLDbZskMdzxyTjl8yIPfTyD01yYPRdSjW+X6zPNqK3ztySziZezPu419E
         suCJQuvywgERUuFjcEnHi4Z1QQWUyfFO4bjGUFByDMTU2ML1XaBgAmunf8cy0bjbUiW6
         daoPwkNXiRew7YerkscSIQfCA1vTfCA/zQEJYA+Gy88c/te+ILvMNZbT6x+k+h8ZXa58
         AhXsEKNQkEnyM1McFXynLRGACGVnivDCet0jtDLXhYTpNVJlBqHoZ63GGUSki5MbqFCA
         mruZWz6KtrRz2f/+SjzX2D9ZkEppU8HB1XaTcih4ryJpVJ1rEiWyU2v/OrqDDX3QhTzV
         PjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j23hZnphv0jcgZfiOY9qWXNDpMCFFj9PRM3bEUKGmc4=;
        b=YcWTIjHau2Mjo9oB97NqOOTh/2B0GRXDlUThKzLKv/4yuZK7wW+9i6IQ9Lbpt3X1R1
         osCEEx8biL/APMawGHHzg4LJgmZeNGtf9QUamPiFo0V43zOfpW1GuUrMvWo8cWHq4l/M
         /Tum0zNajEGc+2xAtrx8ryq+7u8H8LHgzaw4HxBcbdr2JQqofRbZQX83EGuv9Ux1IS6a
         gfSEvkiFsz6aw4EBX1rCLvlEE+W3wgNbwFEnh5gpVYDDpMVDgxP8IeeNda9z1JYaLMju
         Q3fq4WWzWZajmDN1FEdsGuK+F7n4M5DEfBAK2q5ukuYuocehpY+DPCVsPgdeRSMGh7WI
         ryOQ==
X-Gm-Message-State: ANoB5plNkW20CLauyUooJewrC1uBSUyDapxh02YpgVxGFNfFNa46+Bn/
        89bLpePT817KK8VZ3UOZtIB7eQ==
X-Google-Smtp-Source: AA0mqf6F5CKYp1cj3ICGkEzObFA7z8uPbsQFkopSwvQDdKVO4tzZn/XDhXCeCyEy5WVeeswdbWEjag==
X-Received: by 2002:a7b:cb98:0:b0:3cf:9a12:e645 with SMTP id m24-20020a7bcb98000000b003cf9a12e645mr8714322wmi.59.1669112512755;
        Tue, 22 Nov 2022 02:21:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:52 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 12/15] tty: serial: provide devm_uart_add_one_port()
Date:   Tue, 22 Nov 2022 11:21:22 +0100
Message-Id: <20221122102125.142075-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a devres variant of uart_add_one_port() that removes the managed
port at device detach.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../driver-api/driver-model/devres.rst        |  3 ++
 drivers/tty/serial/serial_core.c              | 36 +++++++++++++++++++
 include/linux/serial_core.h                   |  6 ++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 56082265e8e5..5d07a8c1eadb 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -436,6 +436,9 @@ RTC
 SERDEV
   devm_serdev_device_open()
 
+SERIAL
+  devm_uart_add_one_port()
+
 SLAVE DMA ENGINE
   devm_acpi_dma_controller_register()
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 179ee199df34..005190b279b3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3217,6 +3217,42 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 }
 EXPORT_SYMBOL(uart_remove_one_port);
 
+struct uart_port_devres {
+	struct uart_driver *drv;
+	struct uart_port *port;
+};
+
+static void devm_uart_remove_one_port(struct device *dev, void *data)
+{
+	struct uart_port_devres *res = data;
+
+	uart_remove_one_port(res->drv, res->port);
+}
+
+int devm_uart_add_one_port(struct device *dev,
+			   struct uart_driver *drv, struct uart_port *port)
+{
+	struct uart_port_devres *res;
+	int ret;
+
+	res = devres_alloc(devm_uart_remove_one_port, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -1;
+
+	ret = uart_add_one_port(drv, port);
+	if (ret) {
+		devres_free(res);
+		return -1;
+	}
+
+	res->drv = drv;
+	res->port = port;
+	devres_add(dev, res);
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_uart_add_one_port);
+
 /**
  * uart_match_port - are the two ports equivalent?
  * @port1: first port
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d657f2a42a7b..d0911f04706e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -771,6 +771,12 @@ int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
 bool uart_match_port(const struct uart_port *port1,
 		const struct uart_port *port2);
 
+/*
+ * UART devres
+ */
+int devm_uart_add_one_port(struct device *dev,
+			   struct uart_driver *drv, struct uart_port *port);
+
 /*
  * Power Management
  */
-- 
2.37.2

