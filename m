Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6995E6EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiIVV51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIVV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:57:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40CA109779
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C123B835BE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 21:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982C0C433C1;
        Thu, 22 Sep 2022 21:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663883841;
        bh=kqodCzuwqlqJ5UyM36OG0YSUsgR4TArBAX8DBB1ASFU=;
        h=From:To:Cc:Subject:Date:From;
        b=PTfjnG2iEDg1ssayJZVxAqy0W9aPqVt10MfyjVKPXoq11fVr6Q8RDDgZVcATF8mMO
         J25acTm6gBUiDZq/PE2jfd/pRhvYJFD3vm8teudftvby2xL8x4+SjrTulp0thVal0w
         Z40GVwbDH4KH3HK2tiBxGjQAYP8+e4EcP7/uDYoKc3rkxzg9X4qpfnvJcQYGKF+tc8
         g7CohjrrX6CtoWDIGECvqeZvaHnSpx2jAuUvxJP89BMvduMqwa2PPApe3D4DRxwxQF
         LKIjQBbuEG3mg4yCfLaiXmLour9jOhiQ2T6RMxdlR8wi6GvufleDAnheAQ3pozGrQW
         OBFbcYDXMjRkA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Mohan Rao .vanimina" <mailtoc.mohanrao@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] vmlinux.lds.h: CFI: Reduce alignment of jump-table to function alignment
Date:   Thu, 22 Sep 2022 22:57:15 +0100
Message-Id: <20220922215715.13345-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Due to undocumented, hysterical raisins on x86, the CFI jump-table
sections in .text are needlessly aligned to PMD_SIZE in the vmlinux
linker script. When compiling a CFI-enabled arm64 kernel with a 64KiB
page-size, a PMD maps 512MiB of virtual memory and so the .text section
increases to a whopping 940MiB and blows the final Image up to 960MiB.
Others report a link failure.

Since the CFI jump-table requires only instruction alignment, reduce the
alignment directives to function alignment for parity with other parts
of the .text section. This reduces the size of the .text section for the
aforementioned 64KiB page size arm64 kernel to 19MiB for a much more
reasonable total Image size of 39MiB.

Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Mohan Rao .vanimina" <mailtoc.mohanrao@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/all/CAL_GTzigiNOMYkOPX1KDnagPhJtFNqSK=1USNbS0wUL4PW6-Uw@mail.gmail.com/
Fixes: cf68fffb66d60 ("add support for Clang CFI")
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7515a465ec03..7c90b1ab3e00 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -543,10 +543,9 @@
  */
 #ifdef CONFIG_CFI_CLANG
 #define TEXT_CFI_JT							\
-		. = ALIGN(PMD_SIZE);					\
+		ALIGN_FUNCTION();					\
 		__cfi_jt_start = .;					\
 		*(.text..L.cfi.jumptable .text..L.cfi.jumptable.*)	\
-		. = ALIGN(PMD_SIZE);					\
 		__cfi_jt_end = .;
 #else
 #define TEXT_CFI_JT
-- 
2.37.3.998.g577e59143f-goog

