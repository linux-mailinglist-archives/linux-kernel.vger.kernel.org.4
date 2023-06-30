Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DB3743DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjF3Okn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjF3Okb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:40:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC83AB6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:40:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so3116722e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1688136028; x=1690728028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emMdYQhKSBWYyb26wPZv/mWPp2WHz1S9ZDQ86I2IF/0=;
        b=V72U2cWWwPSteJrPZUnc6PeVhllY9a4cS333XTdnQibxRO1sFyOZo2HNrnolEG+lzm
         JZ/aiIm0w31r6uG37XoLdwQQEeQmRSM8QCrmPSOw+VmpDRHE8AqrAlQ5laqN/Q60aZXq
         4Cp2NaeAH83ZHq+qUJv21ZDFhbhaJb6wtiUWm7ByU+KB/IkNT3NDwH5FoTkQUxFMB1y/
         B6eFcJmKqhHllR47OpQZ6GaWCBcNbxaD2/95ElymDhKerOgMeKwcefyAk6i8hVW9x8VC
         d9zb7WRETb2sOB8UzKQiydCKNb2qWBgm839uojgUO9K1pDq4P949qVu1nWTAwc+cHYxk
         AgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136028; x=1690728028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emMdYQhKSBWYyb26wPZv/mWPp2WHz1S9ZDQ86I2IF/0=;
        b=aLWhm2pkZqLoR2n4OgfE/vPvdHW+UHsU2Xm14Udkx0gjVgzr3mnaNoxdm6J7OFKGKd
         mCedEQ+UOdN4Ss012IqPQdZgoiUjPXKPFjDmCc3b7rWwMYYzvsNQh/u6O4dECTIq3EGR
         QbB9JxNQLK5V5im6ux1M7fDlCCH1KntXkGfQBWdCHnQpnDkQjCbLly8uzzsJi9RRsJy8
         RjApSynb06hn8dztZKyJ3c9BRE53ssT0HW3YsCOpWJ5BeNpleFqmMEFHSnQX+m0U64aT
         9C12kNBULPXFauQwyejA70II+trGP0ClX6p5tWUkyjdTcHDL8pYjLgk1O/Slkk3rfyZs
         27TQ==
X-Gm-Message-State: ABy/qLZNBO++/WskeXrhBe7r31+oFNvNsUaPb8p65mS9U8xsqb3Lxgv0
        pjX+Z/UGZCXVnJDPvMXZsMO79A==
X-Google-Smtp-Source: APBJJlEsGNJcNi+LYRa4Ynk0xbdeGY61seaeeiiO3TENmq3RME0O+S3nvKv2xCdP4363H7InYSodTw==
X-Received: by 2002:a05:6512:ac3:b0:4f8:70d8:28f8 with SMTP id n3-20020a0565120ac300b004f870d828f8mr3092132lfu.55.1688136028043;
        Fri, 30 Jun 2023 07:40:28 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id b7-20020a056512024700b004f85d80ca64sm2750402lfo.221.2023.06.30.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:40:27 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, upstream@semihalf.com, amstan@chromium.org,
        ribalda@chromium.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [RFC PATCH 3/3] ARM: dts: Add Chameleon v3 video node
Date:   Fri, 30 Jun 2023 16:40:06 +0200
Message-ID: <20230630144006.1513270-4-pan@semihalf.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630144006.1513270-1-pan@semihalf.com>
References: <20230630144006.1513270-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the video system device.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 .../socfpga/socfpga_arria10_chameleonv3.dts   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
index 422d00cd4c74..5e66363d4ab5 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
@@ -10,6 +10,60 @@ / {
 	compatible = "google,chameleon-v3", "enclustra,mercury-aa1",
 		     "altr,socfpga-arria10", "altr,socfpga";
 
+	soc {
+		video@c0060500 {
+			compatible = "google,chv3-video";
+			reg = <0xc0060500 0x100>,
+			      <0xc0060600 0x100>,
+			      <0xc0060700 0x100>,
+			      <0xc0060800 0x100>,
+			      <0xc0060900 0x100>,
+			      <0xc0060a00 0x100>,
+			      <0xc0062000 0x800>,
+			      <0xc0064000 0x800>,
+			      <0xc0060f20 0x10>,
+			      <0xc0060f30 0x10>,
+			      <0xc0060f40 0x10>,
+			      <0xc0060f50 0x10>,
+			      <0xc0060f60 0x10>,
+			      <0xc0060f70 0x10>,
+			      <0xc0060f80 0x10>,
+			      <0xc0060fe0 0x10>;
+			reg-names = "fb0",
+				"fb_mst1",
+				"fb_mst2",
+				"fb_mst3",
+				"fb_mst4",
+				"fb_sst",
+				"dp_mst",
+				"dp_sst",
+				"fb0_irq",
+				"fb_mst1_irq",
+				"fb_mst2_irq",
+				"fb_mst3_irq",
+				"fb_mst4_irq",
+				"fb_sst_irq",
+				"dp_mst_irq",
+				"dp_sst_irq";
+			interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
+				<0 22 IRQ_TYPE_LEVEL_HIGH>,
+				<0 23 IRQ_TYPE_LEVEL_HIGH>,
+				<0 24 IRQ_TYPE_LEVEL_HIGH>,
+				<0 25 IRQ_TYPE_LEVEL_HIGH>,
+				<0 26 IRQ_TYPE_LEVEL_HIGH>,
+				<0 27 IRQ_TYPE_LEVEL_HIGH>,
+				<0 33 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "fb0",
+				"fb_mst1",
+				"fb_mst2",
+				"fb_mst3",
+				"fb_mst4",
+				"fb_sst",
+				"dp_mst",
+				"dp_sst";
+		};
+	};
+
 	aliases {
 		serial0 = &uart0;
 		i2c0 = &i2c0;
-- 
2.41.0.255.g8b1d071c50-goog

