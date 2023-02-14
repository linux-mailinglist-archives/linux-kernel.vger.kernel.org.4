Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CACD69610E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjBNKj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjBNKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:39:44 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144F244B3;
        Tue, 14 Feb 2023 02:39:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g6-20020a05600c310600b003e1f6dff952so672729wmo.1;
        Tue, 14 Feb 2023 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x1QraTZIx1mxn1ybzEQ9Nso18S7k6Ao6CArkPQDRXU=;
        b=ELd61XLdoBzFgVcqTvGtMDXoG/8GNoIoGuLMHnedoJVRea/0zUU12mqJEmRcOoL3aZ
         M0zl8lPOtTx1pUdXyRtU3agwb6e2b1ONZrl1RQxQmDNbYInfxg9NgpDM4MmKSynwmmFO
         j3KkllZBM20EtIQKWLSmJ4eTpZ6adk/65gtPkV3w2c4ZctYQwvLkXGHqujqsBD9C9wul
         l1Wt4AXOZWYzmMJpdWw+dU8zz1n4WwRbO0EFwiCKGPffKFq7XzlCFapauxx2CEwMZbpe
         qA1fKiqfM/7co1pAmR5Ig9VMScV/1VY06c/7RTAR0H6lB0LTmjOIg/p2vWUCoWugEJcA
         ssVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x1QraTZIx1mxn1ybzEQ9Nso18S7k6Ao6CArkPQDRXU=;
        b=4KlcEa+bpzpbXD/dgztpSz95StmGUGuT7Q8DhJerP38FDiE0d28mEL/c5mJkrM7Fow
         jhH7rtMKTJ/HikelKcxIC2JwO4TG8jZKZmg+fQFIaCC9ZqYjurR+Wu5VHfA8cZWrO0lA
         h4hvAotCQD81tn8fVcxeLH99szl9AB7KDdxBU3wWP7f83bEU59t/PuHf13K0bmF7niRy
         5oGadxM7MgHeiYOGyPAEtuuJ8oek3C1rMmOXm3peeDB83D0+sXeveoYeKe18JLG8YsK7
         FZ8fi041gop+WEKcKDW6rxfjvvun7hjKfouxpLwQZvgZXrI2XxnhHv9NifCSoMG6cXqW
         UuPw==
X-Gm-Message-State: AO0yUKWLJqkLLNT/w5Yf0yozAlqBB9wM7eT8aGOZ/n98f4CA9SluuJoD
        7RQzVjaM8Lrs/ss8M1hItsy3THs72No=
X-Google-Smtp-Source: AK7set/Qf6TB5G+MxxRm/ADJl3gFIvHnQw7N3RmvZi01c1mr2P5CX0IIMDA1lgs8Q/UtFrTbK22FvQ==
X-Received: by 2002:a05:600c:3412:b0:3dd:b0b3:811b with SMTP id y18-20020a05600c341200b003ddb0b3811bmr1549659wmp.31.1676371181298;
        Tue, 14 Feb 2023 02:39:41 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b002be5bdbe40csm12693241wrt.27.2023.02.14.02.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:39:40 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 2/5] mips: dts: ralink: mt7621: rename watchdog node from 'wdt' into 'watchdog'
Date:   Tue, 14 Feb 2023 11:39:33 +0100
Message-Id: <20230214103936.1061078-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
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
index 5ca40fd21662..ac818fd721ae 100644
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

