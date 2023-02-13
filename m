Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8B695154
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBMUFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjBMUF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:05:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637B41E2A9;
        Mon, 13 Feb 2023 12:05:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso3662873wms.2;
        Mon, 13 Feb 2023 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxuQc2Qm9/O1c75x/Q80GT9G9dfuHOQIUSLpagOrN44=;
        b=YHQskvgFSms4BAqjbWCYgFCp2OTTTQrsKR9fg3OxbrL+Sj+oJzbPjbsh0gQ55mcfM/
         5aUcDmImMEbA9a+embT3FoBTYzaZAbKeNy6PYTPLOGv2zjIfnvB7Q0+KnIw65LDmlsuC
         Wq+dAAHA7aC4m7q4i9bsgKwpIGxmbqA6UJg3VQMEwroR8/29Qlrb2B49YCgu0l/YXuBU
         gy60+tqyFI95x58iKfOZMA5RWzIMNRgfg9n+KMY0aVxk62GvlXLrnniWTEfdiMr9UGEv
         LJwR/KIhHlRcIokFJb1YbHu1TmJTXEq1OZiU6Vh5x16JNSz7ZkFLyb99a+Y9GWOhdXNJ
         +i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxuQc2Qm9/O1c75x/Q80GT9G9dfuHOQIUSLpagOrN44=;
        b=HM2FkxKWOqEdEZGZ6NlUG4+3wkePqU14/w0u0VMyDvsW1TY7m8CsfmeV/Apt/1++cx
         MElaj2LiOHHJUigzEz6BdlBSvhdV2FlbX+HgYjhjkWrRCN1fHqNDyHXTi9yG3HY6FYWg
         ajRvd8UXYIsHXq4igbVNiAn+B+wjjBgeRgVyjWaXRtq+FcYGemGZjDRp4a8Q/ruVMnlb
         oDcJcizEEuU+nqfaeCNN9hJqUiBYL7eroubgBk7B5G/2WHGcpa5FPzmelMTunxxpLbtl
         PEipsApvh6Ydrn5O62M7NVpHUnQ60NOJjGqR+kEq3TqgLuud/WGIb2LKI60B7T+LIA7y
         3xoQ==
X-Gm-Message-State: AO0yUKXX6ugmIkUsy0qR1jkPdsPyV9evxQ0KD93Vn+n0dwFK+78yitod
        gDgr1BvOAD8dTDCi/JJWnwk//Xx34+4=
X-Google-Smtp-Source: AK7set9y7U1h45JPvD68yUorkyDDZhH/Ef+cOVb21q6hsZcC5MCpE2ajeYzzgowxOewPagtjTqEscw==
X-Received: by 2002:a05:600c:308a:b0:3dc:43a0:83bb with SMTP id g10-20020a05600c308a00b003dc43a083bbmr20186570wmn.3.1676318722560;
        Mon, 13 Feb 2023 12:05:22 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id c129-20020a1c3587000000b003dc1a525f22sm15591242wma.25.2023.02.13.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:05:22 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 1/3] mips: dts: ralink: mt7621: rename watchdog node from 'wdt' into 'watchdog'
Date:   Mon, 13 Feb 2023 21:05:17 +0100
Message-Id: <20230213200519.889503-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Watchdog nodes must use 'watchdog' for node name. When a 'make dtbs_check'
is performed the following warning appears:

wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f])?$'

Fix this warning up properly renaming the node into 'watchdog'.

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 5ca40fd21..ac818fd72 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -70,7 +70,7 @@ sysc: syscon@0 {
 					     "250m", "270m";
 		};
 
-		wdt: wdt@100 {
+		wdt: watchdog@100 {
 			compatible = "mediatek,mt7621-wdt";
 			reg = <0x100 0x100>;
 		};
-- 
2.25.1

