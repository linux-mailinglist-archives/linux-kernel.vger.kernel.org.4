Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71AD6807CE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjA3Is6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjA3Isu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:48:50 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C66812585;
        Mon, 30 Jan 2023 00:48:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j5so10436939pjn.5;
        Mon, 30 Jan 2023 00:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unCcttXWXEyPBVOHC739lbFOm1ITKrqNz2Z3vNi3kfs=;
        b=qwNhEVCCmT3XrxwFDJjMtFFSoDFcrvAYPFEqvwk5MgKlAP9PMilB2KgW1wj8Gl7d1x
         IzuJauKvyAmtgtOtWDqf57HjfOJSK9IqxGfD6mo9pyY2wsd0n+lcq+zOEFwRHlIgBgKO
         BrY4c3oYmxGbbSK4utppVDEe5NhzetNxJP0bhjqwwGV+Bfol/lWdNmRjUzBmr8YVM7jG
         0niAJa6HZqhT1yV47y2nyWorFHyICis9xRCZfplEyeigo8SD92NAHLfCCNPoy/4gMPj3
         iSo57wFeeqapd+97hnUpu44EYAi47GV4NofKVk+nk1Gt0DCnEjlDRImSVt4xR2CDPiwo
         8i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unCcttXWXEyPBVOHC739lbFOm1ITKrqNz2Z3vNi3kfs=;
        b=3DqwYx7HpqXlzcZeYt74suF6jrQjlcYmZcqlWirPDcNJY0XivpsfjtHF9IOLqS2HTb
         gtYeDkuZJVtSlotdW6lInuHVx4fD8z7kmEs/67XvLDw/Ye6DcP+7Jn9wk8mkbVxa0iG9
         0CIbAzfn9/U/4IGlaFkmnFBe2mU9+rm6XWnijZzpwv39ic3Beg8ReQAASbL2ba1PfIkq
         JLiWg4vX/zF9Om6vN02DSCmgthp5g/EYieXdoKNghmxBKSvkPMdivXWCCXpcm0k6Q9h/
         4q8yPqZ8qINz+cMRXZhvHyhhbRJmVhMUiMa2sDBhqILDQkV7Rma8UHJAeMBI4ZQQjY2v
         BnWA==
X-Gm-Message-State: AO0yUKUyCOY+OUL9dXBTLFwQyjFiLzqmiNI7NOT4bNIp2SfKKd8PzQG5
        pAUErO5ErNqFBUaQsZAWAzY=
X-Google-Smtp-Source: AK7set+uLpUD2RiNQ13tofZZTlyItEtiLxY5qwZAWwYSGHsseTy0MdHNDrrht3UCeksMMtrpxBNBKQ==
X-Received: by 2002:a17:902:e88e:b0:196:3a54:8b23 with SMTP id w14-20020a170902e88e00b001963a548b23mr18673132plg.10.1675068490816;
        Mon, 30 Jan 2023 00:48:10 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id ix1-20020a170902f80100b00192d9258512sm7205284plb.154.2023.01.30.00.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 00:48:10 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v5 2/4] arm64: dts: amlogic: Drop superfluous dr_mode in usb node on odroid c2
Date:   Mon, 30 Jan 2023 08:47:41 +0000
Message-Id: <20230130084744.2539-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130084744.2539-1-linux.amoon@gmail.com>
References: <20230130084744.2539-1-linux.amoon@gmail.com>
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

Drop superfluous dr_mode="host" as it is the default in meson-gxbb.dtsi

Fixes: f24859bbec8a ("arm64: dts: amlogic: Used onboard usb hub reset on odroid c2")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v5: none
v4: neww patch
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 01356437a077..70b10934a811 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -399,7 +399,6 @@ &usb0 {
 };
 
 &usb1 {
-	dr_mode = "host";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-- 
2.38.1

