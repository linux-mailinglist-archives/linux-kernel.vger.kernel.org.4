Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1B769F214
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBVJqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjBVJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:46:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98293B67F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:43:56 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 542C6660215E;
        Wed, 22 Feb 2023 09:42:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058979;
        bh=0jvW+qVjVyFbdPGbJSy+ls56McRznRnqH8nf+HGON0w=;
        h=From:To:Cc:Subject:Date:From;
        b=IDnhTy30pCzSC5pdwVh6livJDWWihQU4BASCnAN3HuBgoHUY19aMAa+X4JbX05qo+
         7pCr9gcdUvx5Sm3Ppg2q/0KgV6hWTzgfptWLDiiRf1VCO2RI4eNRh961hTqgLUXy8E
         suNiKuDIxxkM0EoJMm2qqVttVGag784ArQ9WqLu9Uv2REFVs066PUPP8znx7xEPAQk
         2iv7AYY1gfdH0VStk6ccH3fBK89+N67yblwFeTMFx59If0niac4wFjp3rbBK60SwIu
         +RR70LRCgxnhtHPf9RXPXerHudNNUMUk2piPpp+6xfpPYsGp4+Zu9BaPRwWlfo+Enw
         LSeJ4NS0FhDGQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/9] soc/mediatek: Cleanup mmsys, mutex, cmdq header
Date:   Wed, 22 Feb 2023 10:42:44 +0100
Message-Id: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
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

Changes in v2:
 - Rebased onto Matthias' v6.3-tmp/soc branch for VPP mutex conflict
   on patch [5/9]

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
 drivers/soc/mediatek/mtk-mutex.c      |  80 +++++----------
 include/linux/soc/mediatek/mtk-cmdq.h | 114 ++++++++++++++++++++++
 3 files changed, 182 insertions(+), 147 deletions(-)

-- 
2.39.2

