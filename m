Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C1694541
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjBMMHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjBMMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:07:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC5C4C1C;
        Mon, 13 Feb 2023 04:07:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id he5so721042wmb.3;
        Mon, 13 Feb 2023 04:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puHEl0X23MBFVfVNfelqsSiLh2UANNxeMp5gar+0Q6Y=;
        b=oCahZ1IIM9Zf820MwMwW5Rp4ah7qKLGNJ+sSiOs6UHWp37lcgnyHZkT83lLqc66H8k
         u/HKXNPT4LYRFMQzo+2Y/fmMSAhwIH3DyuyU1UgIb+EnClerGDfhO9GGJ7/J2eoJVRx0
         ZMO3IclljA6eTJ7tac9S0zQ32MpPhsn5b1SXTkQ5Na72wFb8iFAD6sWKbQdWmrXKOqMq
         pTkgD2WsoiOJ+V8Xm7vjnAnYmSr6XA9pr+6qsHE9AQe6RS0Qvd2GAmGgf3fFVcnor0iG
         pIFCJYfFzQHXAV5TQfUJhcDCjuzWdoMqn3cNLwrM5NdogjBOB9heyG0ZK+p3fuCH7bfL
         xwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puHEl0X23MBFVfVNfelqsSiLh2UANNxeMp5gar+0Q6Y=;
        b=vxkr03KgZSidXASDnHo2V5yYSUiM67Svk7BkuWUnbB+K0boH/+TV9fhd2K19+bOwHT
         3wPzcJ+CdmGfDDHGYbofoYhcllSq9Kbp9L8/wOhWEItGiIUizYU8gAixCWAZLJRlWLr1
         CQ7nyTMCFXTQqz0H6ekm45OAMHG9BWjCEPlx0YmafE4sPMRa1Ow/U8opeoAlcpMPYIwN
         xfc06KyFlk+z2dl6iZuIk9j8YvtRXojgZH6NypZmuFEPY8tzMGFQzkBKVwpAvo1Y0JSp
         ztccWHSCTxXJl55grUfvkjSWdG4jyiewwuLtX1RtgqjEFw0fXXRtcgypF40VqA+NvUps
         pkKw==
X-Gm-Message-State: AO0yUKWOWhIQ9If7irdikzRMoBgC/yCfAfwS7XAGIo3Hp//UmKZNP+RO
        vXWzpTEVIQ15hguVRbaGsfNHHPGgmuo=
X-Google-Smtp-Source: AK7set+Zq7a/He9MT+m5kzSdOR6iVZwYuoJ43aTt1o7D505SdkymAuyxsQlFXfNo9hPu2HnUMzphsQ==
X-Received: by 2002:a05:600c:3416:b0:3df:85d2:c768 with SMTP id y22-20020a05600c341600b003df85d2c768mr18865791wmp.26.1676290002018;
        Mon, 13 Feb 2023 04:06:42 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003dc434900e1sm14798046wms.34.2023.02.13.04.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:06:41 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v5 1/2] mips: dts: ralink: mt7621: rename watchdog node from 'wdt' into 'watchdog'
Date:   Mon, 13 Feb 2023 13:06:37 +0100
Message-Id: <20230213120638.850612-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213120638.850612-1-sergio.paracuellos@gmail.com>
References: <20230213120638.850612-1-sergio.paracuellos@gmail.com>
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

