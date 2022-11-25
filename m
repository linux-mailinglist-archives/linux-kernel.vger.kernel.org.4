Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D38E638886
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKYLTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKYLTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:19:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8542610A;
        Fri, 25 Nov 2022 03:19:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so5955098wmb.2;
        Fri, 25 Nov 2022 03:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6QrfFFXtNlfuBto8kS1m3+IbzT51Etpw/eL3qE3JO8=;
        b=lXKAyknG4+JDmB/LJpN2yOCEJBAq3k/M7HDcwVevK57TjYwrpkqQJ5mJNbKZwI0h72
         jx1YdOf9zGEa0d5zwA9uOX1+ZvK0+tsQ1ZQ8Uu0SrvYMPMS2q05usD6mcGDWhwSErc6d
         NRm7+RKqRrV7XpJtoJk+WHIWLaSiW4cNoBYZzSrh0eBPCtsUr4KiMOvU5nyQ8pNEK4im
         ip1myN22+2jiA/1f2OC9Qp0lvw/ssJuqBuL4OF4TkRibh8ksA0fBl/xkzQ2ZUSCg+Csf
         u2lLkAQxVv+DHEnGFnobofhfBljK/T+tY1ZYQGSx4AagFggeHGQie/NjrENbigP114Og
         moFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F6QrfFFXtNlfuBto8kS1m3+IbzT51Etpw/eL3qE3JO8=;
        b=U9j87dHtaxKEAa6iUd3H3GiqMj2AggsCnb6iYYFkFbtjtRsD4q73ykEaFEcoIxdG7B
         TtnNVdnhLDgNP96Gh/dj66Hk1sCr1dhXburAGPD0223k2acwXUzn7Y9POqfnKipigr7W
         LaiI+bkBfYDN/aTU7cAoWVTo9ByQLtYCdYZI1X8vX8YywVVGTWBkQCvltmNTcw+VVhlR
         9Xz8FQITyowi7DZ9hIMtRBccJ1r+OScoGlHcqCxtgzcpDNjt0+cn6pVL8QFHWeoN3TgF
         eIkkfHZak8Z3ozIMsnAEJveb7WTDLNMcfs6LW1EW2V3jedu8BBFoFyoP4rLNqchKDZ5E
         i7Qw==
X-Gm-Message-State: ANoB5pl7TPG39ldVcMe2qAjUNs6rIQ4sBjFbVZ4+Q23h+Q++rVuqd/QQ
        6aVNSWgt2/DftTwlnf6qf+k=
X-Google-Smtp-Source: AA0mqf7pcrgOzZ/Xdkx5TuOPEIv5rbwc/M6UlPSODP8J5pP43i7O6QNDznC+UoB7Ri6TENZClzZaTA==
X-Received: by 2002:a05:600c:511c:b0:3cf:6c05:809e with SMTP id o28-20020a05600c511c00b003cf6c05809emr14530954wms.74.1669375178519;
        Fri, 25 Nov 2022 03:19:38 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4b0b000000b002368f6b56desm4207406wrq.18.2022.11.25.03.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:19:38 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: [PATCH 1/6] dt-bindings: reset: meson-g12a: Add missing NNA reset
Date:   Fri, 25 Nov 2022 12:19:14 +0100
Message-Id: <20221125111921.37261-2-tomeu.vizoso@collabora.com>
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

Doesn't appear in the TRM I have, but it is used by the downstream
galcore driver.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 include/dt-bindings/reset/amlogic,meson-g12a-reset.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
index 6d487c5eba2c..45f6b8a951d0 100644
--- a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
@@ -69,7 +69,9 @@
 #define RESET_PARSER_FETCH		72
 #define RESET_CTL			73
 #define RESET_PARSER_TOP		74
-/*					75-77	*/
+/*					75	*/
+#define RESET_NNA			76
+/*					77	*/
 #define RESET_DVALIN			78
 #define RESET_HDMITX			79
 /*					80-95	*/
-- 
2.38.1

