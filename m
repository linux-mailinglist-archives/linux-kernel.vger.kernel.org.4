Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A35701C32
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 09:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjENHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjENHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 03:47:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4A4271C
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 00:47:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso6058463a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1684050475; x=1686642475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay1MPc6F0iyKA9Pf+RpucZR4uy8JJBBnlfw3+ke13QI=;
        b=c9CtYou5DiDEv6nGqLhstt6vJCSMYNO/S5P96q/XqghzCd/gomUZ/HQlblodvKDIlx
         Oh7IWEW+tsTEg8LA5W/LzBt/EvuBWmj9hY/hVLGf+YbBIpE79aoUGOMJKxueqM004iu1
         f1NCXVfpxrDWOYWrCC36+PRLCDmBurqms4Vac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684050475; x=1686642475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay1MPc6F0iyKA9Pf+RpucZR4uy8JJBBnlfw3+ke13QI=;
        b=ZeY/g2o7+K/GXHKw2HmONAnS7efC6RJg2IoudvFaHlE8p3rZ6YISGOUu4NGcE1/UzL
         ugQo9fCYZHpK04Fp/y0gR4J5hRk2LZpUvNZQYcDD64qyIYCbwYw9Xb9tB+4dKmC8D0aF
         AhUKIVZYxjvchFCuCu4/19pM9OPk0vMbxmL/7vF7L4cdW27LmOt5T9gW0pc1x8SIUrK/
         cOZ9zUhDA6ETxtnJkQhkM16Mkffil7Tt5NOQMfPJ3fKDfJ8feeV9s9fzYS+/usmcTg33
         ITc3YAUsV9UKGzEBT6Z/o+MDILvCsh+Gd4/kRQaQOSY+hW+pEc+NB9WS4FTl8LrXohJz
         BgkA==
X-Gm-Message-State: AC+VfDwoezsl+zqpzlDVPGZq9jvKKWpVnRChmNWXttfOq1szrqHpFeQb
        JXRG4pq+zeY9auwiiPtl/tJzPQ==
X-Google-Smtp-Source: ACHHUZ7+GvsJHRM7m26GQl/jq/2g/yljHEAye1w4XghdoWhpKePYcISv5PAzlF6jy9GhkyljLOaE1w==
X-Received: by 2002:a17:90b:1bc1:b0:24e:2248:31c with SMTP id oa1-20020a17090b1bc100b0024e2248031cmr30507509pjb.22.1684050474747;
        Sun, 14 May 2023 00:47:54 -0700 (PDT)
Received: from 8add390ca20e.heitbaum.com ([122.199.31.3])
        by smtp.googlemail.com with ESMTPSA id j4-20020a17090276c400b00194caf3e975sm10903363plt.208.2023.05.14.00.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 00:47:54 -0700 (PDT)
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        anarsoul@gmail.com, alistair@alistair23.me
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH 1/3] dt-bindings: net: realtek-bluetooth: Add RTL8822BS
Date:   Sun, 14 May 2023 07:47:29 +0000
Message-Id: <20230514074731.70614-2-rudi@heitbaum.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230514074731.70614-1-rudi@heitbaum.com>
References: <20230514074731.70614-1-rudi@heitbaum.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for RTL8822BS for existing Realtek Bluetooth
driver.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 .../devicetree/bindings/net/realtek-bluetooth.yaml  | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
index 8cc2b9924680..d2103931fc1c 100644
--- a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
@@ -4,16 +4,16 @@
 $id: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS Bluetooth
+title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822BS/RTL8822CS Bluetooth
 
 maintainers:
   - Vasily Khoruzhick <anarsoul@gmail.com>
   - Alistair Francis <alistair@alistair23.me>
 
 description:
-  RTL8723CS/RTL8723CS/RTL8821CS/RTL8822CS is a WiFi + BT chip. WiFi part
-  is connected over SDIO, while BT is connected over serial. It speaks
-  H5 protocol with few extra commands to upload firmware and change
+  RTL8723CS/RTL8723CS/RTL8821CS/RTL8822BS/RTL8822CS is a WiFi + BT chip.
+  WiFi part is connected over SDIO, while BT is connected over serial. It
+  speaks H5 protocol with few extra commands to upload firmware and change
   module speed.
 
 properties:
@@ -23,11 +23,14 @@ properties:
           - realtek,rtl8723bs-bt
           - realtek,rtl8723cs-bt
           - realtek,rtl8723ds-bt
+          - realtek,rtl8822bs-bt
           - realtek,rtl8822cs-bt
       - items:
           - enum:
               - realtek,rtl8821cs-bt
-          - const: realtek,rtl8822cs-bt
+          - const:
+              - realtek,rtl8822bs-bt
+              - realtek,rtl8822cs-bt
 
   device-wake-gpios:
     maxItems: 1
-- 
2.25.1

