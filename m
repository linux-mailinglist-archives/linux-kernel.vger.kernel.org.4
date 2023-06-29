Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDDD742121
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjF2HfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjF2He1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:34:27 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5102935B6;
        Thu, 29 Jun 2023 00:34:26 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so422764a12.3;
        Thu, 29 Jun 2023 00:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688024065; x=1690616065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6T7r24ENI7G0wksSZQkaqpDe3IM+chAS5vheCtgJd8=;
        b=M7/vyQ9o8V2hXekjQCQ2oyjvLFUp1l223pq4TUt6wn3xF5qp13pj70BzYrEfSpTwKL
         rs5vnb6Tr2W8y5+2g2OayC3/5MpjH/3pYr2KMqzfhYtuvKRIp+4XGWyiu3z88awuF7Zc
         mVUmEbajeXwo0gV5XIN7wnnFNS3eZ5EchU82YzVAPnjC1UW0DoSVXtf1skDuXoqvDJJY
         vlgzf6LTFTkoh0UZmfa1ChUMKe1cyFS8XRvO5Tc9vK03Si2K2fQXVKvXeOIqBq4v3Ncc
         PrjTkKTXm1xz+pByhOdaeGE9sPy/mYvX5gYW0TKDeA6V6IVY0M4S7SkyIj2vWHWbfSV+
         17+A==
X-Gm-Message-State: ABy/qLaLqfKuHBiiCLBOs2O86wBMOgCRVEaAaQtFApFzVHA04Zc8DEGs
        QVj/NEPQvVLbzkwbaYhtH9U=
X-Google-Smtp-Source: APBJJlFk8i9NeMAgJv7UPq36pyJkMY0ql2BNqaQJs8WwVB9P4KcwdXVQm0eEZEGpoia2vi3M14jaUA==
X-Received: by 2002:aa7:c2d9:0:b0:51d:d5f2:121c with SMTP id m25-20020aa7c2d9000000b0051dd5f2121cmr1291170edp.5.1688024064797;
        Thu, 29 Jun 2023 00:34:24 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0051bfb7de166sm5453716edb.39.2023.06.29.00.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:34:24 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH v7 3/4] tty: serial: meson: Add a earlycon for the T7 SoC
Date:   Thu, 29 Jun 2023 08:34:18 +0100
Message-ID: <20230629073419.207886-4-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629073419.207886-1-tanure@linux.com>
References: <20230629073419.207886-1-tanure@linux.com>
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

The new Amlogic T7 SoC does not have a always-on uart,
so add OF_EARLYCON_DECLARE for it.

Signed-off-by: Lucas Tanure <tanure@linux.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/tty/serial/meson_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 2501db5a7aaf..c24e105a98c5 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -649,6 +649,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt

 OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		    meson_serial_early_console_setup);
+OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
+		    meson_serial_early_console_setup);

 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
--
2.41.0

