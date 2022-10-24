Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6D60AE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiJXOvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJXOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:50:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488A1109D74
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:28:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a14so13431110wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97PYge/1MTmObwJ7LXSqk7SH569eS9TzAoTm4p09NqE=;
        b=ozxe0mOn9EGDZvMKzeOdMD86FrhZjb1xYaPuoB+6ff8bXiHAL0VZWJmPm2Cjfo7t28
         vnsa87erDfablZGIiGSkzAHC1FZuLuT0sknv7QNo7qjCgRwhGgpKbwi9uS/FhnCmLW96
         RRgUqWoEMGqdAa9PuCuZSATiZW1D8kprBrW8bwwdp9lNDLOtM0w/9MrtaeLXHWyklgWF
         xIkk8gHKHrMmyCNijTxyBu8UfFG2oACXSikL5RPQ9SPLmJv2yTbr+cqGA5wHEpKg0BXM
         rTHiIvidbAaZiBkm/Feyw5nA6I3d4YL3UtHJ0gP+xXiZFmwVua2UUCiDIv9LdJ06gHRn
         JqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97PYge/1MTmObwJ7LXSqk7SH569eS9TzAoTm4p09NqE=;
        b=MbyuanbmuxwtGqlvcrxwAYTBXQ3y6U8pk7ICaA63NQIy2Y2TSPB/pu0+kz5klUoD1P
         OrrH4n8cxzrPnJ3TUbRlc73j275rhq7micblxXPVWJtsou4NERXu0m5mslH9tIwEY2Dt
         bGrAtYzOg0mU5Fz2c8cmdF3uBSjd90cYZt1eZv8fOP1gMqYlBF37UPD6mI7xB0PUUYDk
         1kmPjLFcLQtImhs/reWuM2l40hDU6VE7XvZ0/VNvQhRKs8TUsfi4EAfigpzHUL5xfpzA
         jqmMuBHJMk5d7atKxdRPXDnoA5bplppUe9O2g9ifjqrWLkFPJYbxhLFnijpVxzNTIZs2
         EUHA==
X-Gm-Message-State: ACrzQf1gYhC2oJpXc/ce9SS/eHc2Fzhcr2gmDvKPUR70tceqjaDX0Kcn
        sgM5QzP/evNhaPrK7ZHzOjAAJMfnyATIhkeJ
X-Google-Smtp-Source: AMsMyM4WtwquW4/J7jv44/X1hX48qBjqbYlqrlzQyCgMTaKDJpyW1NDhe1IVMdHGjvdWa4zBAYv3Qw==
X-Received: by 2002:adf:a4cc:0:b0:235:f41c:aa1e with SMTP id h12-20020adfa4cc000000b00235f41caa1emr15136314wrb.515.1666617378216;
        Mon, 24 Oct 2022 06:16:18 -0700 (PDT)
Received: from fadwachiby.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l24-20020a056000023800b00236627c078esm6322307wrz.110.2022.10.24.06.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:16:16 -0700 (PDT)
From:   Fadwa CHIBY <fchiby@baylibre.com>
X-Google-Original-From: Fadwa CHIBY
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong . Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Fadwa CHIBY <fchiby@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: soc: mediatek: pwrap: add MT8365 SoC bindings
Date:   Mon, 24 Oct 2022 15:15:41 +0200
Message-Id: <20221024131544.31219-2-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024131544.31219-1-fchiby@baylibre.com>
References: <20221024131544.31219-1-fchiby@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add pwrap binding documentation for

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Fadwa CHIBY <fchiby@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index d24e2bc444be..8424b93c432e 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -30,6 +30,7 @@ Required properties in pwrap device node.
 	"mediatek,mt8186-pwrap" for MT8186 SoCs
 	"mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap" for MT8188 SoCs
 	"mediatek,mt8195-pwrap" for MT8195 SoCs
+	"mediatek,mt8365-pwrap" for MT8365 SoCs
 	"mediatek,mt8516-pwrap" for MT8516 SoCs
 - interrupts: IRQ for pwrap in SOC
 - reg-names: "pwrap" is required; "pwrap-bridge" is optional.
@@ -39,6 +40,8 @@ Required properties in pwrap device node.
 - clock-names: Must include the following entries:
   "spi": SPI bus clock
   "wrap": Main module clock
+  "sys": System module clock (for MT8365 SoC)
+  "tmr": Timer module clock (for MT8365 SoC)
 - clocks: Must contain an entry for each entry in clock-names.
 
 Optional properities:
-- 
2.25.1

