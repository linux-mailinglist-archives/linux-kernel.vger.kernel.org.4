Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E76A57FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjB1LZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjB1LYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:24:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD022DCD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r18so9357083wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS5MMzUrtYY5N2w5QCadh2L/6Lyuv9jfcaqNKoRqTRU=;
        b=wmROP6AyQSd/5lYDaTnJSUSDXdhXDdPFq6dWXSe77IejOrFttF3d59ytNrebe9bWZD
         7G9JvxGcOZeqMgxxKGV78ZWGnj3tWGl5eHJp0AcWtzyoe3qEdHGW6yN3eVOEs00SdMev
         1IXw0FeceljNrRpqTqA3WpAol75g+SiSq2TGI265YAs4USbddI0OBs2VZkN0y81+KQJC
         ag97hXN8hnVLeuV73nCVIlwWV1IJwsGLMorSpUivU/zZYBwtgadH+UPfQvbdnBvBiY/w
         nya+SL8nqgkYI8Z5tKMI0O3fcuoPiU9Z1AjYwN6Z44iSGmqj9rWQctC5xBwHXC8HoLf1
         f5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS5MMzUrtYY5N2w5QCadh2L/6Lyuv9jfcaqNKoRqTRU=;
        b=2FUBuTBEz1Nr1VGDS+5j+Jhj+xq4NrQWR0d1MjEYOQWKITzjp56M7ofsluIhJEqCMG
         qJS5idgsnq28qJ2/LNqs7p/ofQu5mY7vnIUGr1d96zGe4gwslaQtNc7nnGxEVlKCdSnI
         KOn5O7ewCZgYHRNzJf7cWXZhO6kCCcevCTM8oHRagFJo7O1t22Ny3wOsz8BwyY5ZdxYb
         dObclxENDALT7Sql8R/PWO/VTxqPszczAS5ulUwtaWfRkz+DA0hAEJIMu0qE3zXHs+uY
         Spti4H6NyMYLbdYDOTFMEGJf/dYV04phyFDH0fWkmEq2yd4O9NRW3pJfhJlBUlreOF1a
         gSqg==
X-Gm-Message-State: AO0yUKXpMBpzoTuD2a+EkPwDpQ1jWPZLVnOHCF0rNNdVMqsj2Z1YNckS
        dpyH67tMdz5XiqDhLjC2A7Kjvw==
X-Google-Smtp-Source: AK7set/dTEth29o+dr/zBLrbuIlnFlYoyHiG+j5LuNH6wDymmrDcmCwbBZcl8aJWcvTmBiAmDk7x+Q==
X-Received: by 2002:a5d:63c6:0:b0:2c9:e34e:7d0 with SMTP id c6-20020a5d63c6000000b002c9e34e07d0mr2243434wrw.3.1677583422966;
        Tue, 28 Feb 2023 03:23:42 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:23:42 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER)
Subject: [PATCH v4 19/19] thermal/drivers/acerhdf: Remove pointless governor test
Date:   Tue, 28 Feb 2023 12:22:38 +0100
Message-Id: <20230228112238.2312273-20-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
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

