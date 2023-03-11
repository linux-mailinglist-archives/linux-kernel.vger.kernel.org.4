Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688876B5A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCKJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCKJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:47:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A6820A2A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:47:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id er25so2090871edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678528058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeSYc/xPF4GfQny8J1y07XHI4oidFkVFmRDBc8YwiVI=;
        b=f02r/i46OW1rUlkVA8qV4GzLGwjebIXg4FFSOW8RPu7jh7Vz0RVKCEiocwOAAg2kYi
         IVhDdwEdpruwMIhT57wSRNAWc55joEAI1s2pBaNWVjg0iqXlXSqztDk/VVxIU7YImI+u
         5Wp+Ot3/TlxdkheGc8YAAWHvWs5iOxOeVvvzvb61P0EGXyJpAO8dkvZ3XnW5nKGf22xs
         gHGldiGvPgrr9fpGkN/JTeXz7S//YxGhZNpvu60EDQcvSZLul8Xuk6FmmIfynmzlgZnj
         Ys4+XUEbiJ1imksAwvkhfFBUMY3qYC3WNsm5xHdfMYeCk8rNV3fCrFi9xm18SyEiVa34
         dVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678528058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeSYc/xPF4GfQny8J1y07XHI4oidFkVFmRDBc8YwiVI=;
        b=QmhzWUVsUwZWhAgZxl5HA1ELoVnZz+o0zzm3GRJYAS9kB8gUCHfVGdwBUmdbN/ON8q
         Fo7zKpJGE4KWHyEeFKp4ViQWkeYJa7wmHZhekf22iiNW/n2SEHlSLgpqiGbS56j6Eu7N
         2XDPmK4InHNnbTm381R9omg1/EVwrHbMsjOiOeIqyFCT2h7oYfdkX6+Jch5iDgsSzZEh
         yk092hSvGjP1ZoaY8pQgtBrSDiz5jdKl/sT+SBfIcm4BL7pzMVFkbT5JDKkuErx5zMr6
         vnR81osm/kffXQihMzRkf2BtcqKnrDSDzcVQ5+pKcpfFXAGjBrf3OHEHaRCJg8E1BxvN
         us4w==
X-Gm-Message-State: AO0yUKX91hRqJdk4sI0YpFcHr4D5FQW86CXEYLojdtTRlUHQv4vHw1EJ
        u88z6TgM9i/l2Azah/U+q5uvKhn3wpAyG32fI98=
X-Google-Smtp-Source: AK7set/xNglzq3mHMOtj+I5WM2DRtAx92Y4ODYnF2xF0FnlDkK+vnWoUAMjxZvFIc+dZW8gC+Ajdsg==
X-Received: by 2002:a17:906:30d3:b0:8e4:96c4:94a with SMTP id b19-20020a17090630d300b008e496c4094amr27286115ejb.56.1678528057764;
        Sat, 11 Mar 2023 01:47:37 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id u21-20020a509515000000b004bdcc480c41sm952585eda.96.2023.03.11.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 01:47:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] rtc: omap: include header for omap_rtc_power_off_program prototype
Date:   Sat, 11 Mar 2023 10:40:21 +0100
Message-Id: <20230311094021.79730-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Non-static functions should have a prototype:

  drivers/rtc/rtc-omap.c:410:5: error: no previous prototype for ‘omap_rtc_power_off_program’ [-Werror=missing-prototypes]

Fixes: 6256f7f7f217 ("rtc: OMAP: Add support for rtc-only mode")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 4d4f3b1a7309..73634a3ccfd3 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
+#include <linux/rtc/rtc-omap.h>
 
 /*
  * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
-- 
2.34.1

