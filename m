Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B76A7DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCBJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBJdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:33:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B0E136DA;
        Thu,  2 Mar 2023 01:33:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso1245620wmq.1;
        Thu, 02 Mar 2023 01:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6BKNBSKm9t8Xuk4biCqYB1X+wCBstZhM2x0v8XkGJ4U=;
        b=LFmeeFCF7HlGzyTsP+aW8C9CCbhrMohr+Hssz7h98pJtr8gsvl3oFwmS8nOXTuaznK
         P3Rh7AczW3tAIIEB2LtHhTg7onMalD50/m3L/UIn1LlwaumkqNG+Zm7baD+pRA8g4y7g
         9x0+UUBFkFK8b0BcUYX7T5rovO7+9tlnRJNQwCjDeDoqHjGf0+xTXRmHBz5ogl0UpLLP
         1lGXwMuJvFqy/i47sRaYMYD+i+ssD2T/vp6md+AJ2FP8BYKZRu7nzSiQhXwgNFFQ89Tp
         hJQ/mBjmuL71B4AdjSrQrYUh+UvSZNK/wf1IRL+wjox/doq93bad8HY/ol3zqqwSQ06X
         IQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BKNBSKm9t8Xuk4biCqYB1X+wCBstZhM2x0v8XkGJ4U=;
        b=c99Qn9YajHg6CAgPZxxpeZqMNJA3dN/gBplJZMebhEsK55TdtG17FcSj4qayCmLRHt
         HSe0gtkWhyRfS1+yYOuCngV79sSnR5V79zN1hPToXd59csmNwv1sBvnT3ONAqKc1CB4s
         s/BkvpJrptx64/Fn+F36iOLyN8yx8jXr32ks1/4mS2eOVrcpIbqNNCHPi3RItRHj3rp6
         EnBt240jMCOq45YWlswNz9Y1CuOpb3SKSVC44MOFQfJm+KUA3sg59vmu0yZQulxWl46E
         cR4/Kl23gZQPCckhCoRmYLgPIvIq2bPWMTRa+obR0qyl9cWNjZYyMCDifdLWcgIL/6mV
         QtKQ==
X-Gm-Message-State: AO0yUKWdlF1BFfsKawJ6QMZZtuc01In4lEtzijVbNrpYFw5suRlCXyr2
        xYjVwVw2z2raTV2UICL6quhecUp1G86tBzFn
X-Google-Smtp-Source: AK7set+gFdo2mm1hMbeZy8Ga69DY7BJMFCTdJKo7yEwTc9QYfjZ5k+75BiUAP9SisWL09Y9nZmG4NQ==
X-Received: by 2002:a05:600c:a297:b0:3eb:2f3b:4477 with SMTP id hu23-20020a05600ca29700b003eb2f3b4477mr6826745wmb.28.1677749588155;
        Thu, 02 Mar 2023 01:33:08 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c468])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b003df5be8987esm2468410wmo.20.2023.03.02.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:33:07 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell Vostro 15 3535
Date:   Thu,  2 Mar 2023 17:33:00 +0800
Message-Id: <20230302093300.62098-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

Sometimes the system boots up with a acpi_video0 backlight interface
which doesn't work. So add Dell Vostro 15 3535 into the
video_detect_dmi_table to set it to native explicitly.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/acpi/video_detect.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 710ac640267d..14d6d81e536f 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -716,6 +716,13 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
+		},
+	},
 
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
-- 
2.34.1

