Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C315685F39
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjBAFsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjBAFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:48:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0D3166E5;
        Tue, 31 Jan 2023 21:48:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so2638361pjq.1;
        Tue, 31 Jan 2023 21:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2feaPTiFf6nFchWNFm62ii1folwFLguTnGsIZ0OJssw=;
        b=YMpzAQ8fSIRxXawrqIgaOXYDEBG33SRSWpmrJnMmSK2OmQZgwHGwnRbudSsCj+yyxr
         3rTv0zv0BkaTn18vomuhgoyWeFUmoeWGkQoBuUTf3erEAD98ucoD0r20wrTQSffGrGIW
         qaR+uoKXBbLnFh7MGh7cIhqvQkPtLpkhzHv0VqK9lBQMS01ESJ5UZv9v7xu/eWFgmHZJ
         rRrcPK4aZFTZbbQnoRXpPqVXPinXGowI1lPB3lxXcfDvE41gKH5hfQXejCqquluqsBEJ
         Xc8J4DtqgF76zAOle7igHctSN7wHKCEfBQoz86Onk68CZW/sO5F9AwF030MvmWVJWF/z
         8XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2feaPTiFf6nFchWNFm62ii1folwFLguTnGsIZ0OJssw=;
        b=Px9bGtvh2qfHWksl7RpSKEaTyngELDTyLtwhNQdVhslko3I48CYYcoYribQsYu3ZU3
         FuRP+uXUhGktayKO/ipZjXySP9mt3Zzp58HEhTR7jsa/9Fq7fYuDO3U+ZNMyyOD3Xiah
         kvFhznMxlWLF+Cw1IdrbH48K7gjekIr19wJxJ4cjY38RI2bFGJZs9c4zw+MtVQK/xj59
         JaI5mOcNUHRg4lpwH9oIusMRkL5C3ADJE0ilXccFJANGRMZbvyN2Xw9UbLcjxyw6Kfk7
         YcJ09A8ttoYm7hVVROkmvBoLGmCLi1etCXEJuXLPvNJgbOlK8p5R3nP7P26/XCq44Eb1
         xsNA==
X-Gm-Message-State: AO0yUKVJZDIyjE+8r06wzyZozl9FtVu2FDO1G1CAzpVC2wNjPUPz8oqR
        bb86Kd7VxEhies9CQOWZ9Tk=
X-Google-Smtp-Source: AK7set9/DlMG+CPp/mVQehVhBkFrwmrOoHnW2npCWOboxIglzV+uSKWwQM1MOfN3MHrHHkOBv9jSFA==
X-Received: by 2002:a17:903:1111:b0:196:6ec4:52db with SMTP id n17-20020a170903111100b001966ec452dbmr1854428plh.51.1675230502394;
        Tue, 31 Jan 2023 21:48:22 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:ce3a:44de:62b3:7a4b])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709027b8200b00196025a34b9sm7461575pll.159.2023.01.31.21.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 21:48:21 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: rtc: moxart: use proper names for gpio properties
Date:   Tue, 31 Jan 2023 21:48:14 -0800
Message-Id: <20230201054815.4112632-2-dmitry.torokhov@gmail.com>
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

MOXA ART RTC driver has been switched to gpiod API and is now using
properly named properties for its gpios (with gpiolib implementing a
quirk to recognize legacy names). Change binding document to use
proper names as well.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/rtc/moxa,moxart-rtc.txt      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
index c9d3ac1477fe..1374df7bf9d6 100644
--- a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
@@ -3,15 +3,15 @@ MOXA ART real-time clock
 Required properties:
 
 - compatible : Should be "moxa,moxart-rtc"
-- gpio-rtc-sclk : RTC sclk gpio, with zero flags
-- gpio-rtc-data : RTC data gpio, with zero flags
-- gpio-rtc-reset : RTC reset gpio, with zero flags
+- rtc-sclk-gpios : RTC sclk gpio, with zero flags
+- rtc-data-gpios : RTC data gpio, with zero flags
+- rtc-reset-gpios : RTC reset gpio, with zero flags
 
 Example:
 
 	rtc: rtc {
 		compatible = "moxa,moxart-rtc";
-		gpio-rtc-sclk = <&gpio 5 0>;
-		gpio-rtc-data = <&gpio 6 0>;
-		gpio-rtc-reset = <&gpio 7 0>;
+		rtc-sclk-gpios = <&gpio 5 0>;
+		rtc-data-gpios = <&gpio 6 0>;
+		rtc-reset-gpios = <&gpio 7 0>;
 	};
-- 
2.39.1.456.gfc5497dd1b-goog

