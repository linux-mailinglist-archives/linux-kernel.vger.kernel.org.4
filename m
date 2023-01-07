Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6672D660F91
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjAGOno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjAGOn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:43:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F758F99;
        Sat,  7 Jan 2023 06:43:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so679165wma.1;
        Sat, 07 Jan 2023 06:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KflpauUnWgC57RkikrRwZ2S6zi1pavAFyzypxpmWhoY=;
        b=Tqv56ClWmcwHVhAUExXSWB5Pp3P0Zu7LJIe/Bl+SGUESQ/WQIHSuKzg0Y3jwA2+IIs
         QKJknyep1mSJ3Z0JDDEyCYB9+fdRAnBJAiz1t43ArrxDA6AcMDGlkgyVfV74tHt1KciO
         EwWyxR2hAXrAaG+1EkG1yWvv8R9YxCShXQADAMcPTzms3xTr5S7Us2mmyO0P6BHx8eBH
         eYgEZ+JXQ5tQvNr4xzuCPuVQIPSo87Zf6XL47R11boJZw/PAKNoLNwyi34NISpNqwQOH
         W8/shlStEn+YnhUgCerNn/lYkf16RtZC2sIit3L9cSJLGft1fBwCp8ZdK47vLIR5f3KA
         EDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KflpauUnWgC57RkikrRwZ2S6zi1pavAFyzypxpmWhoY=;
        b=Hkf8vewL6UW2KwlesxT/ePueDO9yMQ1jMMQxiBdzSYV6hDItD6zvsX986zBDkwJBTM
         V7GTsbq2TAENVdBN/Pr/MvZxZ8IG9pVQa0XfpKydQyUYUZlbKhsCyaelDKPbCnZVHoKD
         hV7fBI8ic0qJ+15pkFw6ac3zD4YbCclirBagDIQCtVJf2w3I9gglcdXlWXVNKapyTZ6P
         GmwactD8uKmxuPdyIBPm0OZkVRFDYQSWAtVR/Exe918ptIa5C1z9a039P7se21WHwovL
         +xInBd/FoqB/pRa/+20ascNgRyTSO0GyQQbgJnacCcY0ZLpiw5x5dbI7RX87ZLD2vaJK
         xGFQ==
X-Gm-Message-State: AFqh2kq/JGekBoB/Doi0Trm4+fXX0BeLX7m5lYGiRg4Ed2GCC59pdu8O
        Bk3QjoNoiEkg/trRP/Z8QW4=
X-Google-Smtp-Source: AMrXdXugbobdJRCM/3Fbu5r/3k2S8rpVOY4LyMoUQ1NuYbYL5zwd0A/ZbX0xojfBzW3C4wk+iHiWtQ==
X-Received: by 2002:a05:600c:42c7:b0:3d2:3ae8:885b with SMTP id j7-20020a05600c42c700b003d23ae8885bmr41848980wme.28.1673102605972;
        Sat, 07 Jan 2023 06:43:25 -0800 (PST)
Received: from mars.. ([2a02:168:6806:0:40f6:41b6:8914:e80b])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003d9a86a13bfsm6056106wmq.28.2023.01.07.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 06:43:25 -0800 (PST)
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
To:     "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: [PATCH v2 2/2] Revert "ARM: dts: armada-39x: Fix compatible string for gpios"
Date:   Sat,  7 Jan 2023 15:41:49 +0100
Message-Id: <20230107144149.5743-2-klaus.kudielka@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107144149.5743-1-klaus.kudielka@gmail.com>
References: <20230107144149.5743-1-klaus.kudielka@gmail.com>
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

This reverts commit d10886a4e6f85ee18d47a1066a52168461370ded.

If compatible = "marvell,armadaxp-gpio", the reg property requires a
second (address, size) pair, which points to the per-CPU interrupt
registers <0x18800 0x30> / <0x18840 0x30>.

Furthermore:
Commit 5f79c651e81e explains very well, why the gpio-mvebu driver does not
work reliably with per-CPU interrupts.
Commit 988c8c0cd04d deprecates compatible = marvell,armadaxp-gpio for this
reason.

Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
---
v1->v2: Be more explicit about the reg property.

 arch/arm/boot/dts/armada-39x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 1e05208d9f..9d1cac49c0 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -213,7 +213,7 @@ nand_pins: nand-pins {
 			};
 
 			gpio0: gpio@18100 {
-				compatible = "marvell,armadaxp-gpio", "marvell,orion-gpio";
+				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
 				ngpios = <32>;
 				gpio-controller;
@@ -227,7 +227,7 @@ gpio0: gpio@18100 {
 			};
 
 			gpio1: gpio@18140 {
-				compatible = "marvell,armadaxp-gpio", "marvell,orion-gpio";
+				compatible = "marvell,orion-gpio";
 				reg = <0x18140 0x40>;
 				ngpios = <28>;
 				gpio-controller;
-- 
2.39.0

