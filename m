Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF9629026
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiKOCy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiKOCye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:54:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A8115814
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id t25so32874684ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMx+8lnHYaoQJGJTnVIZj+JIYuaVktQaiA/S5krH6nY=;
        b=nWwH779Yad8VbMbCthQlgYkEo6VK8aaVP5klpz87p2A/ZilUOS5P1mvPCviRhDoblU
         dcquwc41Bw+lnHD8UD87tGcSOkM8KI7nUqFQ5I4pzK4/IE0ZjwpXB8m01WISHuBOoITG
         2eS+UMoQHcfes/7AORAM4G14neN5ET24bdSFF4CDiXA658PAkIYbHO6EwR86/PJZhaNp
         DXjv3rjHmL4CA1glBAYOqzLhs+zHoWryoJSsFc0uzqXYkbdGvgT6hIr3F6lvevkcpBBV
         OK8SnV0lzJ0cBz1ytKjrxBhQstItVDFINmq+XG4xK+IiBHWHGLGoF1A1gSuV2vltbVVB
         84FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMx+8lnHYaoQJGJTnVIZj+JIYuaVktQaiA/S5krH6nY=;
        b=G5VCT+Kc4/3wkbBkLEbrHh/5kL7iARoh6eT+/eMe7Aaov/+ZkKrSKflqJp0Iq5cOyH
         Rwz70XUo+mmeEdqWrPVK0JwFKLVnyZEMZrCk7fduGn2Sd3yALRueQPENGF2z7UZPqc/t
         9vkqY4U7eF+6RsucuR4lXVUijtPg7de4FApAuTWn6bwVFyOhw6vlVmtrzj3I6laq/U4n
         OJZnV8BYu/vPNx9wwEqlnGKqFcSR3HyeqY3oHEqEETWTzZHgGOICnvV/2Cfp7TevKX/r
         Ih5IefoLBWVokUJoWaGs9dtOkC2uhDs1VsNQaZX5yRWbu6dBTuBcmmO/XuTL2u5B9q0A
         Thjw==
X-Gm-Message-State: ANoB5pnOwV/AQ1CQR1hiTJr/RK+WFNVgZexRrYRBn06WavjEzRe8yTxn
        56Dxv2iU7RzUr0KaU0VSsjb5Vw==
X-Google-Smtp-Source: AA0mqf44yglbutt2AVjrjMYoluO69lhUJwJSnpH2BUmbB+rceVNA9A3KNZaaoX1cHShsIHoniDXmow==
X-Received: by 2002:a17:906:99d2:b0:7af:bc8:da37 with SMTP id s18-20020a17090699d200b007af0bc8da37mr3882187ejn.18.1668480872354;
        Mon, 14 Nov 2022 18:54:32 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d9a0d0cbcsm4861177ejf.72.2022.11.14.18.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:54:32 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Subject: [PATCH v2 04/15] dt-bindings: i2c: i2c-mt65xx: add binding for MT8365 SoC
Date:   Tue, 15 Nov 2022 03:54:10 +0100
Message-Id: <20221115025421.59847-5-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115025421.59847-1-bero@baylibre.com>
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT8365 I2C controllers.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
index 421563bf576cd..2cfed35bfd9e9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
@@ -45,6 +45,10 @@ properties:
           - enum:
               - mediatek,mt8195-i2c
           - const: mediatek,mt8192-i2c
+      - items:
+          - enum:
+              - mediatek,mt8365-i2c
+          - const: mediatek,mt8168-i2c
 
   reg:
     items:
-- 
2.38.1

