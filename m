Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF55F939D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 01:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiJIXkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 19:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiJIXj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 19:39:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85A754CBD;
        Sun,  9 Oct 2022 16:12:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k2so21647463ejr.2;
        Sun, 09 Oct 2022 16:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiPRh6wTw9/20yomz/2RX853C89gE1vPeMzvoVPx9eM=;
        b=l0jc64i+SO+36YELO3JQ0LNGAyQz5T90Td8W5IlW/cw1fWNlUBhX6QQyBIsucvbsIT
         gyenX0b5DM3XSqRI/SipyLR2MdSQZUwBEavgr5oTmB4HWmDWaGvZGiWwHmtLZuILb1dJ
         wgouum0QvWQjpujSmyixMmxZzed1eOZaN5xGNGB5BlfjAROJcgTcGcR8zRUbCMQdoDtz
         +pZub9991luvmGoxea8qHheyKnBy0K2K0mEc73wG96N82CVmCudDnf7cZ6cmyD2ALxZH
         kcR338cwzcKUhxy8o6tP2qAQoCCyjMTsrAdiX6YcxRKQI862P/lIHX9c7FT8mgQBg2jW
         1IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiPRh6wTw9/20yomz/2RX853C89gE1vPeMzvoVPx9eM=;
        b=QNbyU2/uzdWk0+1FQQi66dCg+1IiNJdnO8IjUOURtgHQuYpFigZfOQ9WwMFj1UMPGW
         kZoU+8fjdCLKa5HO85Ss2sYHhQCeBDXcTahNw6AP2FjCguVlxSfX85Xy8ckj03LHFQ6I
         53/HClaoGTh6DiRmbcH9xSgzP/kLq9rZNyi27D/GMIpI4SX3gwBTZQ17wobMBT4J6c0C
         lcBFE+EP9eFuddTLu4NNH0m0+7r4rJI6/5eqF7CQ/TM2FQXV/W1WTxsRKbLbM4WV0gcj
         l78C6J4VsSlVCxllhYpKylPdk47GlVO9W+oUY/ECq1MLcSGm5z334tfqBkS8x5nicRDR
         z7HQ==
X-Gm-Message-State: ACrzQf24C6NgZjFvPV9x1pEwHuaJVdHcWdFdKr5ZK5luXKUIEDko9RVZ
        in2jcsBzOmVZg+lzJDSb1DdQvkWovHm1Yg==
X-Google-Smtp-Source: AMsMyM4hmqzqBSDgiaJTVrebGVZol0MldXvMwVBoV6c41bxUrWHvpCdF6rBmk9nyFns/pEHTaPa9Wg==
X-Received: by 2002:adf:de8f:0:b0:22e:361b:6a05 with SMTP id w15-20020adfde8f000000b0022e361b6a05mr10029716wrl.311.1665356460803;
        Sun, 09 Oct 2022 16:01:00 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e4:5cde:80ab:dfd4])
        by smtp.gmail.com with ESMTPSA id r16-20020adff710000000b0022afbd02c69sm7239689wrp.56.2022.10.09.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 16:01:00 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/5] arm64: dts: renesas: rzg2lc-smarc-som: Drop enabling WDT2
Date:   Mon, 10 Oct 2022 00:00:41 +0100
Message-Id: <20221009230044.10961-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
used from CA55 CPU would result in an unexpected behaviour. Hence drop
enabling WDT2.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index 78e6e2376b01..8a0d56872de7 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -276,8 +276,3 @@ &wdt1 {
 	status = "okay";
 	timeout-sec = <60>;
 };
-
-&wdt2 {
-	status = "okay";
-	timeout-sec = <60>;
-};
-- 
2.25.1

