Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B48660408
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjAFQLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjAFQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:10:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD69F8CD2B;
        Fri,  6 Jan 2023 08:10:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13C0CCE1D15;
        Fri,  6 Jan 2023 16:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8734AC433D2;
        Fri,  6 Jan 2023 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673021435;
        bh=ipEY3rRKK0D/abA35ydkdmkys9nnj7dRJ9pimvWv99g=;
        h=From:To:Cc:Subject:Date:From;
        b=IiZKX0jvycw86ZvwvJ59MWADhcNI1C4E6BS6pCHjkUpIovheQ3vY8iaPyR7pdVLgo
         90MR7ywWRqnK8vC/dXEsnm/GH0zNlHkLfCTFS45rZowHuH9qiIcVnX8go2FQlZKAcR
         hvbnqUjPT7PbfSS5xNqI2CbJpDaj5RN8lh8A0FcZcItUQs0Xi7DhWCZkviE01ogzky
         2cwUb9quZMIA1Cx8bXan4loCAFI3QLzVi9KBdPPfK5WN136Q7JgpIVThMvs1pRlZlu
         KgXDMhM2pnLOXyjJIUof/lgt30eyhf9ZUU+85l46SkEbZe4S38ZdxWSHxuhzRbtBwm
         Y8J2AQBE4naBQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] s390: fix -Wundef warning for CONFIG_KERNEL_ZSTD
Date:   Sat,  7 Jan 2023 01:10:23 +0900
Message-Id: <20230106161024.2373602-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Since commit 80b6093b55e3 ("kbuild: add -Wundef to KBUILD_CPPFLAGS
for W=1 builds"), building with W=1 detects misuse of #(el)if.

  $ make W=1 ARCH=s390 CROSS_COMPILE=s390x-linux-gnu-
    [snip]
  arch/s390/boot/decompressor.c:28:7: warning: "CONFIG_KERNEL_ZSTD" is not defined, evaluates to 0 [-Wundef]
     28 | #elif CONFIG_KERNEL_ZSTD
        |       ^~~~~~~~~~~~~~~~~~

This issue has been hidden because arch/s390/boot/Makefile overwrites
KBUILD_CFLAGS, dropping -Wundef.

CONFIG_KERNEL_ZSTD is a bool option. #elif defined() should be used.

The line #ifdef CONFIG_KERNEL_BZIP2 is fine, but I changed it for
consistency.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/boot/decompressor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/boot/decompressor.c b/arch/s390/boot/decompressor.c
index e27c2140d620..8dcd7af2911a 100644
--- a/arch/s390/boot/decompressor.c
+++ b/arch/s390/boot/decompressor.c
@@ -23,9 +23,9 @@
 #define memmove memmove
 #define memzero(s, n) memset((s), 0, (n))
 
-#ifdef CONFIG_KERNEL_BZIP2
+#if defined(CONFIG_KERNEL_BZIP2)
 #define BOOT_HEAP_SIZE	0x400000
-#elif CONFIG_KERNEL_ZSTD
+#elif defined(CONFIG_KERNEL_ZSTD)
 #define BOOT_HEAP_SIZE	0x30000
 #else
 #define BOOT_HEAP_SIZE	0x10000
-- 
2.34.1

