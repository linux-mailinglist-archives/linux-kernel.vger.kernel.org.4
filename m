Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68BA6EA629
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjDUIok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjDUIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:44:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28293A5F4;
        Fri, 21 Apr 2023 01:43:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso1388064e87.2;
        Fri, 21 Apr 2023 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682066603; x=1684658603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvGmFR5di2sik7RBLdOP/KeRkjaQDZZlALHIAzFWnQk=;
        b=lZgG/9a5Jc/r7LaEpPZhh6Kh2EI401N+EdCAEdxS1ZeYDJ9Pj1/Cc+6Bpv7+ZphX3x
         XEhmuTTiKKGyQkrPMAhwFjyXMQTjcpw0tck6kIC9evpFucRu4mRhSs+8yh3aTWHjagSH
         eJTaqtuhvqbM42jvAAFvHdxMUZqvUbwFwB8nAzUgHw8aMJn5wyLVTlDArHTVNGXby1z4
         QymzgryUaxPnl8P5wSmYCjB5ueryYvn/Lt2XZtTTP/mP6hoyQikOspdRbxe+XQ5TVvCy
         0xUE1DUUgVHOhugnD/7qrUhnIpjWkjxrDUtLj9IVDDU3wNL8iI6pFAGB3+fVFy4oZ+jO
         nlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066603; x=1684658603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvGmFR5di2sik7RBLdOP/KeRkjaQDZZlALHIAzFWnQk=;
        b=HPNlwS0c1hVo01ryJviPZMgZDIl+p3w3OnQreevGnPkwvWtOBna5T7ijMFNph256ud
         oCEk+erHlgdsx7Njy9GkvJBzdZnWAoxJ/29QvADClCTl+B3n7Ye46bZNQrHjTk5BEpaJ
         6zoXxy3SESezB9GeFq4yaH0qbJRyibdtAwIwMDY7q71/ePL86ZeSiqd9JWl7ENIRAZCQ
         Wk0UuB1l6g+9bHca7pNwKuJMXhm55nr6eaPt5zWJNpYjUqsMZcUblA7kx9ZO0ztgppG9
         3I4ThzyXj7RDVxCPRSNyLorJKOmE2b8aAM/FBLWAsD0AR16VzdnuHUfiGVUyMBKprOTd
         6Xpw==
X-Gm-Message-State: AAQBX9fOn2Dm0+cZEkgVlJEn7AbsTHFjtBWlTgXduQtBB3U1FK56h+ay
        F1VywCTTPvrHZ+8c98XhdoM=
X-Google-Smtp-Source: AKy350aISo20GAPNVBrXfh/unQT0OP7EDE6k1y/Q60ms4Bh+MvtraUkgSHPtS15tDRn4mlL6XlTE3Q==
X-Received: by 2002:a05:6512:20e:b0:4eb:1527:e29d with SMTP id a14-20020a056512020e00b004eb1527e29dmr1221705lfo.52.1682066603523;
        Fri, 21 Apr 2023 01:43:23 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id l16-20020ac25550000000b004edc16dbdfasm480721lfk.119.2023.04.21.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 01:43:22 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 3/3] ARM: dts: BCM5301X: Specify WAN port MAC address for Luxul XWR-3150
Date:   Fri, 21 Apr 2023 10:43:12 +0200
Message-Id: <20230421084312.27932-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421084312.27932-1-zajec5@gmail.com>
References: <20230421084312.27932-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

It needs to be calculated based on the base Ethernet interface one.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This PATCH is a proof of concept that can go separately through the ARM
DT tree. I'd actually suggest that. There are more .dts files I'll want
to update.
Srini: can you just take the first 2 patches from this series?
---
 arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
index 60a2c441d5bd..2dd05f4dce92 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
@@ -27,6 +27,7 @@ nvram@1eff0000 {
 		reg = <0x1eff0000 0x10000>;
 
 		et0macaddr: et0macaddr {
+			#nvmem-cell-cells = <1>;
 		};
 	};
 
@@ -76,7 +77,7 @@ button-restart {
 };
 
 &gmac0 {
-	nvmem-cells = <&et0macaddr>;
+	nvmem-cells = <&et0macaddr 0>;
 	nvmem-cell-names = "mac-address";
 };
 
@@ -119,6 +120,8 @@ port@3 {
 		port@4 {
 			reg = <4>;
 			label = "wan";
+			nvmem-cells = <&et0macaddr 5>;
+			nvmem-cell-names = "mac-address";
 		};
 
 		port@5 {
-- 
2.34.1

