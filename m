Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1E86F5731
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjECLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjECLeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:34:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B1049EC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:34:21 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2135C660309E;
        Wed,  3 May 2023 12:34:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683113660;
        bh=D4GxHwRdyAouEXBmGeD9y+SB4oSmGvmMfyzdYBUTGVw=;
        h=From:To:Cc:Subject:Date:From;
        b=FO9btotfEblnP/1DE5WqXhomqoU+yNbZ7N8+Nsy8eenwAs4MZzxIWUrXh0Y3w2RPu
         Vm0llArH4IEy3kOoR5TnPuBeZ2tbWl0qgeN8V2lNfK+Wl4DfkGmR17HAsTYGcrOfzQ
         8ALiaC5v8FzihTBzNFFK4YvsMoOf78DVujTY/nVRnxwprAUzlRA4nm+uuq2DMPttFu
         KPsHdcA0fWQkHdMWRFoxlI7eOdz5a0Vcv6cSBRO7oki1cZSscyoo2hDR78s8Pr2BPZ
         NKs72uI/0J2qEDl22rB4o39wM1rGZxWbj5Xq/fBRCVDOLLw74yO647543yvwaaEpNv
         KPPMyudnJeUMg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, nicolas.ferre@microchip.com,
        u.kleine-koenig@pengutronix.de, chunxu.li@mediatek.com,
        tinghan.shen@mediatek.com, error27@gmail.com, ribalda@chromium.org,
        yc.hung@mediatek.com, Allen-KH.Cheng@mediatek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 0/5] ASoC: MediaTek MT8195/86 Cleanups
Date:   Wed,  3 May 2023 13:34:08 +0200
Message-Id: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series performs some cleanups for mainly MT8195 and switches
both MT8195 and MT8186's SOF driver to the snd_sof_ipc_process_reply()
helper.

AngeloGioacchino Del Regno (5):
  ASoC: SOF: mediatek: mt8195: Use snd_sof_ipc_process_reply() helper
  ASoC: SOF: mediatek: mt8186: Use snd_sof_ipc_process_reply() helper
  ASoC: mediatek: mt8195-afe-pcm: Simplify runtime PM during probe
  ASoC: mediatek: mt8195-afe-pcm: Simplify with dev_err_probe()
  ASoC: mediatek: mt8195-afe-pcm: Clean up unnecessary functions

 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 99 ++++++++--------------
 sound/soc/sof/mediatek/mt8186/mt8186.c     | 36 +-------
 sound/soc/sof/mediatek/mt8195/mt8195.c     | 36 +-------
 3 files changed, 36 insertions(+), 135 deletions(-)

-- 
2.40.1

