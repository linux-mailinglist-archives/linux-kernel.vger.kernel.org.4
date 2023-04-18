Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654AC6E59BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjDRGxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjDRGxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:53:35 -0400
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2104EC4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:53:31 -0700 (PDT)
From:   Daniil Dulov <d.dulov@aladdin.ru>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Daniil Dulov <d.dulov@aladdin.ru>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] x86/kaslr: Fix potential dereference of NULL pointer.
Date:   Mon, 17 Apr 2023 23:53:08 -0700
Message-ID: <20230418065308.452462-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.20.32]
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer val can have NULL value. Then its value is assigned to the pointer p.
p is dereferenced by calling strcmp().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4cdba14f84c9 ("x86/KASLR: Handle the memory limit specified by the 'memmap=' and 'mem=' boot options")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b92fffbe761f..51b3925d4d2d 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -291,7 +291,7 @@ static void handle_mem_options(void)
 		} else if (!strcmp(param, "mem")) {
 			char *p = val;
 
-			if (!strcmp(p, "nopentium"))
+			if (!p || !strcmp(p, "nopentium"))
 				continue;
 			mem_size = memparse(p, &p);
 			if (mem_size == 0)
-- 
2.25.1

