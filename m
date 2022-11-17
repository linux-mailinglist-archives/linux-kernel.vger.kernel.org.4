Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5688062E659
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbiKQVFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiKQVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:04:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB1F905AB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:12 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z18so4386542edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6+ABKaCFT5+1C0Y5clbHMJQa6kjF8TIULfr4cCgl3o=;
        b=u4zUPtRBGTY9L9LHvnW9DqAWYRm0igVQllWoBz7XgHmcYSdMBuVAy58/lGWh4Dilqg
         1UGWqw1Tezv5eZIYrQAdS5o5Y1q3ZB5f7z3i9FiJjFpOBmoKbUvRPlKrhKORJiYDLCA5
         Pxu4VRIheLOlOvgE8Q7uWtouFjvgiuGkDdNjTP7dtEzfOp32WFKde4Sur0OYVYFhwHig
         ej/t/AXSZK8srV7eq50+nqPGqdyKShmDbKr5Vy2Pb5n1c1+TBEbgFx4xRQmV7BdicTpY
         2McR2oldXKaFyZNjoYkZerusy/kP6ufcoRqtvQa+Fw+QK38iG4Ra7be2auIaioimyX+D
         xsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6+ABKaCFT5+1C0Y5clbHMJQa6kjF8TIULfr4cCgl3o=;
        b=629ajSaPBsYYoVIPR5KWovfn877Il+QJDSaJ1lrrpiEDfHdcG4sKdNy3uXykizeaXM
         Dk8eJtlVXXyLUg3KMjaeteyC7DBtLESMqndJ6PrIoDtLAwQasb5avM9MJZHssirR41wT
         y5XiG1NaSDYY1c+1NdL6ttbmOOG67Hp2XYzPqf8E+lnL1d0T/HxOtIDsltdFzlhbDN3s
         NqICKLPRNlyh9+lx0KRLHCR6BhZjogQ0p20RS6cAdj4i155YbNozSvWcO0nh4WwFjDHL
         M4XcAbizypyChqjyccwjdB5HNi7WQYu5tK+TeNiI+R8G4ePCUulyquwlpQJv9Zm9H6UB
         gNig==
X-Gm-Message-State: ANoB5pl6kaeDfga5y52PBqWm7m7gsXjp7wBUBixFXaK/JW5pZN8bsbnz
        oU3lDQ/FaJdQAmYAF39MT4iMDg==
X-Google-Smtp-Source: AA0mqf74WUgvaOJMRkg/rYttZ/P7xDEgL2yEBGs7v+osI383w3rkMb4HYPZYzRoe7OA5C12sjAKUGg==
X-Received: by 2002:a05:6402:176c:b0:463:c5f7:fae with SMTP id da12-20020a056402176c00b00463c5f70faemr3583579edb.152.1668719049319;
        Thu, 17 Nov 2022 13:04:09 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7cc8f000000b00461c6e8453dsm970807edt.23.2022.11.17.13.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:04:08 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogiocchino.delregno@collabora.com
Subject: [PATCH v3 6/7] dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
Date:   Thu, 17 Nov 2022 22:03:55 +0100
Message-Id: <20221117210356.3178578-7-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117210356.3178578-1-bero@baylibre.com>
References: <20221117210356.3178578-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 939623867a646..3b92725bbc99b 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -34,6 +34,7 @@ properties:
           - mediatek,mt8188-xhci
           - mediatek,mt8192-xhci
           - mediatek,mt8195-xhci
+          - mediatek,mt8365-xhci
       - const: mediatek,mtk-xhci
 
   reg:
-- 
2.38.1

