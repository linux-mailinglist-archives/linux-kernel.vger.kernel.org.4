Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268460B496
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiJXRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiJXRw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E810F1552E8;
        Mon, 24 Oct 2022 09:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70D0BB81440;
        Mon, 24 Oct 2022 16:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C7C433D6;
        Mon, 24 Oct 2022 16:29:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="baNLxAdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666628952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f+qKYAdQp0ZEOEJVb3ZMoRSM9GmC/NBgUVzDe+p3Xhc=;
        b=baNLxAdtA79kdxbhdqIBu/sjlNgsqeE2qUVKkORCsOuwuWBg0oRL38hXps3SPUOqqXVNKS
        Z/2iGMt2QmEyErn1cqnsbvPubWrdcwPi2UrTbif0wjaLMue3qmMQcH6GHyTOyhPN2swfo0
        BElAlULw6U5wYTHdnPfAbh4rI7IHzeI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2b4b3ec4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 24 Oct 2022 16:29:12 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] video: fbdev: sis: use explicitly signed char
Date:   Mon, 24 Oct 2022 18:29:01 +0200
Message-Id: <20221024162901.535972-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With char becoming unsigned by default, and with `char` alone being
ambiguous and based on architecture, signed chars need to be marked
explicitly as such. This fixes warnings like:

drivers/video/fbdev/sis/init301.c:3549 SiS_GetCRT2Data301() warn: 'SiS_Pr->SiS_EModeIDTable[ModeIdIndex]->ROMMODEIDX661' is unsigned

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-usb@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/usb/misc/sisusbvga/sisusb_struct.h | 2 +-
 drivers/video/fbdev/sis/vstruct.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_struct.h b/drivers/usb/misc/sisusbvga/sisusb_struct.h
index 3df64d2a9d43..a86032a26d36 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_struct.h
+++ b/drivers/usb/misc/sisusbvga/sisusb_struct.h
@@ -91,7 +91,7 @@ struct SiS_Ext {
 	unsigned char VB_ExtTVYFilterIndex;
 	unsigned char VB_ExtTVYFilterIndexROM661;
 	unsigned char REFindex;
-	char ROMMODEIDX661;
+	signed char ROMMODEIDX661;
 };
 
 struct SiS_Ext2 {
diff --git a/drivers/video/fbdev/sis/vstruct.h b/drivers/video/fbdev/sis/vstruct.h
index ea94d214dcff..d7a14e63ba5a 100644
--- a/drivers/video/fbdev/sis/vstruct.h
+++ b/drivers/video/fbdev/sis/vstruct.h
@@ -148,7 +148,7 @@ struct SiS_Ext {
 	unsigned char  VB_ExtTVYFilterIndex;
 	unsigned char  VB_ExtTVYFilterIndexROM661;
 	unsigned char  REFindex;
-	char           ROMMODEIDX661;
+	signed char    ROMMODEIDX661;
 };
 
 struct SiS_Ext2 {
-- 
2.38.1

