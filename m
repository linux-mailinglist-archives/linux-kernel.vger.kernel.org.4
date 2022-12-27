Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F533657041
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 23:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiL0Wjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 17:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiL0Wjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 17:39:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F482195;
        Tue, 27 Dec 2022 14:39:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y8so13500761wrl.13;
        Tue, 27 Dec 2022 14:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq2Gpt1I0Xi+5bwKdazv9Q7izhR4qPVICvO2Klgy1FM=;
        b=XIQIGt7MsMGJjoCGtAm/0GlCyvgYQzq502eUTB0k6slIUVwSiBuXWN9+x3D+3SNp58
         JGCRaeHaQckLiQ5r0dfxChgxOsC3vrpX+eyk1xUJfui+chTSLarc65oreQcFjRTP9mCu
         UBEH8oWGl72MUWFmOWFb9/uXwY0OnlTRyjFUeb0cix/GxmHcWYQbBMRf6rG5eQRM6aND
         eWeHCNqstKoXpVjz5d5gSYeduejBe/h281ZnGF2/hGqI4MkUf9JCmigoP9/z0J1MHzop
         I3CAtEjbMdnSXfml6ZozY+SKitR89xvdDo31gjownD5Gz+3e3QPkRMuu3SVW/2XtK7fG
         HkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq2Gpt1I0Xi+5bwKdazv9Q7izhR4qPVICvO2Klgy1FM=;
        b=k0LTLvWOaEqS84lXvUMxfiWTG2f52oNoNfKAzufWvIU0cP3Jqp0hh2BDPaItHFaPRc
         a1DoS2bkziMtLxUzOY1DV0dDzTuGHG20ZT4P1VNhU431mgy0dckccl8kLoucILvprqeR
         kHpaKc9sAqsDZsWeauietHe4JCajJM4lL4dndkoaaMEx2bwJDTgdNViAVHNnVHGOIGzo
         xLZH/5jKiSQwdynWVvODHoLr2QTZRbYkY4tca6VSvLe80xX7O0R644hvGUaXop13bInj
         2NkKk/Gj5DurKt0NHsC5DgYJpOtzhpCmOQrb1jPiFjDLfL1NfmlFV/IVctJ3baNKm1vH
         xVhA==
X-Gm-Message-State: AFqh2kou7fB2qxVOaJgrTqOUTcGJRiSK8JN8ARrmWXLEPZRRRmjOQHn2
        upQuUQ5cXkjuREzqukamOGV9WEhP7kGeQqDEJRU=
X-Google-Smtp-Source: AMrXdXum+TGXQlUSSlj4R0Jbn6rhSvLAf5+ZKn/cW33IIzSUF61sqoKrpcpQFWE6JNe7Q4eUHkMc3Q==
X-Received: by 2002:a5d:6250:0:b0:268:885:bd87 with SMTP id m16-20020a5d6250000000b002680885bd87mr14072848wrv.37.1672180779822;
        Tue, 27 Dec 2022 14:39:39 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm13739132wrq.10.2022.12.27.14.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 14:39:39 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org, "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] ARM: dts: n900: switch accelerometer to iio driver
Date:   Wed, 28 Dec 2022 00:38:41 +0200
Message-Id: <20221227223841.2990847-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221227223841.2990847-1-absicsz@gmail.com>
References: <20221227223841.2990847-1-absicsz@gmail.com>
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

Since 8a7449d68670a8f9033d57b9e7997af77a900d53, lis302dl is supported by an iio
driver. Make the switch, to accommodate modern userspace, even though the iio
interface lacks some of the extended features of the older driver

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 53 +++++---------------------------
 1 file changed, 8 insertions(+), 45 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6ba2e8f81973..94fa1d492fb4 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -767,56 +767,19 @@ &i2c3 {
 
 	clock-frequency = <400000>;
 
-	lis302dl: lis3lv02d@1d {
-		compatible = "st,lis3lv02d";
+	lis302dl: lis302dl@1d {
+		compatible = "st,lis302dl";
 		reg = <0x1d>;
 
-		Vdd-supply = <&vaux1>;
-		Vdd_IO-supply = <&vio>;
+		vdd-supply = <&vaux1>;
+		vddio-supply = <&vio>;
 
 		interrupt-parent = <&gpio6>;
-		interrupts = <21 20>; /* 181 and 180 */
-
-		/* click flags */
-		st,click-single-x;
-		st,click-single-y;
-		st,click-single-z;
-
-		/* Limits are 0.5g * value */
-		st,click-threshold-x = <8>;
-		st,click-threshold-y = <8>;
-		st,click-threshold-z = <10>;
-
-		/* Click must be longer than time limit */
-		st,click-time-limit = <9>;
-
-		/* Kind of debounce filter */
-		st,click-latency = <50>;
-
-		/* Interrupt line 2 for click detection */
-		st,irq2-click;
-
-		st,wakeup-x-hi;
-		st,wakeup-y-hi;
-		st,wakeup-threshold = <(800/18)>; /* millig-value / 18 to get HW values */
-
-		st,wakeup2-z-hi;
-		st,wakeup2-threshold = <(900/18)>; /* millig-value / 18 to get HW values */
-
-		st,hipass1-disable;
-		st,hipass2-disable;
-
-		st,axis-x = <1>;    /* LIS3_DEV_X */
-		st,axis-y = <(-2)>; /* LIS3_INV_DEV_Y */
-		st,axis-z = <(-3)>; /* LIS3_INV_DEV_Z */
-
-		st,min-limit-x = <(-32)>;
-		st,min-limit-y = <3>;
-		st,min-limit-z = <3>;
+		interrupts = <21 IRQ_TYPE_EDGE_RISING>, <20 IRQ_TYPE_EDGE_RISING>; /* 181 and 180 */
 
-		st,max-limit-x = <(-3)>;
-		st,max-limit-y = <32>;
-		st,max-limit-z = <32>;
+		mount-matrix =	 "-1",  "0",  "0",
+				  "0",  "1",  "0",
+				  "0",  "0",  "1";
 	};
 
 	cam1: camera@3e {
-- 
2.39.0

