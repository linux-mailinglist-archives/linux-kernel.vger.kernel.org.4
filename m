Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C9608B5B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJVKOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJVKOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:14:05 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46363317B3C;
        Sat, 22 Oct 2022 02:31:37 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id D818E605AA;
        Sat, 22 Oct 2022 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666429537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5u/+U3WMoQOALWqYdkq+g/H0rCbuuXYSAnM9TAS61+s=;
        b=DUsU397IVw2enhP8d7YRHxAuzAHL12nlD+bX3frXXHde7f1AVIA2yoMKBemaRsIuXw8F+M
        Mz28YQ1804U+l6zrfnxUzrLLjNaFznEa38wjwVdiRyWXw6Gzl024h7H7m9QVT6IeD1B8nc
        8M8aCAf2UqInZ9RztMHRIHmdkRJXmcw=
Received: from frank-G5.. (fttx-pool-80.245.73.148.bambit.de [80.245.73.148])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id DD7F5405AF;
        Sat, 22 Oct 2022 09:05:35 +0000 (UTC)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add mmc-support for mt7986
Date:   Sat, 22 Oct 2022 11:05:25 +0200
Message-Id: <20221022090530.16265-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mail-ID: 3d4a4418-e83c-4c0f-bb27-e18e2915e9b8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
driver. I guess they are added by accident, but before removing them i
want to fix the other problems.

Frank Wunderlich (2):
  arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
  dt-bindings: mmc: mtk-sd: add mt7986

Nícolas F. R. A. Prado (1):
  dt-bindings: mmc: mtk-sd: Set clocks based on compatible

Sam Shih (2):
  dt-bindings: mmc: Add compatible for Mediatek MT7986
  mmc: mediatek: add support for MT7986 SoC

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 140 ++++++++++++++----
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   6 +-
 drivers/mmc/host/mtk-sd.c                     |  14 ++
 3 files changed, 127 insertions(+), 33 deletions(-)

-- 
2.34.1

