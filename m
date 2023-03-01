Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1C96A7520
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCAURD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCAUQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:16:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1195451F85
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:16:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so1124893wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS5MMzUrtYY5N2w5QCadh2L/6Lyuv9jfcaqNKoRqTRU=;
        b=Wh1pDVCEqhjlJTafWbx23xgrU9MTAStk8awP1aqswW8Gi720ZllVpBTdpV3pypOdWz
         2/1vcLJXoc2h8DLn7W+CYb7HiFJpY7f/LNhRdj9ryZbyr7m8zfnh18M7I6xmMREEqzNb
         E47oMtCLR2ltG9x6r3qAYDSCAlyuIENYjlwWtwF0VQ8JGHJVJ6W/gRJXjsJOmz9UUGL6
         SGa/FjUFqa4l4hfO97J8INxHyV02noj65Yz08aDuXf5G4HQO77iriljdBwmilKvw8MQX
         4kMJ5yIx2ReX6Pl9Cio9VyyByqM4ZHizUjCXu3kUXuUbTX0s0ADV336rk7PqnW4mGKxm
         AZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS5MMzUrtYY5N2w5QCadh2L/6Lyuv9jfcaqNKoRqTRU=;
        b=PBN9bikiI2egpVCvC9Ry9XXcmlfYjhY62uRK9F2upd6JC7S3cQOmyimB9hH00m5A7U
         pikSn8qz+WNV7W/iuvUbefphIyom2nHKry0qUkKcmkY8r/RfgG2Sq6PVmyGoheInyflP
         ZG3+7TLcKvXMoiTJMZO/yIJXY6omdRzPuNH0puiWleKCsbwB+4C33vfOULG5v903MJqq
         dPN4FT25bXxFNvHqPk2pJcwD9spVeaUIJmk8EI8FLejbeNdmMRwwnJsLshZ2S83vx298
         NJPbN3j46n7r1hdaFUVJ8TF2rv11BihiLwtke8s8fU9yPE4Uahngt5dQIzfdchbiq76s
         d82A==
X-Gm-Message-State: AO0yUKVuqPtKk/A4VSaE1eswzJMCMhKl899CRC+l9DhX1Xpa7967AXs5
        S7uVjuIf6Ya+vlaWEJbdYN+e6g==
X-Google-Smtp-Source: AK7set9/48B3UkJzRbD9ghUuPOZUq417aVxqF4bZ/zrpzF6PhFApIvpjoxt3GWWtJuYzeCOE4ikdug==
X-Received: by 2002:a05:600c:1716:b0:3eb:2e66:9 with SMTP id c22-20020a05600c171600b003eb2e660009mr6538243wmn.30.1677701752097;
        Wed, 01 Mar 2023 12:15:52 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:51 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER)
Subject: [PATCH v5 18/18] thermal/drivers/acerhdf: Remove pointless governor test
Date:   Wed,  1 Mar 2023 21:14:46 +0100
Message-Id: <20230301201446.3713334-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone parameter specifies the bang-bang governor.

The Kconfig selects the bang-bang governor. So it is pointless to test
if the governor was set for the thermal zone assuming it may not have
been compiled-in.

Remove the test and prevent another access into the thermal internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Peter Kaestle <peter@piie.net>
---
 drivers/platform/x86/acerhdf.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 61f1c3090867..71b9c1f922d9 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -697,13 +697,6 @@ static int __init acerhdf_register_thermal(void)
 	if (ret)
 		return ret;
 
-	if (strcmp(thz_dev->governor->name,
-				acerhdf_zone_params.governor_name)) {
-		pr_err("Didn't get thermal governor %s, perhaps not compiled into thermal subsystem.\n",
-				acerhdf_zone_params.governor_name);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

