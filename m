Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE596168ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiKBQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiKBQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:17 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD12D770;
        Wed,  2 Nov 2022 09:27:05 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id B594741D5B;
        Wed,  2 Nov 2022 11:52:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1667404339;
        bh=4W3VeDIYvjIP23801X+hiRHil28EE436wuQcY+nCUu4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oUI0x5Od+jOFxaBa5v3WffUs7femEzK541UUraIJaerhHjRg1pXV6gURSKt4nB9q7
         nJihwnu6NE3KTpEVbHiMWWwWh59SWk68Ni4r4CZdCyj/5SASe3H6Sx5XIBGoIJy32L
         IS0wcKv5KdkQOVe3UKWdsC04xQsqAX9oW/hrR8kijuxmBsLNJqaL5S1vkKMLyqub7J
         Ho8Muh/IGwf+Jzq9j8b9J0KXkVLowSxO4EhQ5U7ofKeJPdVbb2MfFO3IxHtIlC9gb3
         Gu/pXmj+6KUvHWWi5mDdzaVSPFTICao3D5vRwH1wdHfnl4NjLXWRXnsTt6DwcdYA/M
         i57dcUMirgMzA==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 2 Nov 2022 16:51:42 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v1 17/17] block, blksnap: adds a blksnap to the kernel tree
Date:   Wed, 2 Nov 2022 16:51:01 +0100
Message-ID: <20221102155101.4550-18-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221102155101.4550-1-sergei.shtepa@veeam.com>
References: <20221102155101.4550-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155666726A
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/Kconfig  | 2 ++
 drivers/block/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index db1b4b202646..882b3dd0264d 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -410,4 +410,6 @@ config BLK_DEV_UBLK
 
 source "drivers/block/rnbd/Kconfig"
 
+source "drivers/block/blksnap/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..8414c47960c2 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -40,3 +40,5 @@ obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 
 swim_mod-y	:= swim.o swim_asm.o
+
+obj-$(CONFIG_BLK_SNAP) += blksnap/
-- 
2.20.1

