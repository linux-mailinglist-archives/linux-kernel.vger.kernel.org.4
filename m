Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6836484C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiLIPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLIPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:14:03 -0500
X-Greylist: delayed 1499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 07:14:00 PST
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87221C3;
        Fri,  9 Dec 2022 07:14:00 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 3B5494095A;
        Fri,  9 Dec 2022 09:24:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1670595871;
        bh=w6TzfCo0+zlgk8mkWBLvozZ61mHMj8fuDSVT5ClGaRY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=CSSe0ezo7TJn+Kt8H6vqSaTjYy0rM3ukfblLos9QrnSlWsPqZ1o1iCDgW8MHD4g7U
         w/rG8C/BY75N8eIAdRswbRgEN9fRsyi8pnuFSwjG7gi93u7Aw16WG1ABPz2gbzNuYV
         Rk+VlCJ9YJwbE/IWBWdp0lvtYlvjZ3Y+JCx735Ay36GUxMzAPDYRimsBYRiirNJ+rS
         SOXPgao+HTEm9f67ZnhF9D5weBKGSujRvO5vkAApFYlmYk5xq6pCskUksMyflhThrS
         HxzpWWSeacJrWImaAiQ2CCok7XBcILvZnPTJcNTta7ww8S9Bx5uAc04KnPsghbgFnx
         ygQbaY2GWnM0Q==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:24:25 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 20/21] block, blksnap: adds a blksnap to the kernel tree
Date:   Fri, 9 Dec 2022 15:23:30 +0100
Message-ID: <20221209142331.26395-21-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031556627C62
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index a41145d52de9..81304bfdc30c 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -416,4 +416,6 @@ config BLK_DEV_UBLK
 
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

