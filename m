Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09763BC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiK2Ivl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiK2IvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:51:14 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E53756EC9;
        Tue, 29 Nov 2022 00:51:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m19so17578168edj.8;
        Tue, 29 Nov 2022 00:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cg4h08ScbCmARXEsFqgc8N6O4NbradYeqRREoszyl4=;
        b=OZ0nm34nOouWCtBLY5YQkfcXs5+gKWizxqRw4mpYirXfqgwxJKt8opypNNrkdrw8kE
         huRl4/2p57YfjPf+jIM9y6hfA9SAHXcBmUuf74fm30MwJ57+R+Prx9Gm3+xRPSLP7fdt
         DWJPCSW6DmbRLCiUrZ12qXYoyeILY/IkZm1rxzRKX2+KaoMxYseos1KGxMfU2odKqmy6
         Kn2GhZs3dvjc6THp2I27gHqgVxI7Hq/P0RRxBJNpKYSvuord2DiCNUVYwUJ1pGKmmwYN
         tVTlTeAhVLDlbHgt9Y86FIiGccMsQ6RcLYfeMoyQL9H1qttiH7srDmsU9pcJgJH+KjGR
         UJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9cg4h08ScbCmARXEsFqgc8N6O4NbradYeqRREoszyl4=;
        b=tPad5vlDotZ8K9AocXLUv9AVHjgj+4fjoeUs3BqHATDxGCwL4fV97ugbz6a4ABGB9v
         /NgLjRxLw8TP1W/ZC7SDnSKs1ebRRAXR3Ba3l/7ptSwRUHW4Mvz8Ad5X0X1xZlWhiBBI
         0OC5IVuo9GMufzBU46jTew1m4uYFVg2h531OGG4ioIiVn/OD77jEqM6jbZ+dkXz4QQnN
         egHWEzmNnAA4iAwm8i/8PY/OKo3Sj0gS+/jR9lZLDM61NmXK4C4wJxKxP6dGIgzQimYd
         O+EKkxoqdsZC1WAv3J5jqTuELFkUYWEl+hM3GpMA+e9/Lxtb/P/flaevxuzB7qGKcZ1q
         U7Ww==
X-Gm-Message-State: ANoB5pmN45dclWfXZeqswShL6Sh054jR4T10VpgqQ1iXP0oHs/y7+XFe
        Bf0XB5cs+I/5p/JIgTh/mxs=
X-Google-Smtp-Source: AA0mqf6zBSi++3r4XX3e4bljQj59DYt7fFuQPepG/7qRf1barG5tfUFiR49fDNl2+4m2ca5nK8AiIw==
X-Received: by 2002:a50:fc10:0:b0:464:2afe:ae18 with SMTP id i16-20020a50fc10000000b004642afeae18mr52242994edr.183.1669711872698;
        Tue, 29 Nov 2022 00:51:12 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id kz1-20020a17090777c100b0078de26f66b9sm5873219ejc.114.2022.11.29.00.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:51:12 -0800 (PST)
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
Subject: [PATCH v3 1/5] dt-bindings: reset: meson-g12a: Add missing NNA reset
Date:   Tue, 29 Nov 2022 09:50:41 +0100
Message-Id: <20221129085047.49813-2-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
References: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
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

