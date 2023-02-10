Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FA8692549
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjBJSZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjBJSZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:25:19 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470061D24;
        Fri, 10 Feb 2023 10:25:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id sa10so18134476ejc.9;
        Fri, 10 Feb 2023 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2y6sYHNEq/zZN0E8gf/+N5bxU9MEEKOU3kNqZF3SmI=;
        b=GotghvooWKyyyM2R9iZpsuoUdkaw6mBtm/6brhpXDSbIBs0HPV3yHyP39dE6X185XV
         dLQBxhl3BxO0A0ilsFZgt8OXpPMQnpoAVmnnM5O3VcBzaP0g+716JfdGW3zJ/QdPQK0i
         GCHp27zC4x2f4C1avRkUlcGBF/th09UP3FHDAXBxdLqajrdSNBEzLPxuv7fBd4ZuQ7a2
         nHPosNvo4xuB5ITgxOPkefUadfhuFnONopl+FrzV+FJR2jeI5uWy6hVWDxF/5bBJyEdN
         JXA674PffEYrU3WZlKo027gr5QMnihp1ZWrrTpRoDZr9S5Qp5z+uWMcB6NU+aFKuVH0x
         GwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2y6sYHNEq/zZN0E8gf/+N5bxU9MEEKOU3kNqZF3SmI=;
        b=6NIrGYK/HeO7meMGPl77sDlKtAZZqAVE+RgbyRCpluQdRuMMQ6g9XDYkLeVz43BNZk
         tfScOn5q1c0iPaK8bCA0rPFvLLuUtEOSYMGbPT3fCNL/3xctlyfJuP2nM4+9hHefmG7b
         fKOD4pv67Yw7weSa0aS5xsxZ9YSC2q3B2WoSDHdRhdRw20oJzPj3eh1GtBTBXxLH756o
         pPag2Z3aSRXAgwTfz7rSXEPXjXzeF/h3i65CMW6ngV1/SqSz5IMUiwfHovC4gjmpiDhM
         U3LAt0nEsVS+ADls6mIkowQ9PO2PULtT6D4oqG5Y6FKK9IzpV30FtvXAuOFwPhI+IBy8
         SfNw==
X-Gm-Message-State: AO0yUKXKfGOdZMWBbljJDK1jD2gvKZ/ucaHdnGYEMOiat4FYIJhBkwNU
        zMMpLdrKs4B5nkIVFtzdjSE=
X-Google-Smtp-Source: AK7set/6O05MRjLDgoZzrD7cqFf9vbGCMUu5OdtNyv9uaUgSi9zfXKxw0ZczNpSxDhxMClOOAQLllw==
X-Received: by 2002:a17:906:478e:b0:8aa:9abe:8edd with SMTP id cw14-20020a170906478e00b008aa9abe8eddmr18863182ejc.66.1676053517220;
        Fri, 10 Feb 2023 10:25:17 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906024400b008aef19f678asm2708966ejl.165.2023.02.10.10.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:25:16 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH v3 0/5] arm: dts: mt7623: relocate gmacs, mt7530 switch, and add port@5
Date:   Fri, 10 Feb 2023 21:25:00 +0300
Message-Id: <20230210182505.24597-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Γεια σας και πάλι!

We're doing cleanup and adding port@5 as a CPU port.

The main takeaway of the cleanup is that the MT7530 switch is actually a
part of the multi-chip module on the MT7623AI SoC. I'm moving the bindings
for this switch to mt7623a.dtsi so they don't need to be defined on every
device with this SoC. This should ease it up for supporting more devices
with MT7623AI SoC on mainline.

I don't know if there's a pin wired for interrupt. The switch is going to
work with polling for the time being. Folks from MediaTek, feel free to
fill us in on this.

I've tested the CPU ports on my Bananapi BPI-R2. DTs compile fine.

v3:
- Drop phy muxing, add port@5 as a CPU port instead.

v2:
- Do not define phy-mode on mt7623.dtsi, it should be defined on the DTs
that call mt7623.dtsi instead.
- Use the labels for the MACs, remove them from under &eth on the DTs that
call mt7623.dtsi.
- Mention on the log of the forth patch that the interface name will change
from wan to eth1.

Arınç ÜNAL (5):
  arm: dts: mt7623: add gmacs to mt7623.dtsi
  arm: dts: mt7623: add mt7530 switch to mt7623a.dtsi
  arm: dts: mt7623: change mt7530 switch address
  arm: dts: mt7623: enable flow control on port@6
  arm: dts: mt7623: add port@5 as CPU port

 arch/arm/boot/dts/mt7623.dtsi                 | 12 +++
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts        | 86 +++++--------------
 arch/arm/boot/dts/mt7623a-rfb-nand.dts        | 86 +++++--------------
 arch/arm/boot/dts/mt7623a.dtsi                | 99 ++++++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 49 ++++++++---
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        | 37 ++++----
 6 files changed, 207 insertions(+), 162 deletions(-)


