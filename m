Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04489686E75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjBAS5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBAS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:57:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051347D298;
        Wed,  1 Feb 2023 10:57:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q19so8768516edd.2;
        Wed, 01 Feb 2023 10:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UxdFPymbGprmTe4eBjG0Y5GF8xFEu5mJKO3YHkCQnU=;
        b=AbOQRA07suPEDpJpJx4bqRvx1cSDqzRKLA7jdRCUdvtbqo1gOBGpY7us7ITyqjnhyD
         QXGOnfnqJSTnLcx0zdN+fQZvN2K/6Sr0QJY3Kn35eyCFgNKLdxTpMechGaeqps+W+XIM
         egocf+E4v6+9+pH10QeBrawbtENmvaGag3nREeG9DXrSGoh6Wad2zAen/gMkbbTp8WCm
         SpUkOedh1vy/BmN+9QV3ai04paKe9scGqLxCO6BzREgcxEfaRPzrXPq9vIzdWFvThjA9
         P3zTejok2wYLRFcDAb5KMoTKeVT/a7wJmBx4jSM0FFLXtHkYYjVJ6Go/i9vyUhEHjED/
         FZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UxdFPymbGprmTe4eBjG0Y5GF8xFEu5mJKO3YHkCQnU=;
        b=wGMJHKXhDrga3XuBKn2PjKAAshdbm6YkyBPfymiKUWp91fj3PQE1LjpiR4sf2sVn11
         P29OubwPV0wtXI65/3uYHp8K8/0qYhNuiVPmKu0I3lwNkBZFmtyrntOQ+itnUCUL1/PB
         nAohAx+D0T8yoNOX4h3UpG3zJkAv8kD/0IDn8K9MGTwkyGcv68V5MKZ/bFkEnDKED3YA
         RUzRPY5cPKPbxqSqVEVLUS6TltbVvnG5KgMYs7s4aWrxSRPLOsVBXKTezAOEgU8KdULB
         r6pzRdGS4E+S4E/+Pxo+vbOXFAaWhlOkERjsSdPzujTKMCvAkPj62Vbwi3Go99mlG6gC
         SYgw==
X-Gm-Message-State: AO0yUKU7MTQthOPR9e6maWGv4lpGLoVZNmHMngYytLWZJbX8tZbGbUkV
        SKi4PRacONJdjwEfEYR+72Q=
X-Google-Smtp-Source: AK7set9bay2RnP3GeWQZ4wzsdd/XhhlNvNhrCcMjKzYFhVScgcc4tV0IJwP7yMFpMceXcfHwnOYv5Q==
X-Received: by 2002:a05:6402:b37:b0:4a3:43c1:8441 with SMTP id bo23-20020a0564020b3700b004a343c18441mr2141941edb.21.1675277823400;
        Wed, 01 Feb 2023 10:57:03 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id dy25-20020a05640231f900b0049e210884dasm10100883edb.15.2023.02.01.10.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:57:03 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH v2 0/5] arm: dts: mt7623: relocate gmacs, mt7530 switch, and mux phy
Date:   Wed,  1 Feb 2023 21:56:51 +0300
Message-Id: <20230201185656.17164-1-arinc.unal@arinc9.com>
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

I initially just wanted to submit the phy muxing patch for BPI-R2 but after
looking around the bindings, I decided to do a bit of a cleanup.

The main takeaway of the cleanup is that the MT7530 switch is actually a
part of the multi-chip module on the MT7623AI SoC. I'm moving the bindings
for this switch to mt7623a.dtsi so they don't need to be defined on every
device with this SoC. This should ease it up for supporting more devices
with MT7623AI SoC on mainline.

I don't know if there's a pin wired for interrupt. The switch is going to
work with polling for the time being. Folks from MediaTek, feel free to
fill me in on this.

I've tested phy muxing on my BPI-R2. DTs compile fine.

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
  arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
  arm: dts: mt7623: enable flow control on port@6

 arch/arm/boot/dts/mt7623.dtsi                 | 12 +++
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts        | 86 ++++++----------------
 arch/arm/boot/dts/mt7623a-rfb-nand.dts        | 86 ++++++----------------
 arch/arm/boot/dts/mt7623a.dtsi                | 75 +++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 42 ++++++-----
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        | 37 +++++-----
 6 files changed, 170 insertions(+), 168 deletions(-)


