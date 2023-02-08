Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D188668F756
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBHSpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjBHSpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:45:43 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DCE32506;
        Wed,  8 Feb 2023 10:45:41 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-15f97c478a8so24364750fac.13;
        Wed, 08 Feb 2023 10:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=90USDlrBlY0GPJBdGkLWEIUSACmBWBNicjNoZnrOozw=;
        b=LG89JMdo7J8arjljP02e18QzK1LaMec6kRYxs3qmc3FAiyHMZOTroSuOxRKccvwZvw
         /Y1jLVvEELqgID8rYO0wP2psAUVytd+0M0Jtq3IhQ2ZWIfVuCYbAY20V52PuzyyaOkfn
         1dSqwY3hPdbbUJXWxKPuEbSUmbMcpT4PrKD5mTllA/v1oCMdpbjlJxPdeA47kmZqXIW3
         MGdmeutJ/KtDwJbae1ZIgyZk0CrfzbrfnRwbbKqav+Af4t5WVhk6vOKiRkXS4F7DInc6
         UsoKyjvJPSGw6rD1EtC7ktUn6PqFqDPUQWghf76zP0T+ZNwD+ci7is0dF13yM4MbdSq7
         0kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90USDlrBlY0GPJBdGkLWEIUSACmBWBNicjNoZnrOozw=;
        b=4hpeDrqcZAdoek2CfhK8wdJObnrGUMrfj4PnOAy982w84/n8Qa3zToOpRmWyTn4mn7
         qkm6WqnOsqyaVoN6/rHx2wgX7V6+9QpCwVCmPlNPuEWB6aRKauyC3j6HEOUQX4iaWq2f
         JQ+OWUyNj37GqQKLgILXGe0or8qSmbh0lGcwKC0AamsJ1Gq76d0n4FPJ+9q4/sOCNcFV
         TktTX4TnjZovv2rejvkzy+Z6EsRfu3CqIIveSq+0gem+25qLl6dDp70uykq2xoQqmZ+D
         KATQY42Rp9vux4a85QDBLtAA74V5mVdPmGxfaudu3xtcfKO8NRUMlbqU4DQ9DWFt46dr
         tM+g==
X-Gm-Message-State: AO0yUKWDxdWN5T1EIaKNcUqVU4RmlokeJP+lfszKqtidB1VjzGLvhngl
        Zr4BhAmxEDaHRFH7CFRR+Rc=
X-Google-Smtp-Source: AK7set+ucNxAEwxwS/0P7CYdfveHNR6EFSmQlhy8+oiG6+c49qYc6PuTIfSVvb/ZYGWwl5C+8tdI9Q==
X-Received: by 2002:a05:6870:f10e:b0:163:1c65:5a2b with SMTP id k14-20020a056870f10e00b001631c655a2bmr4446443oac.26.1675881941055;
        Wed, 08 Feb 2023 10:45:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4-20020a056870618400b0014fc049fc0asm7101720oah.57.2023.02.08.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:45:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Tessler <jrt@google.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Joshua Pius <joshuapius@google.com>
Subject: [PATCH] media: cec: i2c: ch7322: Drop of_match_ptr
Date:   Wed,  8 Feb 2023 10:45:36 -0800
Message-Id: <20230208184536.3078001-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not instantiate on ACPI based systems if OF is disabled.
Fix the problem by dropping of_match_ptr.

Cc: Joshua Pius <joshuapius@google.com>
Fixes: 21b9a47e0ec7 ("media: cec: i2c: ch7322: Add ch7322 CEC controller driver")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/media/cec/i2c/ch7322.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/i2c/ch7322.c b/drivers/media/cec/i2c/ch7322.c
index 34fad7123704..3c6e6496a001 100644
--- a/drivers/media/cec/i2c/ch7322.c
+++ b/drivers/media/cec/i2c/ch7322.c
@@ -589,7 +589,7 @@ MODULE_DEVICE_TABLE(of, ch7322_of_match);
 static struct i2c_driver ch7322_i2c_driver = {
 	.driver = {
 		.name = "ch7322",
-		.of_match_table = of_match_ptr(ch7322_of_match),
+		.of_match_table = ch7322_of_match,
 	},
 	.probe_new	= ch7322_probe,
 	.remove		= ch7322_remove,
-- 
2.39.1

