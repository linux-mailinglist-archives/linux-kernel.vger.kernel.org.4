Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AEC729A38
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbjFIMoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbjFIMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:44:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC8270F;
        Fri,  9 Jun 2023 05:44:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977cc662f62so260120566b.3;
        Fri, 09 Jun 2023 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686314652; x=1688906652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7QDAQq/Yt+bFUin4zRriBZQwbZHATNCIDd2rGGW2qI=;
        b=RzAm0uMFzvRDdUqfG+0xGODQ94FDzGMPjIqzTf59CLjHZRlRY5iSj8X/LK7WNOs1LO
         wrarbRpZ3OeOpR86HiqfQnOLkOCFLI9+CwuTVIGhWIp1HRKfEyP6Zqcywt7rxzdsLwAv
         LGFjC2Gg/D9qNeeSrOOHkyG4m6VkXlxRtwVrNkVLtFKzJlPB3q5a4+99gynrn4ZH63UP
         MSFKmSoKlmlMHEnAhe1L1gbnqfL6Wo1uGu7nngTFgpwhE75KiX0oyntLUeZANfR4yCGG
         5IKML+XopTH/7Dl87+TbL98+AE/65c1gqOZRwDKbtwxyizHcrtW+hthN91kIeH7MxqqX
         zaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314652; x=1688906652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7QDAQq/Yt+bFUin4zRriBZQwbZHATNCIDd2rGGW2qI=;
        b=P3VkTXu3tG+Mb/n0udW8hFJtBR0KTIWNnJzdRHjThpLr/9nFAK/LhNVkK0Sg/KC61x
         QHmUWz57xou6GQWJ/j6gnLxQshQbLolC1DTVBgarrlZcjPHGAMuIBpSnWd7KbY3bO181
         hZyALUFvf9+XXjM9APgWW2pH86H4+pwzNdewePBxSY61lLZgEwkfWBWT+myUS5cbqcLV
         3b1KZXLoWTEWTJYNj8tCIghesS6tgVgHKi2C/PTmAOz/M8cp46WVFD1fJHqz1iW0At3F
         LNOiK/YDQwKN5mrUYmEjEEqT8IW2RHpR1kvQWHdeA8hzmXKw/6qS1+yBbHGk6ZKZQIXz
         Xkuw==
X-Gm-Message-State: AC+VfDxjP4RgHcS0N5jvTHhEPQCPmugcyinLgnRWCz4vlIHzeS4IepN1
        n7np4NBofJI283fQOKNJ7CDgR+NXFqU=
X-Google-Smtp-Source: ACHHUZ4hsONfFw870igCx5XZ0nUCRMTK7zGjIfceAO6CPKtu1YJA02DGNKkAdNtIFnb0ipXfWr4C3w==
X-Received: by 2002:a17:906:6a15:b0:973:e349:43c8 with SMTP id qw21-20020a1709066a1500b00973e34943c8mr1805852ejc.69.1686314652317;
        Fri, 09 Jun 2023 05:44:12 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ke3-20020a17090798e300b00977cf84c42dsm1245584ejc.43.2023.06.09.05.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 05:44:11 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: Allow selecting the bang-bang governor as default
Date:   Fri,  9 Jun 2023 14:44:08 +0200
Message-Id: <20230609124408.3788680-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

From: Thierry Reding <treding@nvidia.com>

For many setups the bang-bang governor is exactly what we want. Many
ARM SoC-based devices use fans to cool down the entire SoC and that
works well only with the bang-bang governor because it uses the
hysteresis in order to let the fan run for a while to cool the SoC
down below the trip point before switching it off again.

The step-wise governor will behave strangely in these situations. It
doesn't use the hysteresis, so it can lead to situations where the fan
is turned on for only a very brief period and then is switched back off,
only to get switched back on again very quickly because the SoC hasn't
cooled down very much.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/Kconfig        | 8 ++++++++
 drivers/thermal/thermal_core.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4cd7ab707315..19a4b33cb564 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -130,6 +130,14 @@ config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
 	  system and device power allocation. This governor can only
 	  operate on cooling devices that implement the power API.
 
+config THERMAL_DEFAULT_GOV_BANG_BANG
+	bool "bang_bang"
+	depends on THERMAL_GOV_BANG_BANG
+	help
+	  Use the bang_bang governor as default. This throttles the
+	  devices one step at the time, taking into account the trip
+	  point hysteresis.
+
 endchoice
 
 config THERMAL_GOV_FAIR_SHARE
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 3d4a787c6b28..17c1bbed734d 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -23,6 +23,8 @@
 #define DEFAULT_THERMAL_GOVERNOR       "user_space"
 #elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
 #define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
+#elif defined(CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG)
+#define DEFAULT_THERMAL_GOVERNOR       "bang_bang"
 #endif
 
 /* Initial state of a cooling device during binding */
-- 
2.40.1

