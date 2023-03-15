Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E160C6BBF40
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjCOVlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjCOVlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:41:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6B04EDB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:41:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m13-20020a25800d000000b00b3dfeba6814so10695359ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678916463;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1hKyjwDWdKCL/Wlt0NC0zQ5DwmLIV6PvEhmjPxkamzQ=;
        b=BH5D3WNh7FOlMGAbu+ySIPi6YQWbT8oBK8zLsmSP+rmu2DvuG62Tt/ke6kp7CvNL3h
         g3WnnTr+B3hZ2NINTxArsVA7JSxhgaT/vpZMUXuj75omDHfbFWFyrji+5V7PCQPXcpuC
         0qfiPDxk5jlXZZ/iO9yKfO0NJDF64FMJizMOjxtbLUALrhAn8uXYgz5tcTrbi4TPRqSv
         uU91XO7NvW6haisG0X8N4w/9gEBa3B6f1/33R8wJjBiXIqZmmks+MvAmImX5+BZdXER6
         65AtnwzpS2itPU+8XjxH8JSrV+O13vmff0c/rCWlIGVxTKo497WokjudpL23BYEe/6Rl
         mFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916463;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hKyjwDWdKCL/Wlt0NC0zQ5DwmLIV6PvEhmjPxkamzQ=;
        b=DyDz7v2x/86SuL6svsfYrecmjQkD53+ZQD29fSf9d23NSRy26ordgz3/cpailA7D2t
         f5NGcCZ1pk+crRqnukq+m9OCIs4gTpHeF/02c9z+AhNfrOt4DRaTv8VX1PCPcNR5FmHv
         i0NmhHq7DEhL5PdLGuAB5y2Rkwt43wjUs9KT0OWWDFD/bsGCRe4lLB8sNtvLV+TjUwij
         bsfZDY6jBypKHgP7BrbzeVcSOmVE1HCzubVG2rsDTlKuwrr/x+xL5AUQPzcugD8pNc2K
         ObSEWbxcMHLA2oJgCHkC8uAVzkqrhr9awPjqhdE7APt53b2L7QfZEsBOPWjUg41mug/L
         HD1w==
X-Gm-Message-State: AO0yUKVDWUs1XOgg5T6ic6dJ9SYlKoU5ANLwH5ijmsUbsvYD8DBdVyiU
        YRHzNXTzO0TE3EDk6VBdwsg1ECoz1kQ/2Dntp9o=
X-Google-Smtp-Source: AK7set8PN3SZYYp+m1YrU/xTSFknmYctxBmpJQQ0LLgLQnvrFLo3VQHMCStJM9TDPSuv2GR8CbJUBRZa2ybaT3QivbU=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:a5cc:f0f5:1fc6:713])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:d2:b0:a8f:a6cc:9657 with
 SMTP id i18-20020a05690200d200b00a8fa6cc9657mr21963805ybs.7.1678916463697;
 Wed, 15 Mar 2023 14:41:03 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:40:59 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230315214059.395939-1-ndesaulniers@google.com>
Subject: [PATCH] Makefile: use -gdwarf-{4|5} for assembler for DEBUG_INFO_DWARF{4|5}
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sashal@kernel.org,
        stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is _not_ an upstream commit and just for 5.15.y only. It is based
on upstream
commit 32ef9e5054ec ("Makefile.debug: re-enable debug info for .S files").

When the user has chosen not to use their compiler's implicit default
DWARF version (which changes over time) via selecting
- CONFIG_DEBUG_INFO_DWARF4 or
- CONFIG_DEBUG_INFO_DWARF5
we need to tell the compiler this for Asm sources as well as C sources.
(We use the compiler to drive assembler jobs in kbuild, since most asm
needs to be preprocessed first).  Otherwise, we will get object files
built from Asm sources with the compiler's implicit default DWARF
version.

For example, selecting CONFIG_DEBUG_INFO_DWARF4 would produce a DWARFv5
vmlinux, since it was a mix of DWARFv4 object files from C sources and
DWARFv5 object files from Asm sources when using Clang as the assembler
(ex. `make LLVM=1`).

Fixes: 0ee2f0567a56 ("Makefile.debug: re-enable debug info for .S files")
Reported-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index a7b664680ea3..88b2b13bf35b 100644
--- a/Makefile
+++ b/Makefile
@@ -888,6 +888,7 @@ ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
+KBUILD_AFLAGS	+= -gdwarf-$(dwarf-version-y)
 endif
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
-- 
2.40.0.rc1.284.g88254d51c5-goog

