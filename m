Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38BB67E9EE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjA0PqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjA0Ppv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:45:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FF08625B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b7so5354057wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFVYW1O2xATTJriM1RmoRREy/G+c337SmUDoCitpzco=;
        b=491Ky8TrcAcsgeprw2ZEB8sgi6R/oZLzhKDU0+d3vG7v1nc6h3yA74RGbYkvWZUGx7
         Q0tkN7Dadn3um5AJed8e+Uxhes1ERabJDnCU7A/6BYpFnpWWdaXrjj6Il3p1I8VpHSkG
         GcA/06V6Xi9eNuaFlGDUTvJpxTr14Y8ACoeJpbQF/LNMv1Wf6ztmsMWEw5xZ+CFIsPM2
         kvhpuAsK+d+Qf4DWi8UDauaU6DtDoRIbhKjGCPvOGetFluXBsSa2quz3+OMoDtbDdLRE
         9m3F2z8NigSQc5pUGYdpfWr19F6Ur2lAMmbkHomvcHHW3zFYNsJTejBJ00gnD8XDdA2M
         n2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFVYW1O2xATTJriM1RmoRREy/G+c337SmUDoCitpzco=;
        b=e40M06c0jPS/3Jgcuz4RNsxUn9kyr8/Sg6mOrlQbk7NQmt0Avs4ZoxZP2DSRMKQn4B
         GFNYjpe24PW6f1Pemf3hLh08Lkuh+QQxCAsB/DwCAyadWCFEoe/qWNKHwJwjvcO5RohW
         myLtAU9s/IP3NJAIOe2EX51eu0m1LUwjXAReucm+NI7L5VRp7RlLvPDghiw8vLHngELL
         jQvQTY/3CSo5rDumEPT/639iTQ/G1Ktawa1ECllyMBXvTGY01yzMY0KT4yWOwo2bT39N
         EOF26jTGM2zaCL2L/dODVD3kg3egD1rk04dlj8PYiLUN9w7FP/3FFTpg7p/wZmo7m/Ao
         VmvA==
X-Gm-Message-State: AFqh2kqG4PBQfHC4h28xhWvq3kG/m+/s8MPN0WcfW8WpcI4BbyGb+no7
        anHln1XzzX6NejZnkw6INM+chw==
X-Google-Smtp-Source: AMrXdXtQHXWwiOsqOaUoE38vnif7eGDE3q2bHlH287lAZAfafj8qRbLU4OGjDi/NT1osbLuzBAwQdQ==
X-Received: by 2002:a5d:6e8b:0:b0:2bd:d9b5:8191 with SMTP id k11-20020a5d6e8b000000b002bdd9b58191mr35643805wrz.61.1674834318557;
        Fri, 27 Jan 2023 07:45:18 -0800 (PST)
Received: from [127.0.1.1] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.googlemail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm4381153wrp.53.2023.01.27.07.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:45:18 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 27 Jan 2023 16:44:45 +0100
Subject: [PATCH v9 4/5] thermal: mediatek: add callback for raw to mcelsius conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-up-i350-thermal-bringup-v9-4-55a1ae14af74@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Michael Kao <michael.kao@mediatek.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674834313; l=1727;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=oneS0GOcwyJu/jpresdHeaeVd8flLXASRISr19OSr48=;
 b=PnXR/TW2vh+td5o1N+8uUQCOh9ZzJAzZGpiVAX0YLZpxZwaJwd1lZr59Yb9Anlyb3xTwr21LnY1B
 TWBcJGy7ALBoVPKUNGYbCNIimiZR/rmYuY5AQNwYV5OoL/voXYml
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set a callback at probe time instead of checking the version at
each get_sensor_temp().

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mtk_thermal.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 3a5df1440822..b8e06f6c7c42 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -307,6 +307,8 @@ struct mtk_thermal {
 
 	const struct mtk_thermal_data *conf;
 	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
+
+	int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
 };
 
 /* MT8183 thermal sensor data */
@@ -726,13 +728,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
 		raw = readl(mt->thermal_base + conf->msr[i]);
 
-		if (mt->conf->version == MTK_THERMAL_V1) {
-			temp = raw_to_mcelsius_v1(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		} else {
-			temp = raw_to_mcelsius_v2(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		}
+		temp = mt->raw_to_mcelsius(mt, i, raw);
 
 		/*
 		 * The first read of a sensor often contains very high bogus
@@ -1150,6 +1146,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	mtk_thermal_turn_on_buffer(mt, apmixed_base);
 
+	mt->raw_to_mcelsius = (mt->conf->version == MTK_THERMAL_V1) ?
+				raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
+
 	if (mt->conf->version == MTK_THERMAL_V2) {
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}

-- 
2.39.1
