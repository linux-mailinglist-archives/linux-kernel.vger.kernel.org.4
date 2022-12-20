Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0F6526CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiLTTJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:09:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24418E0C3;
        Tue, 20 Dec 2022 11:09:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fy4so13425816pjb.0;
        Tue, 20 Dec 2022 11:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1OBgH6qhxVhNETTJtpKxpJyJJwZSaJxAnc72NIfU7q8=;
        b=B8qxUMoE7+EAlwHOenlxiYcmaNiVCwIkv+cLWtLf1DvdFen8d5/GPfZO2AcZfsFJ+C
         j9hKmE40U0KY1rBXhWTq6axC8jKgEHENzByO3DzGSvsXsk3kzgD/ueQ1XjSumKsvw67C
         y+kSElTk1YFddpEjE2jy6j0gWutWnUhdwFkykKJchKbQjtqs6pUgSIHs5QtUPPIxIedB
         2Jsas5Y3PJ+eIGoYWT4tqfcZlY4GmmYmJsmqsb0eMX5qgvYQEtDKc2EjR5LhCvmGA4eX
         0AzQAky1NMtPLHLKhJ0dAoGNm6Ehfa7t2qqsmbvjggeZ45KTdpX37xBZGvLmGfyaVhmz
         EeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OBgH6qhxVhNETTJtpKxpJyJJwZSaJxAnc72NIfU7q8=;
        b=V9Vps8QUJLwS36b+fmbCYqSTLxul5rcOq5BMMDam0gUrz9flwHTfuLPYe+4FLyjZWA
         hM7Q6DSZau3xh8tRpIXx12Q4n7pyS0nKOA+ZBDJo9z991Te0t9BgnT2iEBr2eXzaxIeY
         fPxVn3J0pOQ4+Rl8TfuVnKLy893FxCVojDsF8neNdAroGCLkE306tTxITKKSqqVADcdD
         jc0LSk1QW13LbVLHv2QjrK5+VfVTjOUmmKeMG9Jaw8pQ38wGJCqhzYJtKrTjVQcT2dz8
         pieIPkm31ex1tzVINTMMrM4/1OSxBgDTUmIb8zJp4LBXGijRDoQp61jnKQ5uT/7+ZrLm
         v/jA==
X-Gm-Message-State: ANoB5plkIzRya6cfMMhrQqtlbR2IAvpFFFv407M4NyV4Mwx6jhxu70x+
        mKzF04kch8Bq6DbXkfoSICEivltyK4rZaw==
X-Google-Smtp-Source: AA0mqf7jxeSkhNjsR5qNP89OERmGp1AZFIPJVGSOIRilOBXNnwoMcgsIbLYs+BJQGOvtpQXPjSsqhw==
X-Received: by 2002:a05:6a20:d046:b0:af:7762:4c0b with SMTP id hv6-20020a056a20d04600b000af77624c0bmr32394792pzb.34.1671563390179;
        Tue, 20 Dec 2022 11:09:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h5-20020a656385000000b0045ff216a0casm8586163pgv.3.2022.12.20.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:09:49 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: dts: bcm63268: Add missing properties to the TWD node
Date:   Tue, 20 Dec 2022 11:09:46 -0800
Message-Id: <20221220190947.2681192-1-f.fainelli@gmail.com>
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

