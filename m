Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386DA69E6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjBUSIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjBUSID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:08:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6AF30295
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:07:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t15so5520627wrz.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzE7tCtv9nXhTqCLmkAtvvd9XPqHKuG/dItaNXtPrVU=;
        b=Thv7yiSJS6LdT+pw2gxqAfpkdidxjv3XmZIyc14lPv8RHnC0hdzHCCjPuekBBiEdAN
         yXjZemMYp0R3N1qEOanoTIBH7YQeddzDvp6fJC5UT3WQ2by+MV9oIUTnt7LNxgz3kNt7
         baNqeqz/cjrZKoQHUXMp2TeieMzhvc3WFZFasKpvUEMzVOplplYlg7+1ZtGEqJF05bO9
         3cTnILD76iuRP5mLQCykaMR1LAmID5l2JMk2rCxGwYA9LBXwpGWls6Yjfl/6UrSwFnlA
         Uh32c7QCHjs+wnZnE7BP90YNDambSpgEvmO+MXfiMmy64CEp+lMDCp2t/352+WOfdpn2
         8EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzE7tCtv9nXhTqCLmkAtvvd9XPqHKuG/dItaNXtPrVU=;
        b=RBqhNdQ4si1x30f/l4s8MANGKUnmIix6zRyPOgY09z77OlGnTyhVEwLMem5mNZ5vg+
         1qozcR2Gun7Ix6JkR5u25kteoBDCwSwU3jAMmwEi80oodsmJ3CzAe9EUe9Qbfeu2lz+O
         CfSoict1JOFdvhF2LxoVyM5jCyA/3oOD5fGDnVjeXfApjoobighYWx/u8eF3/i1YrbdY
         Ez0Ic72kTPP5mqcpoRL6rSqWvSqtGYPqPYHAMRmu/0VCtkwQIuq76rVIxxoGgOl9qYP/
         Z+DniPwSn1dzorTFlVM0beM3oRSA7fJb6p5T7ZzLl5YMwusdJaJdxjRCJT3cWzJFlql3
         IdLg==
X-Gm-Message-State: AO0yUKVlpZRXJbDH0KNmVf3TvbyCXcYfHJrocYFLEn2OgDhTlqlVtIMb
        /nu45ugoZWjGhHTSwD1WGdcy0g==
X-Google-Smtp-Source: AK7set+/sMtsykswoYmh0ietM4VDLEYWigKi67bsjYwoDaJOIkr0JYkFN9HyhHHiPzXGEmhQlrvi5w==
X-Received: by 2002:a5d:6112:0:b0:2c5:7c7a:78f5 with SMTP id v18-20020a5d6112000000b002c57c7a78f5mr4549225wrt.52.1677002858926;
        Tue, 21 Feb 2023 10:07:38 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:07:38 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 02/16] thermal/core: Show a debug message when get_temp() fails
Date:   Tue, 21 Feb 2023 19:06:56 +0100
Message-Id: <20230221180710.2781027-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
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

