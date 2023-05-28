Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C545713934
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjE1Ldy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1Ldx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:33:53 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49CFBC;
        Sun, 28 May 2023 04:33:50 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout4.routing.net (Postfix) with ESMTP id AAAFC10047A;
        Sun, 28 May 2023 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1685273628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wKL2OHRpM57lwNDHj3JRgnkVg9YanEJjJkWatc4415E=;
        b=gGdaQZM0Gk6IFscFNfBqFaJ5YPjd9dy6lokKYou2PrEarVjzFH6XiIStRtC/ghSXzif641
        kytNmZaV1lrLsORRg4C8z5MJqK+F9m2iwn0hsyo2eP5yCXED+kZiIl9X7o+YY5c4LXpk1w
        keUjo0HC9S0qQGWy2/Rdoq7jUQSvHGU=
Received: from frank-G5.. (fttx-pool-217.61.156.30.bambit.de [217.61.156.30])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id C78F91003E5;
        Sun, 28 May 2023 11:33:47 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH] arm64: dts: mt7986: use size of reserved partition for bl2
Date:   Sun, 28 May 2023 13:33:42 +0200
Message-Id: <20230528113343.7649-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 698df16c-71eb-4971-9a45-3611eae1be82
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

To store uncompressed bl2 more space is required than partition is
actually defined.

There is currently no known usage of this reserved partition.
Openwrt uses same partition layout.

We added same change to u-boot with commit d7bb1099 [1].

[1] https://source.denx.de/u-boot/u-boot/-/commit/d7bb109900c1ca754a0198b9afb50e3161ffc21e

Cc: stable@vger.kernel.org
Fixes: 8e01fb15b815 ("arm64: dts: mt7986: add Bananapi R3")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
If the bl2 does not fit into the bl2-partition (cut off), board does
not boot, thats why i want to increase it now. My current bl2 is 197K
for nor and i ran into this problem.

Openwrt uses also the first reserved partition to give bl2 more
space:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7986a-bananapi-bpi-r3-nor.dts;h=f597b869abc80d1a73f44ebb85ad4da17376bb52;hb=HEAD#l22

so imho it should be same in mainline to not require complex bl2
compression.

have now sent the board-specific dts to uboot too:
https://source.denx.de/u-boot/u-boot/-/commit/d7bb109900c1ca754a0198b9afb50e3161ffc21e
---
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso     | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
index 84aa229e80f3..e48881be4ed6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
@@ -27,15 +27,10 @@ partitions {
 
 					partition@0 {
 						label = "bl2";
-						reg = <0x0 0x20000>;
+						reg = <0x0 0x40000>;
 						read-only;
 					};
 
-					partition@20000 {
-						label = "reserved";
-						reg = <0x20000 0x20000>;
-					};
-
 					partition@40000 {
 						label = "u-boot-env";
 						reg = <0x40000 0x40000>;
-- 
2.34.1

