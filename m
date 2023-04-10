Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39C16DC247
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 03:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDJBNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 21:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjDJBNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 21:13:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1643A9A;
        Sun,  9 Apr 2023 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VdW0QiWZs5tGfWPYA1DUgJb23J28q3ZPvcBOi0zT0BE=; b=daWXvKb1EIcxg0HC4CwHgCtg37
        uOSPNeR3CtfZXI4UL1UQEKRw53ztrrwSN16KQDm0/4UjmKQBs/K4fdMJS1HKBP8Y2lFCOxRQuzvy+
        X/QkANaB6jdpL1QM2u5V4JiTpYp1CIgii1o//f8tyFp/CHbaSd7E8IL75M0NWjF/wt+vxJviwGu+z
        iZqE/xoSuYH0mj4H0lD4fmN4yAnheEX/ke1abhcxu8W4roCX4+2RCCDCUDnQYUWYfWqdULe/K6RvQ
        JbetAX6DydD8As2XFOgUHaCRA9XZNIA9GMa0CZsceZI5KaSgue60KcV8q/9bGl1IQCz+DO4rLq033
        1oudGLig==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1plg61-00EPd9-31;
        Mon, 10 Apr 2023 01:13:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with TRACEPOINTS
Date:   Sun,  9 Apr 2023 18:13:25 -0700
Message-Id: <20230410011325.26850-1-rdunlap@infradead.org>
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

Current build of pata_cs5536 for i386 UML fails with:

ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!

Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
v2: change from not building on UML to fixing the build on UML
v3: add Rev-by: Damien Le Moal

 arch/x86/um/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/um/Makefile b/arch/x86/um/Makefile
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -21,7 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
-subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
+subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o ../lib/msr.o
 subarch-y += ../kernel/sys_ia32.o
 
 else
