Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E46918D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjBJG4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjBJG43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:56:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE33608D;
        Thu,  9 Feb 2023 22:56:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so5585217wma.1;
        Thu, 09 Feb 2023 22:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQlG6AWGDGiaVCyhcczhUxKcndm2ZWR4D2LQqdn5yiE=;
        b=lclAAgSw/cy1PcBGDwGXVnSI8+4AWjAghaqMC/7WihzIyAuvdljcSRO0M0btrKixl8
         Z8kc66wQS8RuJAQbvfhgfVeZCRDDslRuLI9kaur9i2TPs8sSAMtMIIrBwsrEAfTmRkcW
         3UQ0OnMMBMX/FDg3FT5XQ0tWFmPPd8a8gmskfiMY0vuHXyVH1FWs5XCkjZ8bXyb6Xucr
         XtqspUZcIUJmfCnEctvpd0MeJd/OzYSEQl214iihQvuvR2FWQ1WmvYssKgT8ycmELqD8
         zwtOhqnTkD/IfkPvL2t+saUXmwH9zTSKwKQq+MNyiJBwnmdw6nk8hk9YGxLp2QC3R++h
         JLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQlG6AWGDGiaVCyhcczhUxKcndm2ZWR4D2LQqdn5yiE=;
        b=N1tOLmoJ9d6IrpQOui+rXM0R9C0T05v7P89wHvLjLw2nnfy49txIDEgIrsLfwbS9Hb
         sIvudgO3iEmhYTnUOTJwXNEtnKESVBw6GRZi+EzZV1y50p/O0z3EOLGbvzXHO7kj/C1f
         lM8RhoPZtUtysBDZXjBS+5OEz0QWo1DQcizqsOsu8g+F16B3xqPS4JKEZgXXNAggFvoI
         rKPGS5SPDDNCnF8sNJHyTU4RwK/YBRCEqZWK+iOQVgLXNkSg5EOld5BT3aeBv7l5EjMn
         5Lf8nHyow7dR60o20dzvj5RXoClkBor8ldUMUse2NMs/7w6JEorhpi0cEaRTgsMJ2TYO
         3fGQ==
X-Gm-Message-State: AO0yUKXksa1zsUcrcU7aw1KJ506up45xDBl6i0T0ZTA4qolGb+koNJYf
        kNxboKN/ePl/dil27VPvXlEfROqsusM=
X-Google-Smtp-Source: AK7set+D3eysAynCvcZNB0u35nPmszVJoApMTolc4ISxxZo+eUe8r08VuAj2ferIIgQZJKOYTI9OzA==
X-Received: by 2002:a05:600c:3290:b0:3db:8de:6993 with SMTP id t16-20020a05600c329000b003db08de6993mr1307503wmp.4.1676012185515;
        Thu, 09 Feb 2023 22:56:25 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003e001afa274sm4385612wmo.2.2023.02.09.22.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 22:56:25 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 2/3] mips: dts: ralink: mt7621: add phandle to system controller node for watchdog
Date:   Fri, 10 Feb 2023 07:56:20 +0100
Message-Id: <20230210065621.598120-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
References: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
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

To allow to access system controller registers from watchdog driver code
add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
operations in driver code.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 5ca40fd21..ebee23a2b 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -71,8 +71,9 @@ sysc: syscon@0 {
 		};
 
 		wdt: wdt@100 {
-			compatible = "mediatek,mt7621-wdt";
+			compatible = "mediatek,mt7621-wdt", "syscon";
 			reg = <0x100 0x100>;
+			ralink,sysctl = <&sysc>;
 		};
 
 		gpio: gpio@600 {
-- 
2.25.1

