Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C7F69FD74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjBVVFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjBVVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:05:27 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF96F460BD;
        Wed, 22 Feb 2023 13:04:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o12so36194464edb.9;
        Wed, 22 Feb 2023 13:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Nq3dzuM0wiV9YMJ/Hk2mSZsANQ6TIPxxTMSVQHPo70=;
        b=TWPmsWEFjsNN4j2Yh8ZCvcl2OCl492GceDA3d6FDXQee/glFHFSD9sb4nRDXS2TPag
         PCbIfhmEWMb2xI9iBATS+tAzWWPeimyQNj/IKESD4/M4TqXUgcMc/bmuT2KIKAkL75Fb
         WRdewXvOKPHgRuZVVaI/d/fIZ1iHEhLbVCv6hvsbz+n3G5B6dhGqLMsEOrjjkDc319pr
         cVDiwNcZm654jVMpmV8wjv3QrDcJFNg/CMUlifLiPxJdWMMg2fbCoSLNlHaSFDSzbHCR
         7RDWM0Yu+z7Kai3U6jH/a/3POr9XIKw/VnlOStAdN5sBc741+e0tp05iejYWAS03q9Nq
         AcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Nq3dzuM0wiV9YMJ/Hk2mSZsANQ6TIPxxTMSVQHPo70=;
        b=kgyFX8iV424pZ4FJq4R1sRrYkBkoq58zRfkat6e1NfJT/TFNfB67L5kHZPw9x4NosP
         V5HUGc9cRluYHh1nZ0wcbtDlh2oJhN4b0oarWHh3NlWPhZ4yBrPzmCCSh3niMxhUploS
         BSNaAx+6imAttfHbwFydkoDTLzol8rgMfESmJQVz5QOq/0zp0cl8rEbkHIlbhZ8IPIlq
         CtLAU0TWPklc38eEcwZe666drcOVA3Xr7tf0mjX46Ro9MNUHOq8VxJn1Ifm22W/TvyHe
         BZv6djXCKUFzm5jH81t7lKTbqJvjswNEnc7e8eFSzCWQ9KM/BVCaXhgFr6LhoHPGfUDQ
         RJ/A==
X-Gm-Message-State: AO0yUKVfG+A7J/jXyAz5siV1OHp4cHDoJk4eRz65JqR84nLHQQS33n0T
        bz9fika29DS2fB3o2+tDc/6YiItych9Tkw==
X-Google-Smtp-Source: AK7set/Pb9SC42yyGyM/okGUSygtWrCURlJ590lWGkYU/8O1YPoP2Jil0ZxAhQvIGGGCwK8dXhMGOQ==
X-Received: by 2002:a05:6402:4007:b0:4ae:eab6:a07b with SMTP id d7-20020a056402400700b004aeeab6a07bmr11290888eda.16.1677099881755;
        Wed, 22 Feb 2023 13:04:41 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-76c9-eb00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:76c9:eb00::e63])
        by smtp.googlemail.com with ESMTPSA id m17-20020a50c191000000b004af6a840f21sm209208edf.15.2023.02.22.13.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 13:04:41 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 RFC 2/3] tty: serial: meson: Add a new compatible string for the G12A SoC
Date:   Wed, 22 Feb 2023 22:04:24 +0100
Message-Id: <20230222210425.626474-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222210425.626474-1-martin.blumenstingl@googlemail.com>
References: <20230222210425.626474-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson G12A (and later) SoCs also have the "divide XTAL by 2" bit
as the S4 UART controllers. Add a new compatible string for these SoCs
and enable the has_xtal_div2 flag for them.

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/tty/serial/meson_uart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 74110017988a..2501db5a7aaf 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -779,7 +779,7 @@ static int meson_uart_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct meson_uart_data s4_uart_data = {
+static struct meson_uart_data meson_g12a_uart_data = {
 	.has_xtal_div2 = true,
 };
 
@@ -788,9 +788,13 @@ static const struct of_device_id meson_uart_dt_match[] = {
 	{ .compatible = "amlogic,meson8-uart" },
 	{ .compatible = "amlogic,meson8b-uart" },
 	{ .compatible = "amlogic,meson-gx-uart" },
+	{
+		.compatible = "amlogic,meson-g12a-uart",
+		.data = (void *)&meson_g12a_uart_data,
+	},
 	{
 		.compatible = "amlogic,meson-s4-uart",
-		.data = (void *)&s4_uart_data,
+		.data = (void *)&meson_g12a_uart_data,
 	},
 	{ /* sentinel */ },
 };
-- 
2.39.2

