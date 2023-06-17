Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B997342ED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjFQSMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQSMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:12:21 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B13C173B;
        Sat, 17 Jun 2023 11:12:20 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b28eefb49cso1422773a34.0;
        Sat, 17 Jun 2023 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687025539; x=1689617539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEWKXD1JPIR01NtGjO/1uFZNTSbl7uG9HOegtq9F5wg=;
        b=UB7XnrfFZID0xVijy5FeylEcs0AEpj4ICxAHu9hlLWfdDqdGmx/VzsRnnqoUi7KaPu
         7a18RiLJjUU2IJiSkEs0xW/Natm3F2vxujLnUlF6BI2w14E4gqLNo2mHiIdEBqj9SdFZ
         NqTy73hFmpgtXZYYoxn5shn9M8QDJYEymf4q9/ZialIJ1XosiUfXcYwIW6IseOF44m8o
         agtnUeCu0MhZxu8Ir9Im38Qtlk7C/ciw1Nwo9GLjQUpQvNqg4Pp+5yc7c7DYHJAXpTKv
         olywZJ3gUPG1PsPCrJ5BpfJyGbtUJ46y8i8gMw78YXEoaoJ8+S1fABtMXv88pRwgYYbx
         HA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687025539; x=1689617539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEWKXD1JPIR01NtGjO/1uFZNTSbl7uG9HOegtq9F5wg=;
        b=MUKDiv0e9e2ptQdUpCArwkmjiRk24MTLJuQj4Y+W/CGcVFxn8w5kM2mMeHRGSrB339
         bgG7FnFtn1DhHgTjxJELCiqnV9BbIj4yS93bEU6HwyM9pA6Nviy76XczsGBj2sMTph3T
         bz0f9Vw8KkgEteau7tnUgasX8cn5edZ7fkZkpex+exhgOd/AvIrEFOkxRF7P7x3f/iVR
         W08uUmXKUBBxFHO1EsgP/ymqLCJ7NeKuuE0ikDWhnaKmutInpo8YBJNgEN6RUU/oOt2/
         7RVa4j6YqceVO0PdsLAME85F1+M+bF0Th3tGSfita6pouUID/QtFYTJSLJvMWv6fhopT
         NhhQ==
X-Gm-Message-State: AC+VfDwKeJce01ZeOG17t4JmLN+zRWQliPg0NeksFR2GU8JDihTREVy2
        JkrGI8yRrOo5O76o9vI8/UaBxLrTZEo=
X-Google-Smtp-Source: ACHHUZ6k6MyyPKusyPCfgIf6KbmmLMVoZKjcfIIcwVUHRvbtV3T0h0XDPSmtLS9I/byEZ+xJIaRLXw==
X-Received: by 2002:a05:6830:208b:b0:6b1:1f0a:80e3 with SMTP id y11-20020a056830208b00b006b11f0a80e3mr1778605otq.20.1687025539408;
        Sat, 17 Jun 2023 11:12:19 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id j24-20020a9d7698000000b006adda5cddb7sm6604927otl.62.2023.06.17.11.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 11:12:19 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (oxp-sensors) Remove unused header
Date:   Sat, 17 Jun 2023 15:11:42 -0300
Message-ID: <20230617181159.32844-2-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230617181159.32844-1-samsagax@gmail.com>
References: <20230617181159.32844-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We are not using <dev_printk.h>, remove that.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 drivers/hwmon/oxp-sensors.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index be36d38f13d9..584e48d8106e 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -16,7 +16,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/dev_printk.h>
 #include <linux/dmi.h>
 #include <linux/hwmon.h>
 #include <linux/init.h>
-- 
2.41.0

