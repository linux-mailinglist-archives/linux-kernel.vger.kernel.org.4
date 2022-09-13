Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB21A5B76C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiIMQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIMQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:51:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EB36401;
        Tue, 13 Sep 2022 08:45:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33B03660159C;
        Tue, 13 Sep 2022 16:12:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663081923;
        bh=KuqdCOgJgOieJeD84xWwkxjms5aJs4gnLtG2P+nlerI=;
        h=From:To:Cc:Subject:Date:From;
        b=KURCdp7GvGRCnqeFgWJ5tTXgrPL4i/PORMKE3D7a7ZUlYh1HKkzMOMKdA2JyHrK9j
         mSe5KmRvaQq4t+4pwI0KmQg1MXGUrQBXM5RWgKyNsz9a3esnP2/VUm+hDAbgbECp7m
         jbaLMgpwGpaflHVOI+6ao2gXSRj9D114r1sQKm7faAhvxG4i1cwMa/C7ljK1qD9ADd
         TCET6+pMynoBYSxkVQGNEaRTejlFrzensWN8Jb9a1ZeL8vdI1EOWu5ARpWSAHodFpk
         l0qEA5QSO8NnzMMWaiPi7J0iPFUlxZ1463nYzhnLv7Iy00STGM5yQjMCsfYTxduGq9
         kSJhSENySYFgw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     joro@8bytes.org
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v6 0/3] MediaTek Helio X10 MT6795 - M4U/IOMMU Support
Date:   Tue, 13 Sep 2022 17:11:45 +0200
Message-Id: <20220913151148.412312-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series introduces support for the IOMMUs found on this SoC.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

Changes in v6:
 - Fix rebase mistake in patch [2/3] (dropped unrelated change)

Changes in v5:
 - Rebased on next-20220912

Changes in v4:
 - Retitled mtk_iommu commits to iommu/mediatek as suggested by Yong Wu
 - Removed unused M4U_LARB5_ID definition
 - Rebased on next-20220624 and
   https://patchwork.kernel.org/project/linux-mediatek/list/?series=650969

Changes in v3:
 - Added new flag as suggested by Yong Wu
 - Rebased on top of https://patchwork.kernel.org/project/linux-mediatek/list/?series=648784

Changes in v2:
 - Rebased on top of https://patchwork.kernel.org/project/linux-mediatek/list/?series=642681

AngeloGioacchino Del Regno (3):
  dt-bindings: mediatek: Add bindings for MT6795 M4U
  iommu/mediatek: Introduce new flag TF_PORT_TO_ADDR_MT8173
  iommu/mediatek: Add support for MT6795 Helio X10 M4Us

 .../bindings/iommu/mediatek,iommu.yaml        |  4 +
 drivers/iommu/mtk_iommu.c                     | 21 +++-
 include/dt-bindings/memory/mt6795-larb-port.h | 95 +++++++++++++++++++
 3 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h

-- 
2.37.2

