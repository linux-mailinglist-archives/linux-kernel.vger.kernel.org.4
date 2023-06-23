Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9376C73B26E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFWIM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjFWIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:12:49 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141822100;
        Fri, 23 Jun 2023 01:12:49 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f883420152so338952e87.1;
        Fri, 23 Jun 2023 01:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687507967; x=1690099967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upg0hHPusTHNHHtpH4yxVwhsX5Py4GST1osQ8SxWcwo=;
        b=WkZ4EtRE5oIGZ0UAW7i41wEJDd2nDbYwof3x1fTNyR0YtwGstC7C5+EjHCbgT79RvS
         HCnD0O+c0LSNrvsD/khHiN4b/coOBmtrOxOQgldveyl8jcyNW8ewDwWaHNawKJ/3+Nl7
         YHUc2YWbfypmATwWnJeKWaeTW51+cbEgJ5Mp1cW9mhlwI/C+BfrBmbJ1hr5NvbZQLTVQ
         IC8GNUjqcfxrbgP1E75hueQzPZlEjMa8mNoHZ5sigmT2kv1HY30wya29eBBmr4MIHgUv
         SZcxBVc8S2hgoPop57LbjmYiVc51eZUtCfGpM7TaSW8U9WWp8iLxrrEQ89ow8lhdab7B
         8bsQ==
X-Gm-Message-State: AC+VfDyXABVHC0Yku0+D5JBDzyh1AUkgg8s12hfPCWdHOO0+5+XQyobs
        eXXbT8nYpM6ixQG4M1NTj0w=
X-Google-Smtp-Source: ACHHUZ5e7jJXR6du4xziaPnDR4mPvThK3pjT/SA1z9xUsBWSRcruANHFzNte7v3kqfjF7i3BLtOuwQ==
X-Received: by 2002:a19:7912:0:b0:4f4:dfd4:33e4 with SMTP id u18-20020a197912000000b004f4dfd433e4mr11028306lfc.51.1687507967132;
        Fri, 23 Jun 2023 01:12:47 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id l21-20020a7bc455000000b003f9b29ba838sm1594141wmi.35.2023.06.23.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:12:46 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH v5 3/4] tty: serial: meson: Add a earlycon for the T7 SoC
Date:   Fri, 23 Jun 2023 09:12:41 +0100
Message-ID: <20230623081242.109131-4-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623081242.109131-1-tanure@linux.com>
References: <20230623081242.109131-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Amlogic Meson T7 SoC does not have a always-on
uart, so add OF_EARLYCON_DECLARE for it.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/tty/serial/meson_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 2501db5a7aaf..84d33903038a 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -649,6 +649,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
 
 OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		    meson_serial_early_console_setup);
+OF_EARLYCON_DECLARE(meson, "amlogic,meson-t7-uart",
+		    meson_serial_early_console_setup);
 
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
-- 
2.41.0

