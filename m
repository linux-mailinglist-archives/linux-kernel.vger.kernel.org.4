Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7F656B94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiL0OKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiL0OKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:10:21 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34792634A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:10:20 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-45f4aef92daso185846167b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vtremblay.dev; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EApaJZbtiRCSY4uygs5Rlzu9HPHHEB4jZB9tAo0e6I=;
        b=BjltkCtviHqS3n0Pjvv63ugJuASqRNBEBXVjsyPTuWS3BEwDjPaJr10VAvb/Ax1is9
         SJhT9y9sOg1jhesHJggPnPE9r3+oAnWHcZc+lJeNSBHHRRPfVKm4jtr55qCt+Co0NV8Y
         dLoDGYAySuIzh5Hgj8LoR8tnqvVVUTZ4I+s36twCLHt0nBZKHTY0BBvFkjzPjlrtsRdp
         cZfGMPbscoY8AL7KrxEcG7BdrpAIrUAuWGwOhE2FrbGhIwMKGBAOhAhaK3Y+EaTS4gs/
         GwO9kZsBbC1sBqyofZZRBSywsW4YLuhZbplyFnxRoOZ20u9tG6tBguV6Fe3kYQM2GzrT
         I60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EApaJZbtiRCSY4uygs5Rlzu9HPHHEB4jZB9tAo0e6I=;
        b=mGTj5PyasW30jJfjGrU5S4WDQBHvG3ilYEtGhwpsveuorxSNhFhXJZckgdTpEypi3S
         ic9W4vhGzTenyWk+vJqPcXQPGeQvfjREUpNJqD5x0fOfuf6Oc8HoHx47Zs7CDm4ZrSta
         j0hicUY7SmcyWVsB+PJxcxeDkhu0l4EdlenHRyYx6stxVso1zVmKR437UiyC/FqKPqYw
         9VS2PUrcoaszzg1gDuAPKDVqpuPfdwPo7SBfeJHqZvc/aMmY6R4FMRS461tZGW4Wt7Sb
         lsZPHbeGLlZZYFvsEC3j8V+E0CGh9ByCzJ3txGh3jsIVB/0R9sdEMfAEFQdOEEKQaxUQ
         +8JQ==
X-Gm-Message-State: AFqh2koMTgzrmtKFIfDJDDpx9ZSmc7Qu//1JqtRO2HVAjkla8SbbxVgb
        soUo8AB0bbloBTTKisQeTcct3g==
X-Google-Smtp-Source: AMrXdXsGQ+RhQl6x/polkwodi7pXI4ieohEoPNvGYrarJwmNZk0MOG0xq5IhtdzIv8rOc3rQNRJjCg==
X-Received: by 2002:a05:7500:3ece:b0:ea:de70:fc44 with SMTP id lj14-20020a0575003ece00b000eade70fc44mr1293646gab.31.1672150218750;
        Tue, 27 Dec 2022 06:10:18 -0800 (PST)
Received: from vtremblay.. (modemcable190.194-177-173.mc.videotron.ca. [173.177.194.190])
        by smtp.gmail.com with ESMTPSA id y18-20020a05620a25d200b006fc447eebe5sm9596531qko.27.2022.12.27.06.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:10:18 -0800 (PST)
From:   Vincent Tremblay <vincent@vtremblay.dev>
Cc:     vincent@vtremblay.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Marek Vasut <marex@denx.de>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spidev: Add Silicon Labs SI3210 device compatible
Date:   Tue, 27 Dec 2022 09:10:08 -0500
Message-Id: <20221227141011.111410-2-vincent@vtremblay.dev>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227141011.111410-1-vincent@vtremblay.dev>
References: <20221227141011.111410-1-vincent@vtremblay.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Silicon Labs SI3210 device.

Signed-off-by: Vincent Tremblay <vincent@vtremblay.dev>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 46f53ca03f8d..d8998d5e8483 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -703,6 +703,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "spi-petra" },
 	{ .name = "spi-authenta" },
 	{ .name = "em3581" },
+	{ .name = "si3210" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -730,6 +731,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
 	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
+	{ .compatible = "silabs,si3210", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.37.2

