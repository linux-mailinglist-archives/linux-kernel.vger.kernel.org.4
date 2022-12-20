Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F106526C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiLTTJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTTJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:09:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0EE0C3;
        Tue, 20 Dec 2022 11:09:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so13133270pjj.4;
        Tue, 20 Dec 2022 11:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1OBgH6qhxVhNETTJtpKxpJyJJwZSaJxAnc72NIfU7q8=;
        b=UKLuyNP1k8kPnnBJmVy3aAk0U+W/95TQoufIGcDgjVFiLwIeIk2TBu1oY/qGg9+tud
         IB50e+biUVM5s5wt5rOswlQCHfqug/M2Ei7YRJOChGAiCW2B4Q3XKxOMFSU5Vq4eAxvx
         OK7eWudtHiUpS5Wtkd4Xwv9pbZRhA1lesJRxUKlb17aIxaAtIyrrBiwQHZk5NWEJjKxR
         4NyGfKSLw8Bh1b9z72YGiLMcOt42EfNFO3niBDtur1JAstaVwgYTMI1tnjRzrSFQETl0
         owZfWzbGPktA8S3I9qm6WGr1sSV1Omz8vD6jATxZRZbYoXB/EABKjT4O5faxS86UgOqg
         WVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OBgH6qhxVhNETTJtpKxpJyJJwZSaJxAnc72NIfU7q8=;
        b=YujHYemoKBQidgO8QyGYOJUdCkObKQlNoh3Rf1uujj3GjLKtUYjpMAeDPGgqXZTbvd
         hDdauuSlWImcrnHXyCqD89v8q6aflep/CQK4R8tcMEETkiE1phxo9J6u6f/gp6p6RKQy
         gexOyXMiXemDwsDon/6DvGxh5QtLDrptIdbFNrNyAXYDbJZlU1OiKf5t8ljpXpVDdeq9
         ThCvGqvVlSN/rtnn/4DenmpoBnax8KjHXTvfD9dLs8SuqkuDScckmRqooBy4FQ5D2lpe
         2OTXYeXcGC35+3S3GUJOlJzlzFgBYPf+W+kXGQap5pgKthXLP2hTPI6WVbORDsP0Byv1
         DQtQ==
X-Gm-Message-State: ANoB5pn5HaMDGG+RjDpKwTlYQa3F2zYmkeVOppLGKYIeDvw0eaJHpIF3
        vOqitqA/vvrezd+CrEUudqM=
X-Google-Smtp-Source: AA0mqf44hNs+GUi8hvM/wSk9nI9bt394TZ0kMyNtYXB/FndXQ6XulwJXq8q6c9Sbnw3nHrI8Qeo5Jw==
X-Received: by 2002:a17:90a:3188:b0:219:3e5f:2a65 with SMTP id j8-20020a17090a318800b002193e5f2a65mr49327344pjb.36.1671563363053;
        Tue, 20 Dec 2022 11:09:23 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o37-20020a17090a0a2800b00219ebdf797csm11358864pjo.24.2022.12.20.11.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:09:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: dts: bcm63268: Add missing properties to the TWD node
Date:   Tue, 20 Dec 2022 11:09:15 -0800
Message-Id: <20221220190916.2681165-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
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

We currently have a DTC warning with the current DTS due to the lack of
a suitable #address-cells and #size-cells property:

  DTC     arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dtb
arch/mips/boot/dts/brcm/bcm63268.dtsi:115.5-22: Warning (reg_format): /ubus/timer-mfd@10000080/timer@0:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
arch/mips/boot/dts/brcm/bcm63268.dtsi:120.5-22: Warning (reg_format): /ubus/timer-mfd@10000080/watchdog@1c:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
arch/mips/boot/dts/brcm/bcm63268.dtsi:111.4-35: Warning (ranges_format): /ubus/timer-mfd@10000080:ranges: "ranges" property has invalid length (12 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 1)

Fixes: d3db4b96ab7f ("mips: dts: bcm63268: add TWD block timer")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm63268.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm63268.dtsi b/arch/mips/boot/dts/brcm/bcm63268.dtsi
index c663efce91cf..7b788757cb1e 100644
--- a/arch/mips/boot/dts/brcm/bcm63268.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm63268.dtsi
@@ -109,6 +109,8 @@ timer-mfd@10000080 {
 			compatible = "brcm,bcm7038-twd", "simple-mfd", "syscon";
 			reg = <0x10000080 0x30>;
 			ranges = <0x0 0x10000080 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 
 			timer@0 {
 				compatible = "brcm,bcm6345-timer";
-- 
2.34.1

