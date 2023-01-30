Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5713C681B19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbjA3UIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbjA3UIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:08:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886B132E5C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:08:33 -0800 (PST)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3DB6D6602EB0;
        Mon, 30 Jan 2023 20:08:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675109312;
        bh=04swUGoUqfLzO/4GYJ0FTGA8WmbYd7gvyrdjrpSIOFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsSTtJHd2vBscdTddI8ZOpBQl8DfB5rTDqJC14DyiOnJnQa9rskw02+R9XAoYcBhQ
         5yrOKECmzR7Q82W1zkPW1r87I0mdDqBSN7qf02llezIGDoDnEq7rzXXjfX0zpg9abL
         Jt/7wmrhBoB3HancDDfVamY2NMuF54uTZC/+gg7QoBtD1paCbMhKKYYirX+kkUVoFz
         Wt8TQXJLIXSTYVF0BpPdzv9UhDitROp2wJ3cmvw7EokCb4C9dgARtgzEnhIG84YQt8
         9gdQU34TgpiFIx5hnOXRJUOnKLhazkqCVwVxQNLh+VUiGFL193+jT9z96R0Pxfd39w
         eDYjWJqVMy3dw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: defconfig: Enable DMA_RESTRICTED_POOL
Date:   Mon, 30 Jan 2023 15:08:20 -0500
Message-Id: <20230130200820.82084-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130200820.82084-1-nfraprado@collabora.com>
References: <20230130200820.82084-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for restricted DMA pools which provide a level of DMA
memory protection on systems with limited hardware protection
capabilities, such as those lacking an IOMMU.

For instance, mt8192-asurada-spherion makes use of this to provide a
restricted DMA region for WiFi since its MT7921E WiFi card is connected
through PCIe, and the MT8192 SoC doesn't have an IOMMU context for the
PCIe controller.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v3:
- Added this patch

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index be40004a0259..4e806d8068f6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1422,6 +1422,7 @@ CONFIG_CRYPTO_DEV_HISI_SEC2=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
 CONFIG_CRYPTO_DEV_HISI_HPRE=m
 CONFIG_CRYPTO_DEV_HISI_TRNG=m
+CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
-- 
2.39.1

