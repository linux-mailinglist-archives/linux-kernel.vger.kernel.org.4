Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21F63C4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiK2QJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiK2QJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:09:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8643D421A0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:09:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o5so13866530wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmPa+knot3YDUCqalKlJVkyrJNSYU8WAPL5glC3+iuk=;
        b=ZR/e5pS570KyGvQv04N6X9arFtmhgwl0szN5vI4tZCuQSQxBEpD+6qULAwEjfrIg5D
         TjLNRm4euqGS/fYinUVcO9/YXTWmM9cgZslsvJVUDfYGnVm1uI1UH7nMy8DRyBJ731l8
         WIc3osWkfQc9A8RSPastAAm/TyY8FpZEBT9AL0feSGz53BL2Z7Qv6uOyN/3lXnh8UEff
         RGTCP3YP+XdUcZ8Vu5TVPbtTzWXvGtjEmu24tSKkN2T2b5DBxrTtGvMFtzUwSEWaCRQ1
         ZuSWXw5XfRItkJXD3vm0bzAxuAVGvKlp+LjljobejF7oVIgeTHFDsgmgXliEnPMAawaw
         5iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmPa+knot3YDUCqalKlJVkyrJNSYU8WAPL5glC3+iuk=;
        b=6gOWzzGXjQi4AV1TlAMyqVLGz2/teMSJLiuR7mvNThybBWvVowAAWlkH9SapxwoNyY
         5cQnmSmow4SYx97/Ys7sjJj3TYZ0lhrlFfRFFOvDRiwgVnfQD/vR/1mBVudAl08YoKXO
         Ao/FwDmkF2FcLa6KhvcUm4Hp86JAGVIoPuCe69tHuQmEjLFL+kMsgojJZ0Vjs0czsNtk
         DFYoWmyDvI774BCSjRHiLAHIf4JNVLOaCtLwuw7SXFFn6tWGHX6N01L9UdN383Y+Z4if
         lVyD9vSx8BTkoTLa1w6XTWKnKnz4BwZ9slyBlx2DwmxqDHY7tffDovRpCk6COX6z+afG
         XW4Q==
X-Gm-Message-State: ANoB5pkWbPjIaqlA2OjaOjgk/iEYZRzkF44bjRtvKKxHR8bK65+PAxSb
        Cbf1MsoxrgcCn9OGWIh3On2Q/XB/Je2upxag
X-Google-Smtp-Source: AA0mqf6GT0U9KltCoqCWDhICfkfaOnk7CZjLe1EfWefra9rd5OFohyhEJH+BDYtkQYFcsqhz2kT1mQ==
X-Received: by 2002:adf:fdc7:0:b0:241:d7ab:db8f with SMTP id i7-20020adffdc7000000b00241d7abdb8fmr26276019wrs.285.1669738177108;
        Tue, 29 Nov 2022 08:09:37 -0800 (PST)
Received: from mpfj-unity.. ([94.12.112.226])
        by smtp.gmail.com with ESMTPSA id y18-20020a05600c365200b003c6c5a5a651sm2477572wmq.28.2022.11.29.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 08:09:36 -0800 (PST)
From:   Mark Jackson <mpfj@newflow.co.uk>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: am335x-nano: Fix GPIO settings for MMC pins
Date:   Tue, 29 Nov 2022 16:08:17 +0000
Message-Id: <20221129160818.276696-5-mpfj@newflow.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129160818.276696-1-mpfj@newflow.co.uk>
References: <20221129160818.276696-1-mpfj@newflow.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMC slot uses GPIO pins for Write Protext and Card Detect.
Define these so everything works correctly.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/boot/dts/am335x-nano.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 960ef1384bbe..58062cec39c0 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -418,8 +418,9 @@ &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	bus-width = <4>;
-	cd-gpios = <&gpio3 8 0>;
-	wp-gpios = <&gpio3 18 0>;
+	cd-debounce-delay-ms = <5>;
+	cd-gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
 };
 
 #include "tps65217.dtsi"
-- 
2.34.1

