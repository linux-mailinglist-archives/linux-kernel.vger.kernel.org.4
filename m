Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A16A74E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCAUP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCAUPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:15:05 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF8442BC9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:14:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e13so2979953wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAtw1U/BTDOrZHgBLIQAFfpKcmyk/l+MkBAEZzxdNlo=;
        b=LXar5EDJMGIvYkIQBNmH4aYD+L1S+thPtq/sVBh9BMX6eutE7uXqTCBu5XWNA4rH9k
         bxhZfiJgmSOli8WjZh6fThTr8fEDgRQf9ZabmpDx7qyVagf2vb/2lL8Ej0CCWueeUD28
         rigW+wI0aZ8p41nZ4QFkUIe5I37Ls0U/f1nLDIIWWgvq8Ni7D20IuORr96GbR6MuAIpA
         6bTbQS+c6tzTyyCgnJkYCxHzuDQ4SAMOjuAzo3BqTH5nKf9y5o+9PvyY3WF2sh6quRCK
         JpI3CrVtiHzTKhXZn8Sz167S6oHzcF796mz3pUfZNIjQjKigyPhttWKhnaBTakNeIx3v
         NAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAtw1U/BTDOrZHgBLIQAFfpKcmyk/l+MkBAEZzxdNlo=;
        b=xNG8OqF/1rTtR7WYeH4GemZyirRz32yd1tuObwqgXR5rcYG6pBcJJThnJqCPrV8Qfb
         EUIuDRyd7+XRhc4vcPL1XpJBZ/Q+VfW+QtuoTanF4p4mCymzzLqQuV2p9tN8p1ao1KUF
         BxtsbkPGydMUmpg1IkY5mYtYYq2UPkzmQgf0WvwaF82BxlhGSyfQcH15hJPm4r7UZjo9
         yLwHweA34C05olNo5AHqIkeYzaFYlMY6S6CT30PaU2jwPnultBGxKxDuVmNX4X2DHr+S
         +XEl2P8QUVfT9CwTJz61fLbY6lKkIiL81wQAqvhkG2mD4Ec/DYUeShCGVPsxRrpckVyp
         A6nQ==
X-Gm-Message-State: AO0yUKWudkK8v4rvPVN+XcCrnxK2tw4ZKmWzj9nEnhK3bkm2ELZe5prS
        k6kwCtqTBiSC6MdL/y8Mp0igqGE1cUPC7UyZmOE=
X-Google-Smtp-Source: AK7set/YL6hJXKCT9Q1yd2tTfljiI6UDXAiLuLGRxiiD9DPPYB+Y8l3Q3UHRDiIWP4bV9wYn1zwkbQ==
X-Received: by 2002:a5d:6607:0:b0:2bf:96ae:7cc8 with SMTP id n7-20020a5d6607000000b002bf96ae7cc8mr5920649wru.4.1677701696680;
        Wed, 01 Mar 2023 12:14:56 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:14:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v5 01/18] thermal/core: Add a thermal zone 'devdata' accessor
Date:   Wed,  1 Mar 2023 21:14:29 +0100
Message-Id: <20230301201446.3713334-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone device structure is exposed to the different drivers
and obviously they access the internals while that should be
restricted to the core thermal code.

In order to self-encapsulate the thermal core code, we need to prevent
the drivers accessing directly the thermal zone structure and provide
accessor functions to deal with.

Provide an accessor to the 'devdata' structure and make use of it in
the different drivers.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/thermal/thermal_core.c | 6 ++++++
 include/linux/thermal.h        | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0675df54c8e6..9fa12147fead 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1378,6 +1378,12 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type, int n
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
 
+void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
+{
+	return tzd->devdata;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
+
 /**
  * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2bb4bf33f4f3..7dbb5712434c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -365,6 +365,8 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
 					void *, struct thermal_zone_device_ops *,
 					struct thermal_zone_params *, int, int);
 
+void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
+
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
@@ -436,6 +438,11 @@ static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
 
+static inline void *thermal_zone_device_priv(struct thermal_zone_device *tz)
+{
+	return NULL;
+}
+
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-- 
2.34.1

