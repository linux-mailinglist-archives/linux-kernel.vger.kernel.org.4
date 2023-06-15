Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5473200E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbjFOSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjFOS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:29:49 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787CCA7;
        Thu, 15 Jun 2023 11:29:48 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so8061359f8f.1;
        Thu, 15 Jun 2023 11:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853787; x=1689445787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rljMIAz3eZzDzsPXsEwblV15FzZCxzBSB/L1bn8LJCA=;
        b=fO1Myd/HdZ+ggZT5dToJpZJEIKaFAs1TjwYz6WdTt9ObrDFrEVFtEPuGW0+Mnc/0q3
         1vOFhVlTmrb29s02wnJmcHuvoFYkPPWDxUs5JvFto8dVJ3gLQ4WUTfc2kLwFpSWtrjeH
         BcU9K827jCKiNR1E4A1Zm6GWPQCcAnd8lh+onP4+ODzIAK+iFbj9+34qvCbFA5fFZLOx
         Lb3fXhb39UyQowAttnTvksT/ZIp08zOF00q6VRPlSGdK3Qxb/HcRVFe4nN5QgoUlSGMb
         +eI9LxtzIj82+k2fvGfTAOBGWZ8gX8SeUw902BjHSbJNT1/RNWqujLTPJ47JPSHU/CJz
         Ti4Q==
X-Gm-Message-State: AC+VfDwH7Ce5t6QjBdKcum8roXZLmrrHob570CAsdtKIZ5YCkMTfbA98
        EG9e/k+CYTeg+qLQ4DUlvWs=
X-Google-Smtp-Source: ACHHUZ42fJgQgOrOKzgTBUo/P4dWEDA319DLseAkmLt8CW7hBygQiDkavmgcmQUbZq0mtu7H+NMyxw==
X-Received: by 2002:adf:eb92:0:b0:30a:e93e:82aa with SMTP id t18-20020adfeb92000000b0030ae93e82aamr11756161wrn.42.1686853786778;
        Thu, 15 Jun 2023 11:29:46 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm21525887wrr.46.2023.06.15.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 11:29:46 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH 5/6] tty: serial: meson: Added T7 SOC compatibility
Date:   Thu, 15 Jun 2023 19:29:37 +0100
Message-ID: <20230615182938.18487-6-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615182938.18487-1-tanure@linux.com>
References: <20230615182938.18487-1-tanure@linux.com>
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

Make UART driver compatible with T7 SOC UART.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/tty/serial/meson_uart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 2501db5a7aaf..0208f9a6ba7e 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -796,6 +796,10 @@ static const struct of_device_id meson_uart_dt_match[] = {
 		.compatible = "amlogic,meson-s4-uart",
 		.data = (void *)&meson_g12a_uart_data,
 	},
+	{
+		.compatible = "amlogic,meson-t7-uart",
+		.data = (void *)&meson_g12a_uart_data,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
--
2.41.0

