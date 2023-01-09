Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF7466356B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAIXgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbjAIXgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:36:01 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB37CE38
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:35:58 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h26so9585102qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foqffIKuz799F5wyGtIM3OCFdqRESGZUJXSmZJH7pvM=;
        b=LW23jYdpmTZPKAu1WNAQKdJrg5k7NJiFihuZiyYCDKpFVyPTxoX3R+4j2E/8C20sGz
         DdPxbKkkaAXqsaLfqLHBFijQTc6CYz4U5GpoJYjEsTG2PZKxaVtq3Tso9AiBDCHhXqV5
         dq4q63L+CIGkpvTwRe98VF3jzL3qibGsXp6E2Bp4lvs5DB1lIG6ZTjSP4pDpVhX8L2nC
         L4XNW6VIMQsR9lcNlSxeJmkqwFkxnsgA5AbemvE2r/Ld4N8ubsHn0FDVZDZH2dK/oHJo
         FkzrdomLx36tBU+wDHxCLM7SJc/fIRMyhdh9dXD9cnbf7gFtv7nAktBx0YFhFZvEsrXs
         A5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foqffIKuz799F5wyGtIM3OCFdqRESGZUJXSmZJH7pvM=;
        b=EbKnZ7jj9nD++5/3/ZbMnpp9fknE7IuZhoWDm0RBLx3ah0Thl9xtApOH514QpPZ6vL
         eIpfErqRemgJ49p3RC9QdnRK6S/8mYnIIfq8FqAykkITkKHABIxufNguXl4+kgcm+tY1
         IjbBUKiEWYj/8lqZPo/ii01iHtCuPHE1S3DQuytgbLIQQVIuCFLJo5AlHdde/1+cklOL
         MlW9zJ3byWEi/wW7lIcIGYq9hYcr5hOWasrIvB3z+l/HgU9AY7Nht3O6QCKo8UrGeG3u
         ZQWA0nLQbr2HhD8KDS13SDtvovvOZIe+uLsDyNmAByunbyKCoaVURkLQ9b1YaTkmyG0r
         PH3A==
X-Gm-Message-State: AFqh2kptqguVxRZTcTtpE0R5Kwl/LBpF5VT3noUGeSYY+Y1z8egx6qJf
        YAMxVk0ujiqz3X/cA/nNa1RECg==
X-Google-Smtp-Source: AMrXdXuKBe+/Uuajz3rIj6IYkFaqoY4JPMU3uJI0uiqlFZFfgymDjbD1lQMih2c4XDNjXaLumE2glQ==
X-Received: by 2002:ac8:5557:0:b0:3ab:5b6d:1add with SMTP id o23-20020ac85557000000b003ab5b6d1addmr99038370qtr.66.1673307357915;
        Mon, 09 Jan 2023 15:35:57 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a450500b006fa8299b4d5sm6294846qkp.100.2023.01.09.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:35:57 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jonathan Cormier <jcormier@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: [PATCH v3 2/5] hwmon: ltc2945: Add devicetree match table
Date:   Mon,  9 Jan 2023 18:35:31 -0500
Message-Id: <20230109233534.1932370-3-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109233534.1932370-1-jcormier@criticallink.com>
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com>
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

Add adi,ltc2945 compatible

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/hwmon/ltc2945.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 9adebb59f604..9af3e3821152 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -58,6 +58,12 @@
 #define CONTROL_MULT_SELECT	(1 << 0)
 #define CONTROL_TEST_MODE	(1 << 4)
 
+static const struct of_device_id __maybe_unused ltc2945_of_match[] = {
+	{ .compatible = "adi,ltc2945" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc2945_of_match);
+
 static inline bool is_power_reg(u8 reg)
 {
 	return reg < LTC2945_SENSE_H;
@@ -475,8 +481,9 @@ MODULE_DEVICE_TABLE(i2c, ltc2945_id);
 
 static struct i2c_driver ltc2945_driver = {
 	.driver = {
-		   .name = "ltc2945",
-		   },
+		.name = "ltc2945",
+		.of_match_table = of_match_ptr(ltc2945_of_match),
+	},
 	.probe_new = ltc2945_probe,
 	.id_table = ltc2945_id,
 };
-- 
2.25.1

