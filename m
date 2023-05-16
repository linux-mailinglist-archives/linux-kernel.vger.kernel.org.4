Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C53E7058B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjEPUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEPUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675ED97;
        Tue, 16 May 2023 13:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0455263F3C;
        Tue, 16 May 2023 20:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3A0C433D2;
        Tue, 16 May 2023 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268582;
        bh=vu4a3gAHkMYhle534u5kDDmaO/1lqkSTmEK0D8hdHso=;
        h=From:To:Cc:Subject:Date:From;
        b=cwo1OJz8+bzgn+B6EVYFTVNxTDuaILqVkdK9VNMKQ17oBUNtzfNuoF93fXEVjbTwr
         QFzPXlDI47QPkfuAq6iyHfttrXJNKNpiLS5/HGlWjyRwiukjA6amzfFR/ZirO0Ng8m
         VNtCp9Bn6fT3O/vWjJFjCJxrQOwUPctzljgO785qtizvUqhJ7i4lpMj19Dbmfm/kXD
         xhr/LHlfeXcYprpMVuZhhhV4dM598ttOzZbKUzpXBbCWaFbJHOeCaqph0bNe5DlLae
         yduGJoReJzn8PAr1suyOBnle5RhsIXjgXuC87fGWWegVG+9cQwC9ehU9szw0eZcsQ2
         hXW6SPdUPHN1A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: fbmem: mark get_fb_unmapped_area() static
Date:   Tue, 16 May 2023 22:22:48 +0200
Message-Id: <20230516202257.559952-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is a global function with this name on sparc, but no
global declaration:

drivers/video/fbdev/core/fbmem.c:1469:15: error: no previous prototype for 'get_fb_unmapped_area'

Make the generic definition static to avoid this warning. On
sparc, this is never seen.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index e808dc86001c..28739f1cb5e7 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1468,7 +1468,7 @@ __releases(&info->lock)
 }
 
 #if defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA) && !defined(CONFIG_MMU)
-unsigned long get_fb_unmapped_area(struct file *filp,
+static unsigned long get_fb_unmapped_area(struct file *filp,
 				   unsigned long addr, unsigned long len,
 				   unsigned long pgoff, unsigned long flags)
 {
-- 
2.39.2

