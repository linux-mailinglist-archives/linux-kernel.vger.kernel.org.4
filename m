Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB89165170B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiLTAF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiLTAFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:05:47 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD128D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:05:45 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id t191so5066356vkb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJMGVx/c3dHDkaRWc2L4bcsVUSNNmncwpOKzTe9TVL4=;
        b=Ofzaz35lynvdnSiVHvcRnf9yKy6m1B644SLmuzdMMIXjSlGONBbNGyWZxmhelAA821
         9Gkgbwj3AWCKPYaeEHqgFJzszxBDUeRSRog7ByMZTfLlfcC37gU2gaZ7SDNKkVCRJ/hq
         QiM8yeOQx4LSCfWYiW5RjGQEVznzRaYzfzkKRfZnmyj/oT3pJDxW3q3LZRxxMlEsZCww
         qUnkB3k5fttcGXz5zP2sITuTrE51/15enY8Ed7LHYGbmXlEwJqKBDtuTveAsMAAr7Yu6
         Z7r2qQdeLMqvROT02KT1SzpkFTmXV/K4JHfSafNb+3z6AKGeCLJfLncE77xCJ2mOoKEI
         xffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJMGVx/c3dHDkaRWc2L4bcsVUSNNmncwpOKzTe9TVL4=;
        b=kGfvBQQtZccl/Dle3vMh2KbTDzDlQcIVIHwee7lvfiIrRGk+oMAEy/PHyQEUwl1G4v
         cyD/EIvQgpQOaTG9VEiZ3KlqLlFcRIS3sQeVeChGzjftqQBTsuNz3ja6RuHAue2k5+r7
         Ot5VTWrQdos3c36sKraEmftpM/2Ew7J7j1nfyGHdcPiBoUuBmLybIGKUpQgwIECY3D5k
         oEv1wNX4QuIv9YK6Bscyey5v4AuykjYEag3vgkYc0CiWajAJ6gvBVQrcTOGo8mf3wMNW
         1Ayat+33s1pfti6zB3CYKwV3KgykjZVT8B0QKHaMLWL3FmSWyLR5ipdvn/GZhFiJZuw0
         vHzw==
X-Gm-Message-State: AFqh2krEmsPC+isTgc81Nai6LGhsolIRM6gjVjulMP3FO7m4gTE7Mdu8
        T/K22Q0O5m3tz9YReBvqcMDdQA==
X-Google-Smtp-Source: AMrXdXvSPx43BorZHVkyiUnmAzJzGL1p82hYUfox9RY15Fdm7ViTbM2ltazSaxSD+qOxQt7rNf59kg==
X-Received: by 2002:a05:6122:45d:b0:3c6:bdf4:695b with SMTP id f29-20020a056122045d00b003c6bdf4695bmr9378658vkk.5.1671494744542;
        Mon, 19 Dec 2022 16:05:44 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id o70-20020a374149000000b006e702033b15sm7721430qka.66.2022.12.19.16.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:05:44 -0800 (PST)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     "Cormier, Jonathan" <jcormier@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: [PATCH v2 2/4] hwmon: ltc2945: Add devicetree match table
Date:   Mon, 19 Dec 2022 19:04:55 -0500
Message-Id: <20221220000457.1163446-3-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220000457.1163446-1-jcormier@criticallink.com>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com>
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

Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
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
