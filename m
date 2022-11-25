Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13C1638888
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKYLTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKYLTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:19:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8626027B0F;
        Fri, 25 Nov 2022 03:19:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t4so3200097wmj.5;
        Fri, 25 Nov 2022 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl6GRHmDwXTkupYiop0EErlDiZv2DZKUPdgh77pu4+I=;
        b=bZvwjPkKOEGihx59nh4uidHxJrPCbUvQpYbhLXdUzPswveM4bbAPcx2AfxM0GxV65U
         gEDxIVX1v9Ahnj1Yxqm35oOORkIy4ObbLnK/GSiTO0PVWoPCbRuMZhvsiiy8kkgofHPm
         6WF29o678DSOo0RmjuQRDFhajdlDXOUPVM7AU5JcISGjOEmLQdzbDS3YpboMZg6VV2U2
         4kkFW027bQRBKNRpgLK8TCft8ddSP89OssBzRGzXgQX3ay1lAnkuKvIyW6hE/stdHBFs
         3hKVB6i25eax2KFRBW7V8RLz4yWrxjqV6UUVUJYKiDb1nV0Vy0REj6EAqGxSWjAH0UMA
         l/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fl6GRHmDwXTkupYiop0EErlDiZv2DZKUPdgh77pu4+I=;
        b=gc73ITkphA4jT72cf7eqJdZMTraDGN/j4UGlqRx0D/5rCAe3Dbxty1xMFJyxchruoy
         9+O8G0CPQ+EdSQRwolobbr7RFhWw56l9CJJUU7SDDwO5bSTXg3pdWL6sJNiFbHmYZQLc
         A2TgWz4p8jrGhomePZD5yMTG82yYf+Txy8BOufYPI4lPA6SQ3rKANFkLJXYh4L9K/Wbn
         95744nJHRAarQx6d6xHZ5vHd/37keVRTV0dp6UXbUTWh5Uw9WIClnU9tRQWcuSInOUu4
         Zru3GRmPMEYY2ihTlWenMGKYyZ5nba+9X9E7Rw7qpJG2CeMxYicS5s70GMFiYo3LRdqu
         u99Q==
X-Gm-Message-State: ANoB5pmc4cn5m5O3psiMggh3TPNDkwkkRuUPVtjyS5SQ7W/BvNrYE4OQ
        cQJiq/SG5HNzAtvVl+AZvY8=
X-Google-Smtp-Source: AA0mqf6eAtIlDdCwbMKZ0vP7/JzHXc++3weMINUQ93oarLXwbQKfH/KLvspYKAT/dQ+fAFQJlQrQFA==
X-Received: by 2002:a05:600c:3b18:b0:3cf:6ab3:49ce with SMTP id m24-20020a05600c3b1800b003cf6ab349cemr27089016wms.137.1669375181147;
        Fri, 25 Nov 2022 03:19:41 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4b0b000000b002368f6b56desm4207406wrq.18.2022.11.25.03.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:19:40 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/6] dt-bindings: power: Add NNA power domain
Date:   Fri, 25 Nov 2022 12:19:15 +0100
Message-Id: <20221125111921.37261-3-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
References: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 include/dt-bindings/power/meson-g12a-power.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
index bb5e67a842de..93b03bdd60b7 100644
--- a/include/dt-bindings/power/meson-g12a-power.h
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -9,5 +9,6 @@
 
 #define PWRC_G12A_VPU_ID		0
 #define PWRC_G12A_ETH_ID		1
+#define PWRC_G12A_NNA_ID		2
 
 #endif
-- 
2.38.1

