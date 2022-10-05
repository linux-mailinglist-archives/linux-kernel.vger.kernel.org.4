Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA05F5946
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJERoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJERo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:44:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39287F10C;
        Wed,  5 Oct 2022 10:44:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay36so11252201wmb.0;
        Wed, 05 Oct 2022 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vXh3BxCd3UR1/+WjnZXctSKss7l1jK9ZVA3CPpEkeRU=;
        b=pQU0bVQHqs3y8H5Gc8qcusH69fCC7CJC8gFA/XWJsVSLmx15qzHkgLOem0Z3/DFOxJ
         GmS/0dzjvbMtHHHV9LJpW8HIvwEFDlolqPee4YAygr26A3pS4HPqWWqFB/wT7Uv8HJxT
         rysFqkHvsxjKFd3am2tfYxddB+4eNMIgWDQSgBP9S7CZ7rQwzKX4teyHBmcmcyK7KuyU
         oZSoC20kyMw3/Zs3nF/c+zlksnbZf0l735xkSGutgPNtTLQMlDhMpmgn8OJg8/z9A09H
         hG7l/dwdtc4zClnBU/CGaf9FJSw+dx5dleZ9eCDktGaNI+5a+yvSvAj5aQXgZNT13v5l
         LsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vXh3BxCd3UR1/+WjnZXctSKss7l1jK9ZVA3CPpEkeRU=;
        b=BOtScPF7RsnHeTOCNTRqW6XSpG3z+nankCVkVZTvcXW1J/MmxomnDcPaUspyF4NMPf
         D3b6x73YVUdbUA5y2fj7j7ES2rA+qW4HG+CYGIozuHcEhq1yu3Pz4l93I0o7mkLExM3L
         qTGdnqkqPBcgC4VJS2lbW3zTyWXpxcC7llNDTR+ltaT/5n6k9YHEthYJ5c2DTn85tCiZ
         BJkM3ZfsLBVNm6eIKqlgHwe9kmzn2N2i29KUYEbOyvn7h1JjGvAPPtjHw3TJs4X0VI9h
         V7Xr2qKFgf2+qSkRqTUOUBA6/YyosE1kJZlReRUOUJiIQMq5U3YHu2Czc+pOeGuOFJuH
         XW4A==
X-Gm-Message-State: ACrzQf1R7WzKSdFLRVqQN3H5Sm7WARj2jODrRgi+A+FuKEh85cz6JwNN
        N8hkpbE/oPxSoaEU3x0hG4w=
X-Google-Smtp-Source: AMsMyM7SGMHRmQPQNPDZTLXjXHJw2JOTQjWqlYWILhe1UsBmIUdBty7xdVg2s6m1Fm3NF8/JPQ8u2Q==
X-Received: by 2002:a05:600c:1f06:b0:3b4:86e8:bd21 with SMTP id bd6-20020a05600c1f0600b003b486e8bd21mr468229wmb.7.1664991864127;
        Wed, 05 Oct 2022 10:44:24 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4146000000b0022a403954c3sm16075491wrq.42.2022.10.05.10.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:44:23 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Fix interrupt count
Date:   Wed,  5 Oct 2022 20:43:38 +0300
Message-Id: <20221005174343.24240-6-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221005174343.24240-1-y.oudjana@protonmail.com>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The document currently states a maximum of 1 interrupt, but the DT
has 2 specified causing a dtbs_check error. Change the limit to 2
to pass the check and add a minimum limit.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
index 73ae6e11410b..483fcdc60487 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
@@ -47,7 +47,8 @@ properties:
 
   interrupts:
     description: The interrupt outputs to sysirq.
-    maxItems: 1
+    minItems: 2
+    maxItems: 2
 
 # PIN CONFIGURATION NODES
 patternProperties:
-- 
2.38.0

