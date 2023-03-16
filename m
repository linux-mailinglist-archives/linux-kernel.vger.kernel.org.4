Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C66BCEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCPLw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCPLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:52:24 -0400
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090EA9E309
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:52:20 -0700 (PDT)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197]) by mx-outbound40-126.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 16 Mar 2023 11:52:18 +0000
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-541a39df9f4so12663427b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1678967538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqVmEyOrJQJn3pfCA5li10O2ni8RXk5d8AsC0ChXTIA=;
        b=jeC8j1JTwTR/f5hPYMwzkvHuVf4OHuJRbdHwGksJWfzX6pDpYbbj9ix/X8rzVPK5TN
         V1q3j1iyhBwHevUaqnw9juI6lry8YM4YWkVzMZHLkayROB4zc+FlxffI5bnOcvEF5Es7
         7udpjHx+XxkJiEwMNAImjied6nZdwBxqRjRmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678967538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqVmEyOrJQJn3pfCA5li10O2ni8RXk5d8AsC0ChXTIA=;
        b=k9vCRTOOOOQkS/aNcEXNRTdqT7rNc/2puAMXRYoJNn17rvRwUiNFR9T/umIZaxGdTH
         IHUdhWxkPGxFbJVM87xgUIxVckfp4pfCQYkbJcYn/fdgC3p8ip2wCLt2WJl50p+klyWG
         /+SfTz+eFn0AMlpW3OIPjRprCsv5Uf9nQUaEoEJdfO3jXP3ut+d77u+gl/IR2tgFAqdc
         y7h2mdXQMkeG2wmSYjQHuC7ey5KE01p0orwbngpwSx0OM7zOI96ns0EgUFWZQMaMqC7Q
         5PqyA4AYZmmdJDs7nEzl7HsCahJs0nh0a7llxwQ1/+GX9uf1D1F1ryQiRWbi38d3hxQd
         Vd4g==
X-Gm-Message-State: AO0yUKW9RydOWOwR7nKVRRNe/NaMoALWBZqCBpNOClMsNpGShRHq3SFw
        W3qUB0V7AoBL7e2BJca97+CnQxzMq/ptWnkmiDebhl+h/O8avdhPtkkENgVNC+YlJZ7/Jm7BQaq
        ngTQQPQo8fD8zSF2BUEW5PsolpalD/fG/HbKFMoUMgPN5W0sI4ojmls0hrqmx
X-Received: by 2002:aa7:9413:0:b0:625:e1b9:3cdf with SMTP id x19-20020aa79413000000b00625e1b93cdfmr2620439pfo.8.1678963679397;
        Thu, 16 Mar 2023 03:47:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set/WjlblZ9Q81pgj+1uSx+QauOrpihkzi0fcL0bwzVV92S6AK9583K//KSL7MQIv/ro/zTD6dg==
X-Received: by 2002:aa7:9413:0:b0:625:e1b9:3cdf with SMTP id x19-20020aa79413000000b00625e1b93cdfmr2620426pfo.8.1678963679117;
        Thu, 16 Mar 2023 03:47:59 -0700 (PDT)
Received: from localhost.localdomain ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id f26-20020aa78b1a000000b005a8c92f7c27sm5108744pfd.212.2023.03.16.03.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:47:58 -0700 (PDT)
From:   sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sabiya.d@mistralsolutions.com,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j784s4-mcu-wakeup: Fix IO PADCONFIG size for wakeup domain
Date:   Thu, 16 Mar 2023 16:17:42 +0530
Message-Id: <20230316104743.482972-2-sabiya.d@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316104743.482972-1-sabiya.d@ti.com>
References: <20230316104743.482972-1-sabiya.d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1678967538-310366-5549-16789-1
X-BESS-VER: 2019.1_20230310.1716
X-BESS-Apparent-Source-IP: 209.85.128.197
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNDA2BrIygIKGSYYmqWZGho
        kppqkmxklplonJRompJmapZslmBmlJSUq1sQDHxzw1QQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.246833 [from 
        cloudscan9-71.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, NO_REAL_NAME
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dasnavis Sabiya <sabiya.d@ti.com>

The size of IO PADCONFIG register set of the wakeup domain is incorrect for
J784S4. Update the PADCONFIG offset size to the correct value for
J784S4 SoC.

Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 64bd3dee14aa..c0103513c64c 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -50,7 +50,7 @@ mcu_ram: sram@41c00000 {
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c000 0x00 0x178>;
+		reg = <0x00 0x4301c000 0x00 0x194>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.25.1

