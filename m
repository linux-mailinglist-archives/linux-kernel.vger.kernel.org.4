Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870D66112F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJ1NgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJ1NgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:36:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB41EC695C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:35:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kt23so12931270ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPTLDxE+Qpo8aT7LTAOpqv5zhoPUlSbtMdZx1FPPRU0=;
        b=fTXnu/dZCwl4ftwCR9prOocmWD2+dhmNpE7ufBkYUMAKK9C2Ecm6U8Kq9Q3mXBgIya
         m6hqfBy1nFIf/qD5mGGNywbFov2uB+CTB/sxre5LkBeKqBJjt8bg41l+MvSHzeqBCqlg
         42OMLslRRd/49M8PaFkd57CyJ1+vYMOgUwWexzP+DmRlN2cLhyYGAr0T0nHhEevNXiw5
         HhmHsG891pDclpUeGS4oyiZe3HYoC+yUcUllP9Vfq5XEyZuTzbkN+60voSReHPP4OJqC
         msrZt5WOU3l8OSIJANL/fzjbuc71wGSHFUbgzbcgyapCWHZESUcCIoHc+s6AgBT/ZHpE
         9wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPTLDxE+Qpo8aT7LTAOpqv5zhoPUlSbtMdZx1FPPRU0=;
        b=FUZmiJ2fnUK7L2mRuahw7U6eK5GN68rR4RMXksLFUG5zG9My12ounVmNW3vlE8+TgZ
         VZRvlTL510Igam9mQsFpIZLFo0Jtv19b1IE6DmTCMvk2k3OZ9YuPNk/gafh16bv6qxQh
         /1x2ZsuNH7QGtA0w9uhS8X9LSx91/0ilpKbhq42y1F0qKOe+jZt/sS2btDfwgXAexX5r
         eC3pHAjDNRx+xHdJqviF3cN+T6cE65WUvKiWYqkY++kFf0vsS2GPAbcK5koHcpj55wdv
         xkgWsX+vG8DC4LyUNwt+YnnEDlNwfWtJ0yGW3fbgWqViM9x2pysBwev82rp/PMdatnxO
         lQmg==
X-Gm-Message-State: ACrzQf1t5usadsT9U1ais6Wi4paxW8phUCPby1JIWdjyuv2sbMGRB3X9
        pwtgZrtMhB22tPhVXG14T66HUw4yZnOmcXhz2TQ=
X-Google-Smtp-Source: AMsMyM48OcCA2gYFcA/RcNwDOizQrc3LxBdE0G5TfxDKc/yHB7qdTzV5Maj/wUmt1amULcoSuhkWww==
X-Received: by 2002:a17:907:2711:b0:7a6:bbea:683e with SMTP id w17-20020a170907271100b007a6bbea683emr25678116ejk.344.1666964158306;
        Fri, 28 Oct 2022 06:35:58 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id mf7-20020a170906cb8700b007aa239cf4d9sm2190907ejb.89.2022.10.28.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:35:57 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: leds-lp55xx: add ti,disable-charge-pump
Date:   Fri, 28 Oct 2022 15:34:58 +0200
Message-Id: <20221028133501.95833-2-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028133501.95833-1-maarten.zanders@mind.be>
References: <20221028133501.95833-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding to disable the internal charge pump for lp55xx.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 Documentation/devicetree/bindings/leds/leds-lp55xx.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index 7ec676e53851..9eb8d1017402 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -64,6 +64,11 @@ properties:
   '#size-cells':
     const: 0
 
+  ti,disable-charge-pump:
+    description: |
+      Disable the internal charge pump.
+    type: boolean
+
 patternProperties:
   "(^led@[0-9a-f]$|led)":
     type: object
-- 
2.37.3

