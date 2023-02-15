Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38E8697461
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjBOChR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBOChP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:37:15 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C73430E93
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:37:15 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 78EE282;
        Tue, 14 Feb 2023 18:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1676428634;
        bh=af7ZZHxNFz5At1W5VcQd3z15hu8uNlmxF78QrinEHLI=;
        h=From:To:Cc:Subject:Date:From;
        b=aVyUaHtFSzNtr/mVZp/EHscaR1r95cK7AjlOCc9sNAt9p8qVaYnmXFEQc/tAuZowX
         OXyz7xek75iLOswKPlM/KLEzQWnwGsMr/vpMg6bjijNcZOJHPJcCZCsnIRL5EBxSAm
         zrhKoelBh0PmjI65azTNbBFdAqafW5/3ALNUHS0Q=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stafford Horne <shorne@gmail.com>,
        Zev Weiss <zev@bewilderbeest.net>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] ARM: uaccess: Fix KASAN false-positives
Date:   Tue, 14 Feb 2023 18:37:06 -0800
Message-Id: <20230215023706.19453-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jeffery <andrew@aj.id.au>

__copy_to_user_memcpy() and __clear_user_memset() had been calling
memcpy() and memset() respectively, leading to false-positive KASAN
reports when starting userspace:

    [   10.707901] Run /init as init process
    [   10.731892] process '/bin/busybox' started with executable stack
    [   10.745234] ==================================================================
    [   10.745796] BUG: KASAN: user-memory-access in __clear_user_memset+0x258/0x3ac
    [   10.747260] Write of size 2687 at addr 000de581 by task init/1

Use __memcpy() and __memset() instead to allow userspace access, which
is of course the intent of these functions.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/lib/uaccess_with_memcpy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 14eecaaf295f..e4c2677cc1e9 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -116,7 +116,7 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 			tocopy = n;
 
 		ua_flags = uaccess_save_and_enable();
-		memcpy((void *)to, from, tocopy);
+		__memcpy((void *)to, from, tocopy);
 		uaccess_restore(ua_flags);
 		to += tocopy;
 		from += tocopy;
@@ -178,7 +178,7 @@ __clear_user_memset(void __user *addr, unsigned long n)
 			tocopy = n;
 
 		ua_flags = uaccess_save_and_enable();
-		memset((void *)addr, 0, tocopy);
+		__memset((void *)addr, 0, tocopy);
 		uaccess_restore(ua_flags);
 		addr += tocopy;
 		n -= tocopy;
-- 
2.39.1.438.g79fd386332e5.dirty

