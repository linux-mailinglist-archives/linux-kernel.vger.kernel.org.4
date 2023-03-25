Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309D36C8C96
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjCYIYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjCYIYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:24:40 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADA15266
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:24:38 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id x37so2405143pga.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679732678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjcZplfqBfGxkesm/SQ2YHNMoUVOYWANADhv4EwbVKw=;
        b=iF1D1M7zPujubqAFaRoDsv44WF0fxsPh+P1yv7HPgWO600k7bQcVwJItb47E8USlzk
         pYfsPnJnn3d6sP7fi1fCK0iq6Yc9kQ3G4ypBs1DFbbEi5636oGrpjAlOqks8pTPvTYLE
         cwm3g/Z3XR8D4Feg/FzDiLb2vbZJuAs46S7RNgEyLopWutdgZN4lglRLg6GNkedsMfAR
         P7DYXcUlJTvoKnqlR28y3wH2OvWMHXidjielmmScmUrE8hFPEaH/myZ/2VH8/Aac3rHA
         wzWJBceIfhB7aMPBDqHz1kerasDENE59y8fbjamk6mxhe/41eeHSbjLcrDhSWRSVUtss
         AHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679732678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjcZplfqBfGxkesm/SQ2YHNMoUVOYWANADhv4EwbVKw=;
        b=b+oRwfCrmgBpHRLf19rKbPGu0mlLEm5XP/2REdOwSuEO27q7HwxvpLLXP/6yDRovQB
         L6SooOtqKpUBY9LuMWhe+ST9PkOhZAlA5Ny4B7jLBHD1foTQgQJC9VH0+tSAwOrg9/Xo
         52wWSy9EL5V2RY8ifJbKDEhrpo9+GRb255GDwFEYwUWn9UJ8mlYFXVWKiPtyEZYzpW5k
         fSxlGiHS9qpVb5PuofMSSgaHJAWsrGls3qv8f89SyFJkFcCFUYa1KMBbEPzhDNAPJG+Z
         lc8dKVedJefT28vFqyvAwQI7ikNN8104S6cTvzuiXz5orO7c8Z620ii/Ov0Fu1FsjxVA
         cD2g==
X-Gm-Message-State: AAQBX9e67miNRL3xgEIMYGmXXkVpEkhwEBazSXLHhvIlnsP0747j26n5
        fPDoy6FyLOD0yzGsTCcKkK8NR4kix+5YFwVG
X-Google-Smtp-Source: AKy350ZItOW1IWkO8vnKb6jMklJtdNUq0/uX+sYlMWXFYhAR5g+UBO/yaUHVPBtBrs8nlxqvT3t/ZQ==
X-Received: by 2002:aa7:954a:0:b0:625:cb74:9e01 with SMTP id w10-20020aa7954a000000b00625cb749e01mr5601184pfq.25.1679732678056;
        Sat, 25 Mar 2023 01:24:38 -0700 (PDT)
Received: from ubuntu.localdomain ([117.245.251.101])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78105000000b005938f5b7231sm15035875pfi.201.2023.03.25.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:24:37 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v3 1/3] staging: greybus: Inline gpio_chip_to_gb_gpio_controller()
Date:   Sat, 25 Mar 2023 01:23:33 -0700
Message-Id: <3fc5d84a99574ac4a76d26427ac544de375adeb4.1679732179.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679732179.git.sumitraartsy@gmail.com>
References: <cover.1679732179.git.sumitraartsy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 'gpio_chip_to_gb_gpio_controller' from a macro to a static
inline function, to make the relevant types apparent in the
definition and to benefit from the type checking performed by
the compiler at call sites.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/greybus/gpio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index d729b922a750..2a115a8fc263 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -41,8 +41,11 @@ struct gb_gpio_controller {
 	struct irq_chip		irqc;
 	struct mutex		irq_lock;
 };
-#define gpio_chip_to_gb_gpio_controller(chip) \
-	container_of(chip, struct gb_gpio_controller, chip)
+
+static inline struct gb_gpio_controller *gpio_chip_to_gb_gpio_controller(struct gpio_chip *chip)
+{
+	return container_of(chip, struct gb_gpio_controller, chip);
+}
 
 static struct gpio_chip *irq_data_to_gpio_chip(struct irq_data *d)
 {
-- 
2.25.1

