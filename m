Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BDB698782
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBOVrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBOVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:47:37 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF636472;
        Wed, 15 Feb 2023 13:47:30 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-16e2c22c3baso393144fac.8;
        Wed, 15 Feb 2023 13:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=q4BxVGyZRgRm7Y+yG+ffS0kZl38wYlTSPFaznatrum4=;
        b=YXN/JRa+0PTiE8pF+7xU4s5HnUbnIFc5i7RuwFaQiz99pnOvx0cqIlAgiLD7PDS1R1
         pqG1NZkWVqUAufZTzyb24UY4ESvWD2G0PDz56Pk/a3I9qDwRmUF/Ry1fKlspc1hWMAcO
         s5p67/yOIRKAH2SUwlr+f8azgjWTnPt44qrlxzedZ/JHqb0tpvMFnhI9jnrkjsgegzh9
         kA9RKUuGMTKqj4NQV8lLdCjXUA6oukd4W3htVTi7P/qBK6XBZkiGTcspOrzE6roJNz9k
         W5lSq6M8KTXjYbeU9bN3CoP5Q2dLtr0uJDt4bhHoHOERbDqPpn5hoGvkZHy3bTymHJMT
         DakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4BxVGyZRgRm7Y+yG+ffS0kZl38wYlTSPFaznatrum4=;
        b=H9UpNyeRxwf1gW99QkzKURZfwESlDDrq2K4y/txto3Sf8Mb+eqjo9NAAEKmtwssuPc
         Jp82fJ/QJFTj6eNtt42BCinhHkCdmp6KCR7XPRuxQWY6Gyz9dbJihteQglrluxkN7NoS
         7tA1Rg++4raS8+77oOou38ZW64jKQ96eHoNzGlzallw5yQagYaAm9Pvn/G7OAY3t4D4T
         nA+LWqjDnskj/AgozocKN+AXEq5bzVq9jFEbEUJSH9bld/IsxgRrcm2FX86ap9bpFpL0
         rr4h7jed2MEJbx8AGL0G8GMWn+aAwgaqGO1P1uBNhy99TAqr+xImN2KkSY7nw4Y/+d5C
         c+UA==
X-Gm-Message-State: AO0yUKXxWnvNewYH4A796uov0jq7uLjtH30GzZrNKM2L3GUpUOP1FVRJ
        kw2FfXbjsn9YGPLfkaoJdTgF0zcnnC4=
X-Google-Smtp-Source: AK7set+hLDBdlWtkDx+h4YNI2bTu0I+wENBpAOvA21sl4txWqywqERsCHQ61JZsrW6sgZCrb1jE9zQ==
X-Received: by 2002:a05:6870:82a8:b0:16e:23e5:5b69 with SMTP id q40-20020a05687082a800b0016e23e55b69mr2211927oae.52.1676497649000;
        Wed, 15 Feb 2023 13:47:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j17-20020a056870d45100b0016e5ad3e892sm805619oag.14.2023.02.15.13.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:47:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Tessler <jrt@google.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Joshua Pius <joshuapius@google.com>
Subject: [PATCH v2] media: cec: i2c: ch7322: Drop of_match_ptr
Date:   Wed, 15 Feb 2023 13:47:24 -0800
Message-Id: <20230215214724.3798917-1-linux@roeck-us.net>
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
Tested-by: Joshua Pius <joshuapius@google.com>
Fixes: 21b9a47e0ec7 ("media: cec: i2c: ch7322: Add ch7322 CEC controller driver")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Joshua's Tested-by: tag

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

