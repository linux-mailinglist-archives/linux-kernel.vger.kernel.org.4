Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF83464DED0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLOQkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLOQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:40:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDFE2AE07;
        Thu, 15 Dec 2022 08:40:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C02A161E61;
        Thu, 15 Dec 2022 16:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83905C433D2;
        Thu, 15 Dec 2022 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122428;
        bh=vM3CUj4GDE5CqX99A6tmi97aIvyuGUgE2Z3VCaT0Z+I=;
        h=From:To:Cc:Subject:Date:From;
        b=OKeIwSrwxWpFiXDfoywHNKECTEwF2U3EqtQss0QWLiHb5jQByez8MJOwDB7pqrSyx
         TJPayJrHeVZnhLzQHlz6BhvhmDyWTAu2qyZgo811xQrb8qLp0ha0d3k8DfBko2L4uR
         agwVLPmNojdMe8aMrEiJ4fAotsx1pZxpuaFZ++J4daDKb7d/SyLRgpQJ5BHI2+GnFR
         +dbGm0pM7DwNttwngEd2qmZkVOZp3oBVh7vzEhnhsewE5DGM8OaQCCtbH/sr9oV6uK
         5kcTPehvme2Wmt2pc3/Az+vadb8TUwKkbBQbPHiXikTIjg7DyNjDcA36H76dz+dOBx
         ahVijGzINeMPQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] media: platform: mtk-mdp3: fix Kconfig dependencies
Date:   Thu, 15 Dec 2022 17:40:08 +0100
Message-Id: <20221215164021.694343-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new mdp3 driver uses 'select' to force-enable a couple of drivers
it depends on. This is error-prone and likely to cause dependency
loops as well as warnings like:

WARNING: unmet direct dependencies detected for VIDEO_MEDIATEK_VPU
  Depends on [n]: MEDIA_SUPPORT [=m] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_MEM2MEM_DRIVERS [=n] && VIDEO_DEV [=m] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - VIDEO_MEDIATEK_MDP3 [=m] && MEDIA_SUPPORT [=m] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && (MTK_IOMMU [=m] || COMPILE_TEST [=y]) && VIDEO_DEV [=m] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=y]) && HAS_DMA [=y] && REMOTEPROC [=y]

This specific warning was already addressed in a previous patch,
but there are similar unnecessary 'select' statements, so turn those
into 'depends on'. This also means the dependency on ARCH_MEDIATEK
is redundant and can be dropped.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Fixes: 9195a860ef0a ("media: platform: mtk-mdp3: remove unused VIDEO_MEDIATEK_VPU config")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/mediatek/mdp3/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/Kconfig b/drivers/media/platform/mediatek/mdp3/Kconfig
index 846e759a8f6a..602329c44750 100644
--- a/drivers/media/platform/mediatek/mdp3/Kconfig
+++ b/drivers/media/platform/mediatek/mdp3/Kconfig
@@ -3,14 +3,13 @@ config VIDEO_MEDIATEK_MDP3
 	tristate "MediaTek MDP v3 driver"
 	depends on MTK_IOMMU || COMPILE_TEST
 	depends on VIDEO_DEV
-	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on HAS_DMA
 	depends on REMOTEPROC
+	depends on MTK_MMSYS
+	depends on MTK_CMDQ
+	depends on MTK_SCP
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
-	select MTK_MMSYS
-	select MTK_CMDQ
-	select MTK_SCP
 	default n
 	help
 	    It is a v4l2 driver and present in MediaTek MT8183 SoC.
-- 
2.35.1

