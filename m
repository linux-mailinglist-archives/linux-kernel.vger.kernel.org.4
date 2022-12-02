Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438D064062E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiLBLxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiLBLwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:42 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF5915811;
        Fri,  2 Dec 2022 03:52:39 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id fc4so4039069ejc.12;
        Fri, 02 Dec 2022 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpYJc8YISu2BRlH3hvxZv0fOIwXysejIA3F+djx3hbo=;
        b=f7b0KJLVs/0oskAJftN1Qp6QFdvpMjsxCbNbiw0zdeJ72tKWquaI5caqW/LDnVfhR6
         qJE/N6ti/sPb37MKmE2J/YRHHtMYf8XzCrwNN6Ke0peHMXKrCYhfIgGPjcuQjEynX7vN
         +kkZBsFOtGrX1xrJxn60nO5hHLeUJirZu/2+KqNDANHoqK7k6ipCIyRLqSAb0Ziiv4Nt
         0DWFlY+mVPZG1/1OnMG9Mqc4ys2wu0LJA08/RlR4xs0s8ZQ4kdsKne2bVNbON9vRt3DZ
         XGhIij0pQQD5Z9GvAKmms2+JemxRJHrHirV+kRiopMh9nuFp/C26GaAFMpNNAi5cGu/n
         oBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpYJc8YISu2BRlH3hvxZv0fOIwXysejIA3F+djx3hbo=;
        b=jrJ9fOy0/LvQDufSPMkuB+yOSGsYclrOR/3SAD+Jktfo/tnNzDBeMZUEg0WJUDXTtF
         k0KZcL6xzv9nfIzjXbi1igjgwBr8sOqdVNbcT36U1DcV9CYidocsQeJ7/tV6gOEmMeBN
         F6wxNYNl79USFHh7HB49W7dj7YpDEXDgU8fBausJKTDWfwtNJJ3Bgqh8pI9PJS8ewp+g
         7QOjcQ1IL78KHoQufLAv6AQiDc/RkB25jHAEr1YUPIFgOAF8dmTZxSHUVimuSqYJpAX1
         T54DYyY+6qep8M/1YE3hXUQhxS3Ka5Oo9JHj0QuotqO4+OoE9coEBLRAR6jURGjtJGIU
         RsVw==
X-Gm-Message-State: ANoB5pnPKTamGvaTU+IlS8TNjls8BlbDf/TFV3wEXP4uOqmpXJms8ABH
        Y7ywVyQ4kb0kA2bhSaF/Ihm1VEV9QwM4jQ==
X-Google-Smtp-Source: AA0mqf6nsc6YYjKGVTd3lWG1CooxDXTgbjwEpGKczarRIZtXYEjv/A+Z7GaUd+d2lI3Yo0V2wBadoQ==
X-Received: by 2002:a17:906:c2c9:b0:7c0:ba35:b9ec with SMTP id ch9-20020a170906c2c900b007c0ba35b9ecmr4229488ejb.687.1669981958335;
        Fri, 02 Dec 2022 03:52:38 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm1206762ejb.41.2022.12.02.03.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:52:37 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/8] dt-bindings: power: Add G12A NNA power domain
Date:   Fri,  2 Dec 2022 12:52:14 +0100
Message-Id: <20221202115223.39051-3-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
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
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

