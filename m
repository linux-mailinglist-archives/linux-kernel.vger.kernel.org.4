Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31F16339E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiKVKXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiKVKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:22:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B68943867
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso925936wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBSJ9X9pr9Z0i2+NFcnle+eN9VzlxNW46WoYTtGtQAo=;
        b=cNOOrBVDDBxp8Mc+etJ2bnstzSg1Lzp5SAUFfR5Ck/B28wVrN1R9+kJTGe4UPeXN20
         Zu1NxMwctssO70t4AhcPojH9Lpd/OtIVYxCP/o9t4g/osQ4RmxjOUk8kIaLIBQF2LTGI
         DzyLxy/b76Ry0jdaUUPWKo3Nfe1MipiYEfkSOr7cffF2StDF4vuszG4StaL+rdKN7ywA
         ltZaddUhWCDNpCdOEbMKnGmEWn6OQRtY2/yxSTsppKMnfHg3nLC+8DDm6ndI2qqMhwwL
         xEmt7dQflPtTlvn2Rhwr3DlFu+HeFd9HeWUU16GLiORzmPYaUnclQePBH3oRJ6LrsvBj
         OVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBSJ9X9pr9Z0i2+NFcnle+eN9VzlxNW46WoYTtGtQAo=;
        b=jaW4ph6Ng3V1kRpkUbnIdnInVxvlwea/hAU0B1nfAbisHxMPvfAvXZbeZmJZYhAOid
         6ECmmFBFqcs8f8mA400CCBGejtcPNBA1Pidr0ZA16qsSnCMILeH0u4RStFxf8jNQ1rMl
         igORs5gavNUnlUhX1UIrly0Zs0nC/TLdy7e8FVLKbQCXfjBe2oU6AjshUtTENbmWr28C
         eaBnHziUvL9x3l3JzfBw8FWlzYBpFMtYpV9k4IJ2E6BJzYQO4FXP87LazqI6gcp+A8H6
         oKLAStg+vTV9/99A49KlLZSha7Z+PGtQ/qI7pVSRAMGG5P6PSIMbRKOpMluzPboTRrDS
         Ng3w==
X-Gm-Message-State: ANoB5plON4Tr8f4/SwpTGGUTujTAaQ34qtZdoWNJHlgR1ayBYNLDiXYM
        vernXCuxelKh6JZN6Ocq13WnRLmEdvdScA==
X-Google-Smtp-Source: AA0mqf6hZkdlXyqPZJiyPnxJlhWvw7hy1el3QF7vnCcy3ErQ04FPrEZZTgfw8fLc6lEPvbo9gfIwxg==
X-Received: by 2002:a05:600c:384f:b0:3cf:9377:c76f with SMTP id s15-20020a05600c384f00b003cf9377c76fmr3817135wmr.189.1669112511702;
        Tue, 22 Nov 2022 02:21:51 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 11/15] tty: serial: qcom-geni-serial: stop operations in progress at shutdown
Date:   Tue, 22 Nov 2022 11:21:21 +0100
Message-Id: <20221122102125.142075-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We don't stop transmissions in progress at shutdown. This is fine with
FIFO SE mode but with DMA it causes trouble so fix it now.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 036231106321..82242a40a95a 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -865,6 +865,9 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
 
 static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
+	qcom_geni_serial_stop_tx(uport);
+	qcom_geni_serial_stop_rx(uport);
+
 	disable_irq(uport->irq);
 }
 
-- 
2.37.2

