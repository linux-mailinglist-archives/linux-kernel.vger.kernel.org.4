Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B54663EC49
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLAJWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLAJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:22:02 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFD886594;
        Thu,  1 Dec 2022 01:22:00 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so2656066ejb.13;
        Thu, 01 Dec 2022 01:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cg4h08ScbCmARXEsFqgc8N6O4NbradYeqRREoszyl4=;
        b=CXkqw4qUp3iF1c/VAFgMXTatfXdqW2qdLv/ri5wf4ff6y/bwMhcPTiZXL1x5LkU5Sz
         8Q3mRbIrRA7hlRTEfTFvkSh4JplJO/zNfnMvtjbXrFyqH4PZ7WpFjEnp/GBxXNwUR7GH
         EkCCEv4ab3AsoRp7+L1ILg70SRjD0TtXIjl5wkVTPpNUj+/yqoDESBjYRocrbG7qVSJg
         vVJbXbCSMCe9Dao9ZtUScNN9WV/YVzg1l6F9nWke00MhibBosR79feNatjZIYXSi/v24
         VFRKQvRE0AS0abToSBRu3BfhJ0c225w/p4IfxWJ5Np67Q38A5aicQ82QiqNr6PElvY6M
         QySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9cg4h08ScbCmARXEsFqgc8N6O4NbradYeqRREoszyl4=;
        b=Da5q08jiLNLYqb879IY42OVVTFOWTfftxLxUBt0ww8WJ9ZAg2vDVWE+9E+rH98cEd+
         BCSGHY/t4feOwoVdH3OyAGfD0AKKwSVG6fXBu9uLNmMppCtQl7IvdIjh02Ca5wiMUUEX
         ib9admM8v6wASoQ7Ef6mKU8H2q8n4UbI2D/eGd5dLuQKORiyqsbkpzb9xYeoL58tFk/D
         zS5LxhFz71tjanNE18RhXbvDWLZrGYYJqdVfXcpQgoVFmrkflePT/JdMXTh5FI8y5Wt+
         c6q13U2JxdLME6MkQmRrDjZC9u+Sx3RxiGLtwaHULLPCDa76ihE6KDCG/xEduA9pj/Xw
         iWlw==
X-Gm-Message-State: ANoB5pnctS+WUx+NBlteVUgRP+KX4KrB28RYSw4VXTaaBooJSJmEFoeJ
        yjoDSlF1CPXxAtz7VeLsVFU=
X-Google-Smtp-Source: AA0mqf4ntoAMYIY51L9dJw/8VGj7v7SAFWbpcSMtapJ99oDCgJj+l+3LtrhYBgp8Pss4X42nEaXNwA==
X-Received: by 2002:a17:906:a418:b0:7a5:e944:9e48 with SMTP id l24-20020a170906a41800b007a5e9449e48mr57172762ejz.109.1669886519485;
        Thu, 01 Dec 2022 01:21:59 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007b29eb8a4dbsm1587879ejt.13.2022.12.01.01.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:21:59 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/7] dt-bindings: reset: meson-g12a: Add missing NNA reset
Date:   Thu,  1 Dec 2022 10:21:22 +0100
Message-Id: <20221201092131.62867-2-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
References: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
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

