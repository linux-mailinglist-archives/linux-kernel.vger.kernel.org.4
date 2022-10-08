Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E505F8438
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJHIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJHINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:13:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B36D37430
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:13:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l4so6407733plb.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzeF+5IYdAtiIkGd85p245F3R2qmwGRu8GIRwEUCTXk=;
        b=GJblrN5pY4z8b7Q2VdlPobg4VJsc9Jp8nrvLBXMdwdY+sBnf9C3/DuoEqPKE14Lwa3
         LXwSSLDX7zTXZ6sgbe/z+TyvLAue70yyd5LsicgN+8DhaQuUTY5guLF3m89iWBjw9ncd
         q2SpHeLKAJ/x1hycQ2LlkOjznLOPcH/HBlEoqkT8XFixfis7w/GLj2Y3Fy+zDLkKf68X
         e3tAzs+DlFYS1MQ9RLzdkjRYtV+0jdeJ9HDKc7E1W78WwqoDl52+egXVbuHPesJwtn/M
         l+1qyh6CLZ5HUEHbE/afo+sM4+QUYE/6UPhsD5bOgwO3eOXH2TYT5EbE4ahc9UvvKGDD
         9Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzeF+5IYdAtiIkGd85p245F3R2qmwGRu8GIRwEUCTXk=;
        b=fbOXZGOtXDsOkqlstLlPjo6YrkOfvspULW0T8sS8v7hR+PFPh73KLXzPIjfKi39LUp
         ln6RRO4V8GOcR7DEdC0Z4vZqjtIuOIdzI8tUTf2cEXR/A7ieXp2IpSuMkBjweP2w899K
         CMNLv3jF61lRCYO4qfHh7nEEdXb/qoU/2NdHl9SETarJsO6A19tBbA4uPfNaqcBWdZip
         SfhaloDOsTW4Tw8r4YbLlM0NiDU8+75/FMJt+m66T82DM3rHtoyP9i6wkD7lM1ZbM1CJ
         oVaaEu+MfCrYMZIipvtfNeSaIN4uJ0l8atHZlPwnMxhwpc9tQhwzitjRGkp69mbT6hgE
         pQOg==
X-Gm-Message-State: ACrzQf0LsPwPFu1BhVQBsuU0prwEQuucohX0ngHO7B9fDwBebZ6f5U3F
        B7DTbjRcR6dCrGzuJOhtL+s=
X-Google-Smtp-Source: AMsMyM4R+UrIcZXrFuFsu/anmbnCRgksYu38szDIBIaKF+Xhotgt/iZNdvm5z0FCpx6cBR//TB2QHA==
X-Received: by 2002:a17:90a:db0f:b0:20a:7294:638d with SMTP id g15-20020a17090adb0f00b0020a7294638dmr20103203pjv.228.1665216802525;
        Sat, 08 Oct 2022 01:13:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001766a3b2a26sm2783078plh.105.2022.10.08.01.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 01:13:21 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] regulator: gpio: replace !strcmp with sysfs_streq
Date:   Sat,  8 Oct 2022 08:13:17 +0000
Message-Id: <20221008081317.309193-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_streq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/regulator/gpio-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 95e61a2f43f5..9a5d6047ad81 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -211,9 +211,9 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 	config->type = REGULATOR_VOLTAGE;
 	ret = of_property_read_string(np, "regulator-type", &regtype);
 	if (ret >= 0) {
-		if (!strncmp("voltage", regtype, 7))
+		if (sysfs_streq(regtype, "voltage"))
 			config->type = REGULATOR_VOLTAGE;
-		else if (!strncmp("current", regtype, 7))
+		else if (sysfs_streq(regtype, "current"))
 			config->type = REGULATOR_CURRENT;
 		else
 			dev_warn(dev, "Unknown regulator-type '%s'\n",
-- 
2.25.1

