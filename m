Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4EC714E86
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjE2Qgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjE2Qe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:34:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD58B0;
        Mon, 29 May 2023 09:34:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so22898505e9.1;
        Mon, 29 May 2023 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685378094; x=1687970094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dc67GAn2fJGstQiSCO2huhEWgnflOmkWInsUSV0fyQU=;
        b=HtD8ukpkJm7ageW0ELl1AjOj0plsNq59OVhG4gSvsUopOWZMMAEX6sHSiTW3SfAK9r
         BC05rFDRldcvf+O5rSCJDV+KIGZW/Mc+1GIy4RmBXCswoW3u/sRl47JxSlfNXze17e//
         xNH2yN5lkjqgWNVqXU4evOBQoj8YgisymN4YPn1UgUqMtnccfFSk+GCvWvrk7EYsIK5I
         diegWn76BFsZRBCGCzERkczc3rT2CyrJ6Y363/mPiyV92NG7/erVpCJlm3YdwAF9AkOn
         /Fghu+OAgwdTZ/SuZCBW2dwGL9cFW7TJby2Te0RIFMaMqytFpEE09/3sEJbclh62tlT6
         5QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378094; x=1687970094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc67GAn2fJGstQiSCO2huhEWgnflOmkWInsUSV0fyQU=;
        b=KdwFK5HCjIoyv9+yENfCz4qmIJtm/cZbdkELGgZ8Xri0THB3d+cexGjA4AhKvDOKvU
         3/Sm1gBkhLCwe8B5STVh6hU0jP7KKCJVMlgY7tPN5FrSysTRT++ccELF3nurrHUZFzZf
         ua9Z9mII7E1elbaHvS8TIA5nYsSCwhCkzuiNd1U8hkS6O4w0HDQIr4SCH2qjK128GlRU
         5C6zDpVMa/js5seWDxMC9GB0XOyJ5zPCGb08doDYR4RQYe0RlcR1SXKkL5wu8MckUZ/8
         7wWmmWBwdZ+rVeEmCh1qWzlsevLNiEliDT2hsDQDF45PgcKg2ypF0MC+KqBn/X28jEia
         xhEw==
X-Gm-Message-State: AC+VfDzekLoKX/SX4d5vls8uj9IoOg/L+L7sUKGQ/SrbRJJ4OvhB3q4P
        zD+pe9bG/nTrn71IvlmyGSM=
X-Google-Smtp-Source: ACHHUZ5vIWhmzR24SFs1pnI0binXdaFcvbL+XPYCEoHFZokd79N85S56OtjbUcAuRkUyfOOVgYLcKQ==
X-Received: by 2002:a5d:4089:0:b0:306:28f4:963c with SMTP id o9-20020a5d4089000000b0030628f4963cmr9487862wrp.23.1685378093966;
        Mon, 29 May 2023 09:34:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id h14-20020a5d6e0e000000b002ff2c39d072sm417513wrz.104.2023.05.29.09.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:34:53 -0700 (PDT)
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
Subject: [net-next PATCH v4 11/13] leds: trigger: netdev: expose netdev trigger modes in linux include
Date:   Mon, 29 May 2023 18:32:41 +0200
Message-Id: <20230529163243.9555-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529163243.9555-1-ansuelsmth@gmail.com>
References: <20230529163243.9555-1-ansuelsmth@gmail.com>
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

Expose netdev trigger modes to make them accessible by LED driver that
will support netdev trigger for hw control.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/leds/trigger/ledtrig-netdev.c |  9 ---------
 include/linux/leds.h                  | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index e8bb9d0f85c0..b0a6f2749552 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -56,15 +56,6 @@ struct led_netdev_data {
 	bool hw_control;
 };
 
-enum led_trigger_netdev_modes {
-	TRIGGER_NETDEV_LINK = 0,
-	TRIGGER_NETDEV_TX,
-	TRIGGER_NETDEV_RX,
-
-	/* Keep last */
-	__TRIGGER_NETDEV_MAX,
-};
-
 static void set_baseline_state(struct led_netdev_data *trigger_data)
 {
 	int current_brightness;
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 3268b4e789d6..8af62ff431f0 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -552,6 +552,16 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 
 #endif /* CONFIG_LEDS_TRIGGERS */
 
+/* Trigger specific enum */
+enum led_trigger_netdev_modes {
+	TRIGGER_NETDEV_LINK = 0,
+	TRIGGER_NETDEV_TX,
+	TRIGGER_NETDEV_RX,
+
+	/* Keep last */
+	__TRIGGER_NETDEV_MAX,
+};
+
 /* Trigger specific functions */
 #ifdef CONFIG_LEDS_TRIGGER_DISK
 void ledtrig_disk_activity(bool write);
-- 
2.39.2

