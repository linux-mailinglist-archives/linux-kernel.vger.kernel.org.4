Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A159F5EE0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiI1Pzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiI1Pze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:55:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4048E461
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 138A5B82114
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A339FC43146;
        Wed, 28 Sep 2022 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380527;
        bh=RIn6sZf4k88Tnw5v3eTqACWbQ/KJxG3w+Kp9KpVeALg=;
        h=From:To:Cc:Subject:Date:From;
        b=bCY3qTb4/+dYc65wXDwqxgoTq77tM2XbIZQRImu59q9I62cckO9dRTEjEj6UD4hmE
         wZyAoOcjXJzhmftW6Lz6yXZn43NBhnX9mdwFYKcBDjx9gJBL2Zj+i9cklfFFOmAj9T
         z7mfUe+nEsVuEg45jVQnzNTM3BHoUcw7z5yXsmiWDLNWq4KbikSPO07vuo/h+xXI9M
         Js39IvW3fVprP5SbBVTfdpbevt6LzayhsBHd8rNhHaR4RpwnYqFXSdX78pVg7vlWfN
         oznf0AHJWiDYVmtvIG+5o/OwjOCNM+ak86TAQS1IkUzXCM/pqu7+rIy7NFDJmqDy4u
         xS6IeGGAafKog==
From:   matthias.bgg@kernel.org
To:     roger.lu@mediatek.com, jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 0/8] soc: mediatek: mtk-svs: refactor and cleanup the driver
Date:   Wed, 28 Sep 2022 17:55:11 +0200
Message-Id: <20220928155519.31977-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Mediatek SVS driver got accepted upstream but has coding style issues
which were overseen in the review process. This series is a first step
to clean up the driver. It basically cleans up the SoC specific probe.
As next step we will need to clean up the 'struct svs_bank'.

This series should be a mere cleanup with no functional change. I'm
happy to recieve tested-by tags to make sure it does not break anything.


Matthias Brugger (8):
  soc: mediatek: mtk-svs: clean up platform probing
  soc: mediatek: mtk-svs: improve readability of platform_probe
  soc: mediatek: mtk-svs: move svs_platform_probe into probe
  soc: mediatek: mtk-svs: delete superfluous platform data entries
  soc: mediatek: mtk-svs: Move SoC specific functions to new files
  soc: mtk-svs: mt8183: Move thermal parsing in new function
  soc: mtk-svs: mt8183: refactor o_slope calculation
  soc: mtk-svs: mt8192: fix bank data

 drivers/soc/mediatek/Makefile         |   3 +-
 drivers/soc/mediatek/mt8183-svs.h     | 113 ++++
 drivers/soc/mediatek/mt8192-svs.h     |  64 ++
 drivers/soc/mediatek/mtk-svs-mt8183.c | 235 +++++++
 drivers/soc/mediatek/mtk-svs-mt8192.c |  98 +++
 drivers/soc/mediatek/mtk-svs.c        | 882 ++------------------------
 drivers/soc/mediatek/mtk-svs.h        | 279 ++++++++
 7 files changed, 853 insertions(+), 821 deletions(-)
 create mode 100644 drivers/soc/mediatek/mt8183-svs.h
 create mode 100644 drivers/soc/mediatek/mt8192-svs.h
 create mode 100644 drivers/soc/mediatek/mtk-svs-mt8183.c
 create mode 100644 drivers/soc/mediatek/mtk-svs-mt8192.c
 create mode 100644 drivers/soc/mediatek/mtk-svs.h

-- 
2.37.3

