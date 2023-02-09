Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522FC69099F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBINOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjBINN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:13:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A15ACC4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:13:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n13so1385324wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPMNrqeZWO55o8AuAcgfBuwWh3I0TkN1wM5VoUAdYRc=;
        b=P5/7vAmoDhtyUlDOFPxWWFRqeYKHw8doDPEZBBNdtIVq/tXEgqP6HDXkgsDHQG75uj
         BuJV5vmjH4QrQCnfFzzcRmVT3ejoinm3y5GEBKxcEeeD05XKfjCBAClKGnST3B8MQWBn
         Oc9ahTVyT17Vg+/x06m23nWOiXJ4PHkiIM5dWbGETfG8UKXs8GnE9P+l+9vGNhAOPryv
         SB4acICvJP0dUJDt6xotz75JpNVjolbpfbeHUVPmCeXC2RzRWI3hzObNL8NU/+9JNPDt
         2mOU8jfUcVHMFTisSeQ4GxV8m4O9Zrv8n5ZG1Pox+2DVnyTohSu+1Kuswuhi67g9tHme
         /3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPMNrqeZWO55o8AuAcgfBuwWh3I0TkN1wM5VoUAdYRc=;
        b=hWWlqFftJj7yDa5jRuEpdpcalsDdRTs4W8h1K0XSpFmvvmsQLXfcoA+cyQof0JAAUo
         VUe6cFO7Ac34C9jo+fH7GwYs5ELUWm8v5NzS0r2BfzS+O+EadtU2q+9AfDWPDQ0/0ORG
         HDnHXKg/92EGomnwWWQwBTmH0Q8AgyP2e8HXALY3tyKKbSWFZ/BYf44v7G6QmN4/Nxws
         mJ2rhSKAjnmCoHfNKc7PXwIWIoHI9XPEMErN/uxyhGhL0Lmep7bFeDyRy2jRl+YN5/Dj
         MTjgBTjaqksNwTWNb1qWh6bdglbFRkX85e/7DBof2c80TuUTk79t88WP+diUDMLCeEB4
         bPwA==
X-Gm-Message-State: AO0yUKXYPVVuFc85x5WFoBuT4x4CBKkoTnXDwOwTOIuqZqaJctGVgrNz
        Bz6N3tXy4kwDZnww1PZPlSf0vQ==
X-Google-Smtp-Source: AK7set8+KF1qJ63RGYOjxvONT/0dXdAeON0gJzSIfKGxOdbH/Nq2pMAk1kkn/QWQI4j+NQDJQZfcUQ==
X-Received: by 2002:a05:600c:4485:b0:3dc:51ad:9dc4 with SMTP id e5-20020a05600c448500b003dc51ad9dc4mr9701331wmo.18.1675948433322;
        Thu, 09 Feb 2023 05:13:53 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003dc4b4dea31sm1789394wmb.27.2023.02.09.05.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:13:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/5] soundwire: qcom: set clk stop need reset flag at runtime
Date:   Thu,  9 Feb 2023 13:13:36 +0000
Message-Id: <20230209131336.18252-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
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

WSA Soundwire controller needs an full reset if clock stop support
is not available in slave devices. WSA881x does not support clock stop
however WSA883x supports clock stop.

Make setting this flag at runtime to address above issue.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 74e38c0d651b..0224a5a866de 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -536,10 +536,14 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
 
 		sdw_extract_slave_id(bus, addr, &id);
 		found = false;
+		ctrl->clock_stop_not_supported = false;
 		/* Now compare with entries */
 		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
 			if (sdw_compare_devid(slave, id) == 0) {
 				qcom_swrm_set_slave_dev_num(bus, slave, i);
+				if (!slave->prop.simple_clk_stop_capable)
+					ctrl->clock_stop_not_supported = true;
+
 				found = true;
 				break;
 			}
@@ -1500,15 +1504,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
 		 ctrl->version & 0xffff);
 
-	/* Clk stop is not supported on WSA Soundwire masters */
-	if (ctrl->version <= 0x01030000) {
-		ctrl->clock_stop_not_supported = true;
-	} else {
-		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
-		if (val == MASTER_ID_WSA)
-			ctrl->clock_stop_not_supported = true;
-	}
-
 #ifdef CONFIG_DEBUG_FS
 	ctrl->debugfs = debugfs_create_dir("qualcomm-sdw", ctrl->bus.debugfs);
 	debugfs_create_file("qualcomm-registers", 0400, ctrl->debugfs, ctrl,
-- 
2.21.0

