Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EA263EC4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiLAJWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiLAJWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:22:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D585679;
        Thu,  1 Dec 2022 01:22:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f7so1506026edc.6;
        Thu, 01 Dec 2022 01:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIHeFovEuwjGuythdoubrFT/SXANkAJoc/lUtd9ZW10=;
        b=T8NMw0auTX3nVwIJOBEXOMKh+uqx8TL/MfgsQaHpXiIPpHbTluYVT5MbwoV+eH/Mwl
         aqCvSWODpNANYQEcN63jk0hAhV3rHpzhzuEZhLJYxzV3wogr9KE58ZfFLdqTumxU64Ah
         x4H9WETB8elERPDbGGTVLAbok1wt5d0RWcqQXOs1udLnRqd4lM5q4/Su2WpKE5VP35Cf
         XZCLXa0N3xi2YEDA/Ep+KNM5t9fSPxhIkOTQH01L2wOo6SVwXctSxX+BtCFPPxA5Cge9
         umbox7LujP/qN+0OAsIz5/AU9jGE1SjQhJeHw/WLhEbzpYfWAShi3B5wD02MZTDaQXI5
         UVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IIHeFovEuwjGuythdoubrFT/SXANkAJoc/lUtd9ZW10=;
        b=5blYqe3G/RcosCvZ32CZEIcCqmzvhVq4rBrH9bxEEmsuT8tF4U9PGc0shRkAiwEpv5
         t6RLNiNw//hfFWkD2lwdrvOjZL7i6rj3O66JWJ9PSZ5ski+pZ/yBOOybkV8Z2kYYH8jq
         4TbnvleJfEkY1bjR9MoMARknKKtYzQl47UDeXQTRO8f+pnyWmBw5jEh6ZQHz5aP/f48t
         RjB9zBKQXaa1CcmTqQ/YwuPhZnyVtMmBKAl9gabvFIWgYYRbqz/AyKY2Kc9uYSh6Madq
         xGBNKo333fsawqgaq8IgriQaD4Q4a3/UpWoA4QkJ8PkLSdfX+0rxc2JMDOi44rEydBw0
         w0Ig==
X-Gm-Message-State: ANoB5pk0I/PiQG3OJRNmMw52hj4WZw8X+x3Xm/x1BAuMSLcFodD8myMq
        aKFGeArboMPRQO+hJjqbmxM=
X-Google-Smtp-Source: AA0mqf5pb8aFIA8ELC14wWkc0BpA3jtfmG0vYDIKXKX3zZ1MK+of5ZM9eNc1qHqbitu8LkqX55N8DQ==
X-Received: by 2002:aa7:cad7:0:b0:459:443a:faf4 with SMTP id l23-20020aa7cad7000000b00459443afaf4mr59471545edt.297.1669886521955;
        Thu, 01 Dec 2022 01:22:01 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007b29eb8a4dbsm1587879ejt.13.2022.12.01.01.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:22:01 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
Subject: [PATCH v4 2/7] dt-bindings: power: Add G12A NNA power domain
Date:   Thu,  1 Dec 2022 10:21:23 +0100
Message-Id: <20221201092131.62867-3-tomeu.vizoso@collabora.com>
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

Add define for the NNA power domain for the NPU in the G12A.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
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

