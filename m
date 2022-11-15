Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2822162987A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKOMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiKOMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:17:06 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38950222A8;
        Tue, 15 Nov 2022 04:17:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so10131675wmg.2;
        Tue, 15 Nov 2022 04:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUe8lFT1PO6t0RHz3c472gi2hb/HbBQTLPLTxNTDuyE=;
        b=RzAhfd/4Jz14IEg2r7uhegD9SmVBa4THlriXt2QlmPgkOTJWstANj6FNUVWO86/4Km
         xEsQ/BDwh6Np9Dex+aMTSRQK5U6yGi29RBYp95DSLEi7lDsGDzuqQG5ffLaLz99x4kjn
         NR9N4bqTsV0LyPPQv2TwxjgxgMOu68jqqoQEyNEngYjSKUShtz6X81PfidG1hqi0WR4u
         cXujNlL0hL8By+5CW4h6opIkSw2Z39jy8MA65Tl4O7ZfO3ZyQD42xePVLIC1xR6wiWG/
         /lYuPGo/7dT3Y7zD6QbekmmDAetDv7ZvdKnAYv3sYkfkgrznXgLsSsmPFnMKgXOUX4SY
         PnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUe8lFT1PO6t0RHz3c472gi2hb/HbBQTLPLTxNTDuyE=;
        b=KgS8rHjaqcUAlismAFRmcFCFUWrbxT43jm6e9DkuZSf3GOU6RH1sIma4IFwCvDS9MA
         1DTPNL+nQHb75WBeN+4NBJ0twdd0mMxV1JSTZQHcs/upojNR4vF8BHq45TultbWkxpne
         NRUpj+IaVLwZxAsefMZDcWG3DVt6yRnQCsjs4mg2O7Nm57RYh+yF6e8N2Z/ygjKTDnCb
         ejv5gG69+IWJKsdzbR4aWPAAZSJPLP1NEqnPa4gXVU5jmOAQYlPvLtgUmZc1mYHXRYvX
         ozYXMODesAvZT5j5WzyTUV1wPP5GVBz012Yfji+fi2clUeC09brzFm/eS/aIGCMxRr1a
         Sd0g==
X-Gm-Message-State: ANoB5pkbqvvWzJnUcIHRUh7xtKLu4stftqO95i1EJAm16nYsRyoKsRr0
        Qqru3vqbI6Zo+FMbZ8fY2fQ=
X-Google-Smtp-Source: AA0mqf61QrQpnJxv5nsqKcx0FJmy+yQeReHZAJ+sNDhQ29TRVFCpYDSbdf8I1ZQUL4xflpmLEVfw4g==
X-Received: by 2002:a7b:c394:0:b0:3cf:b545:596 with SMTP id s20-20020a7bc394000000b003cfb5450596mr220904wmj.49.1668514623751;
        Tue, 15 Nov 2022 04:17:03 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d94a:6345:c378:e255])
        by smtp.gmail.com with ESMTPSA id q13-20020adfea0d000000b0023677fd2657sm12124907wrm.52.2022.11.15.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:17:02 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: thermal: rzg2l-thermal: Document RZ/Five SoC
Date:   Tue, 15 Nov 2022 12:16:29 +0000
Message-Id: <20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The TSU block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-tsu" compatible string will be used on the
RZ/Five SoC so to make this clear, update the comment to include RZ/Five
SoC.

No driver changes are required as generic compatible string
"renesas,rzg2l-tsu" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
index 1d8373397848..03f4b926e53c 100644
--- a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
@@ -17,7 +17,7 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g043-tsu # RZ/G2UL
+          - renesas,r9a07g043-tsu # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-tsu # RZ/G2{L,LC}
           - renesas,r9a07g054-tsu # RZ/V2L
       - const: renesas,rzg2l-tsu
-- 
2.25.1

