Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B09674564
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjASWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjASWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:01:15 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7066FF89
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:39:37 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id h10so2463881qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV9OZ3zFtkDLpf/Q73kAo3k3wQt+efvU2HfxDW5J4xU=;
        b=kz0ICmRjeaxis1CYzfaXRho4F72emDWp9/L3clEhmPqjdhbGbB5XIeMKlYo9btykB3
         zGzlOVNVou7LgZyhrrgR0ZHyr9lVCkwtFbqGxa6kKdDdTWPYdpnFT2YhpsG2LiW/FOAq
         WZd5mS8N2eaC+pQ4qcUiWy9CMd6Jq5apRPRSr81Mzasf138XZil/KWNqR592FiNr40iM
         nsIgSVI1CLl6sEXJk+XnOvX+MsiSGDYouaR1WwAj5U5xNYzTeK0dOt1mzQgMv3jT5KCM
         MJKGSLu5j1Fo1FsGUP2KK6PODs+RdS6Fmmi205mXcwZTx2JwcQhHM8iu5SbenaD/BduX
         UO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LV9OZ3zFtkDLpf/Q73kAo3k3wQt+efvU2HfxDW5J4xU=;
        b=a1kmv991khoKaZZbiLe9uLDt7j/3gQ5HpoemiSDFwAtW64EtWEdb6oiPsMdgzQTqBc
         vDJkcT5Isw7uh2yVtekbClvFDw/hLQKQfiifI4/hSyPXzoxl8gmHdnpSkbjqRVKGh51G
         1XLSUMtvsARL5bOBKRboHrSP19kKJe2+zyeP6+uCkyjNAF3QsE/LSPxqS/KTOpzcROB7
         5s75jdFDj0NJvzI6RtsVJDaJT4ApM5hdnuIGPrxjyo1hEfVOC2OrfJKVbUfJaaJJvSTf
         +YIktj0YWZNTUOh4nSskPBfZlFJ1mdtGGybhyd0wdt3JiouBHArpFTnqpy8KdslfWmAn
         vMrw==
X-Gm-Message-State: AFqh2kpD137EgPxiP6Szsh5pFJHI3uKGFQGSxZtJbvJTu1ffY0Xw3uT1
        LRV4FyAfaG5wwG/biICbQc7wpQ==
X-Google-Smtp-Source: AMrXdXtb5Ys7U4vEwZn2MJGVTLV/Z41jZFry7umz0eWRnZoQ4kwzNYiVTdYkHv2tq+ujtfAqvxVwLw==
X-Received: by 2002:a05:6214:5d8d:b0:531:e636:e236 with SMTP id mf13-20020a0562145d8d00b00531e636e236mr16867754qvb.28.1674164371726;
        Thu, 19 Jan 2023 13:39:31 -0800 (PST)
Received: from localhost.localdomain (c-66-31-16-167.hsd1.ma.comcast.net. [66.31.16.167])
        by smtp.gmail.com with ESMTPSA id l13-20020a05620a28cd00b0070531c5d655sm2600676qkp.90.2023.01.19.13.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:39:31 -0800 (PST)
From:   Dennis Lambe Jr <dennis@sparkcharge.io>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Cc:     =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Dennis Lambe Jr <dennis@sparkcharge.io>
Subject: [PATCH v3 1/3] rtc: m41t80: probe: use IS_ENABLED for CONFIG_OF
Date:   Thu, 19 Jan 2023 21:39:01 +0000
Message-Id: <20230119213903.899756-2-dennis@sparkcharge.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119213903.899756-1-dennis@sparkcharge.io>
References: <20230119213903.899756-1-dennis@sparkcharge.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The style guide recommends IS_ENABLED rather than ifdef for wrapping
conditional code wherever possible.

Functions that are only called on DeviceTree platforms would otherwise
need to be cluttered up with __maybe_unused, which is especially
undesirable if there's nothing inherently DT-specific about those
functions.

Signed-off-by: Dennis Lambe Jr <dennis@sparkcharge.io>
---

Notes:
    v1 -> v2: spelling fix in changelog

 drivers/rtc/rtc-m41t80.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 494052dbd39f..f963b76e5fc0 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -909,10 +909,11 @@ static int m41t80_probe(struct i2c_client *client)
 	if (IS_ERR(m41t80_data->rtc))
 		return PTR_ERR(m41t80_data->rtc);
 
-#ifdef CONFIG_OF
-	wakeup_source = of_property_read_bool(client->dev.of_node,
-					      "wakeup-source");
-#endif
+	if (IS_ENABLED(CONFIG_OF)) {
+		wakeup_source = of_property_read_bool(client->dev.of_node,
+						      "wakeup-source");
+	}
+
 	if (client->irq > 0) {
 		rc = devm_request_threaded_irq(&client->dev, client->irq,
 					       NULL, m41t80_handle_irq,
-- 
2.25.1

