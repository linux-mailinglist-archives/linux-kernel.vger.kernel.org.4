Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0661FCBB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiKGSF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiKGSFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:05:03 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3CC264A8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:01:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36bf9c132f9so114343307b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tS32EJHch/dBCbWB1L1GEsMMs2fsIbqQFe/97cUFWvM=;
        b=SQYIlLQKDlVnO9q4XFVS6JNGHFLzyXs2BBOTrJ3U2uoFJbz2V1TKCFigITFOkkCBsE
         P7yQEfNwhQDVnNt0lODX16Vj27w+OJsABLNwgNbT28C7yj0B7MRxu0LROLDNT0YKsV2H
         JtLo7sPWQ4n6uVNVn1LklyOZb4adAa+tyftuIUOIFc8ZIbd407jzLM9lVPMTITSIu3QB
         z+ijEaWLv3jAQQ3qeE5n4npuiVJSiDgovDpowJTDvxuAEeEvl5gsUaouodZ7uuTbA+f5
         P4Jrw/KEVPN5Bt0BkSSedMJ32GuffqeJmr+qFlsHcZUirO7vanhPCmC7o4mKfdGCT6jn
         VLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tS32EJHch/dBCbWB1L1GEsMMs2fsIbqQFe/97cUFWvM=;
        b=t05Obq/ezGFB7a3W5ZkrHk17b4kTvJweTq5MXtsqVfpbQWZKIKuhMCayDWu5rbhvN/
         Dt8yc80jd0bszOUCfw7P3R89CchKnFL1OnYwaxYJgaJI3Qc2RPq8kLM9CiopINF2IrqM
         aZfcVcww4r/mUkOQk53g6CnOxnX8r3pu2VZoo8qA2HdkrMLKwDa9urtlRLqV3UmL+81j
         mtvgkdJ3X6gUW0Kz4gOns4MAS5KGe3F6JBtMvjGks33g4GP39Q3IZm0iOjNvKv2lmGtq
         TdLFueqK7ybzorwouO6an94vxMT3IIs2PqP5S53qJRtIXlNLp/SGXBFSzkpojGBS+4Kp
         iBWg==
X-Gm-Message-State: ACrzQf3lDtg0TVApqdkxNr785yMLlcqu7VeW1zS7h+SHrGbSSAioHEj+
        7lfrLcJQgevKPMuzW7/YRMVgDJ16+9KuiC9Tt1o=
X-Google-Smtp-Source: AMsMyM43ETSncLgam+YPFOfqqMnPhR2b4p/E/JIxE9g3tkFOoKJwqElFbUb+Eh05NX1YCpgkMicQmG4tLxtVEWUKbzg=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:a5cc:f0f5:1fc6:713])
 (user=ndesaulniers job=sendgmr) by 2002:a25:a18a:0:b0:6cc:90d7:2494 with SMTP
 id a10-20020a25a18a000000b006cc90d72494mr44462663ybi.210.1667844106473; Mon,
 07 Nov 2022 10:01:46 -0800 (PST)
Date:   Mon,  7 Nov 2022 10:01:33 -0800
In-Reply-To: <CAK7LNATrBDSLqBZFmWr5RA542pUVR=mieUSNVYXy8thkHS6w_A@mail.gmail.com>
Mime-Version: 1.0
References: <CAK7LNATrBDSLqBZFmWr5RA542pUVR=mieUSNVYXy8thkHS6w_A@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667844093; l=4727;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=ngUXhzx1TaUsWCpO5TJrX+dyZDEqf8GPaOtwJXhjBcI=;
 b=mh/Lzv9loBNdaHCrZfNBXOodUwGUUfOiCAZ00kw3hTNN2oumOkTD1WEv6uV6QH6fLPk2XynGvH1k
 Cqo9MNghBOERc78BQRWrFhcemifO4ZzhW5x8THu1yfxq7Ar1hk+U
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221107180137.3634978-1-ndesaulniers@google.com>
Subject: [PATCH v2] Makefile.debug: support for -gz=zstd
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@dhl.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Terrell <terrelln@fb.com>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

This renames the existing KConfig options:
* DEBUG_INFO_UNCOMPRESSED -> DEBUG_INFO_COMPRESSED_NONE
* DEBUG_INFO_COMPRESSED -> DEBUG_INFO_COMPRESSED_ZLIB
So users upgrading may need to reset the new Kconfigs.

Link: https://maskray.me/blog/2022-09-09-zstd-compressed-debug-sections
Link: https://maskray.me/blog/2022-01-23-compressed-debug-sections
Suggested-by: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Remove `depends on DEBUG_KERNEL` as per Nathan.
* Rename Kconfigs as per Sedat and Masahiro.
* Add note about renamed Kconfigs to commit message.
* Add more help text to DEBUG_INFO_COMPRESSED_ZSTD.

 lib/Kconfig.debug      | 29 +++++++++++++++++++++++++++--
 scripts/Makefile.debug |  4 ++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 29280072dc0e..7c28a8fba02e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -312,8 +312,21 @@ config DEBUG_INFO_REDUCED
 	  DEBUG_INFO build and compile times are reduced too.
 	  Only works with newer gcc versions.
 
-config DEBUG_INFO_COMPRESSED
-	bool "Compressed debugging information"
+choice
+	prompt "Compressed Debug information"
+	help
+	  Compress the resulting debug info. Results in smaller debug info sections,
+	  but requires that consumers are able to decompress the results.
+
+	  If unsure, choose DEBUG_INFO_COMPRESSED_NONE.
+
+config DEBUG_INFO_COMPRESSED_NONE
+	bool "Don't compress debug information"
+	help
+	  Don't compress debug info sections.
+
+config DEBUG_INFO_COMPRESSED_ZLIB
+	bool "Compress debugging information with zlib"
 	depends on $(cc-option,-gz=zlib)
 	depends on $(ld-option,--compress-debug-sections=zlib)
 	help
@@ -327,6 +340,18 @@ config DEBUG_INFO_COMPRESSED
 	  preferable to setting $KDEB_COMPRESS to "none" which would be even
 	  larger.
 
+config DEBUG_INFO_COMPRESSED_ZSTD
+	bool "Compress debugging information with zstd"
+	depends on $(cc-option,-gz=zstd)
+	depends on $(ld-option,--compress-debug-sections=zstd)
+	help
+	  Compress the debug information using zstd.  This may provide better
+	  compression than zlib, for about the same time costs, but requires newer
+	  toolchain support.  Requires GCC 13.0+ or Clang 16.0+, binutils 2.40+, and
+	  zstd.
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

base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.38.1.431.g37b22c650d-goog

