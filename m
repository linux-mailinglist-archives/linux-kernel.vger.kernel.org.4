Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745C5606760
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJTR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJTR5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:57:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE60199F45
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:57:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-349423f04dbso652487b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ec6GrMr134d5K39JN9EGJ6lab7lvP07iPKgVQfMKzc4=;
        b=mtYKVeaPkO6QSyeUgHeL74R1RQhtV2UFl2xprFsF7k0UOHVkxog3a3agIjyYv3ILMR
         4dSVWWVlgmc8KrTlUDBuLbRcOeAcF0U8Iyk1PPYvr12nkETiJYv/bAk7HxEytiR541B1
         mgRUbEGMGVDEFzROtM88OxMANZlTJ4aX5UpDMUN5y7aAqnTv2lPdsOMA0eh+QUygTC7e
         rdkY2Xmy4eTjg8T73nV4fuBen9o7yHdEZehpRGcwGmB/cUNC4svSLlIAcfz2olPG8WQ2
         RVxQF4AVw1EIE55AOV5reh/Hh3i8junL8h88BDFnoXKLqf6AbLmvsxUkPc/qx3M3FfX+
         QYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ec6GrMr134d5K39JN9EGJ6lab7lvP07iPKgVQfMKzc4=;
        b=BbVOgLk5Fo2R64cV/R2w3BIGgDgBgPJy5gYvGD9GLbOAxUOcstOqd+MMfB0AsjU+NR
         EGrjqsfL8DcTmN5mCbkTvUWJUHZI2w+mEf0ZXTwj3JUdZm8b2hrGx50QdYZosAEeMe6t
         abLTW/nnFbba+i5zCyBZTQfKXay451kfDMq2b8k0JA9NWcIr5Ec9AAdiMiBeaREvJuZV
         Ops2kXM8w/F0DvOCvDhuKh2aQmCgG8HOIUw+3K8bCii0WBNNFUDB5oTfzn/yUebb3sRR
         ZEipQboMWnFdyEprbmvaZMvpnAqr5Stuyz9Vd4+FYCPU3bfjP5O0V/ikHQDvKGnJ/aHB
         SRjw==
X-Gm-Message-State: ACrzQf0mBgK5wvmnpl/RY226TUhuLRT5pERxN4vlmjPAr+WoP/+U62bY
        Hxy9J28bGgw/cT9vDb6LtUtEifD5MvH1f07puJk=
X-Google-Smtp-Source: AMsMyM61Ms54Wunhjhdb9akAeWWVPBHJ4MsPlEjXe+lfdiz+EPY+7u8Q0NxjhR5fbjntLzuUa1dxx8OIJxC4iuYwi08=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:a5cc:f0f5:1fc6:713])
 (user=ndesaulniers job=sendgmr) by 2002:a5b:70f:0:b0:6ca:2f3d:1dbf with SMTP
 id g15-20020a5b070f000000b006ca2f3d1dbfmr3869419ybq.226.1666288628924; Thu,
 20 Oct 2022 10:57:08 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:56:49 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666288609; l=4033;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=ovpA4QAbIEpcw/Q/ivuVUvthOkcDqOfws3j88FyMzgY=;
 b=HkkhphwDWYZ/FhUnguFN40v5u3kGBJgdujuqhmHB95xetu3Y/CRX62Am2WTKt2C+2SJD4wlCo6t+
 bLkcFARMDCAEDA09XXeVkecc2rUQbLKhLHXREUK8x/aGjQwgZTb0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221020175655.1660864-1-ndesaulniers@google.com>
Subject: [PATCH] Makefile.debug: support for -gz=zstd
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@dhl.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make DEBUG_INFO_COMPRESSED a choice; DEBUG_INFO_UNCOMPRESSED is the
default, DEBUG_INFO_COMPRESSED uses zlib, DEBUG_INFO_COMPRESSED_ZSTD
uses zstd.

Some quick N=1 measurements with du, /usr/bin/time -v, and bloaty:

