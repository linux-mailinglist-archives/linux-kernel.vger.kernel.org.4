Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6CD6A74F9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCAUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCAUPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:15:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC634FA95
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:24 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j3so9385225wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cRPoTQKkI6Vh2gx5bELOPsRnRzqaEtxSxLlrGiyoRc=;
        b=B9YthekpD/U0uo1LELMgmU9WPP8G5c3n+EBiyqdmY3mk1OC75xMx8/nWrc+X4CeaKT
         eTEAKeqJV1F1qSmqX2mp3ZMQXxiT+WuKC9GmXLQpD5lAk3w9k6uv4V5uR5vPl7Ezezyy
         cqgtBSaMDBt2gkXyyD4DqGXSDiIlonOW31JvRyZHYuirC+vI1hCoI2ceNEt8TB/BN8fE
         e5W/zGKb9GoJJdI7i9LkoaaYIlm+lv7pFhKsiPf7oPtfpxm/qh/fZX8hzXpN3hIqPXl+
         DW9AL4tneBchL5RI2iOow/OC78JrfS3Ot+GJzDdIjQJDXWnGCD1FgXf2ZYUS7gqGk/4f
         ll+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cRPoTQKkI6Vh2gx5bELOPsRnRzqaEtxSxLlrGiyoRc=;
        b=ykaLc+NeSxLGRhN5hnuM6UXCgQdVgd6+uoc9A14ylbwWzsip5SGFBO9gF8CL3uoAJU
         suM31yudImipOHq+lR+EHzins8nYngaa+54/n6rWwoZ1uz5Du3dcZToZtVQ/m7AaK/CV
         R6cffhLnYrrF9gUSmJE/ibsMExv3NU54pyQERonI03Jw1LALsduluL0hrDO80f6cJrKV
         Xu9flYfSnKL9PA6dgi4Mm1ajV5qIhIHMq03EYwFWvG0RTFxwRmvyMDqfg/ySKm+mHH2n
         C6C1IW7EnekdjYOCnIKiMf3BbDFjStKA8/qnc900TU9k2/zOwbTxqTszIB5ulPZUmkc+
         3L+g==
X-Gm-Message-State: AO0yUKUgZe20Z2SLDH4EMJWqqSeDKgzPA00Zr+QYRBf5bgq0miZmFYee
        bB2TNhKx9JSXNDsJvX8KpQHc6w==
X-Google-Smtp-Source: AK7set+HdHx1G17g16Uvtj4f41o8F9DUAsXLhvcMOvrAmf4/8g8enUQydKM/hxhsqf3fJ1Gzb3KWQA==
X-Received: by 2002:a05:600c:a29d:b0:3dc:55d9:ec8 with SMTP id hu29-20020a05600ca29d00b003dc55d90ec8mr5713971wmb.41.1677701722390;
        Wed, 01 Mar 2023 12:15:22 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v5 05/18] thermal/core: Show a debug message when get_temp() fails
Date:   Wed,  1 Mar 2023 21:14:33 +0100
Message-Id: <20230301201446.3713334-6-daniel.lezcano@linaro.org>
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

The different thermal drivers are showing an error in case the
get_temp() fails. Actually no traces should be displayed in the
backend ops but in the call site of this ops.

Furthermore, the message is often a dev_dbg message where the
tz->device is used, thus using the internal of the structure from the
driver.

Show a debug message if the thermal_zone_get_temp() fails to read the
sensor temperature, so code showing the message is factored out and
the tz->device accesss is in the scope of the thermal core framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 0f648131b0b5..9558339f5633 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -107,6 +107,9 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 			*temp = tz->emul_temperature;
 	}
 
+	if (ret)
+		dev_dbg(&tz->device, "Failed to get temperature: %d\n", ret);
+	
 	return ret;
 }
 
-- 
2.34.1

