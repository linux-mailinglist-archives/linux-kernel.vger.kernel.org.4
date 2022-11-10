Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D20624B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiKJUAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:00:37 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6F11DDE3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:00:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36b1a68bfa6so25312957b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIHNRdmfkBzhmHybI0x1Prd4hOkiCS+S8r79WveHpBo=;
        b=cu4FgUi89nxSfbZYxNMsDps7Ulsc39wNIRiDjhIKxXG80QX1OL9tfuJPG63usxMrfZ
         EW0EhYGrzNcvEDeg2LJwpIMVIEsDsbkhn78rH9inwUS2fi3OUzn6YBpR5JzoNX6d5akX
         yqZCNCDPjsURHtfN5tzUr2oSAmpKUAFfossYVIzMMav+l/GeZKi76Cb8lVJD6ulhALkn
         4ZEL0WiaB82yxJCGdS78iyKyD/dTmcRRuVN3b2tisbYjQF4Ebuee6VzRaHXhrGmUseAM
         WxD3VAndP/oMYJHCM61Aw0DedqJxA7H47RNOKvSX93tfo+usF2majhxcgW8/rpkNYS+a
         gtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIHNRdmfkBzhmHybI0x1Prd4hOkiCS+S8r79WveHpBo=;
        b=XzXQ37vqT1+i/TLL4F2z2AsPOc+HbTPgwglWO78ktACzmhGeNT1itXlgAPqb0FnPcm
         KB1KigEEnBaU08NrkhZ/ImVDLmz+tBypFIImXbe0zMIiTpqN1NmyxscJioSjSTbePzvZ
         ATOKCTybVKRmfeswiyntSdICjhRCFmMDa9OYDTtoopPt47EkEU13V6mwdr9QrFBu9g89
         cFi1Du8j2Z1vTAzXz4yTa0W41fml2TinSRsY/KrjQ6tpcaIZ0x2/e+X8/ZcuRS1hTAQw
         FPr/iSLZb6oYFXEvW/7s0gG7HMnCzxogmc0fkJr+R+dQ/J2ICQDsvfLpmBGCHPobUAC4
         jQZg==
X-Gm-Message-State: ANoB5pmi417vJP2fGCCbFKoJYfcnDqmiV+/I04TQbmiM/G+JCHunatlI
        GPszzXYpMU/rNxAC+7hGSEdc5VUU1RSUQZAM3qM=
X-Google-Smtp-Source: AA0mqf4Nns+WLB4chAB/kEa+/ldX4+HthE59/h8FIr8lboM5FzK8xxaLgMNVvf52/T7Ej8fhOWa1WRKalLbmf188S8Q=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:a5cc:f0f5:1fc6:713])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:154d:b0:6dc:5d5a:26a4 with
 SMTP id r13-20020a056902154d00b006dc5d5a26a4mr5480669ybu.286.1668110395128;
 Thu, 10 Nov 2022 11:59:55 -0800 (PST)
Date:   Thu, 10 Nov 2022 11:59:05 -0800
In-Reply-To: <CA+icZUW83H0H-oQkE5vyURWu6bD-OGYpTsNMwU1if5r=7+tpDA@mail.gmail.com>
Mime-Version: 1.0
References: <CA+icZUW83H0H-oQkE5vyURWu6bD-OGYpTsNMwU1if5r=7+tpDA@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668110345; l=4874;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=5du/c21UJsTP9Yrc1x6+H5At2NkImsL0yE/dV2D9Aqg=;
 b=jLKlgldZtH5445CKtJeiIIGHnUJ3Z4tI5G9+yYiQLjJ+BdGcCieQnNZdfViY/CuZT+HHt3oI8367
 yREqodIHD14KXhNcsVBB4b6lhbRZUHDyA/h8pnghqSzqf4T1ULA7
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110195932.377841-1-ndesaulniers@google.com>
Subject: [PATCH v3] Makefile.debug: support for -gz=zstd
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make DEBUG_INFO_COMPRESSED a choice; DEBUG_INFO_COMPRESSED_NONE is the
default, DEBUG_INFO_COMPRESSED_ZLIB uses zlib,
DEBUG_INFO_COMPRESSED_ZSTD uses zstd.

This renames the existing KConfig option DEBUG_INFO_COMPRESSED to
DEBUG_INFO_COMPRESSED_ZLIB so users upgrading may need to reset the new
Kconfigs.

Some quick N=1 measurements with du, /usr/bin/time -v, and bloaty:

clang-16, x86_64 defconfig plus
CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_NONE=y:
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:55.43
488M vmlinux
27.6%   136Mi   0.0%       0    .debug_info
 6.1%  30.2Mi   0.0%       0    .debug_str_offsets
 3.5%  17.2Mi   0.0%       0    .debug_line
 3.3%  16.3Mi   0.0%       0    .debug_loclists
 0.9%  4.62Mi   0.0%       0    .debug_str

clang-16, x86_64 defconfig plus
CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_ZLIB=y:
Elapsed (wall clock) time (h:mm:ss or m:ss): 1:00.35
385M vmlinux
21.8%  85.4Mi   0.0%       0    .debug_info
 2.1%  8.26Mi   0.0%       0    .debug_str_offsets
 2.1%  8.24Mi   0.0%       0    .debug_loclists
 1.9%  7.48Mi   0.0%       0    .debug_line
 0.5%  1.94Mi   0.0%       0    .debug_str

clang-16, x86_64 defconfig plus
CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_ZSTD=y:
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
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v2 -> v3:
* Fix scripts/Makefile.debug as per Sedat.
* Update commit message as per Nicolas.

Changes v1 -> v2:
* Remove `depends on DEBUG_KERNEL` as per Nathan.
* Rename Kconfigs as per Sedat and Masahiro.
* Add note about renamed Kconfigs to commit message.
* Add more help text to DEBUG_INFO_COMPRESSED_ZSTD.


 lib/Kconfig.debug      | 29 +++++++++++++++++++++++++++--
 scripts/Makefile.debug |  6 +++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

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
index 332c486f705f..059ff38fe0cb 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -27,10 +27,14 @@ else
 DEBUG_RUSTFLAGS	+= -Cdebuginfo=2
 endif
 
-ifdef CONFIG_DEBUG_INFO_COMPRESSED
+ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZLIB
 DEBUG_CFLAGS	+= -gz=zlib
 KBUILD_AFLAGS	+= -gz=zlib
 KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
+else ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZSTD
+DEBUG_CFLAGS	+= -gz=zstd
+KBUILD_AFLAGS	+= -gz=zstd
+KBUILD_LDFLAGS	+= --compress-debug-sections=zstd
 endif
 
 KBUILD_CFLAGS	+= $(DEBUG_CFLAGS)

base-commit: 1767a722a708f1fa3b9af39eb091d79101f8c086
-- 
2.38.1.431.g37b22c650d-goog

