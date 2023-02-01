Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3DE685F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjBAFtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjBAFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:48:27 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AC61A4B6;
        Tue, 31 Jan 2023 21:48:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso992453pjj.1;
        Tue, 31 Jan 2023 21:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHMEwx5DpAADNj0aeVoFdx46vZBaLLK3nsLX9ugqjV0=;
        b=hhIbgJ5zhQunawb5Bl72W2gs9ckvnnog5fFrNBFVZU5xthmVvUioqOvfB9itiLJosf
         Ui8A9WDQD/wc7osP3mifVMwf9vHUSRUw56ZWGxkmPnoz6DtNWvFD9MpfLOBMWp2DA4nV
         YUNs6i1IWg7+Lk9DN7N3iPyRCG5hqN9msCf28DxD0fW2KQA5vD6b61UlaHwZ/ULDFwRo
         Fs6LIKbQ0T0rf9e78LGVpXFqXEjmVPm321XOFgTnW3CAnwcTzcj81HjV50dLtZEH+iZa
         rDbT66ZJZKri7ncs1G7jug5XIssUoAnMIMOjQ8/1wH0346UExHr1i/7Fbu3+Iwj5tkC2
         wkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHMEwx5DpAADNj0aeVoFdx46vZBaLLK3nsLX9ugqjV0=;
        b=wmhgG+c5sDH5LGG7GFcsKpvYueLDcBGQCRQjYcFC8w3cHDqXS8SeUEDE6M1KWbegjc
         cLbkFLcWeiKEEYN3c4emJura6nNHM9h18kYOzAi9QpYag0VKLWli5+sPpxvuTkikVKJu
         Cj+9U/VqcCDqmihxPSDxI12DL352bVPu3hbYHtIBURlaVVlWQYNU51L8RVGGWCqNQ0qr
         mHldvZo6Tf15tLoY/GW640RA4JirxUjJfdkygwmTIC5i0n7aCGdcmD6CzZhtJ3q3w5B7
         6SsayiB0ks9oEKHdZRJr2xaCJhQlfiklZcFeMHe7fPvWbAMhl2xboeAHFqQEq4dmukG0
         4tew==
X-Gm-Message-State: AO0yUKUCtGTPT1B3C+EFDiGcQ3vAoN78Io/PbcrFQnrDgLNOjN0YiHak
        w7Wha8CUyDK/tHnZRHmdxsKuNphQ4EQ=
X-Google-Smtp-Source: AK7set8aYqlBrLc5gOPVDCORD1xQltDDEDG+ZVQMeRIHy3czWOR2/R4tqJWnDUpEyrr8d9fTlQrtuA==
X-Received: by 2002:a17:902:d48b:b0:194:5c63:3638 with SMTP id c11-20020a170902d48b00b001945c633638mr1783199plg.61.1675230504356;
        Tue, 31 Jan 2023 21:48:24 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:ce3a:44de:62b3:7a4b])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709027b8200b00196025a34b9sm7461575pll.159.2023.01.31.21.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 21:48:23 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: moxart: switch to proper names for RTC GPIOs
Date:   Tue, 31 Jan 2023 21:48:15 -0800
Message-Id: <20230201054815.4112632-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
References: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
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

Update DTS to use proper names for RTC GPIOs. While the driver/gpiolib
will still recognize the old variants of names, there is no reason why
we should not update DTS that is present in the kernel.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/moxart.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index 11cbea5b94d2..622742956b2b 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -74,9 +74,9 @@ gpio: gpio@98700000 {
 
 		rtc: rtc {
 			compatible = "moxa,moxart-rtc";
-			gpio-rtc-sclk = <&gpio 5 0>;
-			gpio-rtc-data = <&gpio 6 0>;
-			gpio-rtc-reset = <&gpio 7 0>;
+			rtc-sclk-gpios = <&gpio 5 0>;
+			rtc-data-gpios = <&gpio 6 0>;
+			rtc-reset-gpios = <&gpio 7 0>;
 		};
 
 		dma: dma@90500000 {
-- 
2.39.1.456.gfc5497dd1b-goog

