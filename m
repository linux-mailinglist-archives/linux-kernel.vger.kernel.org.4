Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585A571346F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjE0LaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjE0L3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:29:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A34E10E;
        Sat, 27 May 2023 04:29:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f68fc6b479so17456815e9.2;
        Sat, 27 May 2023 04:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685186966; x=1687778966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t032UqrKs2qK0Tmykkb/w0e10wBacVTlNSbQa7zNqmM=;
        b=BtKLeJJ6fl8D8E5IMrP9Oxr77Zt7QurslcYfR5GljVurKTTc5GRZccpr08y8UpmThl
         nQPxCuHPMkmroDFGSw/qNAU+qYz1bJy+klGJi5JgtZ1ETqGzKVzkRD27PT7r5Eb51y18
         VT3xrNliCqVXK11joOG10TLSdMqyAXmOLslC0XWsHTDsx8FA0j2zTOicl9EVM37wBXdx
         aCuBAGkNU6gA2v83VqEEpjtW3Tt3IP/jgDRB27bMkaoaC/Gs1YjPHIrD8dDA4c/0usDr
         Bdo++hH7aVn9irKHKFtbp/R8im7SpHkb9KnpwnOd0x47R8fXofYkA2BsaTfnnq4nJ9NE
         J1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685186966; x=1687778966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t032UqrKs2qK0Tmykkb/w0e10wBacVTlNSbQa7zNqmM=;
        b=V2qAHIPDinPCz+1nSmlhD3XQXNKNy7Vdx45VspTKaCTJYXNi3U5YI/mYejmKS7sSU8
         aK3D3aVrJwfruPwbriJM8LzaiFKcebjAgrZgI5fo4jxK0fY1XMYxCghN8gCv4E7SC9Oq
         e8A8vOVw88euRK5WZ9ZHsz4YGcatslAYnmkuxX4gtVhGX62rrBbIDc65orraS+PeZvJf
         +gs2NT6npe/XAbYDCbJ50/lgmgJ7vJzWZr+jLoVInmjqC23VIhlKG+4ccRAt05fyHJTa
         lr90h0aVj5t+cIY62prlRc1VGSfLoDQf9kY5haIYntHnbo2BhoOmyiGvD5snYNOBoALk
         +GbQ==
X-Gm-Message-State: AC+VfDzics8kJqJVFQwwdUWjxmb/hqNKJ6W3PIq+GlXn7FZEKiKXTTZH
        wfwYMk3xHFn6e/swwdHoO2E=
X-Google-Smtp-Source: ACHHUZ42ImUe7BEsBhYL4fF76zPWy0NTUQC2m5IjDGbQpJKn6UtUD18UbfN/McWUMIzEQH5gAzpVdA==
X-Received: by 2002:a05:600c:2209:b0:3f6:15f:e401 with SMTP id z9-20020a05600c220900b003f6015fe401mr3869447wml.37.1685186966404;
        Sat, 27 May 2023 04:29:26 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id q13-20020a7bce8d000000b003f43f82001asm11711000wmj.31.2023.05.27.04.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 04:29:25 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-leds@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [net-next PATCH v3 10/13] leds: trigger: netdev: init mode if hw control already active
Date:   Sat, 27 May 2023 13:28:51 +0200
Message-Id: <20230527112854.2366-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230527112854.2366-1-ansuelsmth@gmail.com>
References: <20230527112854.2366-1-ansuelsmth@gmail.com>
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

On netdev trigger activation, hw control may be already active by
default. If this is the case and a device is actually provided by
hw_control_get_device(), init the already active mode and set the
bool to hw_control bool to true to reflect the already set mode in the
trigger_data.

Co-developed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 5b59441fc415..b0cab2b84ce2 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -452,6 +452,8 @@ static void netdev_trig_work(struct work_struct *work)
 static int netdev_trig_activate(struct led_classdev *led_cdev)
 {
 	struct led_netdev_data *trigger_data;
+	unsigned long mode;
+	struct device *dev;
 	int rc;
 
 	trigger_data = kzalloc(sizeof(struct led_netdev_data), GFP_KERNEL);
@@ -473,6 +475,21 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 	atomic_set(&trigger_data->interval, msecs_to_jiffies(50));
 	trigger_data->last_activity = 0;
 
+	/* Check if hw control is active by default on the LED.
+	 * Init already enabled mode in hw control.
+	 */
+	if (supports_hw_control(led_cdev) &&
+	    !led_cdev->hw_control_get(led_cdev, &mode)) {
+		dev = led_cdev->hw_control_get_device(led_cdev);
+		if (dev) {
+			const char *name = dev_name(dev);
+
+			set_device_name(trigger_data, name, strlen(name));
+			trigger_data->hw_control = true;
+			trigger_data->mode = mode;
+		}
+	}
+
 	led_set_trigger_data(led_cdev, trigger_data);
 
 	rc = register_netdevice_notifier(&trigger_data->notifier);
-- 
2.39.2

