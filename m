Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEC76A34FC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBZWzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBZWzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:55:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654516AE7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:54:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p26so3144006wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cRPoTQKkI6Vh2gx5bELOPsRnRzqaEtxSxLlrGiyoRc=;
        b=AwlI9+h33C/jXhy9hGSXpoqDifHlXB8N01uteX63jb4g3pYnKDNsjEM+g14J292EY4
         0ifvKScwydnHi5F0t1xAVhPNiB9YcSaXLOWwFt4i540arg/Vz2izeTM58KqljbHjJwtm
         ZdO1l9lACbRH1MhmytHdH5lMDDN7rLpvv5tHlx6Rv0jz3+JCgCcXBrvrKpJgNp6yIvOF
         mgf1fLSCbnzdYAG9xELuDZgPJArkFTFx1FN8LNAyDegDEYewE0oprXkWD7JAzDT32Ogv
         PV9EP3MD5djjxLq6NlXU1o7gn7HuaRtRjcKEfPz5OLgBblTwzpj8WIWQjeUnuEUH8yOv
         rXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cRPoTQKkI6Vh2gx5bELOPsRnRzqaEtxSxLlrGiyoRc=;
        b=LmngzSwW9tfcrrVwXJU7G1QLo1lw/bVaNrd/pc9hKTJOypn4PTkZq9fY8lK62D+khf
         XLQvypS0hC2P08pm0bV+SXFOvIVfkP/TFsiy5vv1d22z01zZYIkgGkBlFO2GLK1bhdrP
         L2GFhMEh6nqnvHQb+XxNZE0D2UrbAFTpg5s40etTr29Wihm6669ZkVFbt5Bgb3xSogV9
         r4xGPbORf5tgklBEH/558VcsoA1DhKse3dKLWwxVoLTANQ1lEnm2J7xDK+4Bj5GYncfd
         j3hTNnM/2d141uJO+kCMReobSmScfa1iP/ZANK3Qw1SIcdsjgK2Jb0NlpiqumUJnACE5
         dW/A==
X-Gm-Message-State: AO0yUKVDCqZ9ymvwnjP2wIpulZHYad7svhFTkgxvrS/VJtmMflBqbb2L
        qw0QX3Lg5VKaXjRJ+kT+1axcpg==
X-Google-Smtp-Source: AK7set/qQr+fxwzz14sZxqZKk/MMa/tX15pj/YtT6WQkYmYfK2n3tKLfMBep+DgxFH8pWe/yP83hHQ==
X-Received: by 2002:a05:600c:4aa7:b0:3e2:66b:e90e with SMTP id b39-20020a05600c4aa700b003e2066be90emr12139451wmp.10.1677452089802;
        Sun, 26 Feb 2023 14:54:49 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:54:49 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 05/20] thermal/core: Show a debug message when get_temp() fails
Date:   Sun, 26 Feb 2023 23:53:51 +0100
Message-Id: <20230226225406.979703-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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

