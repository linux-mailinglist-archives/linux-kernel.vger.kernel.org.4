Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D868FC60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjBIBGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjBIBGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:06:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4246F12851;
        Wed,  8 Feb 2023 17:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OcW8GdVrBEWyhALBhRMthSCRaiPw82hJsz7VAS9p4Ag=; b=0lp6NmF3LueIjFiWdcHYtpXB1U
        1YmWS4O+HwlRY4OMb0TbUubrBNn5pPnF5ayeFT/DmwLymhUFl2m6tS3sV75XHy9vmE5PIDazqFzmN
        CPPXHTyicDLj4gqjUY9/M2gESm3KclnZtJASVAJ+Tmn3BZ4fgwZSeWVXWnEITXPs+fFaMloQBNd6Q
        E820N00xjEvDlOx+ozvPjMgZj6XDqGJQvgyzwSrwHqodGA2+kTZmjII+RIwHjomNT9MC4gqL25hdX
        17vOmp3aK2IQJKyfzA5NxFsXDGDeE8+sKcX0IYcQftS+pQfVdME9kv2eoL8rvIoFhabfjZ5Ar84gL
        4t35Sh5w==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPvOW-00HMdb-FX; Thu, 09 Feb 2023 01:06:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH] m68k: allow PM menu options for COMPILE_TEST
Date:   Wed,  8 Feb 2023 17:06:35 -0800
Message-Id: <20230209010635.24016-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow PM options for COMPILE_TEST. This quietens a kconfig
warning.

This is similar to a patch for Sparc32 that was suggested by
Arnd.

WARNING: unmet direct dependencies detected for PM
  Depends on [n]: !MMU [=y]
  Selected by [y]:
  - SUN20I_PPU [=y] && (ARCH_SUNXI || COMPILE_TEST [=y])

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/m68k/Kconfig b/arch/m68k/Kconfig
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -126,7 +126,7 @@ menu "Kernel Features"
 
 endmenu
 
-if !MMU
+if !MMU || COMPILE_TEST
 menu "Power management options"
 
 config PM
