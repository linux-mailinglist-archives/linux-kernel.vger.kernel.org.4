Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E48C6781C9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjAWQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjAWQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:38:56 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CBD2C654
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:38:46 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id mp20so32010704ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=re/iBS/krfavbjAybh8kxWH3jwUIJgUXVLFDpOuxVaQ=;
        b=tte5UV9bJSfSYqJ7ySed85BL8AL0jf3Szrq2yD2EprWKr4hrug4SnSoRf2ZXdGkcYH
         7EVPyKY7z8kv4jSmr/YWXpVpEV5kqmAc+XLUWyQrGo40UWI2Gc2CCySrzuyifdituidQ
         UcEisgl01lpt4XPsYmAk/Bt4gEr5LbDgn7++ah0ohiSa7JzWaqpcA6rtdoPNhUj91NDS
         q9MjGODS04+gDtCQh0dNKg6JDwLHh4qqXhzyzbtLTUGDlNPx8ZZ+JZeaQLE86JoJAQoO
         uR9e4k3HG3VGSFAq0ASYg3f62O5vqmD0hzx7WUYXpi1VCQxUjHQtTG+8TGpBeBFI54Xb
         91EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re/iBS/krfavbjAybh8kxWH3jwUIJgUXVLFDpOuxVaQ=;
        b=mkxnntegUeVs4W3JjA1vkMgBsZXIJefrDSfOEHo8/IUv3gAUA8/I6xkCg1iH0fpMs6
         l6GQOLNa20P34mDMf8Epn/paCpcOclcfEX75tAp15N3uK+5JQKUG1ESx1uzeF7A6dDq9
         M59km0LYSxsRVxdsrkbpBn9l1/0SLhXMlWAptZprf+l0WiqwPcoslPL0hG/fomxWHgFD
         Z8l/HHKHnk8yWSYmf3aLNmhJfdunZT4hFyrjQs7kXFJ7Xj2flC3mGJhRzbFHvb6iTrIg
         0yGWIWEa/co886l+kjUDzZFgNJQYocDWTOWsZFmLD/x1sIqwSwKqISwEg7tRwEeUR927
         iaTA==
X-Gm-Message-State: AFqh2kpjahbAqfH/yzeCPtcFjqzxWXlfJu2BPjj3hmZJLo9IhtmSAqkd
        Uum9hpMcMYfe0KXHNYtUJBOAKQ==
X-Google-Smtp-Source: AMrXdXvh5fhFr1zDZgmt1Fk7cgrD4iLURkeGSSmFiCTQtEWqT12tYjTRyMlLpFC6Yl1qMfW7FzGM7A==
X-Received: by 2002:a17:906:368f:b0:877:593a:58d0 with SMTP id a15-20020a170906368f00b00877593a58d0mr21327808ejc.29.1674491924794;
        Mon, 23 Jan 2023 08:38:44 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b007c00323cc23sm22198562ejc.27.2023.01.23.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:38:43 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        andrew@lunn.ch, gtk3@inbox.ru, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
Subject: [PATCH v8 7/9] dt-bindings: timer: mediatek,mtk-timer: add MT8365 SoC bindings
Date:   Mon, 23 Jan 2023 17:38:31 +0100
Message-Id: <20230123163833.1007181-8-bero@baylibre.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123163833.1007181-1-bero@baylibre.com>
References: <20230123163833.1007181-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding description for mediatek,mt8365-systimer

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 8bbb6e94508b2..b3e797e8aa313 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -33,6 +33,7 @@ Required properties:
 
 	For those SoCs that use CPUX
 	* "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
+	* "mediatek,mt8365-systimer" for MT8365 compatible timers (CPUX)
 
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
-- 
2.39.1

