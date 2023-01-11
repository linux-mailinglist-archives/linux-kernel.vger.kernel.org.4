Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD4666563
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAKVOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjAKVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:14:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9963F105;
        Wed, 11 Jan 2023 13:14:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 18so24218112edw.7;
        Wed, 11 Jan 2023 13:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL00hmmnIkXIymS1Ty0/SvvkA4Jz47U0CjYmB92ey+Q=;
        b=DlkVNyEqyj6QxN8CxFvrAg3tusxratd0TR1bt3MrLfA2eYuQBOyNXykAcO0ttshqEl
         9Okj6ejtX9esNbQiiBvh5iDPtlFRuZtjSUqekAWQHQXtRVKpz+YV/R2qfJe93KcyIob8
         EgvlNtAPn8jdd/jmauF0AR5msZM2ttQk8I0zarlOiQhkyP+JmWb1RRRonSavqQOdVJTC
         bb1dhGoVkE+79ho20BZ7xfwooNJa4Q45icUgLj/4iNmCnlJa9NNt2SlhPipamPBXIYIr
         +0LRaC0Ek+nC7VajiGmiylG4Pv0yUUwKjB2R7kbqD21W47d8v/50lzE/R2UPybg6rWIa
         wP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL00hmmnIkXIymS1Ty0/SvvkA4Jz47U0CjYmB92ey+Q=;
        b=zA3L+XUE+dZ0YbJ7BLlOhSg4qGt6ivtbh1aSeJrABnzslDGOql5qyJi9FLe3rf3oOO
         +I7pVC/q9Op1b5HNZLVQ4Hzwhb4mvpg3SZ/mJsIZ5L/OcScsvyXWyio4zP044Xr/lhmR
         LaV8shIJgleALMGZRwxURKnx0SB7ENzVbbHKf+iNw2ShG5/mGPFbxbZi8ZkICqcevuyS
         TN9d0XCILA85Lh1S0cLGcAe1XPgQo16aWRFFe0AMi4Of/nKMHpVF7JeYg3md+6NWkKjm
         kC6uiE1OTsABQ9zEjXD/7b/9zIc8rpclNzsnMSy9DvbHriWknNlFSHlZE8nqEeDyfkNy
         Xa6A==
X-Gm-Message-State: AFqh2koae/W70Atoqbmt8ld+pbI6aDK/XVdSPh97hE28vOVQMTfsuve3
        mEI6exHrkPzwIfuYW5X+2Tw=
X-Google-Smtp-Source: AMrXdXsJFOnm30KGiGJ6cPDB9D1WoJASTQhB189GSWfrw92fNmmSMTdLYHGTu0MqzEgUMeVZjAJiIw==
X-Received: by 2002:a05:6402:2907:b0:497:1787:13af with SMTP id ee7-20020a056402290700b00497178713afmr15870109edb.32.1673471652474;
        Wed, 11 Jan 2023 13:14:12 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7325-0300-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7325:300::e63])
        by smtp.googlemail.com with ESMTPSA id l4-20020a056402344400b004822681a671sm6485079edc.37.2023.01.11.13.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:14:12 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/6] arm64: dts: meson-axg: jethub-j1xx: Fix MAC address node names
Date:   Wed, 11 Jan 2023 22:13:47 +0100
Message-Id: <20230111211350.1461860-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
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

Node names should use hyphens instead of underscores to not cause
warnings.

Fixes: 59ec069d5055 ("arm64: dts: meson-axg: add support for JetHub D1p (j110)")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
changes from v1 -> v2:
- new patch

 .../boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi     | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
index 5836b0030931..22fd43b5fd73 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
@@ -168,15 +168,15 @@ sn: sn@32 {
 		reg = <0x32 0x20>;
 	};
 
-	eth_mac: eth_mac@0 {
+	eth_mac: eth-mac@0 {
 		reg = <0x0 0x6>;
 	};
 
-	bt_mac: bt_mac@6 {
+	bt_mac: bt-mac@6 {
 		reg = <0x6 0x6>;
 	};
 
-	wifi_mac: wifi_mac@c {
+	wifi_mac: wifi-mac@c {
 		reg = <0xc 0x6>;
 	};
 
-- 
2.39.0

