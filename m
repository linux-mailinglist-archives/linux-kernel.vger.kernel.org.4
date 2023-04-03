Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05156D40A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjDCJdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjDCJdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:33:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2BF6A41
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:33:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01843660000F;
        Mon,  3 Apr 2023 10:33:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680514390;
        bh=sJIlxPcofMXE4g+TA9XuXQqChciFnVtsLhBgGsHH7X0=;
        h=From:To:Cc:Subject:Date:From;
        b=oG1QgpQkgYvEvNYOiS69/eroONBerZrbD/v3h9fHlqjcZ2CgeLTZX0Z4thWgbsMqL
         QoTrmqqwt76a14FmeVGfoC3V5k/RgUf2uONVczJeWZsQHweVm/A2q7fNFYavS5qeat
         5LfDpDNDtAIAu4+7amlj5dDECjZi1GL1QKlB3DNmmWShWQswPRfbNrqDWeBb+L1Hqz
         pODs6DZEjSRQcDwPyyv+39EegIAX+sW+sxQLnOlrsQtTkt+1bxKwx+PY0sWmeB5YbJ
         w73qSgNc/MCAB5Y4eXjw+DGuA7Rhsb9lFMqr2IhFBmU5twYi/S3D4HAGA6v5n6axJq
         az1iV1na+0Nbw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH] soc: mediatek: Kconfig: Add MTK_CMDQ dependency to MTK_MMSYS
Date:   Mon,  3 Apr 2023 11:33:04 +0200
Message-Id: <20230403093304.276418-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk-mmsys and mutex drivers do have a dependency on MTK_CMDQ,
even though both can work with *or* without it: since CMDQ support
can be enabled either as module or as built-in, it is necessary to
add a depends rule in Kconfig, so that we disallow building both
mtk-mmsys and mtk-mutex as built-in if mtk-cmdq-helper is built as
a module, otherwise obvious linker issues appear.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

This has no Fixes tag because the commit that can produce the issue that gets
prevented in this commit is already in the maintainer's tree.

 drivers/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index d6b83a5508ca..a88cf04fc803 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -76,6 +76,7 @@ config MTK_MMSYS
 	tristate "MediaTek MMSYS Support"
 	default ARCH_MEDIATEK
 	depends on HAS_IOMEM
+	depends on MTK_CMDQ || MTK_CMDQ=n
 	help
 	  Say yes here to add support for the MediaTek Multimedia
 	  Subsystem (MMSYS).
-- 
2.40.0

