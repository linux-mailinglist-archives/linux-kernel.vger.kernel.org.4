Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0113C60CD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiJYNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:30:06 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB2DB764;
        Tue, 25 Oct 2022 06:30:00 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id A184A618F6;
        Tue, 25 Oct 2022 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666704598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jolFtewM3ztHIyphgDnA9u4uYdrtd/Xjhj1chDEywEE=;
        b=P3XbA1ThmmAoxE/xeQoCzcpqoy6L1VS36LoJhcmfdpwy3+Bv82Tw1hjiOWpe0oMLOTfrtb
        pyAF+e2zINxK8LSW+l5z2G9/Yt7GWEKt4rnCZTm0u13XiqSIaNdmjPc3rjcIQVzNPcc1Wk
        MudKwFrbrp0M9zLboLGFfJ6XEcecbhM=
Received: from frank-G5.. (fttx-pool-217.61.152.57.bambit.de [217.61.152.57])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 9ABE240112;
        Tue, 25 Oct 2022 13:29:57 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
Subject: [PATCH v5 0/6] Add mmc-support for mt7986
Date:   Tue, 25 Oct 2022 15:29:47 +0200
Message-Id: <20221025132953.81286-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mail-ID: 1f7902d6-bcfd-4759-8bc0-01e5fc8a140d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

I've noticed the mtk-sd binding needs a bit more work get into a more
clean state.

There are 2 properties missing that maybe need to be added later or
dropped from devicetrees:
drv-type (which is used in mt8183-kukui.dtsi and set to <2>)
and
r_smpl (used in mt7622-rfb1.dts and mt7622-bananapi-bpi-r64.dts, both
times set to <1>)

i don't know their function and boundaries and i do not find them in
driver. I guess they are added by accident, so i removing them in the
patches 5+6.

v2:
- add compatible based binding
v3:
- solve "not" statement in binding and reorder if statements,drop mt8183
- added patches removing invalid properties (not in driver)
v4:
- squashed part 1 (compatible) and 3 (SoC specific clock config)
- new mt7986 clock bindings based on info from mtk
- re-add mt8183 reg boundary
v5:
- add fixes-tags to Patches 4+5 and reviewed-by to 6
- drop quotes from mt7986 clock-names from patch 2

Frank Wunderlich (3):
  arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
  arm64: dts: mt8183: drop drv-type from mmc-node
  arm64: dts: mt7622: drop r_smpl property from mmc node

Nícolas F. R. A. Prado (1):
  dt-bindings: mmc: mtk-sd: Set clocks based on compatible

Sam Shih (2):
  dt-bindings: mmc: Add support for Mediatek MT7986
  mmc: mediatek: add support for MT7986 SoC

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 149 ++++++++++++++----
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   6 +-
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   1 -
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   1 -
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   1 -
 drivers/mmc/host/mtk-sd.c                     |  14 ++
 6 files changed, 136 insertions(+), 36 deletions(-)

-- 
2.34.1

