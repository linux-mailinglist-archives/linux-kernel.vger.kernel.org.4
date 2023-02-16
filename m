Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC1699507
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBPNAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBPNA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5813D089
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:28 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 614B06602065;
        Thu, 16 Feb 2023 13:00:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552426;
        bh=6V0LBeMxyzmdIgkojbhJapEL9BumEDxNoGGGL1jLNno=;
        h=From:To:Cc:Subject:Date:From;
        b=VZIglA4hRWDHBMNDyLCl637wB/QAW4DwTwYcBf3O+j+xJ8ZqSEB/iPMbR4n4TLQol
         3EOi5k05tJR1OtAxO0DrKwHgSuuCMouNmwZFLsrtbU4NRXQM6SHOB+jL4EBNdsPbSO
         Z9zNO5qGmeriBDF961rIJ8UCWgxsYZwf5KSbq8XeAZknyi0pwOQoc0vCHzqTFoyUXB
         8S6GK3O3u6c0EhfFGCQYSBlaeANQfswAnrWjogQmSj49cwJ6Ei28QXGbTcmrx8MkET
         sZzuLyVlq5r8AEjMzFcXfuURPnvgn7ynJMDySbiHAGYg0qE/469OcQ/BHGpWEF9XMl
         Y8Lgy+eI+26uQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 0/9] soc/mediatek: Cleanup mmsys, mutex, cmdq header
Date:   Thu, 16 Feb 2023 14:00:12 +0100
Message-Id: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
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

This series adds a proper remove callback for mtk-mmsys, adds light
cleanups on mtk-mutex and, more importantly, adds a cleanup for the
CMDQ helpers.

Special mention goes to the latter: this is just in preparation for
a larger cleanup that I plan to do as soon as possible on other cmdq
helpers users, being mediatek-drm and mtk-mdp3; that's not performed
right now because, in the case of drm/mdp3, the cleanup is not entirely
trivial.

AngeloGioacchino Del Regno (9):
  soc: mediatek: mtk-mmsys: Add .remove() callback
  soc: mediatek: mtk-mmsys: Use module_platform_driver() macro
  soc: mediatek: mtk-mmsys: Compress of_device_id array entries
  soc: mediatek: mtk-mmsys: Add MODULE_DEVICE_TABLE() to allow auto-load
  soc: mediatek: mtk-mutex: Compress of_device_id array entries
  soc: mediatek: mtk-mutex: Replace max handles number with definition
  soc: mediatek: mtk-mutex: Use module_platform_driver() macro
  soc: mediatek: cmdq: Add inline functions for !CONFIG_MTK_CMDQ
  soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MTK_CMDQ)

 drivers/soc/mediatek/mtk-mmsys.c      | 135 +++++++++-----------------
 drivers/soc/mediatek/mtk-mutex.c      |  77 +++++----------
 include/linux/soc/mediatek/mtk-cmdq.h | 114 ++++++++++++++++++++++
 3 files changed, 181 insertions(+), 145 deletions(-)

-- 
2.39.1

