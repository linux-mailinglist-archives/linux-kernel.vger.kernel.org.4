Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C196E30C5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDOKo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjDOKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856169742
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94a9bbfe3ecso402178266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555402; x=1684147402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOqB6Hh2cSpiNdbIkRosOrKqQ+RZFx7UN3jJlAfn/7k=;
        b=wOIFkjp98Oot9k1oi5lJxXgNJfK/wWjEj5CW+I6Suhrx9f7FAmmZ0U+gkd2j8pjya7
         PTBfIYHP43DDauhySLvsvTyvTiE+kvoiIzO4t/wrIHW3JUVSj73EF2AKut5rUXYkkIKE
         SpLt2AQDIu7Jb4i8YvXFwYLl0G6KmevFbc3cvcQemaNDpYGIubgFUHiGnyWSEXXVjYCI
         BowNq1zRGpC8udrcx1nx31t1u0KaZcp1NQZWSU5A7kBpWec8Lv6scsczZQyH5R9ljTAv
         WhmSFQb0Z/WLwMRvj24+vJqSpYORz62lvvivOeoYgeM8iV8dfvA3fChXrrc5c7THpyCk
         A6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555402; x=1684147402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOqB6Hh2cSpiNdbIkRosOrKqQ+RZFx7UN3jJlAfn/7k=;
        b=SOk8FTCnzphmloQdYB2gwerrdHb+u4ZCF1HtGJWSCOIAuQrjXizAoEFW3RlE7EWHYf
         Z/4tMxXC1nD+WGXCAptgT8pE7DfSePpUGCCgAfLrB+WLu5JF/CHA3I1Wg1IDtUh7XZQJ
         5fWbMmDNZdFUaCDk632202Qdxs6Z8xIgXT/nFKWaDLZjqld8HHYAdahE2Vwp2kpVIfZI
         bjOhwKX0gnntvwwrGxzehTaKhy2EFiImZauYTGJWF9ejsJ/fHB9UJcvwMPyhAbd2MguZ
         XXt1UKmLwEoIYThHGQIN95BPD8YBdmueFuBIGaDuEup0n/z6yDdPB5RJ92uQJkbj7WGP
         iELQ==
X-Gm-Message-State: AAQBX9eX6JP9Qx2v1EBLyk04wGsesAwO85xMXUt+uM5LiPM14BWCf2Ys
        znLj+7h5KYpQhfF7V0AhlLmI6A==
X-Google-Smtp-Source: AKy350Ypa5Fu8Ca+HIsIdof7rvkA01OBiRVW51R7F246z8aRdNC9/gILiVEQwvADspd8tMNUIMBgfw==
X-Received: by 2002:aa7:da0d:0:b0:506:8884:7f5 with SMTP id r13-20020aa7da0d000000b00506888407f5mr2820270eds.41.1681555402312;
        Sat, 15 Apr 2023 03:43:22 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/15] w1: use octal for file permissions
Date:   Sat, 15 Apr 2023 12:42:54 +0200
Message-Id: <20230415104304.104134-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve code readability and checkpatch warnings:

  WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/ds2482.c    | 2 +-
 drivers/w1/masters/omap_hdq.c  | 2 +-
 drivers/w1/slaves/w1_ds2406.c  | 4 ++--
 drivers/w1/slaves/w1_ds2413.c  | 2 +-
 drivers/w1/slaves/w1_ds2805.c  | 2 +-
 drivers/w1/slaves/w1_ds28e17.c | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 806e352c8292..90c0a33747db 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -36,7 +36,7 @@ MODULE_PARM_DESC(active_pullup, "Active pullup (apply to all buses): " \
 
 /* extra configurations - e.g. 1WS */
 static int extra_config;
-module_param(extra_config, int, S_IRUGO | S_IWUSR);
+module_param(extra_config, int, 0644);
 MODULE_PARM_DESC(extra_config, "Extra Configuration settings 1=APU,2=PPM,3=SPU,8=1WS");
 
 /*
diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index bf2ec59c1f9d..ae3e504cd543 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -48,7 +48,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
 
 static int w1_id;
-module_param(w1_id, int, S_IRUSR);
+module_param(w1_id, int, 0400);
 MODULE_PARM_DESC(w1_id, "1-wire id for the slave detection in HDQ mode");
 
 struct hdq_data {
diff --git a/drivers/w1/slaves/w1_ds2406.c b/drivers/w1/slaves/w1_ds2406.c
index 3bb88b51fe2b..2f5926859b8b 100644
--- a/drivers/w1/slaves/w1_ds2406.c
+++ b/drivers/w1/slaves/w1_ds2406.c
@@ -99,7 +99,7 @@ static struct bin_attribute w1_f12_sysfs_bin_files[NB_SYSFS_BIN_FILES] = {
 	{
 		.attr = {
 			.name = "state",
-			.mode = S_IRUGO,
+			.mode = 0444,
 		},
 		.size = 1,
 		.read = w1_f12_read_state,
@@ -107,7 +107,7 @@ static struct bin_attribute w1_f12_sysfs_bin_files[NB_SYSFS_BIN_FILES] = {
 	{
 		.attr = {
 			.name = "output",
-			.mode = S_IRUGO | S_IWUSR | S_IWGRP,
+			.mode = 0664,
 		},
 		.size = 1,
 		.write = w1_f12_write_output,
diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index bf4a72aae28a..739009806467 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -128,7 +128,7 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 	return bytes_written;
 }
 
-static BIN_ATTR(output, S_IRUGO | S_IWUSR | S_IWGRP, NULL, output_write, 1);
+static BIN_ATTR(output, 0664, NULL, output_write, 1);
 
 static struct bin_attribute *w1_f3a_bin_attrs[] = {
 	&bin_attr_state,
diff --git a/drivers/w1/slaves/w1_ds2805.c b/drivers/w1/slaves/w1_ds2805.c
index 6b5d12ba1b65..4c1a2c515317 100644
--- a/drivers/w1/slaves/w1_ds2805.c
+++ b/drivers/w1/slaves/w1_ds2805.c
@@ -264,7 +264,7 @@ static ssize_t w1_f0d_write_bin(struct file *filp, struct kobject *kobj,
 static struct bin_attribute w1_f0d_bin_attr = {
 	.attr = {
 		.name = "eeprom",
-		.mode = S_IRUGO | S_IWUSR,
+		.mode = 0644,
 	},
 	.size = W1_F0D_EEPROM_SIZE,
 	.read = w1_f0d_read_bin,
diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index fdbaf77620ac..52261b54d842 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -31,12 +31,12 @@ MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_DS28E17));
 
 /* Default I2C speed to be set when a DS28E17 is detected. */
 static int i2c_speed = 100;
-module_param_named(speed, i2c_speed, int, (S_IRUSR | S_IWUSR));
+module_param_named(speed, i2c_speed, int, 0600);
 MODULE_PARM_DESC(speed, "Default I2C speed to be set when a DS28E17 is detected");
 
 /* Default I2C stretch value to be set when a DS28E17 is detected. */
 static char i2c_stretch = 1;
-module_param_named(stretch, i2c_stretch, byte, (S_IRUSR | S_IWUSR));
+module_param_named(stretch, i2c_stretch, byte, 0600);
 MODULE_PARM_DESC(stretch, "Default I2C stretch value to be set when a DS28E17 is detected");
 
 /* DS28E17 device command codes. */
-- 
2.34.1

