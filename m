Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD38629655
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbiKOKvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiKOKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:51:04 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D304E26121
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:50:50 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id k19so16996257lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jeUp2U1S6pehRzAaj935AujC0T+FHs+JgelXqy8edc=;
        b=GFtiBHdj76khS0rzZbLEhiMxo7P+omEnOtfXtWgZjlz9PCs9eB4CpBn1U2fimQyLha
         Mog5/4/4b5prfCEuRu8O3ZX/p2IW6XT0s55BHLjTP/VDvRK0tSQpO5Qzv/NPjAsV86SB
         sq0TNTbz2PkDESXhUM0nGdIjGirjF4krkNzQWAMfnVvUP+oOnmY8WeQhexdVN4ryg1y9
         WWww7SkzDKA7+XT/GeOpUzmihkfxLV/5dKIiIdAgaWS8kGwBNnAODzrEGGKW/L4DXKqW
         sT324tGaYIy0upeI1delMdoEauGXGSfCaj8Rks0RXgAhMfi1RbW7pzfY0tCGQjOWV63S
         ZvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jeUp2U1S6pehRzAaj935AujC0T+FHs+JgelXqy8edc=;
        b=ObbaMoOS0uS7YiAo4IDRVvMG2EukQJvW0IA6whVqtdAcvaND0o6Pw6SJUTF3ZszKBQ
         nyZwYorm/KC/3k7IFi1P6o6OUoTbRl/CI2JrbciI/kDF2mHDRc64v6UfUuaLIfkYJOON
         eVJqhqfz9qekB0Mtfizb6ZbHk6hOiIV2F3oWYmLqIaKRPLhZEhK5f16Lj4zm0Tq0H5mQ
         gZf+pcDo06dPZH3P0jFQbDLMqafDtqlr67r6nHoT399scxV2QFq1Si0DL8cdKRqng18p
         rjCuRwG2vf5gTj6cNCRkrx3sUibWYgtVPDNJnp9sBUK97xRP2pS/DWcOTSHg93BYoy6c
         ejaQ==
X-Gm-Message-State: ANoB5pnGWoJxAnf5SavQfTgskqxMzoGXqcQoqu6T/NOJWtyg/LuXDSJQ
        Lwwv7BcE5LAaFPR23M5AMWK+Rg==
X-Google-Smtp-Source: AA0mqf4mjOTKQVZ3ML/z84ZJid0+WN8C+0/2KxtGTMiMq1WPWS6UTLK0IWowkMfcy2oAG1vuvAfbRw==
X-Received: by 2002:a05:651c:22f:b0:278:ec8c:7923 with SMTP id z15-20020a05651c022f00b00278ec8c7923mr4715088ljn.185.1668509449247;
        Tue, 15 Nov 2022 02:50:49 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p17-20020ac24ed1000000b0048a9e899693sm2188124lfr.16.2022.11.15.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:50:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: broadcom: trim addresses to 8 digits
Date:   Tue, 15 Nov 2022 11:50:47 +0100
Message-Id: <20221115105047.95281-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hex numbers in addresses and sizes should be rather eight digits, not
nine.  Drop leading zeros.  No functional change (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts | 2 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
index e34172e3117e..fbf0392b8371 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
@@ -52,7 +52,7 @@ chosen {
 
 	memory {
 		device_type = "memory";
-		reg = <0x000000000 0x80000000 0x00000000 0x40000000>;
+		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
index 7bf26f3e36bf..699f7742ce7f 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
@@ -49,7 +49,7 @@ chosen {
 
 	memory {
 		device_type = "memory";
-		reg = <0x000000000 0x80000000 0x00000001 0x00000000>;
+		reg = <0x00000000 0x80000000 0x00000001 0x00000000>;
 	};
 };
 
-- 
2.34.1

