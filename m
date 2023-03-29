Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073446CCFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjC2CPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjC2CPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:15:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C9273C;
        Tue, 28 Mar 2023 19:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=J18Kt0VMrufsQrIsqC+xONid+dtZxRsR3hDUTRlZspM=; b=BQNuij8roX6B/ilCTm8Dku+KA4
        i7NEy7tuNw65WKclXoWErOWL09+B6+GePNZFdN3sJC5qKbepPTdsqtvxK4/aP0AMOnzNfnBGkJE2F
        UeubaYBKce5xGaCsFurAPFZoUJst+i9EOqEV/EjZbyqSz8dikZxJ27Lp5gOZ+lN88Jyh9T7vlSaBE
        vsqA8f8wMhZbMvfsg8i97kicRQn541WsD6QUzQu86OcZWL81Ye1Q0nO0c8uXiXci/qHjv1NmbwQt4
        A1wx4JcVq4rH3YOfWqLGfc0qaYInbLQWZsyBAeakPxhF8NmWg6Ig7MmJ4y3VZUYC8Xkay9fcB2caJ
        TdF79Kqw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phLLW-00GKXk-26;
        Wed, 29 Mar 2023 02:15:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] linux/vt_buffer.h: allow either builtin or modular for macros
Date:   Tue, 28 Mar 2023 19:15:29 -0700
Message-Id: <20230329021529.16188-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors on ARCH=alpha when CONFIG_MDA_CONSOLE=m.
This allows the ARCH macros to be the only ones defined.

In file included from ../drivers/video/console/mdacon.c:37:
../arch/alpha/include/asm/vga.h:17:40: error: expected identifier or '(' before 'volatile'
   17 | static inline void scr_writew(u16 val, volatile u16 *addr)
      |                                        ^~~~~~~~
../include/linux/vt_buffer.h:24:34: note: in definition of macro 'scr_writew'
   24 | #define scr_writew(val, addr) (*(addr) = (val))
      |                                  ^~~~
../include/linux/vt_buffer.h:24:40: error: expected ')' before '=' token
   24 | #define scr_writew(val, addr) (*(addr) = (val))
      |                                        ^
../arch/alpha/include/asm/vga.h:17:20: note: in expansion of macro 'scr_writew'
   17 | static inline void scr_writew(u16 val, volatile u16 *addr)
      |                    ^~~~~~~~~~
../arch/alpha/include/asm/vga.h:25:29: error: expected identifier or '(' before 'volatile'
   25 | static inline u16 scr_readw(volatile const u16 *addr)
      |                             ^~~~~~~~

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 include/linux/vt_buffer.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -16,7 +16,7 @@
 
 #include <linux/string.h>
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+#if IS_ENABLED(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
 #endif
 
