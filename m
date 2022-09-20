Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F925BEE26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiITUBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiITUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:01:43 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ACC52DE3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:01:42 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o184so5131053oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=UvCzFRz2NVVkWyo1c0vM20+OTK1RHradyaDAIZcS02QmdlJiM6aZIJeS1GkO7RVPIv
         Gsp/MxAPYfj70si1NaVa8j5wtwbyP5Ka0j1gQoM35l2ZCHWurQW/eAK1uzOOmxonyITj
         K7YXixBh9+JQ43SzVROPMAo7J+CbD/Bp+K3lX0kDffFZdLlMhM5ZUuBFQI/P5D+uNGfg
         wYkBPOyUWLHFoj/MZzIzpr/1foC2XijSln4oIrtu1Hy1HQ3NL5ZOYI3epX42drdZTjZa
         Z4bjtaiwlMuOCGDROpokAtgqSJU7f8vEzcMo+Db6RMXoHYxTxbuiW5dAVZAC2lY/0lhe
         jfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=Xp/pz8J8qCuT7biGA2y0pgnANNvpNOtZ3+5QoKAEznHUWneJ5sg6BpZZbc4vcgUVsC
         a/dFWwoDoJXyeEn3mKFfLR52kLOXHeQWodIeBJXYvCcJpsrz5RACmD6DDA79FVRnJV8K
         bFoGIufs52N/au907UyeiLhT1S2RXe8tkyPyhlYGTplvBFLQvW1yTxXzEhBuIlhjN2RK
         PF9VqpOKXyVAEz20rgxmDPAqcQLGD1LFJH0KLgQ3gjarXQnVK2WPbdHFiwzFknDCrQqx
         J9yb58G+Yrmys5JctP2A64zsxsiYLPGg6ugcxcA0ct47X77SoDf//RsJcckI/hC7TOYJ
         3+Tw==
X-Gm-Message-State: ACrzQf0ik0hw/On7n84w0TljpaCrKmIsRUn+OG7EiItF2Vxli6p0KDlh
        SSMQ2TH1yGIa0hwTGmrpm/QYJQ==
X-Google-Smtp-Source: AMsMyM5kp/MxdnFF28P45v7t/0Ki1JDF05paDTrbPHa0Gr8RJh4a7QwTvH+z10O9+UuFQSEFhihSzg==
X-Received: by 2002:aca:2319:0:b0:34b:a8d2:c604 with SMTP id e25-20020aca2319000000b0034ba8d2c604mr2440194oie.244.1663704101866;
        Tue, 20 Sep 2022 13:01:41 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bm43-20020a0568081aab00b0034d14c6ce3dsm325634oib.16.2022.09.20.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:01:41 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 2/5] counter: 104-quad-8: Add Signal polarity component
Date:   Tue, 20 Sep 2022 13:21:26 -0400
Message-Id: <8b10f4718e17169dffd7b957e11b02257d91230e.1663693757.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663693757.git.william.gray@linaro.org>
References: <cover.1663693757.git.william.gray@linaro.org>
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

The 104-quad-8 driver provides support for Index signal polarity modes
via the "index_polarity" Signal component. This patch exposes the same
functionality through the more standard "polarity" Signal component.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 1323edfbe40c..2a9d8259ed4b 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -549,6 +549,32 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	return 0;
 }
 
+static int quad8_polarity_read(struct counter_device *counter,
+			       struct counter_signal *signal,
+			       enum counter_signal_polarity *polarity)
+{
+	int err;
+	u32 index_polarity;
+
+	err = quad8_index_polarity_get(counter, signal, &index_polarity);
+	if (err)
+		return err;
+
+	*polarity = (index_polarity) ? COUNTER_SIGNAL_POLARITY_POSITIVE :
+		COUNTER_SIGNAL_POLARITY_NEGATIVE;
+
+	return 0;
+}
+
+static int quad8_polarity_write(struct counter_device *counter,
+				struct counter_signal *signal,
+				enum counter_signal_polarity polarity)
+{
+	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ? 1 : 0;
+
+	return quad8_index_polarity_set(counter, signal, pol);
+}
+
 static const char *const quad8_synchronous_modes[] = {
 	"non-synchronous",
 	"synchronous"
@@ -977,6 +1003,13 @@ static struct counter_comp quad8_signal_ext[] = {
 			       quad8_signal_fck_prescaler_write)
 };
 
+static const enum counter_signal_polarity quad8_polarities[] = {
+	COUNTER_SIGNAL_POLARITY_POSITIVE,
+	COUNTER_SIGNAL_POLARITY_NEGATIVE,
+};
+
+static DEFINE_COUNTER_AVAILABLE(quad8_polarity_available, quad8_polarities);
+
 static DEFINE_COUNTER_ENUM(quad8_index_pol_enum, quad8_index_polarity_modes);
 static DEFINE_COUNTER_ENUM(quad8_synch_mode_enum, quad8_synchronous_modes);
 
@@ -984,6 +1017,8 @@ static struct counter_comp quad8_index_ext[] = {
 	COUNTER_COMP_SIGNAL_ENUM("index_polarity", quad8_index_polarity_get,
 				 quad8_index_polarity_set,
 				 quad8_index_pol_enum),
+	COUNTER_COMP_POLARITY(quad8_polarity_read, quad8_polarity_write,
+			      quad8_polarity_available),
 	COUNTER_COMP_SIGNAL_ENUM("synchronous_mode", quad8_synchronous_mode_get,
 				 quad8_synchronous_mode_set,
 				 quad8_synch_mode_enum),
-- 
2.37.3

