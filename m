Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB86866E485
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjAQRLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjAQRLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7918B28;
        Tue, 17 Jan 2023 09:11:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5B1D614E6;
        Tue, 17 Jan 2023 17:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD500C433D2;
        Tue, 17 Jan 2023 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673975463;
        bh=/4bh/nj8CulG+RACSX9jdm3RR+gTaOZx78QgoDmAThg=;
        h=From:To:Cc:Subject:Date:From;
        b=ixTR+TDnzR8t46qA7h3081NbdQ3JLhJkYwZaNMDVS1sFU0gTxeRBD5wAIEKAJxlKZ
         mtEdsKYXJSBz0d3X3MOLawak7VLcafi1j9uUZsmoRx6GQbg0S5Z5uYkhJFNp911DzO
         rf+TqaYWEyVNNSjHc+rcP42reeMQapzFNgZegu0i3GCn/4Zr5kfDZgryztAOEpU8Nt
         8q4sO4oQ1EXHexixn2tsUtCphCqis/6l8KHIUy363urQ3S0VUtgyaxcR19eLBnoDMY
         j5PBdaZc1LG3bQRJd+3kyW8/oBrO4F2uA2Z1T4vIf8W6anQImQmlONjZKhKaf22ItA
         6mX0QRlVUz1zw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: pvrusb2: fix DVB_CORE dependency
Date:   Tue, 17 Jan 2023 18:10:16 +0100
Message-Id: <20230117171055.2714621-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

Now that DVB_CORE can be a loadable module, pvrusb2 can run into
a link error:

ld.lld: error: undefined symbol: dvb_module_probe
>>> referenced by pvrusb2-devattr.c
>>>               drivers/media/usb/pvrusb2/pvrusb2-devattr.o:(pvr2_lgdt3306a_attach) in archive vmlinux.a
ld.lld: error: undefined symbol: dvb_module_release
>>> referenced by pvrusb2-devattr.c
>>>               drivers/media/usb/pvrusb2/pvrusb2-devattr.o:(pvr2_dual_fe_attach) in archive vmlinux.a

Refine the Kconfig dependencies to avoid this case.

Fixes: 7655c342dbc4 ("media: Kconfig: Make DVB_CORE=m possible when MEDIA_SUPPORT=y")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/usb/pvrusb2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/pvrusb2/Kconfig b/drivers/media/usb/pvrusb2/Kconfig
index f2b64e49c5a2..e02a25d2d029 100644
--- a/drivers/media/usb/pvrusb2/Kconfig
+++ b/drivers/media/usb/pvrusb2/Kconfig
@@ -37,6 +37,7 @@ config VIDEO_PVRUSB2_DVB
 	bool "pvrusb2 ATSC/DVB support"
 	default y
 	depends on VIDEO_PVRUSB2 && DVB_CORE
+	depends on VIDEO_PVRUSB2=m || DVB_CORE=y
 	select DVB_LGDT330X if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_S5H1409 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_S5H1411 if MEDIA_SUBDRV_AUTOSELECT
-- 
2.39.0

