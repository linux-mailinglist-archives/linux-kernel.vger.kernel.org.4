Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C25629028
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiKOCzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiKOCyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:54:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1521659B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t25so32874788ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRYDzS6yAt4cpvGVye2SW5vgcMntnZG/i/Ggtx20GY8=;
        b=EdE8bFuG4EphbFKpcxdIIfm3ak/iOs7F6ye5Bw0bJUAMo88bMnH11/qvrugOAb0cLJ
         /8JttmWZG+cKt4QUAgJJ8Q8SHaInulLWvMW6KaIImNUEmVu+k/yR8haNYmvu71pxC6E0
         foS3sUTx6outGy/xCAtIryaY0bjeY64ogC9UuYet4q1kHfq8nEt6f2gkYlGqSDJY0/Wd
         RaU2nVc6RhuSy2gTRhkVbYNfaVF0J5d976lmTLy0BtAKvmGqBTYZFqRxyMLYhftYTB6M
         zrlWD1VNaVIuCBMowc7TKbtYCzBdfgbW/IgrERUC6ePilpBkG1ET56YiluIrKVUmBYLN
         e+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRYDzS6yAt4cpvGVye2SW5vgcMntnZG/i/Ggtx20GY8=;
        b=6BhL3MeQSXWZUCHLOKitq1tz+UZhiJMI+nj7ZROBhIYwHtyqKAjWuX/Ba+FI5pPcUF
         9Y7W5WJm/hDGtbTeSZHIfHiAtqcMPlcLaQMVTxRZcTes8RoDaYp6j4IGA1/mlfRKBRQB
         i+76I8uCXg5RKJKLlLyiiCCLSpX6NCB7H4ILXEuu4Vu/g1i/5fgeMqnoF91+TTQSfvoZ
         ei1lCYfixvWWdEUt6i3JNKnIyDepVQZLioLo9mm9/dHEMM0Y8NjOIhXIyGF59uAJTkDT
         ng/cKUx6U2kI1fQaTSzd7zZlD4tFN7ZW/NLlZHiSkt2Fmxuii+kWn6BJ6M5o1c/A0rba
         y2vw==
X-Gm-Message-State: ANoB5pnmYUU+CiVXJyCe3rPPV4zHBJLGhcSiIA9BkX6YEEc2wrMilVoE
        NHccIrlfkTODYCoAsLvxni7Bjg==
X-Google-Smtp-Source: AA0mqf582fgL1+vzC2joPQG/FmqgK3d7CgczhTfJbJeR1vCerfkmq+R4+r8ZixBzOGX3gC+jqC9F0Q==
X-Received: by 2002:a17:906:4a0f:b0:7a2:36c7:31eb with SMTP id w15-20020a1709064a0f00b007a236c731ebmr11503557eju.491.1668480874002;
        Mon, 14 Nov 2022 18:54:34 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d9a0d0cbcsm4861177ejf.72.2022.11.14.18.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:54:33 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Subject: [PATCH v2 06/15] dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
Date:   Tue, 15 Nov 2022 03:54:12 +0100
Message-Id: <20221115025421.59847-7-bero@baylibre.com>
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

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
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

