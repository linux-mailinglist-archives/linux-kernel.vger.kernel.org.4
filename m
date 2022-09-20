Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8CD5BEEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiITVCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiITVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:02:24 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D246CF4A;
        Tue, 20 Sep 2022 14:02:19 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id c6so2997747qvn.6;
        Tue, 20 Sep 2022 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NSLrDkTBcy9Rw0cL9fnsWKIlU6heAD2FFLT8LdLFl8o=;
        b=B/OPwJ0okN/Kut70qnqPaTowHsFqf53kAp51Z9JC07NWXMwaKSVGzQJnojA2Nt10mg
         Hw0Y+M11BhXHVPPRSTDue8Z0vnDOjNUyQQTEHPPe8SU3BWcUSh2LyekOn7NoPalLsFxu
         dM4M6aX0fM2OLPXGbTnG+CwDH9ExUJi8FQyzujcKZ81KRX/4qsp8mXUicpCxjjb75JnB
         SZ26DuCTf7BCbRFt8ENCmolZa0Hm/8uIjESunXM8JkaNbon14zM0zl+q3KoXQi43nljZ
         E0FIiAD9puX+ZYhKQu1DyRhX9mt+CazFO1AHln9dAHGvmhnAo8Cjr9XZJW9dCeJgW8HB
         9XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NSLrDkTBcy9Rw0cL9fnsWKIlU6heAD2FFLT8LdLFl8o=;
        b=YH/p4Fwg8hp9kSWMwx7CB5CmNIY95XV4z2C8nvA9yFxCPbyN4it63pxmf9089/wxTM
         B/AC4iCdhFn6spIJD5lR0Bj66hv9v5Zpwanke4B1hnF/NTM2cKIo4T6qe4OK2AtJKs8n
         ARAbzK3HVWDXoGqBPlU3s/OgnmVx+PfGv8YTHlWoWsjLT9DfU7HjqiqCeSszN/CcB0WE
         HEaJXJuYgjvQbl/ycQj2eI9nPPJjSibFJcGGv/VYf9aJkvOsMcFoLUoKfFZVomVaKwtf
         zN6z83ifUwSBp9WHUH7k3LOs/Vak5Okw9JHkev3oKgGynehpFurqIUqYBICMc4IazVzb
         wazw==
X-Gm-Message-State: ACrzQf3aPDa2tglw2IXy3Q6TA6llQmPAj/wiWb+2Lp0LzM4qsHzfjQbi
        6T1HqIzd6StJ5I4KjytcrHE=
X-Google-Smtp-Source: AMsMyM4UEP+K9EikOm54PJ9qlt+YMjmqTxntOx61by31fTyWLuPyqv46WdK95B67PLytdilVPIVrqA==
X-Received: by 2002:a05:6214:300b:b0:4ad:14c4:39f4 with SMTP id ke11-20020a056214300b00b004ad14c439f4mr18214329qvb.105.1663707738510;
        Tue, 20 Sep 2022 14:02:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a284500b006ce5f4720cdsm562058qkp.47.2022.09.20.14.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 14:02:17 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: BCM5301X: Add missing "ranges property for PCIe nodes
Date:   Tue, 20 Sep 2022 14:02:12 -0700
Message-Id: <20220920210213.3268525-1-f.fainelli@gmail.com>
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

Add empty ranges properties to silence such warnings:

arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)

to silence warnings. This is not a functional issue since the driver does not
make use of the OF infrastructure for registering the PCIe controller(s) on
this chip, but uses the BCMA bus.

Fixes: 61dc1e3850a6 ("ARM: dts: BCM5301X: Add basic PCI controller properties")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Change-Id: Ia4eba6d21b72620d2fd8d5c3548c1777d3c1c357
---
 arch/arm/boot/dts/bcm5301x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index a06184b8e0d9..3fb1448b449f 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -240,6 +240,7 @@ chipcommon: chipcommon@0 {
 		pcie0: pcie@12000 {
 			reg = <0x00012000 0x1000>;
 			device_type = "pci";
+			ranges = <0 0 0 0 0 0>;
 
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -248,6 +249,7 @@ pcie0: pcie@12000 {
 		pcie1: pcie@13000 {
 			reg = <0x00013000 0x1000>;
 			device_type = "pci";
+			ranges = <0 0 0 0 0 0>;
 
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -256,6 +258,7 @@ pcie1: pcie@13000 {
 		pcie2: pcie@14000 {
 			reg = <0x00014000 0x1000>;
 			device_type = "pci";
+			ranges = <0 0 0 0 0 0>;
 
 			#address-cells = <3>;
 			#size-cells = <2>;
-- 
2.25.1