clang-16, x86_64 defconfig plus
CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_UNCOMPRESSED=y:
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:55.43
488M vmlinux
27.6%   136Mi   0.0%       0    .debug_info
 6.1%  30.2Mi   0.0%       0    .debug_str_offsets
 3.5%  17.2Mi   0.0%       0    .debug_line
 3.3%  16.3Mi   0.0%       0    .debug_loclists
 0.9%  4.62Mi   0.0%       0    .debug_str

clang-16, x86_64 defconfig plus
CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED=y (zlib):
Elapsed (wall clock) time (h:mm:ss or m:ss): 1:00.35
385M vmlinux
21.8%  85.4Mi   0.0%       0    .debug_info
 2.1%  8.26Mi   0.0%       0    .debug_str_offsets
 2.1%  8.24Mi   0.0%       0    .debug_loclists
 1.9%  7.48Mi   0.0%       0    .debug_line
 0.5%  1.94Mi   0.0%       0    .debug_str

clang-16, x86_64 defconfig plus
CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_ZSTD=y (zstd):
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:59.69
373M vmlinux
21.4%  81.4Mi   0.0%       0    .debug_info
 2.3%  8.85Mi   0.0%       0    .debug_loclists
 1.5%  5.71Mi   0.0%       0    .debug_line
 0.5%  1.95Mi   0.0%       0    .debug_str_offsets
 0.4%  1.62Mi   0.0%       0    .debug_str

That's only a 3.11% overall binary size savings over zlib, but at no
performance regression.

Link: https://maskray.me/blog/2022-09-09-zstd-compressed-debug-sections
Link: https://maskray.me/blog/2022-01-23-compressed-debug-sections
Suggested-by: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 lib/Kconfig.debug      | 26 +++++++++++++++++++++++++-
 scripts/Makefile.debug |  4 ++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3fc7abffc7aa..4085ac77dc12 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -312,8 +312,22 @@ config DEBUG_INFO_REDUCED
 	  DEBUG_INFO build and compile times are reduced too.
 	  Only works with newer gcc versions.
 
+choice
+	prompt "Compressed Debug information"
+	depends on DEBUG_KERNEL
+	help
+	  Compress the resulting debug info. Results in smaller debug info sections,
+	  but requires that consumers are able to decompress the results.
+
+	  If unsure, choose DEBUG_INFO_UNCOMPRESSED.
+
+config DEBUG_INFO_UNCOMPRESSED
+	bool "Don't compress debug information"
+	help
+	  Don't compress debug info sections.
+
 config DEBUG_INFO_COMPRESSED
-	bool "Compressed debugging information"
+	bool "Compress debugging information with zlib"
 	depends on $(cc-option,-gz=zlib)
 	depends on $(ld-option,--compress-debug-sections=zlib)
 	help
@@ -327,6 +341,16 @@ config DEBUG_INFO_COMPRESSED
 	  preferable to setting $KDEB_COMPRESS to "none" which would be even
 	  larger.
 
+config DEBUG_INFO_COMPRESSED_ZSTD
+	bool "Compress debugging information with zstd"
+	depends on $(cc-option,-gz=zstd)
+	depends on $(ld-option,--compress-debug-sections=zstd)
+	help
+	  Compress the debug information using zstd.  Requires GCC 13.0+ or Clang
+	  16.0+, binutils 2.40+, and zstd.
+
+endchoice # "Compressed Debug information"
+
 config DEBUG_INFO_SPLIT
 	bool "Produce split debuginfo in .dwo files"
 	depends on $(cc-option,-gsplit-dwarf)
diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 332c486f705f..8ac3379d2255 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -31,6 +31,10 @@ ifdef CONFIG_DEBUG_INFO_COMPRESSED
 DEBUG_CFLAGS	+= -gz=zlib
 KBUILD_AFLAGS	+= -gz=zlib
 KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
+else ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZSTD
+DEBUG_CFLAGS	+= -gz=zstd
+KBUILD_AFLAGS	+= -gz=zstd
+KBUILD_LDFLAGS	+= --compress-debug-sections=zstd
 endif
 
 KBUILD_CFLAGS	+= $(DEBUG_CFLAGS)
-- 
2.38.0.135.g90850a2211-goog

