Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE867FC28
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjA2BfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjA2Bez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:34:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D42227A7;
        Sat, 28 Jan 2023 17:34:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so7824280wmb.0;
        Sat, 28 Jan 2023 17:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM0qucXfvVQKhID/FnUOMltEKs8rxZzOAPjYUvwbaic=;
        b=c2y4WG3NAKhRDnoZCtb0LhLspsMfb7BhPNCSyhuDN8PtyRRjOSG3UYQHuty82opyEF
         wN5ow9JvF1IGNTvVWZ6/VOcSQ22Dd6fAa1pyFxQXEqAMFCntjOaJijiWxiOd9vUyzX2k
         iUIr0HXlL/1FwPeXNQ315OolktCjRYi1eoVNo58qmu12ZiaQTqNzq36EbHBcut1ctxXW
         RGISl+tyJs3vLQPHJC0GxsdG6Mo8EcfvheDH+ikKju3ZR68x5O8fA9SXBUi1cdbh47Q4
         XYtpHJ1gDOhqgS7+IY9FJMZk2Q661OYlJ0+GI2WtD1tqVkI7vTJpdR8BzYmV1AZoGdtx
         SWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM0qucXfvVQKhID/FnUOMltEKs8rxZzOAPjYUvwbaic=;
        b=p7Ia0cK/yZH2QHReeKcw+9XEYzX8Jy+K63FFNqb8AE9T2jHNhtQH5lQCLso/UeuRsv
         RajumN8mGlQ4IRKX/2ampwc8huazZQq1ysaa6I3n8wOWVysE0yNKzOE8YdqqN/8BDRcK
         fq+G99cSjNVny8j7BEvSCO/xEZaWrl4KKObcYx+3eeENl1TgTJrBKxRKSH49OT9PnLXa
         KXihszGcVOyGGxdozd20uB/o5rP76yjUPc1qjxHPGx5iLYaNPPtxyAxDEXtllYOD636g
         /aKLczhLHdlbFVp+n0J6w4R+hlhE5RoU5xmbr4xuDk206ROYudXLbPeZhmRFpYZxq1tj
         xMZg==
X-Gm-Message-State: AFqh2kqckW5gw9Wb9Bu8rgWJL7eqv6dUBsCRX6zKqbVUEQHKBsEmpNT5
        HTslwed33V7gNHd9OnqqwDgjykceQtw=
X-Google-Smtp-Source: AMrXdXtcfTfF8757XXTQ05Zqcx6IoSfu3Rpq0oy4KPBtmkV66FgUPcoBEUnL8Cosc8yIFU5WKZDzTg==
X-Received: by 2002:a05:600c:2d08:b0:3cf:7dc1:f424 with SMTP id x8-20020a05600c2d0800b003cf7dc1f424mr44150800wmf.3.1674956088325;
        Sat, 28 Jan 2023 17:34:48 -0800 (PST)
Received: from localhost.localdomain (143.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.143])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c434700b003dc3f195abesm5197132wme.39.2023.01.28.17.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 17:34:48 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] iio: pressure: Kconfig: Delete misleading I2C reference on bmp280 title
Date:   Sun, 29 Jan 2023 02:33:06 +0100
Message-Id: <aa005a85c1b3ca69ae9bfe24f30beed258f98f29.1674954271.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674954271.git.ang.iglesiasg@gmail.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
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

Title entry for BMP280 called the driver an I2C implementation, when the
driver supports both I2C and SPI.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index c9453389e4f7..cec4b429cd64 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -17,7 +17,7 @@ config ABP060MG
 	  will be called abp060mg.
 
 config BMP280
-	tristate "Bosch Sensortec BMP180/BMP280/BMP380 pressure sensor I2C driver"
+	tristate "Bosch Sensortec BMP180/BMP280/BMP380 pressure sensor driver"
 	depends on (I2C || SPI_MASTER)
 	select REGMAP
 	select BMP280_I2C if (I2C)
-- 
2.39.1

