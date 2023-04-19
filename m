Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC36E7556
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjDSIeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjDSIeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:34:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA23AD32F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:33:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso85856545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893232; x=1684485232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPfklvntaSAZNSstWZb9c9xIuh7wy5gv7laC1WOc6HM=;
        b=CO5jbBs58eoibeB500jlo8tkaZUwialhUILZ/mxzasCOkfacYHjPZn/iSVXhKoUO91
         bTPTsV0xmV4SVP/B2qJARLMp5mzmlaGf3Dx9vLeA3oUdYxhsAZfO0peVQqrFU8L6bCbW
         GxXVeZp1g0WHFjRq+jkuJEyLXajzQQRcMUmUz5PHuoCMN+++vqyG2V1CmbgTl/LfbdJ+
         T9pPZrhPf+qD5YxS0JFAjcbtdydgCNjsiVr1MBjjDnRhVVlKKmy0j/WAKk+Z5f5SvF1N
         RhEFhWmKE1zf/ScN8YfXNkqGqBSCWj25EQkCs91/ZbDK4vK3ADWNJRU6Iz7sXr5G8Hk5
         aEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893232; x=1684485232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPfklvntaSAZNSstWZb9c9xIuh7wy5gv7laC1WOc6HM=;
        b=DCP5K57f5GSPvglvKiGOxomMjVQeXNrdXIK+Ieky2cePkkjTJYJHVWNuZOqj9Y82xp
         /xcUMCiHZZE71K2iZYDJfvJ5gNFJe9GzXPjLHPPFEa4pVyhEwuqAGcibxqmfw/1ko8RY
         NuuEqJAXSDIBJr6C1wwJr1oNG87GPsBg1blojqXEoGLQOBhv/CAz2LBfv48VKH1eeD7y
         vMd3SDa0OMXuhcPqjHn3JvQZ2t01KNlxUxEQx6kvFg1qRlq7s3NKC4837DQa6e75OZEA
         xTLcPOwUQXntVzupCobk7dcvMjm3HwQ1hXglfLCnqfKPajLI1LUOCnDijZJvXTPWhpSC
         KwSQ==
X-Gm-Message-State: AAQBX9e0pZrLkFlNhMESLUUJMlQK/1/Qa++/0agzcu306tKzWJ5bWYPZ
        VKIj6+m3m8k8L+uxFfGMDXvggg==
X-Google-Smtp-Source: AKy350Z7VqYlBRj/RFO8d6zcdWtuIqi5exUOJhOIPSy4PJYAZ2EtITGlQNN9EX6k459/d0eIqVr/Eg==
X-Received: by 2002:a5d:4573:0:b0:2ef:bac1:9c48 with SMTP id a19-20020a5d4573000000b002efbac19c48mr1406536wrc.6.1681893231938;
        Wed, 19 Apr 2023 01:33:51 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a794:9fb2:29fb:606d])
        by smtp.gmail.com with ESMTPSA id s5-20020a1cf205000000b003ed1ff06faasm1442033wmc.19.2023.04.19.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:33:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Sujith Thomas <sujith.thomas@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 4/6] thermal/drivers/menlow: Use thermal_zone_device()
Date:   Wed, 19 Apr 2023 10:33:41 +0200
Message-Id: <20230419083343.505780-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419083343.505780-1-daniel.lezcano@linaro.org>
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the device associated with the thermal zone, let's use
the wrapper thermal_zone_device() instead of accessing directly the
content of the thermal zone device structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_menlow.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index 5a6ad0552311..d720add918ff 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -422,7 +422,8 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 
 	result = intel_menlow_add_one_attribute("aux0", 0644,
 						aux0_show, aux0_store,
-						&thermal->device, handle);
+						thermal_zone_device(thermal),
+						handle);
 	if (result)
 		return AE_ERROR;
 
@@ -436,7 +437,8 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 
 	result = intel_menlow_add_one_attribute("aux1", 0644,
 						aux1_show, aux1_store,
-						&thermal->device, handle);
+						thermal_zone_device(thermal),
+						handle);
 	if (result) {
 		intel_menlow_unregister_sensor();
 		return AE_ERROR;
@@ -449,7 +451,8 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 
 	result = intel_menlow_add_one_attribute("bios_enabled", 0444,
 						bios_enabled_show, NULL,
-						&thermal->device, handle);
+						thermal_zone_device(thermal),
+						handle);
 	if (result) {
 		intel_menlow_unregister_sensor();
 		return AE_ERROR;
-- 
2.34.1

