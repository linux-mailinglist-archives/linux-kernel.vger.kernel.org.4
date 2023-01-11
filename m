Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13541665A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbjAKLeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbjAKLdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:33:43 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5CE1A04D;
        Wed, 11 Jan 2023 03:32:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bp15so23028443lfb.13;
        Wed, 11 Jan 2023 03:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejDLZHen3G/A6i6n+Ga6Cs9tUQnjBYCtgzbxnqhm2tw=;
        b=X7aXjMRtKGAVT6uPuey5EJm7hw1MAJnqeZKj2DDtFNzhg1QB4q9AwtjUcNRgyTBdR9
         /9/XHgVQQCyUkLQnlHcnBMD0xF9ul2KtjRX50DQZdKuPV5W13PluEfAZ2adDYi35FmKJ
         QDWO+TWR7fN5cFpMEIll1XM7gze4K+HuFhD76yExvSvFNMev3ru+kuJ1YqYA+IZQk8zY
         U5+xRDjvTaPY1Oj/climp0u2KVUTNcDuJ33FuTQzT3sL6Mk5DNuvdR7oqh2dUW9Ub7jc
         8dLqU5N+AG8zoAhMTtrxKt/77TCbXqZAJgB+1eLXuDoQyOgpbu7uzVI9zbYl09NUtyaB
         jErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejDLZHen3G/A6i6n+Ga6Cs9tUQnjBYCtgzbxnqhm2tw=;
        b=032Q0zYTWiTDL/bpy1uKS24cWx2zJnDQdn2z49CRUAXRuHtm2xCyuY8FHaNdgHx8JJ
         KE5BPzPiiAz1uVU4S+ErSzH4nvDDSAfiDNZWyF5fs5CbR/4XU0GQW/mmQue+TwCgu0TK
         maJZ34+eJzRhlho1ohgahFs8JpH9OQk4h5J5fPxYadkqPqjkHqZDnjlXE3Rh12qEN3dn
         GU6X/AdJAaM9tGsh0zw9y8hl8X+XdK8cJLeQIug4BXfT/dFR8T1Ngv1jgBtjeUiebWz6
         RFH66fmMqVxWbBoDL13poSqU4Cbjp+Xx7wmMqcp0QV05+HvIv+hYmNk8nxqXjDuLK2WQ
         o8Jw==
X-Gm-Message-State: AFqh2krIwhDv90WtxozMqcLwWzI9z0Ah3bgI5g6gLS21IFL6BUfDzArM
        RpWag/Gqn57ym28fy0bD5UH1cSltRXZamw==
X-Google-Smtp-Source: AMrXdXu9YDss0dVZtYQFXpY41w/3GimjvTmRw2wmCHbYfIj1HxEbAv8V4Rnwn23+U6l9W4DT/zSr7w==
X-Received: by 2002:a05:6512:2356:b0:4b5:6417:43bb with SMTP id p22-20020a056512235600b004b5641743bbmr25824268lfu.51.1673436732415;
        Wed, 11 Jan 2023 03:32:12 -0800 (PST)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id h3-20020a2ea483000000b0027ff22d93a1sm1729589lji.1.2023.01.11.03.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:32:11 -0800 (PST)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: ethanolx: Correct EEPROM device name
Date:   Wed, 11 Jan 2023 14:32:08 +0300
Message-Id: <20230111113208.964-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BMC on the EthanolX board uses 24LC128 EEPROM chip for the
configuration settings. The correct compatible string for this
chip is "atmel,24c128".

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 889b2fdd19cf..8d84dcc06221 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -161,7 +161,7 @@ &i2c2 {
 &i2c3 {
 	status = "okay";
 	eeprom@50 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x50>;
 		pagesize = <64>;
 	};
-- 
2.25.1

