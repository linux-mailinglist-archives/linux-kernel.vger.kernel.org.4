Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8C16C3B50
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCUUKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCUUKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:10:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BD42278A;
        Tue, 21 Mar 2023 13:10:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e18so3408779wra.9;
        Tue, 21 Mar 2023 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679429428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csPGK0TWyrblGaU2v5rP7OM4tMKhIMMOEo+dKBDUlxM=;
        b=CM+07WX8kDSichtgGVeeC35gI1J2+jom7KiqyMplH29+62EeLgLhf8ecrmM5E5Ffzu
         xC84rkOA1l67XEA490UBK1eJtGi+A9WFN1wWkXVSZJkCTfg2Pwy7lKhQXEfmKL6I9bWa
         kL3aH3Wr5iE8LEcuRH9vyaIGDJU0uoGBjamzK1JXbIUs7UezJFKJ9ldm8OkF52G26exl
         MwJEPwU1S04RLnlB04oOi2dS7x+lJ6siH6IsqrRJV86RmdAzfdcZ4dogx5hPsP0tcWyZ
         FxWkgU4pPX8kLCMjzVxNbV3ux4K8znvOShnkXK3e+h21vSHj9XFQfXvuS+2SPcfkNDVO
         8khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csPGK0TWyrblGaU2v5rP7OM4tMKhIMMOEo+dKBDUlxM=;
        b=B5wo7v4RauunIRkfegmaLqneR+7q48hU76s6L18L7ErukAkf8QSrHpVPvYL6zXpL8+
         Iptf6guHSOt/ZqF6qdHzGG1TAklaVIrENPEZZHlOTopmkQJIh0Q5TgVJ2kKuNq4f5Vuo
         /coYFlDP6tuY2/g+C1pX+8wYNhkzX2XppyTDB60K36d/CkbbvPE3xzQEM/s60exqVy7E
         GMv8bC8/ROSCwuCPrKvBVhovaD3sgYR0407mHr+60+lMca37X7bobeSBjAJuOlW3puD0
         BW49MvfBnKsKrR8/m2Bf1aCh/DdfAsBQqOyofUc6ynzLRdaAu2AQCOGYMx+i1r6eujlY
         h8FQ==
X-Gm-Message-State: AO0yUKW1hcN6EML4mdrP6zaE6dghSCqQeSL+xTbWAIjJFbStvAVb/hw9
        jD5DGysQ+Dc/5Ozrd/Jgd7A=
X-Google-Smtp-Source: AK7set+MlRcBfqCvuCChX8ua/5CwJtIcpB2g6zidWNwnVkcSgsX5Xer1oTxh5C7n5dWO84thLzbuVA==
X-Received: by 2002:a5d:590f:0:b0:2ce:50bb:dd11 with SMTP id v15-20020a5d590f000000b002ce50bbdd11mr3098755wrd.27.1679429428203;
        Tue, 21 Mar 2023 13:10:28 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b002c54c92e125sm12107693wrr.46.2023.03.21.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:10:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        william.zhang@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/4] dt-bindings: reset: add BCM63268 timer reset definitions
Date:   Tue, 21 Mar 2023 21:10:20 +0100
Message-Id: <20230321201022.1052743-3-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230321201022.1052743-1-noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
 <20230321201022.1052743-1-noltari@gmail.com>
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

Add missing timer reset definitions for BCM63268.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 v3: no changes
 v2: change commit title, as suggested by Stephen Boyd

 include/dt-bindings/reset/bcm63268-reset.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-bindings/reset/bcm63268-reset.h
index 6a6403a4c2d5..d87a7882782a 100644
--- a/include/dt-bindings/reset/bcm63268-reset.h
+++ b/include/dt-bindings/reset/bcm63268-reset.h
@@ -23,4 +23,8 @@
 #define BCM63268_RST_PCIE_HARD	17
 #define BCM63268_RST_GPHY	18
 
+#define BCM63268_TRST_SW	29
+#define BCM63268_TRST_HW	30
+#define BCM63268_TRST_POR	31
+
 #endif /* __DT_BINDINGS_RESET_BCM63268_H */
-- 
2.30.2

