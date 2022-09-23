Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE795E7CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiIWOZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiIWOYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:24:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5292737
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:24:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so227160wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aZ9inPx/SpVp/+EGUIHCzXQtKEo6kGOnnJXHLc8UgwM=;
        b=YOGaryDSh5eMCTjfMznfvWNctOo5bnmgrfLp0T2b1FoSvPwCOLhO2KXAHALUJS7chj
         aoVIBT9sRSrjuc1YwAFtMTW0KVXmGhBwTA9el7BG/DRkEjRyOYyQ6bXGtrVnPqUEsM3Y
         N1vkorsv0dXIlGOgM5xWHRP3MZprdLjutkwD+aOeoyEeoWQ6W1eXZx3oA7wSehh4FXjT
         3IuUEklaMR0ETL8tQfMsc7zCVgJU0RT26bzjYz7aNE+ftTnJYcw2u6Ritend42vFXJd8
         j0mOH0ASvCv22tkAuNwANjgmC3gFjhkT86Atps/yR8/6bPJXDTqnOYA9QE8cz1ydGgxw
         JaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aZ9inPx/SpVp/+EGUIHCzXQtKEo6kGOnnJXHLc8UgwM=;
        b=3un0ODRB3smmV5zErjblOYao8v6u2dasVcYIm8U725SV6vw/W1HtxEtKco4IzJet8T
         WrAUfQsIlGBKRpEcc11AaQpGZRQ8Z4VKFxFmfbhbsn3cRgh04XXc0nsKqjKY7f/fQiz+
         YBFcA096Ojx31g9MF0i+pttMIPJS/z0klpud+jaTEf+AXfEz5yhfvMOwSyCKTk1dYj53
         c6la99923HwDWt+rcNVglwj1S9w1WdgkzUea1HXqo3T9nBd4I3Wh2TqHCR231i/X5IB1
         Yw5w1F6fKyrL50CR9BvV3ep6PNz25yoR1va3xs0wBlLoY7iMWaTgvNfa4sV/fSV34NA/
         4zBw==
X-Gm-Message-State: ACrzQf3X5J4aZkafGo4Kt6zP7pzgmxEiW5rXZVHMmjJUDz+RMpn8X7QY
        rGuVgb0J8wAqPoJ+r2lo16MRTQ==
X-Google-Smtp-Source: AMsMyM5KSaCRz7TDVdc4PWQq1dCm9KKmVZbEN5+BoruRlucGDHgFFuxf5Os6GiLXj8b+FzECSYiogw==
X-Received: by 2002:a5d:55c1:0:b0:228:6b57:c60b with SMTP id i1-20020a5d55c1000000b002286b57c60bmr5254820wrw.68.1663943080797;
        Fri, 23 Sep 2022 07:24:40 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b0022878c0cc5esm7444627wrw.69.2022.09.23.07.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:24:40 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v9 2/4] Documentation: ABI: sysfs-bus-counter: add frequency & num_overflows items
Date:   Fri, 23 Sep 2022 16:24:35 +0200
Message-Id: <20220923142437.271328-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923142437.271328-1-jpanis@baylibre.com>
References: <20220923142437.271328-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds frequency and num_overflows items to counter ABI file
(e.g. for TI ECAP hardware used in capture operating mode).

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 30b6e1faa6f6..e177c6128236 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -209,6 +209,12 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/num_overflows
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute indicates the number of overflows of count Y.
+
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
@@ -219,11 +225,13 @@ What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
+What:		/sys/bus/counter/devices/counterX/countY/num_overflows_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/frequency_component_id
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -364,3 +372,9 @@ Description:
 			via index_polarity. The index function (as enabled via
 			preset_enable) is performed synchronously with the
 			quadrature clock on the active level of the index input.
+
+What:		/sys/bus/counter/devices/counterX/signalY/frequency
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the signal Y frequency, in Hz.
-- 
2.37.3

