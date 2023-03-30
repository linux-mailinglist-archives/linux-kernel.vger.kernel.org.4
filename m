Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4A6D03CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjC3LuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC3LuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:50:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C9CDD;
        Thu, 30 Mar 2023 04:49:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id le6so17779128plb.12;
        Thu, 30 Mar 2023 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680176998; x=1682768998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MoqOvm+WmmcoOXasr1TBTGxRdpCYwDL2NJnL6pot/Mo=;
        b=XDcT3KeY/F+zZmaoEHlButSpYGK1hJm15Bg8QjPwlU3C6Jr0iqSFXZM8wZoCA9pqbv
         e6U4KdUeywBj238PKZ9zh2Xig4ijj9VwmEu0k2BWDnt+GxE4cG9sfJrjMIIhrMPTQb2z
         2YO7rEfyuQfA7pIA73DTqWelIIxwkTZKmlrVLPZKMZRUTR+pJ3o/NokAAmjBoCSCKTm2
         jp0dZI4TKfIFnje2WIIoM+rPjYtSO21p/vMNy57MwIzmaCOqADD9rSICEnuvAIw8nQ8y
         euI1YDbQpCygr4cWHQgH9mWZX+d/Sifg4JiONxO+HFQrZLCj5cqZ5D1BqNVEuKyjr7yz
         AF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680176998; x=1682768998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoqOvm+WmmcoOXasr1TBTGxRdpCYwDL2NJnL6pot/Mo=;
        b=fayGaSKOqXuLvnsGQ8ggFynHlGKis68KKRb79WLb7u82YoFGgCkMf5r3MRzs2sb8Kw
         h79Na112OHoK8keEfpsDQQY8h6ZqxDKZBSIOA/4XLFQ2Y8SIV5rNluXpTRCG5Wq+lldW
         TioavaWcsVFdxxRYEaI6caBiE3P5pN3VhxEzOMuXdPm8a7GcsMczojEY/Yo7Qz4j0App
         dNCN94BwuVZnmMA2gkvYNhis4JgKiIGlLlztOsgjtSIWWFgrIKmS0VW+V9eIkK8rPdAL
         U/9qzRhezmmN7/RRa6j41rPy6t5EjUXYNFwMc7HdNWVgvIkwbUSfuRTWwRNlvkshC9MZ
         H3bQ==
X-Gm-Message-State: AAQBX9dyCVdcnxv2kFX7RUA4TEK4CT+tcAVb1e9K/HZNahciCHfsGsha
        GljlurPTZZWznBmG3xKrw+c=
X-Google-Smtp-Source: AKy350b8sLf3HXxlyRrxUD3Ij2cj5uVAfYLc69sXgotjQ50h1YNbFqM32sqKp7j1CXa3AN3iKGGnpw==
X-Received: by 2002:a17:902:e847:b0:19e:d6f2:feea with SMTP id t7-20020a170902e84700b0019ed6f2feeamr28744596plg.9.1680176998695;
        Thu, 30 Mar 2023 04:49:58 -0700 (PDT)
Received: from Erekir.lan ([103.147.22.100])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001a1ccb37847sm20430989plr.146.2023.03.30.04.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:49:58 -0700 (PDT)
From:   weiliang1503 <weiliang1503@gmail.com>
To:     corentin.chary@gmail.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        weiliang1503 <weiliang1503@gmail.com>
Subject: [PATCH v1] asus-nb-wmi: Add quirk_asus_tablet_mode to other ROG Flow X13 models
Date:   Thu, 30 Mar 2023 19:49:43 +0800
Message-Id: <20230330114943.15057-1-weiliang1503@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make quirk_asus_tablet_mode apply on other ROG Flow X13 devices,
which only affects the GV301Q model before.

Signed-off-by: weiliang1503 <weiliang1503@gmail.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index cb15acdf1..e2c9a68d1 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -464,7 +464,8 @@ static const struct dmi_system_id asus_quirks[] = {
 		.ident = "ASUS ROG FLOW X13",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "GV301Q"),
+			/* Match GV301** */
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV301"),
 		},
 		.driver_data = &quirk_asus_tablet_mode,
 	},
-- 
2.40.0

