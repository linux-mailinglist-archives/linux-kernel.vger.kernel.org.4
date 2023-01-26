Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC567C8A7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbjAZKfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjAZKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:35:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1F4518E4;
        Thu, 26 Jan 2023 02:35:35 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19B0C6602E68;
        Thu, 26 Jan 2023 10:35:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674729333;
        bh=/1IZcCeBq30sq5XeIYZ5KDLyqOJxHaleT4KHHY+u2tY=;
        h=From:To:Cc:Subject:Date:From;
        b=A9ow93CX82rwbOjV2A12hJRXCzXASSFhXhEUn6h51FMJlMVrusHLYjz+rxAru6pID
         8uoGq8zHa+ThXlWuXKK2ETPe74qlU4twfCmvf2qwNUbR0OfAf0kFgVKJ/sCfPn+z3a
         4MNvSilVNnzgbClLs0pCtJTU9Gq2p3EAtqH9JhVkJ3Vj5OHV55uOelAk9h7AC5CgD3
         9gyUuVyHaLI94H0Xyc9pyht97msWATScWCY56kX2KlTb3lM/qR6Yp95dSR2cWAsAae
         KVBmJrKvb/wc2OVcI06w35T6D+QjHTgYFqZ7TPGWKRtB0ztNlS3vVlhXeIrbNl8rgh
         O+uzOFwT8IctQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        seiya.wang@mediatek.com, tinghan.shen@mediatek.com,
        allen-kh.cheng@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/6] Fix MT8186/92/95 topology and idle state names
Date:   Thu, 26 Jan 2023 11:35:20 +0100
Message-Id: <20230126103526.417039-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8186, MT8192 and MT8195 use ARM DynamIQ, which combines big and
LITTLE cores in one single cluster! A two cluster topology is simply
wrong in this case.

While at it, after some research, I've also noticed that the names
assigned to the idle states are misleading, so I went on changing
them to reflect the actual function.

The names change commits, unlike the CPU map ones, didn't get any
Fixes tag, as naming changes aren't fixing anything that would be
meaningful for functionality (it's cosmetic, nothing else).

AngeloGioacchino Del Regno (6):
  arm64: dts: mt8195: Fix CPU map for single-cluster SoC
  arm64: dts: mt8192: Fix CPU map for single-cluster SoC
  arm64: dts: mt8186: Fix CPU map for single-cluster SoC
  arm64: dts: mt8195: Change idle states names to reflect actual
    function
  arm64: dts: mt8186: Change idle states names to reflect actual
    function
  arm64: dts: mt8192: Change idle states names to reflect actual
    function

 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 30 ++++++++++----------
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 35 +++++++++++-------------
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 34 +++++++++++------------
 3 files changed, 46 insertions(+), 53 deletions(-)

-- 
2.39.0

