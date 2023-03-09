Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F082A6B2FB2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjCIVfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCIVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:35:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D43E274C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 13:35:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ec29so12667476edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 13:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678397705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XGnTW8d5154ClkyTBOCffDzRAqbcCupwBDkGcyCWzM=;
        b=TIl/6CQjvSe4YeVvY4cH6nV4V3PGDBL5sVSS2OedjbPww9taZoGpOPUNznjXflof3O
         9ELuphT7XRtnzvEHQtPjNucUPk1fNRtQt+5bupz3jYBwW2Fl0CGYdi8T6j0cJWHjczb4
         SzKbUiLoZeh+2uXMsnOs1vdxP1mj/6etFSodRoiVRUNSzP8A+Eo3uRsiMsOksw+B/5u2
         JhdnK/ZGPELQ8eYlPaC57jfkbUgWDpQndn2dktjEynHr+E/R2hvpYD6c/RwtCZlIJbxr
         Nw11h84dUQ8lhyJj69mqvQeqlI+yoBNGRfG6J1uTIJIwcTBDi/TugVZTyJMf81CGTyfl
         mxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678397705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XGnTW8d5154ClkyTBOCffDzRAqbcCupwBDkGcyCWzM=;
        b=AvArVi0feac6+MdbljRG0DqSUmHUMPqubC4cDgjMr+W9Ye2EhQVut2WJoaUkonFPf3
         lqUWA5f8MVcyowcu8FKNpExmoLhHdIHtAMJTG9lf5FDyAsHDhDSVQiCHcIucdGeNyd1J
         weuiA9Lh9YHg4RG1/wZSs0wuEK869AbAes5M4PGDnhHdKw4xPa3dqTC6OKy6v4E+onap
         v0FFo46BUtkYCer5leWfhRAJ7RVHA2OpnFwzrzFW9LzJVZuxUmcYV1PV+WqbAUb+1dFj
         PcTPoB5cUOcB2CaGYAnqGXzuVDKU7u0wIpkriECs5QKAYFGIgHoXbbnwqiGVN5tl6k15
         KxtA==
X-Gm-Message-State: AO0yUKVPCOcBzA4N9GRJ3js7ljSoOxxun1Ru6mWg/A/CTc2q6HeU2Err
        9R0viO/BKOv3i8raO2MyEq5/ug==
X-Google-Smtp-Source: AK7set+jVjANLAicrQHU3OMzrMX/odh2hvLIfV3/Xo9e7u17cIrpWkfMHBv2UrKmn5EX1/IPQjS6jw==
X-Received: by 2002:a17:906:1289:b0:8f0:4a90:a764 with SMTP id k9-20020a170906128900b008f04a90a764mr92340ejb.23.1678397705156;
        Thu, 09 Mar 2023 13:35:05 -0800 (PST)
Received: from ryzen9.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id 8-20020a508748000000b004af7191fe35sm211486edv.22.2023.03.09.13.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:35:04 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH v11 2/3] dt-bindings: serial: mediatek,uart: add MT8365
Date:   Thu,  9 Mar 2023 22:35:00 +0100
Message-Id: <20230309213501.794764-3-bero@baylibre.com>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <20230309213501.794764-1-bero@baylibre.com>
References: <20230309213501.794764-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding description for mediatek,mt8365-uart

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index fe098d98af6ee..303d02ca4e1ba 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -45,6 +45,7 @@ properties:
               - mediatek,mt8188-uart
               - mediatek,mt8192-uart
               - mediatek,mt8195-uart
+              - mediatek,mt8365-uart
               - mediatek,mt8516-uart
           - const: mediatek,mt6577-uart
 
-- 
2.40.0.rc2

