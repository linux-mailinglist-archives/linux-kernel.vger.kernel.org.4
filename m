Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA260BD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJXWFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiJXWEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:04:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851879B877
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:18:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p3so8457931pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB3pyQlqU5SvdVBqjlavg6jCXdGT84BHAaSWMzVkXOo=;
        b=YLYcPh3xqTG9AeKDSkjtmLRFUlHAUM8tfpWOlUo0ZXdZIAI6rFABrhvJWJpsqmZnV4
         Z26OsfqsppHuX2fctY+4eBWExvZLQba53Wk2E6FCgNl98lOL4nmj7jIcOv60wA5ZxB9K
         K78uqapxkvEYLhhkjeMcU6JjF3SiS4IV4rzLlfkWn6/29aqsmZK9XigdbY1Jd0OLge3K
         aYYM0Tq9hwXw2muFyd/SQBbTNZjdZ5dKtW9ezOQybcQFlttRpi8ITnE36hYNw+rq7HI9
         sQxeK2zfC592FO3lMm2x0gy2WiZcfmzLtCdPSH/HFHSZN96kjbZ9av+8OcDD4kluUAup
         7ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB3pyQlqU5SvdVBqjlavg6jCXdGT84BHAaSWMzVkXOo=;
        b=LTRStc4dfx+sL4/vgKvm0TLaH5ch+hLd8O2aj4lG3Zsj53ofYOxwDfRJK94yEJ9fMr
         +YaDb+3ZDCMMdABboxEPRwZpIqKvpf4g0pJSCcqNUWjEAG6Dz5J6w4bPQEBx44J0bQRS
         MeWjRI88lbO4r6XqMaGW5TZS89XmDfWXGTt7tIMgmuGNc7t4SHxT8wU+19OMeV5AZBhp
         EmOUet0nda8QEChinuLG9SghV4GkmBRRNOHru1NgoTyKENepxjz5eHfhTsZDkFavIuNx
         cHK2gjTjKJKMtuUJ5RRpXuxWrlqMjqs8bFRd/oRff/nhkwYvnxCrUFmgMCgXacgWqdFf
         w0iw==
X-Gm-Message-State: ACrzQf1LDbjjXtfcqn4L1Udm7fkGkmJ8/P+MNBgBW868jEWXS+F27YB5
        b2O9tFny+wf5XdWsKz0uFSM=
X-Google-Smtp-Source: AMsMyM6ac3ZzzIv1sM0wR5ZU2+PHPb0yp84WErkBW2Z+dFRhw+IGwZY+Zpgpvn03lom549Z9j1g03A==
X-Received: by 2002:a17:90b:1e11:b0:20d:90b3:45a0 with SMTP id pg17-20020a17090b1e1100b0020d90b345a0mr72718807pjb.29.1666642615999;
        Mon, 24 Oct 2022 13:16:55 -0700 (PDT)
Received: from localhost.localdomain (c-98-35-160-214.hsd1.ca.comcast.net. [98.35.160.214])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7972e000000b0056bb4dc8164sm173518pfg.193.2022.10.24.13.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:16:55 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Terrell <nickrterrell@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Sam Hardeman <natrox@outlook.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: [PATCH 2/2] zstd: import usptream v1.5.2
Date:   Mon, 24 Oct 2022 13:26:06 -0700
Message-Id: <20221024202606.404049-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024202606.404049-1-nickrterrell@gmail.com>
References: <20221024202606.404049-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Updates the kernel's zstd library to v1.5.2, the latest zstd release.
The upstream tag it is updated to is `v1.5.2-kernel`, which contains
several cherry-picked commits on top of the v1.5.2 release which are
required for the kernel update. I will create this tag once the PR is
ready to merge, until then reference the temporary upstream branch
`v1.5.2-kernel-cherrypicks`.

I plan to submit this patch as part of the v6.2 merge window.

I've done basic build testing & testing on x86-64, i386, and aarch64.
I'm merging these patches into my `zstd-next` branch, which is pulled
into `linux-next` for further testing.

I've benchmarked BtrFS with zstd compression on a x86-64 machine, and
saw these results. Decompression speed is a small win across the board.
The lower compression levels 1-4 see both compression speed and
compression ratio wins. The higher compression levels see a small
compression speed loss and about neutral ratio. I expect the lower
compression levels to be used much more heavily than the high
compression levels, so this should be a net win.

Level	CTime	DTime	Ratio
1	-2.95%	-1.1%	-0.7%
3	-3.5%	-1.2%	-0.5%
5	+3.7%	-1.0%	+0.0%
7	+3.2%	-0.9%	+0.0%
9	-4.3%	-0.8%	+0.1%

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 include/linux/zstd_lib.h                      |  479 ++--
 lib/zstd/common/bitstream.h                   |    9 +
 lib/zstd/common/compiler.h                    |   67 +-
 lib/zstd/common/entropy_common.c              |    7 +-
 lib/zstd/common/error_private.h               |   81 +-
 lib/zstd/common/fse.h                         |    3 +-
 lib/zstd/common/fse_decompress.c              |    2 +-
 lib/zstd/common/huf.h                         |   46 +-
 lib/zstd/common/mem.h                         |    2 +
 lib/zstd/common/portability_macros.h          |   93 +
 lib/zstd/common/zstd_internal.h               |  175 +-
 lib/zstd/compress/clevels.h                   |  132 ++
 lib/zstd/compress/fse_compress.c              |   83 +-
 lib/zstd/compress/huf_compress.c              |  644 +++++-
 lib/zstd/compress/zstd_compress.c             | 2000 +++++++++++++----
 lib/zstd/compress/zstd_compress_internal.h    |  375 +++-
 lib/zstd/compress/zstd_compress_literals.c    |    9 +-
 lib/zstd/compress/zstd_compress_literals.h    |    4 +-
 lib/zstd/compress/zstd_compress_sequences.c   |   31 +-
 lib/zstd/compress/zstd_compress_superblock.c  |  295 +--
 lib/zstd/compress/zstd_cwksp.h                |  225 +-
 lib/zstd/compress/zstd_double_fast.c          |  413 +++-
 lib/zstd/compress/zstd_fast.c                 |  441 ++--
 lib/zstd/compress/zstd_lazy.c                 | 1352 ++++++++---
 lib/zstd/compress/zstd_lazy.h                 |   38 +
 lib/zstd/compress/zstd_ldm.c                  |   76 +-
 lib/zstd/compress/zstd_ldm.h                  |    1 +
 lib/zstd/compress/zstd_ldm_geartab.h          |    5 +-
 lib/zstd/compress/zstd_opt.c                  |  402 ++--
 lib/zstd/decompress/huf_decompress.c          |  912 ++++++--
 lib/zstd/decompress/zstd_decompress.c         |   80 +-
 lib/zstd/decompress/zstd_decompress_block.c   | 1022 +++++++--
 lib/zstd/decompress/zstd_decompress_block.h   |   10 +-
 .../decompress/zstd_decompress_internal.h     |   38 +-
 lib/zstd/decompress_sources.h                 |    6 +
 lib/zstd/zstd_compress_module.c               |    6 +-
 36 files changed, 6955 insertions(+), 2609 deletions(-)
 create mode 100644 lib/zstd/common/portability_macros.h
 create mode 100644 lib/zstd/compress/clevels.h

diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
index b8c7dbf98390..79d55465d5c1 100644
--- a/include/linux/zstd_lib.h
+++ b/include/linux/zstd_lib.h
@@ -17,8 +17,16 @@
 
 
 /* =====   ZSTDLIB_API : control library symbols visibility   ===== */
-#define ZSTDLIB_VISIBILITY 
-#define ZSTDLIB_API ZSTDLIB_VISIBILITY
+#ifndef ZSTDLIB_VISIBLE
+#  if (__GNUC__ >= 4) && !defined(__MINGW32__)
+#    define ZSTDLIB_VISIBLE __attribute__ ((visibility ("default")))
+#    define ZSTDLIB_HIDDEN __attribute__ ((visibility ("hidden")))
+#  else
+#    define ZSTDLIB_VISIBLE
+#    define ZSTDLIB_HIDDEN
+#  endif
+#endif
+#define ZSTDLIB_API ZSTDLIB_VISIBLE
 
 
 /* *****************************************************************************
@@ -56,8 +64,8 @@
 
 /*------   Version   ------*/
 #define ZSTD_VERSION_MAJOR    1
-#define ZSTD_VERSION_MINOR    4
-#define ZSTD_VERSION_RELEASE  10
+#define ZSTD_VERSION_MINOR    5
+#define ZSTD_VERSION_RELEASE  2
 #define ZSTD_VERSION_NUMBER  (ZSTD_VERSION_MAJOR *100*100 + ZSTD_VERSION_MINOR *100 + ZSTD_VERSION_RELEASE)
 
 /*! ZSTD_versionNumber() :
@@ -94,7 +102,6 @@ ZSTDLIB_API const char* ZSTD_versionString(void);
 #define ZSTD_BLOCKSIZE_MAX     (1<<ZSTD_BLOCKSIZELOG_MAX)
 
 
-
 /* *************************************
 *  Simple API
 ***************************************/
@@ -151,7 +158,7 @@ ZSTDLIB_API unsigned long long ZSTD_getFrameContentSize(const void *src, size_t
  * @return : decompressed size of `src` frame content _if known and not empty_, 0 otherwise. */
 ZSTDLIB_API unsigned long long ZSTD_getDecompressedSize(const void* src, size_t srcSize);
 
-/*! ZSTD_findFrameCompressedSize() :
+/*! ZSTD_findFrameCompressedSize() : Requires v1.4.0+
  * `src` should point to the start of a ZSTD frame or skippable frame.
  * `srcSize` must be >= first frame size
  * @return : the compressed size of the first frame starting at `src`,
@@ -165,8 +172,9 @@ ZSTDLIB_API size_t ZSTD_findFrameCompressedSize(const void* src, size_t srcSize)
 ZSTDLIB_API size_t      ZSTD_compressBound(size_t srcSize); /*!< maximum compressed size in worst case single-pass scenario */
 ZSTDLIB_API unsigned    ZSTD_isError(size_t code);          /*!< tells if a `size_t` function result is an error code */
 ZSTDLIB_API const char* ZSTD_getErrorName(size_t code);     /*!< provides readable string from an error code */
-ZSTDLIB_API int         ZSTD_minCLevel(void);               /*!< minimum negative compression level allowed */
+ZSTDLIB_API int         ZSTD_minCLevel(void);               /*!< minimum negative compression level allowed, requires v1.4.0+ */
 ZSTDLIB_API int         ZSTD_maxCLevel(void);               /*!< maximum compression level available */
+ZSTDLIB_API int         ZSTD_defaultCLevel(void);           /*!< default compression level, specified by ZSTD_CLEVEL_DEFAULT, requires v1.5.0+ */
 
 
 /* *************************************
@@ -219,9 +227,9 @@ ZSTDLIB_API size_t ZSTD_decompressDCtx(ZSTD_DCtx* dctx,
                                  const void* src, size_t srcSize);
 
 
-/* *************************************
-*  Advanced compression API
-***************************************/
+/* *******************************************
+*  Advanced compression API (Requires v1.4.0+)
+**********************************************/
 
 /* API design :
  *   Parameters are pushed one by one into an existing context,
@@ -232,7 +240,7 @@ ZSTDLIB_API size_t ZSTD_decompressDCtx(ZSTD_DCtx* dctx,
  *
  *   It's possible to reset all parameters to "default" using ZSTD_CCtx_reset().
  *
- *   This API supercedes all other "advanced" API entry points in the experimental section.
+ *   This API supersedes all other "advanced" API entry points in the experimental section.
  *   In the future, we expect to remove from experimental API entry points which are redundant with this API.
  */
 
@@ -251,7 +259,6 @@ typedef enum { ZSTD_fast=1,
                          Only the order (from fast to strong) is guaranteed */
 } ZSTD_strategy;
 
-
 typedef enum {
 
     /* compression parameters
@@ -317,7 +324,6 @@ typedef enum {
                               * The higher the value of selected strategy, the more complex it is,
                               * resulting in stronger and slower compression.
                               * Special: value 0 means "use default strategy". */
-
     /* LDM mode parameters */
     ZSTD_c_enableLongDistanceMatching=160, /* Enable long distance matching.
                                      * This parameter is designed to improve compression ratio
@@ -374,7 +380,7 @@ typedef enum {
     ZSTD_c_jobSize=401,      /* Size of a compression job. This value is enforced only when nbWorkers >= 1.
                               * Each compression job is completed in parallel, so this value can indirectly impact the nb of active threads.
                               * 0 means default, which is dynamically determined based on compression parameters.
-                              * Job size must be a minimum of overlap size, or 1 MB, whichever is largest.
+                              * Job size must be a minimum of overlap size, or ZSTDMT_JOBSIZE_MIN (= 512 KB), whichever is largest.
                               * The minimum size is automatically and transparently enforced. */
     ZSTD_c_overlapLog=402,   /* Control the overlap size, as a fraction of window size.
                               * The overlap size is an amount of data reloaded from previous job at the beginning of a new job.
@@ -404,6 +410,8 @@ typedef enum {
      * ZSTD_c_stableOutBuffer
      * ZSTD_c_blockDelimiters
      * ZSTD_c_validateSequences
+     * ZSTD_c_useBlockSplitter
+     * ZSTD_c_useRowMatchFinder
      * Because they are not stable, it's necessary to define ZSTD_STATIC_LINKING_ONLY to access them.
      * note : never ever use experimentalParam? names directly;
      *        also, the enums values themselves are unstable and can still change.
@@ -419,7 +427,10 @@ typedef enum {
      ZSTD_c_experimentalParam9=1006,
      ZSTD_c_experimentalParam10=1007,
      ZSTD_c_experimentalParam11=1008,
-     ZSTD_c_experimentalParam12=1009
+     ZSTD_c_experimentalParam12=1009,
+     ZSTD_c_experimentalParam13=1010,
+     ZSTD_c_experimentalParam14=1011,
+     ZSTD_c_experimentalParam15=1012
 } ZSTD_cParameter;
 
 typedef struct {
@@ -504,9 +515,9 @@ ZSTDLIB_API size_t ZSTD_compress2( ZSTD_CCtx* cctx,
                              const void* src, size_t srcSize);
 
 
-/* *************************************
-*  Advanced decompression API
-***************************************/
+/* *********************************************
+*  Advanced decompression API (Requires v1.4.0+)
+************************************************/
 
 /* The advanced API pushes parameters one by one into an existing DCtx context.
  * Parameters are sticky, and remain valid for all following frames
@@ -668,7 +679,7 @@ typedef enum {
                         : note : multithreaded compression will block to flush as much output as possible. */
 } ZSTD_EndDirective;
 
-/*! ZSTD_compressStream2() :
+/*! ZSTD_compressStream2() : Requires v1.4.0+
  *  Behaves about the same as ZSTD_compressStream, with additional control on end directive.
  *  - Compression parameters are pushed into CCtx before starting compression, using ZSTD_CCtx_set*()
  *  - Compression parameters cannot be changed once compression is started (save a list of exceptions in multi-threading mode)
@@ -714,11 +725,11 @@ ZSTDLIB_API size_t ZSTD_CStreamOutSize(void);   /*< recommended size for output
 
 
 /* *****************************************************************************
- * This following is a legacy streaming API.
+ * This following is a legacy streaming API, available since v1.0+ .
  * It can be replaced by ZSTD_CCtx_reset() and ZSTD_compressStream2().
  * It is redundant, but remains fully supported.
- * Advanced parameters and dictionary compression can only be used through the
- * new API.
+ * Streaming in combination with advanced parameters and dictionary compression
+ * can only be used through the new API.
  ******************************************************************************/
 
 /*!
@@ -796,7 +807,7 @@ ZSTDLIB_API size_t ZSTD_DStreamOutSize(void);   /*!< recommended size for output
 /*! ZSTD_compress_usingDict() :
  *  Compression at an explicit compression level using a Dictionary.
  *  A dictionary can be any arbitrary data segment (also called a prefix),
- *  or a buffer with specified information (see dictBuilder/zdict.h).
+ *  or a buffer with specified information (see zdict.h).
  *  Note : This function loads the dictionary, resulting in significant startup delay.
  *         It's intended for a dictionary used only once.
  *  Note 2 : When `dict == NULL || dictSize < 8` no dictionary is used. */
@@ -879,19 +890,25 @@ ZSTDLIB_API size_t ZSTD_decompress_usingDDict(ZSTD_DCtx* dctx,
  *  Dictionary helper functions
  *******************************/
 
-/*! ZSTD_getDictID_fromDict() :
+/*! ZSTD_getDictID_fromDict() : Requires v1.4.0+
  *  Provides the dictID stored within dictionary.
  *  if @return == 0, the dictionary is not conformant with Zstandard specification.
  *  It can still be loaded, but as a content-only dictionary. */
 ZSTDLIB_API unsigned ZSTD_getDictID_fromDict(const void* dict, size_t dictSize);
 
-/*! ZSTD_getDictID_fromDDict() :
+/*! ZSTD_getDictID_fromCDict() : Requires v1.5.0+
+ *  Provides the dictID of the dictionary loaded into `cdict`.
+ *  If @return == 0, the dictionary is not conformant to Zstandard specification, or empty.
+ *  Non-conformant dictionaries can still be loaded, but as content-only dictionaries. */
+ZSTDLIB_API unsigned ZSTD_getDictID_fromCDict(const ZSTD_CDict* cdict);
+
+/*! ZSTD_getDictID_fromDDict() : Requires v1.4.0+
  *  Provides the dictID of the dictionary loaded into `ddict`.
  *  If @return == 0, the dictionary is not conformant to Zstandard specification, or empty.
  *  Non-conformant dictionaries can still be loaded, but as content-only dictionaries. */
 ZSTDLIB_API unsigned ZSTD_getDictID_fromDDict(const ZSTD_DDict* ddict);
 
-/*! ZSTD_getDictID_fromFrame() :
+/*! ZSTD_getDictID_fromFrame() : Requires v1.4.0+
  *  Provides the dictID required to decompressed the frame stored within `src`.
  *  If @return == 0, the dictID could not be decoded.
  *  This could for one of the following reasons :
@@ -905,16 +922,16 @@ ZSTDLIB_API unsigned ZSTD_getDictID_fromFrame(const void* src, size_t srcSize);
 
 
 /* *****************************************************************************
- * Advanced dictionary and prefix API
+ * Advanced dictionary and prefix API (Requires v1.4.0+)
  *
  * This API allows dictionaries to be used with ZSTD_compress2(),
- * ZSTD_compressStream2(), and ZSTD_decompress(). Dictionaries are sticky, and
+ * ZSTD_compressStream2(), and ZSTD_decompressDCtx(). Dictionaries are sticky, and
  * only reset with the context is reset with ZSTD_reset_parameters or
  * ZSTD_reset_session_and_parameters. Prefixes are single-use.
  ******************************************************************************/
 
 
-/*! ZSTD_CCtx_loadDictionary() :
+/*! ZSTD_CCtx_loadDictionary() : Requires v1.4.0+
  *  Create an internal CDict from `dict` buffer.
  *  Decompression will have to use same dictionary.
  * @result : 0, or an error code (which can be tested with ZSTD_isError()).
@@ -933,7 +950,7 @@ ZSTDLIB_API unsigned ZSTD_getDictID_fromFrame(const void* src, size_t srcSize);
  *           to precisely select how dictionary content must be interpreted. */
 ZSTDLIB_API size_t ZSTD_CCtx_loadDictionary(ZSTD_CCtx* cctx, const void* dict, size_t dictSize);
 
-/*! ZSTD_CCtx_refCDict() :
+/*! ZSTD_CCtx_refCDict() : Requires v1.4.0+
  *  Reference a prepared dictionary, to be used for all next compressed frames.
  *  Note that compression parameters are enforced from within CDict,
  *  and supersede any compression parameter previously set within CCtx.
@@ -947,7 +964,7 @@ ZSTDLIB_API size_t ZSTD_CCtx_loadDictionary(ZSTD_CCtx* cctx, const void* dict, s
  *  Note 2 : CDict is just referenced, its lifetime must outlive its usage within CCtx. */
 ZSTDLIB_API size_t ZSTD_CCtx_refCDict(ZSTD_CCtx* cctx, const ZSTD_CDict* cdict);
 
-/*! ZSTD_CCtx_refPrefix() :
+/*! ZSTD_CCtx_refPrefix() : Requires v1.4.0+
  *  Reference a prefix (single-usage dictionary) for next compressed frame.
  *  A prefix is **only used once**. Tables are discarded at end of frame (ZSTD_e_end).
  *  Decompression will need same prefix to properly regenerate data.
@@ -968,7 +985,7 @@ ZSTDLIB_API size_t ZSTD_CCtx_refCDict(ZSTD_CCtx* cctx, const ZSTD_CDict* cdict);
 ZSTDLIB_API size_t ZSTD_CCtx_refPrefix(ZSTD_CCtx* cctx,
                                  const void* prefix, size_t prefixSize);
 
-/*! ZSTD_DCtx_loadDictionary() :
+/*! ZSTD_DCtx_loadDictionary() : Requires v1.4.0+
  *  Create an internal DDict from dict buffer,
  *  to be used to decompress next frames.
  *  The dictionary remains valid for all future frames, until explicitly invalidated.
@@ -985,7 +1002,7 @@ ZSTDLIB_API size_t ZSTD_CCtx_refPrefix(ZSTD_CCtx* cctx,
  */
 ZSTDLIB_API size_t ZSTD_DCtx_loadDictionary(ZSTD_DCtx* dctx, const void* dict, size_t dictSize);
 
-/*! ZSTD_DCtx_refDDict() :
+/*! ZSTD_DCtx_refDDict() : Requires v1.4.0+
  *  Reference a prepared dictionary, to be used to decompress next frames.
  *  The dictionary remains active for decompression of future frames using same DCtx.
  *
@@ -1003,7 +1020,7 @@ ZSTDLIB_API size_t ZSTD_DCtx_loadDictionary(ZSTD_DCtx* dctx, const void* dict, s
  */
 ZSTDLIB_API size_t ZSTD_DCtx_refDDict(ZSTD_DCtx* dctx, const ZSTD_DDict* ddict);
 
-/*! ZSTD_DCtx_refPrefix() :
+/*! ZSTD_DCtx_refPrefix() : Requires v1.4.0+
  *  Reference a prefix (single-usage dictionary) to decompress next frame.
  *  This is the reverse operation of ZSTD_CCtx_refPrefix(),
  *  and must use the same prefix as the one used during compression.
@@ -1024,7 +1041,7 @@ ZSTDLIB_API size_t ZSTD_DCtx_refPrefix(ZSTD_DCtx* dctx,
 
 /* ===   Memory management   === */
 
-/*! ZSTD_sizeof_*() :
+/*! ZSTD_sizeof_*() : Requires v1.4.0+
  *  These functions give the _current_ memory usage of selected object.
  *  Note that object memory usage can evolve (increase or decrease) over time. */
 ZSTDLIB_API size_t ZSTD_sizeof_CCtx(const ZSTD_CCtx* cctx);
@@ -1049,6 +1066,29 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict);
 #if !defined(ZSTD_H_ZSTD_STATIC_LINKING_ONLY)
 #define ZSTD_H_ZSTD_STATIC_LINKING_ONLY
 
+/* This can be overridden externally to hide static symbols. */
+#ifndef ZSTDLIB_STATIC_API
+#define ZSTDLIB_STATIC_API ZSTDLIB_VISIBLE
+#endif
+
+/* Deprecation warnings :
+ * Should these warnings be a problem, it is generally possible to disable them,
+ * typically with -Wno-deprecated-declarations for gcc or _CRT_SECURE_NO_WARNINGS in Visual.
+ * Otherwise, it's also possible to define ZSTD_DISABLE_DEPRECATE_WARNINGS.
+ */
+#ifdef ZSTD_DISABLE_DEPRECATE_WARNINGS
+#  define ZSTD_DEPRECATED(message) ZSTDLIB_STATIC_API  /* disable deprecation warnings */
+#else
+#  if (defined(GNUC) && (GNUC > 4 || (GNUC == 4 && GNUC_MINOR >= 5))) || defined(__clang__)
+#    define ZSTD_DEPRECATED(message) ZSTDLIB_STATIC_API __attribute__((deprecated(message)))
+#  elif (__GNUC__ >= 3)
+#    define ZSTD_DEPRECATED(message) ZSTDLIB_STATIC_API __attribute__((deprecated))
+#  else
+#    pragma message("WARNING: You need to implement ZSTD_DEPRECATED for this compiler")
+#    define ZSTD_DEPRECATED(message) ZSTDLIB_STATIC_API
+#  endif
+#endif /* ZSTD_DISABLE_DEPRECATE_WARNINGS */
+
 /* **************************************************************************************
  *   experimental API (static linking only)
  ****************************************************************************************
@@ -1111,9 +1151,6 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict);
 #define ZSTD_SRCSIZEHINT_MIN        0
 #define ZSTD_SRCSIZEHINT_MAX        INT_MAX
 
-/* internal */
-#define ZSTD_HASHLOG3_MAX           17
-
 
 /* ---  Advanced types  --- */
 
@@ -1255,6 +1292,15 @@ typedef enum {
   ZSTD_lcm_uncompressed = 2   /*< Always emit uncompressed literals. */
 } ZSTD_literalCompressionMode_e;
 
+typedef enum {
+  /* Note: This enum controls features which are conditionally beneficial. Zstd typically will make a final
+   * decision on whether or not to enable the feature (ZSTD_ps_auto), but setting the switch to ZSTD_ps_enable
+   * or ZSTD_ps_disable allow for a force enable/disable the feature.
+   */
+  ZSTD_ps_auto = 0,         /* Let the library automatically determine whether the feature shall be enabled */
+  ZSTD_ps_enable = 1,       /* Force-enable the feature */
+  ZSTD_ps_disable = 2       /* Do not use the feature */
+} ZSTD_paramSwitch_e;
 
 /* *************************************
 *  Frame size functions
@@ -1281,7 +1327,7 @@ typedef enum {
  *   note 5 : ZSTD_findDecompressedSize handles multiple frames, and so it must traverse the input to
  *            read each contained frame header.  This is fast as most of the data is skipped,
  *            however it does mean that all frame data must be present and valid. */
-ZSTDLIB_API unsigned long long ZSTD_findDecompressedSize(const void* src, size_t srcSize);
+ZSTDLIB_STATIC_API unsigned long long ZSTD_findDecompressedSize(const void* src, size_t srcSize);
 
 /*! ZSTD_decompressBound() :
  *  `src` should point to the start of a series of ZSTD encoded and/or skippable frames
@@ -1296,13 +1342,13 @@ ZSTDLIB_API unsigned long long ZSTD_findDecompressedSize(const void* src, size_t
  *  note 3  : when the decompressed size field isn't available, the upper-bound for that frame is calculated by:
  *              upper-bound = # blocks * min(128 KB, Window_Size)
  */
-ZSTDLIB_API unsigned long long ZSTD_decompressBound(const void* src, size_t srcSize);
+ZSTDLIB_STATIC_API unsigned long long ZSTD_decompressBound(const void* src, size_t srcSize);
 
 /*! ZSTD_frameHeaderSize() :
  *  srcSize must be >= ZSTD_FRAMEHEADERSIZE_PREFIX.
  * @return : size of the Frame Header,
  *           or an error code (if srcSize is too small) */
-ZSTDLIB_API size_t ZSTD_frameHeaderSize(const void* src, size_t srcSize);
+ZSTDLIB_STATIC_API size_t ZSTD_frameHeaderSize(const void* src, size_t srcSize);
 
 typedef enum {
   ZSTD_sf_noBlockDelimiters = 0,         /* Representation of ZSTD_Sequence has no block delimiters, sequences only */
@@ -1325,12 +1371,12 @@ typedef enum {
  * @return : number of sequences generated
  */
 
-ZSTDLIB_API size_t ZSTD_generateSequences(ZSTD_CCtx* zc, ZSTD_Sequence* outSeqs,
+ZSTDLIB_STATIC_API size_t ZSTD_generateSequences(ZSTD_CCtx* zc, ZSTD_Sequence* outSeqs,
                                           size_t outSeqsSize, const void* src, size_t srcSize);
 
 /*! ZSTD_mergeBlockDelimiters() :
  * Given an array of ZSTD_Sequence, remove all sequences that represent block delimiters/last literals
- * by merging them into into the literals of the next sequence.
+ * by merging them into the literals of the next sequence.
  *
  * As such, the final generated result has no explicit representation of block boundaries,
  * and the final last literals segment is not represented in the sequences.
@@ -1339,7 +1385,7 @@ ZSTDLIB_API size_t ZSTD_generateSequences(ZSTD_CCtx* zc, ZSTD_Sequence* outSeqs,
  * setting of ZSTD_c_blockDelimiters as ZSTD_sf_noBlockDelimiters
  * @return : number of sequences left after merging
  */
-ZSTDLIB_API size_t ZSTD_mergeBlockDelimiters(ZSTD_Sequence* sequences, size_t seqsSize);
+ZSTDLIB_STATIC_API size_t ZSTD_mergeBlockDelimiters(ZSTD_Sequence* sequences, size_t seqsSize);
 
 /*! ZSTD_compressSequences() :
  * Compress an array of ZSTD_Sequence, generated from the original source buffer, into dst.
@@ -1369,7 +1415,7 @@ ZSTDLIB_API size_t ZSTD_mergeBlockDelimiters(ZSTD_Sequence* sequences, size_t se
  *         and cannot emit an RLE block that disagrees with the repcode history
  * @return : final compressed size or a ZSTD error.
  */
-ZSTDLIB_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* dst, size_t dstSize,
+ZSTDLIB_STATIC_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* dst, size_t dstSize,
                                   const ZSTD_Sequence* inSeqs, size_t inSeqsSize,
                                   const void* src, size_t srcSize);
 
@@ -1377,7 +1423,7 @@ ZSTDLIB_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* dst, size
 /*! ZSTD_writeSkippableFrame() :
  * Generates a zstd skippable frame containing data given by src, and writes it to dst buffer.
  *
- * Skippable frames begin with a a 4-byte magic number. There are 16 possible choices of magic number,
+ * Skippable frames begin with a 4-byte magic number. There are 16 possible choices of magic number,
  * ranging from ZSTD_MAGIC_SKIPPABLE_START to ZSTD_MAGIC_SKIPPABLE_START+15.
  * As such, the parameter magicVariant controls the exact skippable frame magic number variant used, so
  * the magic number used will be ZSTD_MAGIC_SKIPPABLE_START + magicVariant.
@@ -1387,9 +1433,29 @@ ZSTDLIB_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* dst, size
  *
  * @return : number of bytes written or a ZSTD error.
  */
-ZSTDLIB_API size_t ZSTD_writeSkippableFrame(void* dst, size_t dstCapacity,
+ZSTDLIB_STATIC_API size_t ZSTD_writeSkippableFrame(void* dst, size_t dstCapacity,
                                             const void* src, size_t srcSize, unsigned magicVariant);
 
+/*! ZSTD_readSkippableFrame() :
+ * Retrieves a zstd skippable frame containing data given by src, and writes it to dst buffer.
+ *
+ * The parameter magicVariant will receive the magicVariant that was supplied when the frame was written,
+ * i.e. magicNumber - ZSTD_MAGIC_SKIPPABLE_START.  This can be NULL if the caller is not interested
+ * in the magicVariant.
+ *
+ * Returns an error if destination buffer is not large enough, or if the frame is not skippable.
+ *
+ * @return : number of bytes written or a ZSTD error.
+ */
+ZSTDLIB_API size_t ZSTD_readSkippableFrame(void* dst, size_t dstCapacity, unsigned* magicVariant,
+                                            const void* src, size_t srcSize);
+
+/*! ZSTD_isSkippableFrame() :
+ *  Tells if the content of `buffer` starts with a valid Frame Identifier for a skippable frame.
+ */
+ZSTDLIB_API unsigned ZSTD_isSkippableFrame(const void* buffer, size_t size);
+
+
 
 /* *************************************
 *  Memory management
@@ -1418,10 +1484,10 @@ ZSTDLIB_API size_t ZSTD_writeSkippableFrame(void* dst, size_t dstCapacity,
  *  Note 2 : only single-threaded compression is supported.
  *  ZSTD_estimateCCtxSize_usingCCtxParams() will return an error code if ZSTD_c_nbWorkers is >= 1.
  */
-ZSTDLIB_API size_t ZSTD_estimateCCtxSize(int compressionLevel);
-ZSTDLIB_API size_t ZSTD_estimateCCtxSize_usingCParams(ZSTD_compressionParameters cParams);
-ZSTDLIB_API size_t ZSTD_estimateCCtxSize_usingCCtxParams(const ZSTD_CCtx_params* params);
-ZSTDLIB_API size_t ZSTD_estimateDCtxSize(void);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCCtxSize(int compressionLevel);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCCtxSize_usingCParams(ZSTD_compressionParameters cParams);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCCtxSize_usingCCtxParams(const ZSTD_CCtx_params* params);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateDCtxSize(void);
 
 /*! ZSTD_estimateCStreamSize() :
  *  ZSTD_estimateCStreamSize() will provide a budget large enough for any compression level up to selected one.
@@ -1436,20 +1502,20 @@ ZSTDLIB_API size_t ZSTD_estimateDCtxSize(void);
  *  Note : if streaming is init with function ZSTD_init?Stream_usingDict(),
  *         an internal ?Dict will be created, which additional size is not estimated here.
  *         In this case, get total size by adding ZSTD_estimate?DictSize */
-ZSTDLIB_API size_t ZSTD_estimateCStreamSize(int compressionLevel);
-ZSTDLIB_API size_t ZSTD_estimateCStreamSize_usingCParams(ZSTD_compressionParameters cParams);
-ZSTDLIB_API size_t ZSTD_estimateCStreamSize_usingCCtxParams(const ZSTD_CCtx_params* params);
-ZSTDLIB_API size_t ZSTD_estimateDStreamSize(size_t windowSize);
-ZSTDLIB_API size_t ZSTD_estimateDStreamSize_fromFrame(const void* src, size_t srcSize);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCStreamSize(int compressionLevel);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCStreamSize_usingCParams(ZSTD_compressionParameters cParams);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCStreamSize_usingCCtxParams(const ZSTD_CCtx_params* params);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateDStreamSize(size_t windowSize);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateDStreamSize_fromFrame(const void* src, size_t srcSize);
 
 /*! ZSTD_estimate?DictSize() :
  *  ZSTD_estimateCDictSize() will bet that src size is relatively "small", and content is copied, like ZSTD_createCDict().
  *  ZSTD_estimateCDictSize_advanced() makes it possible to control compression parameters precisely, like ZSTD_createCDict_advanced().
  *  Note : dictionaries created by reference (`ZSTD_dlm_byRef`) are logically smaller.
  */
-ZSTDLIB_API size_t ZSTD_estimateCDictSize(size_t dictSize, int compressionLevel);
-ZSTDLIB_API size_t ZSTD_estimateCDictSize_advanced(size_t dictSize, ZSTD_compressionParameters cParams, ZSTD_dictLoadMethod_e dictLoadMethod);
-ZSTDLIB_API size_t ZSTD_estimateDDictSize(size_t dictSize, ZSTD_dictLoadMethod_e dictLoadMethod);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCDictSize(size_t dictSize, int compressionLevel);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateCDictSize_advanced(size_t dictSize, ZSTD_compressionParameters cParams, ZSTD_dictLoadMethod_e dictLoadMethod);
+ZSTDLIB_STATIC_API size_t ZSTD_estimateDDictSize(size_t dictSize, ZSTD_dictLoadMethod_e dictLoadMethod);
 
 /*! ZSTD_initStatic*() :
  *  Initialize an object using a pre-allocated fixed-size buffer.
@@ -1472,20 +1538,20 @@ ZSTDLIB_API size_t ZSTD_estimateDDictSize(size_t dictSize, ZSTD_dictLoadMethod_e
  *  Limitation 2 : static cctx currently not compatible with multi-threading.
  *  Limitation 3 : static dctx is incompatible with legacy support.
  */
-ZSTDLIB_API ZSTD_CCtx*    ZSTD_initStaticCCtx(void* workspace, size_t workspaceSize);
-ZSTDLIB_API ZSTD_CStream* ZSTD_initStaticCStream(void* workspace, size_t workspaceSize);    /*< same as ZSTD_initStaticCCtx() */
+ZSTDLIB_STATIC_API ZSTD_CCtx*    ZSTD_initStaticCCtx(void* workspace, size_t workspaceSize);
+ZSTDLIB_STATIC_API ZSTD_CStream* ZSTD_initStaticCStream(void* workspace, size_t workspaceSize);    /*< same as ZSTD_initStaticCCtx() */
 
-ZSTDLIB_API ZSTD_DCtx*    ZSTD_initStaticDCtx(void* workspace, size_t workspaceSize);
-ZSTDLIB_API ZSTD_DStream* ZSTD_initStaticDStream(void* workspace, size_t workspaceSize);    /*< same as ZSTD_initStaticDCtx() */
+ZSTDLIB_STATIC_API ZSTD_DCtx*    ZSTD_initStaticDCtx(void* workspace, size_t workspaceSize);
+ZSTDLIB_STATIC_API ZSTD_DStream* ZSTD_initStaticDStream(void* workspace, size_t workspaceSize);    /*< same as ZSTD_initStaticDCtx() */
 
-ZSTDLIB_API const ZSTD_CDict* ZSTD_initStaticCDict(
+ZSTDLIB_STATIC_API const ZSTD_CDict* ZSTD_initStaticCDict(
                                         void* workspace, size_t workspaceSize,
                                         const void* dict, size_t dictSize,
                                         ZSTD_dictLoadMethod_e dictLoadMethod,
                                         ZSTD_dictContentType_e dictContentType,
                                         ZSTD_compressionParameters cParams);
 
-ZSTDLIB_API const ZSTD_DDict* ZSTD_initStaticDDict(
+ZSTDLIB_STATIC_API const ZSTD_DDict* ZSTD_initStaticDDict(
                                         void* workspace, size_t workspaceSize,
                                         const void* dict, size_t dictSize,
                                         ZSTD_dictLoadMethod_e dictLoadMethod,
@@ -1504,44 +1570,44 @@ static
 __attribute__((__unused__))
 ZSTD_customMem const ZSTD_defaultCMem = { NULL, NULL, NULL };  /*< this constant defers to stdlib's functions */
 
-ZSTDLIB_API ZSTD_CCtx*    ZSTD_createCCtx_advanced(ZSTD_customMem customMem);
-ZSTDLIB_API ZSTD_CStream* ZSTD_createCStream_advanced(ZSTD_customMem customMem);
-ZSTDLIB_API ZSTD_DCtx*    ZSTD_createDCtx_advanced(ZSTD_customMem customMem);
-ZSTDLIB_API ZSTD_DStream* ZSTD_createDStream_advanced(ZSTD_customMem customMem);
+ZSTDLIB_STATIC_API ZSTD_CCtx*    ZSTD_createCCtx_advanced(ZSTD_customMem customMem);
+ZSTDLIB_STATIC_API ZSTD_CStream* ZSTD_createCStream_advanced(ZSTD_customMem customMem);
+ZSTDLIB_STATIC_API ZSTD_DCtx*    ZSTD_createDCtx_advanced(ZSTD_customMem customMem);
+ZSTDLIB_STATIC_API ZSTD_DStream* ZSTD_createDStream_advanced(ZSTD_customMem customMem);
 
-ZSTDLIB_API ZSTD_CDict* ZSTD_createCDict_advanced(const void* dict, size_t dictSize,
+ZSTDLIB_STATIC_API ZSTD_CDict* ZSTD_createCDict_advanced(const void* dict, size_t dictSize,
                                                   ZSTD_dictLoadMethod_e dictLoadMethod,
                                                   ZSTD_dictContentType_e dictContentType,
                                                   ZSTD_compressionParameters cParams,
                                                   ZSTD_customMem customMem);
 
-/* ! Thread pool :
- * These prototypes make it possible to share a thread pool among multiple compression contexts.
- * This can limit resources for applications with multiple threads where each one uses
- * a threaded compression mode (via ZSTD_c_nbWorkers parameter).
- * ZSTD_createThreadPool creates a new thread pool with a given number of threads.
- * Note that the lifetime of such pool must exist while being used.
- * ZSTD_CCtx_refThreadPool assigns a thread pool to a context (use NULL argument value
- * to use an internal thread pool).
- * ZSTD_freeThreadPool frees a thread pool, accepts NULL pointer.
+/*! Thread pool :
+ *  These prototypes make it possible to share a thread pool among multiple compression contexts.
+ *  This can limit resources for applications with multiple threads where each one uses
+ *  a threaded compression mode (via ZSTD_c_nbWorkers parameter).
+ *  ZSTD_createThreadPool creates a new thread pool with a given number of threads.
+ *  Note that the lifetime of such pool must exist while being used.
+ *  ZSTD_CCtx_refThreadPool assigns a thread pool to a context (use NULL argument value
+ *  to use an internal thread pool).
+ *  ZSTD_freeThreadPool frees a thread pool, accepts NULL pointer.
  */
 typedef struct POOL_ctx_s ZSTD_threadPool;
-ZSTDLIB_API ZSTD_threadPool* ZSTD_createThreadPool(size_t numThreads);
-ZSTDLIB_API void ZSTD_freeThreadPool (ZSTD_threadPool* pool);  /* accept NULL pointer */
-ZSTDLIB_API size_t ZSTD_CCtx_refThreadPool(ZSTD_CCtx* cctx, ZSTD_threadPool* pool);
+ZSTDLIB_STATIC_API ZSTD_threadPool* ZSTD_createThreadPool(size_t numThreads);
+ZSTDLIB_STATIC_API void ZSTD_freeThreadPool (ZSTD_threadPool* pool);  /* accept NULL pointer */
+ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refThreadPool(ZSTD_CCtx* cctx, ZSTD_threadPool* pool);
 
 
 /*
  * This API is temporary and is expected to change or disappear in the future!
  */
-ZSTDLIB_API ZSTD_CDict* ZSTD_createCDict_advanced2(
+ZSTDLIB_STATIC_API ZSTD_CDict* ZSTD_createCDict_advanced2(
     const void* dict, size_t dictSize,
     ZSTD_dictLoadMethod_e dictLoadMethod,
     ZSTD_dictContentType_e dictContentType,
     const ZSTD_CCtx_params* cctxParams,
     ZSTD_customMem customMem);
 
-ZSTDLIB_API ZSTD_DDict* ZSTD_createDDict_advanced(
+ZSTDLIB_STATIC_API ZSTD_DDict* ZSTD_createDDict_advanced(
     const void* dict, size_t dictSize,
     ZSTD_dictLoadMethod_e dictLoadMethod,
     ZSTD_dictContentType_e dictContentType,
@@ -1558,28 +1624,22 @@ ZSTDLIB_API ZSTD_DDict* ZSTD_createDDict_advanced(
  *  As a consequence, `dictBuffer` **must** outlive CDict,
  *  and its content must remain unmodified throughout the lifetime of CDict.
  *  note: equivalent to ZSTD_createCDict_advanced(), with dictLoadMethod==ZSTD_dlm_byRef */
-ZSTDLIB_API ZSTD_CDict* ZSTD_createCDict_byReference(const void* dictBuffer, size_t dictSize, int compressionLevel);
-
-/*! ZSTD_getDictID_fromCDict() :
- *  Provides the dictID of the dictionary loaded into `cdict`.
- *  If @return == 0, the dictionary is not conformant to Zstandard specification, or empty.
- *  Non-conformant dictionaries can still be loaded, but as content-only dictionaries. */
-ZSTDLIB_API unsigned ZSTD_getDictID_fromCDict(const ZSTD_CDict* cdict);
+ZSTDLIB_STATIC_API ZSTD_CDict* ZSTD_createCDict_byReference(const void* dictBuffer, size_t dictSize, int compressionLevel);
 
 /*! ZSTD_getCParams() :
  * @return ZSTD_compressionParameters structure for a selected compression level and estimated srcSize.
  * `estimatedSrcSize` value is optional, select 0 if not known */
-ZSTDLIB_API ZSTD_compressionParameters ZSTD_getCParams(int compressionLevel, unsigned long long estimatedSrcSize, size_t dictSize);
+ZSTDLIB_STATIC_API ZSTD_compressionParameters ZSTD_getCParams(int compressionLevel, unsigned long long estimatedSrcSize, size_t dictSize);
 
 /*! ZSTD_getParams() :
  *  same as ZSTD_getCParams(), but @return a full `ZSTD_parameters` object instead of sub-component `ZSTD_compressionParameters`.
  *  All fields of `ZSTD_frameParameters` are set to default : contentSize=1, checksum=0, noDictID=0 */
-ZSTDLIB_API ZSTD_parameters ZSTD_getParams(int compressionLevel, unsigned long long estimatedSrcSize, size_t dictSize);
+ZSTDLIB_STATIC_API ZSTD_parameters ZSTD_getParams(int compressionLevel, unsigned long long estimatedSrcSize, size_t dictSize);
 
 /*! ZSTD_checkCParams() :
  *  Ensure param values remain within authorized range.
  * @return 0 on success, or an error code (can be checked with ZSTD_isError()) */
-ZSTDLIB_API size_t ZSTD_checkCParams(ZSTD_compressionParameters params);
+ZSTDLIB_STATIC_API size_t ZSTD_checkCParams(ZSTD_compressionParameters params);
 
 /*! ZSTD_adjustCParams() :
  *  optimize params for a given `srcSize` and `dictSize`.
@@ -1587,23 +1647,25 @@ ZSTDLIB_API size_t ZSTD_checkCParams(ZSTD_compressionParameters params);
  * `dictSize` must be `0` when there is no dictionary.
  *  cPar can be invalid : all parameters will be clamped within valid range in the @return struct.
  *  This function never fails (wide contract) */
-ZSTDLIB_API ZSTD_compressionParameters ZSTD_adjustCParams(ZSTD_compressionParameters cPar, unsigned long long srcSize, size_t dictSize);
+ZSTDLIB_STATIC_API ZSTD_compressionParameters ZSTD_adjustCParams(ZSTD_compressionParameters cPar, unsigned long long srcSize, size_t dictSize);
 
 /*! ZSTD_compress_advanced() :
  *  Note : this function is now DEPRECATED.
  *         It can be replaced by ZSTD_compress2(), in combination with ZSTD_CCtx_setParameter() and other parameter setters.
- *  This prototype will be marked as deprecated and generate compilation warning on reaching v1.5.x */
-ZSTDLIB_API size_t ZSTD_compress_advanced(ZSTD_CCtx* cctx,
+ *  This prototype will generate compilation warnings. */
+ZSTD_DEPRECATED("use ZSTD_compress2")
+size_t ZSTD_compress_advanced(ZSTD_CCtx* cctx,
                                           void* dst, size_t dstCapacity,
                                     const void* src, size_t srcSize,
                                     const void* dict,size_t dictSize,
                                           ZSTD_parameters params);
 
 /*! ZSTD_compress_usingCDict_advanced() :
- *  Note : this function is now REDUNDANT.
+ *  Note : this function is now DEPRECATED.
  *         It can be replaced by ZSTD_compress2(), in combination with ZSTD_CCtx_loadDictionary() and other parameter setters.
- *  This prototype will be marked as deprecated and generate compilation warning in some future version */
-ZSTDLIB_API size_t ZSTD_compress_usingCDict_advanced(ZSTD_CCtx* cctx,
+ *  This prototype will generate compilation warnings. */
+ZSTD_DEPRECATED("use ZSTD_compress2 with ZSTD_CCtx_loadDictionary")
+size_t ZSTD_compress_usingCDict_advanced(ZSTD_CCtx* cctx,
                                               void* dst, size_t dstCapacity,
                                         const void* src, size_t srcSize,
                                         const ZSTD_CDict* cdict,
@@ -1613,18 +1675,18 @@ ZSTDLIB_API size_t ZSTD_compress_usingCDict_advanced(ZSTD_CCtx* cctx,
 /*! ZSTD_CCtx_loadDictionary_byReference() :
  *  Same as ZSTD_CCtx_loadDictionary(), but dictionary content is referenced, instead of being copied into CCtx.
  *  It saves some memory, but also requires that `dict` outlives its usage within `cctx` */
-ZSTDLIB_API size_t ZSTD_CCtx_loadDictionary_byReference(ZSTD_CCtx* cctx, const void* dict, size_t dictSize);
+ZSTDLIB_STATIC_API size_t ZSTD_CCtx_loadDictionary_byReference(ZSTD_CCtx* cctx, const void* dict, size_t dictSize);
 
 /*! ZSTD_CCtx_loadDictionary_advanced() :
  *  Same as ZSTD_CCtx_loadDictionary(), but gives finer control over
  *  how to load the dictionary (by copy ? by reference ?)
  *  and how to interpret it (automatic ? force raw mode ? full mode only ?) */
-ZSTDLIB_API size_t ZSTD_CCtx_loadDictionary_advanced(ZSTD_CCtx* cctx, const void* dict, size_t dictSize, ZSTD_dictLoadMethod_e dictLoadMethod, ZSTD_dictContentType_e dictContentType);
+ZSTDLIB_STATIC_API size_t ZSTD_CCtx_loadDictionary_advanced(ZSTD_CCtx* cctx, const void* dict, size_t dictSize, ZSTD_dictLoadMethod_e dictLoadMethod, ZSTD_dictContentType_e dictContentType);
 
 /*! ZSTD_CCtx_refPrefix_advanced() :
  *  Same as ZSTD_CCtx_refPrefix(), but gives finer control over
  *  how to interpret prefix content (automatic ? force raw mode (default) ? full mode only ?) */
-ZSTDLIB_API size_t ZSTD_CCtx_refPrefix_advanced(ZSTD_CCtx* cctx, const void* prefix, size_t prefixSize, ZSTD_dictContentType_e dictContentType);
+ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refPrefix_advanced(ZSTD_CCtx* cctx, const void* prefix, size_t prefixSize, ZSTD_dictContentType_e dictContentType);
 
 /* ===   experimental parameters   === */
 /* these parameters can be used with ZSTD_setParameter()
@@ -1663,9 +1725,15 @@ ZSTDLIB_API size_t ZSTD_CCtx_refPrefix_advanced(ZSTD_CCtx* cctx, const void* pre
  * See the comments on that enum for an explanation of the feature. */
 #define ZSTD_c_forceAttachDict ZSTD_c_experimentalParam4
 
-/* Controls how the literals are compressed (default is auto).
- * The value must be of type ZSTD_literalCompressionMode_e.
- * See ZSTD_literalCompressionMode_t enum definition for details.
+/* Controlled with ZSTD_paramSwitch_e enum.
+ * Default is ZSTD_ps_auto.
+ * Set to ZSTD_ps_disable to never compress literals.
+ * Set to ZSTD_ps_enable to always compress literals. (Note: uncompressed literals
+ * may still be emitted if huffman is not beneficial to use.)
+ *
+ * By default, in ZSTD_ps_auto, the library will decide at runtime whether to use
+ * literals compression based on the compression parameters - specifically,
+ * negative compression levels do not use literal compression.
  */
 #define ZSTD_c_literalCompressionMode ZSTD_c_experimentalParam5
 
@@ -1728,7 +1796,7 @@ ZSTDLIB_API size_t ZSTD_CCtx_refPrefix_advanced(ZSTD_CCtx* cctx, const void* pre
  *
  * Note that this means that the CDict tables can no longer be copied into the
  * CCtx, so the dict attachment mode ZSTD_dictForceCopy will no longer be
- * useable. The dictionary can only be attached or reloaded.
+ * usable. The dictionary can only be attached or reloaded.
  *
  * In general, you should expect compression to be faster--sometimes very much
  * so--and CDict creation to be slightly slower. Eventually, we will probably
@@ -1817,12 +1885,55 @@ ZSTDLIB_API size_t ZSTD_CCtx_refPrefix_advanced(ZSTD_CCtx* cctx, const void* pre
  */
 #define ZSTD_c_validateSequences ZSTD_c_experimentalParam12
 
+/* ZSTD_c_useBlockSplitter
+ * Controlled with ZSTD_paramSwitch_e enum.
+ * Default is ZSTD_ps_auto.
+ * Set to ZSTD_ps_disable to never use block splitter.
+ * Set to ZSTD_ps_enable to always use block splitter.
+ *
+ * By default, in ZSTD_ps_auto, the library will decide at runtime whether to use
+ * block splitting based on the compression parameters.
+ */
+#define ZSTD_c_useBlockSplitter ZSTD_c_experimentalParam13
+
+/* ZSTD_c_useRowMatchFinder
+ * Controlled with ZSTD_paramSwitch_e enum.
+ * Default is ZSTD_ps_auto.
+ * Set to ZSTD_ps_disable to never use row-based matchfinder.
+ * Set to ZSTD_ps_enable to force usage of row-based matchfinder.
+ *
+ * By default, in ZSTD_ps_auto, the library will decide at runtime whether to use
+ * the row-based matchfinder based on support for SIMD instructions and the window log.
+ * Note that this only pertains to compression strategies: greedy, lazy, and lazy2
+ */
+#define ZSTD_c_useRowMatchFinder ZSTD_c_experimentalParam14
+
+/* ZSTD_c_deterministicRefPrefix
+ * Default is 0 == disabled. Set to 1 to enable.
+ *
+ * Zstd produces different results for prefix compression when the prefix is
+ * directly adjacent to the data about to be compressed vs. when it isn't.
+ * This is because zstd detects that the two buffers are contiguous and it can
+ * use a more efficient match finding algorithm. However, this produces different
+ * results than when the two buffers are non-contiguous. This flag forces zstd
+ * to always load the prefix in non-contiguous mode, even if it happens to be
+ * adjacent to the data, to guarantee determinism.
+ *
+ * If you really care about determinism when using a dictionary or prefix,
+ * like when doing delta compression, you should select this option. It comes
+ * at a speed penalty of about ~2.5% if the dictionary and data happened to be
+ * contiguous, and is free if they weren't contiguous. We don't expect that
+ * intentionally making the dictionary and data contiguous will be worth the
+ * cost to memcpy() the data.
+ */
+#define ZSTD_c_deterministicRefPrefix ZSTD_c_experimentalParam15
+
 /*! ZSTD_CCtx_getParameter() :
  *  Get the requested compression parameter value, selected by enum ZSTD_cParameter,
  *  and store it into int* value.
  * @return : 0, or an error code (which can be tested with ZSTD_isError()).
  */
-ZSTDLIB_API size_t ZSTD_CCtx_getParameter(const ZSTD_CCtx* cctx, ZSTD_cParameter param, int* value);
+ZSTDLIB_STATIC_API size_t ZSTD_CCtx_getParameter(const ZSTD_CCtx* cctx, ZSTD_cParameter param, int* value);
 
 
 /*! ZSTD_CCtx_params :
@@ -1842,27 +1953,27 @@ ZSTDLIB_API size_t ZSTD_CCtx_getParameter(const ZSTD_CCtx* cctx, ZSTD_cParameter
  *  This can be used with ZSTD_estimateCCtxSize_advanced_usingCCtxParams()
  *  for static allocation of CCtx for single-threaded compression.
  */
-ZSTDLIB_API ZSTD_CCtx_params* ZSTD_createCCtxParams(void);
-ZSTDLIB_API size_t ZSTD_freeCCtxParams(ZSTD_CCtx_params* params);  /* accept NULL pointer */
+ZSTDLIB_STATIC_API ZSTD_CCtx_params* ZSTD_createCCtxParams(void);
+ZSTDLIB_STATIC_API size_t ZSTD_freeCCtxParams(ZSTD_CCtx_params* params);  /* accept NULL pointer */
 
 /*! ZSTD_CCtxParams_reset() :
  *  Reset params to default values.
  */
-ZSTDLIB_API size_t ZSTD_CCtxParams_reset(ZSTD_CCtx_params* params);
+ZSTDLIB_STATIC_API size_t ZSTD_CCtxParams_reset(ZSTD_CCtx_params* params);
 
 /*! ZSTD_CCtxParams_init() :
  *  Initializes the compression parameters of cctxParams according to
  *  compression level. All other parameters are reset to their default values.
  */
-ZSTDLIB_API size_t ZSTD_CCtxParams_init(ZSTD_CCtx_params* cctxParams, int compressionLevel);
+ZSTDLIB_STATIC_API size_t ZSTD_CCtxParams_init(ZSTD_CCtx_params* cctxParams, int compressionLevel);
 
 /*! ZSTD_CCtxParams_init_advanced() :
  *  Initializes the compression and frame parameters of cctxParams according to
  *  params. All other parameters are reset to their default values.
  */
-ZSTDLIB_API size_t ZSTD_CCtxParams_init_advanced(ZSTD_CCtx_params* cctxParams, ZSTD_parameters params);
+ZSTDLIB_STATIC_API size_t ZSTD_CCtxParams_init_advanced(ZSTD_CCtx_params* cctxParams, ZSTD_parameters params);
 
-/*! ZSTD_CCtxParams_setParameter() :
+/*! ZSTD_CCtxParams_setParameter() : Requires v1.4.0+
  *  Similar to ZSTD_CCtx_setParameter.
  *  Set one compression parameter, selected by enum ZSTD_cParameter.
  *  Parameters must be applied to a ZSTD_CCtx using
@@ -1870,14 +1981,14 @@ ZSTDLIB_API size_t ZSTD_CCtxParams_init_advanced(ZSTD_CCtx_params* cctxParams, Z
  * @result : a code representing success or failure (which can be tested with
  *           ZSTD_isError()).
  */
-ZSTDLIB_API size_t ZSTD_CCtxParams_setParameter(ZSTD_CCtx_params* params, ZSTD_cParameter param, int value);
+ZSTDLIB_STATIC_API size_t ZSTD_CCtxParams_setParameter(ZSTD_CCtx_params* params, ZSTD_cParameter param, int value);
 
 /*! ZSTD_CCtxParams_getParameter() :
  * Similar to ZSTD_CCtx_getParameter.
  * Get the requested value of one compression parameter, selected by enum ZSTD_cParameter.
  * @result : 0, or an error code (which can be tested with ZSTD_isError()).
  */
-ZSTDLIB_API size_t ZSTD_CCtxParams_getParameter(const ZSTD_CCtx_params* params, ZSTD_cParameter param, int* value);
+ZSTDLIB_STATIC_API size_t ZSTD_CCtxParams_getParameter(const ZSTD_CCtx_params* params, ZSTD_cParameter param, int* value);
 
 /*! ZSTD_CCtx_setParametersUsingCCtxParams() :
  *  Apply a set of ZSTD_CCtx_params to the compression context.
@@ -1886,7 +1997,7 @@ ZSTDLIB_API size_t ZSTD_CCtxParams_getParameter(const ZSTD_CCtx_params* params,
  *    if nbWorkers>=1, new parameters will be picked up at next job,
  *       with a few restrictions (windowLog, pledgedSrcSize, nbWorkers, jobSize, and overlapLog are not updated).
  */
-ZSTDLIB_API size_t ZSTD_CCtx_setParametersUsingCCtxParams(
+ZSTDLIB_STATIC_API size_t ZSTD_CCtx_setParametersUsingCCtxParams(
         ZSTD_CCtx* cctx, const ZSTD_CCtx_params* params);
 
 /*! ZSTD_compressStream2_simpleArgs() :
@@ -1895,7 +2006,7 @@ ZSTDLIB_API size_t ZSTD_CCtx_setParametersUsingCCtxParams(
  *  This variant might be helpful for binders from dynamic languages
  *  which have troubles handling structures containing memory pointers.
  */
-ZSTDLIB_API size_t ZSTD_compressStream2_simpleArgs (
+ZSTDLIB_STATIC_API size_t ZSTD_compressStream2_simpleArgs (
                             ZSTD_CCtx* cctx,
                             void* dst, size_t dstCapacity, size_t* dstPos,
                       const void* src, size_t srcSize, size_t* srcPos,
@@ -1911,33 +2022,33 @@ ZSTDLIB_API size_t ZSTD_compressStream2_simpleArgs (
  *  Note : Frame Identifier is 4 bytes. If `size < 4`, @return will always be 0.
  *  Note 2 : Legacy Frame Identifiers are considered valid only if Legacy Support is enabled.
  *  Note 3 : Skippable Frame Identifiers are considered valid. */
-ZSTDLIB_API unsigned ZSTD_isFrame(const void* buffer, size_t size);
+ZSTDLIB_STATIC_API unsigned ZSTD_isFrame(const void* buffer, size_t size);
 
 /*! ZSTD_createDDict_byReference() :
  *  Create a digested dictionary, ready to start decompression operation without startup delay.
  *  Dictionary content is referenced, and therefore stays in dictBuffer.
  *  It is important that dictBuffer outlives DDict,
  *  it must remain read accessible throughout the lifetime of DDict */
-ZSTDLIB_API ZSTD_DDict* ZSTD_createDDict_byReference(const void* dictBuffer, size_t dictSize);
+ZSTDLIB_STATIC_API ZSTD_DDict* ZSTD_createDDict_byReference(const void* dictBuffer, size_t dictSize);
 
 /*! ZSTD_DCtx_loadDictionary_byReference() :
  *  Same as ZSTD_DCtx_loadDictionary(),
  *  but references `dict` content instead of copying it into `dctx`.
  *  This saves memory if `dict` remains around.,
  *  However, it's imperative that `dict` remains accessible (and unmodified) while being used, so it must outlive decompression. */
-ZSTDLIB_API size_t ZSTD_DCtx_loadDictionary_byReference(ZSTD_DCtx* dctx, const void* dict, size_t dictSize);
+ZSTDLIB_STATIC_API size_t ZSTD_DCtx_loadDictionary_byReference(ZSTD_DCtx* dctx, const void* dict, size_t dictSize);
 
 /*! ZSTD_DCtx_loadDictionary_advanced() :
  *  Same as ZSTD_DCtx_loadDictionary(),
  *  but gives direct control over
  *  how to load the dictionary (by copy ? by reference ?)
  *  and how to interpret it (automatic ? force raw mode ? full mode only ?). */
-ZSTDLIB_API size_t ZSTD_DCtx_loadDictionary_advanced(ZSTD_DCtx* dctx, const void* dict, size_t dictSize, ZSTD_dictLoadMethod_e dictLoadMethod, ZSTD_dictContentType_e dictContentType);
+ZSTDLIB_STATIC_API size_t ZSTD_DCtx_loadDictionary_advanced(ZSTD_DCtx* dctx, const void* dict, size_t dictSize, ZSTD_dictLoadMethod_e dictLoadMethod, ZSTD_dictContentType_e dictContentType);
 
 /*! ZSTD_DCtx_refPrefix_advanced() :
  *  Same as ZSTD_DCtx_refPrefix(), but gives finer control over
  *  how to interpret prefix content (automatic ? force raw mode (default) ? full mode only ?) */
-ZSTDLIB_API size_t ZSTD_DCtx_refPrefix_advanced(ZSTD_DCtx* dctx, const void* prefix, size_t prefixSize, ZSTD_dictContentType_e dictContentType);
+ZSTDLIB_STATIC_API size_t ZSTD_DCtx_refPrefix_advanced(ZSTD_DCtx* dctx, const void* prefix, size_t prefixSize, ZSTD_dictContentType_e dictContentType);
 
 /*! ZSTD_DCtx_setMaxWindowSize() :
  *  Refuses allocating internal buffers for frames requiring a window size larger than provided limit.
@@ -1946,14 +2057,14 @@ ZSTDLIB_API size_t ZSTD_DCtx_refPrefix_advanced(ZSTD_DCtx* dctx, const void* pre
  *  By default, a decompression context accepts all window sizes <= (1 << ZSTD_WINDOWLOG_LIMIT_DEFAULT)
  * @return : 0, or an error code (which can be tested using ZSTD_isError()).
  */
-ZSTDLIB_API size_t ZSTD_DCtx_setMaxWindowSize(ZSTD_DCtx* dctx, size_t maxWindowSize);
+ZSTDLIB_STATIC_API size_t ZSTD_DCtx_setMaxWindowSize(ZSTD_DCtx* dctx, size_t maxWindowSize);
 
 /*! ZSTD_DCtx_getParameter() :
  *  Get the requested decompression parameter value, selected by enum ZSTD_dParameter,
  *  and store it into int* value.
  * @return : 0, or an error code (which can be tested with ZSTD_isError()).
  */
-ZSTDLIB_API size_t ZSTD_DCtx_getParameter(ZSTD_DCtx* dctx, ZSTD_dParameter param, int* value);
+ZSTDLIB_STATIC_API size_t ZSTD_DCtx_getParameter(ZSTD_DCtx* dctx, ZSTD_dParameter param, int* value);
 
 /* ZSTD_d_format
  * experimental parameter,
@@ -2028,11 +2139,13 @@ ZSTDLIB_API size_t ZSTD_DCtx_getParameter(ZSTD_DCtx* dctx, ZSTD_dParameter param
 
 
 /*! ZSTD_DCtx_setFormat() :
+ *  This function is REDUNDANT. Prefer ZSTD_DCtx_setParameter().
  *  Instruct the decoder context about what kind of data to decode next.
  *  This instruction is mandatory to decode data without a fully-formed header,
  *  such ZSTD_f_zstd1_magicless for example.
  * @return : 0, or an error code (which can be tested using ZSTD_isError()). */
-ZSTDLIB_API size_t ZSTD_DCtx_setFormat(ZSTD_DCtx* dctx, ZSTD_format_e format);
+ZSTD_DEPRECATED("use ZSTD_DCtx_setParameter() instead")
+size_t ZSTD_DCtx_setFormat(ZSTD_DCtx* dctx, ZSTD_format_e format);
 
 /*! ZSTD_decompressStream_simpleArgs() :
  *  Same as ZSTD_decompressStream(),
@@ -2040,7 +2153,7 @@ ZSTDLIB_API size_t ZSTD_DCtx_setFormat(ZSTD_DCtx* dctx, ZSTD_format_e format);
  *  This can be helpful for binders from dynamic languages
  *  which have troubles handling structures containing memory pointers.
  */
-ZSTDLIB_API size_t ZSTD_decompressStream_simpleArgs (
+ZSTDLIB_STATIC_API size_t ZSTD_decompressStream_simpleArgs (
                             ZSTD_DCtx* dctx,
                             void* dst, size_t dstCapacity, size_t* dstPos,
                       const void* src, size_t srcSize, size_t* srcPos);
@@ -2056,7 +2169,7 @@ ZSTDLIB_API size_t ZSTD_decompressStream_simpleArgs (
 /*=====   Advanced Streaming compression functions  =====*/
 
 /*! ZSTD_initCStream_srcSize() :
- * This function is deprecated, and equivalent to:
+ * This function is DEPRECATED, and equivalent to:
  *     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
  *     ZSTD_CCtx_refCDict(zcs, NULL); // clear the dictionary (if any)
  *     ZSTD_CCtx_setParameter(zcs, ZSTD_c_compressionLevel, compressionLevel);
@@ -2065,15 +2178,15 @@ ZSTDLIB_API size_t ZSTD_decompressStream_simpleArgs (
  * pledgedSrcSize must be correct. If it is not known at init time, use
  * ZSTD_CONTENTSIZE_UNKNOWN. Note that, for compatibility with older programs,
  * "0" also disables frame content size field. It may be enabled in the future.
- * Note : this prototype will be marked as deprecated and generate compilation warnings on reaching v1.5.x
+ * This prototype will generate compilation warnings.
  */
-ZSTDLIB_API size_t
-ZSTD_initCStream_srcSize(ZSTD_CStream* zcs,
+ZSTD_DEPRECATED("use ZSTD_CCtx_reset, see zstd.h for detailed instructions")
+size_t ZSTD_initCStream_srcSize(ZSTD_CStream* zcs,
                          int compressionLevel,
                          unsigned long long pledgedSrcSize);
 
 /*! ZSTD_initCStream_usingDict() :
- * This function is deprecated, and is equivalent to:
+ * This function is DEPRECATED, and is equivalent to:
  *     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
  *     ZSTD_CCtx_setParameter(zcs, ZSTD_c_compressionLevel, compressionLevel);
  *     ZSTD_CCtx_loadDictionary(zcs, dict, dictSize);
@@ -2082,15 +2195,15 @@ ZSTD_initCStream_srcSize(ZSTD_CStream* zcs,
  * dict == NULL or dictSize < 8, in which case no dict is used.
  * Note: dict is loaded with ZSTD_dct_auto (treated as a full zstd dictionary if
  * it begins with ZSTD_MAGIC_DICTIONARY, else as raw content) and ZSTD_dlm_byCopy.
- * Note : this prototype will be marked as deprecated and generate compilation warnings on reaching v1.5.x
+ * This prototype will generate compilation warnings.
  */
-ZSTDLIB_API size_t
-ZSTD_initCStream_usingDict(ZSTD_CStream* zcs,
+ZSTD_DEPRECATED("use ZSTD_CCtx_reset, see zstd.h for detailed instructions")
+size_t ZSTD_initCStream_usingDict(ZSTD_CStream* zcs,
                      const void* dict, size_t dictSize,
                            int compressionLevel);
 
 /*! ZSTD_initCStream_advanced() :
- * This function is deprecated, and is approximately equivalent to:
+ * This function is DEPRECATED, and is approximately equivalent to:
  *     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
  *     // Pseudocode: Set each zstd parameter and leave the rest as-is.
  *     for ((param, value) : params) {
@@ -2102,23 +2215,24 @@ ZSTD_initCStream_usingDict(ZSTD_CStream* zcs,
  * dict is loaded with ZSTD_dct_auto and ZSTD_dlm_byCopy.
  * pledgedSrcSize must be correct.
  * If srcSize is not known at init time, use value ZSTD_CONTENTSIZE_UNKNOWN.
- * Note : this prototype will be marked as deprecated and generate compilation warnings on reaching v1.5.x
+ * This prototype will generate compilation warnings.
  */
-ZSTDLIB_API size_t
-ZSTD_initCStream_advanced(ZSTD_CStream* zcs,
+ZSTD_DEPRECATED("use ZSTD_CCtx_reset, see zstd.h for detailed instructions")
+size_t ZSTD_initCStream_advanced(ZSTD_CStream* zcs,
                     const void* dict, size_t dictSize,
                           ZSTD_parameters params,
                           unsigned long long pledgedSrcSize);
 
 /*! ZSTD_initCStream_usingCDict() :
- * This function is deprecated, and equivalent to:
+ * This function is DEPRECATED, and equivalent to:
  *     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
  *     ZSTD_CCtx_refCDict(zcs, cdict);
  *
  * note : cdict will just be referenced, and must outlive compression session
- * Note : this prototype will be marked as deprecated and generate compilation warnings on reaching v1.5.x
+ * This prototype will generate compilation warnings.
  */
-ZSTDLIB_API size_t ZSTD_initCStream_usingCDict(ZSTD_CStream* zcs, const ZSTD_CDict* cdict);
+ZSTD_DEPRECATED("use ZSTD_CCtx_reset and ZSTD_CCtx_refCDict, see zstd.h for detailed instructions")
+size_t ZSTD_initCStream_usingCDict(ZSTD_CStream* zcs, const ZSTD_CDict* cdict);
 
 /*! ZSTD_initCStream_usingCDict_advanced() :
  *   This function is DEPRECATED, and is approximately equivalent to:
@@ -2133,18 +2247,21 @@ ZSTDLIB_API size_t ZSTD_initCStream_usingCDict(ZSTD_CStream* zcs, const ZSTD_CDi
  * same as ZSTD_initCStream_usingCDict(), with control over frame parameters.
  * pledgedSrcSize must be correct. If srcSize is not known at init time, use
  * value ZSTD_CONTENTSIZE_UNKNOWN.
- * Note : this prototype will be marked as deprecated and generate compilation warnings on reaching v1.5.x
+ * This prototype will generate compilation warnings.
  */
-ZSTDLIB_API size_t
-ZSTD_initCStream_usingCDict_advanced(ZSTD_CStream* zcs,
+ZSTD_DEPRECATED("use ZSTD_CCtx_reset and ZSTD_CCtx_refCDict, see zstd.h for detailed instructions")
+size_t ZSTD_initCStream_usingCDict_advanced(ZSTD_CStream* zcs,
                                const ZSTD_CDict* cdict,
                                      ZSTD_frameParameters fParams,
                                      unsigned long long pledgedSrcSize);
 
 /*! ZSTD_resetCStream() :
- * This function is deprecated, and is equivalent to:
+ * This function is DEPRECATED, and is equivalent to:
  *     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
  *     ZSTD_CCtx_setPledgedSrcSize(zcs, pledgedSrcSize);
+ * Note: ZSTD_resetCStream() interprets pledgedSrcSize == 0 as ZSTD_CONTENTSIZE_UNKNOWN, but
+ *       ZSTD_CCtx_setPledgedSrcSize() does not do the same, so ZSTD_CONTENTSIZE_UNKNOWN must be
+ *       explicitly specified.
  *
  *  start a new frame, using same parameters from previous frame.
  *  This is typically useful to skip dictionary loading stage, since it will re-use it in-place.
@@ -2154,9 +2271,10 @@ ZSTD_initCStream_usingCDict_advanced(ZSTD_CStream* zcs,
  *  For the time being, pledgedSrcSize==0 is interpreted as "srcSize unknown" for compatibility with older programs,
  *  but it will change to mean "empty" in future version, so use macro ZSTD_CONTENTSIZE_UNKNOWN instead.
  * @return : 0, or an error code (which can be tested using ZSTD_isError())
- *  Note : this prototype will be marked as deprecated and generate compilation warnings on reaching v1.5.x
+ *  This prototype will generate compilation warnings.
  */
-ZSTDLIB_API size_t ZSTD_resetCStream(ZSTD_CStream* zcs, unsigned long long pledgedSrcSize);
+ZSTD_DEPRECATED("use ZSTD_CCtx_reset, see zstd.h for detailed instructions")
+size_t ZSTD_resetCStream(ZSTD_CStream* zcs, unsigned long long pledgedSrcSize);
 
 
 typedef struct {
@@ -2174,7 +2292,7 @@ typedef struct {
  * Note : (ingested - consumed) is amount of input data buffered internally, not yet compressed.
  * Aggregates progression inside active worker threads.
  */
-ZSTDLIB_API ZSTD_frameProgression ZSTD_getFrameProgression(const ZSTD_CCtx* cctx);
+ZSTDLIB_STATIC_API ZSTD_frameProgression ZSTD_getFrameProgression(const ZSTD_CCtx* cctx);
 
 /*! ZSTD_toFlushNow() :
  *  Tell how many bytes are ready to be flushed immediately.
@@ -2189,7 +2307,7 @@ ZSTDLIB_API ZSTD_frameProgression ZSTD_getFrameProgression(const ZSTD_CCtx* cctx
  *    therefore flush speed is limited by production speed of oldest job
  *    irrespective of the speed of concurrent (and newer) jobs.
  */
-ZSTDLIB_API size_t ZSTD_toFlushNow(ZSTD_CCtx* cctx);
+ZSTDLIB_STATIC_API size_t ZSTD_toFlushNow(ZSTD_CCtx* cctx);
 
 
 /*=====   Advanced Streaming decompression functions  =====*/
@@ -2203,7 +2321,7 @@ ZSTDLIB_API size_t ZSTD_toFlushNow(ZSTD_CCtx* cctx);
  * note: no dictionary will be used if dict == NULL or dictSize < 8
  * Note : this prototype will be marked as deprecated and generate compilation warnings on reaching v1.5.x
  */
-ZSTDLIB_API size_t ZSTD_initDStream_usingDict(ZSTD_DStream* zds, const void* dict, size_t dictSize);
+ZSTDLIB_STATIC_API size_t ZSTD_initDStream_usingDict(ZSTD_DStream* zds, const void* dict, size_t dictSize);
 
 /*!
  * This function is deprecated, and is equivalent to:
@@ -2214,7 +2332,7 @@ ZSTDLIB_API size_t ZSTD_initDStream_usingDict(ZSTD_DStream* zds, const void* dic
  * note : ddict is referenced, it must outlive decompression session
  * Note : this prototype will be marked as deprecated and generate compilation warnings on reaching v1.5.x
  */
-ZSTDLIB_API size_t ZSTD_initDStream_usingDDict(ZSTD_DStream* zds, const ZSTD_DDict* ddict);
+ZSTDLIB_STATIC_API size_t ZSTD_initDStream_usingDDict(ZSTD_DStream* zds, const ZSTD_DDict* ddict);
 
 /*!
  * This function is deprecated, and is equivalent to:
@@ -2224,7 +2342,7 @@ ZSTDLIB_API size_t ZSTD_initDStream_usingDDict(ZSTD_DStream* zds, const ZSTD_DDi
  * re-use decompression parameters from previous init; saves dictionary loading
  * Note : this prototype will be marked as deprecated and generate compilation warnings on reaching v1.5.x
  */
-ZSTDLIB_API size_t ZSTD_resetDStream(ZSTD_DStream* zds);
+ZSTDLIB_STATIC_API size_t ZSTD_resetDStream(ZSTD_DStream* zds);
 
 
 /* *******************************************************************
@@ -2243,8 +2361,7 @@ ZSTDLIB_API size_t ZSTD_resetDStream(ZSTD_DStream* zds);
   ZSTD_CCtx object can be re-used multiple times within successive compression operations.
 
   Start by initializing a context.
-  Use ZSTD_compressBegin(), or ZSTD_compressBegin_usingDict() for dictionary compression,
-  or ZSTD_compressBegin_advanced(), for finer parameter control.
+  Use ZSTD_compressBegin(), or ZSTD_compressBegin_usingDict() for dictionary compression.
   It's also possible to duplicate a reference context which has already been initialized, using ZSTD_copyCCtx()
 
   Then, consume your input using ZSTD_compressContinue().
@@ -2267,17 +2384,19 @@ ZSTDLIB_API size_t ZSTD_resetDStream(ZSTD_DStream* zds);
 */
 
 /*=====   Buffer-less streaming compression functions  =====*/
-ZSTDLIB_API size_t ZSTD_compressBegin(ZSTD_CCtx* cctx, int compressionLevel);
-ZSTDLIB_API size_t ZSTD_compressBegin_usingDict(ZSTD_CCtx* cctx, const void* dict, size_t dictSize, int compressionLevel);
-ZSTDLIB_API size_t ZSTD_compressBegin_advanced(ZSTD_CCtx* cctx, const void* dict, size_t dictSize, ZSTD_parameters params, unsigned long long pledgedSrcSize); /*< pledgedSrcSize : If srcSize is not known at init time, use ZSTD_CONTENTSIZE_UNKNOWN */
-ZSTDLIB_API size_t ZSTD_compressBegin_usingCDict(ZSTD_CCtx* cctx, const ZSTD_CDict* cdict); /*< note: fails if cdict==NULL */
-ZSTDLIB_API size_t ZSTD_compressBegin_usingCDict_advanced(ZSTD_CCtx* const cctx, const ZSTD_CDict* const cdict, ZSTD_frameParameters const fParams, unsigned long long const pledgedSrcSize);   /* compression parameters are already set within cdict. pledgedSrcSize must be correct. If srcSize is not known, use macro ZSTD_CONTENTSIZE_UNKNOWN */
-ZSTDLIB_API size_t ZSTD_copyCCtx(ZSTD_CCtx* cctx, const ZSTD_CCtx* preparedCCtx, unsigned long long pledgedSrcSize); /*<  note: if pledgedSrcSize is not known, use ZSTD_CONTENTSIZE_UNKNOWN */
-
-ZSTDLIB_API size_t ZSTD_compressContinue(ZSTD_CCtx* cctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
-ZSTDLIB_API size_t ZSTD_compressEnd(ZSTD_CCtx* cctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
-
-
+ZSTDLIB_STATIC_API size_t ZSTD_compressBegin(ZSTD_CCtx* cctx, int compressionLevel);
+ZSTDLIB_STATIC_API size_t ZSTD_compressBegin_usingDict(ZSTD_CCtx* cctx, const void* dict, size_t dictSize, int compressionLevel);
+ZSTDLIB_STATIC_API size_t ZSTD_compressBegin_usingCDict(ZSTD_CCtx* cctx, const ZSTD_CDict* cdict); /*< note: fails if cdict==NULL */
+ZSTDLIB_STATIC_API size_t ZSTD_copyCCtx(ZSTD_CCtx* cctx, const ZSTD_CCtx* preparedCCtx, unsigned long long pledgedSrcSize); /*<  note: if pledgedSrcSize is not known, use ZSTD_CONTENTSIZE_UNKNOWN */
+
+ZSTDLIB_STATIC_API size_t ZSTD_compressContinue(ZSTD_CCtx* cctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
+ZSTDLIB_STATIC_API size_t ZSTD_compressEnd(ZSTD_CCtx* cctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
+
+/* The ZSTD_compressBegin_advanced() and ZSTD_compressBegin_usingCDict_advanced() are now DEPRECATED and will generate a compiler warning */
+ZSTD_DEPRECATED("use advanced API to access custom parameters")
+size_t ZSTD_compressBegin_advanced(ZSTD_CCtx* cctx, const void* dict, size_t dictSize, ZSTD_parameters params, unsigned long long pledgedSrcSize); /*< pledgedSrcSize : If srcSize is not known at init time, use ZSTD_CONTENTSIZE_UNKNOWN */
+ZSTD_DEPRECATED("use advanced API to access custom parameters")
+size_t ZSTD_compressBegin_usingCDict_advanced(ZSTD_CCtx* const cctx, const ZSTD_CDict* const cdict, ZSTD_frameParameters const fParams, unsigned long long const pledgedSrcSize);   /* compression parameters are already set within cdict. pledgedSrcSize must be correct. If srcSize is not known, use macro ZSTD_CONTENTSIZE_UNKNOWN */
 /*
   Buffer-less streaming decompression (synchronous mode)
 
@@ -2368,24 +2487,24 @@ typedef struct {
  * @return : 0, `zfhPtr` is correctly filled,
  *          >0, `srcSize` is too small, value is wanted `srcSize` amount,
  *           or an error code, which can be tested using ZSTD_isError() */
-ZSTDLIB_API size_t ZSTD_getFrameHeader(ZSTD_frameHeader* zfhPtr, const void* src, size_t srcSize);   /*< doesn't consume input */
+ZSTDLIB_STATIC_API size_t ZSTD_getFrameHeader(ZSTD_frameHeader* zfhPtr, const void* src, size_t srcSize);   /*< doesn't consume input */
 /*! ZSTD_getFrameHeader_advanced() :
  *  same as ZSTD_getFrameHeader(),
  *  with added capability to select a format (like ZSTD_f_zstd1_magicless) */
-ZSTDLIB_API size_t ZSTD_getFrameHeader_advanced(ZSTD_frameHeader* zfhPtr, const void* src, size_t srcSize, ZSTD_format_e format);
-ZSTDLIB_API size_t ZSTD_decodingBufferSize_min(unsigned long long windowSize, unsigned long long frameContentSize);  /*< when frame content size is not known, pass in frameContentSize == ZSTD_CONTENTSIZE_UNKNOWN */
+ZSTDLIB_STATIC_API size_t ZSTD_getFrameHeader_advanced(ZSTD_frameHeader* zfhPtr, const void* src, size_t srcSize, ZSTD_format_e format);
+ZSTDLIB_STATIC_API size_t ZSTD_decodingBufferSize_min(unsigned long long windowSize, unsigned long long frameContentSize);  /*< when frame content size is not known, pass in frameContentSize == ZSTD_CONTENTSIZE_UNKNOWN */
 
-ZSTDLIB_API size_t ZSTD_decompressBegin(ZSTD_DCtx* dctx);
-ZSTDLIB_API size_t ZSTD_decompressBegin_usingDict(ZSTD_DCtx* dctx, const void* dict, size_t dictSize);
-ZSTDLIB_API size_t ZSTD_decompressBegin_usingDDict(ZSTD_DCtx* dctx, const ZSTD_DDict* ddict);
+ZSTDLIB_STATIC_API size_t ZSTD_decompressBegin(ZSTD_DCtx* dctx);
+ZSTDLIB_STATIC_API size_t ZSTD_decompressBegin_usingDict(ZSTD_DCtx* dctx, const void* dict, size_t dictSize);
+ZSTDLIB_STATIC_API size_t ZSTD_decompressBegin_usingDDict(ZSTD_DCtx* dctx, const ZSTD_DDict* ddict);
 
-ZSTDLIB_API size_t ZSTD_nextSrcSizeToDecompress(ZSTD_DCtx* dctx);
-ZSTDLIB_API size_t ZSTD_decompressContinue(ZSTD_DCtx* dctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
+ZSTDLIB_STATIC_API size_t ZSTD_nextSrcSizeToDecompress(ZSTD_DCtx* dctx);
+ZSTDLIB_STATIC_API size_t ZSTD_decompressContinue(ZSTD_DCtx* dctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
 
 /* misc */
-ZSTDLIB_API void   ZSTD_copyDCtx(ZSTD_DCtx* dctx, const ZSTD_DCtx* preparedDCtx);
+ZSTDLIB_STATIC_API void   ZSTD_copyDCtx(ZSTD_DCtx* dctx, const ZSTD_DCtx* preparedDCtx);
 typedef enum { ZSTDnit_frameHeader, ZSTDnit_blockHeader, ZSTDnit_block, ZSTDnit_lastBlock, ZSTDnit_checksum, ZSTDnit_skippableFrame } ZSTD_nextInputType_e;
-ZSTDLIB_API ZSTD_nextInputType_e ZSTD_nextInputType(ZSTD_DCtx* dctx);
+ZSTDLIB_STATIC_API ZSTD_nextInputType_e ZSTD_nextInputType(ZSTD_DCtx* dctx);
 
 
 
@@ -2422,10 +2541,10 @@ ZSTDLIB_API ZSTD_nextInputType_e ZSTD_nextInputType(ZSTD_DCtx* dctx);
 */
 
 /*=====   Raw zstd block functions  =====*/
-ZSTDLIB_API size_t ZSTD_getBlockSize   (const ZSTD_CCtx* cctx);
-ZSTDLIB_API size_t ZSTD_compressBlock  (ZSTD_CCtx* cctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
-ZSTDLIB_API size_t ZSTD_decompressBlock(ZSTD_DCtx* dctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
-ZSTDLIB_API size_t ZSTD_insertBlock    (ZSTD_DCtx* dctx, const void* blockStart, size_t blockSize);  /*< insert uncompressed block into `dctx` history. Useful for multi-blocks decompression. */
+ZSTDLIB_STATIC_API size_t ZSTD_getBlockSize   (const ZSTD_CCtx* cctx);
+ZSTDLIB_STATIC_API size_t ZSTD_compressBlock  (ZSTD_CCtx* cctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
+ZSTDLIB_STATIC_API size_t ZSTD_decompressBlock(ZSTD_DCtx* dctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
+ZSTDLIB_STATIC_API size_t ZSTD_insertBlock    (ZSTD_DCtx* dctx, const void* blockStart, size_t blockSize);  /*< insert uncompressed block into `dctx` history. Useful for multi-blocks decompression. */
 
 
 #endif   /* ZSTD_H_ZSTD_STATIC_LINKING_ONLY */
diff --git a/lib/zstd/common/bitstream.h b/lib/zstd/common/bitstream.h
index 28248abe8612..feef3a1b1d60 100644
--- a/lib/zstd/common/bitstream.h
+++ b/lib/zstd/common/bitstream.h
@@ -313,7 +313,16 @@ MEM_STATIC FORCE_INLINE_ATTR size_t BIT_getMiddleBits(size_t bitContainer, U32 c
     U32 const regMask = sizeof(bitContainer)*8 - 1;
     /* if start > regMask, bitstream is corrupted, and result is undefined */
     assert(nbBits < BIT_MASK_SIZE);
+    /* x86 transform & ((1 << nbBits) - 1) to bzhi instruction, it is better
+     * than accessing memory. When bmi2 instruction is not present, we consider
+     * such cpus old (pre-Haswell, 2013) and their performance is not of that
+     * importance.
+     */
+#if defined(__x86_64__) || defined(_M_X86)
+    return (bitContainer >> (start & regMask)) & ((((U64)1) << nbBits) - 1);
+#else
     return (bitContainer >> (start & regMask)) & BIT_mask[nbBits];
+#endif
 }
 
 MEM_STATIC FORCE_INLINE_ATTR size_t BIT_getLowerBits(size_t bitContainer, U32 const nbBits)
diff --git a/lib/zstd/common/compiler.h b/lib/zstd/common/compiler.h
index f5a9c70a228a..c42d39faf9bd 100644
--- a/lib/zstd/common/compiler.h
+++ b/lib/zstd/common/compiler.h
@@ -11,6 +11,8 @@
 #ifndef ZSTD_COMPILER_H
 #define ZSTD_COMPILER_H
 
+#include "portability_macros.h"
+
 /*-*******************************************************
 *  Compiler specifics
 *********************************************************/
@@ -34,7 +36,7 @@
 
 /*
   On MSVC qsort requires that functions passed into it use the __cdecl calling conversion(CC).
-  This explictly marks such functions as __cdecl so that the code will still compile
+  This explicitly marks such functions as __cdecl so that the code will still compile
   if a CC other than __cdecl has been made the default.
 */
 #define WIN_CDECL
@@ -70,25 +72,13 @@
 
 
 /* target attribute */
-#ifndef __has_attribute
-  #define __has_attribute(x) 0  /* Compatibility with non-clang compilers. */
-#endif
 #define TARGET_ATTRIBUTE(target) __attribute__((__target__(target)))
 
-/* Enable runtime BMI2 dispatch based on the CPU.
- * Enabled for clang & gcc >=4.8 on x86 when BMI2 isn't enabled by default.
+/* Target attribute for BMI2 dynamic dispatch.
+ * Enable lzcnt, bmi, and bmi2.
+ * We test for bmi1 & bmi2. lzcnt is included in bmi1.
  */
-#ifndef DYNAMIC_BMI2
-  #if ((defined(__clang__) && __has_attribute(__target__)) \
-      || (defined(__GNUC__) \
-          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
-      && (defined(__x86_64__) || defined(_M_X86)) \
-      && !defined(__BMI2__)
-  #  define DYNAMIC_BMI2 1
-  #else
-  #  define DYNAMIC_BMI2 0
-  #endif
-#endif
+#define BMI2_TARGET_ATTRIBUTE TARGET_ATTRIBUTE("lzcnt,bmi,bmi2")
 
 /* prefetch
  * can be disabled, by declaring NO_PREFETCH build macro */
@@ -115,8 +105,9 @@
 }
 
 /* vectorization
- * older GCC (pre gcc-4.3 picked as the cutoff) uses a different syntax */
-#if !defined(__INTEL_COMPILER) && !defined(__clang__) && defined(__GNUC__)
+ * older GCC (pre gcc-4.3 picked as the cutoff) uses a different syntax,
+ * and some compilers, like Intel ICC and MCST LCC, do not support it at all. */
+#if !defined(__INTEL_COMPILER) && !defined(__clang__) && defined(__GNUC__) && !defined(__LCC__)
 #  if (__GNUC__ == 4 && __GNUC_MINOR__ > 3) || (__GNUC__ >= 5)
 #    define DONT_VECTORIZE __attribute__((optimize("no-tree-vectorize")))
 #  else
@@ -134,20 +125,18 @@
 #define LIKELY(x) (__builtin_expect((x), 1))
 #define UNLIKELY(x) (__builtin_expect((x), 0))
 
+#if __has_builtin(__builtin_unreachable) || (defined(__GNUC__) && (__GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 5)))
+#  define ZSTD_UNREACHABLE { assert(0), __builtin_unreachable(); }
+#else
+#  define ZSTD_UNREACHABLE { assert(0); }
+#endif
+
 /* disable warnings */
 
 /*Like DYNAMIC_BMI2 but for compile time determination of BMI2 support*/
 
 
-/* compat. with non-clang compilers */
-#ifndef __has_builtin
-#  define __has_builtin(x) 0
-#endif
-
-/* compat. with non-clang compilers */
-#ifndef __has_feature
-#  define __has_feature(x) 0
-#endif
+/* compile time determination of SIMD support */
 
 /* C-language Attributes are added in C23. */
 #if defined(__STDC_VERSION__) && (__STDC_VERSION__ > 201710L) && defined(__has_c_attribute)
@@ -168,10 +157,28 @@
  */
 #define ZSTD_FALLTHROUGH fallthrough
 
-/* detects whether we are being compiled under msan */
+/*-**************************************************************
+*  Alignment check
+*****************************************************************/
+
+/* this test was initially positioned in mem.h,
+ * but this file is removed (or replaced) for linux kernel
+ * so it's now hosted in compiler.h,
+ * which remains valid for both user & kernel spaces.
+ */
+
+#ifndef ZSTD_ALIGNOF
+/* covers gcc, clang & MSVC */
+/* note : this section must come first, before C11,
+ * due to a limitation in the kernel source generator */
+#  define ZSTD_ALIGNOF(T) __alignof(T)
+
+#endif /* ZSTD_ALIGNOF */
 
+/*-**************************************************************
+*  Sanitizer
+*****************************************************************/
 
-/* detects whether we are being compiled under asan */
 
 
 #endif /* ZSTD_COMPILER_H */
diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
index 6353249de614..fef67056f052 100644
--- a/lib/zstd/common/entropy_common.c
+++ b/lib/zstd/common/entropy_common.c
@@ -212,7 +212,7 @@ static size_t FSE_readNCount_body_default(
 }
 
 #if DYNAMIC_BMI2
-TARGET_ATTRIBUTE("bmi2") static size_t FSE_readNCount_body_bmi2(
+BMI2_TARGET_ATTRIBUTE static size_t FSE_readNCount_body_bmi2(
         short* normalizedCounter, unsigned* maxSVPtr, unsigned* tableLogPtr,
         const void* headerBuffer, size_t hbSize)
 {
@@ -240,6 +240,7 @@ size_t FSE_readNCount(
     return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr, tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
 }
 
+
 /*! HUF_readStats() :
     Read compact Huffman tree, saved by HUF_writeCTable().
     `huffWeight` is destination buffer.
@@ -293,7 +294,7 @@ HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U32* rankStats,
     ZSTD_memset(rankStats, 0, (HUF_TABLELOG_MAX + 1) * sizeof(U32));
     weightTotal = 0;
     {   U32 n; for (n=0; n<oSize; n++) {
-            if (huffWeight[n] >= HUF_TABLELOG_MAX) return ERROR(corruption_detected);
+            if (huffWeight[n] > HUF_TABLELOG_MAX) return ERROR(corruption_detected);
             rankStats[huffWeight[n]]++;
             weightTotal += (1 << huffWeight[n]) >> 1;
     }   }
@@ -331,7 +332,7 @@ static size_t HUF_readStats_body_default(BYTE* huffWeight, size_t hwSize, U32* r
 }
 
 #if DYNAMIC_BMI2
-static TARGET_ATTRIBUTE("bmi2") size_t HUF_readStats_body_bmi2(BYTE* huffWeight, size_t hwSize, U32* rankStats,
+static BMI2_TARGET_ATTRIBUTE size_t HUF_readStats_body_bmi2(BYTE* huffWeight, size_t hwSize, U32* rankStats,
                      U32* nbSymbolsPtr, U32* tableLogPtr,
                      const void* src, size_t srcSize,
                      void* workSpace, size_t wkspSize)
diff --git a/lib/zstd/common/error_private.h b/lib/zstd/common/error_private.h
index d14e686adf95..ca5101e542fa 100644
--- a/lib/zstd/common/error_private.h
+++ b/lib/zstd/common/error_private.h
@@ -18,8 +18,10 @@
 /* ****************************************
 *  Dependencies
 ******************************************/
-#include "zstd_deps.h"    /* size_t */
 #include <linux/zstd_errors.h>  /* enum list */
+#include "compiler.h"
+#include "debug.h"
+#include "zstd_deps.h"       /* size_t */
 
 
 /* ****************************************
@@ -62,5 +64,82 @@ ERR_STATIC const char* ERR_getErrorName(size_t code)
     return ERR_getErrorString(ERR_getErrorCode(code));
 }
 
+/*
+ * Ignore: this is an internal helper.
+ *
+ * This is a helper function to help force C99-correctness during compilation.
+ * Under strict compilation modes, variadic macro arguments can't be empty.
+ * However, variadic function arguments can be. Using a function therefore lets
+ * us statically check that at least one (string) argument was passed,
+ * independent of the compilation flags.
+ */
+static INLINE_KEYWORD UNUSED_ATTR
+void _force_has_format_string(const char *format, ...) {
+  (void)format;
+}
+
+/*
+ * Ignore: this is an internal helper.
+ *
+ * We want to force this function invocation to be syntactically correct, but
+ * we don't want to force runtime evaluation of its arguments.
+ */
+#define _FORCE_HAS_FORMAT_STRING(...) \
+  if (0) { \
+    _force_has_format_string(__VA_ARGS__); \
+  }
+
+#define ERR_QUOTE(str) #str
+
+/*
+ * Return the specified error if the condition evaluates to true.
+ *
+ * In debug modes, prints additional information.
+ * In order to do that (particularly, printing the conditional that failed),
+ * this can't just wrap RETURN_ERROR().
+ */
+#define RETURN_ERROR_IF(cond, err, ...) \
+  if (cond) { \
+    RAWLOG(3, "%s:%d: ERROR!: check %s failed, returning %s", \
+           __FILE__, __LINE__, ERR_QUOTE(cond), ERR_QUOTE(ERROR(err))); \
+    _FORCE_HAS_FORMAT_STRING(__VA_ARGS__); \
+    RAWLOG(3, ": " __VA_ARGS__); \
+    RAWLOG(3, "\n"); \
+    return ERROR(err); \
+  }
+
+/*
+ * Unconditionally return the specified error.
+ *
+ * In debug modes, prints additional information.
+ */
+#define RETURN_ERROR(err, ...) \
+  do { \
+    RAWLOG(3, "%s:%d: ERROR!: unconditional check failed, returning %s", \
+           __FILE__, __LINE__, ERR_QUOTE(ERROR(err))); \
+    _FORCE_HAS_FORMAT_STRING(__VA_ARGS__); \
+    RAWLOG(3, ": " __VA_ARGS__); \
+    RAWLOG(3, "\n"); \
+    return ERROR(err); \
+  } while(0);
+
+/*
+ * If the provided expression evaluates to an error code, returns that error code.
+ *
+ * In debug modes, prints additional information.
+ */
+#define FORWARD_IF_ERROR(err, ...) \
+  do { \
+    size_t const err_code = (err); \
+    if (ERR_isError(err_code)) { \
+      RAWLOG(3, "%s:%d: ERROR!: forwarding error in %s: %s", \
+             __FILE__, __LINE__, ERR_QUOTE(err), ERR_getErrorName(err_code)); \
+      _FORCE_HAS_FORMAT_STRING(__VA_ARGS__); \
+      RAWLOG(3, ": " __VA_ARGS__); \
+      RAWLOG(3, "\n"); \
+      return err_code; \
+    } \
+  } while(0);
+
 
 #endif /* ERROR_H_MODULE */
diff --git a/lib/zstd/common/fse.h b/lib/zstd/common/fse.h
index 0bb174c2c367..4507043b2287 100644
--- a/lib/zstd/common/fse.h
+++ b/lib/zstd/common/fse.h
@@ -333,8 +333,9 @@ size_t FSE_buildCTable_rle (FSE_CTable* ct, unsigned char symbolValue);
 /* FSE_buildCTable_wksp() :
  * Same as FSE_buildCTable(), but using an externally allocated scratch buffer (`workSpace`).
  * `wkspSize` must be >= `FSE_BUILD_CTABLE_WORKSPACE_SIZE_U32(maxSymbolValue, tableLog)` of `unsigned`.
+ * See FSE_buildCTable_wksp() for breakdown of workspace usage.
  */
-#define FSE_BUILD_CTABLE_WORKSPACE_SIZE_U32(maxSymbolValue, tableLog) (maxSymbolValue + 2 + (1ull << (tableLog - 2)))
+#define FSE_BUILD_CTABLE_WORKSPACE_SIZE_U32(maxSymbolValue, tableLog) (((maxSymbolValue + 2) + (1ull << (tableLog)))/2 + sizeof(U64)/sizeof(U32) /* additional 8 bytes for potential table overwrite */)
 #define FSE_BUILD_CTABLE_WORKSPACE_SIZE(maxSymbolValue, tableLog) (sizeof(unsigned) * FSE_BUILD_CTABLE_WORKSPACE_SIZE_U32(maxSymbolValue, tableLog))
 size_t FSE_buildCTable_wksp(FSE_CTable* ct, const short* normalizedCounter, unsigned maxSymbolValue, unsigned tableLog, void* workSpace, size_t wkspSize);
 
diff --git a/lib/zstd/common/fse_decompress.c b/lib/zstd/common/fse_decompress.c
index 2c8bbe3e4c14..a0d06095be83 100644
--- a/lib/zstd/common/fse_decompress.c
+++ b/lib/zstd/common/fse_decompress.c
@@ -365,7 +365,7 @@ static size_t FSE_decompress_wksp_body_default(void* dst, size_t dstCapacity, co
 }
 
 #if DYNAMIC_BMI2
-TARGET_ATTRIBUTE("bmi2") static size_t FSE_decompress_wksp_body_bmi2(void* dst, size_t dstCapacity, const void* cSrc, size_t cSrcSize, unsigned maxLog, void* workSpace, size_t wkspSize)
+BMI2_TARGET_ATTRIBUTE static size_t FSE_decompress_wksp_body_bmi2(void* dst, size_t dstCapacity, const void* cSrc, size_t cSrcSize, unsigned maxLog, void* workSpace, size_t wkspSize)
 {
     return FSE_decompress_wksp_body(dst, dstCapacity, cSrc, cSrcSize, maxLog, workSpace, wkspSize, 1);
 }
diff --git a/lib/zstd/common/huf.h b/lib/zstd/common/huf.h
index 88c5586646aa..5042ff870308 100644
--- a/lib/zstd/common/huf.h
+++ b/lib/zstd/common/huf.h
@@ -86,9 +86,9 @@ HUF_PUBLIC_API size_t HUF_compress2 (void* dst, size_t dstCapacity,
 
 /* HUF_compress4X_wksp() :
  *  Same as HUF_compress2(), but uses externally allocated `workSpace`.
- * `workspace` must have minimum alignment of 4, and be at least as large as HUF_WORKSPACE_SIZE */
-#define HUF_WORKSPACE_SIZE ((6 << 10) + 256)
-#define HUF_WORKSPACE_SIZE_U32 (HUF_WORKSPACE_SIZE / sizeof(U32))
+ * `workspace` must be at least as large as HUF_WORKSPACE_SIZE */
+#define HUF_WORKSPACE_SIZE ((8 << 10) + 512 /* sorting scratch space */)
+#define HUF_WORKSPACE_SIZE_U64 (HUF_WORKSPACE_SIZE / sizeof(U64))
 HUF_PUBLIC_API size_t HUF_compress4X_wksp (void* dst, size_t dstCapacity,
                                      const void* src, size_t srcSize,
                                      unsigned maxSymbolValue, unsigned tableLog,
@@ -113,11 +113,11 @@ HUF_PUBLIC_API size_t HUF_compress4X_wksp (void* dst, size_t dstCapacity,
 
 
 /* *** Constants *** */
-#define HUF_TABLELOG_MAX      12      /* max runtime value of tableLog (due to static allocation); can be modified up to HUF_ABSOLUTEMAX_TABLELOG */
+#define HUF_TABLELOG_MAX      12      /* max runtime value of tableLog (due to static allocation); can be modified up to HUF_TABLELOG_ABSOLUTEMAX */
 #define HUF_TABLELOG_DEFAULT  11      /* default tableLog value when none specified */
 #define HUF_SYMBOLVALUE_MAX  255
 
-#define HUF_TABLELOG_ABSOLUTEMAX  15  /* absolute limit of HUF_MAX_TABLELOG. Beyond that value, code does not work */
+#define HUF_TABLELOG_ABSOLUTEMAX  12  /* absolute limit of HUF_MAX_TABLELOG. Beyond that value, code does not work */
 #if (HUF_TABLELOG_MAX > HUF_TABLELOG_ABSOLUTEMAX)
 #  error "HUF_TABLELOG_MAX is too large !"
 #endif
@@ -133,15 +133,11 @@ HUF_PUBLIC_API size_t HUF_compress4X_wksp (void* dst, size_t dstCapacity,
 
 /* static allocation of HUF's Compression Table */
 /* this is a private definition, just exposed for allocation and strict aliasing purpose. never EVER access its members directly */
-struct HUF_CElt_s {
-  U16  val;
-  BYTE nbBits;
-};   /* typedef'd to HUF_CElt */
-typedef struct HUF_CElt_s HUF_CElt;   /* consider it an incomplete type */
-#define HUF_CTABLE_SIZE_U32(maxSymbolValue)   ((maxSymbolValue)+1)   /* Use tables of U32, for proper alignment */
-#define HUF_CTABLE_SIZE(maxSymbolValue)       (HUF_CTABLE_SIZE_U32(maxSymbolValue) * sizeof(U32))
+typedef size_t HUF_CElt;   /* consider it an incomplete type */
+#define HUF_CTABLE_SIZE_ST(maxSymbolValue)   ((maxSymbolValue)+2)   /* Use tables of size_t, for proper alignment */
+#define HUF_CTABLE_SIZE(maxSymbolValue)       (HUF_CTABLE_SIZE_ST(maxSymbolValue) * sizeof(size_t))
 #define HUF_CREATE_STATIC_CTABLE(name, maxSymbolValue) \
-    HUF_CElt name[HUF_CTABLE_SIZE_U32(maxSymbolValue)] /* no final ; */
+    HUF_CElt name[HUF_CTABLE_SIZE_ST(maxSymbolValue)] /* no final ; */
 
 /* static allocation of HUF's DTable */
 typedef U32 HUF_DTable;
@@ -191,6 +187,7 @@ size_t HUF_buildCTable (HUF_CElt* CTable, const unsigned* count, unsigned maxSym
 size_t HUF_writeCTable (void* dst, size_t maxDstSize, const HUF_CElt* CTable, unsigned maxSymbolValue, unsigned huffLog);
 size_t HUF_writeCTable_wksp(void* dst, size_t maxDstSize, const HUF_CElt* CTable, unsigned maxSymbolValue, unsigned huffLog, void* workspace, size_t workspaceSize);
 size_t HUF_compress4X_usingCTable(void* dst, size_t dstSize, const void* src, size_t srcSize, const HUF_CElt* CTable);
+size_t HUF_compress4X_usingCTable_bmi2(void* dst, size_t dstSize, const void* src, size_t srcSize, const HUF_CElt* CTable, int bmi2);
 size_t HUF_estimateCompressedSize(const HUF_CElt* CTable, const unsigned* count, unsigned maxSymbolValue);
 int HUF_validateCTable(const HUF_CElt* CTable, const unsigned* count, unsigned maxSymbolValue);
 
@@ -203,12 +200,13 @@ typedef enum {
  *  Same as HUF_compress4X_wksp(), but considers using hufTable if *repeat != HUF_repeat_none.
  *  If it uses hufTable it does not modify hufTable or repeat.
  *  If it doesn't, it sets *repeat = HUF_repeat_none, and it sets hufTable to the table used.
- *  If preferRepeat then the old table will always be used if valid. */
+ *  If preferRepeat then the old table will always be used if valid.
+ *  If suspectUncompressible then some sampling checks will be run to potentially skip huffman coding */
 size_t HUF_compress4X_repeat(void* dst, size_t dstSize,
                        const void* src, size_t srcSize,
                        unsigned maxSymbolValue, unsigned tableLog,
                        void* workSpace, size_t wkspSize,    /*< `workSpace` must be aligned on 4-bytes boundaries, `wkspSize` must be >= HUF_WORKSPACE_SIZE */
-                       HUF_CElt* hufTable, HUF_repeat* repeat, int preferRepeat, int bmi2);
+                       HUF_CElt* hufTable, HUF_repeat* repeat, int preferRepeat, int bmi2, unsigned suspectUncompressible);
 
 /* HUF_buildCTable_wksp() :
  *  Same as HUF_buildCTable(), but using externally allocated scratch buffer.
@@ -246,11 +244,10 @@ size_t HUF_readStats_wksp(BYTE* huffWeight, size_t hwSize,
  *  Loading a CTable saved with HUF_writeCTable() */
 size_t HUF_readCTable (HUF_CElt* CTable, unsigned* maxSymbolValuePtr, const void* src, size_t srcSize, unsigned *hasZeroWeights);
 
-/* HUF_getNbBits() :
+/* HUF_getNbBitsFromCTable() :
  *  Read nbBits from CTable symbolTable, for symbol `symbolValue` presumed <= HUF_SYMBOLVALUE_MAX
- *  Note 1 : is not inlined, as HUF_CElt definition is private
- *  Note 2 : const void* used, so that it can provide a statically allocated table as argument (which uses type U32) */
-U32 HUF_getNbBits(const void* symbolTable, U32 symbolValue);
+ *  Note 1 : is not inlined, as HUF_CElt definition is private */
+U32 HUF_getNbBitsFromCTable(const HUF_CElt* symbolTable, U32 symbolValue);
 
 /*
  * HUF_decompress() does the following:
@@ -302,18 +299,20 @@ size_t HUF_decompress4X2_usingDTable(void* dst, size_t maxDstSize, const void* c
 /* ====================== */
 
 size_t HUF_compress1X (void* dst, size_t dstSize, const void* src, size_t srcSize, unsigned maxSymbolValue, unsigned tableLog);
-size_t HUF_compress1X_wksp (void* dst, size_t dstSize, const void* src, size_t srcSize, unsigned maxSymbolValue, unsigned tableLog, void* workSpace, size_t wkspSize);  /*< `workSpace` must be a table of at least HUF_WORKSPACE_SIZE_U32 unsigned */
+size_t HUF_compress1X_wksp (void* dst, size_t dstSize, const void* src, size_t srcSize, unsigned maxSymbolValue, unsigned tableLog, void* workSpace, size_t wkspSize);  /*< `workSpace` must be a table of at least HUF_WORKSPACE_SIZE_U64 U64 */
 size_t HUF_compress1X_usingCTable(void* dst, size_t dstSize, const void* src, size_t srcSize, const HUF_CElt* CTable);
+size_t HUF_compress1X_usingCTable_bmi2(void* dst, size_t dstSize, const void* src, size_t srcSize, const HUF_CElt* CTable, int bmi2);
 /* HUF_compress1X_repeat() :
  *  Same as HUF_compress1X_wksp(), but considers using hufTable if *repeat != HUF_repeat_none.
  *  If it uses hufTable it does not modify hufTable or repeat.
  *  If it doesn't, it sets *repeat = HUF_repeat_none, and it sets hufTable to the table used.
- *  If preferRepeat then the old table will always be used if valid. */
+ *  If preferRepeat then the old table will always be used if valid.
+ *  If suspectUncompressible then some sampling checks will be run to potentially skip huffman coding */
 size_t HUF_compress1X_repeat(void* dst, size_t dstSize,
                        const void* src, size_t srcSize,
                        unsigned maxSymbolValue, unsigned tableLog,
                        void* workSpace, size_t wkspSize,   /*< `workSpace` must be aligned on 4-bytes boundaries, `wkspSize` must be >= HUF_WORKSPACE_SIZE */
-                       HUF_CElt* hufTable, HUF_repeat* repeat, int preferRepeat, int bmi2);
+                       HUF_CElt* hufTable, HUF_repeat* repeat, int preferRepeat, int bmi2, unsigned suspectUncompressible);
 
 size_t HUF_decompress1X1 (void* dst, size_t dstSize, const void* cSrc, size_t cSrcSize);   /* single-symbol decoder */
 #ifndef HUF_FORCE_DECOMPRESS_X1
@@ -351,6 +350,9 @@ size_t HUF_decompress4X_hufOnly_wksp_bmi2(HUF_DTable* dctx, void* dst, size_t ds
 #ifndef HUF_FORCE_DECOMPRESS_X2
 size_t HUF_readDTableX1_wksp_bmi2(HUF_DTable* DTable, const void* src, size_t srcSize, void* workSpace, size_t wkspSize, int bmi2);
 #endif
+#ifndef HUF_FORCE_DECOMPRESS_X1
+size_t HUF_readDTableX2_wksp_bmi2(HUF_DTable* DTable, const void* src, size_t srcSize, void* workSpace, size_t wkspSize, int bmi2);
+#endif
 
 #endif /* HUF_STATIC_LINKING_ONLY */
 
diff --git a/lib/zstd/common/mem.h b/lib/zstd/common/mem.h
index dcdd586a9fd9..1d9cc03924ca 100644
--- a/lib/zstd/common/mem.h
+++ b/lib/zstd/common/mem.h
@@ -30,6 +30,8 @@
 *  Basic Types
 *****************************************************************/
 typedef uint8_t  BYTE;
+typedef uint8_t  U8;
+typedef int8_t   S8;
 typedef uint16_t U16;
 typedef int16_t  S16;
 typedef uint32_t U32;
diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portability_macros.h
new file mode 100644
index 000000000000..0e3b2c0a527d
--- /dev/null
+++ b/lib/zstd/common/portability_macros.h
@@ -0,0 +1,93 @@
+/*
+ * Copyright (c) Facebook, Inc.
+ * All rights reserved.
+ *
+ * This source code is licensed under both the BSD-style license (found in the
+ * LICENSE file in the root directory of this source tree) and the GPLv2 (found
+ * in the COPYING file in the root directory of this source tree).
+ * You may select, at your option, one of the above-listed licenses.
+ */
+
+#ifndef ZSTD_PORTABILITY_MACROS_H
+#define ZSTD_PORTABILITY_MACROS_H
+
+/*
+ * This header file contains macro defintions to support portability.
+ * This header is shared between C and ASM code, so it MUST only
+ * contain macro definitions. It MUST not contain any C code.
+ *
+ * This header ONLY defines macros to detect platforms/feature support.
+ *
+ */
+
+
+/* compat. with non-clang compilers */
+#ifndef __has_attribute
+  #define __has_attribute(x) 0
+#endif
+
+/* compat. with non-clang compilers */
+#ifndef __has_builtin
+#  define __has_builtin(x) 0
+#endif
+
+/* compat. with non-clang compilers */
+#ifndef __has_feature
+#  define __has_feature(x) 0
+#endif
+
+/* detects whether we are being compiled under msan */
+
+/* detects whether we are being compiled under asan */
+
+/* detects whether we are being compiled under dfsan */
+
+/* Mark the internal assembly functions as hidden  */
+#ifdef __ELF__
+# define ZSTD_HIDE_ASM_FUNCTION(func) .hidden func
+#else
+# define ZSTD_HIDE_ASM_FUNCTION(func)
+#endif
+
+/* Enable runtime BMI2 dispatch based on the CPU.
+ * Enabled for clang & gcc >=4.8 on x86 when BMI2 isn't enabled by default.
+ */
+#ifndef DYNAMIC_BMI2
+  #if ((defined(__clang__) && __has_attribute(__target__)) \
+      || (defined(__GNUC__) \
+          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
+      && (defined(__x86_64__) || defined(_M_X64)) \
+      && !defined(__BMI2__)
+  #  define DYNAMIC_BMI2 1
+  #else
+  #  define DYNAMIC_BMI2 0
+  #endif
+#endif
+
+/*
+ * Only enable assembly for GNUC comptabile compilers,
+ * because other platforms may not support GAS assembly syntax.
+ *
+ * Only enable assembly for Linux / MacOS, other platforms may
+ * work, but they haven't been tested. This could likely be
+ * extended to BSD systems.
+ *
+ * Disable assembly when MSAN is enabled, because MSAN requires
+ * 100% of code to be instrumented to work.
+ */
+#define ZSTD_ASM_SUPPORTED 1
+
+/*
+ * Determines whether we should enable assembly for x86-64
+ * with BMI2.
+ *
+ * Enable if all of the following conditions hold:
+ * - ASM hasn't been explicitly disabled by defining ZSTD_DISABLE_ASM
+ * - Assembly is supported
+ * - We are compiling for x86-64 and either:
+ *   - DYNAMIC_BMI2 is enabled
+ *   - BMI2 is supported at compile time
+ */
+#define ZSTD_ENABLE_ASM_X86_64_BMI2 0
+
+#endif /* ZSTD_PORTABILITY_MACROS_H */
diff --git a/lib/zstd/common/zstd_internal.h b/lib/zstd/common/zstd_internal.h
index fc6f3a9b40c0..93305d9b41bb 100644
--- a/lib/zstd/common/zstd_internal.h
+++ b/lib/zstd/common/zstd_internal.h
@@ -20,6 +20,7 @@
 *  Dependencies
 ***************************************/
 #include "compiler.h"
+#include "cpu.h"
 #include "mem.h"
 #include "debug.h"                 /* assert, DEBUGLOG, RAWLOG, g_debuglevel */
 #include "error_private.h"
@@ -47,81 +48,7 @@
 #undef MAX
 #define MIN(a,b) ((a)<(b) ? (a) : (b))
 #define MAX(a,b) ((a)>(b) ? (a) : (b))
-
-/*
- * Ignore: this is an internal helper.
- *
- * This is a helper function to help force C99-correctness during compilation.
- * Under strict compilation modes, variadic macro arguments can't be empty.
- * However, variadic function arguments can be. Using a function therefore lets
- * us statically check that at least one (string) argument was passed,
- * independent of the compilation flags.
- */
-static INLINE_KEYWORD UNUSED_ATTR
-void _force_has_format_string(const char *format, ...) {
-  (void)format;
-}
-
-/*
- * Ignore: this is an internal helper.
- *
- * We want to force this function invocation to be syntactically correct, but
- * we don't want to force runtime evaluation of its arguments.
- */
-#define _FORCE_HAS_FORMAT_STRING(...) \
-  if (0) { \
-    _force_has_format_string(__VA_ARGS__); \
-  }
-
-/*
- * Return the specified error if the condition evaluates to true.
- *
- * In debug modes, prints additional information.
- * In order to do that (particularly, printing the conditional that failed),
- * this can't just wrap RETURN_ERROR().
- */
-#define RETURN_ERROR_IF(cond, err, ...) \
-  if (cond) { \
-    RAWLOG(3, "%s:%d: ERROR!: check %s failed, returning %s", \
-           __FILE__, __LINE__, ZSTD_QUOTE(cond), ZSTD_QUOTE(ERROR(err))); \
-    _FORCE_HAS_FORMAT_STRING(__VA_ARGS__); \
-    RAWLOG(3, ": " __VA_ARGS__); \
-    RAWLOG(3, "\n"); \
-    return ERROR(err); \
-  }
-
-/*
- * Unconditionally return the specified error.
- *
- * In debug modes, prints additional information.
- */
-#define RETURN_ERROR(err, ...) \
-  do { \
-    RAWLOG(3, "%s:%d: ERROR!: unconditional check failed, returning %s", \
-           __FILE__, __LINE__, ZSTD_QUOTE(ERROR(err))); \
-    _FORCE_HAS_FORMAT_STRING(__VA_ARGS__); \
-    RAWLOG(3, ": " __VA_ARGS__); \
-    RAWLOG(3, "\n"); \
-    return ERROR(err); \
-  } while(0);
-
-/*
- * If the provided expression evaluates to an error code, returns that error code.
- *
- * In debug modes, prints additional information.
- */
-#define FORWARD_IF_ERROR(err, ...) \
-  do { \
-    size_t const err_code = (err); \
-    if (ERR_isError(err_code)) { \
-      RAWLOG(3, "%s:%d: ERROR!: forwarding error in %s: %s", \
-             __FILE__, __LINE__, ZSTD_QUOTE(err), ERR_getErrorName(err_code)); \
-      _FORCE_HAS_FORMAT_STRING(__VA_ARGS__); \
-      RAWLOG(3, ": " __VA_ARGS__); \
-      RAWLOG(3, "\n"); \
-      return err_code; \
-    } \
-  } while(0);
+#define BOUNDED(min,val,max) (MAX(min,MIN(val,max)))
 
 
 /*-*************************************
@@ -130,7 +57,6 @@ void _force_has_format_string(const char *format, ...) {
 #define ZSTD_OPT_NUM    (1<<12)
 
 #define ZSTD_REP_NUM      3                 /* number of repcodes */
-#define ZSTD_REP_MOVE     (ZSTD_REP_NUM-1)
 static UNUSED_ATTR const U32 repStartValue[ZSTD_REP_NUM] = { 1, 4, 8 };
 
 #define KB *(1 <<10)
@@ -182,7 +108,7 @@ typedef enum { set_basic, set_rle, set_compressed, set_repeat } symbolEncodingTy
 /* Each table cannot take more than #symbols * FSELog bits */
 #define ZSTD_MAX_FSE_HEADERS_SIZE (((MaxML + 1) * MLFSELog + (MaxLL + 1) * LLFSELog + (MaxOff + 1) * OffFSELog + 7) / 8)
 
-static UNUSED_ATTR const U32 LL_bits[MaxLL+1] = {
+static UNUSED_ATTR const U8 LL_bits[MaxLL+1] = {
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      1, 1, 1, 1, 2, 2, 3, 3,
@@ -199,7 +125,7 @@ static UNUSED_ATTR const S16 LL_defaultNorm[MaxLL+1] = {
 #define LL_DEFAULTNORMLOG 6  /* for static allocation */
 static UNUSED_ATTR const U32 LL_defaultNormLog = LL_DEFAULTNORMLOG;
 
-static UNUSED_ATTR const U32 ML_bits[MaxML+1] = {
+static UNUSED_ATTR const U8 ML_bits[MaxML+1] = {
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
@@ -234,12 +160,31 @@ static UNUSED_ATTR const U32 OF_defaultNormLog = OF_DEFAULTNORMLOG;
 *  Shared functions to include for inlining
 *********************************************/
 static void ZSTD_copy8(void* dst, const void* src) {
+#if defined(ZSTD_ARCH_ARM_NEON)
+    vst1_u8((uint8_t*)dst, vld1_u8((const uint8_t*)src));
+#else
     ZSTD_memcpy(dst, src, 8);
+#endif
 }
-
 #define COPY8(d,s) { ZSTD_copy8(d,s); d+=8; s+=8; }
+
+/* Need to use memmove here since the literal buffer can now be located within
+   the dst buffer. In circumstances where the op "catches up" to where the
+   literal buffer is, there can be partial overlaps in this call on the final
+   copy if the literal is being shifted by less than 16 bytes. */
 static void ZSTD_copy16(void* dst, const void* src) {
-    ZSTD_memcpy(dst, src, 16);
+#if defined(ZSTD_ARCH_ARM_NEON)
+    vst1q_u8((uint8_t*)dst, vld1q_u8((const uint8_t*)src));
+#elif defined(ZSTD_ARCH_X86_SSE2)
+    _mm_storeu_si128((__m128i*)dst, _mm_loadu_si128((const __m128i*)src));
+#elif defined(__clang__)
+    ZSTD_memmove(dst, src, 16);
+#else
+    /* ZSTD_memmove is not inlined properly by gcc */
+    BYTE copy16_buf[16];
+    ZSTD_memcpy(copy16_buf, src, 16);
+    ZSTD_memcpy(dst, copy16_buf, 16);
+#endif
 }
 #define COPY16(d,s) { ZSTD_copy16(d,s); d+=16; s+=16; }
 
@@ -267,8 +212,6 @@ void ZSTD_wildcopy(void* dst, const void* src, ptrdiff_t length, ZSTD_overlap_e
     BYTE* op = (BYTE*)dst;
     BYTE* const oend = op + length;
 
-    assert(diff >= 8 || (ovtype == ZSTD_no_overlap && diff <= -WILDCOPY_VECLEN));
-
     if (ovtype == ZSTD_overlap_src_before_dst && diff < WILDCOPY_VECLEN) {
         /* Handle short offset copies. */
         do {
@@ -331,11 +274,18 @@ typedef enum {
 *  Private declarations
 *********************************************/
 typedef struct seqDef_s {
-    U32 offset;         /* Offset code of the sequence */
+    U32 offBase;   /* offBase == Offset + ZSTD_REP_NUM, or repcode 1,2,3 */
     U16 litLength;
-    U16 matchLength;
+    U16 mlBase;    /* mlBase == matchLength - MINMATCH */
 } seqDef;
 
+/* Controls whether seqStore has a single "long" litLength or matchLength. See seqStore_t. */
+typedef enum {
+    ZSTD_llt_none = 0,             /* no longLengthType */
+    ZSTD_llt_literalLength = 1,    /* represents a long literal */
+    ZSTD_llt_matchLength = 2       /* represents a long match */
+} ZSTD_longLengthType_e;
+
 typedef struct {
     seqDef* sequencesStart;
     seqDef* sequences;      /* ptr to end of sequences */
@@ -347,12 +297,12 @@ typedef struct {
     size_t maxNbSeq;
     size_t maxNbLit;
 
-    /* longLengthPos and longLengthID to allow us to represent either a single litLength or matchLength
+    /* longLengthPos and longLengthType to allow us to represent either a single litLength or matchLength
      * in the seqStore that has a value larger than U16 (if it exists). To do so, we increment
      * the existing value of the litLength or matchLength by 0x10000.
      */
-    U32   longLengthID;   /* 0 == no longLength; 1 == Represent the long literal; 2 == Represent the long match; */
-    U32   longLengthPos;  /* Index of the sequence to apply long length modification to */
+    ZSTD_longLengthType_e   longLengthType;
+    U32                     longLengthPos;  /* Index of the sequence to apply long length modification to */
 } seqStore_t;
 
 typedef struct {
@@ -362,18 +312,18 @@ typedef struct {
 
 /*
  * Returns the ZSTD_sequenceLength for the given sequences. It handles the decoding of long sequences
- * indicated by longLengthPos and longLengthID, and adds MINMATCH back to matchLength.
+ * indicated by longLengthPos and longLengthType, and adds MINMATCH back to matchLength.
  */
 MEM_STATIC ZSTD_sequenceLength ZSTD_getSequenceLength(seqStore_t const* seqStore, seqDef const* seq)
 {
     ZSTD_sequenceLength seqLen;
     seqLen.litLength = seq->litLength;
-    seqLen.matchLength = seq->matchLength + MINMATCH;
+    seqLen.matchLength = seq->mlBase + MINMATCH;
     if (seqStore->longLengthPos == (U32)(seq - seqStore->sequencesStart)) {
-        if (seqStore->longLengthID == 1) {
+        if (seqStore->longLengthType == ZSTD_llt_literalLength) {
             seqLen.litLength += 0xFFFF;
         }
-        if (seqStore->longLengthID == 2) {
+        if (seqStore->longLengthType == ZSTD_llt_matchLength) {
             seqLen.matchLength += 0xFFFF;
         }
     }
@@ -419,6 +369,41 @@ MEM_STATIC U32 ZSTD_highbit32(U32 val)   /* compress, dictBuilder, decodeCorpus
     }
 }
 
+/*
+ * Counts the number of trailing zeros of a `size_t`.
+ * Most compilers should support CTZ as a builtin. A backup
+ * implementation is provided if the builtin isn't supported, but
+ * it may not be terribly efficient.
+ */
+MEM_STATIC unsigned ZSTD_countTrailingZeros(size_t val)
+{
+    if (MEM_64bits()) {
+#       if (__GNUC__ >= 4)
+            return __builtin_ctzll((U64)val);
+#       else
+            static const int DeBruijnBytePos[64] = {  0,  1,  2,  7,  3, 13,  8, 19,
+                                                      4, 25, 14, 28,  9, 34, 20, 56,
+                                                      5, 17, 26, 54, 15, 41, 29, 43,
+                                                      10, 31, 38, 35, 21, 45, 49, 57,
+                                                      63,  6, 12, 18, 24, 27, 33, 55,
+                                                      16, 53, 40, 42, 30, 37, 44, 48,
+                                                      62, 11, 23, 32, 52, 39, 36, 47,
+                                                      61, 22, 51, 46, 60, 50, 59, 58 };
+            return DeBruijnBytePos[((U64)((val & -(long long)val) * 0x0218A392CDABBD3FULL)) >> 58];
+#       endif
+    } else { /* 32 bits */
+#       if (__GNUC__ >= 3)
+            return __builtin_ctz((U32)val);
+#       else
+            static const int DeBruijnBytePos[32] = {  0,  1, 28,  2, 29, 14, 24,  3,
+                                                     30, 22, 20, 15, 25, 17,  4,  8,
+                                                     31, 27, 13, 23, 21, 19, 16,  7,
+                                                     26, 12, 18,  6, 11,  5, 10,  9 };
+            return DeBruijnBytePos[((U32)((val & -(S32)val) * 0x077CB531U)) >> 27];
+#       endif
+    }
+}
+
 
 /* ZSTD_invalidateRepCodes() :
  * ensures next compression will not use repcodes from previous block.
@@ -445,6 +430,14 @@ size_t ZSTD_getcBlockSize(const void* src, size_t srcSize,
 size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx* dctx, int* nbSeqPtr,
                        const void* src, size_t srcSize);
 
+/*
+ * @returns true iff the CPU supports dynamic BMI2 dispatch.
+ */
+MEM_STATIC int ZSTD_cpuSupportsBmi2(void)
+{
+    ZSTD_cpuid_t cpuid = ZSTD_cpuid();
+    return ZSTD_cpuid_bmi1(cpuid) && ZSTD_cpuid_bmi2(cpuid);
+}
 
 
 #endif   /* ZSTD_CCOMMON_H_MODULE */
diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
new file mode 100644
index 000000000000..d9a76112ec3a
--- /dev/null
+++ b/lib/zstd/compress/clevels.h
@@ -0,0 +1,132 @@
+/*
+ * Copyright (c) Yann Collet, Facebook, Inc.
+ * All rights reserved.
+ *
+ * This source code is licensed under both the BSD-style license (found in the
+ * LICENSE file in the root directory of this source tree) and the GPLv2 (found
+ * in the COPYING file in the root directory of this source tree).
+ * You may select, at your option, one of the above-listed licenses.
+ */
+
+#ifndef ZSTD_CLEVELS_H
+#define ZSTD_CLEVELS_H
+
+#define ZSTD_STATIC_LINKING_ONLY  /* ZSTD_compressionParameters  */
+#include <linux/zstd.h>
+
+/*-=====  Pre-defined compression levels  =====-*/
+
+#define ZSTD_MAX_CLEVEL     22
+
+__attribute__((__unused__))
+
+static const ZSTD_compressionParameters ZSTD_defaultCParameters[4][ZSTD_MAX_CLEVEL+1] = {
+{   /* "default" - for any srcSize > 256 KB */
+    /* W,  C,  H,  S,  L, TL, strat */
+    { 19, 12, 13,  1,  6,  1, ZSTD_fast    },  /* base for negative levels */
+    { 19, 13, 14,  1,  7,  0, ZSTD_fast    },  /* level  1 */
+    { 20, 15, 16,  1,  6,  0, ZSTD_fast    },  /* level  2 */
+    { 21, 16, 17,  1,  5,  0, ZSTD_dfast   },  /* level  3 */
+    { 21, 18, 18,  1,  5,  0, ZSTD_dfast   },  /* level  4 */
+    { 21, 18, 19,  3,  5,  2, ZSTD_greedy  },  /* level  5 */
+    { 21, 18, 19,  3,  5,  4, ZSTD_lazy    },  /* level  6 */
+    { 21, 19, 20,  4,  5,  8, ZSTD_lazy    },  /* level  7 */
+    { 21, 19, 20,  4,  5, 16, ZSTD_lazy2   },  /* level  8 */
+    { 22, 20, 21,  4,  5, 16, ZSTD_lazy2   },  /* level  9 */
+    { 22, 21, 22,  5,  5, 16, ZSTD_lazy2   },  /* level 10 */
+    { 22, 21, 22,  6,  5, 16, ZSTD_lazy2   },  /* level 11 */
+    { 22, 22, 23,  6,  5, 32, ZSTD_lazy2   },  /* level 12 */
+    { 22, 22, 22,  4,  5, 32, ZSTD_btlazy2 },  /* level 13 */
+    { 22, 22, 23,  5,  5, 32, ZSTD_btlazy2 },  /* level 14 */
+    { 22, 23, 23,  6,  5, 32, ZSTD_btlazy2 },  /* level 15 */
+    { 22, 22, 22,  5,  5, 48, ZSTD_btopt   },  /* level 16 */
+    { 23, 23, 22,  5,  4, 64, ZSTD_btopt   },  /* level 17 */
+    { 23, 23, 22,  6,  3, 64, ZSTD_btultra },  /* level 18 */
+    { 23, 24, 22,  7,  3,256, ZSTD_btultra2},  /* level 19 */
+    { 25, 25, 23,  7,  3,256, ZSTD_btultra2},  /* level 20 */
+    { 26, 26, 24,  7,  3,512, ZSTD_btultra2},  /* level 21 */
+    { 27, 27, 25,  9,  3,999, ZSTD_btultra2},  /* level 22 */
+},
+{   /* for srcSize <= 256 KB */
+    /* W,  C,  H,  S,  L,  T, strat */
+    { 18, 12, 13,  1,  5,  1, ZSTD_fast    },  /* base for negative levels */
+    { 18, 13, 14,  1,  6,  0, ZSTD_fast    },  /* level  1 */
+    { 18, 14, 14,  1,  5,  0, ZSTD_dfast   },  /* level  2 */
+    { 18, 16, 16,  1,  4,  0, ZSTD_dfast   },  /* level  3 */
+    { 18, 16, 17,  3,  5,  2, ZSTD_greedy  },  /* level  4.*/
+    { 18, 17, 18,  5,  5,  2, ZSTD_greedy  },  /* level  5.*/
+    { 18, 18, 19,  3,  5,  4, ZSTD_lazy    },  /* level  6.*/
+    { 18, 18, 19,  4,  4,  4, ZSTD_lazy    },  /* level  7 */
+    { 18, 18, 19,  4,  4,  8, ZSTD_lazy2   },  /* level  8 */
+    { 18, 18, 19,  5,  4,  8, ZSTD_lazy2   },  /* level  9 */
+    { 18, 18, 19,  6,  4,  8, ZSTD_lazy2   },  /* level 10 */
+    { 18, 18, 19,  5,  4, 12, ZSTD_btlazy2 },  /* level 11.*/
+    { 18, 19, 19,  7,  4, 12, ZSTD_btlazy2 },  /* level 12.*/
+    { 18, 18, 19,  4,  4, 16, ZSTD_btopt   },  /* level 13 */
+    { 18, 18, 19,  4,  3, 32, ZSTD_btopt   },  /* level 14.*/
+    { 18, 18, 19,  6,  3,128, ZSTD_btopt   },  /* level 15.*/
+    { 18, 19, 19,  6,  3,128, ZSTD_btultra },  /* level 16.*/
+    { 18, 19, 19,  8,  3,256, ZSTD_btultra },  /* level 17.*/
+    { 18, 19, 19,  6,  3,128, ZSTD_btultra2},  /* level 18.*/
+    { 18, 19, 19,  8,  3,256, ZSTD_btultra2},  /* level 19.*/
+    { 18, 19, 19, 10,  3,512, ZSTD_btultra2},  /* level 20.*/
+    { 18, 19, 19, 12,  3,512, ZSTD_btultra2},  /* level 21.*/
+    { 18, 19, 19, 13,  3,999, ZSTD_btultra2},  /* level 22.*/
+},
+{   /* for srcSize <= 128 KB */
+    /* W,  C,  H,  S,  L,  T, strat */
+    { 17, 12, 12,  1,  5,  1, ZSTD_fast    },  /* base for negative levels */
+    { 17, 12, 13,  1,  6,  0, ZSTD_fast    },  /* level  1 */
+    { 17, 13, 15,  1,  5,  0, ZSTD_fast    },  /* level  2 */
+    { 17, 15, 16,  2,  5,  0, ZSTD_dfast   },  /* level  3 */
+    { 17, 17, 17,  2,  4,  0, ZSTD_dfast   },  /* level  4 */
+    { 17, 16, 17,  3,  4,  2, ZSTD_greedy  },  /* level  5 */
+    { 17, 16, 17,  3,  4,  4, ZSTD_lazy    },  /* level  6 */
+    { 17, 16, 17,  3,  4,  8, ZSTD_lazy2   },  /* level  7 */
+    { 17, 16, 17,  4,  4,  8, ZSTD_lazy2   },  /* level  8 */
+    { 17, 16, 17,  5,  4,  8, ZSTD_lazy2   },  /* level  9 */
+    { 17, 16, 17,  6,  4,  8, ZSTD_lazy2   },  /* level 10 */
+    { 17, 17, 17,  5,  4,  8, ZSTD_btlazy2 },  /* level 11 */
+    { 17, 18, 17,  7,  4, 12, ZSTD_btlazy2 },  /* level 12 */
+    { 17, 18, 17,  3,  4, 12, ZSTD_btopt   },  /* level 13.*/
+    { 17, 18, 17,  4,  3, 32, ZSTD_btopt   },  /* level 14.*/
+    { 17, 18, 17,  6,  3,256, ZSTD_btopt   },  /* level 15.*/
+    { 17, 18, 17,  6,  3,128, ZSTD_btultra },  /* level 16.*/
+    { 17, 18, 17,  8,  3,256, ZSTD_btultra },  /* level 17.*/
+    { 17, 18, 17, 10,  3,512, ZSTD_btultra },  /* level 18.*/
+    { 17, 18, 17,  5,  3,256, ZSTD_btultra2},  /* level 19.*/
+    { 17, 18, 17,  7,  3,512, ZSTD_btultra2},  /* level 20.*/
+    { 17, 18, 17,  9,  3,512, ZSTD_btultra2},  /* level 21.*/
+    { 17, 18, 17, 11,  3,999, ZSTD_btultra2},  /* level 22.*/
+},
+{   /* for srcSize <= 16 KB */
+    /* W,  C,  H,  S,  L,  T, strat */
+    { 14, 12, 13,  1,  5,  1, ZSTD_fast    },  /* base for negative levels */
+    { 14, 14, 15,  1,  5,  0, ZSTD_fast    },  /* level  1 */
+    { 14, 14, 15,  1,  4,  0, ZSTD_fast    },  /* level  2 */
+    { 14, 14, 15,  2,  4,  0, ZSTD_dfast   },  /* level  3 */
+    { 14, 14, 14,  4,  4,  2, ZSTD_greedy  },  /* level  4 */
+    { 14, 14, 14,  3,  4,  4, ZSTD_lazy    },  /* level  5.*/
+    { 14, 14, 14,  4,  4,  8, ZSTD_lazy2   },  /* level  6 */
+    { 14, 14, 14,  6,  4,  8, ZSTD_lazy2   },  /* level  7 */
+    { 14, 14, 14,  8,  4,  8, ZSTD_lazy2   },  /* level  8.*/
+    { 14, 15, 14,  5,  4,  8, ZSTD_btlazy2 },  /* level  9.*/
+    { 14, 15, 14,  9,  4,  8, ZSTD_btlazy2 },  /* level 10.*/
+    { 14, 15, 14,  3,  4, 12, ZSTD_btopt   },  /* level 11.*/
+    { 14, 15, 14,  4,  3, 24, ZSTD_btopt   },  /* level 12.*/
+    { 14, 15, 14,  5,  3, 32, ZSTD_btultra },  /* level 13.*/
+    { 14, 15, 15,  6,  3, 64, ZSTD_btultra },  /* level 14.*/
+    { 14, 15, 15,  7,  3,256, ZSTD_btultra },  /* level 15.*/
+    { 14, 15, 15,  5,  3, 48, ZSTD_btultra2},  /* level 16.*/
+    { 14, 15, 15,  6,  3,128, ZSTD_btultra2},  /* level 17.*/
+    { 14, 15, 15,  7,  3,256, ZSTD_btultra2},  /* level 18.*/
+    { 14, 15, 15,  8,  3,256, ZSTD_btultra2},  /* level 19.*/
+    { 14, 15, 15,  8,  3,512, ZSTD_btultra2},  /* level 20.*/
+    { 14, 15, 15,  9,  3,512, ZSTD_btultra2},  /* level 21.*/
+    { 14, 15, 15, 10,  3,999, ZSTD_btultra2},  /* level 22.*/
+},
+};
+
+
+
+#endif  /* ZSTD_CLEVELS_H */
diff --git a/lib/zstd/compress/fse_compress.c b/lib/zstd/compress/fse_compress.c
index 436985b620e5..ec5b1ca6d71a 100644
--- a/lib/zstd/compress/fse_compress.c
+++ b/lib/zstd/compress/fse_compress.c
@@ -75,13 +75,14 @@ size_t FSE_buildCTable_wksp(FSE_CTable* ct,
     void* const FSCT = ((U32*)ptr) + 1 /* header */ + (tableLog ? tableSize>>1 : 1) ;
     FSE_symbolCompressionTransform* const symbolTT = (FSE_symbolCompressionTransform*) (FSCT);
     U32 const step = FSE_TABLESTEP(tableSize);
+    U32 const maxSV1 = maxSymbolValue+1;
 
-    U32* cumul = (U32*)workSpace;
-    FSE_FUNCTION_TYPE* tableSymbol = (FSE_FUNCTION_TYPE*)(cumul + (maxSymbolValue + 2));
+    U16* cumul = (U16*)workSpace;   /* size = maxSV1 */
+    FSE_FUNCTION_TYPE* const tableSymbol = (FSE_FUNCTION_TYPE*)(cumul + (maxSV1+1));  /* size = tableSize */
 
     U32 highThreshold = tableSize-1;
 
-    if ((size_t)workSpace & 3) return ERROR(GENERIC); /* Must be 4 byte aligned */
+    assert(((size_t)workSpace & 1) == 0);  /* Must be 2 bytes-aligned */
     if (FSE_BUILD_CTABLE_WORKSPACE_SIZE(maxSymbolValue, tableLog) > wkspSize) return ERROR(tableLog_tooLarge);
     /* CTable header */
     tableU16[-2] = (U16) tableLog;
@@ -98,20 +99,61 @@ size_t FSE_buildCTable_wksp(FSE_CTable* ct,
     /* symbol start positions */
     {   U32 u;
         cumul[0] = 0;
-        for (u=1; u <= maxSymbolValue+1; u++) {
+        for (u=1; u <= maxSV1; u++) {
             if (normalizedCounter[u-1]==-1) {  /* Low proba symbol */
                 cumul[u] = cumul[u-1] + 1;
                 tableSymbol[highThreshold--] = (FSE_FUNCTION_TYPE)(u-1);
             } else {
-                cumul[u] = cumul[u-1] + normalizedCounter[u-1];
+                assert(normalizedCounter[u-1] >= 0);
+                cumul[u] = cumul[u-1] + (U16)normalizedCounter[u-1];
+                assert(cumul[u] >= cumul[u-1]);  /* no overflow */
         }   }
-        cumul[maxSymbolValue+1] = tableSize+1;
+        cumul[maxSV1] = (U16)(tableSize+1);
     }
 
     /* Spread symbols */
-    {   U32 position = 0;
+    if (highThreshold == tableSize - 1) {
+        /* Case for no low prob count symbols. Lay down 8 bytes at a time
+         * to reduce branch misses since we are operating on a small block
+         */
+        BYTE* const spread = tableSymbol + tableSize; /* size = tableSize + 8 (may write beyond tableSize) */
+        {   U64 const add = 0x0101010101010101ull;
+            size_t pos = 0;
+            U64 sv = 0;
+            U32 s;
+            for (s=0; s<maxSV1; ++s, sv += add) {
+                int i;
+                int const n = normalizedCounter[s];
+                MEM_write64(spread + pos, sv);
+                for (i = 8; i < n; i += 8) {
+                    MEM_write64(spread + pos + i, sv);
+                }
+                assert(n>=0);
+                pos += (size_t)n;
+            }
+        }
+        /* Spread symbols across the table. Lack of lowprob symbols means that
+         * we don't need variable sized inner loop, so we can unroll the loop and
+         * reduce branch misses.
+         */
+        {   size_t position = 0;
+            size_t s;
+            size_t const unroll = 2; /* Experimentally determined optimal unroll */
+            assert(tableSize % unroll == 0); /* FSE_MIN_TABLELOG is 5 */
+            for (s = 0; s < (size_t)tableSize; s += unroll) {
+                size_t u;
+                for (u = 0; u < unroll; ++u) {
+                    size_t const uPosition = (position + (u * step)) & tableMask;
+                    tableSymbol[uPosition] = spread[s + u];
+                }
+                position = (position + (unroll * step)) & tableMask;
+            }
+            assert(position == 0);   /* Must have initialized all positions */
+        }
+    } else {
+        U32 position = 0;
         U32 symbol;
-        for (symbol=0; symbol<=maxSymbolValue; symbol++) {
+        for (symbol=0; symbol<maxSV1; symbol++) {
             int nbOccurrences;
             int const freq = normalizedCounter[symbol];
             for (nbOccurrences=0; nbOccurrences<freq; nbOccurrences++) {
@@ -120,7 +162,6 @@ size_t FSE_buildCTable_wksp(FSE_CTable* ct,
                 while (position > highThreshold)
                     position = (position + step) & tableMask;   /* Low proba area */
         }   }
-
         assert(position==0);  /* Must have initialized all positions */
     }
 
@@ -144,16 +185,17 @@ size_t FSE_buildCTable_wksp(FSE_CTable* ct,
             case -1:
             case  1:
                 symbolTT[s].deltaNbBits = (tableLog << 16) - (1<<tableLog);
-                symbolTT[s].deltaFindState = total - 1;
+                assert(total <= INT_MAX);
+                symbolTT[s].deltaFindState = (int)(total - 1);
                 total ++;
                 break;
             default :
-                {
-                    U32 const maxBitsOut = tableLog - BIT_highbit32 (normalizedCounter[s]-1);
-                    U32 const minStatePlus = normalizedCounter[s] << maxBitsOut;
+                assert(normalizedCounter[s] > 1);
+                {   U32 const maxBitsOut = tableLog - BIT_highbit32 ((U32)normalizedCounter[s]-1);
+                    U32 const minStatePlus = (U32)normalizedCounter[s] << maxBitsOut;
                     symbolTT[s].deltaNbBits = (maxBitsOut << 16) - minStatePlus;
-                    symbolTT[s].deltaFindState = total - normalizedCounter[s];
-                    total +=  normalizedCounter[s];
+                    symbolTT[s].deltaFindState = (int)(total - (unsigned)normalizedCounter[s]);
+                    total +=  (unsigned)normalizedCounter[s];
     }   }   }   }
 
 #if 0  /* debug : symbol costs */
@@ -164,8 +206,7 @@ size_t FSE_buildCTable_wksp(FSE_CTable* ct,
                 symbol, normalizedCounter[symbol],
                 FSE_getMaxNbBits(symbolTT, symbol),
                 (double)FSE_bitCost(symbolTT, tableLog, symbol, 8) / 256);
-        }
-    }
+    }   }
 #endif
 
     return 0;
@@ -173,16 +214,18 @@ size_t FSE_buildCTable_wksp(FSE_CTable* ct,
 
 
 
-
 #ifndef FSE_COMMONDEFS_ONLY
 
-
 /*-**************************************************************
 *  FSE NCount encoding
 ****************************************************************/
 size_t FSE_NCountWriteBound(unsigned maxSymbolValue, unsigned tableLog)
 {
-    size_t const maxHeaderSize = (((maxSymbolValue+1) * tableLog) >> 3) + 3;
+    size_t const maxHeaderSize = (((maxSymbolValue+1) * tableLog
+                                   + 4 /* bitCount initialized at 4 */
+                                   + 2 /* first two symbols may use one additional bit each */) / 8)
+                                    + 1 /* round up to whole nb bytes */
+                                    + 2 /* additional two bytes for bitstream flush */;
     return maxSymbolValue ? maxHeaderSize : FSE_NCOUNTBOUND;  /* maxSymbolValue==0 ? use default */
 }
 
diff --git a/lib/zstd/compress/huf_compress.c b/lib/zstd/compress/huf_compress.c
index f76a526bfa54..74ef0db47621 100644
--- a/lib/zstd/compress/huf_compress.c
+++ b/lib/zstd/compress/huf_compress.c
@@ -50,6 +50,28 @@ unsigned HUF_optimalTableLog(unsigned maxTableLog, size_t srcSize, unsigned maxS
 /* *******************************************************
 *  HUF : Huffman block compression
 *********************************************************/
+#define HUF_WORKSPACE_MAX_ALIGNMENT 8
+
+static void* HUF_alignUpWorkspace(void* workspace, size_t* workspaceSizePtr, size_t align)
+{
+    size_t const mask = align - 1;
+    size_t const rem = (size_t)workspace & mask;
+    size_t const add = (align - rem) & mask;
+    BYTE* const aligned = (BYTE*)workspace + add;
+    assert((align & (align - 1)) == 0); /* pow 2 */
+    assert(align <= HUF_WORKSPACE_MAX_ALIGNMENT);
+    if (*workspaceSizePtr >= add) {
+        assert(add < align);
+        assert(((size_t)aligned & mask) == 0);
+        *workspaceSizePtr -= add;
+        return aligned;
+    } else {
+        *workspaceSizePtr = 0;
+        return NULL;
+    }
+}
+
+
 /* HUF_compressWeights() :
  * Same as FSE_compress(), but dedicated to huff0's weights compression.
  * The use case needs much less stack memory.
@@ -72,7 +94,7 @@ static size_t HUF_compressWeights(void* dst, size_t dstSize, const void* weightT
 
     unsigned maxSymbolValue = HUF_TABLELOG_MAX;
     U32 tableLog = MAX_FSE_TABLELOG_FOR_HUFF_HEADER;
-    HUF_CompressWeightsWksp* wksp = (HUF_CompressWeightsWksp*)workspace;
+    HUF_CompressWeightsWksp* wksp = (HUF_CompressWeightsWksp*)HUF_alignUpWorkspace(workspace, &workspaceSize, ZSTD_ALIGNOF(U32));
 
     if (workspaceSize < sizeof(HUF_CompressWeightsWksp)) return ERROR(GENERIC);
 
@@ -103,6 +125,40 @@ static size_t HUF_compressWeights(void* dst, size_t dstSize, const void* weightT
     return (size_t)(op-ostart);
 }
 
+static size_t HUF_getNbBits(HUF_CElt elt)
+{
+    return elt & 0xFF;
+}
+
+static size_t HUF_getNbBitsFast(HUF_CElt elt)
+{
+    return elt;
+}
+
+static size_t HUF_getValue(HUF_CElt elt)
+{
+    return elt & ~0xFF;
+}
+
+static size_t HUF_getValueFast(HUF_CElt elt)
+{
+    return elt;
+}
+
+static void HUF_setNbBits(HUF_CElt* elt, size_t nbBits)
+{
+    assert(nbBits <= HUF_TABLELOG_ABSOLUTEMAX);
+    *elt = nbBits;
+}
+
+static void HUF_setValue(HUF_CElt* elt, size_t value)
+{
+    size_t const nbBits = HUF_getNbBits(*elt);
+    if (nbBits > 0) {
+        assert((value >> nbBits) == 0);
+        *elt |= value << (sizeof(HUF_CElt) * 8 - nbBits);
+    }
+}
 
 typedef struct {
     HUF_CompressWeightsWksp wksp;
@@ -114,9 +170,10 @@ size_t HUF_writeCTable_wksp(void* dst, size_t maxDstSize,
                             const HUF_CElt* CTable, unsigned maxSymbolValue, unsigned huffLog,
                             void* workspace, size_t workspaceSize)
 {
+    HUF_CElt const* const ct = CTable + 1;
     BYTE* op = (BYTE*)dst;
     U32 n;
-    HUF_WriteCTableWksp* wksp = (HUF_WriteCTableWksp*)workspace;
+    HUF_WriteCTableWksp* wksp = (HUF_WriteCTableWksp*)HUF_alignUpWorkspace(workspace, &workspaceSize, ZSTD_ALIGNOF(U32));
 
     /* check conditions */
     if (workspaceSize < sizeof(HUF_WriteCTableWksp)) return ERROR(GENERIC);
@@ -127,9 +184,10 @@ size_t HUF_writeCTable_wksp(void* dst, size_t maxDstSize,
     for (n=1; n<huffLog+1; n++)
         wksp->bitsToWeight[n] = (BYTE)(huffLog + 1 - n);
     for (n=0; n<maxSymbolValue; n++)
-        wksp->huffWeight[n] = wksp->bitsToWeight[CTable[n].nbBits];
+        wksp->huffWeight[n] = wksp->bitsToWeight[HUF_getNbBits(ct[n])];
 
     /* attempt weights compression by FSE */
+    if (maxDstSize < 1) return ERROR(dstSize_tooSmall);
     {   CHECK_V_F(hSize, HUF_compressWeights(op+1, maxDstSize-1, wksp->huffWeight, maxSymbolValue, &wksp->wksp, sizeof(wksp->wksp)) );
         if ((hSize>1) & (hSize < maxSymbolValue/2)) {   /* FSE compressed */
             op[0] = (BYTE)hSize;
@@ -163,6 +221,7 @@ size_t HUF_readCTable (HUF_CElt* CTable, unsigned* maxSymbolValuePtr, const void
     U32 rankVal[HUF_TABLELOG_ABSOLUTEMAX + 1];   /* large enough for values from 0 to 16 */
     U32 tableLog = 0;
     U32 nbSymbols = 0;
+    HUF_CElt* const ct = CTable + 1;
 
     /* get symbol weights */
     CHECK_V_F(readSize, HUF_readStats(huffWeight, HUF_SYMBOLVALUE_MAX+1, rankVal, &nbSymbols, &tableLog, src, srcSize));
@@ -172,6 +231,8 @@ size_t HUF_readCTable (HUF_CElt* CTable, unsigned* maxSymbolValuePtr, const void
     if (tableLog > HUF_TABLELOG_MAX) return ERROR(tableLog_tooLarge);
     if (nbSymbols > *maxSymbolValuePtr+1) return ERROR(maxSymbolValue_tooSmall);
 
+    CTable[0] = tableLog;
+
     /* Prepare base value per rank */
     {   U32 n, nextRankStart = 0;
         for (n=1; n<=tableLog; n++) {
@@ -183,13 +244,13 @@ size_t HUF_readCTable (HUF_CElt* CTable, unsigned* maxSymbolValuePtr, const void
     /* fill nbBits */
     {   U32 n; for (n=0; n<nbSymbols; n++) {
             const U32 w = huffWeight[n];
-            CTable[n].nbBits = (BYTE)(tableLog + 1 - w) & -(w != 0);
+            HUF_setNbBits(ct + n, (BYTE)(tableLog + 1 - w) & -(w != 0));
     }   }
 
     /* fill val */
     {   U16 nbPerRank[HUF_TABLELOG_MAX+2]  = {0};  /* support w=0=>n=tableLog+1 */
         U16 valPerRank[HUF_TABLELOG_MAX+2] = {0};
-        { U32 n; for (n=0; n<nbSymbols; n++) nbPerRank[CTable[n].nbBits]++; }
+        { U32 n; for (n=0; n<nbSymbols; n++) nbPerRank[HUF_getNbBits(ct[n])]++; }
         /* determine stating value per rank */
         valPerRank[tableLog+1] = 0;   /* for w==0 */
         {   U16 min = 0;
@@ -199,18 +260,18 @@ size_t HUF_readCTable (HUF_CElt* CTable, unsigned* maxSymbolValuePtr, const void
                 min >>= 1;
         }   }
         /* assign value within rank, symbol order */
-        { U32 n; for (n=0; n<nbSymbols; n++) CTable[n].val = valPerRank[CTable[n].nbBits]++; }
+        { U32 n; for (n=0; n<nbSymbols; n++) HUF_setValue(ct + n, valPerRank[HUF_getNbBits(ct[n])]++); }
     }
 
     *maxSymbolValuePtr = nbSymbols - 1;
     return readSize;
 }
 
-U32 HUF_getNbBits(const void* symbolTable, U32 symbolValue)
+U32 HUF_getNbBitsFromCTable(HUF_CElt const* CTable, U32 symbolValue)
 {
-    const HUF_CElt* table = (const HUF_CElt*)symbolTable;
+    const HUF_CElt* ct = CTable + 1;
     assert(symbolValue <= HUF_SYMBOLVALUE_MAX);
-    return table[symbolValue].nbBits;
+    return (U32)HUF_getNbBits(ct[symbolValue]);
 }
 
 
@@ -364,22 +425,118 @@ static U32 HUF_setMaxHeight(nodeElt* huffNode, U32 lastNonNull, U32 maxNbBits)
 }
 
 typedef struct {
-    U32 base;
-    U32 curr;
+    U16 base;
+    U16 curr;
 } rankPos;
 
 typedef nodeElt huffNodeTable[HUF_CTABLE_WORKSPACE_SIZE_U32];
 
-#define RANK_POSITION_TABLE_SIZE 32
+/* Number of buckets available for HUF_sort() */
+#define RANK_POSITION_TABLE_SIZE 192
 
 typedef struct {
   huffNodeTable huffNodeTbl;
   rankPos rankPosition[RANK_POSITION_TABLE_SIZE];
 } HUF_buildCTable_wksp_tables;
 
+/* RANK_POSITION_DISTINCT_COUNT_CUTOFF == Cutoff point in HUF_sort() buckets for which we use log2 bucketing.
+ * Strategy is to use as many buckets as possible for representing distinct
+ * counts while using the remainder to represent all "large" counts.
+ *
+ * To satisfy this requirement for 192 buckets, we can do the following:
+ * Let buckets 0-166 represent distinct counts of [0, 166]
+ * Let buckets 166 to 192 represent all remaining counts up to RANK_POSITION_MAX_COUNT_LOG using log2 bucketing.
+ */
+#define RANK_POSITION_MAX_COUNT_LOG 32
+#define RANK_POSITION_LOG_BUCKETS_BEGIN (RANK_POSITION_TABLE_SIZE - 1) - RANK_POSITION_MAX_COUNT_LOG - 1 /* == 158 */
+#define RANK_POSITION_DISTINCT_COUNT_CUTOFF RANK_POSITION_LOG_BUCKETS_BEGIN + BIT_highbit32(RANK_POSITION_LOG_BUCKETS_BEGIN) /* == 166 */
+
+/* Return the appropriate bucket index for a given count. See definition of
+ * RANK_POSITION_DISTINCT_COUNT_CUTOFF for explanation of bucketing strategy.
+ */
+static U32 HUF_getIndex(U32 const count) {
+    return (count < RANK_POSITION_DISTINCT_COUNT_CUTOFF)
+        ? count
+        : BIT_highbit32(count) + RANK_POSITION_LOG_BUCKETS_BEGIN;
+}
+
+/* Helper swap function for HUF_quickSortPartition() */
+static void HUF_swapNodes(nodeElt* a, nodeElt* b) {
+	nodeElt tmp = *a;
+	*a = *b;
+	*b = tmp;
+}
+
+/* Returns 0 if the huffNode array is not sorted by descending count */
+MEM_STATIC int HUF_isSorted(nodeElt huffNode[], U32 const maxSymbolValue1) {
+    U32 i;
+    for (i = 1; i < maxSymbolValue1; ++i) {
+        if (huffNode[i].count > huffNode[i-1].count) {
+            return 0;
+        }
+    }
+    return 1;
+}
+
+/* Insertion sort by descending order */
+HINT_INLINE void HUF_insertionSort(nodeElt huffNode[], int const low, int const high) {
+    int i;
+    int const size = high-low+1;
+    huffNode += low;
+    for (i = 1; i < size; ++i) {
+        nodeElt const key = huffNode[i];
+        int j = i - 1;
+        while (j >= 0 && huffNode[j].count < key.count) {
+            huffNode[j + 1] = huffNode[j];
+            j--;
+        }
+        huffNode[j + 1] = key;
+    }
+}
+
+/* Pivot helper function for quicksort. */
+static int HUF_quickSortPartition(nodeElt arr[], int const low, int const high) {
+    /* Simply select rightmost element as pivot. "Better" selectors like
+     * median-of-three don't experimentally appear to have any benefit.
+     */
+    U32 const pivot = arr[high].count;
+    int i = low - 1;
+    int j = low;
+    for ( ; j < high; j++) {
+        if (arr[j].count > pivot) {
+            i++;
+            HUF_swapNodes(&arr[i], &arr[j]);
+        }
+    }
+    HUF_swapNodes(&arr[i + 1], &arr[high]);
+    return i + 1;
+}
+
+/* Classic quicksort by descending with partially iterative calls
+ * to reduce worst case callstack size.
+ */
+static void HUF_simpleQuickSort(nodeElt arr[], int low, int high) {
+    int const kInsertionSortThreshold = 8;
+    if (high - low < kInsertionSortThreshold) {
+        HUF_insertionSort(arr, low, high);
+        return;
+    }
+    while (low < high) {
+        int const idx = HUF_quickSortPartition(arr, low, high);
+        if (idx - low < high - idx) {
+            HUF_simpleQuickSort(arr, low, idx - 1);
+            low = idx + 1;
+        } else {
+            HUF_simpleQuickSort(arr, idx + 1, high);
+            high = idx - 1;
+        }
+    }
+}
+
 /*
  * HUF_sort():
  * Sorts the symbols [0, maxSymbolValue] by count[symbol] in decreasing order.
+ * This is a typical bucket sorting strategy that uses either quicksort or insertion sort to sort each bucket.
  *
  * @param[out] huffNode       Sorted symbols by decreasing count. Only members `.count` and `.byte` are filled.
  *                            Must have (maxSymbolValue + 1) entries.
@@ -387,44 +544,52 @@ typedef struct {
  * @param[in]  maxSymbolValue Maximum symbol value.
  * @param      rankPosition   This is a scratch workspace. Must have RANK_POSITION_TABLE_SIZE entries.
  */
-static void HUF_sort(nodeElt* huffNode, const unsigned* count, U32 maxSymbolValue, rankPos* rankPosition)
-{
-    int n;
-    int const maxSymbolValue1 = (int)maxSymbolValue + 1;
+static void HUF_sort(nodeElt huffNode[], const unsigned count[], U32 const maxSymbolValue, rankPos rankPosition[]) {
+    U32 n;
+    U32 const maxSymbolValue1 = maxSymbolValue+1;
 
     /* Compute base and set curr to base.
-     * For symbol s let lowerRank = BIT_highbit32(count[n]+1) and rank = lowerRank + 1.
-     * Then 2^lowerRank <= count[n]+1 <= 2^rank.
+     * For symbol s let lowerRank = HUF_getIndex(count[n]) and rank = lowerRank + 1.
+     * See HUF_getIndex to see bucketing strategy.
      * We attribute each symbol to lowerRank's base value, because we want to know where
      * each rank begins in the output, so for rank R we want to count ranks R+1 and above.
      */
     ZSTD_memset(rankPosition, 0, sizeof(*rankPosition) * RANK_POSITION_TABLE_SIZE);
     for (n = 0; n < maxSymbolValue1; ++n) {
-        U32 lowerRank = BIT_highbit32(count[n] + 1);
+        U32 lowerRank = HUF_getIndex(count[n]);
+        assert(lowerRank < RANK_POSITION_TABLE_SIZE - 1);
         rankPosition[lowerRank].base++;
     }
+
     assert(rankPosition[RANK_POSITION_TABLE_SIZE - 1].base == 0);
+    /* Set up the rankPosition table */
     for (n = RANK_POSITION_TABLE_SIZE - 1; n > 0; --n) {
         rankPosition[n-1].base += rankPosition[n].base;
         rankPosition[n-1].curr = rankPosition[n-1].base;
     }
-    /* Sort */
+
+    /* Insert each symbol into their appropriate bucket, setting up rankPosition table. */
     for (n = 0; n < maxSymbolValue1; ++n) {
         U32 const c = count[n];
-        U32 const r = BIT_highbit32(c+1) + 1;
-        U32 pos = rankPosition[r].curr++;
-        /* Insert into the correct position in the rank.
-         * We have at most 256 symbols, so this insertion should be fine.
-         */
-        while ((pos > rankPosition[r].base) && (c > huffNode[pos-1].count)) {
-            huffNode[pos] = huffNode[pos-1];
-            pos--;
-        }
+        U32 const r = HUF_getIndex(c) + 1;
+        U32 const pos = rankPosition[r].curr++;
+        assert(pos < maxSymbolValue1);
         huffNode[pos].count = c;
         huffNode[pos].byte  = (BYTE)n;
     }
-}
 
+    /* Sort each bucket. */
+    for (n = RANK_POSITION_DISTINCT_COUNT_CUTOFF; n < RANK_POSITION_TABLE_SIZE - 1; ++n) {
+        U32 const bucketSize = rankPosition[n].curr-rankPosition[n].base;
+        U32 const bucketStartIdx = rankPosition[n].base;
+        if (bucketSize > 1) {
+            assert(bucketStartIdx < maxSymbolValue1);
+            HUF_simpleQuickSort(huffNode + bucketStartIdx, 0, bucketSize-1);
+        }
+    }
+
+    assert(HUF_isSorted(huffNode, maxSymbolValue1));
+}
 
 /* HUF_buildCTable_wksp() :
  *  Same as HUF_buildCTable(), but using externally allocated scratch buffer.
@@ -487,6 +652,7 @@ static int HUF_buildTree(nodeElt* huffNode, U32 maxSymbolValue)
  */
 static void HUF_buildCTableFromTree(HUF_CElt* CTable, nodeElt const* huffNode, int nonNullRank, U32 maxSymbolValue, U32 maxNbBits)
 {
+    HUF_CElt* const ct = CTable + 1;
     /* fill result into ctable (val, nbBits) */
     int n;
     U16 nbPerRank[HUF_TABLELOG_MAX+1] = {0};
@@ -502,20 +668,20 @@ static void HUF_buildCTableFromTree(HUF_CElt* CTable, nodeElt const* huffNode, i
             min >>= 1;
     }   }
     for (n=0; n<alphabetSize; n++)
-        CTable[huffNode[n].byte].nbBits = huffNode[n].nbBits;   /* push nbBits per symbol, symbol order */
+        HUF_setNbBits(ct + huffNode[n].byte, huffNode[n].nbBits);   /* push nbBits per symbol, symbol order */
     for (n=0; n<alphabetSize; n++)
-        CTable[n].val = valPerRank[CTable[n].nbBits]++;   /* assign value within rank, symbol order */
+        HUF_setValue(ct + n, valPerRank[HUF_getNbBits(ct[n])]++);   /* assign value within rank, symbol order */
+    CTable[0] = maxNbBits;
 }
 
-size_t HUF_buildCTable_wksp (HUF_CElt* tree, const unsigned* count, U32 maxSymbolValue, U32 maxNbBits, void* workSpace, size_t wkspSize)
+size_t HUF_buildCTable_wksp (HUF_CElt* CTable, const unsigned* count, U32 maxSymbolValue, U32 maxNbBits, void* workSpace, size_t wkspSize)
 {
-    HUF_buildCTable_wksp_tables* const wksp_tables = (HUF_buildCTable_wksp_tables*)workSpace;
+    HUF_buildCTable_wksp_tables* const wksp_tables = (HUF_buildCTable_wksp_tables*)HUF_alignUpWorkspace(workSpace, &wkspSize, ZSTD_ALIGNOF(U32));
     nodeElt* const huffNode0 = wksp_tables->huffNodeTbl;
     nodeElt* const huffNode = huffNode0+1;
     int nonNullRank;
 
     /* safety checks */
-    if (((size_t)workSpace & 3) != 0) return ERROR(GENERIC);  /* must be aligned on 4-bytes boundaries */
     if (wkspSize < sizeof(HUF_buildCTable_wksp_tables))
       return ERROR(workSpace_tooSmall);
     if (maxNbBits == 0) maxNbBits = HUF_TABLELOG_DEFAULT;
@@ -533,99 +699,334 @@ size_t HUF_buildCTable_wksp (HUF_CElt* tree, const unsigned* count, U32 maxSymbo
     maxNbBits = HUF_setMaxHeight(huffNode, (U32)nonNullRank, maxNbBits);
     if (maxNbBits > HUF_TABLELOG_MAX) return ERROR(GENERIC);   /* check fit into table */
 
-    HUF_buildCTableFromTree(tree, huffNode, nonNullRank, maxSymbolValue, maxNbBits);
+    HUF_buildCTableFromTree(CTable, huffNode, nonNullRank, maxSymbolValue, maxNbBits);
 
     return maxNbBits;
 }
 
 size_t HUF_estimateCompressedSize(const HUF_CElt* CTable, const unsigned* count, unsigned maxSymbolValue)
 {
+    HUF_CElt const* ct = CTable + 1;
     size_t nbBits = 0;
     int s;
     for (s = 0; s <= (int)maxSymbolValue; ++s) {
-        nbBits += CTable[s].nbBits * count[s];
+        nbBits += HUF_getNbBits(ct[s]) * count[s];
     }
     return nbBits >> 3;
 }
 
 int HUF_validateCTable(const HUF_CElt* CTable, const unsigned* count, unsigned maxSymbolValue) {
+  HUF_CElt const* ct = CTable + 1;
   int bad = 0;
   int s;
   for (s = 0; s <= (int)maxSymbolValue; ++s) {
-    bad |= (count[s] != 0) & (CTable[s].nbBits == 0);
+    bad |= (count[s] != 0) & (HUF_getNbBits(ct[s]) == 0);
   }
   return !bad;
 }
 
 size_t HUF_compressBound(size_t size) { return HUF_COMPRESSBOUND(size); }
 
+/* HUF_CStream_t:
+ * Huffman uses its own BIT_CStream_t implementation.
+ * There are three major differences from BIT_CStream_t:
+ *   1. HUF_addBits() takes a HUF_CElt (size_t) which is
+ *      the pair (nbBits, value) in the format:
+ *      format:
+ *        - Bits [0, 4)            = nbBits
+ *        - Bits [4, 64 - nbBits)  = 0
+ *        - Bits [64 - nbBits, 64) = value
+ *   2. The bitContainer is built from the upper bits and
+ *      right shifted. E.g. to add a new value of N bits
+ *      you right shift the bitContainer by N, then or in
+ *      the new value into the N upper bits.
+ *   3. The bitstream has two bit containers. You can add
+ *      bits to the second container and merge them into
+ *      the first container.
+ */
+
+#define HUF_BITS_IN_CONTAINER (sizeof(size_t) * 8)
+
+typedef struct {
+    size_t bitContainer[2];
+    size_t bitPos[2];
+
+    BYTE* startPtr;
+    BYTE* ptr;
+    BYTE* endPtr;
+} HUF_CStream_t;
+
+/*! HUF_initCStream():
+ * Initializes the bitstream.
+ * @returns 0 or an error code.
+ */
+static size_t HUF_initCStream(HUF_CStream_t* bitC,
+                                  void* startPtr, size_t dstCapacity)
+{
+    ZSTD_memset(bitC, 0, sizeof(*bitC));
+    bitC->startPtr = (BYTE*)startPtr;
+    bitC->ptr = bitC->startPtr;
+    bitC->endPtr = bitC->startPtr + dstCapacity - sizeof(bitC->bitContainer[0]);
+    if (dstCapacity <= sizeof(bitC->bitContainer[0])) return ERROR(dstSize_tooSmall);
+    return 0;
+}
+
+/*! HUF_addBits():
+ * Adds the symbol stored in HUF_CElt elt to the bitstream.
+ *
+ * @param elt   The element we're adding. This is a (nbBits, value) pair.
+ *              See the HUF_CStream_t docs for the format.
+ * @param idx   Insert into the bitstream at this idx.
+ * @param kFast This is a template parameter. If the bitstream is guaranteed
+ *              to have at least 4 unused bits after this call it may be 1,
+ *              otherwise it must be 0. HUF_addBits() is faster when fast is set.
+ */
+FORCE_INLINE_TEMPLATE void HUF_addBits(HUF_CStream_t* bitC, HUF_CElt elt, int idx, int kFast)
+{
+    assert(idx <= 1);
+    assert(HUF_getNbBits(elt) <= HUF_TABLELOG_ABSOLUTEMAX);
+    /* This is efficient on x86-64 with BMI2 because shrx
+     * only reads the low 6 bits of the register. The compiler
+     * knows this and elides the mask. When fast is set,
+     * every operation can use the same value loaded from elt.
+     */
+    bitC->bitContainer[idx] >>= HUF_getNbBits(elt);
+    bitC->bitContainer[idx] |= kFast ? HUF_getValueFast(elt) : HUF_getValue(elt);
+    /* We only read the low 8 bits of bitC->bitPos[idx] so it
+     * doesn't matter that the high bits have noise from the value.
+     */
+    bitC->bitPos[idx] += HUF_getNbBitsFast(elt);
+    assert((bitC->bitPos[idx] & 0xFF) <= HUF_BITS_IN_CONTAINER);
+    /* The last 4-bits of elt are dirty if fast is set,
+     * so we must not be overwriting bits that have already been
+     * inserted into the bit container.
+     */
+#if DEBUGLEVEL >= 1
+    {
+        size_t const nbBits = HUF_getNbBits(elt);
+        size_t const dirtyBits = nbBits == 0 ? 0 : BIT_highbit32((U32)nbBits) + 1;
+        (void)dirtyBits;
+        /* Middle bits are 0. */
+        assert(((elt >> dirtyBits) << (dirtyBits + nbBits)) == 0);
+        /* We didn't overwrite any bits in the bit container. */
+        assert(!kFast || (bitC->bitPos[idx] & 0xFF) <= HUF_BITS_IN_CONTAINER);
+        (void)dirtyBits;
+    }
+#endif
+}
+
+FORCE_INLINE_TEMPLATE void HUF_zeroIndex1(HUF_CStream_t* bitC)
+{
+    bitC->bitContainer[1] = 0;
+    bitC->bitPos[1] = 0;
+}
+
+/*! HUF_mergeIndex1() :
+ * Merges the bit container @ index 1 into the bit container @ index 0
+ * and zeros the bit container @ index 1.
+ */
+FORCE_INLINE_TEMPLATE void HUF_mergeIndex1(HUF_CStream_t* bitC)
+{
+    assert((bitC->bitPos[1] & 0xFF) < HUF_BITS_IN_CONTAINER);
+    bitC->bitContainer[0] >>= (bitC->bitPos[1] & 0xFF);
+    bitC->bitContainer[0] |= bitC->bitContainer[1];
+    bitC->bitPos[0] += bitC->bitPos[1];
+    assert((bitC->bitPos[0] & 0xFF) <= HUF_BITS_IN_CONTAINER);
+}
+
+/*! HUF_flushBits() :
+* Flushes the bits in the bit container @ index 0.
+*
+* @post bitPos will be < 8.
+* @param kFast If kFast is set then we must know a-priori that
+*              the bit container will not overflow.
+*/
+FORCE_INLINE_TEMPLATE void HUF_flushBits(HUF_CStream_t* bitC, int kFast)
+{
+    /* The upper bits of bitPos are noisy, so we must mask by 0xFF. */
+    size_t const nbBits = bitC->bitPos[0] & 0xFF;
+    size_t const nbBytes = nbBits >> 3;
+    /* The top nbBits bits of bitContainer are the ones we need. */
+    size_t const bitContainer = bitC->bitContainer[0] >> (HUF_BITS_IN_CONTAINER - nbBits);
+    /* Mask bitPos to account for the bytes we consumed. */
+    bitC->bitPos[0] &= 7;
+    assert(nbBits > 0);
+    assert(nbBits <= sizeof(bitC->bitContainer[0]) * 8);
+    assert(bitC->ptr <= bitC->endPtr);
+    MEM_writeLEST(bitC->ptr, bitContainer);
+    bitC->ptr += nbBytes;
+    assert(!kFast || bitC->ptr <= bitC->endPtr);
+    if (!kFast && bitC->ptr > bitC->endPtr) bitC->ptr = bitC->endPtr;
+    /* bitContainer doesn't need to be modified because the leftover
+     * bits are already the top bitPos bits. And we don't care about
+     * noise in the lower values.
+     */
+}
+
+/*! HUF_endMark()
+ * @returns The Huffman stream end mark: A 1-bit value = 1.
+ */
+static HUF_CElt HUF_endMark(void)
+{
+    HUF_CElt endMark;
+    HUF_setNbBits(&endMark, 1);
+    HUF_setValue(&endMark, 1);
+    return endMark;
+}
+
+/*! HUF_closeCStream() :
+ *  @return Size of CStream, in bytes,
+ *          or 0 if it could not fit into dstBuffer */
+static size_t HUF_closeCStream(HUF_CStream_t* bitC)
+{
+    HUF_addBits(bitC, HUF_endMark(), /* idx */ 0, /* kFast */ 0);
+    HUF_flushBits(bitC, /* kFast */ 0);
+    {
+        size_t const nbBits = bitC->bitPos[0] & 0xFF;
+        if (bitC->ptr >= bitC->endPtr) return 0; /* overflow detected */
+        return (bitC->ptr - bitC->startPtr) + (nbBits > 0);
+    }
+}
+
 FORCE_INLINE_TEMPLATE void
-HUF_encodeSymbol(BIT_CStream_t* bitCPtr, U32 symbol, const HUF_CElt* CTable)
+HUF_encodeSymbol(HUF_CStream_t* bitCPtr, U32 symbol, const HUF_CElt* CTable, int idx, int fast)
 {
-    BIT_addBitsFast(bitCPtr, CTable[symbol].val, CTable[symbol].nbBits);
+    HUF_addBits(bitCPtr, CTable[symbol], idx, fast);
 }
 
-#define HUF_FLUSHBITS(s)  BIT_flushBits(s)
+FORCE_INLINE_TEMPLATE void
+HUF_compress1X_usingCTable_internal_body_loop(HUF_CStream_t* bitC,
+                                   const BYTE* ip, size_t srcSize,
+                                   const HUF_CElt* ct,
+                                   int kUnroll, int kFastFlush, int kLastFast)
+{
+    /* Join to kUnroll */
+    int n = (int)srcSize;
+    int rem = n % kUnroll;
+    if (rem > 0) {
+        for (; rem > 0; --rem) {
+            HUF_encodeSymbol(bitC, ip[--n], ct, 0, /* fast */ 0);
+        }
+        HUF_flushBits(bitC, kFastFlush);
+    }
+    assert(n % kUnroll == 0);
+
+    /* Join to 2 * kUnroll */
+    if (n % (2 * kUnroll)) {
+        int u;
+        for (u = 1; u < kUnroll; ++u) {
+            HUF_encodeSymbol(bitC, ip[n - u], ct, 0, 1);
+        }
+        HUF_encodeSymbol(bitC, ip[n - kUnroll], ct, 0, kLastFast);
+        HUF_flushBits(bitC, kFastFlush);
+        n -= kUnroll;
+    }
+    assert(n % (2 * kUnroll) == 0);
+
+    for (; n>0; n-= 2 * kUnroll) {
+        /* Encode kUnroll symbols into the bitstream @ index 0. */
+        int u;
+        for (u = 1; u < kUnroll; ++u) {
+            HUF_encodeSymbol(bitC, ip[n - u], ct, /* idx */ 0, /* fast */ 1);
+        }
+        HUF_encodeSymbol(bitC, ip[n - kUnroll], ct, /* idx */ 0, /* fast */ kLastFast);
+        HUF_flushBits(bitC, kFastFlush);
+        /* Encode kUnroll symbols into the bitstream @ index 1.
+         * This allows us to start filling the bit container
+         * without any data dependencies.
+         */
+        HUF_zeroIndex1(bitC);
+        for (u = 1; u < kUnroll; ++u) {
+            HUF_encodeSymbol(bitC, ip[n - kUnroll - u], ct, /* idx */ 1, /* fast */ 1);
+        }
+        HUF_encodeSymbol(bitC, ip[n - kUnroll - kUnroll], ct, /* idx */ 1, /* fast */ kLastFast);
+        /* Merge bitstream @ index 1 into the bitstream @ index 0 */
+        HUF_mergeIndex1(bitC);
+        HUF_flushBits(bitC, kFastFlush);
+    }
+    assert(n == 0);
+
+}
 
-#define HUF_FLUSHBITS_1(stream) \
-    if (sizeof((stream)->bitContainer)*8 < HUF_TABLELOG_MAX*2+7) HUF_FLUSHBITS(stream)
+/*
+ * Returns a tight upper bound on the output space needed by Huffman
+ * with 8 bytes buffer to handle over-writes. If the output is at least
+ * this large we don't need to do bounds checks during Huffman encoding.
+ */
+static size_t HUF_tightCompressBound(size_t srcSize, size_t tableLog)
+{
+    return ((srcSize * tableLog) >> 3) + 8;
+}
 
-#define HUF_FLUSHBITS_2(stream) \
-    if (sizeof((stream)->bitContainer)*8 < HUF_TABLELOG_MAX*4+7) HUF_FLUSHBITS(stream)
 
 FORCE_INLINE_TEMPLATE size_t
 HUF_compress1X_usingCTable_internal_body(void* dst, size_t dstSize,
                                    const void* src, size_t srcSize,
                                    const HUF_CElt* CTable)
 {
+    U32 const tableLog = (U32)CTable[0];
+    HUF_CElt const* ct = CTable + 1;
     const BYTE* ip = (const BYTE*) src;
     BYTE* const ostart = (BYTE*)dst;
     BYTE* const oend = ostart + dstSize;
     BYTE* op = ostart;
-    size_t n;
-    BIT_CStream_t bitC;
+    HUF_CStream_t bitC;
 
     /* init */
     if (dstSize < 8) return 0;   /* not enough space to compress */
-    { size_t const initErr = BIT_initCStream(&bitC, op, (size_t)(oend-op));
+    { size_t const initErr = HUF_initCStream(&bitC, op, (size_t)(oend-op));
       if (HUF_isError(initErr)) return 0; }
 
-    n = srcSize & ~3;  /* join to mod 4 */
-    switch (srcSize & 3)
-    {
-        case 3:
-            HUF_encodeSymbol(&bitC, ip[n+ 2], CTable);
-            HUF_FLUSHBITS_2(&bitC);
-            ZSTD_FALLTHROUGH;
-        case 2:
-            HUF_encodeSymbol(&bitC, ip[n+ 1], CTable);
-            HUF_FLUSHBITS_1(&bitC);
-            ZSTD_FALLTHROUGH;
-        case 1:
-            HUF_encodeSymbol(&bitC, ip[n+ 0], CTable);
-            HUF_FLUSHBITS(&bitC);
-            ZSTD_FALLTHROUGH;
-        case 0: ZSTD_FALLTHROUGH;
-        default: break;
-    }
-
-    for (; n>0; n-=4) {  /* note : n&3==0 at this stage */
-        HUF_encodeSymbol(&bitC, ip[n- 1], CTable);
-        HUF_FLUSHBITS_1(&bitC);
-        HUF_encodeSymbol(&bitC, ip[n- 2], CTable);
-        HUF_FLUSHBITS_2(&bitC);
-        HUF_encodeSymbol(&bitC, ip[n- 3], CTable);
-        HUF_FLUSHBITS_1(&bitC);
-        HUF_encodeSymbol(&bitC, ip[n- 4], CTable);
-        HUF_FLUSHBITS(&bitC);
-    }
-
-    return BIT_closeCStream(&bitC);
+    if (dstSize < HUF_tightCompressBound(srcSize, (size_t)tableLog) || tableLog > 11)
+        HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ MEM_32bits() ? 2 : 4, /* kFast */ 0, /* kLastFast */ 0);
+    else {
+        if (MEM_32bits()) {
+            switch (tableLog) {
+            case 11:
+                HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ 2, /* kFastFlush */ 1, /* kLastFast */ 0);
+                break;
+            case 10: ZSTD_FALLTHROUGH;
+            case 9: ZSTD_FALLTHROUGH;
+            case 8:
+                HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ 2, /* kFastFlush */ 1, /* kLastFast */ 1);
+                break;
+            case 7: ZSTD_FALLTHROUGH;
+            default:
+                HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ 3, /* kFastFlush */ 1, /* kLastFast */ 1);
+                break;
+            }
+        } else {
+            switch (tableLog) {
+            case 11:
+                HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ 5, /* kFastFlush */ 1, /* kLastFast */ 0);
+                break;
+            case 10:
+                HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ 5, /* kFastFlush */ 1, /* kLastFast */ 1);
+                break;
+            case 9:
+                HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ 6, /* kFastFlush */ 1, /* kLastFast */ 0);
+                break;
+            case 8:
+                HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ 7, /* kFastFlush */ 1, /* kLastFast */ 0);
+                break;
+            case 7:
+                HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ 8, /* kFastFlush */ 1, /* kLastFast */ 0);
+                break;
+            case 6: ZSTD_FALLTHROUGH;
+            default:
+                HUF_compress1X_usingCTable_internal_body_loop(&bitC, ip, srcSize, ct, /* kUnroll */ 9, /* kFastFlush */ 1, /* kLastFast */ 1);
+                break;
+            }
+        }
+    }
+    assert(bitC.ptr <= bitC.endPtr);
+
+    return HUF_closeCStream(&bitC);
 }
 
 #if DYNAMIC_BMI2
 
-static TARGET_ATTRIBUTE("bmi2") size_t
+static BMI2_TARGET_ATTRIBUTE size_t
 HUF_compress1X_usingCTable_internal_bmi2(void* dst, size_t dstSize,
                                    const void* src, size_t srcSize,
                                    const HUF_CElt* CTable)
@@ -667,9 +1068,13 @@ HUF_compress1X_usingCTable_internal(void* dst, size_t dstSize,
 
 size_t HUF_compress1X_usingCTable(void* dst, size_t dstSize, const void* src, size_t srcSize, const HUF_CElt* CTable)
 {
-    return HUF_compress1X_usingCTable_internal(dst, dstSize, src, srcSize, CTable, /* bmi2 */ 0);
+    return HUF_compress1X_usingCTable_bmi2(dst, dstSize, src, srcSize, CTable, /* bmi2 */ 0);
 }
 
+size_t HUF_compress1X_usingCTable_bmi2(void* dst, size_t dstSize, const void* src, size_t srcSize, const HUF_CElt* CTable, int bmi2)
+{
+    return HUF_compress1X_usingCTable_internal(dst, dstSize, src, srcSize, CTable, bmi2);
+}
 
 static size_t
 HUF_compress4X_usingCTable_internal(void* dst, size_t dstSize,
@@ -689,8 +1094,7 @@ HUF_compress4X_usingCTable_internal(void* dst, size_t dstSize,
 
     assert(op <= oend);
     {   CHECK_V_F(cSize, HUF_compress1X_usingCTable_internal(op, (size_t)(oend-op), ip, segmentSize, CTable, bmi2) );
-        if (cSize==0) return 0;
-        assert(cSize <= 65535);
+        if (cSize == 0 || cSize > 65535) return 0;
         MEM_writeLE16(ostart, (U16)cSize);
         op += cSize;
     }
@@ -698,8 +1102,7 @@ HUF_compress4X_usingCTable_internal(void* dst, size_t dstSize,
     ip += segmentSize;
     assert(op <= oend);
     {   CHECK_V_F(cSize, HUF_compress1X_usingCTable_internal(op, (size_t)(oend-op), ip, segmentSize, CTable, bmi2) );
-        if (cSize==0) return 0;
-        assert(cSize <= 65535);
+        if (cSize == 0 || cSize > 65535) return 0;
         MEM_writeLE16(ostart+2, (U16)cSize);
         op += cSize;
     }
@@ -707,8 +1110,7 @@ HUF_compress4X_usingCTable_internal(void* dst, size_t dstSize,
     ip += segmentSize;
     assert(op <= oend);
     {   CHECK_V_F(cSize, HUF_compress1X_usingCTable_internal(op, (size_t)(oend-op), ip, segmentSize, CTable, bmi2) );
-        if (cSize==0) return 0;
-        assert(cSize <= 65535);
+        if (cSize == 0 || cSize > 65535) return 0;
         MEM_writeLE16(ostart+4, (U16)cSize);
         op += cSize;
     }
@@ -717,7 +1119,7 @@ HUF_compress4X_usingCTable_internal(void* dst, size_t dstSize,
     assert(op <= oend);
     assert(ip <= iend);
     {   CHECK_V_F(cSize, HUF_compress1X_usingCTable_internal(op, (size_t)(oend-op), ip, (size_t)(iend-ip), CTable, bmi2) );
-        if (cSize==0) return 0;
+        if (cSize == 0 || cSize > 65535) return 0;
         op += cSize;
     }
 
@@ -726,7 +1128,12 @@ HUF_compress4X_usingCTable_internal(void* dst, size_t dstSize,
 
 size_t HUF_compress4X_usingCTable(void* dst, size_t dstSize, const void* src, size_t srcSize, const HUF_CElt* CTable)
 {
-    return HUF_compress4X_usingCTable_internal(dst, dstSize, src, srcSize, CTable, /* bmi2 */ 0);
+    return HUF_compress4X_usingCTable_bmi2(dst, dstSize, src, srcSize, CTable, /* bmi2 */ 0);
+}
+
+size_t HUF_compress4X_usingCTable_bmi2(void* dst, size_t dstSize, const void* src, size_t srcSize, const HUF_CElt* CTable, int bmi2)
+{
+    return HUF_compress4X_usingCTable_internal(dst, dstSize, src, srcSize, CTable, bmi2);
 }
 
 typedef enum { HUF_singleStream, HUF_fourStreams } HUF_nbStreams_e;
@@ -750,35 +1157,38 @@ static size_t HUF_compressCTable_internal(
 
 typedef struct {
     unsigned count[HUF_SYMBOLVALUE_MAX + 1];
-    HUF_CElt CTable[HUF_SYMBOLVALUE_MAX + 1];
+    HUF_CElt CTable[HUF_CTABLE_SIZE_ST(HUF_SYMBOLVALUE_MAX)];
     union {
         HUF_buildCTable_wksp_tables buildCTable_wksp;
         HUF_WriteCTableWksp writeCTable_wksp;
+        U32 hist_wksp[HIST_WKSP_SIZE_U32];
     } wksps;
 } HUF_compress_tables_t;
 
+#define SUSPECT_INCOMPRESSIBLE_SAMPLE_SIZE 4096
+#define SUSPECT_INCOMPRESSIBLE_SAMPLE_RATIO 10  /* Must be >= 2 */
+
 /* HUF_compress_internal() :
  * `workSpace_align4` must be aligned on 4-bytes boundaries,
- * and occupies the same space as a table of HUF_WORKSPACE_SIZE_U32 unsigned */
+ * and occupies the same space as a table of HUF_WORKSPACE_SIZE_U64 unsigned */
 static size_t
 HUF_compress_internal (void* dst, size_t dstSize,
                  const void* src, size_t srcSize,
                        unsigned maxSymbolValue, unsigned huffLog,
                        HUF_nbStreams_e nbStreams,
-                       void* workSpace_align4, size_t wkspSize,
+                       void* workSpace, size_t wkspSize,
                        HUF_CElt* oldHufTable, HUF_repeat* repeat, int preferRepeat,
-                 const int bmi2)
+                 const int bmi2, unsigned suspectUncompressible)
 {
-    HUF_compress_tables_t* const table = (HUF_compress_tables_t*)workSpace_align4;
+    HUF_compress_tables_t* const table = (HUF_compress_tables_t*)HUF_alignUpWorkspace(workSpace, &wkspSize, ZSTD_ALIGNOF(size_t));
     BYTE* const ostart = (BYTE*)dst;
     BYTE* const oend = ostart + dstSize;
     BYTE* op = ostart;
 
-    HUF_STATIC_ASSERT(sizeof(*table) <= HUF_WORKSPACE_SIZE);
-    assert(((size_t)workSpace_align4 & 3) == 0);   /* must be aligned on 4-bytes boundaries */
+    HUF_STATIC_ASSERT(sizeof(*table) + HUF_WORKSPACE_MAX_ALIGNMENT <= HUF_WORKSPACE_SIZE);
 
     /* checks & inits */
-    if (wkspSize < HUF_WORKSPACE_SIZE) return ERROR(workSpace_tooSmall);
+    if (wkspSize < sizeof(*table)) return ERROR(workSpace_tooSmall);
     if (!srcSize) return 0;  /* Uncompressed */
     if (!dstSize) return 0;  /* cannot fit anything within dst budget */
     if (srcSize > HUF_BLOCKSIZE_MAX) return ERROR(srcSize_wrong);   /* current block size limit */
@@ -794,8 +1204,23 @@ HUF_compress_internal (void* dst, size_t dstSize,
                                            nbStreams, oldHufTable, bmi2);
     }
 
+    /* If uncompressible data is suspected, do a smaller sampling first */
+    DEBUG_STATIC_ASSERT(SUSPECT_INCOMPRESSIBLE_SAMPLE_RATIO >= 2);
+    if (suspectUncompressible && srcSize >= (SUSPECT_INCOMPRESSIBLE_SAMPLE_SIZE * SUSPECT_INCOMPRESSIBLE_SAMPLE_RATIO)) {
+        size_t largestTotal = 0;
+        {   unsigned maxSymbolValueBegin = maxSymbolValue;
+            CHECK_V_F(largestBegin, HIST_count_simple (table->count, &maxSymbolValueBegin, (const BYTE*)src, SUSPECT_INCOMPRESSIBLE_SAMPLE_SIZE) );
+            largestTotal += largestBegin;
+        }
+        {   unsigned maxSymbolValueEnd = maxSymbolValue;
+            CHECK_V_F(largestEnd, HIST_count_simple (table->count, &maxSymbolValueEnd, (const BYTE*)src + srcSize - SUSPECT_INCOMPRESSIBLE_SAMPLE_SIZE, SUSPECT_INCOMPRESSIBLE_SAMPLE_SIZE) );
+            largestTotal += largestEnd;
+        }
+        if (largestTotal <= ((2 * SUSPECT_INCOMPRESSIBLE_SAMPLE_SIZE) >> 7)+4) return 0;   /* heuristic : probably not compressible enough */
+    }
+
     /* Scan input and build symbol stats */
-    {   CHECK_V_F(largest, HIST_count_wksp (table->count, &maxSymbolValue, (const BYTE*)src, srcSize, workSpace_align4, wkspSize) );
+    {   CHECK_V_F(largest, HIST_count_wksp (table->count, &maxSymbolValue, (const BYTE*)src, srcSize, table->wksps.hist_wksp, sizeof(table->wksps.hist_wksp)) );
         if (largest == srcSize) { *ostart = ((const BYTE*)src)[0]; return 1; }   /* single symbol, rle */
         if (largest <= (srcSize >> 7)+4) return 0;   /* heuristic : probably not compressible enough */
     }
@@ -820,9 +1245,12 @@ HUF_compress_internal (void* dst, size_t dstSize,
                                             &table->wksps.buildCTable_wksp, sizeof(table->wksps.buildCTable_wksp));
         CHECK_F(maxBits);
         huffLog = (U32)maxBits;
-        /* Zero unused symbols in CTable, so we can check it for validity */
-        ZSTD_memset(table->CTable + (maxSymbolValue + 1), 0,
-               sizeof(table->CTable) - ((maxSymbolValue + 1) * sizeof(HUF_CElt)));
+    }
+    /* Zero unused symbols in CTable, so we can check it for validity */
+    {
+        size_t const ctableSize = HUF_CTABLE_SIZE_ST(maxSymbolValue);
+        size_t const unusedSize = sizeof(table->CTable) - ctableSize * sizeof(HUF_CElt);
+        ZSTD_memset(table->CTable + ctableSize, 0, unusedSize);
     }
 
     /* Write table description header */
@@ -859,19 +1287,20 @@ size_t HUF_compress1X_wksp (void* dst, size_t dstSize,
     return HUF_compress_internal(dst, dstSize, src, srcSize,
                                  maxSymbolValue, huffLog, HUF_singleStream,
                                  workSpace, wkspSize,
-                                 NULL, NULL, 0, 0 /*bmi2*/);
+                                 NULL, NULL, 0, 0 /*bmi2*/, 0);
 }
 
 size_t HUF_compress1X_repeat (void* dst, size_t dstSize,
                       const void* src, size_t srcSize,
                       unsigned maxSymbolValue, unsigned huffLog,
                       void* workSpace, size_t wkspSize,
-                      HUF_CElt* hufTable, HUF_repeat* repeat, int preferRepeat, int bmi2)
+                      HUF_CElt* hufTable, HUF_repeat* repeat, int preferRepeat,
+                      int bmi2, unsigned suspectUncompressible)
 {
     return HUF_compress_internal(dst, dstSize, src, srcSize,
                                  maxSymbolValue, huffLog, HUF_singleStream,
                                  workSpace, wkspSize, hufTable,
-                                 repeat, preferRepeat, bmi2);
+                                 repeat, preferRepeat, bmi2, suspectUncompressible);
 }
 
 /* HUF_compress4X_repeat():
@@ -885,21 +1314,22 @@ size_t HUF_compress4X_wksp (void* dst, size_t dstSize,
     return HUF_compress_internal(dst, dstSize, src, srcSize,
                                  maxSymbolValue, huffLog, HUF_fourStreams,
                                  workSpace, wkspSize,
-                                 NULL, NULL, 0, 0 /*bmi2*/);
+                                 NULL, NULL, 0, 0 /*bmi2*/, 0);
 }
 
 /* HUF_compress4X_repeat():
  * compress input using 4 streams.
+ * consider skipping quickly
  * re-use an existing huffman compression table */
 size_t HUF_compress4X_repeat (void* dst, size_t dstSize,
                       const void* src, size_t srcSize,
                       unsigned maxSymbolValue, unsigned huffLog,
                       void* workSpace, size_t wkspSize,
-                      HUF_CElt* hufTable, HUF_repeat* repeat, int preferRepeat, int bmi2)
+                      HUF_CElt* hufTable, HUF_repeat* repeat, int preferRepeat, int bmi2, unsigned suspectUncompressible)
 {
     return HUF_compress_internal(dst, dstSize, src, srcSize,
                                  maxSymbolValue, huffLog, HUF_fourStreams,
                                  workSpace, wkspSize,
-                                 hufTable, repeat, preferRepeat, bmi2);
+                                 hufTable, repeat, preferRepeat, bmi2, suspectUncompressible);
 }
 
diff --git a/lib/zstd/compress/zstd_compress.c b/lib/zstd/compress/zstd_compress.c
index a4e916008b3a..f620cafca633 100644
--- a/lib/zstd/compress/zstd_compress.c
+++ b/lib/zstd/compress/zstd_compress.c
@@ -12,7 +12,6 @@
 *  Dependencies
 ***************************************/
 #include "../common/zstd_deps.h"  /* INT_MAX, ZSTD_memset, ZSTD_memcpy */
-#include "../common/cpu.h"
 #include "../common/mem.h"
 #include "hist.h"           /* HIST_countFast_wksp */
 #define FSE_STATIC_LINKING_ONLY   /* FSE_encodeSymbol */
@@ -39,6 +38,18 @@
  * Note that functions with explicit context such as ZSTD_compressCCtx() are unaffected.
  */
 
+/*!
+ * ZSTD_HASHLOG3_MAX :
+ * Maximum size of the hash table dedicated to find 3-bytes matches,
+ * in log format, aka 17 => 1 << 17 == 128Ki positions.
+ * This structure is only used in zstd_opt.
+ * Since allocation is centralized for all strategies, it has to be known here.
+ * The actual (selected) size of the hash table is then stored in ZSTD_matchState_t.hashLog3,
+ * so that zstd_opt.c doesn't need to know about this constant.
+ */
+#ifndef ZSTD_HASHLOG3_MAX
+#  define ZSTD_HASHLOG3_MAX 17
+#endif
 
 /*-*************************************
 *  Helper functions
@@ -69,6 +80,10 @@ struct ZSTD_CDict_s {
     ZSTD_customMem customMem;
     U32 dictID;
     int compressionLevel; /* 0 indicates that advanced API was used to select CDict params */
+    ZSTD_paramSwitch_e useRowMatchFinder; /* Indicates whether the CDict was created with params that would use
+                                           * row-based matchfinder. Unless the cdict is reloaded, we will use
+                                           * the same greedy/lazy matchfinder at compression time.
+                                           */
 };  /* typedef'd to ZSTD_CDict within "zstd.h" */
 
 ZSTD_CCtx* ZSTD_createCCtx(void)
@@ -81,7 +96,7 @@ static void ZSTD_initCCtx(ZSTD_CCtx* cctx, ZSTD_customMem memManager)
     assert(cctx != NULL);
     ZSTD_memset(cctx, 0, sizeof(*cctx));
     cctx->customMem = memManager;
-    cctx->bmi2 = ZSTD_cpuid_bmi2(ZSTD_cpuid());
+    cctx->bmi2 = ZSTD_cpuSupportsBmi2();
     {   size_t const err = ZSTD_CCtx_reset(cctx, ZSTD_reset_parameters);
         assert(!ZSTD_isError(err));
         (void)err;
@@ -192,12 +207,64 @@ size_t ZSTD_sizeof_CStream(const ZSTD_CStream* zcs)
 /* private API call, for dictBuilder only */
 const seqStore_t* ZSTD_getSeqStore(const ZSTD_CCtx* ctx) { return &(ctx->seqStore); }
 
+/* Returns true if the strategy supports using a row based matchfinder */
+static int ZSTD_rowMatchFinderSupported(const ZSTD_strategy strategy) {
+    return (strategy >= ZSTD_greedy && strategy <= ZSTD_lazy2);
+}
+
+/* Returns true if the strategy and useRowMatchFinder mode indicate that we will use the row based matchfinder
+ * for this compression.
+ */
+static int ZSTD_rowMatchFinderUsed(const ZSTD_strategy strategy, const ZSTD_paramSwitch_e mode) {
+    assert(mode != ZSTD_ps_auto);
+    return ZSTD_rowMatchFinderSupported(strategy) && (mode == ZSTD_ps_enable);
+}
+
+/* Returns row matchfinder usage given an initial mode and cParams */
+static ZSTD_paramSwitch_e ZSTD_resolveRowMatchFinderMode(ZSTD_paramSwitch_e mode,
+                                                         const ZSTD_compressionParameters* const cParams) {
+#if defined(ZSTD_ARCH_X86_SSE2) || defined(ZSTD_ARCH_ARM_NEON)
+    int const kHasSIMD128 = 1;
+#else
+    int const kHasSIMD128 = 0;
+#endif
+    if (mode != ZSTD_ps_auto) return mode; /* if requested enabled, but no SIMD, we still will use row matchfinder */
+    mode = ZSTD_ps_disable;
+    if (!ZSTD_rowMatchFinderSupported(cParams->strategy)) return mode;
+    if (kHasSIMD128) {
+        if (cParams->windowLog > 14) mode = ZSTD_ps_enable;
+    } else {
+        if (cParams->windowLog > 17) mode = ZSTD_ps_enable;
+    }
+    return mode;
+}
+
+/* Returns block splitter usage (generally speaking, when using slower/stronger compression modes) */
+static ZSTD_paramSwitch_e ZSTD_resolveBlockSplitterMode(ZSTD_paramSwitch_e mode,
+                                                        const ZSTD_compressionParameters* const cParams) {
+    if (mode != ZSTD_ps_auto) return mode;
+    return (cParams->strategy >= ZSTD_btopt && cParams->windowLog >= 17) ? ZSTD_ps_enable : ZSTD_ps_disable;
+}
+
+/* Returns 1 if the arguments indicate that we should allocate a chainTable, 0 otherwise */
+static int ZSTD_allocateChainTable(const ZSTD_strategy strategy,
+                                   const ZSTD_paramSwitch_e useRowMatchFinder,
+                                   const U32 forDDSDict) {
+    assert(useRowMatchFinder != ZSTD_ps_auto);
+    /* We always should allocate a chaintable if we are allocating a matchstate for a DDS dictionary matchstate.
+     * We do not allocate a chaintable if we are using ZSTD_fast, or are using the row-based matchfinder.
+     */
+    return forDDSDict || ((strategy != ZSTD_fast) && !ZSTD_rowMatchFinderUsed(strategy, useRowMatchFinder));
+}
+
 /* Returns 1 if compression parameters are such that we should
  * enable long distance matching (wlog >= 27, strategy >= btopt).
  * Returns 0 otherwise.
  */
-static U32 ZSTD_CParams_shouldEnableLdm(const ZSTD_compressionParameters* const cParams) {
-    return cParams->strategy >= ZSTD_btopt && cParams->windowLog >= 27;
+static ZSTD_paramSwitch_e ZSTD_resolveEnableLdm(ZSTD_paramSwitch_e mode,
+                                 const ZSTD_compressionParameters* const cParams) {
+    if (mode != ZSTD_ps_auto) return mode;
+    return (cParams->strategy >= ZSTD_btopt && cParams->windowLog >= 27) ? ZSTD_ps_enable : ZSTD_ps_disable;
 }
 
 static ZSTD_CCtx_params ZSTD_makeCCtxParamsFromCParams(
@@ -208,15 +275,15 @@ static ZSTD_CCtx_params ZSTD_makeCCtxParamsFromCParams(
     ZSTD_CCtxParams_init(&cctxParams, ZSTD_CLEVEL_DEFAULT);
     cctxParams.cParams = cParams;
 
-    if (ZSTD_CParams_shouldEnableLdm(&cParams)) {
-        DEBUGLOG(4, "ZSTD_makeCCtxParamsFromCParams(): Including LDM into cctx params");
-        cctxParams.ldmParams.enableLdm = 1;
-        /* LDM is enabled by default for optimal parser and window size >= 128MB */
+    /* Adjust advanced params according to cParams */
+    cctxParams.ldmParams.enableLdm = ZSTD_resolveEnableLdm(cctxParams.ldmParams.enableLdm, &cParams);
+    if (cctxParams.ldmParams.enableLdm == ZSTD_ps_enable) {
         ZSTD_ldm_adjustParameters(&cctxParams.ldmParams, &cParams);
         assert(cctxParams.ldmParams.hashLog >= cctxParams.ldmParams.bucketSizeLog);
         assert(cctxParams.ldmParams.hashRateLog < 32);
     }
-
+    cctxParams.useBlockSplitter = ZSTD_resolveBlockSplitterMode(cctxParams.useBlockSplitter, &cParams);
+    cctxParams.useRowMatchFinder = ZSTD_resolveRowMatchFinderMode(cctxParams.useRowMatchFinder, &cParams);
     assert(!ZSTD_checkCParams(cParams));
     return cctxParams;
 }
@@ -275,6 +342,11 @@ static void ZSTD_CCtxParams_init_internal(ZSTD_CCtx_params* cctxParams, ZSTD_par
      * But, set it for tracing anyway.
      */
     cctxParams->compressionLevel = compressionLevel;
+    cctxParams->useRowMatchFinder = ZSTD_resolveRowMatchFinderMode(cctxParams->useRowMatchFinder, &params->cParams);
+    cctxParams->useBlockSplitter = ZSTD_resolveBlockSplitterMode(cctxParams->useBlockSplitter, &params->cParams);
+    cctxParams->ldmParams.enableLdm = ZSTD_resolveEnableLdm(cctxParams->ldmParams.enableLdm, &params->cParams);
+    DEBUGLOG(4, "ZSTD_CCtxParams_init_internal: useRowMatchFinder=%d, useBlockSplitter=%d ldm=%d",
+                cctxParams->useRowMatchFinder, cctxParams->useBlockSplitter, cctxParams->ldmParams.enableLdm);
 }
 
 size_t ZSTD_CCtxParams_init_advanced(ZSTD_CCtx_params* cctxParams, ZSTD_parameters params)
@@ -431,9 +503,9 @@ ZSTD_bounds ZSTD_cParam_getBounds(ZSTD_cParameter param)
         return bounds;
 
     case ZSTD_c_literalCompressionMode:
-        ZSTD_STATIC_ASSERT(ZSTD_lcm_auto < ZSTD_lcm_huffman && ZSTD_lcm_huffman < ZSTD_lcm_uncompressed);
-        bounds.lowerBound = ZSTD_lcm_auto;
-        bounds.upperBound = ZSTD_lcm_uncompressed;
+        ZSTD_STATIC_ASSERT(ZSTD_ps_auto < ZSTD_ps_enable && ZSTD_ps_enable < ZSTD_ps_disable);
+        bounds.lowerBound = (int)ZSTD_ps_auto;
+        bounds.upperBound = (int)ZSTD_ps_disable;
         return bounds;
 
     case ZSTD_c_targetCBlockSize:
@@ -462,6 +534,21 @@ ZSTD_bounds ZSTD_cParam_getBounds(ZSTD_cParameter param)
         bounds.upperBound = 1;
         return bounds;
 
+    case ZSTD_c_useBlockSplitter:
+        bounds.lowerBound = (int)ZSTD_ps_auto;
+        bounds.upperBound = (int)ZSTD_ps_disable;
+        return bounds;
+
+    case ZSTD_c_useRowMatchFinder:
+        bounds.lowerBound = (int)ZSTD_ps_auto;
+        bounds.upperBound = (int)ZSTD_ps_disable;
+        return bounds;
+
+    case ZSTD_c_deterministicRefPrefix:
+        bounds.lowerBound = 0;
+        bounds.upperBound = 1;
+        return bounds;
+
     default:
         bounds.error = ERROR(parameter_unsupported);
         return bounds;
@@ -523,6 +610,9 @@ static int ZSTD_isUpdateAuthorized(ZSTD_cParameter param)
     case ZSTD_c_stableOutBuffer:
     case ZSTD_c_blockDelimiters:
     case ZSTD_c_validateSequences:
+    case ZSTD_c_useBlockSplitter:
+    case ZSTD_c_useRowMatchFinder:
+    case ZSTD_c_deterministicRefPrefix:
     default:
         return 0;
     }
@@ -575,6 +665,9 @@ size_t ZSTD_CCtx_setParameter(ZSTD_CCtx* cctx, ZSTD_cParameter param, int value)
     case ZSTD_c_stableOutBuffer:
     case ZSTD_c_blockDelimiters:
     case ZSTD_c_validateSequences:
+    case ZSTD_c_useBlockSplitter:
+    case ZSTD_c_useRowMatchFinder:
+    case ZSTD_c_deterministicRefPrefix:
         break;
 
     default: RETURN_ERROR(parameter_unsupported, "unknown parameter");
@@ -672,7 +765,7 @@ size_t ZSTD_CCtxParams_setParameter(ZSTD_CCtx_params* CCtxParams,
     }
 
     case ZSTD_c_literalCompressionMode : {
-        const ZSTD_literalCompressionMode_e lcm = (ZSTD_literalCompressionMode_e)value;
+        const ZSTD_paramSwitch_e lcm = (ZSTD_paramSwitch_e)value;
         BOUNDCHECK(ZSTD_c_literalCompressionMode, lcm);
         CCtxParams->literalCompressionMode = lcm;
         return CCtxParams->literalCompressionMode;
@@ -699,7 +792,7 @@ size_t ZSTD_CCtxParams_setParameter(ZSTD_CCtx_params* CCtxParams,
         return CCtxParams->enableDedicatedDictSearch;
 
     case ZSTD_c_enableLongDistanceMatching :
-        CCtxParams->ldmParams.enableLdm = (value!=0);
+        CCtxParams->ldmParams.enableLdm = (ZSTD_paramSwitch_e)value;
         return CCtxParams->ldmParams.enableLdm;
 
     case ZSTD_c_ldmHashLog :
@@ -758,6 +851,21 @@ size_t ZSTD_CCtxParams_setParameter(ZSTD_CCtx_params* CCtxParams,
         CCtxParams->validateSequences = value;
         return CCtxParams->validateSequences;
 
+    case ZSTD_c_useBlockSplitter:
+        BOUNDCHECK(ZSTD_c_useBlockSplitter, value);
+        CCtxParams->useBlockSplitter = (ZSTD_paramSwitch_e)value;
+        return CCtxParams->useBlockSplitter;
+
+    case ZSTD_c_useRowMatchFinder:
+        BOUNDCHECK(ZSTD_c_useRowMatchFinder, value);
+        CCtxParams->useRowMatchFinder = (ZSTD_paramSwitch_e)value;
+        return CCtxParams->useRowMatchFinder;
+
+    case ZSTD_c_deterministicRefPrefix:
+        BOUNDCHECK(ZSTD_c_deterministicRefPrefix, value);
+        CCtxParams->deterministicRefPrefix = !!value;
+        return CCtxParams->deterministicRefPrefix;
+
     default: RETURN_ERROR(parameter_unsupported, "unknown parameter");
     }
 }
@@ -863,6 +971,15 @@ size_t ZSTD_CCtxParams_getParameter(
     case ZSTD_c_validateSequences :
         *value = (int)CCtxParams->validateSequences;
         break;
+    case ZSTD_c_useBlockSplitter :
+        *value = (int)CCtxParams->useBlockSplitter;
+        break;
+    case ZSTD_c_useRowMatchFinder :
+        *value = (int)CCtxParams->useRowMatchFinder;
+        break;
+    case ZSTD_c_deterministicRefPrefix:
+        *value = (int)CCtxParams->deterministicRefPrefix;
+        break;
     default: RETURN_ERROR(parameter_unsupported, "unknown parameter");
     }
     return 0;
@@ -889,7 +1006,7 @@ size_t ZSTD_CCtx_setParametersUsingCCtxParams(
     return 0;
 }
 
-ZSTDLIB_API size_t ZSTD_CCtx_setPledgedSrcSize(ZSTD_CCtx* cctx, unsigned long long pledgedSrcSize)
+size_t ZSTD_CCtx_setPledgedSrcSize(ZSTD_CCtx* cctx, unsigned long long pledgedSrcSize)
 {
     DEBUGLOG(4, "ZSTD_CCtx_setPledgedSrcSize to %u bytes", (U32)pledgedSrcSize);
     RETURN_ERROR_IF(cctx->streamStage != zcss_init, stage_wrong,
@@ -969,14 +1086,14 @@ size_t ZSTD_CCtx_loadDictionary_advanced(
     return 0;
 }
 
-ZSTDLIB_API size_t ZSTD_CCtx_loadDictionary_byReference(
+size_t ZSTD_CCtx_loadDictionary_byReference(
       ZSTD_CCtx* cctx, const void* dict, size_t dictSize)
 {
     return ZSTD_CCtx_loadDictionary_advanced(
             cctx, dict, dictSize, ZSTD_dlm_byRef, ZSTD_dct_auto);
 }
 
-ZSTDLIB_API size_t ZSTD_CCtx_loadDictionary(ZSTD_CCtx* cctx, const void* dict, size_t dictSize)
+size_t ZSTD_CCtx_loadDictionary(ZSTD_CCtx* cctx, const void* dict, size_t dictSize)
 {
     return ZSTD_CCtx_loadDictionary_advanced(
             cctx, dict, dictSize, ZSTD_dlm_byCopy, ZSTD_dct_auto);
@@ -1146,7 +1263,7 @@ ZSTD_adjustCParams_internal(ZSTD_compressionParameters cPar,
         break;
     case ZSTD_cpm_createCDict:
         /* Assume a small source size when creating a dictionary
-         * with an unkown source size.
+         * with an unknown source size.
          */
         if (dictSize && srcSize == ZSTD_CONTENTSIZE_UNKNOWN)
             srcSize = minSrcSize;
@@ -1220,7 +1337,7 @@ ZSTD_compressionParameters ZSTD_getCParamsFromCCtxParams(
       srcSizeHint = CCtxParams->srcSizeHint;
     }
     cParams = ZSTD_getCParams_internal(CCtxParams->compressionLevel, srcSizeHint, dictSize, mode);
-    if (CCtxParams->ldmParams.enableLdm) cParams.windowLog = ZSTD_LDM_DEFAULT_WINDOW_LOG;
+    if (CCtxParams->ldmParams.enableLdm == ZSTD_ps_enable) cParams.windowLog = ZSTD_LDM_DEFAULT_WINDOW_LOG;
     ZSTD_overrideCParams(&cParams, &CCtxParams->cParams);
     assert(!ZSTD_checkCParams(cParams));
     /* srcSizeHint == 0 means 0 */
@@ -1229,9 +1346,14 @@ ZSTD_compressionParameters ZSTD_getCParamsFromCCtxParams(
 
 static size_t
 ZSTD_sizeof_matchState(const ZSTD_compressionParameters* const cParams,
+                       const ZSTD_paramSwitch_e useRowMatchFinder,
+                       const U32 enableDedicatedDictSearch,
                        const U32 forCCtx)
 {
-    size_t const chainSize = (cParams->strategy == ZSTD_fast) ? 0 : ((size_t)1 << cParams->chainLog);
+    /* chain table size should be 0 for fast or row-hash strategies */
+    size_t const chainSize = ZSTD_allocateChainTable(cParams->strategy, useRowMatchFinder, enableDedicatedDictSearch && !forCCtx)
+                                ? ((size_t)1 << cParams->chainLog)
+                                : 0;
     size_t const hSize = ((size_t)1) << cParams->hashLog;
     U32    const hashLog3 = (forCCtx && cParams->minMatch==3) ? MIN(ZSTD_HASHLOG3_MAX, cParams->windowLog) : 0;
     size_t const h3Size = hashLog3 ? ((size_t)1) << hashLog3 : 0;
@@ -1241,43 +1363,53 @@ ZSTD_sizeof_matchState(const ZSTD_compressionParameters* const cParams,
                             + hSize * sizeof(U32)
                             + h3Size * sizeof(U32);
     size_t const optPotentialSpace =
-        ZSTD_cwksp_alloc_size((MaxML+1) * sizeof(U32))
-      + ZSTD_cwksp_alloc_size((MaxLL+1) * sizeof(U32))
-      + ZSTD_cwksp_alloc_size((MaxOff+1) * sizeof(U32))
-      + ZSTD_cwksp_alloc_size((1<<Litbits) * sizeof(U32))
-      + ZSTD_cwksp_alloc_size((ZSTD_OPT_NUM+1) * sizeof(ZSTD_match_t))
-      + ZSTD_cwksp_alloc_size((ZSTD_OPT_NUM+1) * sizeof(ZSTD_optimal_t));
+        ZSTD_cwksp_aligned_alloc_size((MaxML+1) * sizeof(U32))
+      + ZSTD_cwksp_aligned_alloc_size((MaxLL+1) * sizeof(U32))
+      + ZSTD_cwksp_aligned_alloc_size((MaxOff+1) * sizeof(U32))
+      + ZSTD_cwksp_aligned_alloc_size((1<<Litbits) * sizeof(U32))
+      + ZSTD_cwksp_aligned_alloc_size((ZSTD_OPT_NUM+1) * sizeof(ZSTD_match_t))
+      + ZSTD_cwksp_aligned_alloc_size((ZSTD_OPT_NUM+1) * sizeof(ZSTD_optimal_t));
+    size_t const lazyAdditionalSpace = ZSTD_rowMatchFinderUsed(cParams->strategy, useRowMatchFinder)
+                                            ? ZSTD_cwksp_aligned_alloc_size(hSize*sizeof(U16))
+                                            : 0;
     size_t const optSpace = (forCCtx && (cParams->strategy >= ZSTD_btopt))
                                 ? optPotentialSpace
                                 : 0;
+    size_t const slackSpace = ZSTD_cwksp_slack_space_required();
+
+    /* tables are guaranteed to be sized in multiples of 64 bytes (or 16 uint32_t) */
+    ZSTD_STATIC_ASSERT(ZSTD_HASHLOG_MIN >= 4 && ZSTD_WINDOWLOG_MIN >= 4 && ZSTD_CHAINLOG_MIN >= 4);
+    assert(useRowMatchFinder != ZSTD_ps_auto);
+
     DEBUGLOG(4, "chainSize: %u - hSize: %u - h3Size: %u",
                 (U32)chainSize, (U32)hSize, (U32)h3Size);
-    return tableSpace + optSpace;
+    return tableSpace + optSpace + slackSpace + lazyAdditionalSpace;
 }
 
 static size_t ZSTD_estimateCCtxSize_usingCCtxParams_internal(
         const ZSTD_compressionParameters* cParams,
         const ldmParams_t* ldmParams,
         const int isStatic,
+        const ZSTD_paramSwitch_e useRowMatchFinder,
         const size_t buffInSize,
         const size_t buffOutSize,
         const U64 pledgedSrcSize)
 {
-    size_t const windowSize = MAX(1, (size_t)MIN(((U64)1 << cParams->windowLog), pledgedSrcSize));
+    size_t const windowSize = (size_t) BOUNDED(1ULL, 1ULL << cParams->windowLog, pledgedSrcSize);
     size_t const blockSize = MIN(ZSTD_BLOCKSIZE_MAX, windowSize);
     U32    const divider = (cParams->minMatch==3) ? 3 : 4;
     size_t const maxNbSeq = blockSize / divider;
     size_t const tokenSpace = ZSTD_cwksp_alloc_size(WILDCOPY_OVERLENGTH + blockSize)
-                            + ZSTD_cwksp_alloc_size(maxNbSeq * sizeof(seqDef))
+                            + ZSTD_cwksp_aligned_alloc_size(maxNbSeq * sizeof(seqDef))
                             + 3 * ZSTD_cwksp_alloc_size(maxNbSeq * sizeof(BYTE));
     size_t const entropySpace = ZSTD_cwksp_alloc_size(ENTROPY_WORKSPACE_SIZE);
     size_t const blockStateSpace = 2 * ZSTD_cwksp_alloc_size(sizeof(ZSTD_compressedBlockState_t));
-    size_t const matchStateSize = ZSTD_sizeof_matchState(cParams, /* forCCtx */ 1);
+    size_t const matchStateSize = ZSTD_sizeof_matchState(cParams, useRowMatchFinder, /* enableDedicatedDictSearch */ 0, /* forCCtx */ 1);
 
     size_t const ldmSpace = ZSTD_ldm_getTableSize(*ldmParams);
     size_t const maxNbLdmSeq = ZSTD_ldm_getMaxNbSeq(*ldmParams, blockSize);
-    size_t const ldmSeqSpace = ldmParams->enableLdm ?
-        ZSTD_cwksp_alloc_size(maxNbLdmSeq * sizeof(rawSeq)) : 0;
+    size_t const ldmSeqSpace = ldmParams->enableLdm == ZSTD_ps_enable ?
+        ZSTD_cwksp_aligned_alloc_size(maxNbLdmSeq * sizeof(rawSeq)) : 0;
 
 
     size_t const bufferSpace = ZSTD_cwksp_alloc_size(buffInSize)
@@ -1303,19 +1435,32 @@ size_t ZSTD_estimateCCtxSize_usingCCtxParams(const ZSTD_CCtx_params* params)
 {
     ZSTD_compressionParameters const cParams =
                 ZSTD_getCParamsFromCCtxParams(params, ZSTD_CONTENTSIZE_UNKNOWN, 0, ZSTD_cpm_noAttachDict);
+    ZSTD_paramSwitch_e const useRowMatchFinder = ZSTD_resolveRowMatchFinderMode(params->useRowMatchFinder,
+                                                                               &cParams);
 
     RETURN_ERROR_IF(params->nbWorkers > 0, GENERIC, "Estimate CCtx size is supported for single-threaded compression only.");
     /* estimateCCtxSize is for one-shot compression. So no buffers should
      * be needed. However, we still allocate two 0-sized buffers, which can
      * take space under ASAN. */
     return ZSTD_estimateCCtxSize_usingCCtxParams_internal(
-        &cParams, &params->ldmParams, 1, 0, 0, ZSTD_CONTENTSIZE_UNKNOWN);
+        &cParams, &params->ldmParams, 1, useRowMatchFinder, 0, 0, ZSTD_CONTENTSIZE_UNKNOWN);
 }
 
 size_t ZSTD_estimateCCtxSize_usingCParams(ZSTD_compressionParameters cParams)
 {
-    ZSTD_CCtx_params const params = ZSTD_makeCCtxParamsFromCParams(cParams);
-    return ZSTD_estimateCCtxSize_usingCCtxParams(&params);
+    ZSTD_CCtx_params initialParams = ZSTD_makeCCtxParamsFromCParams(cParams);
+    if (ZSTD_rowMatchFinderSupported(cParams.strategy)) {
+        /* Pick bigger of not using and using row-based matchfinder for greedy and lazy strategies */
+        size_t noRowCCtxSize;
+        size_t rowCCtxSize;
+        initialParams.useRowMatchFinder = ZSTD_ps_disable;
+        noRowCCtxSize = ZSTD_estimateCCtxSize_usingCCtxParams(&initialParams);
+        initialParams.useRowMatchFinder = ZSTD_ps_enable;
+        rowCCtxSize = ZSTD_estimateCCtxSize_usingCCtxParams(&initialParams);
+        return MAX(noRowCCtxSize, rowCCtxSize);
+    } else {
+        return ZSTD_estimateCCtxSize_usingCCtxParams(&initialParams);
+    }
 }
 
 static size_t ZSTD_estimateCCtxSize_internal(int compressionLevel)
@@ -1355,17 +1500,29 @@ size_t ZSTD_estimateCStreamSize_usingCCtxParams(const ZSTD_CCtx_params* params)
         size_t const outBuffSize = (params->outBufferMode == ZSTD_bm_buffered)
                 ? ZSTD_compressBound(blockSize) + 1
                 : 0;
+        ZSTD_paramSwitch_e const useRowMatchFinder = ZSTD_resolveRowMatchFinderMode(params->useRowMatchFinder, &params->cParams);
 
         return ZSTD_estimateCCtxSize_usingCCtxParams_internal(
-            &cParams, &params->ldmParams, 1, inBuffSize, outBuffSize,
+            &cParams, &params->ldmParams, 1, useRowMatchFinder, inBuffSize, outBuffSize,
             ZSTD_CONTENTSIZE_UNKNOWN);
     }
 }
 
 size_t ZSTD_estimateCStreamSize_usingCParams(ZSTD_compressionParameters cParams)
 {
-    ZSTD_CCtx_params const params = ZSTD_makeCCtxParamsFromCParams(cParams);
-    return ZSTD_estimateCStreamSize_usingCCtxParams(&params);
+    ZSTD_CCtx_params initialParams = ZSTD_makeCCtxParamsFromCParams(cParams);
+    if (ZSTD_rowMatchFinderSupported(cParams.strategy)) {
+        /* Pick bigger of not using and using row-based matchfinder for greedy and lazy strategies */
+        size_t noRowCCtxSize;
+        size_t rowCCtxSize;
+        initialParams.useRowMatchFinder = ZSTD_ps_disable;
+        noRowCCtxSize = ZSTD_estimateCStreamSize_usingCCtxParams(&initialParams);
+        initialParams.useRowMatchFinder = ZSTD_ps_enable;
+        rowCCtxSize = ZSTD_estimateCStreamSize_usingCCtxParams(&initialParams);
+        return MAX(noRowCCtxSize, rowCCtxSize);
+    } else {
+        return ZSTD_estimateCStreamSize_usingCCtxParams(&initialParams);
+    }
 }
 
 static size_t ZSTD_estimateCStreamSize_internal(int compressionLevel)
@@ -1480,20 +1637,27 @@ typedef enum {
     ZSTD_resetTarget_CCtx
 } ZSTD_resetTarget_e;
 
+
 static size_t
 ZSTD_reset_matchState(ZSTD_matchState_t* ms,
                       ZSTD_cwksp* ws,
                 const ZSTD_compressionParameters* cParams,
+                const ZSTD_paramSwitch_e useRowMatchFinder,
                 const ZSTD_compResetPolicy_e crp,
                 const ZSTD_indexResetPolicy_e forceResetIndex,
                 const ZSTD_resetTarget_e forWho)
 {
-    size_t const chainSize = (cParams->strategy == ZSTD_fast) ? 0 : ((size_t)1 << cParams->chainLog);
+    /* disable chain table allocation for fast or row-based strategies */
+    size_t const chainSize = ZSTD_allocateChainTable(cParams->strategy, useRowMatchFinder,
+                                                     ms->dedicatedDictSearch && (forWho == ZSTD_resetTarget_CDict))
+                                ? ((size_t)1 << cParams->chainLog)
+                                : 0;
     size_t const hSize = ((size_t)1) << cParams->hashLog;
     U32    const hashLog3 = ((forWho == ZSTD_resetTarget_CCtx) && cParams->minMatch==3) ? MIN(ZSTD_HASHLOG3_MAX, cParams->windowLog) : 0;
     size_t const h3Size = hashLog3 ? ((size_t)1) << hashLog3 : 0;
 
     DEBUGLOG(4, "reset indices : %u", forceResetIndex == ZSTDirp_reset);
+    assert(useRowMatchFinder != ZSTD_ps_auto);
     if (forceResetIndex == ZSTDirp_reset) {
         ZSTD_window_init(&ms->window);
         ZSTD_cwksp_mark_tables_dirty(ws);
@@ -1532,11 +1696,23 @@ ZSTD_reset_matchState(ZSTD_matchState_t* ms,
         ms->opt.priceTable = (ZSTD_optimal_t*)ZSTD_cwksp_reserve_aligned(ws, (ZSTD_OPT_NUM+1) * sizeof(ZSTD_optimal_t));
     }
 
+    if (ZSTD_rowMatchFinderUsed(cParams->strategy, useRowMatchFinder)) {
+        {   /* Row match finder needs an additional table of hashes ("tags") */
+            size_t const tagTableSize = hSize*sizeof(U16);
+            ms->tagTable = (U16*)ZSTD_cwksp_reserve_aligned(ws, tagTableSize);
+            if (ms->tagTable) ZSTD_memset(ms->tagTable, 0, tagTableSize);
+        }
+        {   /* Switch to 32-entry rows if searchLog is 5 (or more) */
+            U32 const rowLog = BOUNDED(4, cParams->searchLog, 6);
+            assert(cParams->hashLog >= rowLog);
+            ms->rowHashLog = cParams->hashLog - rowLog;
+        }
+    }
+
     ms->cParams = *cParams;
 
     RETURN_ERROR_IF(ZSTD_cwksp_reserve_failed(ws), memory_allocation,
                     "failed a workspace allocation in ZSTD_reset_matchState");
-
     return 0;
 }
 
@@ -1553,61 +1729,87 @@ static int ZSTD_indexTooCloseToMax(ZSTD_window_t w)
     return (size_t)(w.nextSrc - w.base) > (ZSTD_CURRENT_MAX - ZSTD_INDEXOVERFLOW_MARGIN);
 }
 
+/* ZSTD_dictTooBig():
+ * When dictionaries are larger than ZSTD_CHUNKSIZE_MAX they can't be loaded in
+ * one go generically. So we ensure that in that case we reset the tables to zero,
+ * so that we can load as much of the dictionary as possible.
+ */
+static int ZSTD_dictTooBig(size_t const loadedDictSize)
+{
+    return loadedDictSize > ZSTD_CHUNKSIZE_MAX;
+}
+
 /*! ZSTD_resetCCtx_internal() :
-    note : `params` are assumed fully validated at this stage */
+ * @param loadedDictSize The size of the dictionary to be loaded
+ * into the context, if any. If no dictionary is used, or the
+ * dictionary is being attached / copied, then pass 0.
+ * note : `params` are assumed fully validated at this stage.
+ */
 static size_t ZSTD_resetCCtx_internal(ZSTD_CCtx* zc,
-                                      ZSTD_CCtx_params params,
+                                      ZSTD_CCtx_params const* params,
                                       U64 const pledgedSrcSize,
+                                      size_t const loadedDictSize,
                                       ZSTD_compResetPolicy_e const crp,
                                       ZSTD_buffered_policy_e const zbuff)
 {
     ZSTD_cwksp* const ws = &zc->workspace;
-    DEBUGLOG(4, "ZSTD_resetCCtx_internal: pledgedSrcSize=%u, wlog=%u",
-                (U32)pledgedSrcSize, params.cParams.windowLog);
-    assert(!ZSTD_isError(ZSTD_checkCParams(params.cParams)));
+    DEBUGLOG(4, "ZSTD_resetCCtx_internal: pledgedSrcSize=%u, wlog=%u, useRowMatchFinder=%d useBlockSplitter=%d",
+                (U32)pledgedSrcSize, params->cParams.windowLog, (int)params->useRowMatchFinder, (int)params->useBlockSplitter);
+    assert(!ZSTD_isError(ZSTD_checkCParams(params->cParams)));
 
     zc->isFirstBlock = 1;
 
-    if (params.ldmParams.enableLdm) {
+    /* Set applied params early so we can modify them for LDM,
+     * and point params at the applied params.
+     */
+    zc->appliedParams = *params;
+    params = &zc->appliedParams;
+
+    assert(params->useRowMatchFinder != ZSTD_ps_auto);
+    assert(params->useBlockSplitter != ZSTD_ps_auto);
+    assert(params->ldmParams.enableLdm != ZSTD_ps_auto);
+    if (params->ldmParams.enableLdm == ZSTD_ps_enable) {
         /* Adjust long distance matching parameters */
-        ZSTD_ldm_adjustParameters(&params.ldmParams, &params.cParams);
-        assert(params.ldmParams.hashLog >= params.ldmParams.bucketSizeLog);
-        assert(params.ldmParams.hashRateLog < 32);
+        ZSTD_ldm_adjustParameters(&zc->appliedParams.ldmParams, &params->cParams);
+        assert(params->ldmParams.hashLog >= params->ldmParams.bucketSizeLog);
+        assert(params->ldmParams.hashRateLog < 32);
     }
 
-    {   size_t const windowSize = MAX(1, (size_t)MIN(((U64)1 << params.cParams.windowLog), pledgedSrcSize));
+    {   size_t const windowSize = MAX(1, (size_t)MIN(((U64)1 << params->cParams.windowLog), pledgedSrcSize));
         size_t const blockSize = MIN(ZSTD_BLOCKSIZE_MAX, windowSize);
-        U32    const divider = (params.cParams.minMatch==3) ? 3 : 4;
+        U32    const divider = (params->cParams.minMatch==3) ? 3 : 4;
         size_t const maxNbSeq = blockSize / divider;
-        size_t const buffOutSize = (zbuff == ZSTDb_buffered && params.outBufferMode == ZSTD_bm_buffered)
+        size_t const buffOutSize = (zbuff == ZSTDb_buffered && params->outBufferMode == ZSTD_bm_buffered)
                 ? ZSTD_compressBound(blockSize) + 1
                 : 0;
-        size_t const buffInSize = (zbuff == ZSTDb_buffered && params.inBufferMode == ZSTD_bm_buffered)
+        size_t const buffInSize = (zbuff == ZSTDb_buffered && params->inBufferMode == ZSTD_bm_buffered)
                 ? windowSize + blockSize
                 : 0;
-        size_t const maxNbLdmSeq = ZSTD_ldm_getMaxNbSeq(params.ldmParams, blockSize);
+        size_t const maxNbLdmSeq = ZSTD_ldm_getMaxNbSeq(params->ldmParams, blockSize);
 
         int const indexTooClose = ZSTD_indexTooCloseToMax(zc->blockState.matchState.window);
+        int const dictTooBig = ZSTD_dictTooBig(loadedDictSize);
         ZSTD_indexResetPolicy_e needsIndexReset =
-            (!indexTooClose && zc->initialized) ? ZSTDirp_continue : ZSTDirp_reset;
+            (indexTooClose || dictTooBig || !zc->initialized) ? ZSTDirp_reset : ZSTDirp_continue;
 
         size_t const neededSpace =
             ZSTD_estimateCCtxSize_usingCCtxParams_internal(
-                &params.cParams, &params.ldmParams, zc->staticSize != 0,
+                &params->cParams, &params->ldmParams, zc->staticSize != 0, params->useRowMatchFinder,
                 buffInSize, buffOutSize, pledgedSrcSize);
+        int resizeWorkspace;
+
         FORWARD_IF_ERROR(neededSpace, "cctx size estimate failed!");
 
         if (!zc->staticSize) ZSTD_cwksp_bump_oversized_duration(ws, 0);
 
-        /* Check if workspace is large enough, alloc a new one if needed */
-        {
+        {   /* Check if workspace is large enough, alloc a new one if needed */
             int const workspaceTooSmall = ZSTD_cwksp_sizeof(ws) < neededSpace;
             int const workspaceWasteful = ZSTD_cwksp_check_wasteful(ws, neededSpace);
-
+            resizeWorkspace = workspaceTooSmall || workspaceWasteful;
             DEBUGLOG(4, "Need %zu B workspace", neededSpace);
             DEBUGLOG(4, "windowSize: %zu - blockSize: %zu", windowSize, blockSize);
 
-            if (workspaceTooSmall || workspaceWasteful) {
+            if (resizeWorkspace) {
                 DEBUGLOG(4, "Resize workspaceSize from %zuKB to %zuKB",
                             ZSTD_cwksp_sizeof(ws) >> 10,
                             neededSpace >> 10);
@@ -1629,14 +1831,13 @@ static size_t ZSTD_resetCCtx_internal(ZSTD_CCtx* zc,
                 zc->blockState.nextCBlock = (ZSTD_compressedBlockState_t*) ZSTD_cwksp_reserve_object(ws, sizeof(ZSTD_compressedBlockState_t));
                 RETURN_ERROR_IF(zc->blockState.nextCBlock == NULL, memory_allocation, "couldn't allocate nextCBlock");
                 zc->entropyWorkspace = (U32*) ZSTD_cwksp_reserve_object(ws, ENTROPY_WORKSPACE_SIZE);
-                RETURN_ERROR_IF(zc->blockState.nextCBlock == NULL, memory_allocation, "couldn't allocate entropyWorkspace");
+                RETURN_ERROR_IF(zc->entropyWorkspace == NULL, memory_allocation, "couldn't allocate entropyWorkspace");
         }   }
 
         ZSTD_cwksp_clear(ws);
 
         /* init params */
-        zc->appliedParams = params;
-        zc->blockState.matchState.cParams = params.cParams;
+        zc->blockState.matchState.cParams = params->cParams;
         zc->pledgedSrcSizePlusOne = pledgedSrcSize+1;
         zc->consumedSrcSize = 0;
         zc->producedCSize = 0;
@@ -1667,11 +1868,11 @@ static size_t ZSTD_resetCCtx_internal(ZSTD_CCtx* zc,
         zc->outBuff = (char*)ZSTD_cwksp_reserve_buffer(ws, buffOutSize);
 
         /* ldm bucketOffsets table */
-        if (params.ldmParams.enableLdm) {
+        if (params->ldmParams.enableLdm == ZSTD_ps_enable) {
             /* TODO: avoid memset? */
             size_t const numBuckets =
-                  ((size_t)1) << (params.ldmParams.hashLog -
-                                  params.ldmParams.bucketSizeLog);
+                  ((size_t)1) << (params->ldmParams.hashLog -
+                                  params->ldmParams.bucketSizeLog);
             zc->ldmState.bucketOffsets = ZSTD_cwksp_reserve_buffer(ws, numBuckets);
             ZSTD_memset(zc->ldmState.bucketOffsets, 0, numBuckets);
         }
@@ -1687,32 +1888,28 @@ static size_t ZSTD_resetCCtx_internal(ZSTD_CCtx* zc,
         FORWARD_IF_ERROR(ZSTD_reset_matchState(
             &zc->blockState.matchState,
             ws,
-            &params.cParams,
+            &params->cParams,
+            params->useRowMatchFinder,
             crp,
             needsIndexReset,
             ZSTD_resetTarget_CCtx), "");
 
         /* ldm hash table */
-        if (params.ldmParams.enableLdm) {
+        if (params->ldmParams.enableLdm == ZSTD_ps_enable) {
             /* TODO: avoid memset? */
-            size_t const ldmHSize = ((size_t)1) << params.ldmParams.hashLog;
+            size_t const ldmHSize = ((size_t)1) << params->ldmParams.hashLog;
             zc->ldmState.hashTable = (ldmEntry_t*)ZSTD_cwksp_reserve_aligned(ws, ldmHSize * sizeof(ldmEntry_t));
             ZSTD_memset(zc->ldmState.hashTable, 0, ldmHSize * sizeof(ldmEntry_t));
             zc->ldmSequences = (rawSeq*)ZSTD_cwksp_reserve_aligned(ws, maxNbLdmSeq * sizeof(rawSeq));
             zc->maxNbLdmSequences = maxNbLdmSeq;
 
             ZSTD_window_init(&zc->ldmState.window);
-            ZSTD_window_clear(&zc->ldmState.window);
             zc->ldmState.loadedDictEnd = 0;
         }
 
-        /* Due to alignment, when reusing a workspace, we can actually consume
-         * up to 3 extra bytes for alignment. See the comments in zstd_cwksp.h
-         */
-        assert(ZSTD_cwksp_used(ws) >= neededSpace &&
-               ZSTD_cwksp_used(ws) <= neededSpace + 3);
-
         DEBUGLOG(3, "wksp: finished allocating, %zd bytes remain available", ZSTD_cwksp_available_space(ws));
+        assert(ZSTD_cwksp_estimated_space_within_bounds(ws, neededSpace, resizeWorkspace));
+
         zc->initialized = 1;
 
         return 0;
@@ -1768,6 +1965,8 @@ ZSTD_resetCCtx_byAttachingCDict(ZSTD_CCtx* cctx,
                         U64 pledgedSrcSize,
                         ZSTD_buffered_policy_e zbuff)
 {
+    DEBUGLOG(4, "ZSTD_resetCCtx_byAttachingCDict() pledgedSrcSize=%llu",
+                (unsigned long long)pledgedSrcSize);
     {
         ZSTD_compressionParameters adjusted_cdict_cParams = cdict->matchState.cParams;
         unsigned const windowLog = params.cParams.windowLog;
@@ -1783,7 +1982,9 @@ ZSTD_resetCCtx_byAttachingCDict(ZSTD_CCtx* cctx,
         params.cParams = ZSTD_adjustCParams_internal(adjusted_cdict_cParams, pledgedSrcSize,
                                                      cdict->dictContentSize, ZSTD_cpm_attachDict);
         params.cParams.windowLog = windowLog;
-        FORWARD_IF_ERROR(ZSTD_resetCCtx_internal(cctx, params, pledgedSrcSize,
+        params.useRowMatchFinder = cdict->useRowMatchFinder;    /* cdict overrides */
+        FORWARD_IF_ERROR(ZSTD_resetCCtx_internal(cctx, &params, pledgedSrcSize,
+                                                 /* loadedDictSize */ 0,
                                                  ZSTDcrp_makeClean, zbuff), "");
         assert(cctx->appliedParams.cParams.strategy == adjusted_cdict_cParams.strategy);
     }
@@ -1827,15 +2028,17 @@ static size_t ZSTD_resetCCtx_byCopyingCDict(ZSTD_CCtx* cctx,
     const ZSTD_compressionParameters *cdict_cParams = &cdict->matchState.cParams;
 
     assert(!cdict->matchState.dedicatedDictSearch);
-
-    DEBUGLOG(4, "copying dictionary into context");
+    DEBUGLOG(4, "ZSTD_resetCCtx_byCopyingCDict() pledgedSrcSize=%llu",
+                (unsigned long long)pledgedSrcSize);
 
     {   unsigned const windowLog = params.cParams.windowLog;
         assert(windowLog != 0);
         /* Copy only compression parameters related to tables. */
         params.cParams = *cdict_cParams;
         params.cParams.windowLog = windowLog;
-        FORWARD_IF_ERROR(ZSTD_resetCCtx_internal(cctx, params, pledgedSrcSize,
+        params.useRowMatchFinder = cdict->useRowMatchFinder;
+        FORWARD_IF_ERROR(ZSTD_resetCCtx_internal(cctx, &params, pledgedSrcSize,
+                                                 /* loadedDictSize */ 0,
                                                  ZSTDcrp_leaveDirty, zbuff), "");
         assert(cctx->appliedParams.cParams.strategy == cdict_cParams->strategy);
         assert(cctx->appliedParams.cParams.hashLog == cdict_cParams->hashLog);
@@ -1843,17 +2046,30 @@ static size_t ZSTD_resetCCtx_byCopyingCDict(ZSTD_CCtx* cctx,
     }
 
     ZSTD_cwksp_mark_tables_dirty(&cctx->workspace);
+    assert(params.useRowMatchFinder != ZSTD_ps_auto);
 
     /* copy tables */
-    {   size_t const chainSize = (cdict_cParams->strategy == ZSTD_fast) ? 0 : ((size_t)1 << cdict_cParams->chainLog);
+    {   size_t const chainSize = ZSTD_allocateChainTable(cdict_cParams->strategy, cdict->useRowMatchFinder, 0 /* DDS guaranteed disabled */)
+                                                            ? ((size_t)1 << cdict_cParams->chainLog)
+                                                            : 0;
         size_t const hSize =  (size_t)1 << cdict_cParams->hashLog;
 
         ZSTD_memcpy(cctx->blockState.matchState.hashTable,
                cdict->matchState.hashTable,
                hSize * sizeof(U32));
-        ZSTD_memcpy(cctx->blockState.matchState.chainTable,
+        /* Do not copy cdict's chainTable if cctx has parameters such that it would not use chainTable */
+        if (ZSTD_allocateChainTable(cctx->appliedParams.cParams.strategy, cctx->appliedParams.useRowMatchFinder, 0 /* forDDSDict */)) {
+            ZSTD_memcpy(cctx->blockState.matchState.chainTable,
                cdict->matchState.chainTable,
                chainSize * sizeof(U32));
+        }
+        /* copy tag table */
+        if (ZSTD_rowMatchFinderUsed(cdict_cParams->strategy, cdict->useRowMatchFinder)) {
+            size_t const tagTableSize = hSize*sizeof(U16);
+            ZSTD_memcpy(cctx->blockState.matchState.tagTable,
+                cdict->matchState.tagTable,
+                tagTableSize);
+        }
     }
 
     /* Zero the hashTable3, since the cdict never fills it */
@@ -1917,16 +2133,22 @@ static size_t ZSTD_copyCCtx_internal(ZSTD_CCtx* dstCCtx,
                             U64 pledgedSrcSize,
                             ZSTD_buffered_policy_e zbuff)
 {
-    DEBUGLOG(5, "ZSTD_copyCCtx_internal");
     RETURN_ERROR_IF(srcCCtx->stage!=ZSTDcs_init, stage_wrong,
                     "Can't copy a ctx that's not in init stage.");
-
+    DEBUGLOG(5, "ZSTD_copyCCtx_internal");
     ZSTD_memcpy(&dstCCtx->customMem, &srcCCtx->customMem, sizeof(ZSTD_customMem));
     {   ZSTD_CCtx_params params = dstCCtx->requestedParams;
         /* Copy only compression parameters related to tables. */
         params.cParams = srcCCtx->appliedParams.cParams;
+        assert(srcCCtx->appliedParams.useRowMatchFinder != ZSTD_ps_auto);
+        assert(srcCCtx->appliedParams.useBlockSplitter != ZSTD_ps_auto);
+        assert(srcCCtx->appliedParams.ldmParams.enableLdm != ZSTD_ps_auto);
+        params.useRowMatchFinder = srcCCtx->appliedParams.useRowMatchFinder;
+        params.useBlockSplitter = srcCCtx->appliedParams.useBlockSplitter;
+        params.ldmParams = srcCCtx->appliedParams.ldmParams;
         params.fParams = fParams;
-        ZSTD_resetCCtx_internal(dstCCtx, params, pledgedSrcSize,
+        ZSTD_resetCCtx_internal(dstCCtx, &params, pledgedSrcSize,
+                                /* loadedDictSize */ 0,
                                 ZSTDcrp_leaveDirty, zbuff);
         assert(dstCCtx->appliedParams.cParams.windowLog == srcCCtx->appliedParams.cParams.windowLog);
         assert(dstCCtx->appliedParams.cParams.strategy == srcCCtx->appliedParams.cParams.strategy);
@@ -1938,7 +2160,11 @@ static size_t ZSTD_copyCCtx_internal(ZSTD_CCtx* dstCCtx,
     ZSTD_cwksp_mark_tables_dirty(&dstCCtx->workspace);
 
     /* copy tables */
-    {   size_t const chainSize = (srcCCtx->appliedParams.cParams.strategy == ZSTD_fast) ? 0 : ((size_t)1 << srcCCtx->appliedParams.cParams.chainLog);
+    {   size_t const chainSize = ZSTD_allocateChainTable(srcCCtx->appliedParams.cParams.strategy,
+                                                         srcCCtx->appliedParams.useRowMatchFinder,
+                                                         0 /* forDDSDict */)
+                                    ? ((size_t)1 << srcCCtx->appliedParams.cParams.chainLog)
+                                    : 0;
         size_t const hSize =  (size_t)1 << srcCCtx->appliedParams.cParams.hashLog;
         int const h3log = srcCCtx->blockState.matchState.hashLog3;
         size_t const h3Size = h3log ? ((size_t)1 << h3log) : 0;
@@ -2005,6 +2231,8 @@ ZSTD_reduceTable_internal (U32* const table, U32 const size, U32 const reducerVa
     int const nbRows = (int)size / ZSTD_ROWSIZE;
     int cellNb = 0;
     int rowNb;
+    /* Protect special index values < ZSTD_WINDOW_START_INDEX. */
+    U32 const reducerThreshold = reducerValue + ZSTD_WINDOW_START_INDEX;
     assert((size & (ZSTD_ROWSIZE-1)) == 0);  /* multiple of ZSTD_ROWSIZE */
     assert(size < (1U<<31));   /* can be casted to int */
 
@@ -2012,12 +2240,17 @@ ZSTD_reduceTable_internal (U32* const table, U32 const size, U32 const reducerVa
     for (rowNb=0 ; rowNb < nbRows ; rowNb++) {
         int column;
         for (column=0; column<ZSTD_ROWSIZE; column++) {
-            if (preserveMark) {
-                U32 const adder = (table[cellNb] == ZSTD_DUBT_UNSORTED_MARK) ? reducerValue : 0;
-                table[cellNb] += adder;
+            U32 newVal;
+            if (preserveMark && table[cellNb] == ZSTD_DUBT_UNSORTED_MARK) {
+                /* This write is pointless, but is required(?) for the compiler
+                 * to auto-vectorize the loop. */
+                newVal = ZSTD_DUBT_UNSORTED_MARK;
+            } else if (table[cellNb] < reducerThreshold) {
+                newVal = 0;
+            } else {
+                newVal = table[cellNb] - reducerValue;
             }
-            if (table[cellNb] < reducerValue) table[cellNb] = 0;
-            else table[cellNb] -= reducerValue;
+            table[cellNb] = newVal;
             cellNb++;
     }   }
 }
@@ -2040,7 +2273,7 @@ static void ZSTD_reduceIndex (ZSTD_matchState_t* ms, ZSTD_CCtx_params const* par
         ZSTD_reduceTable(ms->hashTable, hSize, reducerValue);
     }
 
-    if (params->cParams.strategy != ZSTD_fast) {
+    if (ZSTD_allocateChainTable(params->cParams.strategy, params->useRowMatchFinder, (U32)ms->dedicatedDictSearch)) {
         U32 const chainSize = (U32)1 << params->cParams.chainLog;
         if (params->cParams.strategy == ZSTD_btlazy2)
             ZSTD_reduceTable_btlazy2(ms->chainTable, chainSize, reducerValue);
@@ -2072,14 +2305,14 @@ void ZSTD_seqToCodes(const seqStore_t* seqStorePtr)
     assert(nbSeq <= seqStorePtr->maxNbSeq);
     for (u=0; u<nbSeq; u++) {
         U32 const llv = sequences[u].litLength;
-        U32 const mlv = sequences[u].matchLength;
+        U32 const mlv = sequences[u].mlBase;
         llCodeTable[u] = (BYTE)ZSTD_LLcode(llv);
-        ofCodeTable[u] = (BYTE)ZSTD_highbit32(sequences[u].offset);
+        ofCodeTable[u] = (BYTE)ZSTD_highbit32(sequences[u].offBase);
         mlCodeTable[u] = (BYTE)ZSTD_MLcode(mlv);
     }
-    if (seqStorePtr->longLengthID==1)
+    if (seqStorePtr->longLengthType==ZSTD_llt_literalLength)
         llCodeTable[seqStorePtr->longLengthPos] = MaxLL;
-    if (seqStorePtr->longLengthID==2)
+    if (seqStorePtr->longLengthType==ZSTD_llt_matchLength)
         mlCodeTable[seqStorePtr->longLengthPos] = MaxML;
 }
 
@@ -2093,10 +2326,161 @@ static int ZSTD_useTargetCBlockSize(const ZSTD_CCtx_params* cctxParams)
     return (cctxParams->targetCBlockSize != 0);
 }
 
-/* ZSTD_entropyCompressSequences_internal():
- * actually compresses both literals and sequences */
+/* ZSTD_blockSplitterEnabled():
+ * Returns if block splitting param is being used
+ * If used, compression will do best effort to split a block in order to improve compression ratio.
+ * At the time this function is called, the parameter must be finalized.
+ * Returns 1 if true, 0 otherwise. */
+static int ZSTD_blockSplitterEnabled(ZSTD_CCtx_params* cctxParams)
+{
+    DEBUGLOG(5, "ZSTD_blockSplitterEnabled (useBlockSplitter=%d)", cctxParams->useBlockSplitter);
+    assert(cctxParams->useBlockSplitter != ZSTD_ps_auto);
+    return (cctxParams->useBlockSplitter == ZSTD_ps_enable);
+}
+
+/* Type returned by ZSTD_buildSequencesStatistics containing finalized symbol encoding types
+ * and size of the sequences statistics
+ */
+typedef struct {
+    U32 LLtype;
+    U32 Offtype;
+    U32 MLtype;
+    size_t size;
+    size_t lastCountSize; /* Accounts for bug in 1.3.4. More detail in ZSTD_entropyCompressSeqStore_internal() */
+} ZSTD_symbolEncodingTypeStats_t;
+
+/* ZSTD_buildSequencesStatistics():
+ * Returns a ZSTD_symbolEncodingTypeStats_t, or a zstd error code in the `size` field.
+ * Modifies `nextEntropy` to have the appropriate values as a side effect.
+ * nbSeq must be greater than 0.
+ *
+ * entropyWkspSize must be of size at least ENTROPY_WORKSPACE_SIZE - (MaxSeq + 1)*sizeof(U32)
+ */
+static ZSTD_symbolEncodingTypeStats_t
+ZSTD_buildSequencesStatistics(seqStore_t* seqStorePtr, size_t nbSeq,
+                        const ZSTD_fseCTables_t* prevEntropy, ZSTD_fseCTables_t* nextEntropy,
+                              BYTE* dst, const BYTE* const dstEnd,
+                              ZSTD_strategy strategy, unsigned* countWorkspace,
+                              void* entropyWorkspace, size_t entropyWkspSize) {
+    BYTE* const ostart = dst;
+    const BYTE* const oend = dstEnd;
+    BYTE* op = ostart;
+    FSE_CTable* CTable_LitLength = nextEntropy->litlengthCTable;
+    FSE_CTable* CTable_OffsetBits = nextEntropy->offcodeCTable;
+    FSE_CTable* CTable_MatchLength = nextEntropy->matchlengthCTable;
+    const BYTE* const ofCodeTable = seqStorePtr->ofCode;
+    const BYTE* const llCodeTable = seqStorePtr->llCode;
+    const BYTE* const mlCodeTable = seqStorePtr->mlCode;
+    ZSTD_symbolEncodingTypeStats_t stats;
+
+    stats.lastCountSize = 0;
+    /* convert length/distances into codes */
+    ZSTD_seqToCodes(seqStorePtr);
+    assert(op <= oend);
+    assert(nbSeq != 0); /* ZSTD_selectEncodingType() divides by nbSeq */
+    /* build CTable for Literal Lengths */
+    {   unsigned max = MaxLL;
+        size_t const mostFrequent = HIST_countFast_wksp(countWorkspace, &max, llCodeTable, nbSeq, entropyWorkspace, entropyWkspSize);   /* can't fail */
+        DEBUGLOG(5, "Building LL table");
+        nextEntropy->litlength_repeatMode = prevEntropy->litlength_repeatMode;
+        stats.LLtype = ZSTD_selectEncodingType(&nextEntropy->litlength_repeatMode,
+                                        countWorkspace, max, mostFrequent, nbSeq,
+                                        LLFSELog, prevEntropy->litlengthCTable,
+                                        LL_defaultNorm, LL_defaultNormLog,
+                                        ZSTD_defaultAllowed, strategy);
+        assert(set_basic < set_compressed && set_rle < set_compressed);
+        assert(!(stats.LLtype < set_compressed && nextEntropy->litlength_repeatMode != FSE_repeat_none)); /* We don't copy tables */
+        {   size_t const countSize = ZSTD_buildCTable(
+                op, (size_t)(oend - op),
+                CTable_LitLength, LLFSELog, (symbolEncodingType_e)stats.LLtype,
+                countWorkspace, max, llCodeTable, nbSeq,
+                LL_defaultNorm, LL_defaultNormLog, MaxLL,
+                prevEntropy->litlengthCTable,
+                sizeof(prevEntropy->litlengthCTable),
+                entropyWorkspace, entropyWkspSize);
+            if (ZSTD_isError(countSize)) {
+                DEBUGLOG(3, "ZSTD_buildCTable for LitLens failed");
+                stats.size = countSize;
+                return stats;
+            }
+            if (stats.LLtype == set_compressed)
+                stats.lastCountSize = countSize;
+            op += countSize;
+            assert(op <= oend);
+    }   }
+    /* build CTable for Offsets */
+    {   unsigned max = MaxOff;
+        size_t const mostFrequent = HIST_countFast_wksp(
+            countWorkspace, &max, ofCodeTable, nbSeq, entropyWorkspace, entropyWkspSize);  /* can't fail */
+        /* We can only use the basic table if max <= DefaultMaxOff, otherwise the offsets are too large */
+        ZSTD_defaultPolicy_e const defaultPolicy = (max <= DefaultMaxOff) ? ZSTD_defaultAllowed : ZSTD_defaultDisallowed;
+        DEBUGLOG(5, "Building OF table");
+        nextEntropy->offcode_repeatMode = prevEntropy->offcode_repeatMode;
+        stats.Offtype = ZSTD_selectEncodingType(&nextEntropy->offcode_repeatMode,
+                                        countWorkspace, max, mostFrequent, nbSeq,
+                                        OffFSELog, prevEntropy->offcodeCTable,
+                                        OF_defaultNorm, OF_defaultNormLog,
+                                        defaultPolicy, strategy);
+        assert(!(stats.Offtype < set_compressed && nextEntropy->offcode_repeatMode != FSE_repeat_none)); /* We don't copy tables */
+        {   size_t const countSize = ZSTD_buildCTable(
+                op, (size_t)(oend - op),
+                CTable_OffsetBits, OffFSELog, (symbolEncodingType_e)stats.Offtype,
+                countWorkspace, max, ofCodeTable, nbSeq,
+                OF_defaultNorm, OF_defaultNormLog, DefaultMaxOff,
+                prevEntropy->offcodeCTable,
+                sizeof(prevEntropy->offcodeCTable),
+                entropyWorkspace, entropyWkspSize);
+            if (ZSTD_isError(countSize)) {
+                DEBUGLOG(3, "ZSTD_buildCTable for Offsets failed");
+                stats.size = countSize;
+                return stats;
+            }
+            if (stats.Offtype == set_compressed)
+                stats.lastCountSize = countSize;
+            op += countSize;
+            assert(op <= oend);
+    }   }
+    /* build CTable for MatchLengths */
+    {   unsigned max = MaxML;
+        size_t const mostFrequent = HIST_countFast_wksp(
+            countWorkspace, &max, mlCodeTable, nbSeq, entropyWorkspace, entropyWkspSize);   /* can't fail */
+        DEBUGLOG(5, "Building ML table (remaining space : %i)", (int)(oend-op));
+        nextEntropy->matchlength_repeatMode = prevEntropy->matchlength_repeatMode;
+        stats.MLtype = ZSTD_selectEncodingType(&nextEntropy->matchlength_repeatMode,
+                                        countWorkspace, max, mostFrequent, nbSeq,
+                                        MLFSELog, prevEntropy->matchlengthCTable,
+                                        ML_defaultNorm, ML_defaultNormLog,
+                                        ZSTD_defaultAllowed, strategy);
+        assert(!(stats.MLtype < set_compressed && nextEntropy->matchlength_repeatMode != FSE_repeat_none)); /* We don't copy tables */
+        {   size_t const countSize = ZSTD_buildCTable(
+                op, (size_t)(oend - op),
+                CTable_MatchLength, MLFSELog, (symbolEncodingType_e)stats.MLtype,
+                countWorkspace, max, mlCodeTable, nbSeq,
+                ML_defaultNorm, ML_defaultNormLog, MaxML,
+                prevEntropy->matchlengthCTable,
+                sizeof(prevEntropy->matchlengthCTable),
+                entropyWorkspace, entropyWkspSize);
+            if (ZSTD_isError(countSize)) {
+                DEBUGLOG(3, "ZSTD_buildCTable for MatchLengths failed");
+                stats.size = countSize;
+                return stats;
+            }
+            if (stats.MLtype == set_compressed)
+                stats.lastCountSize = countSize;
+            op += countSize;
+            assert(op <= oend);
+    }   }
+    stats.size = (size_t)(op-ostart);
+    return stats;
+}
+
+/* ZSTD_entropyCompressSeqStore_internal():
+ * compresses both literals and sequences
+ * Returns compressed size of block, or a zstd error.
+ */
+#define SUSPECT_UNCOMPRESSIBLE_LITERAL_RATIO 20
 MEM_STATIC size_t
-ZSTD_entropyCompressSequences_internal(seqStore_t* seqStorePtr,
+ZSTD_entropyCompressSeqStore_internal(seqStore_t* seqStorePtr,
                           const ZSTD_entropyCTables_t* prevEntropy,
                                 ZSTD_entropyCTables_t* nextEntropy,
                           const ZSTD_CCtx_params* cctxParams,
@@ -2110,36 +2494,38 @@ ZSTD_entropyCompressSequences_internal(seqStore_t* seqStorePtr,
     FSE_CTable* CTable_LitLength = nextEntropy->fse.litlengthCTable;
     FSE_CTable* CTable_OffsetBits = nextEntropy->fse.offcodeCTable;
     FSE_CTable* CTable_MatchLength = nextEntropy->fse.matchlengthCTable;
-    U32 LLtype, Offtype, MLtype;   /* compressed, raw or rle */
     const seqDef* const sequences = seqStorePtr->sequencesStart;
+    const size_t nbSeq = seqStorePtr->sequences - seqStorePtr->sequencesStart;
     const BYTE* const ofCodeTable = seqStorePtr->ofCode;
     const BYTE* const llCodeTable = seqStorePtr->llCode;
     const BYTE* const mlCodeTable = seqStorePtr->mlCode;
     BYTE* const ostart = (BYTE*)dst;
     BYTE* const oend = ostart + dstCapacity;
     BYTE* op = ostart;
-    size_t const nbSeq = (size_t)(seqStorePtr->sequences - seqStorePtr->sequencesStart);
-    BYTE* seqHead;
-    BYTE* lastNCount = NULL;
+    size_t lastCountSize;
 
     entropyWorkspace = count + (MaxSeq + 1);
     entropyWkspSize -= (MaxSeq + 1) * sizeof(*count);
 
-    DEBUGLOG(4, "ZSTD_entropyCompressSequences_internal (nbSeq=%zu)", nbSeq);
+    DEBUGLOG(4, "ZSTD_entropyCompressSeqStore_internal (nbSeq=%zu)", nbSeq);
     ZSTD_STATIC_ASSERT(HUF_WORKSPACE_SIZE >= (1<<MAX(MLFSELog,LLFSELog)));
     assert(entropyWkspSize >= HUF_WORKSPACE_SIZE);
 
     /* Compress literals */
     {   const BYTE* const literals = seqStorePtr->litStart;
+        size_t const numSequences = seqStorePtr->sequences - seqStorePtr->sequencesStart;
+        size_t const numLiterals = seqStorePtr->lit - seqStorePtr->litStart;
+        /* Base suspicion of uncompressibility on ratio of literals to sequences */
+        unsigned const suspectUncompressible = (numSequences == 0) || (numLiterals / numSequences >= SUSPECT_UNCOMPRESSIBLE_LITERAL_RATIO);
         size_t const litSize = (size_t)(seqStorePtr->lit - literals);
         size_t const cSize = ZSTD_compressLiterals(
                                     &prevEntropy->huf, &nextEntropy->huf,
                                     cctxParams->cParams.strategy,
-                                    ZSTD_disableLiteralsCompression(cctxParams),
+                                    ZSTD_literalsCompressionIsDisabled(cctxParams),
                                     op, dstCapacity,
                                     literals, litSize,
                                     entropyWorkspace, entropyWkspSize,
-                                    bmi2);
+                                    bmi2, suspectUncompressible);
         FORWARD_IF_ERROR(cSize, "ZSTD_compressLiterals failed");
         assert(cSize <= dstCapacity);
         op += cSize;
@@ -2165,95 +2551,20 @@ ZSTD_entropyCompressSequences_internal(seqStore_t* seqStorePtr,
         ZSTD_memcpy(&nextEntropy->fse, &prevEntropy->fse, sizeof(prevEntropy->fse));
         return (size_t)(op - ostart);
     }
-
-    /* seqHead : flags for FSE encoding type */
-    seqHead = op++;
-    assert(op <= oend);
-
-    /* convert length/distances into codes */
-    ZSTD_seqToCodes(seqStorePtr);
-    /* build CTable for Literal Lengths */
-    {   unsigned max = MaxLL;
-        size_t const mostFrequent = HIST_countFast_wksp(count, &max, llCodeTable, nbSeq, entropyWorkspace, entropyWkspSize);   /* can't fail */
-        DEBUGLOG(5, "Building LL table");
-        nextEntropy->fse.litlength_repeatMode = prevEntropy->fse.litlength_repeatMode;
-        LLtype = ZSTD_selectEncodingType(&nextEntropy->fse.litlength_repeatMode,
-                                        count, max, mostFrequent, nbSeq,
-                                        LLFSELog, prevEntropy->fse.litlengthCTable,
-                                        LL_defaultNorm, LL_defaultNormLog,
-                                        ZSTD_defaultAllowed, strategy);
-        assert(set_basic < set_compressed && set_rle < set_compressed);
-        assert(!(LLtype < set_compressed && nextEntropy->fse.litlength_repeatMode != FSE_repeat_none)); /* We don't copy tables */
-        {   size_t const countSize = ZSTD_buildCTable(
-                op, (size_t)(oend - op),
-                CTable_LitLength, LLFSELog, (symbolEncodingType_e)LLtype,
-                count, max, llCodeTable, nbSeq,
-                LL_defaultNorm, LL_defaultNormLog, MaxLL,
-                prevEntropy->fse.litlengthCTable,
-                sizeof(prevEntropy->fse.litlengthCTable),
-                entropyWorkspace, entropyWkspSize);
-            FORWARD_IF_ERROR(countSize, "ZSTD_buildCTable for LitLens failed");
-            if (LLtype == set_compressed)
-                lastNCount = op;
-            op += countSize;
-            assert(op <= oend);
-    }   }
-    /* build CTable for Offsets */
-    {   unsigned max = MaxOff;
-        size_t const mostFrequent = HIST_countFast_wksp(
-            count, &max, ofCodeTable, nbSeq, entropyWorkspace, entropyWkspSize);  /* can't fail */
-        /* We can only use the basic table if max <= DefaultMaxOff, otherwise the offsets are too large */
-        ZSTD_defaultPolicy_e const defaultPolicy = (max <= DefaultMaxOff) ? ZSTD_defaultAllowed : ZSTD_defaultDisallowed;
-        DEBUGLOG(5, "Building OF table");
-        nextEntropy->fse.offcode_repeatMode = prevEntropy->fse.offcode_repeatMode;
-        Offtype = ZSTD_selectEncodingType(&nextEntropy->fse.offcode_repeatMode,
-                                        count, max, mostFrequent, nbSeq,
-                                        OffFSELog, prevEntropy->fse.offcodeCTable,
-                                        OF_defaultNorm, OF_defaultNormLog,
-                                        defaultPolicy, strategy);
-        assert(!(Offtype < set_compressed && nextEntropy->fse.offcode_repeatMode != FSE_repeat_none)); /* We don't copy tables */
-        {   size_t const countSize = ZSTD_buildCTable(
-                op, (size_t)(oend - op),
-                CTable_OffsetBits, OffFSELog, (symbolEncodingType_e)Offtype,
-                count, max, ofCodeTable, nbSeq,
-                OF_defaultNorm, OF_defaultNormLog, DefaultMaxOff,
-                prevEntropy->fse.offcodeCTable,
-                sizeof(prevEntropy->fse.offcodeCTable),
-                entropyWorkspace, entropyWkspSize);
-            FORWARD_IF_ERROR(countSize, "ZSTD_buildCTable for Offsets failed");
-            if (Offtype == set_compressed)
-                lastNCount = op;
-            op += countSize;
-            assert(op <= oend);
-    }   }
-    /* build CTable for MatchLengths */
-    {   unsigned max = MaxML;
-        size_t const mostFrequent = HIST_countFast_wksp(
-            count, &max, mlCodeTable, nbSeq, entropyWorkspace, entropyWkspSize);   /* can't fail */
-        DEBUGLOG(5, "Building ML table (remaining space : %i)", (int)(oend-op));
-        nextEntropy->fse.matchlength_repeatMode = prevEntropy->fse.matchlength_repeatMode;
-        MLtype = ZSTD_selectEncodingType(&nextEntropy->fse.matchlength_repeatMode,
-                                        count, max, mostFrequent, nbSeq,
-                                        MLFSELog, prevEntropy->fse.matchlengthCTable,
-                                        ML_defaultNorm, ML_defaultNormLog,
-                                        ZSTD_defaultAllowed, strategy);
-        assert(!(MLtype < set_compressed && nextEntropy->fse.matchlength_repeatMode != FSE_repeat_none)); /* We don't copy tables */
-        {   size_t const countSize = ZSTD_buildCTable(
-                op, (size_t)(oend - op),
-                CTable_MatchLength, MLFSELog, (symbolEncodingType_e)MLtype,
-                count, max, mlCodeTable, nbSeq,
-                ML_defaultNorm, ML_defaultNormLog, MaxML,
-                prevEntropy->fse.matchlengthCTable,
-                sizeof(prevEntropy->fse.matchlengthCTable),
-                entropyWorkspace, entropyWkspSize);
-            FORWARD_IF_ERROR(countSize, "ZSTD_buildCTable for MatchLengths failed");
-            if (MLtype == set_compressed)
-                lastNCount = op;
-            op += countSize;
-            assert(op <= oend);
-    }   }
-
-    *seqHead = (BYTE)((LLtype<<6) + (Offtype<<4) + (MLtype<<2));
+    {
+        ZSTD_symbolEncodingTypeStats_t stats;
+        BYTE* seqHead = op++;
+        /* build stats for sequences */
+        stats = ZSTD_buildSequencesStatistics(seqStorePtr, nbSeq,
+                                             &prevEntropy->fse, &nextEntropy->fse,
+                                              op, oend,
+                                              strategy, count,
+                                              entropyWorkspace, entropyWkspSize);
+        FORWARD_IF_ERROR(stats.size, "ZSTD_buildSequencesStatistics failed!");
+        *seqHead = (BYTE)((stats.LLtype<<6) + (stats.Offtype<<4) + (stats.MLtype<<2));
+        lastCountSize = stats.lastCountSize;
+        op += stats.size;
+    }
 
     {   size_t const bitstreamSize = ZSTD_encodeSequences(
                                         op, (size_t)(oend - op),
@@ -2273,9 +2584,9 @@ ZSTD_entropyCompressSequences_internal(seqStore_t* seqStorePtr,
          * In this exceedingly rare case, we will simply emit an uncompressed
          * block, since it isn't worth optimizing.
          */
-        if (lastNCount && (op - lastNCount) < 4) {
-            /* NCountSize >= 2 && bitstreamSize > 0 ==> lastCountSize == 3 */
-            assert(op - lastNCount == 3);
+        if (lastCountSize && (lastCountSize + bitstreamSize) < 4) {
+            /* lastCountSize >= 2 && bitstreamSize > 0 ==> lastCountSize == 3 */
+            assert(lastCountSize + bitstreamSize == 3);
             DEBUGLOG(5, "Avoiding bug in zstd decoder in versions <= 1.3.4 by "
                         "emitting an uncompressed block.");
             return 0;
@@ -2287,7 +2598,7 @@ ZSTD_entropyCompressSequences_internal(seqStore_t* seqStorePtr,
 }
 
 MEM_STATIC size_t
-ZSTD_entropyCompressSequences(seqStore_t* seqStorePtr,
+ZSTD_entropyCompressSeqStore(seqStore_t* seqStorePtr,
                        const ZSTD_entropyCTables_t* prevEntropy,
                              ZSTD_entropyCTables_t* nextEntropy,
                        const ZSTD_CCtx_params* cctxParams,
@@ -2296,7 +2607,7 @@ ZSTD_entropyCompressSequences(seqStore_t* seqStorePtr,
                              void* entropyWorkspace, size_t entropyWkspSize,
                              int bmi2)
 {
-    size_t const cSize = ZSTD_entropyCompressSequences_internal(
+    size_t const cSize = ZSTD_entropyCompressSeqStore_internal(
                             seqStorePtr, prevEntropy, nextEntropy, cctxParams,
                             dst, dstCapacity,
                             entropyWorkspace, entropyWkspSize, bmi2);
@@ -2306,20 +2617,20 @@ ZSTD_entropyCompressSequences(seqStore_t* seqStorePtr,
      */
     if ((cSize == ERROR(dstSize_tooSmall)) & (srcSize <= dstCapacity))
         return 0;  /* block not compressed */
-    FORWARD_IF_ERROR(cSize, "ZSTD_entropyCompressSequences_internal failed");
+    FORWARD_IF_ERROR(cSize, "ZSTD_entropyCompressSeqStore_internal failed");
 
     /* Check compressibility */
     {   size_t const maxCSize = srcSize - ZSTD_minGain(srcSize, cctxParams->cParams.strategy);
         if (cSize >= maxCSize) return 0;  /* block not compressed */
     }
-    DEBUGLOG(4, "ZSTD_entropyCompressSequences() cSize: %zu\n", cSize);
+    DEBUGLOG(4, "ZSTD_entropyCompressSeqStore() cSize: %zu", cSize);
     return cSize;
 }
 
 /* ZSTD_selectBlockCompressor() :
  * Not static, but internal use only (used by long distance matcher)
  * assumption : strat is a valid strategy */
-ZSTD_blockCompressor ZSTD_selectBlockCompressor(ZSTD_strategy strat, ZSTD_dictMode_e dictMode)
+ZSTD_blockCompressor ZSTD_selectBlockCompressor(ZSTD_strategy strat, ZSTD_paramSwitch_e useRowMatchFinder, ZSTD_dictMode_e dictMode)
 {
     static const ZSTD_blockCompressor blockCompressor[4][ZSTD_STRATEGY_MAX+1] = {
         { ZSTD_compressBlock_fast  /* default for 0 */,
@@ -2367,7 +2678,28 @@ ZSTD_blockCompressor ZSTD_selectBlockCompressor(ZSTD_strategy strat, ZSTD_dictMo
     ZSTD_STATIC_ASSERT((unsigned)ZSTD_fast == 1);
 
     assert(ZSTD_cParam_withinBounds(ZSTD_c_strategy, strat));
-    selectedCompressor = blockCompressor[(int)dictMode][(int)strat];
+    DEBUGLOG(4, "Selected block compressor: dictMode=%d strat=%d rowMatchfinder=%d", (int)dictMode, (int)strat, (int)useRowMatchFinder);
+    if (ZSTD_rowMatchFinderUsed(strat, useRowMatchFinder)) {
+        static const ZSTD_blockCompressor rowBasedBlockCompressors[4][3] = {
+            { ZSTD_compressBlock_greedy_row,
+            ZSTD_compressBlock_lazy_row,
+            ZSTD_compressBlock_lazy2_row },
+            { ZSTD_compressBlock_greedy_extDict_row,
+            ZSTD_compressBlock_lazy_extDict_row,
+            ZSTD_compressBlock_lazy2_extDict_row },
+            { ZSTD_compressBlock_greedy_dictMatchState_row,
+            ZSTD_compressBlock_lazy_dictMatchState_row,
+            ZSTD_compressBlock_lazy2_dictMatchState_row },
+            { ZSTD_compressBlock_greedy_dedicatedDictSearch_row,
+            ZSTD_compressBlock_lazy_dedicatedDictSearch_row,
+            ZSTD_compressBlock_lazy2_dedicatedDictSearch_row }
+        };
+        DEBUGLOG(4, "Selecting a row-based matchfinder");
+        assert(useRowMatchFinder != ZSTD_ps_auto);
+        selectedCompressor = rowBasedBlockCompressors[(int)dictMode][(int)strat - (int)ZSTD_greedy];
+    } else {
+        selectedCompressor = blockCompressor[(int)dictMode][(int)strat];
+    }
     assert(selectedCompressor != NULL);
     return selectedCompressor;
 }
@@ -2383,7 +2715,7 @@ void ZSTD_resetSeqStore(seqStore_t* ssPtr)
 {
     ssPtr->lit = ssPtr->litStart;
     ssPtr->sequences = ssPtr->sequencesStart;
-    ssPtr->longLengthID = 0;
+    ssPtr->longLengthType = ZSTD_llt_none;
 }
 
 typedef enum { ZSTDbss_compress, ZSTDbss_noCompress } ZSTD_buildSeqStore_e;
@@ -2430,15 +2762,16 @@ static size_t ZSTD_buildSeqStore(ZSTD_CCtx* zc, const void* src, size_t srcSize)
                 zc->blockState.nextCBlock->rep[i] = zc->blockState.prevCBlock->rep[i];
         }
         if (zc->externSeqStore.pos < zc->externSeqStore.size) {
-            assert(!zc->appliedParams.ldmParams.enableLdm);
+            assert(zc->appliedParams.ldmParams.enableLdm == ZSTD_ps_disable);
             /* Updates ldmSeqStore.pos */
             lastLLSize =
                 ZSTD_ldm_blockCompress(&zc->externSeqStore,
                                        ms, &zc->seqStore,
                                        zc->blockState.nextCBlock->rep,
+                                       zc->appliedParams.useRowMatchFinder,
                                        src, srcSize);
             assert(zc->externSeqStore.pos <= zc->externSeqStore.size);
-        } else if (zc->appliedParams.ldmParams.enableLdm) {
+        } else if (zc->appliedParams.ldmParams.enableLdm == ZSTD_ps_enable) {
             rawSeqStore_t ldmSeqStore = kNullRawSeqStore;
 
             ldmSeqStore.seq = zc->ldmSequences;
@@ -2452,10 +2785,13 @@ static size_t ZSTD_buildSeqStore(ZSTD_CCtx* zc, const void* src, size_t srcSize)
                 ZSTD_ldm_blockCompress(&ldmSeqStore,
                                        ms, &zc->seqStore,
                                        zc->blockState.nextCBlock->rep,
+                                       zc->appliedParams.useRowMatchFinder,
                                        src, srcSize);
             assert(ldmSeqStore.pos == ldmSeqStore.size);
         } else {   /* not long range mode */
-            ZSTD_blockCompressor const blockCompressor = ZSTD_selectBlockCompressor(zc->appliedParams.cParams.strategy, dictMode);
+            ZSTD_blockCompressor const blockCompressor = ZSTD_selectBlockCompressor(zc->appliedParams.cParams.strategy,
+                                                                                    zc->appliedParams.useRowMatchFinder,
+                                                                                    dictMode);
             ms->ldmSeqStore = NULL;
             lastLLSize = blockCompressor(ms, &zc->seqStore, zc->blockState.nextCBlock->rep, src, srcSize);
         }
@@ -2483,22 +2819,22 @@ static void ZSTD_copyBlockSequences(ZSTD_CCtx* zc)
     assert(zc->seqCollector.maxSequences >= seqStoreSeqSize + 1);
     ZSTD_memcpy(updatedRepcodes.rep, zc->blockState.prevCBlock->rep, sizeof(repcodes_t));
     for (i = 0; i < seqStoreSeqSize; ++i) {
-        U32 rawOffset = seqStoreSeqs[i].offset - ZSTD_REP_NUM;
+        U32 rawOffset = seqStoreSeqs[i].offBase - ZSTD_REP_NUM;
         outSeqs[i].litLength = seqStoreSeqs[i].litLength;
-        outSeqs[i].matchLength = seqStoreSeqs[i].matchLength + MINMATCH;
+        outSeqs[i].matchLength = seqStoreSeqs[i].mlBase + MINMATCH;
         outSeqs[i].rep = 0;
 
         if (i == seqStore->longLengthPos) {
-            if (seqStore->longLengthID == 1) {
+            if (seqStore->longLengthType == ZSTD_llt_literalLength) {
                 outSeqs[i].litLength += 0x10000;
-            } else if (seqStore->longLengthID == 2) {
+            } else if (seqStore->longLengthType == ZSTD_llt_matchLength) {
                 outSeqs[i].matchLength += 0x10000;
             }
         }
 
-        if (seqStoreSeqs[i].offset <= ZSTD_REP_NUM) {
+        if (seqStoreSeqs[i].offBase <= ZSTD_REP_NUM) {
             /* Derive the correct offset corresponding to a repcode */
-            outSeqs[i].rep = seqStoreSeqs[i].offset;
+            outSeqs[i].rep = seqStoreSeqs[i].offBase;
             if (outSeqs[i].litLength != 0) {
                 rawOffset = updatedRepcodes.rep[outSeqs[i].rep - 1];
             } else {
@@ -2512,9 +2848,9 @@ static void ZSTD_copyBlockSequences(ZSTD_CCtx* zc)
         outSeqs[i].offset = rawOffset;
         /* seqStoreSeqs[i].offset == offCode+1, and ZSTD_updateRep() expects offCode
            so we provide seqStoreSeqs[i].offset - 1 */
-        updatedRepcodes = ZSTD_updateRep(updatedRepcodes.rep,
-                                         seqStoreSeqs[i].offset - 1,
-                                         seqStoreSeqs[i].litLength == 0);
+        ZSTD_updateRep(updatedRepcodes.rep,
+                       seqStoreSeqs[i].offBase - 1,
+                       seqStoreSeqs[i].litLength == 0);
         literalsRead += outSeqs[i].litLength;
     }
     /* Insert last literals (if any exist) in the block as a sequence with ml == off == 0.
@@ -2602,16 +2938,740 @@ static int ZSTD_maybeRLE(seqStore_t const* seqStore)
     return nbSeqs < 4 && nbLits < 10;
 }
 
-static void ZSTD_confirmRepcodesAndEntropyTables(ZSTD_CCtx* zc)
+static void ZSTD_blockState_confirmRepcodesAndEntropyTables(ZSTD_blockState_t* const bs)
+{
+    ZSTD_compressedBlockState_t* const tmp = bs->prevCBlock;
+    bs->prevCBlock = bs->nextCBlock;
+    bs->nextCBlock = tmp;
+}
+
+/* Writes the block header */
+static void writeBlockHeader(void* op, size_t cSize, size_t blockSize, U32 lastBlock) {
+    U32 const cBlockHeader = cSize == 1 ?
+                        lastBlock + (((U32)bt_rle)<<1) + (U32)(blockSize << 3) :
+                        lastBlock + (((U32)bt_compressed)<<1) + (U32)(cSize << 3);
+    MEM_writeLE24(op, cBlockHeader);
+    DEBUGLOG(3, "writeBlockHeader: cSize: %zu blockSize: %zu lastBlock: %u", cSize, blockSize, lastBlock);
+}
+
+/* ZSTD_buildBlockEntropyStats_literals() :
+ *  Builds entropy for the literals.
+ *  Stores literals block type (raw, rle, compressed, repeat) and
+ *  huffman description table to hufMetadata.
+ *  Requires ENTROPY_WORKSPACE_SIZE workspace
+ *  @return : size of huffman description table or error code */
+static size_t ZSTD_buildBlockEntropyStats_literals(void* const src, size_t srcSize,
+                                            const ZSTD_hufCTables_t* prevHuf,
+                                                  ZSTD_hufCTables_t* nextHuf,
+                                                  ZSTD_hufCTablesMetadata_t* hufMetadata,
+                                                  const int literalsCompressionIsDisabled,
+                                                  void* workspace, size_t wkspSize)
+{
+    BYTE* const wkspStart = (BYTE*)workspace;
+    BYTE* const wkspEnd = wkspStart + wkspSize;
+    BYTE* const countWkspStart = wkspStart;
+    unsigned* const countWksp = (unsigned*)workspace;
+    const size_t countWkspSize = (HUF_SYMBOLVALUE_MAX + 1) * sizeof(unsigned);
+    BYTE* const nodeWksp = countWkspStart + countWkspSize;
+    const size_t nodeWkspSize = wkspEnd-nodeWksp;
+    unsigned maxSymbolValue = HUF_SYMBOLVALUE_MAX;
+    unsigned huffLog = HUF_TABLELOG_DEFAULT;
+    HUF_repeat repeat = prevHuf->repeatMode;
+    DEBUGLOG(5, "ZSTD_buildBlockEntropyStats_literals (srcSize=%zu)", srcSize);
+
+    /* Prepare nextEntropy assuming reusing the existing table */
+    ZSTD_memcpy(nextHuf, prevHuf, sizeof(*prevHuf));
+
+    if (literalsCompressionIsDisabled) {
+        DEBUGLOG(5, "set_basic - disabled");
+        hufMetadata->hType = set_basic;
+        return 0;
+    }
+
+    /* small ? don't even attempt compression (speed opt) */
+#ifndef COMPRESS_LITERALS_SIZE_MIN
+#define COMPRESS_LITERALS_SIZE_MIN 63
+#endif
+    {   size_t const minLitSize = (prevHuf->repeatMode == HUF_repeat_valid) ? 6 : COMPRESS_LITERALS_SIZE_MIN;
+        if (srcSize <= minLitSize) {
+            DEBUGLOG(5, "set_basic - too small");
+            hufMetadata->hType = set_basic;
+            return 0;
+        }
+    }
+
+    /* Scan input and build symbol stats */
+    {   size_t const largest = HIST_count_wksp (countWksp, &maxSymbolValue, (const BYTE*)src, srcSize, workspace, wkspSize);
+        FORWARD_IF_ERROR(largest, "HIST_count_wksp failed");
+        if (largest == srcSize) {
+            DEBUGLOG(5, "set_rle");
+            hufMetadata->hType = set_rle;
+            return 0;
+        }
+        if (largest <= (srcSize >> 7)+4) {
+            DEBUGLOG(5, "set_basic - no gain");
+            hufMetadata->hType = set_basic;
+            return 0;
+        }
+    }
+
+    /* Validate the previous Huffman table */
+    if (repeat == HUF_repeat_check && !HUF_validateCTable((HUF_CElt const*)prevHuf->CTable, countWksp, maxSymbolValue)) {
+        repeat = HUF_repeat_none;
+    }
+
+    /* Build Huffman Tree */
+    ZSTD_memset(nextHuf->CTable, 0, sizeof(nextHuf->CTable));
+    huffLog = HUF_optimalTableLog(huffLog, srcSize, maxSymbolValue);
+    {   size_t const maxBits = HUF_buildCTable_wksp((HUF_CElt*)nextHuf->CTable, countWksp,
+                                                    maxSymbolValue, huffLog,
+                                                    nodeWksp, nodeWkspSize);
+        FORWARD_IF_ERROR(maxBits, "HUF_buildCTable_wksp");
+        huffLog = (U32)maxBits;
+        {   /* Build and write the CTable */
+            size_t const newCSize = HUF_estimateCompressedSize(
+                    (HUF_CElt*)nextHuf->CTable, countWksp, maxSymbolValue);
+            size_t const hSize = HUF_writeCTable_wksp(
+                    hufMetadata->hufDesBuffer, sizeof(hufMetadata->hufDesBuffer),
+                    (HUF_CElt*)nextHuf->CTable, maxSymbolValue, huffLog,
+                    nodeWksp, nodeWkspSize);
+            /* Check against repeating the previous CTable */
+            if (repeat != HUF_repeat_none) {
+                size_t const oldCSize = HUF_estimateCompressedSize(
+                        (HUF_CElt const*)prevHuf->CTable, countWksp, maxSymbolValue);
+                if (oldCSize < srcSize && (oldCSize <= hSize + newCSize || hSize + 12 >= srcSize)) {
+                    DEBUGLOG(5, "set_repeat - smaller");
+                    ZSTD_memcpy(nextHuf, prevHuf, sizeof(*prevHuf));
+                    hufMetadata->hType = set_repeat;
+                    return 0;
+                }
+            }
+            if (newCSize + hSize >= srcSize) {
+                DEBUGLOG(5, "set_basic - no gains");
+                ZSTD_memcpy(nextHuf, prevHuf, sizeof(*prevHuf));
+                hufMetadata->hType = set_basic;
+                return 0;
+            }
+            DEBUGLOG(5, "set_compressed (hSize=%u)", (U32)hSize);
+            hufMetadata->hType = set_compressed;
+            nextHuf->repeatMode = HUF_repeat_check;
+            return hSize;
+        }
+    }
+}
+
+
+/* ZSTD_buildDummySequencesStatistics():
+ * Returns a ZSTD_symbolEncodingTypeStats_t with all encoding types as set_basic,
+ * and updates nextEntropy to the appropriate repeatMode.
+ */
+static ZSTD_symbolEncodingTypeStats_t
+ZSTD_buildDummySequencesStatistics(ZSTD_fseCTables_t* nextEntropy) {
+    ZSTD_symbolEncodingTypeStats_t stats = {set_basic, set_basic, set_basic, 0, 0};
+    nextEntropy->litlength_repeatMode = FSE_repeat_none;
+    nextEntropy->offcode_repeatMode = FSE_repeat_none;
+    nextEntropy->matchlength_repeatMode = FSE_repeat_none;
+    return stats;
+}
+
+/* ZSTD_buildBlockEntropyStats_sequences() :
+ *  Builds entropy for the sequences.
+ *  Stores symbol compression modes and fse table to fseMetadata.
+ *  Requires ENTROPY_WORKSPACE_SIZE wksp.
+ *  @return : size of fse tables or error code */
+static size_t ZSTD_buildBlockEntropyStats_sequences(seqStore_t* seqStorePtr,
+                                              const ZSTD_fseCTables_t* prevEntropy,
+                                                    ZSTD_fseCTables_t* nextEntropy,
+                                              const ZSTD_CCtx_params* cctxParams,
+                                                    ZSTD_fseCTablesMetadata_t* fseMetadata,
+                                                    void* workspace, size_t wkspSize)
+{
+    ZSTD_strategy const strategy = cctxParams->cParams.strategy;
+    size_t const nbSeq = seqStorePtr->sequences - seqStorePtr->sequencesStart;
+    BYTE* const ostart = fseMetadata->fseTablesBuffer;
+    BYTE* const oend = ostart + sizeof(fseMetadata->fseTablesBuffer);
+    BYTE* op = ostart;
+    unsigned* countWorkspace = (unsigned*)workspace;
+    unsigned* entropyWorkspace = countWorkspace + (MaxSeq + 1);
+    size_t entropyWorkspaceSize = wkspSize - (MaxSeq + 1) * sizeof(*countWorkspace);
+    ZSTD_symbolEncodingTypeStats_t stats;
+
+    DEBUGLOG(5, "ZSTD_buildBlockEntropyStats_sequences (nbSeq=%zu)", nbSeq);
+    stats = nbSeq != 0 ? ZSTD_buildSequencesStatistics(seqStorePtr, nbSeq,
+                                          prevEntropy, nextEntropy, op, oend,
+                                          strategy, countWorkspace,
+                                          entropyWorkspace, entropyWorkspaceSize)
+                       : ZSTD_buildDummySequencesStatistics(nextEntropy);
+    FORWARD_IF_ERROR(stats.size, "ZSTD_buildSequencesStatistics failed!");
+    fseMetadata->llType = (symbolEncodingType_e) stats.LLtype;
+    fseMetadata->ofType = (symbolEncodingType_e) stats.Offtype;
+    fseMetadata->mlType = (symbolEncodingType_e) stats.MLtype;
+    fseMetadata->lastCountSize = stats.lastCountSize;
+    return stats.size;
+}
+
+
+/* ZSTD_buildBlockEntropyStats() :
+ *  Builds entropy for the block.
+ *  Requires workspace size ENTROPY_WORKSPACE_SIZE
+ *
+ *  @return : 0 on success or error code
+ */
+size_t ZSTD_buildBlockEntropyStats(seqStore_t* seqStorePtr,
+                             const ZSTD_entropyCTables_t* prevEntropy,
+                                   ZSTD_entropyCTables_t* nextEntropy,
+                             const ZSTD_CCtx_params* cctxParams,
+                                   ZSTD_entropyCTablesMetadata_t* entropyMetadata,
+                                   void* workspace, size_t wkspSize)
+{
+    size_t const litSize = seqStorePtr->lit - seqStorePtr->litStart;
+    entropyMetadata->hufMetadata.hufDesSize =
+        ZSTD_buildBlockEntropyStats_literals(seqStorePtr->litStart, litSize,
+                                            &prevEntropy->huf, &nextEntropy->huf,
+                                            &entropyMetadata->hufMetadata,
+                                            ZSTD_literalsCompressionIsDisabled(cctxParams),
+                                            workspace, wkspSize);
+    FORWARD_IF_ERROR(entropyMetadata->hufMetadata.hufDesSize, "ZSTD_buildBlockEntropyStats_literals failed");
+    entropyMetadata->fseMetadata.fseTablesSize =
+        ZSTD_buildBlockEntropyStats_sequences(seqStorePtr,
+                                              &prevEntropy->fse, &nextEntropy->fse,
+                                              cctxParams,
+                                              &entropyMetadata->fseMetadata,
+                                              workspace, wkspSize);
+    FORWARD_IF_ERROR(entropyMetadata->fseMetadata.fseTablesSize, "ZSTD_buildBlockEntropyStats_sequences failed");
+    return 0;
+}
+
+/* Returns the size estimate for the literals section (header + content) of a block */
+static size_t ZSTD_estimateBlockSize_literal(const BYTE* literals, size_t litSize,
+                                                const ZSTD_hufCTables_t* huf,
+                                                const ZSTD_hufCTablesMetadata_t* hufMetadata,
+                                                void* workspace, size_t wkspSize,
+                                                int writeEntropy)
+{
+    unsigned* const countWksp = (unsigned*)workspace;
+    unsigned maxSymbolValue = HUF_SYMBOLVALUE_MAX;
+    size_t literalSectionHeaderSize = 3 + (litSize >= 1 KB) + (litSize >= 16 KB);
+    U32 singleStream = litSize < 256;
+
+    if (hufMetadata->hType == set_basic) return litSize;
+    else if (hufMetadata->hType == set_rle) return 1;
+    else if (hufMetadata->hType == set_compressed || hufMetadata->hType == set_repeat) {
+        size_t const largest = HIST_count_wksp (countWksp, &maxSymbolValue, (const BYTE*)literals, litSize, workspace, wkspSize);
+        if (ZSTD_isError(largest)) return litSize;
+        {   size_t cLitSizeEstimate = HUF_estimateCompressedSize((const HUF_CElt*)huf->CTable, countWksp, maxSymbolValue);
+            if (writeEntropy) cLitSizeEstimate += hufMetadata->hufDesSize;
+            if (!singleStream) cLitSizeEstimate += 6; /* multi-stream huffman uses 6-byte jump table */
+            return cLitSizeEstimate + literalSectionHeaderSize;
+    }   }
+    assert(0); /* impossible */
+    return 0;
+}
+
+/* Returns the size estimate for the FSE-compressed symbols (of, ml, ll) of a block */
+static size_t ZSTD_estimateBlockSize_symbolType(symbolEncodingType_e type,
+                        const BYTE* codeTable, size_t nbSeq, unsigned maxCode,
+                        const FSE_CTable* fseCTable,
+                        const U8* additionalBits,
+                        short const* defaultNorm, U32 defaultNormLog, U32 defaultMax,
+                        void* workspace, size_t wkspSize)
+{
+    unsigned* const countWksp = (unsigned*)workspace;
+    const BYTE* ctp = codeTable;
+    const BYTE* const ctStart = ctp;
+    const BYTE* const ctEnd = ctStart + nbSeq;
+    size_t cSymbolTypeSizeEstimateInBits = 0;
+    unsigned max = maxCode;
+
+    HIST_countFast_wksp(countWksp, &max, codeTable, nbSeq, workspace, wkspSize);  /* can't fail */
+    if (type == set_basic) {
+        /* We selected this encoding type, so it must be valid. */
+        assert(max <= defaultMax);
+        (void)defaultMax;
+        cSymbolTypeSizeEstimateInBits = ZSTD_crossEntropyCost(defaultNorm, defaultNormLog, countWksp, max);
+    } else if (type == set_rle) {
+        cSymbolTypeSizeEstimateInBits = 0;
+    } else if (type == set_compressed || type == set_repeat) {
+        cSymbolTypeSizeEstimateInBits = ZSTD_fseBitCost(fseCTable, countWksp, max);
+    }
+    if (ZSTD_isError(cSymbolTypeSizeEstimateInBits)) {
+        return nbSeq * 10;
+    }
+    while (ctp < ctEnd) {
+        if (additionalBits) cSymbolTypeSizeEstimateInBits += additionalBits[*ctp];
+        else cSymbolTypeSizeEstimateInBits += *ctp; /* for offset, offset code is also the number of additional bits */
+        ctp++;
+    }
+    return cSymbolTypeSizeEstimateInBits >> 3;
+}
+
+/* Returns the size estimate for the sequences section (header + content) of a block */
+static size_t ZSTD_estimateBlockSize_sequences(const BYTE* ofCodeTable,
+                                                  const BYTE* llCodeTable,
+                                                  const BYTE* mlCodeTable,
+                                                  size_t nbSeq,
+                                                  const ZSTD_fseCTables_t* fseTables,
+                                                  const ZSTD_fseCTablesMetadata_t* fseMetadata,
+                                                  void* workspace, size_t wkspSize,
+                                                  int writeEntropy)
+{
+    size_t sequencesSectionHeaderSize = 1 /* seqHead */ + 1 /* min seqSize size */ + (nbSeq >= 128) + (nbSeq >= LONGNBSEQ);
+    size_t cSeqSizeEstimate = 0;
+    cSeqSizeEstimate += ZSTD_estimateBlockSize_symbolType(fseMetadata->ofType, ofCodeTable, nbSeq, MaxOff,
+                                         fseTables->offcodeCTable, NULL,
+                                         OF_defaultNorm, OF_defaultNormLog, DefaultMaxOff,
+                                         workspace, wkspSize);
+    cSeqSizeEstimate += ZSTD_estimateBlockSize_symbolType(fseMetadata->llType, llCodeTable, nbSeq, MaxLL,
+                                         fseTables->litlengthCTable, LL_bits,
+                                         LL_defaultNorm, LL_defaultNormLog, MaxLL,
+                                         workspace, wkspSize);
+    cSeqSizeEstimate += ZSTD_estimateBlockSize_symbolType(fseMetadata->mlType, mlCodeTable, nbSeq, MaxML,
+                                         fseTables->matchlengthCTable, ML_bits,
+                                         ML_defaultNorm, ML_defaultNormLog, MaxML,
+                                         workspace, wkspSize);
+    if (writeEntropy) cSeqSizeEstimate += fseMetadata->fseTablesSize;
+    return cSeqSizeEstimate + sequencesSectionHeaderSize;
+}
+
+/* Returns the size estimate for a given stream of literals, of, ll, ml */
+static size_t ZSTD_estimateBlockSize(const BYTE* literals, size_t litSize,
+                                     const BYTE* ofCodeTable,
+                                     const BYTE* llCodeTable,
+                                     const BYTE* mlCodeTable,
+                                     size_t nbSeq,
+                                     const ZSTD_entropyCTables_t* entropy,
+                                     const ZSTD_entropyCTablesMetadata_t* entropyMetadata,
+                                     void* workspace, size_t wkspSize,
+                                     int writeLitEntropy, int writeSeqEntropy) {
+    size_t const literalsSize = ZSTD_estimateBlockSize_literal(literals, litSize,
+                                                         &entropy->huf, &entropyMetadata->hufMetadata,
+                                                         workspace, wkspSize, writeLitEntropy);
+    size_t const seqSize = ZSTD_estimateBlockSize_sequences(ofCodeTable, llCodeTable, mlCodeTable,
+                                                         nbSeq, &entropy->fse, &entropyMetadata->fseMetadata,
+                                                         workspace, wkspSize, writeSeqEntropy);
+    return seqSize + literalsSize + ZSTD_blockHeaderSize;
+}
+
+/* Builds entropy statistics and uses them for blocksize estimation.
+ *
+ * Returns the estimated compressed size of the seqStore, or a zstd error.
+ */
+static size_t ZSTD_buildEntropyStatisticsAndEstimateSubBlockSize(seqStore_t* seqStore, ZSTD_CCtx* zc) {
+    ZSTD_entropyCTablesMetadata_t* entropyMetadata = &zc->blockSplitCtx.entropyMetadata;
+    DEBUGLOG(6, "ZSTD_buildEntropyStatisticsAndEstimateSubBlockSize()");
+    FORWARD_IF_ERROR(ZSTD_buildBlockEntropyStats(seqStore,
+                    &zc->blockState.prevCBlock->entropy,
+                    &zc->blockState.nextCBlock->entropy,
+                    &zc->appliedParams,
+                    entropyMetadata,
+                    zc->entropyWorkspace, ENTROPY_WORKSPACE_SIZE /* statically allocated in resetCCtx */), "");
+    return ZSTD_estimateBlockSize(seqStore->litStart, (size_t)(seqStore->lit - seqStore->litStart),
+                    seqStore->ofCode, seqStore->llCode, seqStore->mlCode,
+                    (size_t)(seqStore->sequences - seqStore->sequencesStart),
+                    &zc->blockState.nextCBlock->entropy, entropyMetadata, zc->entropyWorkspace, ENTROPY_WORKSPACE_SIZE,
+                    (int)(entropyMetadata->hufMetadata.hType == set_compressed), 1);
+}
+
+/* Returns literals bytes represented in a seqStore */
+static size_t ZSTD_countSeqStoreLiteralsBytes(const seqStore_t* const seqStore) {
+    size_t literalsBytes = 0;
+    size_t const nbSeqs = seqStore->sequences - seqStore->sequencesStart;
+    size_t i;
+    for (i = 0; i < nbSeqs; ++i) {
+        seqDef seq = seqStore->sequencesStart[i];
+        literalsBytes += seq.litLength;
+        if (i == seqStore->longLengthPos && seqStore->longLengthType == ZSTD_llt_literalLength) {
+            literalsBytes += 0x10000;
+        }
+    }
+    return literalsBytes;
+}
+
+/* Returns match bytes represented in a seqStore */
+static size_t ZSTD_countSeqStoreMatchBytes(const seqStore_t* const seqStore) {
+    size_t matchBytes = 0;
+    size_t const nbSeqs = seqStore->sequences - seqStore->sequencesStart;
+    size_t i;
+    for (i = 0; i < nbSeqs; ++i) {
+        seqDef seq = seqStore->sequencesStart[i];
+        matchBytes += seq.mlBase + MINMATCH;
+        if (i == seqStore->longLengthPos && seqStore->longLengthType == ZSTD_llt_matchLength) {
+            matchBytes += 0x10000;
+        }
+    }
+    return matchBytes;
+}
+
+/* Derives the seqStore that is a chunk of the originalSeqStore from [startIdx, endIdx).
+ * Stores the result in resultSeqStore.
+ */
+static void ZSTD_deriveSeqStoreChunk(seqStore_t* resultSeqStore,
+                               const seqStore_t* originalSeqStore,
+                                     size_t startIdx, size_t endIdx) {
+    BYTE* const litEnd = originalSeqStore->lit;
+    size_t literalsBytes;
+    size_t literalsBytesPreceding = 0;
+
+    *resultSeqStore = *originalSeqStore;
+    if (startIdx > 0) {
+        resultSeqStore->sequences = originalSeqStore->sequencesStart + startIdx;
+        literalsBytesPreceding = ZSTD_countSeqStoreLiteralsBytes(resultSeqStore);
+    }
+
+    /* Move longLengthPos into the correct position if necessary */
+    if (originalSeqStore->longLengthType != ZSTD_llt_none) {
+        if (originalSeqStore->longLengthPos < startIdx || originalSeqStore->longLengthPos > endIdx) {
+            resultSeqStore->longLengthType = ZSTD_llt_none;
+        } else {
+            resultSeqStore->longLengthPos -= (U32)startIdx;
+        }
+    }
+    resultSeqStore->sequencesStart = originalSeqStore->sequencesStart + startIdx;
+    resultSeqStore->sequences = originalSeqStore->sequencesStart + endIdx;
+    literalsBytes = ZSTD_countSeqStoreLiteralsBytes(resultSeqStore);
+    resultSeqStore->litStart += literalsBytesPreceding;
+    if (endIdx == (size_t)(originalSeqStore->sequences - originalSeqStore->sequencesStart)) {
+        /* This accounts for possible last literals if the derived chunk reaches the end of the block */
+        resultSeqStore->lit = litEnd;
+    } else {
+        resultSeqStore->lit = resultSeqStore->litStart+literalsBytes;
+    }
+    resultSeqStore->llCode += startIdx;
+    resultSeqStore->mlCode += startIdx;
+    resultSeqStore->ofCode += startIdx;
+}
+
+/*
+ * Returns the raw offset represented by the combination of offCode, ll0, and repcode history.
+ * offCode must represent a repcode in the numeric representation of ZSTD_storeSeq().
+ */
+static U32
+ZSTD_resolveRepcodeToRawOffset(const U32 rep[ZSTD_REP_NUM], const U32 offCode, const U32 ll0)
+{
+    U32 const adjustedOffCode = STORED_REPCODE(offCode) - 1 + ll0;  /* [ 0 - 3 ] */
+    assert(STORED_IS_REPCODE(offCode));
+    if (adjustedOffCode == ZSTD_REP_NUM) {
+        /* litlength == 0 and offCode == 2 implies selection of first repcode - 1 */
+        assert(rep[0] > 0);
+        return rep[0] - 1;
+    }
+    return rep[adjustedOffCode];
+}
+
+/*
+ * ZSTD_seqStore_resolveOffCodes() reconciles any possible divergences in offset history that may arise
+ * due to emission of RLE/raw blocks that disturb the offset history,
+ * and replaces any repcodes within the seqStore that may be invalid.
+ *
+ * dRepcodes are updated as would be on the decompression side.
+ * cRepcodes are updated exactly in accordance with the seqStore.
+ *
+ * Note : this function assumes seq->offBase respects the following numbering scheme :
+ *        0 : invalid
+ *        1-3 : repcode 1-3
+ *        4+ : real_offset+3
+ */
+static void ZSTD_seqStore_resolveOffCodes(repcodes_t* const dRepcodes, repcodes_t* const cRepcodes,
+                                          seqStore_t* const seqStore, U32 const nbSeq) {
+    U32 idx = 0;
+    for (; idx < nbSeq; ++idx) {
+        seqDef* const seq = seqStore->sequencesStart + idx;
+        U32 const ll0 = (seq->litLength == 0);
+        U32 const offCode = OFFBASE_TO_STORED(seq->offBase);
+        assert(seq->offBase > 0);
+        if (STORED_IS_REPCODE(offCode)) {
+            U32 const dRawOffset = ZSTD_resolveRepcodeToRawOffset(dRepcodes->rep, offCode, ll0);
+            U32 const cRawOffset = ZSTD_resolveRepcodeToRawOffset(cRepcodes->rep, offCode, ll0);
+            /* Adjust simulated decompression repcode history if we come across a mismatch. Replace
+             * the repcode with the offset it actually references, determined by the compression
+             * repcode history.
+             */
+            if (dRawOffset != cRawOffset) {
+                seq->offBase = cRawOffset + ZSTD_REP_NUM;
+            }
+        }
+        /* Compression repcode history is always updated with values directly from the unmodified seqStore.
+         * Decompression repcode history may use modified seq->offset value taken from compression repcode history.
+         */
+        ZSTD_updateRep(dRepcodes->rep, OFFBASE_TO_STORED(seq->offBase), ll0);
+        ZSTD_updateRep(cRepcodes->rep, offCode, ll0);
+    }
+}
+
+/* ZSTD_compressSeqStore_singleBlock():
+ * Compresses a seqStore into a block with a block header, into the buffer dst.
+ *
+ * Returns the total size of that block (including header) or a ZSTD error code.
+ */
+static size_t
+ZSTD_compressSeqStore_singleBlock(ZSTD_CCtx* zc, seqStore_t* const seqStore,
+                                  repcodes_t* const dRep, repcodes_t* const cRep,
+                                  void* dst, size_t dstCapacity,
+                                  const void* src, size_t srcSize,
+                                  U32 lastBlock, U32 isPartition)
 {
-    ZSTD_compressedBlockState_t* const tmp = zc->blockState.prevCBlock;
-    zc->blockState.prevCBlock = zc->blockState.nextCBlock;
-    zc->blockState.nextCBlock = tmp;
+    const U32 rleMaxLength = 25;
+    BYTE* op = (BYTE*)dst;
+    const BYTE* ip = (const BYTE*)src;
+    size_t cSize;
+    size_t cSeqsSize;
+
+    /* In case of an RLE or raw block, the simulated decompression repcode history must be reset */
+    repcodes_t const dRepOriginal = *dRep;
+    DEBUGLOG(5, "ZSTD_compressSeqStore_singleBlock");
+    if (isPartition)
+        ZSTD_seqStore_resolveOffCodes(dRep, cRep, seqStore, (U32)(seqStore->sequences - seqStore->sequencesStart));
+
+    RETURN_ERROR_IF(dstCapacity < ZSTD_blockHeaderSize, dstSize_tooSmall, "Block header doesn't fit");
+    cSeqsSize = ZSTD_entropyCompressSeqStore(seqStore,
+                &zc->blockState.prevCBlock->entropy, &zc->blockState.nextCBlock->entropy,
+                &zc->appliedParams,
+                op + ZSTD_blockHeaderSize, dstCapacity - ZSTD_blockHeaderSize,
+                srcSize,
+                zc->entropyWorkspace, ENTROPY_WORKSPACE_SIZE /* statically allocated in resetCCtx */,
+                zc->bmi2);
+    FORWARD_IF_ERROR(cSeqsSize, "ZSTD_entropyCompressSeqStore failed!");
+
+    if (!zc->isFirstBlock &&
+        cSeqsSize < rleMaxLength &&
+        ZSTD_isRLE((BYTE const*)src, srcSize)) {
+        /* We don't want to emit our first block as a RLE even if it qualifies because
+        * doing so will cause the decoder (cli only) to throw a "should consume all input error."
+        * This is only an issue for zstd <= v1.4.3
+        */
+        cSeqsSize = 1;
+    }
+
+    if (zc->seqCollector.collectSequences) {
+        ZSTD_copyBlockSequences(zc);
+        ZSTD_blockState_confirmRepcodesAndEntropyTables(&zc->blockState);
+        return 0;
+    }
+
+    if (cSeqsSize == 0) {
+        cSize = ZSTD_noCompressBlock(op, dstCapacity, ip, srcSize, lastBlock);
+        FORWARD_IF_ERROR(cSize, "Nocompress block failed");
+        DEBUGLOG(4, "Writing out nocompress block, size: %zu", cSize);
+        *dRep = dRepOriginal; /* reset simulated decompression repcode history */
+    } else if (cSeqsSize == 1) {
+        cSize = ZSTD_rleCompressBlock(op, dstCapacity, *ip, srcSize, lastBlock);
+        FORWARD_IF_ERROR(cSize, "RLE compress block failed");
+        DEBUGLOG(4, "Writing out RLE block, size: %zu", cSize);
+        *dRep = dRepOriginal; /* reset simulated decompression repcode history */
+    } else {
+        ZSTD_blockState_confirmRepcodesAndEntropyTables(&zc->blockState);
+        writeBlockHeader(op, cSeqsSize, srcSize, lastBlock);
+        cSize = ZSTD_blockHeaderSize + cSeqsSize;
+        DEBUGLOG(4, "Writing out compressed block, size: %zu", cSize);
+    }
+
+    if (zc->blockState.prevCBlock->entropy.fse.offcode_repeatMode == FSE_repeat_valid)
+        zc->blockState.prevCBlock->entropy.fse.offcode_repeatMode = FSE_repeat_check;
+
+    return cSize;
+}
+
+/* Struct to keep track of where we are in our recursive calls. */
+typedef struct {
+    U32* splitLocations;    /* Array of split indices */
+    size_t idx;             /* The current index within splitLocations being worked on */
+} seqStoreSplits;
+
+#define MIN_SEQUENCES_BLOCK_SPLITTING 300
+
+/* Helper function to perform the recursive search for block splits.
+ * Estimates the cost of seqStore prior to split, and estimates the cost of splitting the sequences in half.
+ * If advantageous to split, then we recurse down the two sub-blocks. If not, or if an error occurred in estimation, then
+ * we do not recurse.
+ *
+ * Note: The recursion depth is capped by a heuristic minimum number of sequences, defined by MIN_SEQUENCES_BLOCK_SPLITTING.
+ * In theory, this means the absolute largest recursion depth is 10 == log2(maxNbSeqInBlock/MIN_SEQUENCES_BLOCK_SPLITTING).
+ * In practice, recursion depth usually doesn't go beyond 4.
+ *
+ * Furthermore, the number of splits is capped by ZSTD_MAX_NB_BLOCK_SPLITS. At ZSTD_MAX_NB_BLOCK_SPLITS == 196 with the current existing blockSize
+ * maximum of 128 KB, this value is actually impossible to reach.
+ */
+static void
+ZSTD_deriveBlockSplitsHelper(seqStoreSplits* splits, size_t startIdx, size_t endIdx,
+                             ZSTD_CCtx* zc, const seqStore_t* origSeqStore)
+{
+    seqStore_t* fullSeqStoreChunk = &zc->blockSplitCtx.fullSeqStoreChunk;
+    seqStore_t* firstHalfSeqStore = &zc->blockSplitCtx.firstHalfSeqStore;
+    seqStore_t* secondHalfSeqStore = &zc->blockSplitCtx.secondHalfSeqStore;
+    size_t estimatedOriginalSize;
+    size_t estimatedFirstHalfSize;
+    size_t estimatedSecondHalfSize;
+    size_t midIdx = (startIdx + endIdx)/2;
+
+    if (endIdx - startIdx < MIN_SEQUENCES_BLOCK_SPLITTING || splits->idx >= ZSTD_MAX_NB_BLOCK_SPLITS) {
+        DEBUGLOG(6, "ZSTD_deriveBlockSplitsHelper: Too few sequences");
+        return;
+    }
+    DEBUGLOG(4, "ZSTD_deriveBlockSplitsHelper: startIdx=%zu endIdx=%zu", startIdx, endIdx);
+    ZSTD_deriveSeqStoreChunk(fullSeqStoreChunk, origSeqStore, startIdx, endIdx);
+    ZSTD_deriveSeqStoreChunk(firstHalfSeqStore, origSeqStore, startIdx, midIdx);
+    ZSTD_deriveSeqStoreChunk(secondHalfSeqStore, origSeqStore, midIdx, endIdx);
+    estimatedOriginalSize = ZSTD_buildEntropyStatisticsAndEstimateSubBlockSize(fullSeqStoreChunk, zc);
+    estimatedFirstHalfSize = ZSTD_buildEntropyStatisticsAndEstimateSubBlockSize(firstHalfSeqStore, zc);
+    estimatedSecondHalfSize = ZSTD_buildEntropyStatisticsAndEstimateSubBlockSize(secondHalfSeqStore, zc);
+    DEBUGLOG(4, "Estimated original block size: %zu -- First half split: %zu -- Second half split: %zu",
+             estimatedOriginalSize, estimatedFirstHalfSize, estimatedSecondHalfSize);
+    if (ZSTD_isError(estimatedOriginalSize) || ZSTD_isError(estimatedFirstHalfSize) || ZSTD_isError(estimatedSecondHalfSize)) {
+        return;
+    }
+    if (estimatedFirstHalfSize + estimatedSecondHalfSize < estimatedOriginalSize) {
+        ZSTD_deriveBlockSplitsHelper(splits, startIdx, midIdx, zc, origSeqStore);
+        splits->splitLocations[splits->idx] = (U32)midIdx;
+        splits->idx++;
+        ZSTD_deriveBlockSplitsHelper(splits, midIdx, endIdx, zc, origSeqStore);
+    }
+}
+
+/* Base recursive function. Populates a table with intra-block partition indices that can improve compression ratio.
+ *
+ * Returns the number of splits made (which equals the size of the partition table - 1).
+ */
+static size_t ZSTD_deriveBlockSplits(ZSTD_CCtx* zc, U32 partitions[], U32 nbSeq) {
+    seqStoreSplits splits = {partitions, 0};
+    if (nbSeq <= 4) {
+        DEBUGLOG(4, "ZSTD_deriveBlockSplits: Too few sequences to split");
+        /* Refuse to try and split anything with less than 4 sequences */
+        return 0;
+    }
+    ZSTD_deriveBlockSplitsHelper(&splits, 0, nbSeq, zc, &zc->seqStore);
+    splits.splitLocations[splits.idx] = nbSeq;
+    DEBUGLOG(5, "ZSTD_deriveBlockSplits: final nb partitions: %zu", splits.idx+1);
+    return splits.idx;
+}
+
+/* ZSTD_compressBlock_splitBlock():
+ * Attempts to split a given block into multiple blocks to improve compression ratio.
+ *
+ * Returns combined size of all blocks (which includes headers), or a ZSTD error code.
+ */
+static size_t
+ZSTD_compressBlock_splitBlock_internal(ZSTD_CCtx* zc, void* dst, size_t dstCapacity,
+                                       const void* src, size_t blockSize, U32 lastBlock, U32 nbSeq)
+{
+    size_t cSize = 0;
+    const BYTE* ip = (const BYTE*)src;
+    BYTE* op = (BYTE*)dst;
+    size_t i = 0;
+    size_t srcBytesTotal = 0;
+    U32* partitions = zc->blockSplitCtx.partitions; /* size == ZSTD_MAX_NB_BLOCK_SPLITS */
+    seqStore_t* nextSeqStore = &zc->blockSplitCtx.nextSeqStore;
+    seqStore_t* currSeqStore = &zc->blockSplitCtx.currSeqStore;
+    size_t numSplits = ZSTD_deriveBlockSplits(zc, partitions, nbSeq);
+
+    /* If a block is split and some partitions are emitted as RLE/uncompressed, then repcode history
+     * may become invalid. In order to reconcile potentially invalid repcodes, we keep track of two
+     * separate repcode histories that simulate repcode history on compression and decompression side,
+     * and use the histories to determine whether we must replace a particular repcode with its raw offset.
+     *
+     * 1) cRep gets updated for each partition, regardless of whether the block was emitted as uncompressed
+     *    or RLE. This allows us to retrieve the offset value that an invalid repcode references within
+     *    a nocompress/RLE block.
+     * 2) dRep gets updated only for compressed partitions, and when a repcode gets replaced, will use
+     *    the replacement offset value rather than the original repcode to update the repcode history.
+     *    dRep also will be the final repcode history sent to the next block.
+     *
+     * See ZSTD_seqStore_resolveOffCodes() for more details.
+     */
+    repcodes_t dRep;
+    repcodes_t cRep;
+    ZSTD_memcpy(dRep.rep, zc->blockState.prevCBlock->rep, sizeof(repcodes_t));
+    ZSTD_memcpy(cRep.rep, zc->blockState.prevCBlock->rep, sizeof(repcodes_t));
+    ZSTD_memset(nextSeqStore, 0, sizeof(seqStore_t));
+
+    DEBUGLOG(4, "ZSTD_compressBlock_splitBlock_internal (dstCapacity=%u, dictLimit=%u, nextToUpdate=%u)",
+                (unsigned)dstCapacity, (unsigned)zc->blockState.matchState.window.dictLimit,
+                (unsigned)zc->blockState.matchState.nextToUpdate);
+
+    if (numSplits == 0) {
+        size_t cSizeSingleBlock = ZSTD_compressSeqStore_singleBlock(zc, &zc->seqStore,
+                                                                   &dRep, &cRep,
+                                                                    op, dstCapacity,
+                                                                    ip, blockSize,
+                                                                    lastBlock, 0 /* isPartition */);
+        FORWARD_IF_ERROR(cSizeSingleBlock, "Compressing single block from splitBlock_internal() failed!");
+        DEBUGLOG(5, "ZSTD_compressBlock_splitBlock_internal: No splits");
+        assert(cSizeSingleBlock <= ZSTD_BLOCKSIZE_MAX + ZSTD_blockHeaderSize);
+        return cSizeSingleBlock;
+    }
+
+    ZSTD_deriveSeqStoreChunk(currSeqStore, &zc->seqStore, 0, partitions[0]);
+    for (i = 0; i <= numSplits; ++i) {
+        size_t srcBytes;
+        size_t cSizeChunk;
+        U32 const lastPartition = (i == numSplits);
+        U32 lastBlockEntireSrc = 0;
+
+        srcBytes = ZSTD_countSeqStoreLiteralsBytes(currSeqStore) + ZSTD_countSeqStoreMatchBytes(currSeqStore);
+        srcBytesTotal += srcBytes;
+        if (lastPartition) {
+            /* This is the final partition, need to account for possible last literals */
+            srcBytes += blockSize - srcBytesTotal;
+            lastBlockEntireSrc = lastBlock;
+        } else {
+            ZSTD_deriveSeqStoreChunk(nextSeqStore, &zc->seqStore, partitions[i], partitions[i+1]);
+        }
+
+        cSizeChunk = ZSTD_compressSeqStore_singleBlock(zc, currSeqStore,
+                                                      &dRep, &cRep,
+                                                       op, dstCapacity,
+                                                       ip, srcBytes,
+                                                       lastBlockEntireSrc, 1 /* isPartition */);
+        DEBUGLOG(5, "Estimated size: %zu actual size: %zu", ZSTD_buildEntropyStatisticsAndEstimateSubBlockSize(currSeqStore, zc), cSizeChunk);
+        FORWARD_IF_ERROR(cSizeChunk, "Compressing chunk failed!");
+
+        ip += srcBytes;
+        op += cSizeChunk;
+        dstCapacity -= cSizeChunk;
+        cSize += cSizeChunk;
+        *currSeqStore = *nextSeqStore;
+        assert(cSizeChunk <= ZSTD_BLOCKSIZE_MAX + ZSTD_blockHeaderSize);
+    }
+    /* cRep and dRep may have diverged during the compression. If so, we use the dRep repcodes
+     * for the next block.
+     */
+    ZSTD_memcpy(zc->blockState.prevCBlock->rep, dRep.rep, sizeof(repcodes_t));
+    return cSize;
+}
+
+static size_t
+ZSTD_compressBlock_splitBlock(ZSTD_CCtx* zc,
+                              void* dst, size_t dstCapacity,
+                              const void* src, size_t srcSize, U32 lastBlock)
+{
+    const BYTE* ip = (const BYTE*)src;
+    BYTE* op = (BYTE*)dst;
+    U32 nbSeq;
+    size_t cSize;
+    DEBUGLOG(4, "ZSTD_compressBlock_splitBlock");
+    assert(zc->appliedParams.useBlockSplitter == ZSTD_ps_enable);
+
+    {   const size_t bss = ZSTD_buildSeqStore(zc, src, srcSize);
+        FORWARD_IF_ERROR(bss, "ZSTD_buildSeqStore failed");
+        if (bss == ZSTDbss_noCompress) {
+            if (zc->blockState.prevCBlock->entropy.fse.offcode_repeatMode == FSE_repeat_valid)
+                zc->blockState.prevCBlock->entropy.fse.offcode_repeatMode = FSE_repeat_check;
+            cSize = ZSTD_noCompressBlock(op, dstCapacity, ip, srcSize, lastBlock);
+            FORWARD_IF_ERROR(cSize, "ZSTD_noCompressBlock failed");
+            DEBUGLOG(4, "ZSTD_compressBlock_splitBlock: Nocompress block");
+            return cSize;
+        }
+        nbSeq = (U32)(zc->seqStore.sequences - zc->seqStore.sequencesStart);
+    }
+
+    cSize = ZSTD_compressBlock_splitBlock_internal(zc, dst, dstCapacity, src, srcSize, lastBlock, nbSeq);
+    FORWARD_IF_ERROR(cSize, "Splitting blocks failed!");
+    return cSize;
 }
 
-static size_t ZSTD_compressBlock_internal(ZSTD_CCtx* zc,
-                                        void* dst, size_t dstCapacity,
-                                        const void* src, size_t srcSize, U32 frame)
+static size_t
+ZSTD_compressBlock_internal(ZSTD_CCtx* zc,
+                            void* dst, size_t dstCapacity,
+                            const void* src, size_t srcSize, U32 frame)
 {
     /* This the upper bound for the length of an rle block.
      * This isn't the actual upper bound. Finding the real threshold
@@ -2632,12 +3692,12 @@ static size_t ZSTD_compressBlock_internal(ZSTD_CCtx* zc,
 
     if (zc->seqCollector.collectSequences) {
         ZSTD_copyBlockSequences(zc);
-        ZSTD_confirmRepcodesAndEntropyTables(zc);
+        ZSTD_blockState_confirmRepcodesAndEntropyTables(&zc->blockState);
         return 0;
     }
 
     /* encode sequences and literals */
-    cSize = ZSTD_entropyCompressSequences(&zc->seqStore,
+    cSize = ZSTD_entropyCompressSeqStore(&zc->seqStore,
             &zc->blockState.prevCBlock->entropy, &zc->blockState.nextCBlock->entropy,
             &zc->appliedParams,
             dst, dstCapacity,
@@ -2645,12 +3705,6 @@ static size_t ZSTD_compressBlock_internal(ZSTD_CCtx* zc,
             zc->entropyWorkspace, ENTROPY_WORKSPACE_SIZE /* statically allocated in resetCCtx */,
             zc->bmi2);
 
-    if (zc->seqCollector.collectSequences) {
-        ZSTD_copyBlockSequences(zc);
-        return 0;
-    }
-
-
     if (frame &&
         /* We don't want to emit our first block as a RLE even if it qualifies because
          * doing so will cause the decoder (cli only) to throw a "should consume all input error."
@@ -2666,7 +3720,7 @@ static size_t ZSTD_compressBlock_internal(ZSTD_CCtx* zc,
 
 out:
     if (!ZSTD_isError(cSize) && cSize > 1) {
-        ZSTD_confirmRepcodesAndEntropyTables(zc);
+        ZSTD_blockState_confirmRepcodesAndEntropyTables(&zc->blockState);
     }
     /* We check that dictionaries have offset codes available for the first
      * block. After the first block, the offcode table might not have large
@@ -2719,7 +3773,7 @@ static size_t ZSTD_compressBlock_targetCBlockSize_body(ZSTD_CCtx* zc,
                 size_t const maxCSize = srcSize - ZSTD_minGain(srcSize, zc->appliedParams.cParams.strategy);
                 FORWARD_IF_ERROR(cSize, "ZSTD_compressSuperBlock failed");
                 if (cSize != 0 && cSize < maxCSize + ZSTD_blockHeaderSize) {
-                    ZSTD_confirmRepcodesAndEntropyTables(zc);
+                    ZSTD_blockState_confirmRepcodesAndEntropyTables(&zc->blockState);
                     return cSize;
                 }
             }
@@ -2759,9 +3813,9 @@ static void ZSTD_overflowCorrectIfNeeded(ZSTD_matchState_t* ms,
                                          void const* ip,
                                          void const* iend)
 {
-    if (ZSTD_window_needOverflowCorrection(ms->window, iend)) {
-        U32 const maxDist = (U32)1 << params->cParams.windowLog;
-        U32 const cycleLog = ZSTD_cycleLog(params->cParams.chainLog, params->cParams.strategy);
+    U32 const cycleLog = ZSTD_cycleLog(params->cParams.chainLog, params->cParams.strategy);
+    U32 const maxDist = (U32)1 << params->cParams.windowLog;
+    if (ZSTD_window_needOverflowCorrection(ms->window, cycleLog, maxDist, ms->loadedDictEnd, ip, iend)) {
         U32 const correction = ZSTD_window_correctOverflow(&ms->window, cycleLog, maxDist, ip);
         ZSTD_STATIC_ASSERT(ZSTD_CHAINLOG_MAX <= 30);
         ZSTD_STATIC_ASSERT(ZSTD_WINDOWLOG_MAX_32 <= 30);
@@ -2784,7 +3838,7 @@ static void ZSTD_overflowCorrectIfNeeded(ZSTD_matchState_t* ms,
 *   Frame is supposed already started (header already produced)
 *   @return : compressed size, or an error code
 */
-static size_t ZSTD_compress_frameChunk (ZSTD_CCtx* cctx,
+static size_t ZSTD_compress_frameChunk(ZSTD_CCtx* cctx,
                                      void* dst, size_t dstCapacity,
                                const void* src, size_t srcSize,
                                      U32 lastFrameChunk)
@@ -2814,6 +3868,7 @@ static size_t ZSTD_compress_frameChunk (ZSTD_CCtx* cctx,
         ZSTD_overflowCorrectIfNeeded(
             ms, &cctx->workspace, &cctx->appliedParams, ip, ip + blockSize);
         ZSTD_checkDictValidity(&ms->window, ip + blockSize, maxDist, &ms->loadedDictEnd, &ms->dictMatchState);
+        ZSTD_window_enforceMaxDist(&ms->window, ip, maxDist, &ms->loadedDictEnd, &ms->dictMatchState);
 
         /* Ensure hash/chain table insertion resumes no sooner than lowlimit */
         if (ms->nextToUpdate < ms->window.lowLimit) ms->nextToUpdate = ms->window.lowLimit;
@@ -2824,6 +3879,10 @@ static size_t ZSTD_compress_frameChunk (ZSTD_CCtx* cctx,
                 FORWARD_IF_ERROR(cSize, "ZSTD_compressBlock_targetCBlockSize failed");
                 assert(cSize > 0);
                 assert(cSize <= blockSize + ZSTD_blockHeaderSize);
+            } else if (ZSTD_blockSplitterEnabled(&cctx->appliedParams)) {
+                cSize = ZSTD_compressBlock_splitBlock(cctx, op, dstCapacity, ip, blockSize, lastBlock);
+                FORWARD_IF_ERROR(cSize, "ZSTD_compressBlock_splitBlock failed");
+                assert(cSize > 0 || cctx->seqCollector.collectSequences == 1);
             } else {
                 cSize = ZSTD_compressBlock_internal(cctx,
                                         op+ZSTD_blockHeaderSize, dstCapacity-ZSTD_blockHeaderSize,
@@ -2946,7 +4005,7 @@ size_t ZSTD_referenceExternalSequences(ZSTD_CCtx* cctx, rawSeq* seq, size_t nbSe
 {
     RETURN_ERROR_IF(cctx->stage != ZSTDcs_init, stage_wrong,
                     "wrong cctx stage");
-    RETURN_ERROR_IF(cctx->appliedParams.ldmParams.enableLdm,
+    RETURN_ERROR_IF(cctx->appliedParams.ldmParams.enableLdm == ZSTD_ps_enable,
                     parameter_unsupported,
                     "incompatible with ldm");
     cctx->externSeqStore.seq = seq;
@@ -2983,11 +4042,12 @@ static size_t ZSTD_compressContinue_internal (ZSTD_CCtx* cctx,
 
     if (!srcSize) return fhSize;  /* do not generate an empty block if no input */
 
-    if (!ZSTD_window_update(&ms->window, src, srcSize)) {
+    if (!ZSTD_window_update(&ms->window, src, srcSize, ms->forceNonContiguous)) {
+        ms->forceNonContiguous = 0;
         ms->nextToUpdate = ms->window.dictLimit;
     }
-    if (cctx->appliedParams.ldmParams.enableLdm) {
-        ZSTD_window_update(&cctx->ldmState.window, src, srcSize);
+    if (cctx->appliedParams.ldmParams.enableLdm == ZSTD_ps_enable) {
+        ZSTD_window_update(&cctx->ldmState.window, src, srcSize, /* forceNonContiguous */ 0);
     }
 
     if (!frame) {
@@ -3055,63 +4115,86 @@ static size_t ZSTD_loadDictionaryContent(ZSTD_matchState_t* ms,
 {
     const BYTE* ip = (const BYTE*) src;
     const BYTE* const iend = ip + srcSize;
+    int const loadLdmDict = params->ldmParams.enableLdm == ZSTD_ps_enable && ls != NULL;
 
-    ZSTD_window_update(&ms->window, src, srcSize);
+    /* Assert that we the ms params match the params we're being given */
+    ZSTD_assertEqualCParams(params->cParams, ms->cParams);
+
+    if (srcSize > ZSTD_CHUNKSIZE_MAX) {
+        /* Allow the dictionary to set indices up to exactly ZSTD_CURRENT_MAX.
+         * Dictionaries right at the edge will immediately trigger overflow
+         * correction, but I don't want to insert extra constraints here.
+         */
+        U32 const maxDictSize = ZSTD_CURRENT_MAX - 1;
+        /* We must have cleared our windows when our source is this large. */
+        assert(ZSTD_window_isEmpty(ms->window));
+        if (loadLdmDict)
+            assert(ZSTD_window_isEmpty(ls->window));
+        /* If the dictionary is too large, only load the suffix of the dictionary. */
+        if (srcSize > maxDictSize) {
+            ip = iend - maxDictSize;
+            src = ip;
+            srcSize = maxDictSize;
+        }
+    }
+
+    DEBUGLOG(4, "ZSTD_loadDictionaryContent(): useRowMatchFinder=%d", (int)params->useRowMatchFinder);
+    ZSTD_window_update(&ms->window, src, srcSize, /* forceNonContiguous */ 0);
     ms->loadedDictEnd = params->forceWindow ? 0 : (U32)(iend - ms->window.base);
+    ms->forceNonContiguous = params->deterministicRefPrefix;
 
-    if (params->ldmParams.enableLdm && ls != NULL) {
-        ZSTD_window_update(&ls->window, src, srcSize);
+    if (loadLdmDict) {
+        ZSTD_window_update(&ls->window, src, srcSize, /* forceNonContiguous */ 0);
         ls->loadedDictEnd = params->forceWindow ? 0 : (U32)(iend - ls->window.base);
     }
 
-    /* Assert that we the ms params match the params we're being given */
-    ZSTD_assertEqualCParams(params->cParams, ms->cParams);
-
     if (srcSize <= HASH_READ_SIZE) return 0;
 
-    while (iend - ip > HASH_READ_SIZE) {
-        size_t const remaining = (size_t)(iend - ip);
-        size_t const chunk = MIN(remaining, ZSTD_CHUNKSIZE_MAX);
-        const BYTE* const ichunk = ip + chunk;
-
-        ZSTD_overflowCorrectIfNeeded(ms, ws, params, ip, ichunk);
+    ZSTD_overflowCorrectIfNeeded(ms, ws, params, ip, iend);
 
-        if (params->ldmParams.enableLdm && ls != NULL)
-            ZSTD_ldm_fillHashTable(ls, (const BYTE*)src, (const BYTE*)src + srcSize, &params->ldmParams);
+    if (loadLdmDict)
+        ZSTD_ldm_fillHashTable(ls, ip, iend, &params->ldmParams);
 
-        switch(params->cParams.strategy)
-        {
-        case ZSTD_fast:
-            ZSTD_fillHashTable(ms, ichunk, dtlm);
-            break;
-        case ZSTD_dfast:
-            ZSTD_fillDoubleHashTable(ms, ichunk, dtlm);
-            break;
+    switch(params->cParams.strategy)
+    {
+    case ZSTD_fast:
+        ZSTD_fillHashTable(ms, iend, dtlm);
+        break;
+    case ZSTD_dfast:
+        ZSTD_fillDoubleHashTable(ms, iend, dtlm);
+        break;
 
-        case ZSTD_greedy:
-        case ZSTD_lazy:
-        case ZSTD_lazy2:
-            if (chunk >= HASH_READ_SIZE && ms->dedicatedDictSearch) {
-                assert(chunk == remaining); /* must load everything in one go */
-                ZSTD_dedicatedDictSearch_lazy_loadDictionary(ms, ichunk-HASH_READ_SIZE);
-            } else if (chunk >= HASH_READ_SIZE) {
-                ZSTD_insertAndFindFirstIndex(ms, ichunk-HASH_READ_SIZE);
+    case ZSTD_greedy:
+    case ZSTD_lazy:
+    case ZSTD_lazy2:
+        assert(srcSize >= HASH_READ_SIZE);
+        if (ms->dedicatedDictSearch) {
+            assert(ms->chainTable != NULL);
+            ZSTD_dedicatedDictSearch_lazy_loadDictionary(ms, iend-HASH_READ_SIZE);
+        } else {
+            assert(params->useRowMatchFinder != ZSTD_ps_auto);
+            if (params->useRowMatchFinder == ZSTD_ps_enable) {
+                size_t const tagTableSize = ((size_t)1 << params->cParams.hashLog) * sizeof(U16);
+                ZSTD_memset(ms->tagTable, 0, tagTableSize);
+                ZSTD_row_update(ms, iend-HASH_READ_SIZE);
+                DEBUGLOG(4, "Using row-based hash table for lazy dict");
+            } else {
+                ZSTD_insertAndFindFirstIndex(ms, iend-HASH_READ_SIZE);
+                DEBUGLOG(4, "Using chain-based hash table for lazy dict");
             }
-            break;
-
-        case ZSTD_btlazy2:   /* we want the dictionary table fully sorted */
-        case ZSTD_btopt:
-        case ZSTD_btultra:
-        case ZSTD_btultra2:
-            if (chunk >= HASH_READ_SIZE)
-                ZSTD_updateTree(ms, ichunk-HASH_READ_SIZE, ichunk);
-            break;
-
-        default:
-            assert(0);  /* not possible : not a valid strategy id */
         }
+        break;
+
+    case ZSTD_btlazy2:   /* we want the dictionary table fully sorted */
+    case ZSTD_btopt:
+    case ZSTD_btultra:
+    case ZSTD_btultra2:
+        assert(srcSize >= HASH_READ_SIZE);
+        ZSTD_updateTree(ms, iend-HASH_READ_SIZE, iend);
+        break;
 
-        ip = ichunk;
+    default:
+        assert(0);  /* not possible : not a valid strategy id */
     }
 
     ms->nextToUpdate = (U32)(iend - ms->window.base);
@@ -3250,7 +4333,6 @@ static size_t ZSTD_loadZstdDictionary(ZSTD_compressedBlockState_t* bs,
     const BYTE* const dictEnd = dictPtr + dictSize;
     size_t dictID;
     size_t eSize;
-
     ZSTD_STATIC_ASSERT(HUF_WORKSPACE_SIZE >= (1<<MAX(MLFSELog,LLFSELog)));
     assert(dictSize >= 8);
     assert(MEM_readLE32(dictPtr) == ZSTD_MAGIC_DICTIONARY);
@@ -3321,6 +4403,7 @@ static size_t ZSTD_compressBegin_internal(ZSTD_CCtx* cctx,
                                     const ZSTD_CCtx_params* params, U64 pledgedSrcSize,
                                     ZSTD_buffered_policy_e zbuff)
 {
+    size_t const dictContentSize = cdict ? cdict->dictContentSize : dictSize;
     DEBUGLOG(4, "ZSTD_compressBegin_internal: wlog=%u", params->cParams.windowLog);
     /* params are supposed to be fully validated at this point */
     assert(!ZSTD_isError(ZSTD_checkCParams(params->cParams)));
@@ -3335,7 +4418,8 @@ static size_t ZSTD_compressBegin_internal(ZSTD_CCtx* cctx,
         return ZSTD_resetCCtx_usingCDict(cctx, cdict, params, pledgedSrcSize, zbuff);
     }
 
-    FORWARD_IF_ERROR( ZSTD_resetCCtx_internal(cctx, *params, pledgedSrcSize,
+    FORWARD_IF_ERROR( ZSTD_resetCCtx_internal(cctx, params, pledgedSrcSize,
+                                     dictContentSize,
                                      ZSTDcrp_makeClean, zbuff) , "");
     {   size_t const dictID = cdict ?
                 ZSTD_compress_insertDictionary(
@@ -3350,7 +4434,7 @@ static size_t ZSTD_compressBegin_internal(ZSTD_CCtx* cctx,
         FORWARD_IF_ERROR(dictID, "ZSTD_compress_insertDictionary failed");
         assert(dictID <= UINT_MAX);
         cctx->dictID = (U32)dictID;
-        cctx->dictContentSize = cdict ? cdict->dictContentSize : dictSize;
+        cctx->dictContentSize = dictContentSize;
     }
     return 0;
 }
@@ -3485,15 +4569,14 @@ size_t ZSTD_compress_advanced (ZSTD_CCtx* cctx,
                          const void* dict,size_t dictSize,
                                ZSTD_parameters params)
 {
-    ZSTD_CCtx_params cctxParams;
     DEBUGLOG(4, "ZSTD_compress_advanced");
     FORWARD_IF_ERROR(ZSTD_checkCParams(params.cParams), "");
-    ZSTD_CCtxParams_init_internal(&cctxParams, &params, ZSTD_NO_CLEVEL);
+    ZSTD_CCtxParams_init_internal(&cctx->simpleApiParams, &params, ZSTD_NO_CLEVEL);
     return ZSTD_compress_advanced_internal(cctx,
                                            dst, dstCapacity,
                                            src, srcSize,
                                            dict, dictSize,
-                                           &cctxParams);
+                                           &cctx->simpleApiParams);
 }
 
 /* Internal */
@@ -3517,14 +4600,13 @@ size_t ZSTD_compress_usingDict(ZSTD_CCtx* cctx,
                          const void* dict, size_t dictSize,
                                int compressionLevel)
 {
-    ZSTD_CCtx_params cctxParams;
     {
         ZSTD_parameters const params = ZSTD_getParams_internal(compressionLevel, srcSize, dict ? dictSize : 0, ZSTD_cpm_noAttachDict);
         assert(params.fParams.contentSizeFlag == 1);
-        ZSTD_CCtxParams_init_internal(&cctxParams, &params, (compressionLevel == 0) ? ZSTD_CLEVEL_DEFAULT: compressionLevel);
+        ZSTD_CCtxParams_init_internal(&cctx->simpleApiParams, &params, (compressionLevel == 0) ? ZSTD_CLEVEL_DEFAULT: compressionLevel);
     }
     DEBUGLOG(4, "ZSTD_compress_usingDict (srcSize=%u)", (unsigned)srcSize);
-    return ZSTD_compress_advanced_internal(cctx, dst, dstCapacity, src, srcSize, dict, dictSize, &cctxParams);
+    return ZSTD_compress_advanced_internal(cctx, dst, dstCapacity, src, srcSize, dict, dictSize, &cctx->simpleApiParams);
 }
 
 size_t ZSTD_compressCCtx(ZSTD_CCtx* cctx,
@@ -3561,7 +4643,10 @@ size_t ZSTD_estimateCDictSize_advanced(
     DEBUGLOG(5, "sizeof(ZSTD_CDict) : %u", (unsigned)sizeof(ZSTD_CDict));
     return ZSTD_cwksp_alloc_size(sizeof(ZSTD_CDict))
          + ZSTD_cwksp_alloc_size(HUF_WORKSPACE_SIZE)
-         + ZSTD_sizeof_matchState(&cParams, /* forCCtx */ 0)
+         /* enableDedicatedDictSearch == 1 ensures that CDict estimation will not be too small
+          * in case we are using DDS with row-hash. */
+         + ZSTD_sizeof_matchState(&cParams, ZSTD_resolveRowMatchFinderMode(ZSTD_ps_auto, &cParams),
+                                  /* enableDedicatedDictSearch */ 1, /* forCCtx */ 0)
          + (dictLoadMethod == ZSTD_dlm_byRef ? 0
             : ZSTD_cwksp_alloc_size(ZSTD_cwksp_align(dictSize, sizeof(void *))));
 }
@@ -3592,9 +4677,6 @@ static size_t ZSTD_initCDict_internal(
     assert(!ZSTD_checkCParams(params.cParams));
     cdict->matchState.cParams = params.cParams;
     cdict->matchState.dedicatedDictSearch = params.enableDedicatedDictSearch;
-    if (cdict->matchState.dedicatedDictSearch && dictSize > ZSTD_CHUNKSIZE_MAX) {
-        cdict->matchState.dedicatedDictSearch = 0;
-    }
     if ((dictLoadMethod == ZSTD_dlm_byRef) || (!dictBuffer) || (!dictSize)) {
         cdict->dictContent = dictBuffer;
     } else {
@@ -3615,6 +4697,7 @@ static size_t ZSTD_initCDict_internal(
         &cdict->matchState,
         &cdict->workspace,
         &params.cParams,
+        params.useRowMatchFinder,
         ZSTDcrp_makeClean,
         ZSTDirp_reset,
         ZSTD_resetTarget_CDict), "");
@@ -3638,14 +4721,17 @@ static size_t ZSTD_initCDict_internal(
 
 static ZSTD_CDict* ZSTD_createCDict_advanced_internal(size_t dictSize,
                                       ZSTD_dictLoadMethod_e dictLoadMethod,
-                                      ZSTD_compressionParameters cParams, ZSTD_customMem customMem)
+                                      ZSTD_compressionParameters cParams,
+                                      ZSTD_paramSwitch_e useRowMatchFinder,
+                                      U32 enableDedicatedDictSearch,
+                                      ZSTD_customMem customMem)
 {
     if ((!customMem.customAlloc) ^ (!customMem.customFree)) return NULL;
 
     {   size_t const workspaceSize =
             ZSTD_cwksp_alloc_size(sizeof(ZSTD_CDict)) +
             ZSTD_cwksp_alloc_size(HUF_WORKSPACE_SIZE) +
-            ZSTD_sizeof_matchState(&cParams, /* forCCtx */ 0) +
+            ZSTD_sizeof_matchState(&cParams, useRowMatchFinder, enableDedicatedDictSearch, /* forCCtx */ 0) +
             (dictLoadMethod == ZSTD_dlm_byRef ? 0
              : ZSTD_cwksp_alloc_size(ZSTD_cwksp_align(dictSize, sizeof(void*))));
         void* const workspace = ZSTD_customMalloc(workspaceSize, customMem);
@@ -3664,7 +4750,7 @@ static ZSTD_CDict* ZSTD_createCDict_advanced_internal(size_t dictSize,
         ZSTD_cwksp_move(&cdict->workspace, &ws);
         cdict->customMem = customMem;
         cdict->compressionLevel = ZSTD_NO_CLEVEL; /* signals advanced API usage */
-
+        cdict->useRowMatchFinder = useRowMatchFinder;
         return cdict;
     }
 }
@@ -3686,7 +4772,7 @@ ZSTD_CDict* ZSTD_createCDict_advanced(const void* dictBuffer, size_t dictSize,
         &cctxParams, customMem);
 }
 
-ZSTDLIB_API ZSTD_CDict* ZSTD_createCDict_advanced2(
+ZSTD_CDict* ZSTD_createCDict_advanced2(
         const void* dict, size_t dictSize,
         ZSTD_dictLoadMethod_e dictLoadMethod,
         ZSTD_dictContentType_e dictContentType,
@@ -3716,10 +4802,13 @@ ZSTDLIB_API ZSTD_CDict* ZSTD_createCDict_advanced2(
             &cctxParams, ZSTD_CONTENTSIZE_UNKNOWN, dictSize, ZSTD_cpm_createCDict);
     }
 
+    DEBUGLOG(3, "ZSTD_createCDict_advanced2: DDS: %u", cctxParams.enableDedicatedDictSearch);
     cctxParams.cParams = cParams;
+    cctxParams.useRowMatchFinder = ZSTD_resolveRowMatchFinderMode(cctxParams.useRowMatchFinder, &cParams);
 
     cdict = ZSTD_createCDict_advanced_internal(dictSize,
                         dictLoadMethod, cctxParams.cParams,
+                        cctxParams.useRowMatchFinder, cctxParams.enableDedicatedDictSearch,
                         customMem);
 
     if (ZSTD_isError( ZSTD_initCDict_internal(cdict,
@@ -3788,7 +4877,9 @@ const ZSTD_CDict* ZSTD_initStaticCDict(
                                  ZSTD_dictContentType_e dictContentType,
                                  ZSTD_compressionParameters cParams)
 {
-    size_t const matchStateSize = ZSTD_sizeof_matchState(&cParams, /* forCCtx */ 0);
+    ZSTD_paramSwitch_e const useRowMatchFinder = ZSTD_resolveRowMatchFinderMode(ZSTD_ps_auto, &cParams);
+    /* enableDedicatedDictSearch == 1 ensures matchstate is not too small in case this CDict will be used for DDS + row hash */
+    size_t const matchStateSize = ZSTD_sizeof_matchState(&cParams, useRowMatchFinder, /* enableDedicatedDictSearch */ 1, /* forCCtx */ 0);
     size_t const neededSize = ZSTD_cwksp_alloc_size(sizeof(ZSTD_CDict))
                             + (dictLoadMethod == ZSTD_dlm_byRef ? 0
                                : ZSTD_cwksp_alloc_size(ZSTD_cwksp_align(dictSize, sizeof(void*))))
@@ -3813,6 +4904,8 @@ const ZSTD_CDict* ZSTD_initStaticCDict(
 
     ZSTD_CCtxParams_init(&params, 0);
     params.cParams = cParams;
+    params.useRowMatchFinder = useRowMatchFinder;
+    cdict->useRowMatchFinder = useRowMatchFinder;
 
     if (ZSTD_isError( ZSTD_initCDict_internal(cdict,
                                               dict, dictSize,
@@ -3839,15 +4932,15 @@ unsigned ZSTD_getDictID_fromCDict(const ZSTD_CDict* cdict)
     return cdict->dictID;
 }
 
-
-/* ZSTD_compressBegin_usingCDict_advanced() :
- * cdict must be != NULL */
-size_t ZSTD_compressBegin_usingCDict_advanced(
+/* ZSTD_compressBegin_usingCDict_internal() :
+ * Implementation of various ZSTD_compressBegin_usingCDict* functions.
+ */
+static size_t ZSTD_compressBegin_usingCDict_internal(
     ZSTD_CCtx* const cctx, const ZSTD_CDict* const cdict,
     ZSTD_frameParameters const fParams, unsigned long long const pledgedSrcSize)
 {
     ZSTD_CCtx_params cctxParams;
-    DEBUGLOG(4, "ZSTD_compressBegin_usingCDict_advanced");
+    DEBUGLOG(4, "ZSTD_compressBegin_usingCDict_internal");
     RETURN_ERROR_IF(cdict==NULL, dictionary_wrong, "NULL pointer!");
     /* Initialize the cctxParams from the cdict */
     {
@@ -3879,25 +4972,48 @@ size_t ZSTD_compressBegin_usingCDict_advanced(
                                         ZSTDb_not_buffered);
 }
 
+
+/* ZSTD_compressBegin_usingCDict_advanced() :
+ * This function is DEPRECATED.
+ * cdict must be != NULL */
+size_t ZSTD_compressBegin_usingCDict_advanced(
+    ZSTD_CCtx* const cctx, const ZSTD_CDict* const cdict,
+    ZSTD_frameParameters const fParams, unsigned long long const pledgedSrcSize)
+{
+    return ZSTD_compressBegin_usingCDict_internal(cctx, cdict, fParams, pledgedSrcSize);
+}
+
 /* ZSTD_compressBegin_usingCDict() :
- * pledgedSrcSize=0 means "unknown"
- * if pledgedSrcSize>0, it will enable contentSizeFlag */
+ * cdict must be != NULL */
 size_t ZSTD_compressBegin_usingCDict(ZSTD_CCtx* cctx, const ZSTD_CDict* cdict)
 {
     ZSTD_frameParameters const fParams = { 0 /*content*/, 0 /*checksum*/, 0 /*noDictID*/ };
-    DEBUGLOG(4, "ZSTD_compressBegin_usingCDict : dictIDFlag == %u", !fParams.noDictIDFlag);
-    return ZSTD_compressBegin_usingCDict_advanced(cctx, cdict, fParams, ZSTD_CONTENTSIZE_UNKNOWN);
+    return ZSTD_compressBegin_usingCDict_internal(cctx, cdict, fParams, ZSTD_CONTENTSIZE_UNKNOWN);
 }
 
-size_t ZSTD_compress_usingCDict_advanced(ZSTD_CCtx* cctx,
+/*! ZSTD_compress_usingCDict_internal():
+ * Implementation of various ZSTD_compress_usingCDict* functions.
+ */
+static size_t ZSTD_compress_usingCDict_internal(ZSTD_CCtx* cctx,
                                 void* dst, size_t dstCapacity,
                                 const void* src, size_t srcSize,
                                 const ZSTD_CDict* cdict, ZSTD_frameParameters fParams)
 {
-    FORWARD_IF_ERROR(ZSTD_compressBegin_usingCDict_advanced(cctx, cdict, fParams, srcSize), "");   /* will check if cdict != NULL */
+    FORWARD_IF_ERROR(ZSTD_compressBegin_usingCDict_internal(cctx, cdict, fParams, srcSize), ""); /* will check if cdict != NULL */
     return ZSTD_compressEnd(cctx, dst, dstCapacity, src, srcSize);
 }
 
+/*! ZSTD_compress_usingCDict_advanced():
+ * This function is DEPRECATED.
+ */
+size_t ZSTD_compress_usingCDict_advanced(ZSTD_CCtx* cctx,
+                                void* dst, size_t dstCapacity,
+                                const void* src, size_t srcSize,
+                                const ZSTD_CDict* cdict, ZSTD_frameParameters fParams)
+{
+    return ZSTD_compress_usingCDict_internal(cctx, dst, dstCapacity, src, srcSize, cdict, fParams);
+}
+
 /*! ZSTD_compress_usingCDict() :
  *  Compression using a digested Dictionary.
  *  Faster startup than ZSTD_compress_usingDict(), recommended when same dictionary is used multiple times.
@@ -3909,7 +5025,7 @@ size_t ZSTD_compress_usingCDict(ZSTD_CCtx* cctx,
                                 const ZSTD_CDict* cdict)
 {
     ZSTD_frameParameters const fParams = { 1 /*content*/, 0 /*checksum*/, 0 /*noDictID*/ };
-    return ZSTD_compress_usingCDict_advanced(cctx, dst, dstCapacity, src, srcSize, cdict, fParams);
+    return ZSTD_compress_usingCDict_internal(cctx, dst, dstCapacity, src, srcSize, cdict, fParams);
 }
 
 
@@ -4313,8 +5429,13 @@ static size_t ZSTD_CCtx_init_compressStream2(ZSTD_CCtx* cctx,
     FORWARD_IF_ERROR( ZSTD_initLocalDict(cctx) , ""); /* Init the local dict if present. */
     ZSTD_memset(&cctx->prefixDict, 0, sizeof(cctx->prefixDict));   /* single usage */
     assert(prefixDict.dict==NULL || cctx->cdict==NULL);    /* only one can be set */
-    if (cctx->cdict)
-        params.compressionLevel = cctx->cdict->compressionLevel; /* let cdict take priority in terms of compression level */
+    if (cctx->cdict && !cctx->localDict.cdict) {
+        /* Let the cdict's compression level take priority over the requested params.
+         * But do not take the cdict's compression level if the "cdict" is actually a localDict
+         * generated from ZSTD_initLocalDict().
+         */
+        params.compressionLevel = cctx->cdict->compressionLevel;
+    }
     DEBUGLOG(4, "ZSTD_compressStream2 : transparent init stage");
     if (endOp == ZSTD_e_end) cctx->pledgedSrcSizePlusOne = inSize + 1;  /* auto-fix pledgedSrcSize */
     {
@@ -4327,11 +5448,9 @@ static size_t ZSTD_CCtx_init_compressStream2(ZSTD_CCtx* cctx,
                 dictSize, mode);
     }
 
-    if (ZSTD_CParams_shouldEnableLdm(&params.cParams)) {
-        /* Enable LDM by default for optimal parser and window size >= 128MB */
-        DEBUGLOG(4, "LDM enabled by default (window size >= 128MB, strategy >= btopt)");
-        params.ldmParams.enableLdm = 1;
-    }
+    params.useBlockSplitter = ZSTD_resolveBlockSplitterMode(params.useBlockSplitter, &params.cParams);
+    params.ldmParams.enableLdm = ZSTD_resolveEnableLdm(params.ldmParams.enableLdm, &params.cParams);
+    params.useRowMatchFinder = ZSTD_resolveRowMatchFinderMode(params.useRowMatchFinder, &params.cParams);
 
     {   U64 const pledgedSrcSize = cctx->pledgedSrcSizePlusOne - 1;
         assert(!ZSTD_isError(ZSTD_checkCParams(params.cParams)));
@@ -4436,39 +5555,39 @@ typedef struct {
     size_t posInSrc;        /* Number of bytes given by sequences provided so far */
 } ZSTD_sequencePosition;
 
-/* Returns a ZSTD error code if sequence is not valid */
-static size_t ZSTD_validateSequence(U32 offCode, U32 matchLength,
-                                    size_t posInSrc, U32 windowLog, size_t dictSize, U32 minMatch) {
-    size_t offsetBound;
-    U32 windowSize = 1 << windowLog;
-    /* posInSrc represents the amount of data the the decoder would decode up to this point.
+/* ZSTD_validateSequence() :
+ * @offCode : is presumed to follow format required by ZSTD_storeSeq()
+ * @returns a ZSTD error code if sequence is not valid
+ */
+static size_t
+ZSTD_validateSequence(U32 offCode, U32 matchLength,
+                      size_t posInSrc, U32 windowLog, size_t dictSize)
+{
+    U32 const windowSize = 1 << windowLog;
+    /* posInSrc represents the amount of data the decoder would decode up to this point.
      * As long as the amount of data decoded is less than or equal to window size, offsets may be
      * larger than the total length of output decoded in order to reference the dict, even larger than
      * window size. After output surpasses windowSize, we're limited to windowSize offsets again.
      */
-    offsetBound = posInSrc > windowSize ? (size_t)windowSize : posInSrc + (size_t)dictSize;
-    RETURN_ERROR_IF(offCode > offsetBound + ZSTD_REP_MOVE, corruption_detected, "Offset too large!");
-    RETURN_ERROR_IF(matchLength < minMatch, corruption_detected, "Matchlength too small");
+    size_t const offsetBound = posInSrc > windowSize ? (size_t)windowSize : posInSrc + (size_t)dictSize;
+    RETURN_ERROR_IF(offCode > STORE_OFFSET(offsetBound), corruption_detected, "Offset too large!");
+    RETURN_ERROR_IF(matchLength < MINMATCH, corruption_detected, "Matchlength too small");
     return 0;
 }
 
 /* Returns an offset code, given a sequence's raw offset, the ongoing repcode array, and whether litLength == 0 */
-static U32 ZSTD_finalizeOffCode(U32 rawOffset, const U32 rep[ZSTD_REP_NUM], U32 ll0) {
-    U32 offCode = rawOffset + ZSTD_REP_MOVE;
-    U32 repCode = 0;
+static U32 ZSTD_finalizeOffCode(U32 rawOffset, const U32 rep[ZSTD_REP_NUM], U32 ll0)
+{
+    U32 offCode = STORE_OFFSET(rawOffset);
 
     if (!ll0 && rawOffset == rep[0]) {
-        repCode = 1;
+        offCode = STORE_REPCODE_1;
     } else if (rawOffset == rep[1]) {
-        repCode = 2 - ll0;
+        offCode = STORE_REPCODE(2 - ll0);
     } else if (rawOffset == rep[2]) {
-        repCode = 3 - ll0;
+        offCode = STORE_REPCODE(3 - ll0);
     } else if (ll0 && rawOffset == rep[0] - 1) {
-        repCode = 3;
-    }
-    if (repCode) {
-        /* ZSTD_storeSeq expects a number in the range [0, 2] to represent a repcode */
-        offCode = repCode - 1;
+        offCode = STORE_REPCODE_3;
     }
     return offCode;
 }
@@ -4476,18 +5595,17 @@ static U32 ZSTD_finalizeOffCode(U32 rawOffset, const U32 rep[ZSTD_REP_NUM], U32
 /* Returns 0 on success, and a ZSTD_error otherwise. This function scans through an array of
  * ZSTD_Sequence, storing the sequences it finds, until it reaches a block delimiter.
  */
-static size_t ZSTD_copySequencesToSeqStoreExplicitBlockDelim(ZSTD_CCtx* cctx, ZSTD_sequencePosition* seqPos,
-                                                             const ZSTD_Sequence* const inSeqs, size_t inSeqsSize,
-                                                             const void* src, size_t blockSize) {
+static size_t
+ZSTD_copySequencesToSeqStoreExplicitBlockDelim(ZSTD_CCtx* cctx,
+                                              ZSTD_sequencePosition* seqPos,
+                                        const ZSTD_Sequence* const inSeqs, size_t inSeqsSize,
+                                        const void* src, size_t blockSize)
+{
     U32 idx = seqPos->idx;
     BYTE const* ip = (BYTE const*)(src);
     const BYTE* const iend = ip + blockSize;
     repcodes_t updatedRepcodes;
     U32 dictSize;
-    U32 litLength;
-    U32 matchLength;
-    U32 ll0;
-    U32 offCode;
 
     if (cctx->cdict) {
         dictSize = (U32)cctx->cdict->dictContentSize;
@@ -4498,23 +5616,22 @@ static size_t ZSTD_copySequencesToSeqStoreExplicitBlockDelim(ZSTD_CCtx* cctx, ZS
     }
     ZSTD_memcpy(updatedRepcodes.rep, cctx->blockState.prevCBlock->rep, sizeof(repcodes_t));
     for (; (inSeqs[idx].matchLength != 0 || inSeqs[idx].offset != 0) && idx < inSeqsSize; ++idx) {
-        litLength = inSeqs[idx].litLength;
-        matchLength = inSeqs[idx].matchLength;
-        ll0 = litLength == 0;
-        offCode = ZSTD_finalizeOffCode(inSeqs[idx].offset, updatedRepcodes.rep, ll0);
-        updatedRepcodes = ZSTD_updateRep(updatedRepcodes.rep, offCode, ll0);
+        U32 const litLength = inSeqs[idx].litLength;
+        U32 const ll0 = (litLength == 0);
+        U32 const matchLength = inSeqs[idx].matchLength;
+        U32 const offCode = ZSTD_finalizeOffCode(inSeqs[idx].offset, updatedRepcodes.rep, ll0);
+        ZSTD_updateRep(updatedRepcodes.rep, offCode, ll0);
 
         DEBUGLOG(6, "Storing sequence: (of: %u, ml: %u, ll: %u)", offCode, matchLength, litLength);
         if (cctx->appliedParams.validateSequences) {
             seqPos->posInSrc += litLength + matchLength;
             FORWARD_IF_ERROR(ZSTD_validateSequence(offCode, matchLength, seqPos->posInSrc,
-                                                cctx->appliedParams.cParams.windowLog, dictSize,
-                                                cctx->appliedParams.cParams.minMatch),
+                                                cctx->appliedParams.cParams.windowLog, dictSize),
                                                 "Sequence validation failed");
         }
         RETURN_ERROR_IF(idx - seqPos->idx > cctx->seqStore.maxNbSeq, memory_allocation,
                         "Not enough memory allocated. Try adjusting ZSTD_c_minMatch.");
-        ZSTD_storeSeq(&cctx->seqStore, litLength, ip, iend, offCode, matchLength - MINMATCH);
+        ZSTD_storeSeq(&cctx->seqStore, litLength, ip, iend, offCode, matchLength);
         ip += matchLength + litLength;
     }
     ZSTD_memcpy(cctx->blockState.nextCBlock->rep, updatedRepcodes.rep, sizeof(repcodes_t));
@@ -4541,9 +5658,11 @@ static size_t ZSTD_copySequencesToSeqStoreExplicitBlockDelim(ZSTD_CCtx* cctx, ZS
  * avoid splitting a match, or to avoid splitting a match such that it would produce a match
  * smaller than MINMATCH. In this case, we return the number of bytes that we didn't read from this block.
  */
-static size_t ZSTD_copySequencesToSeqStoreNoBlockDelim(ZSTD_CCtx* cctx, ZSTD_sequencePosition* seqPos,
-                                                       const ZSTD_Sequence* const inSeqs, size_t inSeqsSize,
-                                                       const void* src, size_t blockSize) {
+static size_t
+ZSTD_copySequencesToSeqStoreNoBlockDelim(ZSTD_CCtx* cctx, ZSTD_sequencePosition* seqPos,
+                                   const ZSTD_Sequence* const inSeqs, size_t inSeqsSize,
+                                   const void* src, size_t blockSize)
+{
     U32 idx = seqPos->idx;
     U32 startPosInSequence = seqPos->posInSequence;
     U32 endPosInSequence = seqPos->posInSequence + (U32)blockSize;
@@ -4553,10 +5672,6 @@ static size_t ZSTD_copySequencesToSeqStoreNoBlockDelim(ZSTD_CCtx* cctx, ZSTD_seq
     repcodes_t updatedRepcodes;
     U32 bytesAdjustment = 0;
     U32 finalMatchSplit = 0;
-    U32 litLength;
-    U32 matchLength;
-    U32 rawOffset;
-    U32 offCode;
 
     if (cctx->cdict) {
         dictSize = cctx->cdict->dictContentSize;
@@ -4570,9 +5685,10 @@ static size_t ZSTD_copySequencesToSeqStoreNoBlockDelim(ZSTD_CCtx* cctx, ZSTD_seq
     ZSTD_memcpy(updatedRepcodes.rep, cctx->blockState.prevCBlock->rep, sizeof(repcodes_t));
     while (endPosInSequence && idx < inSeqsSize && !finalMatchSplit) {
         const ZSTD_Sequence currSeq = inSeqs[idx];
-        litLength = currSeq.litLength;
-        matchLength = currSeq.matchLength;
-        rawOffset = currSeq.offset;
+        U32 litLength = currSeq.litLength;
+        U32 matchLength = currSeq.matchLength;
+        U32 const rawOffset = currSeq.offset;
+        U32 offCode;
 
         /* Modify the sequence depending on where endPosInSequence lies */
         if (endPosInSequence >= currSeq.litLength + currSeq.matchLength) {
@@ -4625,22 +5741,21 @@ static size_t ZSTD_copySequencesToSeqStoreNoBlockDelim(ZSTD_CCtx* cctx, ZSTD_seq
             }
         }
         /* Check if this offset can be represented with a repcode */
-        {   U32 ll0 = (litLength == 0);
+        {   U32 const ll0 = (litLength == 0);
             offCode = ZSTD_finalizeOffCode(rawOffset, updatedRepcodes.rep, ll0);
-            updatedRepcodes = ZSTD_updateRep(updatedRepcodes.rep, offCode, ll0);
+            ZSTD_updateRep(updatedRepcodes.rep, offCode, ll0);
         }
 
         if (cctx->appliedParams.validateSequences) {
             seqPos->posInSrc += litLength + matchLength;
             FORWARD_IF_ERROR(ZSTD_validateSequence(offCode, matchLength, seqPos->posInSrc,
-                                                   cctx->appliedParams.cParams.windowLog, dictSize,
-                                                   cctx->appliedParams.cParams.minMatch),
+                                                   cctx->appliedParams.cParams.windowLog, dictSize),
                                                    "Sequence validation failed");
         }
         DEBUGLOG(6, "Storing sequence: (of: %u, ml: %u, ll: %u)", offCode, matchLength, litLength);
         RETURN_ERROR_IF(idx - seqPos->idx > cctx->seqStore.maxNbSeq, memory_allocation,
                         "Not enough memory allocated. Try adjusting ZSTD_c_minMatch.");
-        ZSTD_storeSeq(&cctx->seqStore, litLength, ip, iend, offCode, matchLength - MINMATCH);
+        ZSTD_storeSeq(&cctx->seqStore, litLength, ip, iend, offCode, matchLength);
         ip += matchLength + litLength;
     }
     DEBUGLOG(5, "Ending seq: idx: %u (of: %u ml: %u ll: %u)", idx, inSeqs[idx].offset, inSeqs[idx].matchLength, inSeqs[idx].litLength);
@@ -4665,7 +5780,8 @@ static size_t ZSTD_copySequencesToSeqStoreNoBlockDelim(ZSTD_CCtx* cctx, ZSTD_seq
 typedef size_t (*ZSTD_sequenceCopier) (ZSTD_CCtx* cctx, ZSTD_sequencePosition* seqPos,
                                        const ZSTD_Sequence* const inSeqs, size_t inSeqsSize,
                                        const void* src, size_t blockSize);
-static ZSTD_sequenceCopier ZSTD_selectSequenceCopier(ZSTD_sequenceFormat_e mode) {
+static ZSTD_sequenceCopier ZSTD_selectSequenceCopier(ZSTD_sequenceFormat_e mode)
+{
     ZSTD_sequenceCopier sequenceCopier = NULL;
     assert(ZSTD_cParam_withinBounds(ZSTD_c_blockDelimiters, mode));
     if (mode == ZSTD_sf_explicitBlockDelimiters) {
@@ -4679,12 +5795,15 @@ static ZSTD_sequenceCopier ZSTD_selectSequenceCopier(ZSTD_sequenceFormat_e mode)
 
 /* Compress, block-by-block, all of the sequences given.
  *
- * Returns the cumulative size of all compressed blocks (including their headers), otherwise a ZSTD error.
+ * Returns the cumulative size of all compressed blocks (including their headers),
+ * otherwise a ZSTD error.
  */
-static size_t ZSTD_compressSequences_internal(ZSTD_CCtx* cctx,
-                                              void* dst, size_t dstCapacity,
-                                              const ZSTD_Sequence* inSeqs, size_t inSeqsSize,
-                                              const void* src, size_t srcSize) {
+static size_t
+ZSTD_compressSequences_internal(ZSTD_CCtx* cctx,
+                                void* dst, size_t dstCapacity,
+                          const ZSTD_Sequence* inSeqs, size_t inSeqsSize,
+                          const void* src, size_t srcSize)
+{
     size_t cSize = 0;
     U32 lastBlock;
     size_t blockSize;
@@ -4694,7 +5813,7 @@ static size_t ZSTD_compressSequences_internal(ZSTD_CCtx* cctx,
 
     BYTE const* ip = (BYTE const*)src;
     BYTE* op = (BYTE*)dst;
-    ZSTD_sequenceCopier sequenceCopier = ZSTD_selectSequenceCopier(cctx->appliedParams.blockDelimiters);
+    ZSTD_sequenceCopier const sequenceCopier = ZSTD_selectSequenceCopier(cctx->appliedParams.blockDelimiters);
 
     DEBUGLOG(4, "ZSTD_compressSequences_internal srcSize: %zu, inSeqsSize: %zu", srcSize, inSeqsSize);
     /* Special case: empty frame */
@@ -4732,7 +5851,7 @@ static size_t ZSTD_compressSequences_internal(ZSTD_CCtx* cctx,
             continue;
         }
 
-        compressedSeqsSize = ZSTD_entropyCompressSequences(&cctx->seqStore,
+        compressedSeqsSize = ZSTD_entropyCompressSeqStore(&cctx->seqStore,
                                 &cctx->blockState.prevCBlock->entropy, &cctx->blockState.nextCBlock->entropy,
                                 &cctx->appliedParams,
                                 op + ZSTD_blockHeaderSize /* Leave space for block header */, dstCapacity - ZSTD_blockHeaderSize,
@@ -4764,7 +5883,7 @@ static size_t ZSTD_compressSequences_internal(ZSTD_CCtx* cctx,
         } else {
             U32 cBlockHeader;
             /* Error checking and repcodes update */
-            ZSTD_confirmRepcodesAndEntropyTables(cctx);
+            ZSTD_blockState_confirmRepcodesAndEntropyTables(&cctx->blockState);
             if (cctx->blockState.prevCBlock->entropy.fse.offcode_repeatMode == FSE_repeat_valid)
                 cctx->blockState.prevCBlock->entropy.fse.offcode_repeatMode = FSE_repeat_check;
 
@@ -4794,7 +5913,8 @@ static size_t ZSTD_compressSequences_internal(ZSTD_CCtx* cctx,
 
 size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* dst, size_t dstCapacity,
                               const ZSTD_Sequence* inSeqs, size_t inSeqsSize,
-                              const void* src, size_t srcSize) {
+                              const void* src, size_t srcSize)
+{
     BYTE* op = (BYTE*)dst;
     size_t cSize = 0;
     size_t compressedBlocksSize = 0;
@@ -4861,117 +5981,11 @@ size_t ZSTD_endStream(ZSTD_CStream* zcs, ZSTD_outBuffer* output)
 
 
 /*-=====  Pre-defined compression levels  =====-*/
+#include "clevels.h"
 
-#define ZSTD_MAX_CLEVEL     22
 int ZSTD_maxCLevel(void) { return ZSTD_MAX_CLEVEL; }
 int ZSTD_minCLevel(void) { return (int)-ZSTD_TARGETLENGTH_MAX; }
-
-static const ZSTD_compressionParameters ZSTD_defaultCParameters[4][ZSTD_MAX_CLEVEL+1] = {
-{   /* "default" - for any srcSize > 256 KB */
-    /* W,  C,  H,  S,  L, TL, strat */
-    { 19, 12, 13,  1,  6,  1, ZSTD_fast    },  /* base for negative levels */
-    { 19, 13, 14,  1,  7,  0, ZSTD_fast    },  /* level  1 */
-    { 20, 15, 16,  1,  6,  0, ZSTD_fast    },  /* level  2 */
-    { 21, 16, 17,  1,  5,  0, ZSTD_dfast   },  /* level  3 */
-    { 21, 18, 18,  1,  5,  0, ZSTD_dfast   },  /* level  4 */
-    { 21, 18, 19,  2,  5,  2, ZSTD_greedy  },  /* level  5 */
-    { 21, 19, 19,  3,  5,  4, ZSTD_greedy  },  /* level  6 */
-    { 21, 19, 19,  3,  5,  8, ZSTD_lazy    },  /* level  7 */
-    { 21, 19, 19,  3,  5, 16, ZSTD_lazy2   },  /* level  8 */
-    { 21, 19, 20,  4,  5, 16, ZSTD_lazy2   },  /* level  9 */
-    { 22, 20, 21,  4,  5, 16, ZSTD_lazy2   },  /* level 10 */
-    { 22, 21, 22,  4,  5, 16, ZSTD_lazy2   },  /* level 11 */
-    { 22, 21, 22,  5,  5, 16, ZSTD_lazy2   },  /* level 12 */
-    { 22, 21, 22,  5,  5, 32, ZSTD_btlazy2 },  /* level 13 */
-    { 22, 22, 23,  5,  5, 32, ZSTD_btlazy2 },  /* level 14 */
-    { 22, 23, 23,  6,  5, 32, ZSTD_btlazy2 },  /* level 15 */
-    { 22, 22, 22,  5,  5, 48, ZSTD_btopt   },  /* level 16 */
-    { 23, 23, 22,  5,  4, 64, ZSTD_btopt   },  /* level 17 */
-    { 23, 23, 22,  6,  3, 64, ZSTD_btultra },  /* level 18 */
-    { 23, 24, 22,  7,  3,256, ZSTD_btultra2},  /* level 19 */
-    { 25, 25, 23,  7,  3,256, ZSTD_btultra2},  /* level 20 */
-    { 26, 26, 24,  7,  3,512, ZSTD_btultra2},  /* level 21 */
-    { 27, 27, 25,  9,  3,999, ZSTD_btultra2},  /* level 22 */
-},
-{   /* for srcSize <= 256 KB */
-    /* W,  C,  H,  S,  L,  T, strat */
-    { 18, 12, 13,  1,  5,  1, ZSTD_fast    },  /* base for negative levels */
-    { 18, 13, 14,  1,  6,  0, ZSTD_fast    },  /* level  1 */
-    { 18, 14, 14,  1,  5,  0, ZSTD_dfast   },  /* level  2 */
-    { 18, 16, 16,  1,  4,  0, ZSTD_dfast   },  /* level  3 */
-    { 18, 16, 17,  2,  5,  2, ZSTD_greedy  },  /* level  4.*/
-    { 18, 18, 18,  3,  5,  2, ZSTD_greedy  },  /* level  5.*/
-    { 18, 18, 19,  3,  5,  4, ZSTD_lazy    },  /* level  6.*/
-    { 18, 18, 19,  4,  4,  4, ZSTD_lazy    },  /* level  7 */
-    { 18, 18, 19,  4,  4,  8, ZSTD_lazy2   },  /* level  8 */
-    { 18, 18, 19,  5,  4,  8, ZSTD_lazy2   },  /* level  9 */
-    { 18, 18, 19,  6,  4,  8, ZSTD_lazy2   },  /* level 10 */
-    { 18, 18, 19,  5,  4, 12, ZSTD_btlazy2 },  /* level 11.*/
-    { 18, 19, 19,  7,  4, 12, ZSTD_btlazy2 },  /* level 12.*/
-    { 18, 18, 19,  4,  4, 16, ZSTD_btopt   },  /* level 13 */
-    { 18, 18, 19,  4,  3, 32, ZSTD_btopt   },  /* level 14.*/
-    { 18, 18, 19,  6,  3,128, ZSTD_btopt   },  /* level 15.*/
-    { 18, 19, 19,  6,  3,128, ZSTD_btultra },  /* level 16.*/
-    { 18, 19, 19,  8,  3,256, ZSTD_btultra },  /* level 17.*/
-    { 18, 19, 19,  6,  3,128, ZSTD_btultra2},  /* level 18.*/
-    { 18, 19, 19,  8,  3,256, ZSTD_btultra2},  /* level 19.*/
-    { 18, 19, 19, 10,  3,512, ZSTD_btultra2},  /* level 20.*/
-    { 18, 19, 19, 12,  3,512, ZSTD_btultra2},  /* level 21.*/
-    { 18, 19, 19, 13,  3,999, ZSTD_btultra2},  /* level 22.*/
-},
-{   /* for srcSize <= 128 KB */
-    /* W,  C,  H,  S,  L,  T, strat */
-    { 17, 12, 12,  1,  5,  1, ZSTD_fast    },  /* base for negative levels */
-    { 17, 12, 13,  1,  6,  0, ZSTD_fast    },  /* level  1 */
-    { 17, 13, 15,  1,  5,  0, ZSTD_fast    },  /* level  2 */
-    { 17, 15, 16,  2,  5,  0, ZSTD_dfast   },  /* level  3 */
-    { 17, 17, 17,  2,  4,  0, ZSTD_dfast   },  /* level  4 */
-    { 17, 16, 17,  3,  4,  2, ZSTD_greedy  },  /* level  5 */
-    { 17, 17, 17,  3,  4,  4, ZSTD_lazy    },  /* level  6 */
-    { 17, 17, 17,  3,  4,  8, ZSTD_lazy2   },  /* level  7 */
-    { 17, 17, 17,  4,  4,  8, ZSTD_lazy2   },  /* level  8 */
-    { 17, 17, 17,  5,  4,  8, ZSTD_lazy2   },  /* level  9 */
-    { 17, 17, 17,  6,  4,  8, ZSTD_lazy2   },  /* level 10 */
-    { 17, 17, 17,  5,  4,  8, ZSTD_btlazy2 },  /* level 11 */
-    { 17, 18, 17,  7,  4, 12, ZSTD_btlazy2 },  /* level 12 */
-    { 17, 18, 17,  3,  4, 12, ZSTD_btopt   },  /* level 13.*/
-    { 17, 18, 17,  4,  3, 32, ZSTD_btopt   },  /* level 14.*/
-    { 17, 18, 17,  6,  3,256, ZSTD_btopt   },  /* level 15.*/
-    { 17, 18, 17,  6,  3,128, ZSTD_btultra },  /* level 16.*/
-    { 17, 18, 17,  8,  3,256, ZSTD_btultra },  /* level 17.*/
-    { 17, 18, 17, 10,  3,512, ZSTD_btultra },  /* level 18.*/
-    { 17, 18, 17,  5,  3,256, ZSTD_btultra2},  /* level 19.*/
-    { 17, 18, 17,  7,  3,512, ZSTD_btultra2},  /* level 20.*/
-    { 17, 18, 17,  9,  3,512, ZSTD_btultra2},  /* level 21.*/
-    { 17, 18, 17, 11,  3,999, ZSTD_btultra2},  /* level 22.*/
-},
-{   /* for srcSize <= 16 KB */
-    /* W,  C,  H,  S,  L,  T, strat */
-    { 14, 12, 13,  1,  5,  1, ZSTD_fast    },  /* base for negative levels */
-    { 14, 14, 15,  1,  5,  0, ZSTD_fast    },  /* level  1 */
-    { 14, 14, 15,  1,  4,  0, ZSTD_fast    },  /* level  2 */
-    { 14, 14, 15,  2,  4,  0, ZSTD_dfast   },  /* level  3 */
-    { 14, 14, 14,  4,  4,  2, ZSTD_greedy  },  /* level  4 */
-    { 14, 14, 14,  3,  4,  4, ZSTD_lazy    },  /* level  5.*/
-    { 14, 14, 14,  4,  4,  8, ZSTD_lazy2   },  /* level  6 */
-    { 14, 14, 14,  6,  4,  8, ZSTD_lazy2   },  /* level  7 */
-    { 14, 14, 14,  8,  4,  8, ZSTD_lazy2   },  /* level  8.*/
-    { 14, 15, 14,  5,  4,  8, ZSTD_btlazy2 },  /* level  9.*/
-    { 14, 15, 14,  9,  4,  8, ZSTD_btlazy2 },  /* level 10.*/
-    { 14, 15, 14,  3,  4, 12, ZSTD_btopt   },  /* level 11.*/
-    { 14, 15, 14,  4,  3, 24, ZSTD_btopt   },  /* level 12.*/
-    { 14, 15, 14,  5,  3, 32, ZSTD_btultra },  /* level 13.*/
-    { 14, 15, 15,  6,  3, 64, ZSTD_btultra },  /* level 14.*/
-    { 14, 15, 15,  7,  3,256, ZSTD_btultra },  /* level 15.*/
-    { 14, 15, 15,  5,  3, 48, ZSTD_btultra2},  /* level 16.*/
-    { 14, 15, 15,  6,  3,128, ZSTD_btultra2},  /* level 17.*/
-    { 14, 15, 15,  7,  3,256, ZSTD_btultra2},  /* level 18.*/
-    { 14, 15, 15,  8,  3,256, ZSTD_btultra2},  /* level 19.*/
-    { 14, 15, 15,  8,  3,512, ZSTD_btultra2},  /* level 20.*/
-    { 14, 15, 15,  9,  3,512, ZSTD_btultra2},  /* level 21.*/
-    { 14, 15, 15, 10,  3,999, ZSTD_btultra2},  /* level 22.*/
-},
-};
+int ZSTD_defaultCLevel(void) { return ZSTD_CLEVEL_DEFAULT; }
 
 static ZSTD_compressionParameters ZSTD_dedicatedDictSearch_getCParams(int const compressionLevel, size_t const dictSize)
 {
@@ -4999,7 +6013,7 @@ static int ZSTD_dedicatedDictSearch_isSupported(
 {
     return (cParams->strategy >= ZSTD_greedy)
         && (cParams->strategy <= ZSTD_lazy2)
-        && (cParams->hashLog >= cParams->chainLog)
+        && (cParams->hashLog > cParams->chainLog)
         && (cParams->chainLog <= 24);
 }
 
@@ -5018,6 +6032,9 @@ static void ZSTD_dedicatedDictSearch_revertCParams(
         case ZSTD_lazy:
         case ZSTD_lazy2:
             cParams->hashLog -= ZSTD_LAZY_DDSS_BUCKET_LOG;
+            if (cParams->hashLog < ZSTD_HASHLOG_MIN) {
+                cParams->hashLog = ZSTD_HASHLOG_MIN;
+            }
             break;
         case ZSTD_btlazy2:
         case ZSTD_btopt:
@@ -5066,6 +6083,7 @@ static ZSTD_compressionParameters ZSTD_getCParams_internal(int compressionLevel,
     else row = compressionLevel;
 
     {   ZSTD_compressionParameters cp = ZSTD_defaultCParameters[tableID][row];
+        DEBUGLOG(5, "ZSTD_getCParams_internal selected tableID: %u row: %u strat: %u", tableID, row, (U32)cp.strategy);
         /* acceleration factor */
         if (compressionLevel < 0) {
             int const clampedCompressionLevel = MAX(ZSTD_minCLevel(), compressionLevel);
diff --git a/lib/zstd/compress/zstd_compress_internal.h b/lib/zstd/compress/zstd_compress_internal.h
index 685d2f996cc2..71697a11ae30 100644
--- a/lib/zstd/compress/zstd_compress_internal.h
+++ b/lib/zstd/compress/zstd_compress_internal.h
@@ -57,7 +57,7 @@ typedef struct {
 } ZSTD_localDict;
 
 typedef struct {
-    HUF_CElt CTable[HUF_CTABLE_SIZE_U32(255)];
+    HUF_CElt CTable[HUF_CTABLE_SIZE_ST(255)];
     HUF_repeat repeatMode;
 } ZSTD_hufCTables_t;
 
@@ -75,8 +75,55 @@ typedef struct {
     ZSTD_fseCTables_t fse;
 } ZSTD_entropyCTables_t;
 
+/* *********************************************
+*  Entropy buffer statistics structs and funcs *
+***********************************************/
+/* ZSTD_hufCTablesMetadata_t :
+ *  Stores Literals Block Type for a super-block in hType, and
+ *  huffman tree description in hufDesBuffer.
+ *  hufDesSize refers to the size of huffman tree description in bytes.
+ *  This metadata is populated in ZSTD_buildBlockEntropyStats_literals() */
 typedef struct {
-    U32 off;            /* Offset code (offset + ZSTD_REP_MOVE) for the match */
+    symbolEncodingType_e hType;
+    BYTE hufDesBuffer[ZSTD_MAX_HUF_HEADER_SIZE];
+    size_t hufDesSize;
+} ZSTD_hufCTablesMetadata_t;
+
+/* ZSTD_fseCTablesMetadata_t :
+ *  Stores symbol compression modes for a super-block in {ll, ol, ml}Type, and
+ *  fse tables in fseTablesBuffer.
+ *  fseTablesSize refers to the size of fse tables in bytes.
+ *  This metadata is populated in ZSTD_buildBlockEntropyStats_sequences() */
+typedef struct {
+    symbolEncodingType_e llType;
+    symbolEncodingType_e ofType;
+    symbolEncodingType_e mlType;
+    BYTE fseTablesBuffer[ZSTD_MAX_FSE_HEADERS_SIZE];
+    size_t fseTablesSize;
+    size_t lastCountSize; /* This is to account for bug in 1.3.4. More detail in ZSTD_entropyCompressSeqStore_internal() */
+} ZSTD_fseCTablesMetadata_t;
+
+typedef struct {
+    ZSTD_hufCTablesMetadata_t hufMetadata;
+    ZSTD_fseCTablesMetadata_t fseMetadata;
+} ZSTD_entropyCTablesMetadata_t;
+
+/* ZSTD_buildBlockEntropyStats() :
+ *  Builds entropy for the block.
+ *  @return : 0 on success or error code */
+size_t ZSTD_buildBlockEntropyStats(seqStore_t* seqStorePtr,
+                             const ZSTD_entropyCTables_t* prevEntropy,
+                                   ZSTD_entropyCTables_t* nextEntropy,
+                             const ZSTD_CCtx_params* cctxParams,
+                                   ZSTD_entropyCTablesMetadata_t* entropyMetadata,
+                                   void* workspace, size_t wkspSize);
+
+/* *******************************
+*  Compression internals structs *
+*********************************/
+
+typedef struct {
+    U32 off;            /* Offset sumtype code for the match, using ZSTD_storeSeq() format */
     U32 len;            /* Raw length of match */
 } ZSTD_match_t;
 
@@ -126,7 +173,7 @@ typedef struct {
     U32  offCodeSumBasePrice;    /* to compare to log2(offreq)  */
     ZSTD_OptPrice_e priceType;   /* prices can be determined dynamically, or follow a pre-defined cost structure */
     const ZSTD_entropyCTables_t* symbolCosts;  /* pre-calculated dictionary statistics */
-    ZSTD_literalCompressionMode_e literalCompressionMode;
+    ZSTD_paramSwitch_e literalCompressionMode;
 } optState_t;
 
 typedef struct {
@@ -135,14 +182,23 @@ typedef struct {
 } ZSTD_compressedBlockState_t;
 
 typedef struct {
-    BYTE const* nextSrc;    /* next block here to continue on current prefix */
-    BYTE const* base;       /* All regular indexes relative to this position */
-    BYTE const* dictBase;   /* extDict indexes relative to this position */
-    U32 dictLimit;          /* below that point, need extDict */
-    U32 lowLimit;           /* below that point, no more valid data */
+    BYTE const* nextSrc;       /* next block here to continue on current prefix */
+    BYTE const* base;          /* All regular indexes relative to this position */
+    BYTE const* dictBase;      /* extDict indexes relative to this position */
+    U32 dictLimit;             /* below that point, need extDict */
+    U32 lowLimit;              /* below that point, no more valid data */
+    U32 nbOverflowCorrections; /* Number of times overflow correction has run since
+                                * ZSTD_window_init(). Useful for debugging coredumps
+                                * and for ZSTD_WINDOW_OVERFLOW_CORRECT_FREQUENTLY.
+                                */
 } ZSTD_window_t;
 
+#define ZSTD_WINDOW_START_INDEX 2
+
 typedef struct ZSTD_matchState_t ZSTD_matchState_t;
+
+#define ZSTD_ROW_HASH_CACHE_SIZE 8       /* Size of prefetching hash cache for row-based matchfinder */
+
 struct ZSTD_matchState_t {
     ZSTD_window_t window;   /* State for window round buffer management */
     U32 loadedDictEnd;      /* index of end of dictionary, within context's referential.
@@ -154,9 +210,17 @@ struct ZSTD_matchState_t {
                              */
     U32 nextToUpdate;       /* index from which to continue table update */
     U32 hashLog3;           /* dispatch table for matches of len==3 : larger == faster, more memory */
+
+    U32 rowHashLog;                          /* For row-based matchfinder: Hashlog based on nb of rows in the hashTable.*/
+    U16* tagTable;                           /* For row-based matchFinder: A row-based table containing the hashes and head index. */
+    U32 hashCache[ZSTD_ROW_HASH_CACHE_SIZE]; /* For row-based matchFinder: a cache of hashes to improve speed */
+
     U32* hashTable;
     U32* hashTable3;
     U32* chainTable;
+
+    U32 forceNonContiguous; /* Non-zero if we should force non-contiguous load for the next window update. */
+
     int dedicatedDictSearch;  /* Indicates whether this matchState is using the
                                * dedicated dictionary search structure.
                                */
@@ -196,7 +260,7 @@ typedef struct {
 } ldmState_t;
 
 typedef struct {
-    U32 enableLdm;          /* 1 if enable long distance matching */
+    ZSTD_paramSwitch_e enableLdm; /* ZSTD_ps_enable to enable LDM. ZSTD_ps_auto by default */
     U32 hashLog;            /* Log size of hashTable */
     U32 bucketSizeLog;      /* Log bucket size for collision resolution, at most 8 */
     U32 minMatchLength;     /* Minimum match length */
@@ -227,7 +291,7 @@ struct ZSTD_CCtx_params_s {
                                 * There is no guarantee that hint is close to actual source size */
 
     ZSTD_dictAttachPref_e attachDictPref;
-    ZSTD_literalCompressionMode_e literalCompressionMode;
+    ZSTD_paramSwitch_e literalCompressionMode;
 
     /* Multithreading: used to pass parameters to mtctx */
     int nbWorkers;
@@ -249,6 +313,15 @@ struct ZSTD_CCtx_params_s {
     ZSTD_sequenceFormat_e blockDelimiters;
     int validateSequences;
 
+    /* Block splitting */
+    ZSTD_paramSwitch_e useBlockSplitter;
+
+    /* Param for deciding whether to use row-based matchfinder */
+    ZSTD_paramSwitch_e useRowMatchFinder;
+
+    /* Always load a dictionary in ext-dict mode (not prefix mode)? */
+    int deterministicRefPrefix;
+
     /* Internal use, for createCCtxParams() and freeCCtxParams() only */
     ZSTD_customMem customMem;
 };  /* typedef'd to ZSTD_CCtx_params within "zstd.h" */
@@ -266,12 +339,29 @@ typedef enum {
     ZSTDb_buffered
 } ZSTD_buffered_policy_e;
 
+/*
+ * Struct that contains all elements of block splitter that should be allocated
+ * in a wksp.
+ */
+#define ZSTD_MAX_NB_BLOCK_SPLITS 196
+typedef struct {
+    seqStore_t fullSeqStoreChunk;
+    seqStore_t firstHalfSeqStore;
+    seqStore_t secondHalfSeqStore;
+    seqStore_t currSeqStore;
+    seqStore_t nextSeqStore;
+
+    U32 partitions[ZSTD_MAX_NB_BLOCK_SPLITS];
+    ZSTD_entropyCTablesMetadata_t entropyMetadata;
+} ZSTD_blockSplitCtx;
+
 struct ZSTD_CCtx_s {
     ZSTD_compressionStage_e stage;
     int cParamsChanged;                  /* == 1 if cParams(except wlog) or compression level are changed in requestedParams. Triggers transmission of new params to ZSTDMT (if available) then reset to 0. */
     int bmi2;                            /* == 1 if the CPU supports BMI2 and 0 otherwise. CPU support is determined dynamically once per context lifetime. */
     ZSTD_CCtx_params requestedParams;
     ZSTD_CCtx_params appliedParams;
+    ZSTD_CCtx_params simpleApiParams;    /* Param storage used by the simple API - not sticky. Must only be used in top-level simple API functions for storage. */
     U32   dictID;
     size_t dictContentSize;
 
@@ -296,7 +386,7 @@ struct ZSTD_CCtx_s {
     ZSTD_blockState_t blockState;
     U32* entropyWorkspace;  /* entropy workspace of ENTROPY_WORKSPACE_SIZE bytes */
 
-    /* Wether we are streaming or not */
+    /* Whether we are streaming or not */
     ZSTD_buffered_policy_e bufferedPolicy;
 
     /* streaming */
@@ -324,6 +414,9 @@ struct ZSTD_CCtx_s {
     /* Multi-threading */
 
     /* Tracing */
+
+    /* Workspace for block splitter */
+    ZSTD_blockSplitCtx blockSplitCtx;
 };
 
 typedef enum { ZSTD_dtlm_fast, ZSTD_dtlm_full } ZSTD_dictTableLoadMethod_e;
@@ -358,7 +451,7 @@ typedef enum {
 typedef size_t (*ZSTD_blockCompressor) (
         ZSTD_matchState_t* bs, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         void const* src, size_t srcSize);
-ZSTD_blockCompressor ZSTD_selectBlockCompressor(ZSTD_strategy strat, ZSTD_dictMode_e dictMode);
+ZSTD_blockCompressor ZSTD_selectBlockCompressor(ZSTD_strategy strat, ZSTD_paramSwitch_e rowMatchfinderMode, ZSTD_dictMode_e dictMode);
 
 
 MEM_STATIC U32 ZSTD_LLcode(U32 litLength)
@@ -392,31 +485,6 @@ MEM_STATIC U32 ZSTD_MLcode(U32 mlBase)
     return (mlBase > 127) ? ZSTD_highbit32(mlBase) + ML_deltaCode : ML_Code[mlBase];
 }
 
-typedef struct repcodes_s {
-    U32 rep[3];
-} repcodes_t;
-
-MEM_STATIC repcodes_t ZSTD_updateRep(U32 const rep[3], U32 const offset, U32 const ll0)
-{
-    repcodes_t newReps;
-    if (offset >= ZSTD_REP_NUM) {  /* full offset */
-        newReps.rep[2] = rep[1];
-        newReps.rep[1] = rep[0];
-        newReps.rep[0] = offset - ZSTD_REP_MOVE;
-    } else {   /* repcode */
-        U32 const repCode = offset + ll0;
-        if (repCode > 0) {  /* note : if repCode==0, no change */
-            U32 const currentOffset = (repCode==ZSTD_REP_NUM) ? (rep[0] - 1) : rep[repCode];
-            newReps.rep[2] = (repCode >= 2) ? rep[1] : rep[2];
-            newReps.rep[1] = rep[0];
-            newReps.rep[0] = currentOffset;
-        } else {   /* repCode == 0 */
-            ZSTD_memcpy(&newReps, rep, sizeof(newReps));
-        }
-    }
-    return newReps;
-}
-
 /* ZSTD_cParam_withinBounds:
  * @return 1 if value is within cParam bounds,
  * 0 otherwise */
@@ -465,17 +533,17 @@ MEM_STATIC size_t ZSTD_minGain(size_t srcSize, ZSTD_strategy strat)
     return (srcSize >> minlog) + 2;
 }
 
-MEM_STATIC int ZSTD_disableLiteralsCompression(const ZSTD_CCtx_params* cctxParams)
+MEM_STATIC int ZSTD_literalsCompressionIsDisabled(const ZSTD_CCtx_params* cctxParams)
 {
     switch (cctxParams->literalCompressionMode) {
-    case ZSTD_lcm_huffman:
+    case ZSTD_ps_enable:
         return 0;
-    case ZSTD_lcm_uncompressed:
+    case ZSTD_ps_disable:
         return 1;
     default:
         assert(0 /* impossible: pre-validated */);
         ZSTD_FALLTHROUGH;
-    case ZSTD_lcm_auto:
+    case ZSTD_ps_auto:
         return (cctxParams->cParams.strategy == ZSTD_fast) && (cctxParams->cParams.targetLength > 0);
     }
 }
@@ -485,7 +553,9 @@ MEM_STATIC int ZSTD_disableLiteralsCompression(const ZSTD_CCtx_params* cctxParam
  *  Only called when the sequence ends past ilimit_w, so it only needs to be optimized for single
  *  large copies.
  */
-static void ZSTD_safecopyLiterals(BYTE* op, BYTE const* ip, BYTE const* const iend, BYTE const* ilimit_w) {
+static void
+ZSTD_safecopyLiterals(BYTE* op, BYTE const* ip, BYTE const* const iend, BYTE const* ilimit_w)
+{
     assert(iend > ilimit_w);
     if (ip <= ilimit_w) {
         ZSTD_wildcopy(op, ip, ilimit_w - ip, ZSTD_no_overlap);
@@ -495,14 +565,30 @@ static void ZSTD_safecopyLiterals(BYTE* op, BYTE const* ip, BYTE const* const ie
     while (ip < iend) *op++ = *ip++;
 }
 
+#define ZSTD_REP_MOVE     (ZSTD_REP_NUM-1)
+#define STORE_REPCODE_1 STORE_REPCODE(1)
+#define STORE_REPCODE_2 STORE_REPCODE(2)
+#define STORE_REPCODE_3 STORE_REPCODE(3)
+#define STORE_REPCODE(r) (assert((r)>=1), assert((r)<=3), (r)-1)
+#define STORE_OFFSET(o)  (assert((o)>0), o + ZSTD_REP_MOVE)
+#define STORED_IS_OFFSET(o)  ((o) > ZSTD_REP_MOVE)
+#define STORED_IS_REPCODE(o) ((o) <= ZSTD_REP_MOVE)
+#define STORED_OFFSET(o)  (assert(STORED_IS_OFFSET(o)), (o)-ZSTD_REP_MOVE)
+#define STORED_REPCODE(o) (assert(STORED_IS_REPCODE(o)), (o)+1)  /* returns ID 1,2,3 */
+#define STORED_TO_OFFBASE(o) ((o)+1)
+#define OFFBASE_TO_STORED(o) ((o)-1)
+
 /*! ZSTD_storeSeq() :
- *  Store a sequence (litlen, litPtr, offCode and mlBase) into seqStore_t.
- *  `offCode` : distance to match + ZSTD_REP_MOVE (values <= ZSTD_REP_MOVE are repCodes).
- *  `mlBase` : matchLength - MINMATCH
+ *  Store a sequence (litlen, litPtr, offCode and matchLength) into seqStore_t.
+ *  @offBase_minus1 : Users should use employ macros STORE_REPCODE_X and STORE_OFFSET().
+ *  @matchLength : must be >= MINMATCH
  *  Allowed to overread literals up to litLimit.
 */
-HINT_INLINE UNUSED_ATTR
-void ZSTD_storeSeq(seqStore_t* seqStorePtr, size_t litLength, const BYTE* literals, const BYTE* litLimit, U32 offCode, size_t mlBase)
+HINT_INLINE UNUSED_ATTR void
+ZSTD_storeSeq(seqStore_t* seqStorePtr,
+              size_t litLength, const BYTE* literals, const BYTE* litLimit,
+              U32 offBase_minus1,
+              size_t matchLength)
 {
     BYTE const* const litLimit_w = litLimit - WILDCOPY_OVERLENGTH;
     BYTE const* const litEnd = literals + litLength;
@@ -511,7 +597,7 @@ void ZSTD_storeSeq(seqStore_t* seqStorePtr, size_t litLength, const BYTE* litera
     if (g_start==NULL) g_start = (const BYTE*)literals;  /* note : index only works for compression within a single segment */
     {   U32 const pos = (U32)((const BYTE*)literals - g_start);
         DEBUGLOG(6, "Cpos%7u :%3u literals, match%4u bytes at offCode%7u",
-               pos, (U32)litLength, (U32)mlBase+MINMATCH, (U32)offCode);
+               pos, (U32)litLength, (U32)matchLength, (U32)offBase_minus1);
     }
 #endif
     assert((size_t)(seqStorePtr->sequences - seqStorePtr->sequencesStart) < seqStorePtr->maxNbSeq);
@@ -535,26 +621,66 @@ void ZSTD_storeSeq(seqStore_t* seqStorePtr, size_t litLength, const BYTE* litera
 
     /* literal Length */
     if (litLength>0xFFFF) {
-        assert(seqStorePtr->longLengthID == 0); /* there can only be a single long length */
-        seqStorePtr->longLengthID = 1;
+        assert(seqStorePtr->longLengthType == ZSTD_llt_none); /* there can only be a single long length */
+        seqStorePtr->longLengthType = ZSTD_llt_literalLength;
         seqStorePtr->longLengthPos = (U32)(seqStorePtr->sequences - seqStorePtr->sequencesStart);
     }
     seqStorePtr->sequences[0].litLength = (U16)litLength;
 
     /* match offset */
-    seqStorePtr->sequences[0].offset = offCode + 1;
+    seqStorePtr->sequences[0].offBase = STORED_TO_OFFBASE(offBase_minus1);
 
     /* match Length */
-    if (mlBase>0xFFFF) {
-        assert(seqStorePtr->longLengthID == 0); /* there can only be a single long length */
-        seqStorePtr->longLengthID = 2;
-        seqStorePtr->longLengthPos = (U32)(seqStorePtr->sequences - seqStorePtr->sequencesStart);
+    assert(matchLength >= MINMATCH);
+    {   size_t const mlBase = matchLength - MINMATCH;
+        if (mlBase>0xFFFF) {
+            assert(seqStorePtr->longLengthType == ZSTD_llt_none); /* there can only be a single long length */
+            seqStorePtr->longLengthType = ZSTD_llt_matchLength;
+            seqStorePtr->longLengthPos = (U32)(seqStorePtr->sequences - seqStorePtr->sequencesStart);
+        }
+        seqStorePtr->sequences[0].mlBase = (U16)mlBase;
     }
-    seqStorePtr->sequences[0].matchLength = (U16)mlBase;
 
     seqStorePtr->sequences++;
 }
 
+/* ZSTD_updateRep() :
+ * updates in-place @rep (array of repeat offsets)
+ * @offBase_minus1 : sum-type, with same numeric representation as ZSTD_storeSeq()
+ */
+MEM_STATIC void
+ZSTD_updateRep(U32 rep[ZSTD_REP_NUM], U32 const offBase_minus1, U32 const ll0)
+{
+    if (STORED_IS_OFFSET(offBase_minus1)) {  /* full offset */
+        rep[2] = rep[1];
+        rep[1] = rep[0];
+        rep[0] = STORED_OFFSET(offBase_minus1);
+    } else {   /* repcode */
+        U32 const repCode = STORED_REPCODE(offBase_minus1) - 1 + ll0;
+        if (repCode > 0) {  /* note : if repCode==0, no change */
+            U32 const currentOffset = (repCode==ZSTD_REP_NUM) ? (rep[0] - 1) : rep[repCode];
+            rep[2] = (repCode >= 2) ? rep[1] : rep[2];
+            rep[1] = rep[0];
+            rep[0] = currentOffset;
+        } else {   /* repCode == 0 */
+            /* nothing to do */
+        }
+    }
+}
+
+typedef struct repcodes_s {
+    U32 rep[3];
+} repcodes_t;
+
+MEM_STATIC repcodes_t
+ZSTD_newRep(U32 const rep[ZSTD_REP_NUM], U32 const offBase_minus1, U32 const ll0)
+{
+    repcodes_t newReps;
+    ZSTD_memcpy(&newReps, rep, sizeof(newReps));
+    ZSTD_updateRep(newReps.rep, offBase_minus1, ll0);
+    return newReps;
+}
+
 
 /*-*************************************
 *  Match length counter
@@ -778,6 +904,13 @@ MEM_STATIC void ZSTD_window_clear(ZSTD_window_t* window)
     window->dictLimit = end;
 }
 
+MEM_STATIC U32 ZSTD_window_isEmpty(ZSTD_window_t const window)
+{
+    return window.dictLimit == ZSTD_WINDOW_START_INDEX &&
+           window.lowLimit == ZSTD_WINDOW_START_INDEX &&
+           (window.nextSrc - window.base) == ZSTD_WINDOW_START_INDEX;
+}
+
 /*
  * ZSTD_window_hasExtDict():
  * Returns non-zero if the window has a non-empty extDict.
@@ -801,15 +934,71 @@ MEM_STATIC ZSTD_dictMode_e ZSTD_matchState_dictMode(const ZSTD_matchState_t *ms)
             ZSTD_noDict;
 }
 
+/* Defining this macro to non-zero tells zstd to run the overflow correction
+ * code much more frequently. This is very inefficient, and should only be
+ * used for tests and fuzzers.
+ */
+#ifndef ZSTD_WINDOW_OVERFLOW_CORRECT_FREQUENTLY
+#  ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+#    define ZSTD_WINDOW_OVERFLOW_CORRECT_FREQUENTLY 1
+#  else
+#    define ZSTD_WINDOW_OVERFLOW_CORRECT_FREQUENTLY 0
+#  endif
+#endif
+
+/*
+ * ZSTD_window_canOverflowCorrect():
+ * Returns non-zero if the indices are large enough for overflow correction
+ * to work correctly without impacting compression ratio.
+ */
+MEM_STATIC U32 ZSTD_window_canOverflowCorrect(ZSTD_window_t const window,
+                                              U32 cycleLog,
+                                              U32 maxDist,
+                                              U32 loadedDictEnd,
+                                              void const* src)
+{
+    U32 const cycleSize = 1u << cycleLog;
+    U32 const curr = (U32)((BYTE const*)src - window.base);
+    U32 const minIndexToOverflowCorrect = cycleSize
+                                        + MAX(maxDist, cycleSize)
+                                        + ZSTD_WINDOW_START_INDEX;
+
+    /* Adjust the min index to backoff the overflow correction frequency,
+     * so we don't waste too much CPU in overflow correction. If this
+     * computation overflows we don't really care, we just need to make
+     * sure it is at least minIndexToOverflowCorrect.
+     */
+    U32 const adjustment = window.nbOverflowCorrections + 1;
+    U32 const adjustedIndex = MAX(minIndexToOverflowCorrect * adjustment,
+                                  minIndexToOverflowCorrect);
+    U32 const indexLargeEnough = curr > adjustedIndex;
+
+    /* Only overflow correct early if the dictionary is invalidated already,
+     * so we don't hurt compression ratio.
+     */
+    U32 const dictionaryInvalidated = curr > maxDist + loadedDictEnd;
+
+    return indexLargeEnough && dictionaryInvalidated;
+}
+
 /*
  * ZSTD_window_needOverflowCorrection():
  * Returns non-zero if the indices are getting too large and need overflow
  * protection.
  */
 MEM_STATIC U32 ZSTD_window_needOverflowCorrection(ZSTD_window_t const window,
+                                                  U32 cycleLog,
+                                                  U32 maxDist,
+                                                  U32 loadedDictEnd,
+                                                  void const* src,
                                                   void const* srcEnd)
 {
     U32 const curr = (U32)((BYTE const*)srcEnd - window.base);
+    if (ZSTD_WINDOW_OVERFLOW_CORRECT_FREQUENTLY) {
+        if (ZSTD_window_canOverflowCorrect(window, cycleLog, maxDist, loadedDictEnd, src)) {
+            return 1;
+        }
+    }
     return curr > ZSTD_CURRENT_MAX;
 }
 
@@ -821,7 +1010,6 @@ MEM_STATIC U32 ZSTD_window_needOverflowCorrection(ZSTD_window_t const window,
  *
  * The least significant cycleLog bits of the indices must remain the same,
  * which may be 0. Every index up to maxDist in the past must be valid.
- * NOTE: (maxDist & cycleMask) must be zero.
  */
 MEM_STATIC U32 ZSTD_window_correctOverflow(ZSTD_window_t* window, U32 cycleLog,
                                            U32 maxDist, void const* src)
@@ -845,32 +1033,52 @@ MEM_STATIC U32 ZSTD_window_correctOverflow(ZSTD_window_t* window, U32 cycleLog,
      * 3. (cctx->lowLimit + 1<<windowLog) < 1<<32:
      *    windowLog <= 31 ==> 3<<29 + 1<<windowLog < 7<<29 < 1<<32.
      */
-    U32 const cycleMask = (1U << cycleLog) - 1;
+    U32 const cycleSize = 1u << cycleLog;
+    U32 const cycleMask = cycleSize - 1;
     U32 const curr = (U32)((BYTE const*)src - window->base);
-    U32 const currentCycle0 = curr & cycleMask;
-    /* Exclude zero so that newCurrent - maxDist >= 1. */
-    U32 const currentCycle1 = currentCycle0 == 0 ? (1U << cycleLog) : currentCycle0;
-    U32 const newCurrent = currentCycle1 + maxDist;
+    U32 const currentCycle = curr & cycleMask;
+    /* Ensure newCurrent - maxDist >= ZSTD_WINDOW_START_INDEX. */
+    U32 const currentCycleCorrection = currentCycle < ZSTD_WINDOW_START_INDEX
+                                     ? MAX(cycleSize, ZSTD_WINDOW_START_INDEX)
+                                     : 0;
+    U32 const newCurrent = currentCycle
+                         + currentCycleCorrection
+                         + MAX(maxDist, cycleSize);
     U32 const correction = curr - newCurrent;
-    assert((maxDist & cycleMask) == 0);
+    /* maxDist must be a power of two so that:
+     *   (newCurrent & cycleMask) == (curr & cycleMask)
+     * This is required to not corrupt the chains / binary tree.
+     */
+    assert((maxDist & (maxDist - 1)) == 0);
+    assert((curr & cycleMask) == (newCurrent & cycleMask));
     assert(curr > newCurrent);
-    /* Loose bound, should be around 1<<29 (see above) */
-    assert(correction > 1<<28);
+    if (!ZSTD_WINDOW_OVERFLOW_CORRECT_FREQUENTLY) {
+        /* Loose bound, should be around 1<<29 (see above) */
+        assert(correction > 1<<28);
+    }
 
     window->base += correction;
     window->dictBase += correction;
-    if (window->lowLimit <= correction) window->lowLimit = 1;
-    else window->lowLimit -= correction;
-    if (window->dictLimit <= correction) window->dictLimit = 1;
-    else window->dictLimit -= correction;
+    if (window->lowLimit < correction + ZSTD_WINDOW_START_INDEX) {
+        window->lowLimit = ZSTD_WINDOW_START_INDEX;
+    } else {
+        window->lowLimit -= correction;
+    }
+    if (window->dictLimit < correction + ZSTD_WINDOW_START_INDEX) {
+        window->dictLimit = ZSTD_WINDOW_START_INDEX;
+    } else {
+        window->dictLimit -= correction;
+    }
 
     /* Ensure we can still reference the full window. */
     assert(newCurrent >= maxDist);
-    assert(newCurrent - maxDist >= 1);
+    assert(newCurrent - maxDist >= ZSTD_WINDOW_START_INDEX);
     /* Ensure that lowLimit and dictLimit didn't underflow. */
     assert(window->lowLimit <= newCurrent);
     assert(window->dictLimit <= newCurrent);
 
+    ++window->nbOverflowCorrections;
+
     DEBUGLOG(4, "Correction of 0x%x bytes to lowLimit=0x%x", correction,
              window->lowLimit);
     return correction;
@@ -975,11 +1183,13 @@ ZSTD_checkDictValidity(const ZSTD_window_t* window,
 
 MEM_STATIC void ZSTD_window_init(ZSTD_window_t* window) {
     ZSTD_memset(window, 0, sizeof(*window));
-    window->base = (BYTE const*)"";
-    window->dictBase = (BYTE const*)"";
-    window->dictLimit = 1;    /* start from 1, so that 1st position is valid */
-    window->lowLimit = 1;     /* it ensures first and later CCtx usages compress the same */
-    window->nextSrc = window->base + 1;   /* see issue #1241 */
+    window->base = (BYTE const*)" ";
+    window->dictBase = (BYTE const*)" ";
+    ZSTD_STATIC_ASSERT(ZSTD_DUBT_UNSORTED_MARK < ZSTD_WINDOW_START_INDEX); /* Start above ZSTD_DUBT_UNSORTED_MARK */
+    window->dictLimit = ZSTD_WINDOW_START_INDEX;    /* start from >0, so that 1st position is valid */
+    window->lowLimit = ZSTD_WINDOW_START_INDEX;     /* it ensures first and later CCtx usages compress the same */
+    window->nextSrc = window->base + ZSTD_WINDOW_START_INDEX;   /* see issue #1241 */
+    window->nbOverflowCorrections = 0;
 }
 
 /*
@@ -990,7 +1200,8 @@ MEM_STATIC void ZSTD_window_init(ZSTD_window_t* window) {
  * Returns non-zero if the segment is contiguous.
  */
 MEM_STATIC U32 ZSTD_window_update(ZSTD_window_t* window,
-                                  void const* src, size_t srcSize)
+                                  void const* src, size_t srcSize,
+                                  int forceNonContiguous)
 {
     BYTE const* const ip = (BYTE const*)src;
     U32 contiguous = 1;
@@ -1000,7 +1211,7 @@ MEM_STATIC U32 ZSTD_window_update(ZSTD_window_t* window,
     assert(window->base != NULL);
     assert(window->dictBase != NULL);
     /* Check if blocks follow each other */
-    if (src != window->nextSrc) {
+    if (src != window->nextSrc || forceNonContiguous) {
         /* not contiguous */
         size_t const distanceFromBase = (size_t)(window->nextSrc - window->base);
         DEBUGLOG(5, "Non contiguous blocks, new segment starts at %u", window->dictLimit);
@@ -1030,15 +1241,15 @@ MEM_STATIC U32 ZSTD_window_update(ZSTD_window_t* window,
  */
 MEM_STATIC U32 ZSTD_getLowestMatchIndex(const ZSTD_matchState_t* ms, U32 curr, unsigned windowLog)
 {
-    U32    const maxDistance = 1U << windowLog;
-    U32    const lowestValid = ms->window.lowLimit;
-    U32    const withinWindow = (curr - lowestValid > maxDistance) ? curr - maxDistance : lowestValid;
-    U32    const isDictionary = (ms->loadedDictEnd != 0);
+    U32 const maxDistance = 1U << windowLog;
+    U32 const lowestValid = ms->window.lowLimit;
+    U32 const withinWindow = (curr - lowestValid > maxDistance) ? curr - maxDistance : lowestValid;
+    U32 const isDictionary = (ms->loadedDictEnd != 0);
     /* When using a dictionary the entire dictionary is valid if a single byte of the dictionary
      * is within the window. We invalidate the dictionary (and set loadedDictEnd to 0) when it isn't
      * valid for the entire block. So this check is sufficient to find the lowest valid match index.
      */
-    U32    const matchLowest = isDictionary ? lowestValid : withinWindow;
+    U32 const matchLowest = isDictionary ? lowestValid : withinWindow;
     return matchLowest;
 }
 
diff --git a/lib/zstd/compress/zstd_compress_literals.c b/lib/zstd/compress/zstd_compress_literals.c
index 655bcda4d1f1..52b0a8059aba 100644
--- a/lib/zstd/compress/zstd_compress_literals.c
+++ b/lib/zstd/compress/zstd_compress_literals.c
@@ -73,7 +73,8 @@ size_t ZSTD_compressLiterals (ZSTD_hufCTables_t const* prevHuf,
                               void* dst, size_t dstCapacity,
                         const void* src, size_t srcSize,
                               void* entropyWorkspace, size_t entropyWorkspaceSize,
-                        const int bmi2)
+                        const int bmi2,
+                        unsigned suspectUncompressible)
 {
     size_t const minGain = ZSTD_minGain(srcSize, strategy);
     size_t const lhSize = 3 + (srcSize >= 1 KB) + (srcSize >= 16 KB);
@@ -105,11 +106,11 @@ size_t ZSTD_compressLiterals (ZSTD_hufCTables_t const* prevHuf,
             HUF_compress1X_repeat(
                 ostart+lhSize, dstCapacity-lhSize, src, srcSize,
                 HUF_SYMBOLVALUE_MAX, HUF_TABLELOG_DEFAULT, entropyWorkspace, entropyWorkspaceSize,
-                (HUF_CElt*)nextHuf->CTable, &repeat, preferRepeat, bmi2) :
+                (HUF_CElt*)nextHuf->CTable, &repeat, preferRepeat, bmi2, suspectUncompressible) :
             HUF_compress4X_repeat(
                 ostart+lhSize, dstCapacity-lhSize, src, srcSize,
                 HUF_SYMBOLVALUE_MAX, HUF_TABLELOG_DEFAULT, entropyWorkspace, entropyWorkspaceSize,
-                (HUF_CElt*)nextHuf->CTable, &repeat, preferRepeat, bmi2);
+                (HUF_CElt*)nextHuf->CTable, &repeat, preferRepeat, bmi2, suspectUncompressible);
         if (repeat != HUF_repeat_none) {
             /* reused the existing table */
             DEBUGLOG(5, "Reusing previous huffman table");
@@ -117,7 +118,7 @@ size_t ZSTD_compressLiterals (ZSTD_hufCTables_t const* prevHuf,
         }
     }
 
-    if ((cLitSize==0) | (cLitSize >= srcSize - minGain) | ERR_isError(cLitSize)) {
+    if ((cLitSize==0) || (cLitSize >= srcSize - minGain) || ERR_isError(cLitSize)) {
         ZSTD_memcpy(nextHuf, prevHuf, sizeof(*prevHuf));
         return ZSTD_noCompressLiterals(dst, dstCapacity, src, srcSize);
     }
diff --git a/lib/zstd/compress/zstd_compress_literals.h b/lib/zstd/compress/zstd_compress_literals.h
index 9904c0cd30a0..9775fb97cb70 100644
--- a/lib/zstd/compress/zstd_compress_literals.h
+++ b/lib/zstd/compress/zstd_compress_literals.h
@@ -18,12 +18,14 @@ size_t ZSTD_noCompressLiterals (void* dst, size_t dstCapacity, const void* src,
 
 size_t ZSTD_compressRleLiteralsBlock (void* dst, size_t dstCapacity, const void* src, size_t srcSize);
 
+/* If suspectUncompressible then some sampling checks will be run to potentially skip huffman coding */
 size_t ZSTD_compressLiterals (ZSTD_hufCTables_t const* prevHuf,
                               ZSTD_hufCTables_t* nextHuf,
                               ZSTD_strategy strategy, int disableLiteralCompression,
                               void* dst, size_t dstCapacity,
                         const void* src, size_t srcSize,
                               void* entropyWorkspace, size_t entropyWorkspaceSize,
-                        const int bmi2);
+                        const int bmi2,
+                        unsigned suspectUncompressible);
 
 #endif /* ZSTD_COMPRESS_LITERALS_H */
diff --git a/lib/zstd/compress/zstd_compress_sequences.c b/lib/zstd/compress/zstd_compress_sequences.c
index dcfcdc9cc5e8..21ddc1b37acf 100644
--- a/lib/zstd/compress/zstd_compress_sequences.c
+++ b/lib/zstd/compress/zstd_compress_sequences.c
@@ -85,6 +85,8 @@ static size_t ZSTD_entropyCost(unsigned const* count, unsigned const max, size_t
 {
     unsigned cost = 0;
     unsigned s;
+
+    assert(total > 0);
     for (s = 0; s <= max; ++s) {
         unsigned norm = (unsigned)((256 * count[s]) / total);
         if (count[s] != 0 && norm == 0)
@@ -273,10 +275,11 @@ ZSTD_buildCTable(void* dst, size_t dstCapacity,
         assert(nbSeq_1 > 1);
         assert(entropyWorkspaceSize >= sizeof(ZSTD_BuildCTableWksp));
         (void)entropyWorkspaceSize;
-        FORWARD_IF_ERROR(FSE_normalizeCount(wksp->norm, tableLog, count, nbSeq_1, max, ZSTD_useLowProbCount(nbSeq_1)), "");
-        {   size_t const NCountSize = FSE_writeNCount(op, oend - op, wksp->norm, max, tableLog);   /* overflow protected */
+        FORWARD_IF_ERROR(FSE_normalizeCount(wksp->norm, tableLog, count, nbSeq_1, max, ZSTD_useLowProbCount(nbSeq_1)), "FSE_normalizeCount failed");
+        assert(oend >= op);
+        {   size_t const NCountSize = FSE_writeNCount(op, (size_t)(oend - op), wksp->norm, max, tableLog);   /* overflow protected */
             FORWARD_IF_ERROR(NCountSize, "FSE_writeNCount failed");
-            FORWARD_IF_ERROR(FSE_buildCTable_wksp(nextCTable, wksp->norm, max, tableLog, wksp->wksp, sizeof(wksp->wksp)), "");
+            FORWARD_IF_ERROR(FSE_buildCTable_wksp(nextCTable, wksp->norm, max, tableLog, wksp->wksp, sizeof(wksp->wksp)), "FSE_buildCTable_wksp failed");
             return NCountSize;
         }
     }
@@ -310,19 +313,19 @@ ZSTD_encodeSequences_body(
     FSE_initCState2(&stateLitLength,   CTable_LitLength,   llCodeTable[nbSeq-1]);
     BIT_addBits(&blockStream, sequences[nbSeq-1].litLength, LL_bits[llCodeTable[nbSeq-1]]);
     if (MEM_32bits()) BIT_flushBits(&blockStream);
-    BIT_addBits(&blockStream, sequences[nbSeq-1].matchLength, ML_bits[mlCodeTable[nbSeq-1]]);
+    BIT_addBits(&blockStream, sequences[nbSeq-1].mlBase, ML_bits[mlCodeTable[nbSeq-1]]);
     if (MEM_32bits()) BIT_flushBits(&blockStream);
     if (longOffsets) {
         U32 const ofBits = ofCodeTable[nbSeq-1];
         unsigned const extraBits = ofBits - MIN(ofBits, STREAM_ACCUMULATOR_MIN-1);
         if (extraBits) {
-            BIT_addBits(&blockStream, sequences[nbSeq-1].offset, extraBits);
+            BIT_addBits(&blockStream, sequences[nbSeq-1].offBase, extraBits);
             BIT_flushBits(&blockStream);
         }
-        BIT_addBits(&blockStream, sequences[nbSeq-1].offset >> extraBits,
+        BIT_addBits(&blockStream, sequences[nbSeq-1].offBase >> extraBits,
                     ofBits - extraBits);
     } else {
-        BIT_addBits(&blockStream, sequences[nbSeq-1].offset, ofCodeTable[nbSeq-1]);
+        BIT_addBits(&blockStream, sequences[nbSeq-1].offBase, ofCodeTable[nbSeq-1]);
     }
     BIT_flushBits(&blockStream);
 
@@ -336,8 +339,8 @@ ZSTD_encodeSequences_body(
             U32  const mlBits = ML_bits[mlCode];
             DEBUGLOG(6, "encoding: litlen:%2u - matchlen:%2u - offCode:%7u",
                         (unsigned)sequences[n].litLength,
-                        (unsigned)sequences[n].matchLength + MINMATCH,
-                        (unsigned)sequences[n].offset);
+                        (unsigned)sequences[n].mlBase + MINMATCH,
+                        (unsigned)sequences[n].offBase);
                                                                             /* 32b*/  /* 64b*/
                                                                             /* (7)*/  /* (7)*/
             FSE_encodeSymbol(&blockStream, &stateOffsetBits, ofCode);       /* 15 */  /* 15 */
@@ -348,18 +351,18 @@ ZSTD_encodeSequences_body(
                 BIT_flushBits(&blockStream);                                /* (7)*/
             BIT_addBits(&blockStream, sequences[n].litLength, llBits);
             if (MEM_32bits() && ((llBits+mlBits)>24)) BIT_flushBits(&blockStream);
-            BIT_addBits(&blockStream, sequences[n].matchLength, mlBits);
+            BIT_addBits(&blockStream, sequences[n].mlBase, mlBits);
             if (MEM_32bits() || (ofBits+mlBits+llBits > 56)) BIT_flushBits(&blockStream);
             if (longOffsets) {
                 unsigned const extraBits = ofBits - MIN(ofBits, STREAM_ACCUMULATOR_MIN-1);
                 if (extraBits) {
-                    BIT_addBits(&blockStream, sequences[n].offset, extraBits);
+                    BIT_addBits(&blockStream, sequences[n].offBase, extraBits);
                     BIT_flushBits(&blockStream);                            /* (7)*/
                 }
-                BIT_addBits(&blockStream, sequences[n].offset >> extraBits,
+                BIT_addBits(&blockStream, sequences[n].offBase >> extraBits,
                             ofBits - extraBits);                            /* 31 */
             } else {
-                BIT_addBits(&blockStream, sequences[n].offset, ofBits);     /* 31 */
+                BIT_addBits(&blockStream, sequences[n].offBase, ofBits);     /* 31 */
             }
             BIT_flushBits(&blockStream);                                    /* (7)*/
             DEBUGLOG(7, "remaining space : %i", (int)(blockStream.endPtr - blockStream.ptr));
@@ -396,7 +399,7 @@ ZSTD_encodeSequences_default(
 
 #if DYNAMIC_BMI2
 
-static TARGET_ATTRIBUTE("bmi2") size_t
+static BMI2_TARGET_ATTRIBUTE size_t
 ZSTD_encodeSequences_bmi2(
             void* dst, size_t dstCapacity,
             FSE_CTable const* CTable_MatchLength, BYTE const* mlCodeTable,
diff --git a/lib/zstd/compress/zstd_compress_superblock.c b/lib/zstd/compress/zstd_compress_superblock.c
index b0610b255653..17d836cc84e8 100644
--- a/lib/zstd/compress/zstd_compress_superblock.c
+++ b/lib/zstd/compress/zstd_compress_superblock.c
@@ -15,289 +15,10 @@
 
 #include "../common/zstd_internal.h"  /* ZSTD_getSequenceLength */
 #include "hist.h"                     /* HIST_countFast_wksp */
-#include "zstd_compress_internal.h"
+#include "zstd_compress_internal.h"   /* ZSTD_[huf|fse|entropy]CTablesMetadata_t */
 #include "zstd_compress_sequences.h"
 #include "zstd_compress_literals.h"
 
-/*-*************************************
-*  Superblock entropy buffer structs
-***************************************/
-/* ZSTD_hufCTablesMetadata_t :
- *  Stores Literals Block Type for a super-block in hType, and
- *  huffman tree description in hufDesBuffer.
- *  hufDesSize refers to the size of huffman tree description in bytes.
- *  This metadata is populated in ZSTD_buildSuperBlockEntropy_literal() */
-typedef struct {
-    symbolEncodingType_e hType;
-    BYTE hufDesBuffer[ZSTD_MAX_HUF_HEADER_SIZE];
-    size_t hufDesSize;
-} ZSTD_hufCTablesMetadata_t;
-
-/* ZSTD_fseCTablesMetadata_t :
- *  Stores symbol compression modes for a super-block in {ll, ol, ml}Type, and
- *  fse tables in fseTablesBuffer.
- *  fseTablesSize refers to the size of fse tables in bytes.
- *  This metadata is populated in ZSTD_buildSuperBlockEntropy_sequences() */
-typedef struct {
-    symbolEncodingType_e llType;
-    symbolEncodingType_e ofType;
-    symbolEncodingType_e mlType;
-    BYTE fseTablesBuffer[ZSTD_MAX_FSE_HEADERS_SIZE];
-    size_t fseTablesSize;
-    size_t lastCountSize; /* This is to account for bug in 1.3.4. More detail in ZSTD_compressSubBlock_sequences() */
-} ZSTD_fseCTablesMetadata_t;
-
-typedef struct {
-    ZSTD_hufCTablesMetadata_t hufMetadata;
-    ZSTD_fseCTablesMetadata_t fseMetadata;
-} ZSTD_entropyCTablesMetadata_t;
-
-
-/* ZSTD_buildSuperBlockEntropy_literal() :
- *  Builds entropy for the super-block literals.
- *  Stores literals block type (raw, rle, compressed, repeat) and
- *  huffman description table to hufMetadata.
- *  @return : size of huffman description table or error code */
-static size_t ZSTD_buildSuperBlockEntropy_literal(void* const src, size_t srcSize,
-                                            const ZSTD_hufCTables_t* prevHuf,
-                                                  ZSTD_hufCTables_t* nextHuf,
-                                                  ZSTD_hufCTablesMetadata_t* hufMetadata,
-                                                  const int disableLiteralsCompression,
-                                                  void* workspace, size_t wkspSize)
-{
-    BYTE* const wkspStart = (BYTE*)workspace;
-    BYTE* const wkspEnd = wkspStart + wkspSize;
-    BYTE* const countWkspStart = wkspStart;
-    unsigned* const countWksp = (unsigned*)workspace;
-    const size_t countWkspSize = (HUF_SYMBOLVALUE_MAX + 1) * sizeof(unsigned);
-    BYTE* const nodeWksp = countWkspStart + countWkspSize;
-    const size_t nodeWkspSize = wkspEnd-nodeWksp;
-    unsigned maxSymbolValue = 255;
-    unsigned huffLog = HUF_TABLELOG_DEFAULT;
-    HUF_repeat repeat = prevHuf->repeatMode;
-
-    DEBUGLOG(5, "ZSTD_buildSuperBlockEntropy_literal (srcSize=%zu)", srcSize);
-
-    /* Prepare nextEntropy assuming reusing the existing table */
-    ZSTD_memcpy(nextHuf, prevHuf, sizeof(*prevHuf));
-
-    if (disableLiteralsCompression) {
-        DEBUGLOG(5, "set_basic - disabled");
-        hufMetadata->hType = set_basic;
-        return 0;
-    }
-
-    /* small ? don't even attempt compression (speed opt) */
-#   define COMPRESS_LITERALS_SIZE_MIN 63
-    {   size_t const minLitSize = (prevHuf->repeatMode == HUF_repeat_valid) ? 6 : COMPRESS_LITERALS_SIZE_MIN;
-        if (srcSize <= minLitSize) {
-            DEBUGLOG(5, "set_basic - too small");
-            hufMetadata->hType = set_basic;
-            return 0;
-        }
-    }
-
-    /* Scan input and build symbol stats */
-    {   size_t const largest = HIST_count_wksp (countWksp, &maxSymbolValue, (const BYTE*)src, srcSize, workspace, wkspSize);
-        FORWARD_IF_ERROR(largest, "HIST_count_wksp failed");
-        if (largest == srcSize) {
-            DEBUGLOG(5, "set_rle");
-            hufMetadata->hType = set_rle;
-            return 0;
-        }
-        if (largest <= (srcSize >> 7)+4) {
-            DEBUGLOG(5, "set_basic - no gain");
-            hufMetadata->hType = set_basic;
-            return 0;
-        }
-    }
-
-    /* Validate the previous Huffman table */
-    if (repeat == HUF_repeat_check && !HUF_validateCTable((HUF_CElt const*)prevHuf->CTable, countWksp, maxSymbolValue)) {
-        repeat = HUF_repeat_none;
-    }
-
-    /* Build Huffman Tree */
-    ZSTD_memset(nextHuf->CTable, 0, sizeof(nextHuf->CTable));
-    huffLog = HUF_optimalTableLog(huffLog, srcSize, maxSymbolValue);
-    {   size_t const maxBits = HUF_buildCTable_wksp((HUF_CElt*)nextHuf->CTable, countWksp,
-                                                    maxSymbolValue, huffLog,
-                                                    nodeWksp, nodeWkspSize);
-        FORWARD_IF_ERROR(maxBits, "HUF_buildCTable_wksp");
-        huffLog = (U32)maxBits;
-        {   /* Build and write the CTable */
-            size_t const newCSize = HUF_estimateCompressedSize(
-                    (HUF_CElt*)nextHuf->CTable, countWksp, maxSymbolValue);
-            size_t const hSize = HUF_writeCTable_wksp(
-                    hufMetadata->hufDesBuffer, sizeof(hufMetadata->hufDesBuffer),
-                    (HUF_CElt*)nextHuf->CTable, maxSymbolValue, huffLog,
-                    nodeWksp, nodeWkspSize);
-            /* Check against repeating the previous CTable */
-            if (repeat != HUF_repeat_none) {
-                size_t const oldCSize = HUF_estimateCompressedSize(
-                        (HUF_CElt const*)prevHuf->CTable, countWksp, maxSymbolValue);
-                if (oldCSize < srcSize && (oldCSize <= hSize + newCSize || hSize + 12 >= srcSize)) {
-                    DEBUGLOG(5, "set_repeat - smaller");
-                    ZSTD_memcpy(nextHuf, prevHuf, sizeof(*prevHuf));
-                    hufMetadata->hType = set_repeat;
-                    return 0;
-                }
-            }
-            if (newCSize + hSize >= srcSize) {
-                DEBUGLOG(5, "set_basic - no gains");
-                ZSTD_memcpy(nextHuf, prevHuf, sizeof(*prevHuf));
-                hufMetadata->hType = set_basic;
-                return 0;
-            }
-            DEBUGLOG(5, "set_compressed (hSize=%u)", (U32)hSize);
-            hufMetadata->hType = set_compressed;
-            nextHuf->repeatMode = HUF_repeat_check;
-            return hSize;
-        }
-    }
-}
-
-/* ZSTD_buildSuperBlockEntropy_sequences() :
- *  Builds entropy for the super-block sequences.
- *  Stores symbol compression modes and fse table to fseMetadata.
- *  @return : size of fse tables or error code */
-static size_t ZSTD_buildSuperBlockEntropy_sequences(seqStore_t* seqStorePtr,
-                                              const ZSTD_fseCTables_t* prevEntropy,
-                                                    ZSTD_fseCTables_t* nextEntropy,
-                                              const ZSTD_CCtx_params* cctxParams,
-                                                    ZSTD_fseCTablesMetadata_t* fseMetadata,
-                                                    void* workspace, size_t wkspSize)
-{
-    BYTE* const wkspStart = (BYTE*)workspace;
-    BYTE* const wkspEnd = wkspStart + wkspSize;
-    BYTE* const countWkspStart = wkspStart;
-    unsigned* const countWksp = (unsigned*)workspace;
-    const size_t countWkspSize = (MaxSeq + 1) * sizeof(unsigned);
-    BYTE* const cTableWksp = countWkspStart + countWkspSize;
-    const size_t cTableWkspSize = wkspEnd-cTableWksp;
-    ZSTD_strategy const strategy = cctxParams->cParams.strategy;
-    FSE_CTable* CTable_LitLength = nextEntropy->litlengthCTable;
-    FSE_CTable* CTable_OffsetBits = nextEntropy->offcodeCTable;
-    FSE_CTable* CTable_MatchLength = nextEntropy->matchlengthCTable;
-    const BYTE* const ofCodeTable = seqStorePtr->ofCode;
-    const BYTE* const llCodeTable = seqStorePtr->llCode;
-    const BYTE* const mlCodeTable = seqStorePtr->mlCode;
-    size_t const nbSeq = seqStorePtr->sequences - seqStorePtr->sequencesStart;
-    BYTE* const ostart = fseMetadata->fseTablesBuffer;
-    BYTE* const oend = ostart + sizeof(fseMetadata->fseTablesBuffer);
-    BYTE* op = ostart;
-
-    assert(cTableWkspSize >= (1 << MaxFSELog) * sizeof(FSE_FUNCTION_TYPE));
-    DEBUGLOG(5, "ZSTD_buildSuperBlockEntropy_sequences (nbSeq=%zu)", nbSeq);
-    ZSTD_memset(workspace, 0, wkspSize);
-
-    fseMetadata->lastCountSize = 0;
-    /* convert length/distances into codes */
-    ZSTD_seqToCodes(seqStorePtr);
-    /* build CTable for Literal Lengths */
-    {   U32 LLtype;
-        unsigned max = MaxLL;
-        size_t const mostFrequent = HIST_countFast_wksp(countWksp, &max, llCodeTable, nbSeq, workspace, wkspSize);  /* can't fail */
-        DEBUGLOG(5, "Building LL table");
-        nextEntropy->litlength_repeatMode = prevEntropy->litlength_repeatMode;
-        LLtype = ZSTD_selectEncodingType(&nextEntropy->litlength_repeatMode,
-                                        countWksp, max, mostFrequent, nbSeq,
-                                        LLFSELog, prevEntropy->litlengthCTable,
-                                        LL_defaultNorm, LL_defaultNormLog,
-                                        ZSTD_defaultAllowed, strategy);
-        assert(set_basic < set_compressed && set_rle < set_compressed);
-        assert(!(LLtype < set_compressed && nextEntropy->litlength_repeatMode != FSE_repeat_none)); /* We don't copy tables */
-        {   size_t const countSize = ZSTD_buildCTable(op, oend - op, CTable_LitLength, LLFSELog, (symbolEncodingType_e)LLtype,
-                                                    countWksp, max, llCodeTable, nbSeq, LL_defaultNorm, LL_defaultNormLog, MaxLL,
-                                                    prevEntropy->litlengthCTable, sizeof(prevEntropy->litlengthCTable),
-                                                    cTableWksp, cTableWkspSize);
-            FORWARD_IF_ERROR(countSize, "ZSTD_buildCTable for LitLens failed");
-            if (LLtype == set_compressed)
-                fseMetadata->lastCountSize = countSize;
-            op += countSize;
-            fseMetadata->llType = (symbolEncodingType_e) LLtype;
-    }   }
-    /* build CTable for Offsets */
-    {   U32 Offtype;
-        unsigned max = MaxOff;
-        size_t const mostFrequent = HIST_countFast_wksp(countWksp, &max, ofCodeTable, nbSeq, workspace, wkspSize);  /* can't fail */
-        /* We can only use the basic table if max <= DefaultMaxOff, otherwise the offsets are too large */
-        ZSTD_defaultPolicy_e const defaultPolicy = (max <= DefaultMaxOff) ? ZSTD_defaultAllowed : ZSTD_defaultDisallowed;
-        DEBUGLOG(5, "Building OF table");
-        nextEntropy->offcode_repeatMode = prevEntropy->offcode_repeatMode;
-        Offtype = ZSTD_selectEncodingType(&nextEntropy->offcode_repeatMode,
-                                        countWksp, max, mostFrequent, nbSeq,
-                                        OffFSELog, prevEntropy->offcodeCTable,
-                                        OF_defaultNorm, OF_defaultNormLog,
-                                        defaultPolicy, strategy);
-        assert(!(Offtype < set_compressed && nextEntropy->offcode_repeatMode != FSE_repeat_none)); /* We don't copy tables */
-        {   size_t const countSize = ZSTD_buildCTable(op, oend - op, CTable_OffsetBits, OffFSELog, (symbolEncodingType_e)Offtype,
-                                                    countWksp, max, ofCodeTable, nbSeq, OF_defaultNorm, OF_defaultNormLog, DefaultMaxOff,
-                                                    prevEntropy->offcodeCTable, sizeof(prevEntropy->offcodeCTable),
-                                                    cTableWksp, cTableWkspSize);
-            FORWARD_IF_ERROR(countSize, "ZSTD_buildCTable for Offsets failed");
-            if (Offtype == set_compressed)
-                fseMetadata->lastCountSize = countSize;
-            op += countSize;
-            fseMetadata->ofType = (symbolEncodingType_e) Offtype;
-    }   }
-    /* build CTable for MatchLengths */
-    {   U32 MLtype;
-        unsigned max = MaxML;
-        size_t const mostFrequent = HIST_countFast_wksp(countWksp, &max, mlCodeTable, nbSeq, workspace, wkspSize);   /* can't fail */
-        DEBUGLOG(5, "Building ML table (remaining space : %i)", (int)(oend-op));
-        nextEntropy->matchlength_repeatMode = prevEntropy->matchlength_repeatMode;
-        MLtype = ZSTD_selectEncodingType(&nextEntropy->matchlength_repeatMode,
-                                        countWksp, max, mostFrequent, nbSeq,
-                                        MLFSELog, prevEntropy->matchlengthCTable,
-                                        ML_defaultNorm, ML_defaultNormLog,
-                                        ZSTD_defaultAllowed, strategy);
-        assert(!(MLtype < set_compressed && nextEntropy->matchlength_repeatMode != FSE_repeat_none)); /* We don't copy tables */
-        {   size_t const countSize = ZSTD_buildCTable(op, oend - op, CTable_MatchLength, MLFSELog, (symbolEncodingType_e)MLtype,
-                                                    countWksp, max, mlCodeTable, nbSeq, ML_defaultNorm, ML_defaultNormLog, MaxML,
-                                                    prevEntropy->matchlengthCTable, sizeof(prevEntropy->matchlengthCTable),
-                                                    cTableWksp, cTableWkspSize);
-            FORWARD_IF_ERROR(countSize, "ZSTD_buildCTable for MatchLengths failed");
-            if (MLtype == set_compressed)
-                fseMetadata->lastCountSize = countSize;
-            op += countSize;
-            fseMetadata->mlType = (symbolEncodingType_e) MLtype;
-    }   }
-    assert((size_t) (op-ostart) <= sizeof(fseMetadata->fseTablesBuffer));
-    return op-ostart;
-}
-
-
-/* ZSTD_buildSuperBlockEntropy() :
- *  Builds entropy for the super-block.
- *  @return : 0 on success or error code */
-static size_t
-ZSTD_buildSuperBlockEntropy(seqStore_t* seqStorePtr,
-                      const ZSTD_entropyCTables_t* prevEntropy,
-                            ZSTD_entropyCTables_t* nextEntropy,
-                      const ZSTD_CCtx_params* cctxParams,
-                            ZSTD_entropyCTablesMetadata_t* entropyMetadata,
-                            void* workspace, size_t wkspSize)
-{
-    size_t const litSize = seqStorePtr->lit - seqStorePtr->litStart;
-    DEBUGLOG(5, "ZSTD_buildSuperBlockEntropy");
-    entropyMetadata->hufMetadata.hufDesSize =
-        ZSTD_buildSuperBlockEntropy_literal(seqStorePtr->litStart, litSize,
-                                            &prevEntropy->huf, &nextEntropy->huf,
-                                            &entropyMetadata->hufMetadata,
-                                            ZSTD_disableLiteralsCompression(cctxParams),
-                                            workspace, wkspSize);
-    FORWARD_IF_ERROR(entropyMetadata->hufMetadata.hufDesSize, "ZSTD_buildSuperBlockEntropy_literal failed");
-    entropyMetadata->fseMetadata.fseTablesSize =
-        ZSTD_buildSuperBlockEntropy_sequences(seqStorePtr,
-                                              &prevEntropy->fse, &nextEntropy->fse,
-                                              cctxParams,
-                                              &entropyMetadata->fseMetadata,
-                                              workspace, wkspSize);
-    FORWARD_IF_ERROR(entropyMetadata->fseMetadata.fseTablesSize, "ZSTD_buildSuperBlockEntropy_sequences failed");
-    return 0;
-}
-
 /* ZSTD_compressSubBlock_literal() :
  *  Compresses literals section for a sub-block.
  *  When we have to write the Huffman table we will sometimes choose a header
@@ -411,8 +132,7 @@ static size_t ZSTD_seqDecompressedSize(seqStore_t const* seqStore, const seqDef*
     const seqDef* sp = sstart;
     size_t matchLengthSum = 0;
     size_t litLengthSum = 0;
-    /* Only used by assert(), suppress unused variable warnings in production. */
-    (void)litLengthSum;
+    (void)(litLengthSum); /* suppress unused variable warning on some environments */
     while (send-sp > 0) {
         ZSTD_sequenceLength const seqLen = ZSTD_getSequenceLength(seqStore, sp);
         litLengthSum += seqLen.litLength;
@@ -605,7 +325,7 @@ static size_t ZSTD_estimateSubBlockSize_literal(const BYTE* literals, size_t lit
 static size_t ZSTD_estimateSubBlockSize_symbolType(symbolEncodingType_e type,
                         const BYTE* codeTable, unsigned maxCode,
                         size_t nbSeq, const FSE_CTable* fseCTable,
-                        const U32* additionalBits,
+                        const U8* additionalBits,
                         short const* defaultNorm, U32 defaultNormLog, U32 defaultMax,
                         void* workspace, size_t wkspSize)
 {
@@ -646,8 +366,9 @@ static size_t ZSTD_estimateSubBlockSize_sequences(const BYTE* ofCodeTable,
                                                   void* workspace, size_t wkspSize,
                                                   int writeEntropy)
 {
-    size_t sequencesSectionHeaderSize = 3; /* Use hard coded size of 3 bytes */
+    size_t const sequencesSectionHeaderSize = 3; /* Use hard coded size of 3 bytes */
     size_t cSeqSizeEstimate = 0;
+    if (nbSeq == 0) return sequencesSectionHeaderSize;
     cSeqSizeEstimate += ZSTD_estimateSubBlockSize_symbolType(fseMetadata->ofType, ofCodeTable, MaxOff,
                                          nbSeq, fseTables->offcodeCTable, NULL,
                                          OF_defaultNorm, OF_defaultNormLog, DefaultMaxOff,
@@ -754,7 +475,7 @@ static size_t ZSTD_compressSubBlock_multi(const seqStore_t* seqStorePtr,
         /* I think there is an optimization opportunity here.
          * Calling ZSTD_estimateSubBlockSize for every sequence can be wasteful
          * since it recalculates estimate from scratch.
-         * For example, it would recount literal distribution and symbol codes everytime.
+         * For example, it would recount literal distribution and symbol codes every time.
          */
         cBlockSizeEstimate = ZSTD_estimateSubBlockSize(lp, litSize, ofCodePtr, llCodePtr, mlCodePtr, seqCount,
                                                        &nextCBlock->entropy, entropyMetadata,
@@ -818,7 +539,7 @@ static size_t ZSTD_compressSubBlock_multi(const seqStore_t* seqStorePtr,
             repcodes_t rep;
             ZSTD_memcpy(&rep, prevCBlock->rep, sizeof(rep));
             for (seq = sstart; seq < sp; ++seq) {
-                rep = ZSTD_updateRep(rep.rep, seq->offset - 1, ZSTD_getSequenceLength(seqStorePtr, seq).litLength == 0);
+                ZSTD_updateRep(rep.rep, seq->offBase - 1, ZSTD_getSequenceLength(seqStorePtr, seq).litLength == 0);
             }
             ZSTD_memcpy(nextCBlock->rep, &rep, sizeof(rep));
         }
@@ -833,7 +554,7 @@ size_t ZSTD_compressSuperBlock(ZSTD_CCtx* zc,
                                unsigned lastBlock) {
     ZSTD_entropyCTablesMetadata_t entropyMetadata;
 
-    FORWARD_IF_ERROR(ZSTD_buildSuperBlockEntropy(&zc->seqStore,
+    FORWARD_IF_ERROR(ZSTD_buildBlockEntropyStats(&zc->seqStore,
           &zc->blockState.prevCBlock->entropy,
           &zc->blockState.nextCBlock->entropy,
           &zc->appliedParams,
diff --git a/lib/zstd/compress/zstd_cwksp.h b/lib/zstd/compress/zstd_cwksp.h
index 98e359adf5d4..349fc923c355 100644
--- a/lib/zstd/compress/zstd_cwksp.h
+++ b/lib/zstd/compress/zstd_cwksp.h
@@ -32,6 +32,10 @@
 #define ZSTD_CWKSP_ASAN_REDZONE_SIZE 128
 #endif
 
+
+/* Set our tables and aligneds to align by 64 bytes */
+#define ZSTD_CWKSP_ALIGNMENT_BYTES 64
+
 /*-*************************************
 *  Structures
 ***************************************/
@@ -114,10 +118,11 @@ typedef enum {
  * - Tables: these are any of several different datastructures (hash tables,
  *   chain tables, binary trees) that all respect a common format: they are
  *   uint32_t arrays, all of whose values are between 0 and (nextSrc - base).
- *   Their sizes depend on the cparams.
+ *   Their sizes depend on the cparams. These tables are 64-byte aligned.
  *
  * - Aligned: these buffers are used for various purposes that require 4 byte
- *   alignment, but don't require any initialization before they're used.
+ *   alignment, but don't require any initialization before they're used. These
+ *   buffers are each aligned to 64 bytes.
  *
  * - Buffers: these buffers are used for various purposes that don't require
  *   any alignment or initialization before they're used. This means they can
@@ -130,8 +135,7 @@ typedef enum {
  *
  * 1. Objects
  * 2. Buffers
- * 3. Aligned
- * 4. Tables
+ * 3. Aligned/Tables
  *
  * Attempts to reserve objects of different types out of order will fail.
  */
@@ -184,6 +188,8 @@ MEM_STATIC size_t ZSTD_cwksp_align(size_t size, size_t const align) {
  * Since tables aren't currently redzoned, you don't need to call through this
  * to figure out how much space you need for the matchState tables. Everything
  * else is though.
+ *
+ * Do not use for sizing aligned buffers. Instead, use ZSTD_cwksp_aligned_alloc_size().
  */
 MEM_STATIC size_t ZSTD_cwksp_alloc_size(size_t size) {
     if (size == 0)
@@ -191,66 +197,139 @@ MEM_STATIC size_t ZSTD_cwksp_alloc_size(size_t size) {
     return size;
 }
 
-MEM_STATIC void ZSTD_cwksp_internal_advance_phase(
-        ZSTD_cwksp* ws, ZSTD_cwksp_alloc_phase_e phase) {
+/*
+ * Returns an adjusted alloc size that is the nearest larger multiple of 64 bytes.
+ * Used to determine the number of bytes required for a given "aligned".
+ */
+MEM_STATIC size_t ZSTD_cwksp_aligned_alloc_size(size_t size) {
+    return ZSTD_cwksp_alloc_size(ZSTD_cwksp_align(size, ZSTD_CWKSP_ALIGNMENT_BYTES));
+}
+
+/*
+ * Returns the amount of additional space the cwksp must allocate
+ * for internal purposes (currently only alignment).
+ */
+MEM_STATIC size_t ZSTD_cwksp_slack_space_required(void) {
+    /* For alignment, the wksp will always allocate an additional n_1=[1, 64] bytes
+     * to align the beginning of tables section, as well as another n_2=[0, 63] bytes
+     * to align the beginning of the aligned section.
+     *
+     * n_1 + n_2 == 64 bytes if the cwksp is freshly allocated, due to tables and
+     * aligneds being sized in multiples of 64 bytes.
+     */
+    size_t const slackSpace = ZSTD_CWKSP_ALIGNMENT_BYTES;
+    return slackSpace;
+}
+
+
+/*
+ * Return the number of additional bytes required to align a pointer to the given number of bytes.
+ * alignBytes must be a power of two.
+ */
+MEM_STATIC size_t ZSTD_cwksp_bytes_to_align_ptr(void* ptr, const size_t alignBytes) {
+    size_t const alignBytesMask = alignBytes - 1;
+    size_t const bytes = (alignBytes - ((size_t)ptr & (alignBytesMask))) & alignBytesMask;
+    assert((alignBytes & alignBytesMask) == 0);
+    assert(bytes != ZSTD_CWKSP_ALIGNMENT_BYTES);
+    return bytes;
+}
+
+/*
+ * Internal function. Do not use directly.
+ * Reserves the given number of bytes within the aligned/buffer segment of the wksp,
+ * which counts from the end of the wksp (as opposed to the object/table segment).
+ *
+ * Returns a pointer to the beginning of that space.
+ */
+MEM_STATIC void*
+ZSTD_cwksp_reserve_internal_buffer_space(ZSTD_cwksp* ws, size_t const bytes)
+{
+    void* const alloc = (BYTE*)ws->allocStart - bytes;
+    void* const bottom = ws->tableEnd;
+    DEBUGLOG(5, "cwksp: reserving %p %zd bytes, %zd bytes remaining",
+        alloc, bytes, ZSTD_cwksp_available_space(ws) - bytes);
+    ZSTD_cwksp_assert_internal_consistency(ws);
+    assert(alloc >= bottom);
+    if (alloc < bottom) {
+        DEBUGLOG(4, "cwksp: alloc failed!");
+        ws->allocFailed = 1;
+        return NULL;
+    }
+    /* the area is reserved from the end of wksp.
+     * If it overlaps with tableValidEnd, it voids guarantees on values' range */
+    if (alloc < ws->tableValidEnd) {
+        ws->tableValidEnd = alloc;
+    }
+    ws->allocStart = alloc;
+    return alloc;
+}
+
+/*
+ * Moves the cwksp to the next phase, and does any necessary allocations.
+ * cwksp initialization must necessarily go through each phase in order.
+ * Returns a 0 on success, or zstd error
+ */
+MEM_STATIC size_t
+ZSTD_cwksp_internal_advance_phase(ZSTD_cwksp* ws, ZSTD_cwksp_alloc_phase_e phase)
+{
     assert(phase >= ws->phase);
     if (phase > ws->phase) {
+        /* Going from allocating objects to allocating buffers */
         if (ws->phase < ZSTD_cwksp_alloc_buffers &&
                 phase >= ZSTD_cwksp_alloc_buffers) {
             ws->tableValidEnd = ws->objectEnd;
         }
+
+        /* Going from allocating buffers to allocating aligneds/tables */
         if (ws->phase < ZSTD_cwksp_alloc_aligned &&
                 phase >= ZSTD_cwksp_alloc_aligned) {
-            /* If unaligned allocations down from a too-large top have left us
-             * unaligned, we need to realign our alloc ptr. Technically, this
-             * can consume space that is unaccounted for in the neededSpace
-             * calculation. However, I believe this can only happen when the
-             * workspace is too large, and specifically when it is too large
-             * by a larger margin than the space that will be consumed. */
-            /* TODO: cleaner, compiler warning friendly way to do this??? */
-            ws->allocStart = (BYTE*)ws->allocStart - ((size_t)ws->allocStart & (sizeof(U32)-1));
-            if (ws->allocStart < ws->tableValidEnd) {
-                ws->tableValidEnd = ws->allocStart;
+            {   /* Align the start of the "aligned" to 64 bytes. Use [1, 64] bytes. */
+                size_t const bytesToAlign =
+                    ZSTD_CWKSP_ALIGNMENT_BYTES - ZSTD_cwksp_bytes_to_align_ptr(ws->allocStart, ZSTD_CWKSP_ALIGNMENT_BYTES);
+                DEBUGLOG(5, "reserving aligned alignment addtl space: %zu", bytesToAlign);
+                ZSTD_STATIC_ASSERT((ZSTD_CWKSP_ALIGNMENT_BYTES & (ZSTD_CWKSP_ALIGNMENT_BYTES - 1)) == 0); /* power of 2 */
+                RETURN_ERROR_IF(!ZSTD_cwksp_reserve_internal_buffer_space(ws, bytesToAlign),
+                                memory_allocation, "aligned phase - alignment initial allocation failed!");
             }
-        }
+            {   /* Align the start of the tables to 64 bytes. Use [0, 63] bytes */
+                void* const alloc = ws->objectEnd;
+                size_t const bytesToAlign = ZSTD_cwksp_bytes_to_align_ptr(alloc, ZSTD_CWKSP_ALIGNMENT_BYTES);
+                void* const objectEnd = (BYTE*)alloc + bytesToAlign;
+                DEBUGLOG(5, "reserving table alignment addtl space: %zu", bytesToAlign);
+                RETURN_ERROR_IF(objectEnd > ws->workspaceEnd, memory_allocation,
+                                "table phase - alignment initial allocation failed!");
+                ws->objectEnd = objectEnd;
+                ws->tableEnd = objectEnd;  /* table area starts being empty */
+                if (ws->tableValidEnd < ws->tableEnd) {
+                    ws->tableValidEnd = ws->tableEnd;
+        }   }   }
         ws->phase = phase;
+        ZSTD_cwksp_assert_internal_consistency(ws);
     }
+    return 0;
 }
 
 /*
  * Returns whether this object/buffer/etc was allocated in this workspace.
  */
-MEM_STATIC int ZSTD_cwksp_owns_buffer(const ZSTD_cwksp* ws, const void* ptr) {
+MEM_STATIC int ZSTD_cwksp_owns_buffer(const ZSTD_cwksp* ws, const void* ptr)
+{
     return (ptr != NULL) && (ws->workspace <= ptr) && (ptr <= ws->workspaceEnd);
 }
 
 /*
  * Internal function. Do not use directly.
  */
-MEM_STATIC void* ZSTD_cwksp_reserve_internal(
-        ZSTD_cwksp* ws, size_t bytes, ZSTD_cwksp_alloc_phase_e phase) {
+MEM_STATIC void*
+ZSTD_cwksp_reserve_internal(ZSTD_cwksp* ws, size_t bytes, ZSTD_cwksp_alloc_phase_e phase)
+{
     void* alloc;
-    void* bottom = ws->tableEnd;
-    ZSTD_cwksp_internal_advance_phase(ws, phase);
-    alloc = (BYTE *)ws->allocStart - bytes;
-
-    if (bytes == 0)
+    if (ZSTD_isError(ZSTD_cwksp_internal_advance_phase(ws, phase)) || bytes == 0) {
         return NULL;
+    }
 
 
-    DEBUGLOG(5, "cwksp: reserving %p %zd bytes, %zd bytes remaining",
-        alloc, bytes, ZSTD_cwksp_available_space(ws) - bytes);
-    ZSTD_cwksp_assert_internal_consistency(ws);
-    assert(alloc >= bottom);
-    if (alloc < bottom) {
-        DEBUGLOG(4, "cwksp: alloc failed!");
-        ws->allocFailed = 1;
-        return NULL;
-    }
-    if (alloc < ws->tableValidEnd) {
-        ws->tableValidEnd = alloc;
-    }
-    ws->allocStart = alloc;
+    alloc = ZSTD_cwksp_reserve_internal_buffer_space(ws, bytes);
 
 
     return alloc;
@@ -259,33 +338,44 @@ MEM_STATIC void* ZSTD_cwksp_reserve_internal(
 /*
  * Reserves and returns unaligned memory.
  */
-MEM_STATIC BYTE* ZSTD_cwksp_reserve_buffer(ZSTD_cwksp* ws, size_t bytes) {
+MEM_STATIC BYTE* ZSTD_cwksp_reserve_buffer(ZSTD_cwksp* ws, size_t bytes)
+{
     return (BYTE*)ZSTD_cwksp_reserve_internal(ws, bytes, ZSTD_cwksp_alloc_buffers);
 }
 
 /*
- * Reserves and returns memory sized on and aligned on sizeof(unsigned).
+ * Reserves and returns memory sized on and aligned on ZSTD_CWKSP_ALIGNMENT_BYTES (64 bytes).
  */
-MEM_STATIC void* ZSTD_cwksp_reserve_aligned(ZSTD_cwksp* ws, size_t bytes) {
-    assert((bytes & (sizeof(U32)-1)) == 0);
-    return ZSTD_cwksp_reserve_internal(ws, ZSTD_cwksp_align(bytes, sizeof(U32)), ZSTD_cwksp_alloc_aligned);
+MEM_STATIC void* ZSTD_cwksp_reserve_aligned(ZSTD_cwksp* ws, size_t bytes)
+{
+    void* ptr = ZSTD_cwksp_reserve_internal(ws, ZSTD_cwksp_align(bytes, ZSTD_CWKSP_ALIGNMENT_BYTES),
+                                            ZSTD_cwksp_alloc_aligned);
+    assert(((size_t)ptr & (ZSTD_CWKSP_ALIGNMENT_BYTES-1))== 0);
+    return ptr;
 }
 
 /*
- * Aligned on sizeof(unsigned). These buffers have the special property that
+ * Aligned on 64 bytes. These buffers have the special property that
  * their values remain constrained, allowing us to re-use them without
  * memset()-ing them.
  */
-MEM_STATIC void* ZSTD_cwksp_reserve_table(ZSTD_cwksp* ws, size_t bytes) {
+MEM_STATIC void* ZSTD_cwksp_reserve_table(ZSTD_cwksp* ws, size_t bytes)
+{
     const ZSTD_cwksp_alloc_phase_e phase = ZSTD_cwksp_alloc_aligned;
-    void* alloc = ws->tableEnd;
-    void* end = (BYTE *)alloc + bytes;
-    void* top = ws->allocStart;
+    void* alloc;
+    void* end;
+    void* top;
+
+    if (ZSTD_isError(ZSTD_cwksp_internal_advance_phase(ws, phase))) {
+        return NULL;
+    }
+    alloc = ws->tableEnd;
+    end = (BYTE *)alloc + bytes;
+    top = ws->allocStart;
 
     DEBUGLOG(5, "cwksp: reserving %p table %zd bytes, %zd bytes remaining",
         alloc, bytes, ZSTD_cwksp_available_space(ws) - bytes);
     assert((bytes & (sizeof(U32)-1)) == 0);
-    ZSTD_cwksp_internal_advance_phase(ws, phase);
     ZSTD_cwksp_assert_internal_consistency(ws);
     assert(end <= top);
     if (end > top) {
@@ -296,27 +386,31 @@ MEM_STATIC void* ZSTD_cwksp_reserve_table(ZSTD_cwksp* ws, size_t bytes) {
     ws->tableEnd = end;
 
 
+    assert((bytes & (ZSTD_CWKSP_ALIGNMENT_BYTES-1)) == 0);
+    assert(((size_t)alloc & (ZSTD_CWKSP_ALIGNMENT_BYTES-1))== 0);
     return alloc;
 }
 
 /*
  * Aligned on sizeof(void*).
+ * Note : should happen only once, at workspace first initialization
  */
-MEM_STATIC void* ZSTD_cwksp_reserve_object(ZSTD_cwksp* ws, size_t bytes) {
-    size_t roundedBytes = ZSTD_cwksp_align(bytes, sizeof(void*));
+MEM_STATIC void* ZSTD_cwksp_reserve_object(ZSTD_cwksp* ws, size_t bytes)
+{
+    size_t const roundedBytes = ZSTD_cwksp_align(bytes, sizeof(void*));
     void* alloc = ws->objectEnd;
     void* end = (BYTE*)alloc + roundedBytes;
 
 
-    DEBUGLOG(5,
+    DEBUGLOG(4,
         "cwksp: reserving %p object %zd bytes (rounded to %zd), %zd bytes remaining",
         alloc, bytes, roundedBytes, ZSTD_cwksp_available_space(ws) - roundedBytes);
-    assert(((size_t)alloc & (sizeof(void*)-1)) == 0);
-    assert((bytes & (sizeof(void*)-1)) == 0);
+    assert((size_t)alloc % ZSTD_ALIGNOF(void*) == 0);
+    assert(bytes % ZSTD_ALIGNOF(void*) == 0);
     ZSTD_cwksp_assert_internal_consistency(ws);
     /* we must be in the first phase, no advance is possible */
     if (ws->phase != ZSTD_cwksp_alloc_objects || end > ws->workspaceEnd) {
-        DEBUGLOG(4, "cwksp: object alloc failed!");
+        DEBUGLOG(3, "cwksp: object alloc failed!");
         ws->allocFailed = 1;
         return NULL;
     }
@@ -328,7 +422,8 @@ MEM_STATIC void* ZSTD_cwksp_reserve_object(ZSTD_cwksp* ws, size_t bytes) {
     return alloc;
 }
 
-MEM_STATIC void ZSTD_cwksp_mark_tables_dirty(ZSTD_cwksp* ws) {
+MEM_STATIC void ZSTD_cwksp_mark_tables_dirty(ZSTD_cwksp* ws)
+{
     DEBUGLOG(4, "cwksp: ZSTD_cwksp_mark_tables_dirty");
 
 
@@ -451,6 +546,24 @@ MEM_STATIC int ZSTD_cwksp_reserve_failed(const ZSTD_cwksp* ws) {
 *  Functions Checking Free Space
 ***************************************/
 
+/* ZSTD_alignmentSpaceWithinBounds() :
+ * Returns if the estimated space needed for a wksp is within an acceptable limit of the
+ * actual amount of space used.
+ */
+MEM_STATIC int ZSTD_cwksp_estimated_space_within_bounds(const ZSTD_cwksp* const ws,
+                                                        size_t const estimatedSpace, int resizedWorkspace) {
+    if (resizedWorkspace) {
+        /* Resized/newly allocated wksp should have exact bounds */
+        return ZSTD_cwksp_used(ws) == estimatedSpace;
+    } else {
+        /* Due to alignment, when reusing a workspace, we can actually consume 63 fewer or more bytes
+         * than estimatedSpace. See the comments in zstd_cwksp.h for details.
+         */
+        return (ZSTD_cwksp_used(ws) >= estimatedSpace - 63) && (ZSTD_cwksp_used(ws) <= estimatedSpace + 63);
+    }
+}
+
+
 MEM_STATIC size_t ZSTD_cwksp_available_space(ZSTD_cwksp* ws) {
     return (size_t)((BYTE*)ws->allocStart - (BYTE*)ws->tableEnd);
 }
diff --git a/lib/zstd/compress/zstd_double_fast.c b/lib/zstd/compress/zstd_double_fast.c
index b0424d23ac57..76933dea2624 100644
--- a/lib/zstd/compress/zstd_double_fast.c
+++ b/lib/zstd/compress/zstd_double_fast.c
@@ -48,10 +48,216 @@ void ZSTD_fillDoubleHashTable(ZSTD_matchState_t* ms,
 
 
 FORCE_INLINE_TEMPLATE
-size_t ZSTD_compressBlock_doubleFast_generic(
+size_t ZSTD_compressBlock_doubleFast_noDict_generic(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize, U32 const mls /* template */)
+{
+    ZSTD_compressionParameters const* cParams = &ms->cParams;
+    U32* const hashLong = ms->hashTable;
+    const U32 hBitsL = cParams->hashLog;
+    U32* const hashSmall = ms->chainTable;
+    const U32 hBitsS = cParams->chainLog;
+    const BYTE* const base = ms->window.base;
+    const BYTE* const istart = (const BYTE*)src;
+    const BYTE* anchor = istart;
+    const U32 endIndex = (U32)((size_t)(istart - base) + srcSize);
+    /* presumes that, if there is a dictionary, it must be using Attach mode */
+    const U32 prefixLowestIndex = ZSTD_getLowestPrefixIndex(ms, endIndex, cParams->windowLog);
+    const BYTE* const prefixLowest = base + prefixLowestIndex;
+    const BYTE* const iend = istart + srcSize;
+    const BYTE* const ilimit = iend - HASH_READ_SIZE;
+    U32 offset_1=rep[0], offset_2=rep[1];
+    U32 offsetSaved = 0;
+
+    size_t mLength;
+    U32 offset;
+    U32 curr;
+
+    /* how many positions to search before increasing step size */
+    const size_t kStepIncr = 1 << kSearchStrength;
+    /* the position at which to increment the step size if no match is found */
+    const BYTE* nextStep;
+    size_t step; /* the current step size */
+
+    size_t hl0; /* the long hash at ip */
+    size_t hl1; /* the long hash at ip1 */
+
+    U32 idxl0; /* the long match index for ip */
+    U32 idxl1; /* the long match index for ip1 */
+
+    const BYTE* matchl0; /* the long match for ip */
+    const BYTE* matchs0; /* the short match for ip */
+    const BYTE* matchl1; /* the long match for ip1 */
+
+    const BYTE* ip = istart; /* the current position */
+    const BYTE* ip1; /* the next position */
+
+    DEBUGLOG(5, "ZSTD_compressBlock_doubleFast_noDict_generic");
+
+    /* init */
+    ip += ((ip - prefixLowest) == 0);
+    {
+        U32 const current = (U32)(ip - base);
+        U32 const windowLow = ZSTD_getLowestPrefixIndex(ms, current, cParams->windowLog);
+        U32 const maxRep = current - windowLow;
+        if (offset_2 > maxRep) offsetSaved = offset_2, offset_2 = 0;
+        if (offset_1 > maxRep) offsetSaved = offset_1, offset_1 = 0;
+    }
+
+    /* Outer Loop: one iteration per match found and stored */
+    while (1) {
+        step = 1;
+        nextStep = ip + kStepIncr;
+        ip1 = ip + step;
+
+        if (ip1 > ilimit) {
+            goto _cleanup;
+        }
+
+        hl0 = ZSTD_hashPtr(ip, hBitsL, 8);
+        idxl0 = hashLong[hl0];
+        matchl0 = base + idxl0;
+
+        /* Inner Loop: one iteration per search / position */
+        do {
+            const size_t hs0 = ZSTD_hashPtr(ip, hBitsS, mls);
+            const U32 idxs0 = hashSmall[hs0];
+            curr = (U32)(ip-base);
+            matchs0 = base + idxs0;
+
+            hashLong[hl0] = hashSmall[hs0] = curr;   /* update hash tables */
+
+            /* check noDict repcode */
+            if ((offset_1 > 0) & (MEM_read32(ip+1-offset_1) == MEM_read32(ip+1))) {
+                mLength = ZSTD_count(ip+1+4, ip+1+4-offset_1, iend) + 4;
+                ip++;
+                ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_REPCODE_1, mLength);
+                goto _match_stored;
+            }
+
+            hl1 = ZSTD_hashPtr(ip1, hBitsL, 8);
+
+            if (idxl0 > prefixLowestIndex) {
+                /* check prefix long match */
+                if (MEM_read64(matchl0) == MEM_read64(ip)) {
+                    mLength = ZSTD_count(ip+8, matchl0+8, iend) + 8;
+                    offset = (U32)(ip-matchl0);
+                    while (((ip>anchor) & (matchl0>prefixLowest)) && (ip[-1] == matchl0[-1])) { ip--; matchl0--; mLength++; } /* catch up */
+                    goto _match_found;
+                }
+            }
+
+            idxl1 = hashLong[hl1];
+            matchl1 = base + idxl1;
+
+            if (idxs0 > prefixLowestIndex) {
+                /* check prefix short match */
+                if (MEM_read32(matchs0) == MEM_read32(ip)) {
+                    goto _search_next_long;
+                }
+            }
+
+            if (ip1 >= nextStep) {
+                PREFETCH_L1(ip1 + 64);
+                PREFETCH_L1(ip1 + 128);
+                step++;
+                nextStep += kStepIncr;
+            }
+            ip = ip1;
+            ip1 += step;
+
+            hl0 = hl1;
+            idxl0 = idxl1;
+            matchl0 = matchl1;
+    #if defined(__aarch64__)
+            PREFETCH_L1(ip+256);
+    #endif
+        } while (ip1 <= ilimit);
+
+_cleanup:
+        /* save reps for next block */
+        rep[0] = offset_1 ? offset_1 : offsetSaved;
+        rep[1] = offset_2 ? offset_2 : offsetSaved;
+
+        /* Return the last literals size */
+        return (size_t)(iend - anchor);
+
+_search_next_long:
+
+        /* check prefix long +1 match */
+        if (idxl1 > prefixLowestIndex) {
+            if (MEM_read64(matchl1) == MEM_read64(ip1)) {
+                ip = ip1;
+                mLength = ZSTD_count(ip+8, matchl1+8, iend) + 8;
+                offset = (U32)(ip-matchl1);
+                while (((ip>anchor) & (matchl1>prefixLowest)) && (ip[-1] == matchl1[-1])) { ip--; matchl1--; mLength++; } /* catch up */
+                goto _match_found;
+            }
+        }
+
+        /* if no long +1 match, explore the short match we found */
+        mLength = ZSTD_count(ip+4, matchs0+4, iend) + 4;
+        offset = (U32)(ip - matchs0);
+        while (((ip>anchor) & (matchs0>prefixLowest)) && (ip[-1] == matchs0[-1])) { ip--; matchs0--; mLength++; } /* catch up */
+
+        /* fall-through */
+
+_match_found: /* requires ip, offset, mLength */
+        offset_2 = offset_1;
+        offset_1 = offset;
+
+        if (step < 4) {
+            /* It is unsafe to write this value back to the hashtable when ip1 is
+             * greater than or equal to the new ip we will have after we're done
+             * processing this match. Rather than perform that test directly
+             * (ip1 >= ip + mLength), which costs speed in practice, we do a simpler
+             * more predictable test. The minmatch even if we take a short match is
+             * 4 bytes, so as long as step, the distance between ip and ip1
+             * (initially) is less than 4, we know ip1 < new ip. */
+            hashLong[hl1] = (U32)(ip1 - base);
+        }
+
+        ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_OFFSET(offset), mLength);
+
+_match_stored:
+        /* match found */
+        ip += mLength;
+        anchor = ip;
+
+        if (ip <= ilimit) {
+            /* Complementary insertion */
+            /* done after iLimit test, as candidates could be > iend-8 */
+            {   U32 const indexToInsert = curr+2;
+                hashLong[ZSTD_hashPtr(base+indexToInsert, hBitsL, 8)] = indexToInsert;
+                hashLong[ZSTD_hashPtr(ip-2, hBitsL, 8)] = (U32)(ip-2-base);
+                hashSmall[ZSTD_hashPtr(base+indexToInsert, hBitsS, mls)] = indexToInsert;
+                hashSmall[ZSTD_hashPtr(ip-1, hBitsS, mls)] = (U32)(ip-1-base);
+            }
+
+            /* check immediate repcode */
+            while ( (ip <= ilimit)
+                 && ( (offset_2>0)
+                    & (MEM_read32(ip) == MEM_read32(ip - offset_2)) )) {
+                /* store sequence */
+                size_t const rLength = ZSTD_count(ip+4, ip+4-offset_2, iend) + 4;
+                U32 const tmpOff = offset_2; offset_2 = offset_1; offset_1 = tmpOff;  /* swap offset_2 <=> offset_1 */
+                hashSmall[ZSTD_hashPtr(ip, hBitsS, mls)] = (U32)(ip-base);
+                hashLong[ZSTD_hashPtr(ip, hBitsL, 8)] = (U32)(ip-base);
+                ZSTD_storeSeq(seqStore, 0, anchor, iend, STORE_REPCODE_1, rLength);
+                ip += rLength;
+                anchor = ip;
+                continue;   /* faster when present ... (?) */
+            }
+        }
+    }
+}
+
+
+FORCE_INLINE_TEMPLATE
+size_t ZSTD_compressBlock_doubleFast_dictMatchState_generic(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         void const* src, size_t srcSize,
-        U32 const mls /* template */, ZSTD_dictMode_e const dictMode)
+        U32 const mls /* template */)
 {
     ZSTD_compressionParameters const* cParams = &ms->cParams;
     U32* const hashLong = ms->hashTable;
@@ -72,54 +278,30 @@ size_t ZSTD_compressBlock_doubleFast_generic(
     U32 offsetSaved = 0;
 
     const ZSTD_matchState_t* const dms = ms->dictMatchState;
-    const ZSTD_compressionParameters* const dictCParams =
-                                     dictMode == ZSTD_dictMatchState ?
-                                     &dms->cParams : NULL;
-    const U32* const dictHashLong  = dictMode == ZSTD_dictMatchState ?
-                                     dms->hashTable : NULL;
-    const U32* const dictHashSmall = dictMode == ZSTD_dictMatchState ?
-                                     dms->chainTable : NULL;
-    const U32 dictStartIndex       = dictMode == ZSTD_dictMatchState ?
-                                     dms->window.dictLimit : 0;
-    const BYTE* const dictBase     = dictMode == ZSTD_dictMatchState ?
-                                     dms->window.base : NULL;
-    const BYTE* const dictStart    = dictMode == ZSTD_dictMatchState ?
-                                     dictBase + dictStartIndex : NULL;
-    const BYTE* const dictEnd      = dictMode == ZSTD_dictMatchState ?
-                                     dms->window.nextSrc : NULL;
-    const U32 dictIndexDelta       = dictMode == ZSTD_dictMatchState ?
-                                     prefixLowestIndex - (U32)(dictEnd - dictBase) :
-                                     0;
-    const U32 dictHBitsL           = dictMode == ZSTD_dictMatchState ?
-                                     dictCParams->hashLog : hBitsL;
-    const U32 dictHBitsS           = dictMode == ZSTD_dictMatchState ?
-                                     dictCParams->chainLog : hBitsS;
+    const ZSTD_compressionParameters* const dictCParams = &dms->cParams;
+    const U32* const dictHashLong  = dms->hashTable;
+    const U32* const dictHashSmall = dms->chainTable;
+    const U32 dictStartIndex       = dms->window.dictLimit;
+    const BYTE* const dictBase     = dms->window.base;
+    const BYTE* const dictStart    = dictBase + dictStartIndex;
+    const BYTE* const dictEnd      = dms->window.nextSrc;
+    const U32 dictIndexDelta       = prefixLowestIndex - (U32)(dictEnd - dictBase);
+    const U32 dictHBitsL           = dictCParams->hashLog;
+    const U32 dictHBitsS           = dictCParams->chainLog;
     const U32 dictAndPrefixLength  = (U32)((ip - prefixLowest) + (dictEnd - dictStart));
 
-    DEBUGLOG(5, "ZSTD_compressBlock_doubleFast_generic");
-
-    assert(dictMode == ZSTD_noDict || dictMode == ZSTD_dictMatchState);
+    DEBUGLOG(5, "ZSTD_compressBlock_doubleFast_dictMatchState_generic");
 
     /* if a dictionary is attached, it must be within window range */
-    if (dictMode == ZSTD_dictMatchState) {
-        assert(ms->window.dictLimit + (1U << cParams->windowLog) >= endIndex);
-    }
+    assert(ms->window.dictLimit + (1U << cParams->windowLog) >= endIndex);
 
     /* init */
     ip += (dictAndPrefixLength == 0);
-    if (dictMode == ZSTD_noDict) {
-        U32 const curr = (U32)(ip - base);
-        U32 const windowLow = ZSTD_getLowestPrefixIndex(ms, curr, cParams->windowLog);
-        U32 const maxRep = curr - windowLow;
-        if (offset_2 > maxRep) offsetSaved = offset_2, offset_2 = 0;
-        if (offset_1 > maxRep) offsetSaved = offset_1, offset_1 = 0;
-    }
-    if (dictMode == ZSTD_dictMatchState) {
-        /* dictMatchState repCode checks don't currently handle repCode == 0
-         * disabling. */
-        assert(offset_1 <= dictAndPrefixLength);
-        assert(offset_2 <= dictAndPrefixLength);
-    }
+
+    /* dictMatchState repCode checks don't currently handle repCode == 0
+     * disabling. */
+    assert(offset_1 <= dictAndPrefixLength);
+    assert(offset_2 <= dictAndPrefixLength);
 
     /* Main Search Loop */
     while (ip < ilimit) {   /* < instead of <=, because repcode check at (ip+1) */
@@ -135,29 +317,18 @@ size_t ZSTD_compressBlock_doubleFast_generic(
         const BYTE* matchLong = base + matchIndexL;
         const BYTE* match = base + matchIndexS;
         const U32 repIndex = curr + 1 - offset_1;
-        const BYTE* repMatch = (dictMode == ZSTD_dictMatchState
-                            && repIndex < prefixLowestIndex) ?
+        const BYTE* repMatch = (repIndex < prefixLowestIndex) ?
                                dictBase + (repIndex - dictIndexDelta) :
                                base + repIndex;
         hashLong[h2] = hashSmall[h] = curr;   /* update hash tables */
 
-        /* check dictMatchState repcode */
-        if (dictMode == ZSTD_dictMatchState
-            && ((U32)((prefixLowestIndex-1) - repIndex) >= 3 /* intentional underflow */)
+        /* check repcode */
+        if (((U32)((prefixLowestIndex-1) - repIndex) >= 3 /* intentional underflow */)
             && (MEM_read32(repMatch) == MEM_read32(ip+1)) ) {
             const BYTE* repMatchEnd = repIndex < prefixLowestIndex ? dictEnd : iend;
             mLength = ZSTD_count_2segments(ip+1+4, repMatch+4, iend, repMatchEnd, prefixLowest) + 4;
             ip++;
-            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, 0, mLength-MINMATCH);
-            goto _match_stored;
-        }
-
-        /* check noDict repcode */
-        if ( dictMode == ZSTD_noDict
-          && ((offset_1 > 0) & (MEM_read32(ip+1-offset_1) == MEM_read32(ip+1)))) {
-            mLength = ZSTD_count(ip+1+4, ip+1+4-offset_1, iend) + 4;
-            ip++;
-            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, 0, mLength-MINMATCH);
+            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_REPCODE_1, mLength);
             goto _match_stored;
         }
 
@@ -169,7 +340,7 @@ size_t ZSTD_compressBlock_doubleFast_generic(
                 while (((ip>anchor) & (matchLong>prefixLowest)) && (ip[-1] == matchLong[-1])) { ip--; matchLong--; mLength++; } /* catch up */
                 goto _match_found;
             }
-        } else if (dictMode == ZSTD_dictMatchState) {
+        } else {
             /* check dictMatchState long match */
             U32 const dictMatchIndexL = dictHashLong[dictHL];
             const BYTE* dictMatchL = dictBase + dictMatchIndexL;
@@ -187,7 +358,7 @@ size_t ZSTD_compressBlock_doubleFast_generic(
             if (MEM_read32(match) == MEM_read32(ip)) {
                 goto _search_next_long;
             }
-        } else if (dictMode == ZSTD_dictMatchState) {
+        } else {
             /* check dictMatchState short match */
             U32 const dictMatchIndexS = dictHashSmall[dictHS];
             match = dictBase + dictMatchIndexS;
@@ -220,7 +391,7 @@ size_t ZSTD_compressBlock_doubleFast_generic(
                     while (((ip>anchor) & (matchL3>prefixLowest)) && (ip[-1] == matchL3[-1])) { ip--; matchL3--; mLength++; } /* catch up */
                     goto _match_found;
                 }
-            } else if (dictMode == ZSTD_dictMatchState) {
+            } else {
                 /* check dict long +1 match */
                 U32 const dictMatchIndexL3 = dictHashLong[dictHLNext];
                 const BYTE* dictMatchL3 = dictBase + dictMatchIndexL3;
@@ -234,7 +405,7 @@ size_t ZSTD_compressBlock_doubleFast_generic(
         }   }   }
 
         /* if no long +1 match, explore the short match we found */
-        if (dictMode == ZSTD_dictMatchState && matchIndexS < prefixLowestIndex) {
+        if (matchIndexS < prefixLowestIndex) {
             mLength = ZSTD_count_2segments(ip+4, match+4, iend, dictEnd, prefixLowest) + 4;
             offset = (U32)(curr - matchIndexS);
             while (((ip>anchor) & (match>dictStart)) && (ip[-1] == match[-1])) { ip--; match--; mLength++; } /* catch up */
@@ -248,7 +419,7 @@ size_t ZSTD_compressBlock_doubleFast_generic(
         offset_2 = offset_1;
         offset_1 = offset;
 
-        ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, offset + ZSTD_REP_MOVE, mLength-MINMATCH);
+        ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_OFFSET(offset), mLength);
 
 _match_stored:
         /* match found */
@@ -266,43 +437,27 @@ size_t ZSTD_compressBlock_doubleFast_generic(
             }
 
             /* check immediate repcode */
-            if (dictMode == ZSTD_dictMatchState) {
-                while (ip <= ilimit) {
-                    U32 const current2 = (U32)(ip-base);
-                    U32 const repIndex2 = current2 - offset_2;
-                    const BYTE* repMatch2 = dictMode == ZSTD_dictMatchState
-                        && repIndex2 < prefixLowestIndex ?
-                            dictBase + repIndex2 - dictIndexDelta :
-                            base + repIndex2;
-                    if ( ((U32)((prefixLowestIndex-1) - (U32)repIndex2) >= 3 /* intentional overflow */)
-                       && (MEM_read32(repMatch2) == MEM_read32(ip)) ) {
-                        const BYTE* const repEnd2 = repIndex2 < prefixLowestIndex ? dictEnd : iend;
-                        size_t const repLength2 = ZSTD_count_2segments(ip+4, repMatch2+4, iend, repEnd2, prefixLowest) + 4;
-                        U32 tmpOffset = offset_2; offset_2 = offset_1; offset_1 = tmpOffset;   /* swap offset_2 <=> offset_1 */
-                        ZSTD_storeSeq(seqStore, 0, anchor, iend, 0, repLength2-MINMATCH);
-                        hashSmall[ZSTD_hashPtr(ip, hBitsS, mls)] = current2;
-                        hashLong[ZSTD_hashPtr(ip, hBitsL, 8)] = current2;
-                        ip += repLength2;
-                        anchor = ip;
-                        continue;
-                    }
-                    break;
-            }   }
-
-            if (dictMode == ZSTD_noDict) {
-                while ( (ip <= ilimit)
-                     && ( (offset_2>0)
-                        & (MEM_read32(ip) == MEM_read32(ip - offset_2)) )) {
-                    /* store sequence */
-                    size_t const rLength = ZSTD_count(ip+4, ip+4-offset_2, iend) + 4;
-                    U32 const tmpOff = offset_2; offset_2 = offset_1; offset_1 = tmpOff;  /* swap offset_2 <=> offset_1 */
-                    hashSmall[ZSTD_hashPtr(ip, hBitsS, mls)] = (U32)(ip-base);
-                    hashLong[ZSTD_hashPtr(ip, hBitsL, 8)] = (U32)(ip-base);
-                    ZSTD_storeSeq(seqStore, 0, anchor, iend, 0, rLength-MINMATCH);
-                    ip += rLength;
+            while (ip <= ilimit) {
+                U32 const current2 = (U32)(ip-base);
+                U32 const repIndex2 = current2 - offset_2;
+                const BYTE* repMatch2 = repIndex2 < prefixLowestIndex ?
+                        dictBase + repIndex2 - dictIndexDelta :
+                        base + repIndex2;
+                if ( ((U32)((prefixLowestIndex-1) - (U32)repIndex2) >= 3 /* intentional overflow */)
+                   && (MEM_read32(repMatch2) == MEM_read32(ip)) ) {
+                    const BYTE* const repEnd2 = repIndex2 < prefixLowestIndex ? dictEnd : iend;
+                    size_t const repLength2 = ZSTD_count_2segments(ip+4, repMatch2+4, iend, repEnd2, prefixLowest) + 4;
+                    U32 tmpOffset = offset_2; offset_2 = offset_1; offset_1 = tmpOffset;   /* swap offset_2 <=> offset_1 */
+                    ZSTD_storeSeq(seqStore, 0, anchor, iend, STORE_REPCODE_1, repLength2);
+                    hashSmall[ZSTD_hashPtr(ip, hBitsS, mls)] = current2;
+                    hashLong[ZSTD_hashPtr(ip, hBitsL, 8)] = current2;
+                    ip += repLength2;
                     anchor = ip;
-                    continue;   /* faster when present ... (?) */
-        }   }   }
+                    continue;
+                }
+                break;
+            }
+        }
     }   /* while (ip < ilimit) */
 
     /* save reps for next block */
@@ -313,6 +468,24 @@ size_t ZSTD_compressBlock_doubleFast_generic(
     return (size_t)(iend - anchor);
 }
 
+#define ZSTD_GEN_DFAST_FN(dictMode, mls)                                                                 \
+    static size_t ZSTD_compressBlock_doubleFast_##dictMode##_##mls(                                      \
+            ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],                          \
+            void const* src, size_t srcSize)                                                             \
+    {                                                                                                    \
+        return ZSTD_compressBlock_doubleFast_##dictMode##_generic(ms, seqStore, rep, src, srcSize, mls); \
+    }
+
+ZSTD_GEN_DFAST_FN(noDict, 4)
+ZSTD_GEN_DFAST_FN(noDict, 5)
+ZSTD_GEN_DFAST_FN(noDict, 6)
+ZSTD_GEN_DFAST_FN(noDict, 7)
+
+ZSTD_GEN_DFAST_FN(dictMatchState, 4)
+ZSTD_GEN_DFAST_FN(dictMatchState, 5)
+ZSTD_GEN_DFAST_FN(dictMatchState, 6)
+ZSTD_GEN_DFAST_FN(dictMatchState, 7)
+
 
 size_t ZSTD_compressBlock_doubleFast(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
@@ -323,13 +496,13 @@ size_t ZSTD_compressBlock_doubleFast(
     {
     default: /* includes case 3 */
     case 4 :
-        return ZSTD_compressBlock_doubleFast_generic(ms, seqStore, rep, src, srcSize, 4, ZSTD_noDict);
+        return ZSTD_compressBlock_doubleFast_noDict_4(ms, seqStore, rep, src, srcSize);
     case 5 :
-        return ZSTD_compressBlock_doubleFast_generic(ms, seqStore, rep, src, srcSize, 5, ZSTD_noDict);
+        return ZSTD_compressBlock_doubleFast_noDict_5(ms, seqStore, rep, src, srcSize);
     case 6 :
-        return ZSTD_compressBlock_doubleFast_generic(ms, seqStore, rep, src, srcSize, 6, ZSTD_noDict);
+        return ZSTD_compressBlock_doubleFast_noDict_6(ms, seqStore, rep, src, srcSize);
     case 7 :
-        return ZSTD_compressBlock_doubleFast_generic(ms, seqStore, rep, src, srcSize, 7, ZSTD_noDict);
+        return ZSTD_compressBlock_doubleFast_noDict_7(ms, seqStore, rep, src, srcSize);
     }
 }
 
@@ -343,13 +516,13 @@ size_t ZSTD_compressBlock_doubleFast_dictMatchState(
     {
     default: /* includes case 3 */
     case 4 :
-        return ZSTD_compressBlock_doubleFast_generic(ms, seqStore, rep, src, srcSize, 4, ZSTD_dictMatchState);
+        return ZSTD_compressBlock_doubleFast_dictMatchState_4(ms, seqStore, rep, src, srcSize);
     case 5 :
-        return ZSTD_compressBlock_doubleFast_generic(ms, seqStore, rep, src, srcSize, 5, ZSTD_dictMatchState);
+        return ZSTD_compressBlock_doubleFast_dictMatchState_5(ms, seqStore, rep, src, srcSize);
     case 6 :
-        return ZSTD_compressBlock_doubleFast_generic(ms, seqStore, rep, src, srcSize, 6, ZSTD_dictMatchState);
+        return ZSTD_compressBlock_doubleFast_dictMatchState_6(ms, seqStore, rep, src, srcSize);
     case 7 :
-        return ZSTD_compressBlock_doubleFast_generic(ms, seqStore, rep, src, srcSize, 7, ZSTD_dictMatchState);
+        return ZSTD_compressBlock_doubleFast_dictMatchState_7(ms, seqStore, rep, src, srcSize);
     }
 }
 
@@ -385,7 +558,7 @@ static size_t ZSTD_compressBlock_doubleFast_extDict_generic(
 
     /* if extDict is invalidated due to maxDistance, switch to "regular" variant */
     if (prefixStartIndex == dictStartIndex)
-        return ZSTD_compressBlock_doubleFast_generic(ms, seqStore, rep, src, srcSize, mls, ZSTD_noDict);
+        return ZSTD_compressBlock_doubleFast(ms, seqStore, rep, src, srcSize);
 
     /* Search Loop */
     while (ip < ilimit) {  /* < instead of <=, because (ip+1) */
@@ -407,12 +580,12 @@ static size_t ZSTD_compressBlock_doubleFast_extDict_generic(
         hashSmall[hSmall] = hashLong[hLong] = curr;   /* update hash table */
 
         if ((((U32)((prefixStartIndex-1) - repIndex) >= 3) /* intentional underflow : ensure repIndex doesn't overlap dict + prefix */
-            & (repIndex > dictStartIndex))
+            & (offset_1 <= curr+1 - dictStartIndex)) /* note: we are searching at curr+1 */
           && (MEM_read32(repMatch) == MEM_read32(ip+1)) ) {
             const BYTE* repMatchEnd = repIndex < prefixStartIndex ? dictEnd : iend;
             mLength = ZSTD_count_2segments(ip+1+4, repMatch+4, iend, repMatchEnd, prefixStart) + 4;
             ip++;
-            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, 0, mLength-MINMATCH);
+            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_REPCODE_1, mLength);
         } else {
             if ((matchLongIndex > dictStartIndex) && (MEM_read64(matchLong) == MEM_read64(ip))) {
                 const BYTE* const matchEnd = matchLongIndex < prefixStartIndex ? dictEnd : iend;
@@ -423,7 +596,7 @@ static size_t ZSTD_compressBlock_doubleFast_extDict_generic(
                 while (((ip>anchor) & (matchLong>lowMatchPtr)) && (ip[-1] == matchLong[-1])) { ip--; matchLong--; mLength++; }   /* catch up */
                 offset_2 = offset_1;
                 offset_1 = offset;
-                ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, offset + ZSTD_REP_MOVE, mLength-MINMATCH);
+                ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_OFFSET(offset), mLength);
 
             } else if ((matchIndex > dictStartIndex) && (MEM_read32(match) == MEM_read32(ip))) {
                 size_t const h3 = ZSTD_hashPtr(ip+1, hBitsL, 8);
@@ -448,7 +621,7 @@ static size_t ZSTD_compressBlock_doubleFast_extDict_generic(
                 }
                 offset_2 = offset_1;
                 offset_1 = offset;
-                ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, offset + ZSTD_REP_MOVE, mLength-MINMATCH);
+                ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_OFFSET(offset), mLength);
 
             } else {
                 ip += ((ip-anchor) >> kSearchStrength) + 1;
@@ -475,12 +648,12 @@ static size_t ZSTD_compressBlock_doubleFast_extDict_generic(
                 U32 const repIndex2 = current2 - offset_2;
                 const BYTE* repMatch2 = repIndex2 < prefixStartIndex ? dictBase + repIndex2 : base + repIndex2;
                 if ( (((U32)((prefixStartIndex-1) - repIndex2) >= 3)   /* intentional overflow : ensure repIndex2 doesn't overlap dict + prefix */
-                    & (repIndex2 > dictStartIndex))
+                    & (offset_2 <= current2 - dictStartIndex))
                   && (MEM_read32(repMatch2) == MEM_read32(ip)) ) {
                     const BYTE* const repEnd2 = repIndex2 < prefixStartIndex ? dictEnd : iend;
                     size_t const repLength2 = ZSTD_count_2segments(ip+4, repMatch2+4, iend, repEnd2, prefixStart) + 4;
                     U32 const tmpOffset = offset_2; offset_2 = offset_1; offset_1 = tmpOffset;   /* swap offset_2 <=> offset_1 */
-                    ZSTD_storeSeq(seqStore, 0, anchor, iend, 0, repLength2-MINMATCH);
+                    ZSTD_storeSeq(seqStore, 0, anchor, iend, STORE_REPCODE_1, repLength2);
                     hashSmall[ZSTD_hashPtr(ip, hBitsS, mls)] = current2;
                     hashLong[ZSTD_hashPtr(ip, hBitsL, 8)] = current2;
                     ip += repLength2;
@@ -498,6 +671,10 @@ static size_t ZSTD_compressBlock_doubleFast_extDict_generic(
     return (size_t)(iend - anchor);
 }
 
+ZSTD_GEN_DFAST_FN(extDict, 4)
+ZSTD_GEN_DFAST_FN(extDict, 5)
+ZSTD_GEN_DFAST_FN(extDict, 6)
+ZSTD_GEN_DFAST_FN(extDict, 7)
 
 size_t ZSTD_compressBlock_doubleFast_extDict(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
@@ -508,12 +685,12 @@ size_t ZSTD_compressBlock_doubleFast_extDict(
     {
     default: /* includes case 3 */
     case 4 :
-        return ZSTD_compressBlock_doubleFast_extDict_generic(ms, seqStore, rep, src, srcSize, 4);
+        return ZSTD_compressBlock_doubleFast_extDict_4(ms, seqStore, rep, src, srcSize);
     case 5 :
-        return ZSTD_compressBlock_doubleFast_extDict_generic(ms, seqStore, rep, src, srcSize, 5);
+        return ZSTD_compressBlock_doubleFast_extDict_5(ms, seqStore, rep, src, srcSize);
     case 6 :
-        return ZSTD_compressBlock_doubleFast_extDict_generic(ms, seqStore, rep, src, srcSize, 6);
+        return ZSTD_compressBlock_doubleFast_extDict_6(ms, seqStore, rep, src, srcSize);
     case 7 :
-        return ZSTD_compressBlock_doubleFast_extDict_generic(ms, seqStore, rep, src, srcSize, 7);
+        return ZSTD_compressBlock_doubleFast_extDict_7(ms, seqStore, rep, src, srcSize);
     }
 }
diff --git a/lib/zstd/compress/zstd_fast.c b/lib/zstd/compress/zstd_fast.c
index 96b7d48e2868..a752e6beab52 100644
--- a/lib/zstd/compress/zstd_fast.c
+++ b/lib/zstd/compress/zstd_fast.c
@@ -43,145 +43,294 @@ void ZSTD_fillHashTable(ZSTD_matchState_t* ms,
 }
 
 
+/*
+ * If you squint hard enough (and ignore repcodes), the search operation at any
+ * given position is broken into 4 stages:
+ *
+ * 1. Hash   (map position to hash value via input read)
+ * 2. Lookup (map hash val to index via hashtable read)
+ * 3. Load   (map index to value at that position via input read)
+ * 4. Compare
+ *
+ * Each of these steps involves a memory read at an address which is computed
+ * from the previous step. This means these steps must be sequenced and their
+ * latencies are cumulative.
+ *
+ * Rather than do 1->2->3->4 sequentially for a single position before moving
+ * onto the next, this implementation interleaves these operations across the
+ * next few positions:
+ *
+ * R = Repcode Read & Compare
+ * H = Hash
+ * T = Table Lookup
+ * M = Match Read & Compare
+ *
+ * Pos | Time -->
+ * ----+-------------------
+ * N   | ... M
+ * N+1 | ...   TM
+ * N+2 |    R H   T M
+ * N+3 |         H    TM
+ * N+4 |           R H   T M
+ * N+5 |                H   ...
+ * N+6 |                  R ...
+ *
+ * This is very much analogous to the pipelining of execution in a CPU. And just
+ * like a CPU, we have to dump the pipeline when we find a match (i.e., take a
+ * branch).
+ *
+ * When this happens, we throw away our current state, and do the following prep
+ * to re-enter the loop:
+ *
+ * Pos | Time -->
+ * ----+-------------------
+ * N   | H T
+ * N+1 |  H
+ *
+ * This is also the work we do at the beginning to enter the loop initially.
+ */
 FORCE_INLINE_TEMPLATE size_t
-ZSTD_compressBlock_fast_generic(
+ZSTD_compressBlock_fast_noDict_generic(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         void const* src, size_t srcSize,
-        U32 const mls)
+        U32 const mls, U32 const hasStep)
 {
     const ZSTD_compressionParameters* const cParams = &ms->cParams;
     U32* const hashTable = ms->hashTable;
     U32 const hlog = cParams->hashLog;
     /* support stepSize of 0 */
-    size_t const stepSize = cParams->targetLength + !(cParams->targetLength) + 1;
+    size_t const stepSize = hasStep ? (cParams->targetLength + !(cParams->targetLength) + 1) : 2;
     const BYTE* const base = ms->window.base;
     const BYTE* const istart = (const BYTE*)src;
-    /* We check ip0 (ip + 0) and ip1 (ip + 1) each loop */
-    const BYTE* ip0 = istart;
-    const BYTE* ip1;
-    const BYTE* anchor = istart;
     const U32   endIndex = (U32)((size_t)(istart - base) + srcSize);
     const U32   prefixStartIndex = ZSTD_getLowestPrefixIndex(ms, endIndex, cParams->windowLog);
     const BYTE* const prefixStart = base + prefixStartIndex;
     const BYTE* const iend = istart + srcSize;
     const BYTE* const ilimit = iend - HASH_READ_SIZE;
-    U32 offset_1=rep[0], offset_2=rep[1];
+
+    const BYTE* anchor = istart;
+    const BYTE* ip0 = istart;
+    const BYTE* ip1;
+    const BYTE* ip2;
+    const BYTE* ip3;
+    U32 current0;
+
+    U32 rep_offset1 = rep[0];
+    U32 rep_offset2 = rep[1];
     U32 offsetSaved = 0;
 
-    /* init */
+    size_t hash0; /* hash for ip0 */
+    size_t hash1; /* hash for ip1 */
+    U32 idx; /* match idx for ip0 */
+    U32 mval; /* src value at match idx */
+
+    U32 offcode;
+    const BYTE* match0;
+    size_t mLength;
+
+    /* ip0 and ip1 are always adjacent. The targetLength skipping and
+     * uncompressibility acceleration is applied to every other position,
+     * matching the behavior of #1562. step therefore represents the gap
+     * between pairs of positions, from ip0 to ip2 or ip1 to ip3. */
+    size_t step;
+    const BYTE* nextStep;
+    const size_t kStepIncr = (1 << (kSearchStrength - 1));
+
     DEBUGLOG(5, "ZSTD_compressBlock_fast_generic");
     ip0 += (ip0 == prefixStart);
-    ip1 = ip0 + 1;
     {   U32 const curr = (U32)(ip0 - base);
         U32 const windowLow = ZSTD_getLowestPrefixIndex(ms, curr, cParams->windowLog);
         U32 const maxRep = curr - windowLow;
-        if (offset_2 > maxRep) offsetSaved = offset_2, offset_2 = 0;
-        if (offset_1 > maxRep) offsetSaved = offset_1, offset_1 = 0;
+        if (rep_offset2 > maxRep) offsetSaved = rep_offset2, rep_offset2 = 0;
+        if (rep_offset1 > maxRep) offsetSaved = rep_offset1, rep_offset1 = 0;
     }
 
-    /* Main Search Loop */
-#ifdef __INTEL_COMPILER
-    /* From intel 'The vector pragma indicates that the loop should be
-     * vectorized if it is legal to do so'. Can be used together with
-     * #pragma ivdep (but have opted to exclude that because intel
-     * warns against using it).*/
-    #pragma vector always
-#endif
-    while (ip1 < ilimit) {   /* < instead of <=, because check at ip0+2 */
-        size_t mLength;
-        BYTE const* ip2 = ip0 + 2;
-        size_t const h0 = ZSTD_hashPtr(ip0, hlog, mls);
-        U32 const val0 = MEM_read32(ip0);
-        size_t const h1 = ZSTD_hashPtr(ip1, hlog, mls);
-        U32 const val1 = MEM_read32(ip1);
-        U32 const current0 = (U32)(ip0-base);
-        U32 const current1 = (U32)(ip1-base);
-        U32 const matchIndex0 = hashTable[h0];
-        U32 const matchIndex1 = hashTable[h1];
-        BYTE const* repMatch = ip2 - offset_1;
-        const BYTE* match0 = base + matchIndex0;
-        const BYTE* match1 = base + matchIndex1;
-        U32 offcode;
-
-#if defined(__aarch64__)
-        PREFETCH_L1(ip0+256);
-#endif
-
-        hashTable[h0] = current0;   /* update hash table */
-        hashTable[h1] = current1;   /* update hash table */
-
-        assert(ip0 + 1 == ip1);
-
-        if ((offset_1 > 0) & (MEM_read32(repMatch) == MEM_read32(ip2))) {
-            mLength = (ip2[-1] == repMatch[-1]) ? 1 : 0;
-            ip0 = ip2 - mLength;
-            match0 = repMatch - mLength;
+    /* start each op */
+_start: /* Requires: ip0 */
+
+    step = stepSize;
+    nextStep = ip0 + kStepIncr;
+
+    /* calculate positions, ip0 - anchor == 0, so we skip step calc */
+    ip1 = ip0 + 1;
+    ip2 = ip0 + step;
+    ip3 = ip2 + 1;
+
+    if (ip3 >= ilimit) {
+        goto _cleanup;
+    }
+
+    hash0 = ZSTD_hashPtr(ip0, hlog, mls);
+    hash1 = ZSTD_hashPtr(ip1, hlog, mls);
+
+    idx = hashTable[hash0];
+
+    do {
+        /* load repcode match for ip[2]*/
+        const U32 rval = MEM_read32(ip2 - rep_offset1);
+
+        /* write back hash table entry */
+        current0 = (U32)(ip0 - base);
+        hashTable[hash0] = current0;
+
+        /* check repcode at ip[2] */
+        if ((MEM_read32(ip2) == rval) & (rep_offset1 > 0)) {
+            ip0 = ip2;
+            match0 = ip0 - rep_offset1;
+            mLength = ip0[-1] == match0[-1];
+            ip0 -= mLength;
+            match0 -= mLength;
+            offcode = STORE_REPCODE_1;
             mLength += 4;
-            offcode = 0;
             goto _match;
         }
-        if ((matchIndex0 > prefixStartIndex) && MEM_read32(match0) == val0) {
-            /* found a regular match */
-            goto _offset;
+
+        /* load match for ip[0] */
+        if (idx >= prefixStartIndex) {
+            mval = MEM_read32(base + idx);
+        } else {
+            mval = MEM_read32(ip0) ^ 1; /* guaranteed to not match. */
         }
-        if ((matchIndex1 > prefixStartIndex) && MEM_read32(match1) == val1) {
-            /* found a regular match after one literal */
-            ip0 = ip1;
-            match0 = match1;
+
+        /* check match at ip[0] */
+        if (MEM_read32(ip0) == mval) {
+            /* found a match! */
             goto _offset;
         }
-        {   size_t const step = ((size_t)(ip0-anchor) >> (kSearchStrength - 1)) + stepSize;
-            assert(step >= 2);
-            ip0 += step;
-            ip1 += step;
-            continue;
+
+        /* lookup ip[1] */
+        idx = hashTable[hash1];
+
+        /* hash ip[2] */
+        hash0 = hash1;
+        hash1 = ZSTD_hashPtr(ip2, hlog, mls);
+
+        /* advance to next positions */
+        ip0 = ip1;
+        ip1 = ip2;
+        ip2 = ip3;
+
+        /* write back hash table entry */
+        current0 = (U32)(ip0 - base);
+        hashTable[hash0] = current0;
+
+        /* load match for ip[0] */
+        if (idx >= prefixStartIndex) {
+            mval = MEM_read32(base + idx);
+        } else {
+            mval = MEM_read32(ip0) ^ 1; /* guaranteed to not match. */
         }
-_offset: /* Requires: ip0, match0 */
-        /* Compute the offset code */
-        offset_2 = offset_1;
-        offset_1 = (U32)(ip0-match0);
-        offcode = offset_1 + ZSTD_REP_MOVE;
-        mLength = 4;
-        /* Count the backwards match length */
-        while (((ip0>anchor) & (match0>prefixStart))
-             && (ip0[-1] == match0[-1])) { ip0--; match0--; mLength++; } /* catch up */
 
-_match: /* Requires: ip0, match0, offcode */
-        /* Count the forward length */
-        mLength += ZSTD_count(ip0+mLength, match0+mLength, iend);
-        ZSTD_storeSeq(seqStore, (size_t)(ip0-anchor), anchor, iend, offcode, mLength-MINMATCH);
-        /* match found */
-        ip0 += mLength;
-        anchor = ip0;
+        /* check match at ip[0] */
+        if (MEM_read32(ip0) == mval) {
+            /* found a match! */
+            goto _offset;
+        }
 
-        if (ip0 <= ilimit) {
-            /* Fill Table */
-            assert(base+current0+2 > istart);  /* check base overflow */
-            hashTable[ZSTD_hashPtr(base+current0+2, hlog, mls)] = current0+2;  /* here because current+2 could be > iend-8 */
-            hashTable[ZSTD_hashPtr(ip0-2, hlog, mls)] = (U32)(ip0-2-base);
-
-            if (offset_2 > 0) { /* offset_2==0 means offset_2 is invalidated */
-                while ( (ip0 <= ilimit) && (MEM_read32(ip0) == MEM_read32(ip0 - offset_2)) ) {
-                    /* store sequence */
-                    size_t const rLength = ZSTD_count(ip0+4, ip0+4-offset_2, iend) + 4;
-                    { U32 const tmpOff = offset_2; offset_2 = offset_1; offset_1 = tmpOff; } /* swap offset_2 <=> offset_1 */
-                    hashTable[ZSTD_hashPtr(ip0, hlog, mls)] = (U32)(ip0-base);
-                    ip0 += rLength;
-                    ZSTD_storeSeq(seqStore, 0 /*litLen*/, anchor, iend, 0 /*offCode*/, rLength-MINMATCH);
-                    anchor = ip0;
-                    continue;   /* faster when present (confirmed on gcc-8) ... (?) */
-        }   }   }
-        ip1 = ip0 + 1;
-    }
+        /* lookup ip[1] */
+        idx = hashTable[hash1];
+
+        /* hash ip[2] */
+        hash0 = hash1;
+        hash1 = ZSTD_hashPtr(ip2, hlog, mls);
+
+        /* advance to next positions */
+        ip0 = ip1;
+        ip1 = ip2;
+        ip2 = ip0 + step;
+        ip3 = ip1 + step;
+
+        /* calculate step */
+        if (ip2 >= nextStep) {
+            step++;
+            PREFETCH_L1(ip1 + 64);
+            PREFETCH_L1(ip1 + 128);
+            nextStep += kStepIncr;
+        }
+    } while (ip3 < ilimit);
+
+_cleanup:
+    /* Note that there are probably still a couple positions we could search.
+     * However, it seems to be a meaningful performance hit to try to search
+     * them. So let's not. */
 
     /* save reps for next block */
-    rep[0] = offset_1 ? offset_1 : offsetSaved;
-    rep[1] = offset_2 ? offset_2 : offsetSaved;
+    rep[0] = rep_offset1 ? rep_offset1 : offsetSaved;
+    rep[1] = rep_offset2 ? rep_offset2 : offsetSaved;
 
     /* Return the last literals size */
     return (size_t)(iend - anchor);
+
+_offset: /* Requires: ip0, idx */
+
+    /* Compute the offset code. */
+    match0 = base + idx;
+    rep_offset2 = rep_offset1;
+    rep_offset1 = (U32)(ip0-match0);
+    offcode = STORE_OFFSET(rep_offset1);
+    mLength = 4;
+
+    /* Count the backwards match length. */
+    while (((ip0>anchor) & (match0>prefixStart)) && (ip0[-1] == match0[-1])) {
+        ip0--;
+        match0--;
+        mLength++;
+    }
+
+_match: /* Requires: ip0, match0, offcode */
+
+    /* Count the forward length. */
+    mLength += ZSTD_count(ip0 + mLength, match0 + mLength, iend);
+
+    ZSTD_storeSeq(seqStore, (size_t)(ip0 - anchor), anchor, iend, offcode, mLength);
+
+    ip0 += mLength;
+    anchor = ip0;
+
+    /* write next hash table entry */
+    if (ip1 < ip0) {
+        hashTable[hash1] = (U32)(ip1 - base);
+    }
+
+    /* Fill table and check for immediate repcode. */
+    if (ip0 <= ilimit) {
+        /* Fill Table */
+        assert(base+current0+2 > istart);  /* check base overflow */
+        hashTable[ZSTD_hashPtr(base+current0+2, hlog, mls)] = current0+2;  /* here because current+2 could be > iend-8 */
+        hashTable[ZSTD_hashPtr(ip0-2, hlog, mls)] = (U32)(ip0-2-base);
+
+        if (rep_offset2 > 0) { /* rep_offset2==0 means rep_offset2 is invalidated */
+            while ( (ip0 <= ilimit) && (MEM_read32(ip0) == MEM_read32(ip0 - rep_offset2)) ) {
+                /* store sequence */
+                size_t const rLength = ZSTD_count(ip0+4, ip0+4-rep_offset2, iend) + 4;
+                { U32 const tmpOff = rep_offset2; rep_offset2 = rep_offset1; rep_offset1 = tmpOff; } /* swap rep_offset2 <=> rep_offset1 */
+                hashTable[ZSTD_hashPtr(ip0, hlog, mls)] = (U32)(ip0-base);
+                ip0 += rLength;
+                ZSTD_storeSeq(seqStore, 0 /*litLen*/, anchor, iend, STORE_REPCODE_1, rLength);
+                anchor = ip0;
+                continue;   /* faster when present (confirmed on gcc-8) ... (?) */
+    }   }   }
+
+    goto _start;
 }
 
+#define ZSTD_GEN_FAST_FN(dictMode, mls, step)                                                            \
+    static size_t ZSTD_compressBlock_fast_##dictMode##_##mls##_##step(                                      \
+            ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],                    \
+            void const* src, size_t srcSize)                                                       \
+    {                                                                                              \
+        return ZSTD_compressBlock_fast_##dictMode##_generic(ms, seqStore, rep, src, srcSize, mls, step); \
+    }
+
+ZSTD_GEN_FAST_FN(noDict, 4, 1)
+ZSTD_GEN_FAST_FN(noDict, 5, 1)
+ZSTD_GEN_FAST_FN(noDict, 6, 1)
+ZSTD_GEN_FAST_FN(noDict, 7, 1)
+
+ZSTD_GEN_FAST_FN(noDict, 4, 0)
+ZSTD_GEN_FAST_FN(noDict, 5, 0)
+ZSTD_GEN_FAST_FN(noDict, 6, 0)
+ZSTD_GEN_FAST_FN(noDict, 7, 0)
 
 size_t ZSTD_compressBlock_fast(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
@@ -189,24 +338,40 @@ size_t ZSTD_compressBlock_fast(
 {
     U32 const mls = ms->cParams.minMatch;
     assert(ms->dictMatchState == NULL);
-    switch(mls)
-    {
-    default: /* includes case 3 */
-    case 4 :
-        return ZSTD_compressBlock_fast_generic(ms, seqStore, rep, src, srcSize, 4);
-    case 5 :
-        return ZSTD_compressBlock_fast_generic(ms, seqStore, rep, src, srcSize, 5);
-    case 6 :
-        return ZSTD_compressBlock_fast_generic(ms, seqStore, rep, src, srcSize, 6);
-    case 7 :
-        return ZSTD_compressBlock_fast_generic(ms, seqStore, rep, src, srcSize, 7);
+    if (ms->cParams.targetLength > 1) {
+        switch(mls)
+        {
+        default: /* includes case 3 */
+        case 4 :
+            return ZSTD_compressBlock_fast_noDict_4_1(ms, seqStore, rep, src, srcSize);
+        case 5 :
+            return ZSTD_compressBlock_fast_noDict_5_1(ms, seqStore, rep, src, srcSize);
+        case 6 :
+            return ZSTD_compressBlock_fast_noDict_6_1(ms, seqStore, rep, src, srcSize);
+        case 7 :
+            return ZSTD_compressBlock_fast_noDict_7_1(ms, seqStore, rep, src, srcSize);
+        }
+    } else {
+        switch(mls)
+        {
+        default: /* includes case 3 */
+        case 4 :
+            return ZSTD_compressBlock_fast_noDict_4_0(ms, seqStore, rep, src, srcSize);
+        case 5 :
+            return ZSTD_compressBlock_fast_noDict_5_0(ms, seqStore, rep, src, srcSize);
+        case 6 :
+            return ZSTD_compressBlock_fast_noDict_6_0(ms, seqStore, rep, src, srcSize);
+        case 7 :
+            return ZSTD_compressBlock_fast_noDict_7_0(ms, seqStore, rep, src, srcSize);
+        }
+
     }
 }
 
 FORCE_INLINE_TEMPLATE
 size_t ZSTD_compressBlock_fast_dictMatchState_generic(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
-        void const* src, size_t srcSize, U32 const mls)
+        void const* src, size_t srcSize, U32 const mls, U32 const hasStep)
 {
     const ZSTD_compressionParameters* const cParams = &ms->cParams;
     U32* const hashTable = ms->hashTable;
@@ -242,6 +407,8 @@ size_t ZSTD_compressBlock_fast_dictMatchState_generic(
     assert(endIndex - prefixStartIndex <= maxDistance);
     (void)maxDistance; (void)endIndex;   /* these variables are not used when assert() is disabled */
 
+    (void)hasStep; /* not currently specialized on whether it's accelerated */
+
     /* ensure there will be no underflow
      * when translating a dict index into a local index */
     assert(prefixStartIndex >= (U32)(dictEnd - dictBase));
@@ -272,7 +439,7 @@ size_t ZSTD_compressBlock_fast_dictMatchState_generic(
             const BYTE* const repMatchEnd = repIndex < prefixStartIndex ? dictEnd : iend;
             mLength = ZSTD_count_2segments(ip+1+4, repMatch+4, iend, repMatchEnd, prefixStart) + 4;
             ip++;
-            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, 0, mLength-MINMATCH);
+            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_REPCODE_1, mLength);
         } else if ( (matchIndex <= prefixStartIndex) ) {
             size_t const dictHash = ZSTD_hashPtr(ip, dictHLog, mls);
             U32 const dictMatchIndex = dictHashTable[dictHash];
@@ -292,7 +459,7 @@ size_t ZSTD_compressBlock_fast_dictMatchState_generic(
                 } /* catch up */
                 offset_2 = offset_1;
                 offset_1 = offset;
-                ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, offset + ZSTD_REP_MOVE, mLength-MINMATCH);
+                ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_OFFSET(offset), mLength);
             }
         } else if (MEM_read32(match) != MEM_read32(ip)) {
             /* it's not a match, and we're not going to check the dictionary */
@@ -307,7 +474,7 @@ size_t ZSTD_compressBlock_fast_dictMatchState_generic(
                  && (ip[-1] == match[-1])) { ip--; match--; mLength++; } /* catch up */
             offset_2 = offset_1;
             offset_1 = offset;
-            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, offset + ZSTD_REP_MOVE, mLength-MINMATCH);
+            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_OFFSET(offset), mLength);
         }
 
         /* match found */
@@ -332,7 +499,7 @@ size_t ZSTD_compressBlock_fast_dictMatchState_generic(
                     const BYTE* const repEnd2 = repIndex2 < prefixStartIndex ? dictEnd : iend;
                     size_t const repLength2 = ZSTD_count_2segments(ip+4, repMatch2+4, iend, repEnd2, prefixStart) + 4;
                     U32 tmpOffset = offset_2; offset_2 = offset_1; offset_1 = tmpOffset;   /* swap offset_2 <=> offset_1 */
-                    ZSTD_storeSeq(seqStore, 0, anchor, iend, 0, repLength2-MINMATCH);
+                    ZSTD_storeSeq(seqStore, 0, anchor, iend, STORE_REPCODE_1, repLength2);
                     hashTable[ZSTD_hashPtr(ip, hlog, mls)] = current2;
                     ip += repLength2;
                     anchor = ip;
@@ -351,6 +518,12 @@ size_t ZSTD_compressBlock_fast_dictMatchState_generic(
     return (size_t)(iend - anchor);
 }
 
+
+ZSTD_GEN_FAST_FN(dictMatchState, 4, 0)
+ZSTD_GEN_FAST_FN(dictMatchState, 5, 0)
+ZSTD_GEN_FAST_FN(dictMatchState, 6, 0)
+ZSTD_GEN_FAST_FN(dictMatchState, 7, 0)
+
 size_t ZSTD_compressBlock_fast_dictMatchState(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         void const* src, size_t srcSize)
@@ -361,20 +534,20 @@ size_t ZSTD_compressBlock_fast_dictMatchState(
     {
     default: /* includes case 3 */
     case 4 :
-        return ZSTD_compressBlock_fast_dictMatchState_generic(ms, seqStore, rep, src, srcSize, 4);
+        return ZSTD_compressBlock_fast_dictMatchState_4_0(ms, seqStore, rep, src, srcSize);
     case 5 :
-        return ZSTD_compressBlock_fast_dictMatchState_generic(ms, seqStore, rep, src, srcSize, 5);
+        return ZSTD_compressBlock_fast_dictMatchState_5_0(ms, seqStore, rep, src, srcSize);
     case 6 :
-        return ZSTD_compressBlock_fast_dictMatchState_generic(ms, seqStore, rep, src, srcSize, 6);
+        return ZSTD_compressBlock_fast_dictMatchState_6_0(ms, seqStore, rep, src, srcSize);
     case 7 :
-        return ZSTD_compressBlock_fast_dictMatchState_generic(ms, seqStore, rep, src, srcSize, 7);
+        return ZSTD_compressBlock_fast_dictMatchState_7_0(ms, seqStore, rep, src, srcSize);
     }
 }
 
 
 static size_t ZSTD_compressBlock_fast_extDict_generic(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
-        void const* src, size_t srcSize, U32 const mls)
+        void const* src, size_t srcSize, U32 const mls, U32 const hasStep)
 {
     const ZSTD_compressionParameters* const cParams = &ms->cParams;
     U32* const hashTable = ms->hashTable;
@@ -398,11 +571,13 @@ static size_t ZSTD_compressBlock_fast_extDict_generic(
     const BYTE* const ilimit = iend - 8;
     U32 offset_1=rep[0], offset_2=rep[1];
 
+    (void)hasStep; /* not currently specialized on whether it's accelerated */
+
     DEBUGLOG(5, "ZSTD_compressBlock_fast_extDict_generic (offset_1=%u)", offset_1);
 
     /* switch to "regular" variant if extDict is invalidated due to maxDistance */
     if (prefixStartIndex == dictStartIndex)
-        return ZSTD_compressBlock_fast_generic(ms, seqStore, rep, src, srcSize, mls);
+        return ZSTD_compressBlock_fast(ms, seqStore, rep, src, srcSize);
 
     /* Search Loop */
     while (ip < ilimit) {  /* < instead of <=, because (ip+1) */
@@ -416,14 +591,14 @@ static size_t ZSTD_compressBlock_fast_extDict_generic(
         const BYTE* const repMatch = repBase + repIndex;
         hashTable[h] = curr;   /* update hash table */
         DEBUGLOG(7, "offset_1 = %u , curr = %u", offset_1, curr);
-        assert(offset_1 <= curr +1);   /* check repIndex */
 
-        if ( (((U32)((prefixStartIndex-1) - repIndex) >= 3) /* intentional underflow */ & (repIndex > dictStartIndex))
+        if ( ( ((U32)((prefixStartIndex-1) - repIndex) >= 3) /* intentional underflow */
+             & (offset_1 <= curr+1 - dictStartIndex) ) /* note: we are searching at curr+1 */
            && (MEM_read32(repMatch) == MEM_read32(ip+1)) ) {
             const BYTE* const repMatchEnd = repIndex < prefixStartIndex ? dictEnd : iend;
             size_t const rLength = ZSTD_count_2segments(ip+1 +4, repMatch +4, iend, repMatchEnd, prefixStart) + 4;
             ip++;
-            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, 0, rLength-MINMATCH);
+            ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_REPCODE_1, rLength);
             ip += rLength;
             anchor = ip;
         } else {
@@ -439,7 +614,7 @@ static size_t ZSTD_compressBlock_fast_extDict_generic(
                 size_t mLength = ZSTD_count_2segments(ip+4, match+4, iend, matchEnd, prefixStart) + 4;
                 while (((ip>anchor) & (match>lowMatchPtr)) && (ip[-1] == match[-1])) { ip--; match--; mLength++; }   /* catch up */
                 offset_2 = offset_1; offset_1 = offset;  /* update offset history */
-                ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, offset + ZSTD_REP_MOVE, mLength-MINMATCH);
+                ZSTD_storeSeq(seqStore, (size_t)(ip-anchor), anchor, iend, STORE_OFFSET(offset), mLength);
                 ip += mLength;
                 anchor = ip;
         }   }
@@ -453,12 +628,12 @@ static size_t ZSTD_compressBlock_fast_extDict_generic(
                 U32 const current2 = (U32)(ip-base);
                 U32 const repIndex2 = current2 - offset_2;
                 const BYTE* const repMatch2 = repIndex2 < prefixStartIndex ? dictBase + repIndex2 : base + repIndex2;
-                if ( (((U32)((prefixStartIndex-1) - repIndex2) >= 3) & (repIndex2 > dictStartIndex))  /* intentional overflow */
+                if ( (((U32)((prefixStartIndex-1) - repIndex2) >= 3) & (offset_2 <= curr - dictStartIndex))  /* intentional overflow */
                    && (MEM_read32(repMatch2) == MEM_read32(ip)) ) {
                     const BYTE* const repEnd2 = repIndex2 < prefixStartIndex ? dictEnd : iend;
                     size_t const repLength2 = ZSTD_count_2segments(ip+4, repMatch2+4, iend, repEnd2, prefixStart) + 4;
                     { U32 const tmpOffset = offset_2; offset_2 = offset_1; offset_1 = tmpOffset; }  /* swap offset_2 <=> offset_1 */
-                    ZSTD_storeSeq(seqStore, 0 /*litlen*/, anchor, iend, 0 /*offcode*/, repLength2-MINMATCH);
+                    ZSTD_storeSeq(seqStore, 0 /*litlen*/, anchor, iend, STORE_REPCODE_1, repLength2);
                     hashTable[ZSTD_hashPtr(ip, hlog, mls)] = current2;
                     ip += repLength2;
                     anchor = ip;
@@ -475,6 +650,10 @@ static size_t ZSTD_compressBlock_fast_extDict_generic(
     return (size_t)(iend - anchor);
 }
 
+ZSTD_GEN_FAST_FN(extDict, 4, 0)
+ZSTD_GEN_FAST_FN(extDict, 5, 0)
+ZSTD_GEN_FAST_FN(extDict, 6, 0)
+ZSTD_GEN_FAST_FN(extDict, 7, 0)
 
 size_t ZSTD_compressBlock_fast_extDict(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
@@ -485,12 +664,12 @@ size_t ZSTD_compressBlock_fast_extDict(
     {
     default: /* includes case 3 */
     case 4 :
-        return ZSTD_compressBlock_fast_extDict_generic(ms, seqStore, rep, src, srcSize, 4);
+        return ZSTD_compressBlock_fast_extDict_4_0(ms, seqStore, rep, src, srcSize);
     case 5 :
-        return ZSTD_compressBlock_fast_extDict_generic(ms, seqStore, rep, src, srcSize, 5);
+        return ZSTD_compressBlock_fast_extDict_5_0(ms, seqStore, rep, src, srcSize);
     case 6 :
-        return ZSTD_compressBlock_fast_extDict_generic(ms, seqStore, rep, src, srcSize, 6);
+        return ZSTD_compressBlock_fast_extDict_6_0(ms, seqStore, rep, src, srcSize);
     case 7 :
-        return ZSTD_compressBlock_fast_extDict_generic(ms, seqStore, rep, src, srcSize, 7);
+        return ZSTD_compressBlock_fast_extDict_7_0(ms, seqStore, rep, src, srcSize);
     }
 }
diff --git a/lib/zstd/compress/zstd_lazy.c b/lib/zstd/compress/zstd_lazy.c
index fb54d4e28a2b..0298a01a7504 100644
--- a/lib/zstd/compress/zstd_lazy.c
+++ b/lib/zstd/compress/zstd_lazy.c
@@ -61,7 +61,7 @@ ZSTD_updateDUBT(ZSTD_matchState_t* ms,
  *  assumption : curr >= btlow == (curr - btmask)
  *  doesn't fail */
 static void
-ZSTD_insertDUBT1(ZSTD_matchState_t* ms,
+ZSTD_insertDUBT1(const ZSTD_matchState_t* ms,
                  U32 curr, const BYTE* inputEnd,
                  U32 nbCompares, U32 btLow,
                  const ZSTD_dictMode_e dictMode)
@@ -151,7 +151,7 @@ ZSTD_insertDUBT1(ZSTD_matchState_t* ms,
 
 static size_t
 ZSTD_DUBT_findBetterDictMatch (
-        ZSTD_matchState_t* ms,
+        const ZSTD_matchState_t* ms,
         const BYTE* const ip, const BYTE* const iend,
         size_t* offsetPtr,
         size_t bestLength,
@@ -197,8 +197,8 @@ ZSTD_DUBT_findBetterDictMatch (
             U32 matchIndex = dictMatchIndex + dictIndexDelta;
             if ( (4*(int)(matchLength-bestLength)) > (int)(ZSTD_highbit32(curr-matchIndex+1) - ZSTD_highbit32((U32)offsetPtr[0]+1)) ) {
                 DEBUGLOG(9, "ZSTD_DUBT_findBetterDictMatch(%u) : found better match length %u -> %u and offsetCode %u -> %u (dictMatchIndex %u, matchIndex %u)",
-                    curr, (U32)bestLength, (U32)matchLength, (U32)*offsetPtr, ZSTD_REP_MOVE + curr - matchIndex, dictMatchIndex, matchIndex);
-                bestLength = matchLength, *offsetPtr = ZSTD_REP_MOVE + curr - matchIndex;
+                    curr, (U32)bestLength, (U32)matchLength, (U32)*offsetPtr, STORE_OFFSET(curr - matchIndex), dictMatchIndex, matchIndex);
+                bestLength = matchLength, *offsetPtr = STORE_OFFSET(curr - matchIndex);
             }
             if (ip+matchLength == iend) {   /* reached end of input : ip[matchLength] is not valid, no way to know if it's larger or smaller than match */
                 break;   /* drop, to guarantee consistency (miss a little bit of compression) */
@@ -218,7 +218,7 @@ ZSTD_DUBT_findBetterDictMatch (
     }
 
     if (bestLength >= MINMATCH) {
-        U32 const mIndex = curr - ((U32)*offsetPtr - ZSTD_REP_MOVE); (void)mIndex;
+        U32 const mIndex = curr - (U32)STORED_OFFSET(*offsetPtr); (void)mIndex;
         DEBUGLOG(8, "ZSTD_DUBT_findBetterDictMatch(%u) : found match of length %u and offsetCode %u (pos %u)",
                     curr, (U32)bestLength, (U32)*offsetPtr, mIndex);
     }
@@ -328,7 +328,7 @@ ZSTD_DUBT_findBestMatch(ZSTD_matchState_t* ms,
                 if (matchLength > matchEndIdx - matchIndex)
                     matchEndIdx = matchIndex + (U32)matchLength;
                 if ( (4*(int)(matchLength-bestLength)) > (int)(ZSTD_highbit32(curr-matchIndex+1) - ZSTD_highbit32((U32)offsetPtr[0]+1)) )
-                    bestLength = matchLength, *offsetPtr = ZSTD_REP_MOVE + curr - matchIndex;
+                    bestLength = matchLength, *offsetPtr = STORE_OFFSET(curr - matchIndex);
                 if (ip+matchLength == iend) {   /* equal : no way to know if inf or sup */
                     if (dictMode == ZSTD_dictMatchState) {
                         nbCompares = 0; /* in addition to avoiding checking any
@@ -368,7 +368,7 @@ ZSTD_DUBT_findBestMatch(ZSTD_matchState_t* ms,
         assert(matchEndIdx > curr+8); /* ensure nextToUpdate is increased */
         ms->nextToUpdate = matchEndIdx - 8;   /* skip repetitive patterns */
         if (bestLength >= MINMATCH) {
-            U32 const mIndex = curr - ((U32)*offsetPtr - ZSTD_REP_MOVE); (void)mIndex;
+            U32 const mIndex = curr - (U32)STORED_OFFSET(*offsetPtr); (void)mIndex;
             DEBUGLOG(8, "ZSTD_DUBT_findBestMatch(%u) : found match of length %u and offsetCode %u (pos %u)",
                         curr, (U32)bestLength, (U32)*offsetPtr, mIndex);
         }
@@ -391,91 +391,9 @@ ZSTD_BtFindBestMatch( ZSTD_matchState_t* ms,
     return ZSTD_DUBT_findBestMatch(ms, ip, iLimit, offsetPtr, mls, dictMode);
 }
 
-
-static size_t
-ZSTD_BtFindBestMatch_selectMLS (  ZSTD_matchState_t* ms,
-                            const BYTE* ip, const BYTE* const iLimit,
-                                  size_t* offsetPtr)
-{
-    switch(ms->cParams.minMatch)
-    {
-    default : /* includes case 3 */
-    case 4 : return ZSTD_BtFindBestMatch(ms, ip, iLimit, offsetPtr, 4, ZSTD_noDict);
-    case 5 : return ZSTD_BtFindBestMatch(ms, ip, iLimit, offsetPtr, 5, ZSTD_noDict);
-    case 7 :
-    case 6 : return ZSTD_BtFindBestMatch(ms, ip, iLimit, offsetPtr, 6, ZSTD_noDict);
-    }
-}
-
-
-static size_t ZSTD_BtFindBestMatch_dictMatchState_selectMLS (
-                        ZSTD_matchState_t* ms,
-                        const BYTE* ip, const BYTE* const iLimit,
-                        size_t* offsetPtr)
-{
-    switch(ms->cParams.minMatch)
-    {
-    default : /* includes case 3 */
-    case 4 : return ZSTD_BtFindBestMatch(ms, ip, iLimit, offsetPtr, 4, ZSTD_dictMatchState);
-    case 5 : return ZSTD_BtFindBestMatch(ms, ip, iLimit, offsetPtr, 5, ZSTD_dictMatchState);
-    case 7 :
-    case 6 : return ZSTD_BtFindBestMatch(ms, ip, iLimit, offsetPtr, 6, ZSTD_dictMatchState);
-    }
-}
-
-
-static size_t ZSTD_BtFindBestMatch_extDict_selectMLS (
-                        ZSTD_matchState_t* ms,
-                        const BYTE* ip, const BYTE* const iLimit,
-                        size_t* offsetPtr)
-{
-    switch(ms->cParams.minMatch)
-    {
-    default : /* includes case 3 */
-    case 4 : return ZSTD_BtFindBestMatch(ms, ip, iLimit, offsetPtr, 4, ZSTD_extDict);
-    case 5 : return ZSTD_BtFindBestMatch(ms, ip, iLimit, offsetPtr, 5, ZSTD_extDict);
-    case 7 :
-    case 6 : return ZSTD_BtFindBestMatch(ms, ip, iLimit, offsetPtr, 6, ZSTD_extDict);
-    }
-}
-
-
-
 /* *********************************
-*  Hash Chain
+* Dedicated dict search
 ***********************************/
-#define NEXT_IN_CHAIN(d, mask)   chainTable[(d) & (mask)]
-
-/* Update chains up to ip (excluded)
-   Assumption : always within prefix (i.e. not within extDict) */
-FORCE_INLINE_TEMPLATE U32 ZSTD_insertAndFindFirstIndex_internal(
-                        ZSTD_matchState_t* ms,
-                        const ZSTD_compressionParameters* const cParams,
-                        const BYTE* ip, U32 const mls)
-{
-    U32* const hashTable  = ms->hashTable;
-    const U32 hashLog = cParams->hashLog;
-    U32* const chainTable = ms->chainTable;
-    const U32 chainMask = (1 << cParams->chainLog) - 1;
-    const BYTE* const base = ms->window.base;
-    const U32 target = (U32)(ip - base);
-    U32 idx = ms->nextToUpdate;
-
-    while(idx < target) { /* catch up */
-        size_t const h = ZSTD_hashPtr(base+idx, hashLog, mls);
-        NEXT_IN_CHAIN(idx, chainMask) = hashTable[h];
-        hashTable[h] = idx;
-        idx++;
-    }
-
-    ms->nextToUpdate = target;
-    return hashTable[ZSTD_hashPtr(ip, hashLog, mls)];
-}
-
-U32 ZSTD_insertAndFindFirstIndex(ZSTD_matchState_t* ms, const BYTE* ip) {
-    const ZSTD_compressionParameters* const cParams = &ms->cParams;
-    return ZSTD_insertAndFindFirstIndex_internal(ms, cParams, ip, ms->cParams.minMatch);
-}
 
 void ZSTD_dedicatedDictSearch_lazy_loadDictionary(ZSTD_matchState_t* ms, const BYTE* const ip)
 {
@@ -485,7 +403,7 @@ void ZSTD_dedicatedDictSearch_lazy_loadDictionary(ZSTD_matchState_t* ms, const B
     U32* const chainTable = ms->chainTable;
     U32 const chainSize = 1 << ms->cParams.chainLog;
     U32 idx = ms->nextToUpdate;
-    U32 const minChain = chainSize < target ? target - chainSize : idx;
+    U32 const minChain = chainSize < target - idx ? target - chainSize : idx;
     U32 const bucketSize = 1 << ZSTD_LAZY_DDSS_BUCKET_LOG;
     U32 const cacheSize = bucketSize - 1;
     U32 const chainAttempts = (1 << ms->cParams.searchLog) - cacheSize;
@@ -499,13 +417,12 @@ void ZSTD_dedicatedDictSearch_lazy_loadDictionary(ZSTD_matchState_t* ms, const B
     U32 const hashLog = ms->cParams.hashLog - ZSTD_LAZY_DDSS_BUCKET_LOG;
     U32* const tmpHashTable = hashTable;
     U32* const tmpChainTable = hashTable + ((size_t)1 << hashLog);
-    U32 const tmpChainSize = ((1 << ZSTD_LAZY_DDSS_BUCKET_LOG) - 1) << hashLog;
+    U32 const tmpChainSize = (U32)((1 << ZSTD_LAZY_DDSS_BUCKET_LOG) - 1) << hashLog;
     U32 const tmpMinChain = tmpChainSize < target ? target - tmpChainSize : idx;
-
     U32 hashIdx;
 
     assert(ms->cParams.chainLog <= 24);
-    assert(ms->cParams.hashLog >= ms->cParams.chainLog);
+    assert(ms->cParams.hashLog > ms->cParams.chainLog);
     assert(idx != 0);
     assert(tmpMinChain <= minChain);
 
@@ -536,7 +453,7 @@ void ZSTD_dedicatedDictSearch_lazy_loadDictionary(ZSTD_matchState_t* ms, const B
             if (count == cacheSize) {
                 for (count = 0; count < chainLimit;) {
                     if (i < minChain) {
-                        if (!i || countBeyondMinChain++ > cacheSize) {
+                        if (!i || ++countBeyondMinChain > cacheSize) {
                             /* only allow pulling `cacheSize` number of entries
                              * into the cache or chainTable beyond `minChain`,
                              * to replace the entries pulled out of the
@@ -592,10 +509,143 @@ void ZSTD_dedicatedDictSearch_lazy_loadDictionary(ZSTD_matchState_t* ms, const B
     ms->nextToUpdate = target;
 }
 
+/* Returns the longest match length found in the dedicated dict search structure.
+ * If none are longer than the argument ml, then ml will be returned.
+ */
+FORCE_INLINE_TEMPLATE
+size_t ZSTD_dedicatedDictSearch_lazy_search(size_t* offsetPtr, size_t ml, U32 nbAttempts,
+                                            const ZSTD_matchState_t* const dms,
+                                            const BYTE* const ip, const BYTE* const iLimit,
+                                            const BYTE* const prefixStart, const U32 curr,
+                                            const U32 dictLimit, const size_t ddsIdx) {
+    const U32 ddsLowestIndex  = dms->window.dictLimit;
+    const BYTE* const ddsBase = dms->window.base;
+    const BYTE* const ddsEnd  = dms->window.nextSrc;
+    const U32 ddsSize         = (U32)(ddsEnd - ddsBase);
+    const U32 ddsIndexDelta   = dictLimit - ddsSize;
+    const U32 bucketSize      = (1 << ZSTD_LAZY_DDSS_BUCKET_LOG);
+    const U32 bucketLimit     = nbAttempts < bucketSize - 1 ? nbAttempts : bucketSize - 1;
+    U32 ddsAttempt;
+    U32 matchIndex;
+
+    for (ddsAttempt = 0; ddsAttempt < bucketSize - 1; ddsAttempt++) {
+        PREFETCH_L1(ddsBase + dms->hashTable[ddsIdx + ddsAttempt]);
+    }
+
+    {
+        U32 const chainPackedPointer = dms->hashTable[ddsIdx + bucketSize - 1];
+        U32 const chainIndex = chainPackedPointer >> 8;
+
+        PREFETCH_L1(&dms->chainTable[chainIndex]);
+    }
+
+    for (ddsAttempt = 0; ddsAttempt < bucketLimit; ddsAttempt++) {
+        size_t currentMl=0;
+        const BYTE* match;
+        matchIndex = dms->hashTable[ddsIdx + ddsAttempt];
+        match = ddsBase + matchIndex;
+
+        if (!matchIndex) {
+            return ml;
+        }
+
+        /* guaranteed by table construction */
+        (void)ddsLowestIndex;
+        assert(matchIndex >= ddsLowestIndex);
+        assert(match+4 <= ddsEnd);
+        if (MEM_read32(match) == MEM_read32(ip)) {
+            /* assumption : matchIndex <= dictLimit-4 (by table construction) */
+            currentMl = ZSTD_count_2segments(ip+4, match+4, iLimit, ddsEnd, prefixStart) + 4;
+        }
+
+        /* save best solution */
+        if (currentMl > ml) {
+            ml = currentMl;
+            *offsetPtr = STORE_OFFSET(curr - (matchIndex + ddsIndexDelta));
+            if (ip+currentMl == iLimit) {
+                /* best possible, avoids read overflow on next attempt */
+                return ml;
+            }
+        }
+    }
+
+    {
+        U32 const chainPackedPointer = dms->hashTable[ddsIdx + bucketSize - 1];
+        U32 chainIndex = chainPackedPointer >> 8;
+        U32 const chainLength = chainPackedPointer & 0xFF;
+        U32 const chainAttempts = nbAttempts - ddsAttempt;
+        U32 const chainLimit = chainAttempts > chainLength ? chainLength : chainAttempts;
+        U32 chainAttempt;
+
+        for (chainAttempt = 0 ; chainAttempt < chainLimit; chainAttempt++) {
+            PREFETCH_L1(ddsBase + dms->chainTable[chainIndex + chainAttempt]);
+        }
+
+        for (chainAttempt = 0 ; chainAttempt < chainLimit; chainAttempt++, chainIndex++) {
+            size_t currentMl=0;
+            const BYTE* match;
+            matchIndex = dms->chainTable[chainIndex];
+            match = ddsBase + matchIndex;
+
+            /* guaranteed by table construction */
+            assert(matchIndex >= ddsLowestIndex);
+            assert(match+4 <= ddsEnd);
+            if (MEM_read32(match) == MEM_read32(ip)) {
+                /* assumption : matchIndex <= dictLimit-4 (by table construction) */
+                currentMl = ZSTD_count_2segments(ip+4, match+4, iLimit, ddsEnd, prefixStart) + 4;
+            }
+
+            /* save best solution */
+            if (currentMl > ml) {
+                ml = currentMl;
+                *offsetPtr = STORE_OFFSET(curr - (matchIndex + ddsIndexDelta));
+                if (ip+currentMl == iLimit) break; /* best possible, avoids read overflow on next attempt */
+            }
+        }
+    }
+    return ml;
+}
+
+
+/* *********************************
+*  Hash Chain
+***********************************/
+#define NEXT_IN_CHAIN(d, mask)   chainTable[(d) & (mask)]
+
+/* Update chains up to ip (excluded)
+   Assumption : always within prefix (i.e. not within extDict) */
+FORCE_INLINE_TEMPLATE U32 ZSTD_insertAndFindFirstIndex_internal(
+                        ZSTD_matchState_t* ms,
+                        const ZSTD_compressionParameters* const cParams,
+                        const BYTE* ip, U32 const mls)
+{
+    U32* const hashTable  = ms->hashTable;
+    const U32 hashLog = cParams->hashLog;
+    U32* const chainTable = ms->chainTable;
+    const U32 chainMask = (1 << cParams->chainLog) - 1;
+    const BYTE* const base = ms->window.base;
+    const U32 target = (U32)(ip - base);
+    U32 idx = ms->nextToUpdate;
+
+    while(idx < target) { /* catch up */
+        size_t const h = ZSTD_hashPtr(base+idx, hashLog, mls);
+        NEXT_IN_CHAIN(idx, chainMask) = hashTable[h];
+        hashTable[h] = idx;
+        idx++;
+    }
+
+    ms->nextToUpdate = target;
+    return hashTable[ZSTD_hashPtr(ip, hashLog, mls)];
+}
+
+U32 ZSTD_insertAndFindFirstIndex(ZSTD_matchState_t* ms, const BYTE* ip) {
+    const ZSTD_compressionParameters* const cParams = &ms->cParams;
+    return ZSTD_insertAndFindFirstIndex_internal(ms, cParams, ip, ms->cParams.minMatch);
+}
 
 /* inlining is important to hardwire a hot branch (template emulation) */
 FORCE_INLINE_TEMPLATE
-size_t ZSTD_HcFindBestMatch_generic (
+size_t ZSTD_HcFindBestMatch(
                         ZSTD_matchState_t* ms,
                         const BYTE* const ip, const BYTE* const iLimit,
                         size_t* offsetPtr,
@@ -653,7 +703,7 @@ size_t ZSTD_HcFindBestMatch_generic (
         /* save best solution */
         if (currentMl > ml) {
             ml = currentMl;
-            *offsetPtr = curr - matchIndex + ZSTD_REP_MOVE;
+            *offsetPtr = STORE_OFFSET(curr - matchIndex);
             if (ip+currentMl == iLimit) break; /* best possible, avoids read overflow on next attempt */
         }
 
@@ -663,90 +713,8 @@ size_t ZSTD_HcFindBestMatch_generic (
 
     assert(nbAttempts <= (1U << ZSTD_SEARCHLOG_MAX)); /* Check we haven't underflowed. */
     if (dictMode == ZSTD_dedicatedDictSearch) {
-        const U32 ddsLowestIndex  = dms->window.dictLimit;
-        const BYTE* const ddsBase = dms->window.base;
-        const BYTE* const ddsEnd  = dms->window.nextSrc;
-        const U32 ddsSize         = (U32)(ddsEnd - ddsBase);
-        const U32 ddsIndexDelta   = dictLimit - ddsSize;
-        const U32 bucketSize      = (1 << ZSTD_LAZY_DDSS_BUCKET_LOG);
-        const U32 bucketLimit     = nbAttempts < bucketSize - 1 ? nbAttempts : bucketSize - 1;
-        U32 ddsAttempt;
-
-        for (ddsAttempt = 0; ddsAttempt < bucketSize - 1; ddsAttempt++) {
-            PREFETCH_L1(ddsBase + dms->hashTable[ddsIdx + ddsAttempt]);
-        }
-
-        {
-            U32 const chainPackedPointer = dms->hashTable[ddsIdx + bucketSize - 1];
-            U32 const chainIndex = chainPackedPointer >> 8;
-
-            PREFETCH_L1(&dms->chainTable[chainIndex]);
-        }
-
-        for (ddsAttempt = 0; ddsAttempt < bucketLimit; ddsAttempt++) {
-            size_t currentMl=0;
-            const BYTE* match;
-            matchIndex = dms->hashTable[ddsIdx + ddsAttempt];
-            match = ddsBase + matchIndex;
-
-            if (!matchIndex) {
-                return ml;
-            }
-
-            /* guaranteed by table construction */
-            (void)ddsLowestIndex;
-            assert(matchIndex >= ddsLowestIndex);
-            assert(match+4 <= ddsEnd);
-            if (MEM_read32(match) == MEM_read32(ip)) {
-                /* assumption : matchIndex <= dictLimit-4 (by table construction) */
-                currentMl = ZSTD_count_2segments(ip+4, match+4, iLimit, ddsEnd, prefixStart) + 4;
-            }
-
-            /* save best solution */
-            if (currentMl > ml) {
-                ml = currentMl;
-                *offsetPtr = curr - (matchIndex + ddsIndexDelta) + ZSTD_REP_MOVE;
-                if (ip+currentMl == iLimit) {
-                    /* best possible, avoids read overflow on next attempt */
-                    return ml;
-                }
-            }
-        }
-
-        {
-            U32 const chainPackedPointer = dms->hashTable[ddsIdx + bucketSize - 1];
-            U32 chainIndex = chainPackedPointer >> 8;
-            U32 const chainLength = chainPackedPointer & 0xFF;
-            U32 const chainAttempts = nbAttempts - ddsAttempt;
-            U32 const chainLimit = chainAttempts > chainLength ? chainLength : chainAttempts;
-            U32 chainAttempt;
-
-            for (chainAttempt = 0 ; chainAttempt < chainLimit; chainAttempt++) {
-                PREFETCH_L1(ddsBase + dms->chainTable[chainIndex + chainAttempt]);
-            }
-
-            for (chainAttempt = 0 ; chainAttempt < chainLimit; chainAttempt++, chainIndex++) {
-                size_t currentMl=0;
-                const BYTE* match;
-                matchIndex = dms->chainTable[chainIndex];
-                match = ddsBase + matchIndex;
-
-                /* guaranteed by table construction */
-                assert(matchIndex >= ddsLowestIndex);
-                assert(match+4 <= ddsEnd);
-                if (MEM_read32(match) == MEM_read32(ip)) {
-                    /* assumption : matchIndex <= dictLimit-4 (by table construction) */
-                    currentMl = ZSTD_count_2segments(ip+4, match+4, iLimit, ddsEnd, prefixStart) + 4;
-                }
-
-                /* save best solution */
-                if (currentMl > ml) {
-                    ml = currentMl;
-                    *offsetPtr = curr - (matchIndex + ddsIndexDelta) + ZSTD_REP_MOVE;
-                    if (ip+currentMl == iLimit) break; /* best possible, avoids read overflow on next attempt */
-                }
-            }
-        }
+        ml = ZSTD_dedicatedDictSearch_lazy_search(offsetPtr, ml, nbAttempts, dms,
+                                                  ip, iLimit, prefixStart, curr, dictLimit, ddsIdx);
     } else if (dictMode == ZSTD_dictMatchState) {
         const U32* const dmsChainTable = dms->chainTable;
         const U32 dmsChainSize         = (1 << dms->cParams.chainLog);
@@ -770,7 +738,8 @@ size_t ZSTD_HcFindBestMatch_generic (
             /* save best solution */
             if (currentMl > ml) {
                 ml = currentMl;
-                *offsetPtr = curr - (matchIndex + dmsIndexDelta) + ZSTD_REP_MOVE;
+                assert(curr > matchIndex + dmsIndexDelta);
+                *offsetPtr = STORE_OFFSET(curr - (matchIndex + dmsIndexDelta));
                 if (ip+currentMl == iLimit) break; /* best possible, avoids read overflow on next attempt */
             }
 
@@ -783,75 +752,725 @@ size_t ZSTD_HcFindBestMatch_generic (
     return ml;
 }
 
+/* *********************************
+* (SIMD) Row-based matchfinder
+***********************************/
+/* Constants for row-based hash */
+#define ZSTD_ROW_HASH_TAG_OFFSET 16     /* byte offset of hashes in the match state's tagTable from the beginning of a row */
+#define ZSTD_ROW_HASH_TAG_BITS 8        /* nb bits to use for the tag */
+#define ZSTD_ROW_HASH_TAG_MASK ((1u << ZSTD_ROW_HASH_TAG_BITS) - 1)
+#define ZSTD_ROW_HASH_MAX_ENTRIES 64    /* absolute maximum number of entries per row, for all configurations */
+
+#define ZSTD_ROW_HASH_CACHE_MASK (ZSTD_ROW_HASH_CACHE_SIZE - 1)
 
-FORCE_INLINE_TEMPLATE size_t ZSTD_HcFindBestMatch_selectMLS (
-                        ZSTD_matchState_t* ms,
-                        const BYTE* ip, const BYTE* const iLimit,
-                        size_t* offsetPtr)
+typedef U64 ZSTD_VecMask;   /* Clarifies when we are interacting with a U64 representing a mask of matches */
+
+/* ZSTD_VecMask_next():
+ * Starting from the LSB, returns the idx of the next non-zero bit.
+ * Basically counting the nb of trailing zeroes.
+ */
+static U32 ZSTD_VecMask_next(ZSTD_VecMask val) {
+    assert(val != 0);
+#   if (defined(__GNUC__) && ((__GNUC__ > 3) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 4))))
+    if (sizeof(size_t) == 4) {
+        U32 mostSignificantWord = (U32)(val >> 32);
+        U32 leastSignificantWord = (U32)val;
+        if (leastSignificantWord == 0) {
+            return 32 + (U32)__builtin_ctz(mostSignificantWord);
+        } else {
+            return (U32)__builtin_ctz(leastSignificantWord);
+        }
+    } else {
+        return (U32)__builtin_ctzll(val);
+    }
+#   else
+    /* Software ctz version: http://aggregate.org/MAGIC/#Trailing%20Zero%20Count
+     * and: https://stackoverflow.com/questions/2709430/count-number-of-bits-in-a-64-bit-long-big-integer
+     */
+    val = ~val & (val - 1ULL); /* Lowest set bit mask */
+    val = val - ((val >> 1) & 0x5555555555555555);
+    val = (val & 0x3333333333333333ULL) + ((val >> 2) & 0x3333333333333333ULL);
+    return (U32)((((val + (val >> 4)) & 0xF0F0F0F0F0F0F0FULL) * 0x101010101010101ULL) >> 56);
+#   endif
+}
+
+/* ZSTD_rotateRight_*():
+ * Rotates a bitfield to the right by "count" bits.
+ * https://en.wikipedia.org/w/index.php?title=Circular_shift&oldid=991635599#Implementing_circular_shifts
+ */
+FORCE_INLINE_TEMPLATE
+U64 ZSTD_rotateRight_U64(U64 const value, U32 count) {
+    assert(count < 64);
+    count &= 0x3F; /* for fickle pattern recognition */
+    return (value >> count) | (U64)(value << ((0U - count) & 0x3F));
+}
+
+FORCE_INLINE_TEMPLATE
+U32 ZSTD_rotateRight_U32(U32 const value, U32 count) {
+    assert(count < 32);
+    count &= 0x1F; /* for fickle pattern recognition */
+    return (value >> count) | (U32)(value << ((0U - count) & 0x1F));
+}
+
+FORCE_INLINE_TEMPLATE
+U16 ZSTD_rotateRight_U16(U16 const value, U32 count) {
+    assert(count < 16);
+    count &= 0x0F; /* for fickle pattern recognition */
+    return (value >> count) | (U16)(value << ((0U - count) & 0x0F));
+}
+
+/* ZSTD_row_nextIndex():
+ * Returns the next index to insert at within a tagTable row, and updates the "head"
+ * value to reflect the update. Essentially cycles backwards from [0, {entries per row})
+ */
+FORCE_INLINE_TEMPLATE U32 ZSTD_row_nextIndex(BYTE* const tagRow, U32 const rowMask) {
+  U32 const next = (*tagRow - 1) & rowMask;
+  *tagRow = (BYTE)next;
+  return next;
+}
+
+/* ZSTD_isAligned():
+ * Checks that a pointer is aligned to "align" bytes which must be a power of 2.
+ */
+MEM_STATIC int ZSTD_isAligned(void const* ptr, size_t align) {
+    assert((align & (align - 1)) == 0);
+    return (((size_t)ptr) & (align - 1)) == 0;
+}
+
+/* ZSTD_row_prefetch():
+ * Performs prefetching for the hashTable and tagTable at a given row.
+ */
+FORCE_INLINE_TEMPLATE void ZSTD_row_prefetch(U32 const* hashTable, U16 const* tagTable, U32 const relRow, U32 const rowLog) {
+    PREFETCH_L1(hashTable + relRow);
+    if (rowLog >= 5) {
+        PREFETCH_L1(hashTable + relRow + 16);
+        /* Note: prefetching more of the hash table does not appear to be beneficial for 128-entry rows */
+    }
+    PREFETCH_L1(tagTable + relRow);
+    if (rowLog == 6) {
+        PREFETCH_L1(tagTable + relRow + 32);
+    }
+    assert(rowLog == 4 || rowLog == 5 || rowLog == 6);
+    assert(ZSTD_isAligned(hashTable + relRow, 64));                 /* prefetched hash row always 64-byte aligned */
+    assert(ZSTD_isAligned(tagTable + relRow, (size_t)1 << rowLog)); /* prefetched tagRow sits on correct multiple of bytes (32,64,128) */
+}
+
+/* ZSTD_row_fillHashCache():
+ * Fill up the hash cache starting at idx, prefetching up to ZSTD_ROW_HASH_CACHE_SIZE entries,
+ * but not beyond iLimit.
+ */
+FORCE_INLINE_TEMPLATE void ZSTD_row_fillHashCache(ZSTD_matchState_t* ms, const BYTE* base,
+                                   U32 const rowLog, U32 const mls,
+                                   U32 idx, const BYTE* const iLimit)
 {
-    switch(ms->cParams.minMatch)
-    {
-    default : /* includes case 3 */
-    case 4 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 4, ZSTD_noDict);
-    case 5 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 5, ZSTD_noDict);
-    case 7 :
-    case 6 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 6, ZSTD_noDict);
+    U32 const* const hashTable = ms->hashTable;
+    U16 const* const tagTable = ms->tagTable;
+    U32 const hashLog = ms->rowHashLog;
+    U32 const maxElemsToPrefetch = (base + idx) > iLimit ? 0 : (U32)(iLimit - (base + idx) + 1);
+    U32 const lim = idx + MIN(ZSTD_ROW_HASH_CACHE_SIZE, maxElemsToPrefetch);
+
+    for (; idx < lim; ++idx) {
+        U32 const hash = (U32)ZSTD_hashPtr(base + idx, hashLog + ZSTD_ROW_HASH_TAG_BITS, mls);
+        U32 const row = (hash >> ZSTD_ROW_HASH_TAG_BITS) << rowLog;
+        ZSTD_row_prefetch(hashTable, tagTable, row, rowLog);
+        ms->hashCache[idx & ZSTD_ROW_HASH_CACHE_MASK] = hash;
     }
+
+    DEBUGLOG(6, "ZSTD_row_fillHashCache(): [%u %u %u %u %u %u %u %u]", ms->hashCache[0], ms->hashCache[1],
+                                                     ms->hashCache[2], ms->hashCache[3], ms->hashCache[4],
+                                                     ms->hashCache[5], ms->hashCache[6], ms->hashCache[7]);
 }
 
+/* ZSTD_row_nextCachedHash():
+ * Returns the hash of base + idx, and replaces the hash in the hash cache with the byte at
+ * base + idx + ZSTD_ROW_HASH_CACHE_SIZE. Also prefetches the appropriate rows from hashTable and tagTable.
+ */
+FORCE_INLINE_TEMPLATE U32 ZSTD_row_nextCachedHash(U32* cache, U32 const* hashTable,
+                                                  U16 const* tagTable, BYTE const* base,
+                                                  U32 idx, U32 const hashLog,
+                                                  U32 const rowLog, U32 const mls)
+{
+    U32 const newHash = (U32)ZSTD_hashPtr(base+idx+ZSTD_ROW_HASH_CACHE_SIZE, hashLog + ZSTD_ROW_HASH_TAG_BITS, mls);
+    U32 const row = (newHash >> ZSTD_ROW_HASH_TAG_BITS) << rowLog;
+    ZSTD_row_prefetch(hashTable, tagTable, row, rowLog);
+    {   U32 const hash = cache[idx & ZSTD_ROW_HASH_CACHE_MASK];
+        cache[idx & ZSTD_ROW_HASH_CACHE_MASK] = newHash;
+        return hash;
+    }
+}
 
-static size_t ZSTD_HcFindBestMatch_dictMatchState_selectMLS (
-                        ZSTD_matchState_t* ms,
-                        const BYTE* ip, const BYTE* const iLimit,
-                        size_t* offsetPtr)
+/* ZSTD_row_update_internalImpl():
+ * Updates the hash table with positions starting from updateStartIdx until updateEndIdx.
+ */
+FORCE_INLINE_TEMPLATE void ZSTD_row_update_internalImpl(ZSTD_matchState_t* ms,
+                                                        U32 updateStartIdx, U32 const updateEndIdx,
+                                                        U32 const mls, U32 const rowLog,
+                                                        U32 const rowMask, U32 const useCache)
 {
-    switch(ms->cParams.minMatch)
-    {
-    default : /* includes case 3 */
-    case 4 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 4, ZSTD_dictMatchState);
-    case 5 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 5, ZSTD_dictMatchState);
-    case 7 :
-    case 6 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 6, ZSTD_dictMatchState);
+    U32* const hashTable = ms->hashTable;
+    U16* const tagTable = ms->tagTable;
+    U32 const hashLog = ms->rowHashLog;
+    const BYTE* const base = ms->window.base;
+
+    DEBUGLOG(6, "ZSTD_row_update_internalImpl(): updateStartIdx=%u, updateEndIdx=%u", updateStartIdx, updateEndIdx);
+    for (; updateStartIdx < updateEndIdx; ++updateStartIdx) {
+        U32 const hash = useCache ? ZSTD_row_nextCachedHash(ms->hashCache, hashTable, tagTable, base, updateStartIdx, hashLog, rowLog, mls)
+                                  : (U32)ZSTD_hashPtr(base + updateStartIdx, hashLog + ZSTD_ROW_HASH_TAG_BITS, mls);
+        U32 const relRow = (hash >> ZSTD_ROW_HASH_TAG_BITS) << rowLog;
+        U32* const row = hashTable + relRow;
+        BYTE* tagRow = (BYTE*)(tagTable + relRow);  /* Though tagTable is laid out as a table of U16, each tag is only 1 byte.
+                                                       Explicit cast allows us to get exact desired position within each row */
+        U32 const pos = ZSTD_row_nextIndex(tagRow, rowMask);
+
+        assert(hash == ZSTD_hashPtr(base + updateStartIdx, hashLog + ZSTD_ROW_HASH_TAG_BITS, mls));
+        ((BYTE*)tagRow)[pos + ZSTD_ROW_HASH_TAG_OFFSET] = hash & ZSTD_ROW_HASH_TAG_MASK;
+        row[pos] = updateStartIdx;
     }
 }
 
+/* ZSTD_row_update_internal():
+ * Inserts the byte at ip into the appropriate position in the hash table, and updates ms->nextToUpdate.
+ * Skips sections of long matches as is necessary.
+ */
+FORCE_INLINE_TEMPLATE void ZSTD_row_update_internal(ZSTD_matchState_t* ms, const BYTE* ip,
+                                                    U32 const mls, U32 const rowLog,
+                                                    U32 const rowMask, U32 const useCache)
+{
+    U32 idx = ms->nextToUpdate;
+    const BYTE* const base = ms->window.base;
+    const U32 target = (U32)(ip - base);
+    const U32 kSkipThreshold = 384;
+    const U32 kMaxMatchStartPositionsToUpdate = 96;
+    const U32 kMaxMatchEndPositionsToUpdate = 32;
+
+    if (useCache) {
+        /* Only skip positions when using hash cache, i.e.
+         * if we are loading a dict, don't skip anything.
+         * If we decide to skip, then we only update a set number
+         * of positions at the beginning and end of the match.
+         */
+        if (UNLIKELY(target - idx > kSkipThreshold)) {
+            U32 const bound = idx + kMaxMatchStartPositionsToUpdate;
+            ZSTD_row_update_internalImpl(ms, idx, bound, mls, rowLog, rowMask, useCache);
+            idx = target - kMaxMatchEndPositionsToUpdate;
+            ZSTD_row_fillHashCache(ms, base, rowLog, mls, idx, ip+1);
+        }
+    }
+    assert(target >= idx);
+    ZSTD_row_update_internalImpl(ms, idx, target, mls, rowLog, rowMask, useCache);
+    ms->nextToUpdate = target;
+}
 
-static size_t ZSTD_HcFindBestMatch_dedicatedDictSearch_selectMLS (
-                        ZSTD_matchState_t* ms,
-                        const BYTE* ip, const BYTE* const iLimit,
-                        size_t* offsetPtr)
+/* ZSTD_row_update():
+ * External wrapper for ZSTD_row_update_internal(). Used for filling the hashtable during dictionary
+ * processing.
+ */
+void ZSTD_row_update(ZSTD_matchState_t* const ms, const BYTE* ip) {
+    const U32 rowLog = BOUNDED(4, ms->cParams.searchLog, 6);
+    const U32 rowMask = (1u << rowLog) - 1;
+    const U32 mls = MIN(ms->cParams.minMatch, 6 /* mls caps out at 6 */);
+
+    DEBUGLOG(5, "ZSTD_row_update(), rowLog=%u", rowLog);
+    ZSTD_row_update_internal(ms, ip, mls, rowLog, rowMask, 0 /* dont use cache */);
+}
+
+#if defined(ZSTD_ARCH_X86_SSE2)
+FORCE_INLINE_TEMPLATE ZSTD_VecMask
+ZSTD_row_getSSEMask(int nbChunks, const BYTE* const src, const BYTE tag, const U32 head)
 {
-    switch(ms->cParams.minMatch)
-    {
-    default : /* includes case 3 */
-    case 4 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 4, ZSTD_dedicatedDictSearch);
-    case 5 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 5, ZSTD_dedicatedDictSearch);
-    case 7 :
-    case 6 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 6, ZSTD_dedicatedDictSearch);
+    const __m128i comparisonMask = _mm_set1_epi8((char)tag);
+    int matches[4] = {0};
+    int i;
+    assert(nbChunks == 1 || nbChunks == 2 || nbChunks == 4);
+    for (i=0; i<nbChunks; i++) {
+        const __m128i chunk = _mm_loadu_si128((const __m128i*)(const void*)(src + 16*i));
+        const __m128i equalMask = _mm_cmpeq_epi8(chunk, comparisonMask);
+        matches[i] = _mm_movemask_epi8(equalMask);
     }
+    if (nbChunks == 1) return ZSTD_rotateRight_U16((U16)matches[0], head);
+    if (nbChunks == 2) return ZSTD_rotateRight_U32((U32)matches[1] << 16 | (U32)matches[0], head);
+    assert(nbChunks == 4);
+    return ZSTD_rotateRight_U64((U64)matches[3] << 48 | (U64)matches[2] << 32 | (U64)matches[1] << 16 | (U64)matches[0], head);
 }
+#endif
 
+/* Returns a ZSTD_VecMask (U32) that has the nth bit set to 1 if the newly-computed "tag" matches
+ * the hash at the nth position in a row of the tagTable.
+ * Each row is a circular buffer beginning at the value of "head". So we must rotate the "matches" bitfield
+ * to match up with the actual layout of the entries within the hashTable */
+FORCE_INLINE_TEMPLATE ZSTD_VecMask
+ZSTD_row_getMatchMask(const BYTE* const tagRow, const BYTE tag, const U32 head, const U32 rowEntries)
+{
+    const BYTE* const src = tagRow + ZSTD_ROW_HASH_TAG_OFFSET;
+    assert((rowEntries == 16) || (rowEntries == 32) || rowEntries == 64);
+    assert(rowEntries <= ZSTD_ROW_HASH_MAX_ENTRIES);
+
+#if defined(ZSTD_ARCH_X86_SSE2)
+
+    return ZSTD_row_getSSEMask(rowEntries / 16, src, tag, head);
+
+#else /* SW or NEON-LE */
+
+# if defined(ZSTD_ARCH_ARM_NEON)
+  /* This NEON path only works for little endian - otherwise use SWAR below */
+    if (MEM_isLittleEndian()) {
+        if (rowEntries == 16) {
+            const uint8x16_t chunk = vld1q_u8(src);
+            const uint16x8_t equalMask = vreinterpretq_u16_u8(vceqq_u8(chunk, vdupq_n_u8(tag)));
+            const uint16x8_t t0 = vshlq_n_u16(equalMask, 7);
+            const uint32x4_t t1 = vreinterpretq_u32_u16(vsriq_n_u16(t0, t0, 14));
+            const uint64x2_t t2 = vreinterpretq_u64_u32(vshrq_n_u32(t1, 14));
+            const uint8x16_t t3 = vreinterpretq_u8_u64(vsraq_n_u64(t2, t2, 28));
+            const U16 hi = (U16)vgetq_lane_u8(t3, 8);
+            const U16 lo = (U16)vgetq_lane_u8(t3, 0);
+            return ZSTD_rotateRight_U16((hi << 8) | lo, head);
+        } else if (rowEntries == 32) {
+            const uint16x8x2_t chunk = vld2q_u16((const U16*)(const void*)src);
+            const uint8x16_t chunk0 = vreinterpretq_u8_u16(chunk.val[0]);
+            const uint8x16_t chunk1 = vreinterpretq_u8_u16(chunk.val[1]);
+            const uint8x16_t equalMask0 = vceqq_u8(chunk0, vdupq_n_u8(tag));
+            const uint8x16_t equalMask1 = vceqq_u8(chunk1, vdupq_n_u8(tag));
+            const int8x8_t pack0 = vqmovn_s16(vreinterpretq_s16_u8(equalMask0));
+            const int8x8_t pack1 = vqmovn_s16(vreinterpretq_s16_u8(equalMask1));
+            const uint8x8_t t0 = vreinterpret_u8_s8(pack0);
+            const uint8x8_t t1 = vreinterpret_u8_s8(pack1);
+            const uint8x8_t t2 = vsri_n_u8(t1, t0, 2);
+            const uint8x8x2_t t3 = vuzp_u8(t2, t0);
+            const uint8x8_t t4 = vsri_n_u8(t3.val[1], t3.val[0], 4);
+            const U32 matches = vget_lane_u32(vreinterpret_u32_u8(t4), 0);
+            return ZSTD_rotateRight_U32(matches, head);
+        } else { /* rowEntries == 64 */
+            const uint8x16x4_t chunk = vld4q_u8(src);
+            const uint8x16_t dup = vdupq_n_u8(tag);
+            const uint8x16_t cmp0 = vceqq_u8(chunk.val[0], dup);
+            const uint8x16_t cmp1 = vceqq_u8(chunk.val[1], dup);
+            const uint8x16_t cmp2 = vceqq_u8(chunk.val[2], dup);
+            const uint8x16_t cmp3 = vceqq_u8(chunk.val[3], dup);
+
+            const uint8x16_t t0 = vsriq_n_u8(cmp1, cmp0, 1);
+            const uint8x16_t t1 = vsriq_n_u8(cmp3, cmp2, 1);
+            const uint8x16_t t2 = vsriq_n_u8(t1, t0, 2);
+            const uint8x16_t t3 = vsriq_n_u8(t2, t2, 4);
+            const uint8x8_t t4 = vshrn_n_u16(vreinterpretq_u16_u8(t3), 4);
+            const U64 matches = vget_lane_u64(vreinterpret_u64_u8(t4), 0);
+            return ZSTD_rotateRight_U64(matches, head);
+        }
+    }
+# endif /* ZSTD_ARCH_ARM_NEON */
+    /* SWAR */
+    {   const size_t chunkSize = sizeof(size_t);
+        const size_t shiftAmount = ((chunkSize * 8) - chunkSize);
+        const size_t xFF = ~((size_t)0);
+        const size_t x01 = xFF / 0xFF;
+        const size_t x80 = x01 << 7;
+        const size_t splatChar = tag * x01;
+        ZSTD_VecMask matches = 0;
+        int i = rowEntries - chunkSize;
+        assert((sizeof(size_t) == 4) || (sizeof(size_t) == 8));
+        if (MEM_isLittleEndian()) { /* runtime check so have two loops */
+            const size_t extractMagic = (xFF / 0x7F) >> chunkSize;
+            do {
+                size_t chunk = MEM_readST(&src[i]);
+                chunk ^= splatChar;
+                chunk = (((chunk | x80) - x01) | chunk) & x80;
+                matches <<= chunkSize;
+                matches |= (chunk * extractMagic) >> shiftAmount;
+                i -= chunkSize;
+            } while (i >= 0);
+        } else { /* big endian: reverse bits during extraction */
+            const size_t msb = xFF ^ (xFF >> 1);
+            const size_t extractMagic = (msb / 0x1FF) | msb;
+            do {
+                size_t chunk = MEM_readST(&src[i]);
+                chunk ^= splatChar;
+                chunk = (((chunk | x80) - x01) | chunk) & x80;
+                matches <<= chunkSize;
+                matches |= ((chunk >> 7) * extractMagic) >> shiftAmount;
+                i -= chunkSize;
+            } while (i >= 0);
+        }
+        matches = ~matches;
+        if (rowEntries == 16) {
+            return ZSTD_rotateRight_U16((U16)matches, head);
+        } else if (rowEntries == 32) {
+            return ZSTD_rotateRight_U32((U32)matches, head);
+        } else {
+            return ZSTD_rotateRight_U64((U64)matches, head);
+        }
+    }
+#endif
+}
 
-FORCE_INLINE_TEMPLATE size_t ZSTD_HcFindBestMatch_extDict_selectMLS (
+/* The high-level approach of the SIMD row based match finder is as follows:
+ * - Figure out where to insert the new entry:
+ *      - Generate a hash from a byte along with an additional 1-byte "short hash". The additional byte is our "tag"
+ *      - The hashTable is effectively split into groups or "rows" of 16 or 32 entries of U32, and the hash determines
+ *        which row to insert into.
+ *      - Determine the correct position within the row to insert the entry into. Each row of 16 or 32 can
+ *        be considered as a circular buffer with a "head" index that resides in the tagTable.
+ *      - Also insert the "tag" into the equivalent row and position in the tagTable.
+ *          - Note: The tagTable has 17 or 33 1-byte entries per row, due to 16 or 32 tags, and 1 "head" entry.
+ *                  The 17 or 33 entry rows are spaced out to occur every 32 or 64 bytes, respectively,
+ *                  for alignment/performance reasons, leaving some bytes unused.
+ * - Use SIMD to efficiently compare the tags in the tagTable to the 1-byte "short hash" and
+ *   generate a bitfield that we can cycle through to check the collisions in the hash table.
+ * - Pick the longest match.
+ */
+FORCE_INLINE_TEMPLATE
+size_t ZSTD_RowFindBestMatch(
                         ZSTD_matchState_t* ms,
-                        const BYTE* ip, const BYTE* const iLimit,
-                        size_t* offsetPtr)
+                        const BYTE* const ip, const BYTE* const iLimit,
+                        size_t* offsetPtr,
+                        const U32 mls, const ZSTD_dictMode_e dictMode,
+                        const U32 rowLog)
 {
-    switch(ms->cParams.minMatch)
-    {
-    default : /* includes case 3 */
-    case 4 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 4, ZSTD_extDict);
-    case 5 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 5, ZSTD_extDict);
-    case 7 :
-    case 6 : return ZSTD_HcFindBestMatch_generic(ms, ip, iLimit, offsetPtr, 6, ZSTD_extDict);
+    U32* const hashTable = ms->hashTable;
+    U16* const tagTable = ms->tagTable;
+    U32* const hashCache = ms->hashCache;
+    const U32 hashLog = ms->rowHashLog;
+    const ZSTD_compressionParameters* const cParams = &ms->cParams;
+    const BYTE* const base = ms->window.base;
+    const BYTE* const dictBase = ms->window.dictBase;
+    const U32 dictLimit = ms->window.dictLimit;
+    const BYTE* const prefixStart = base + dictLimit;
+    const BYTE* const dictEnd = dictBase + dictLimit;
+    const U32 curr = (U32)(ip-base);
+    const U32 maxDistance = 1U << cParams->windowLog;
+    const U32 lowestValid = ms->window.lowLimit;
+    const U32 withinMaxDistance = (curr - lowestValid > maxDistance) ? curr - maxDistance : lowestValid;
+    const U32 isDictionary = (ms->loadedDictEnd != 0);
+    const U32 lowLimit = isDictionary ? lowestValid : withinMaxDistance;
+    const U32 rowEntries = (1U << rowLog);
+    const U32 rowMask = rowEntries - 1;
+    const U32 cappedSearchLog = MIN(cParams->searchLog, rowLog); /* nb of searches is capped at nb entries per row */
+    U32 nbAttempts = 1U << cappedSearchLog;
+    size_t ml=4-1;
+
+    /* DMS/DDS variables that may be referenced laster */
+    const ZSTD_matchState_t* const dms = ms->dictMatchState;
+
+    /* Initialize the following variables to satisfy static analyzer */
+    size_t ddsIdx = 0;
+    U32 ddsExtraAttempts = 0; /* cctx hash tables are limited in searches, but allow extra searches into DDS */
+    U32 dmsTag = 0;
+    U32* dmsRow = NULL;
+    BYTE* dmsTagRow = NULL;
+
+    if (dictMode == ZSTD_dedicatedDictSearch) {
+        const U32 ddsHashLog = dms->cParams.hashLog - ZSTD_LAZY_DDSS_BUCKET_LOG;
+        {   /* Prefetch DDS hashtable entry */
+            ddsIdx = ZSTD_hashPtr(ip, ddsHashLog, mls) << ZSTD_LAZY_DDSS_BUCKET_LOG;
+            PREFETCH_L1(&dms->hashTable[ddsIdx]);
+        }
+        ddsExtraAttempts = cParams->searchLog > rowLog ? 1U << (cParams->searchLog - rowLog) : 0;
+    }
+
+    if (dictMode == ZSTD_dictMatchState) {
+        /* Prefetch DMS rows */
+        U32* const dmsHashTable = dms->hashTable;
+        U16* const dmsTagTable = dms->tagTable;
+        U32 const dmsHash = (U32)ZSTD_hashPtr(ip, dms->rowHashLog + ZSTD_ROW_HASH_TAG_BITS, mls);
+        U32 const dmsRelRow = (dmsHash >> ZSTD_ROW_HASH_TAG_BITS) << rowLog;
+        dmsTag = dmsHash & ZSTD_ROW_HASH_TAG_MASK;
+        dmsTagRow = (BYTE*)(dmsTagTable + dmsRelRow);
+        dmsRow = dmsHashTable + dmsRelRow;
+        ZSTD_row_prefetch(dmsHashTable, dmsTagTable, dmsRelRow, rowLog);
+    }
+
+    /* Update the hashTable and tagTable up to (but not including) ip */
+    ZSTD_row_update_internal(ms, ip, mls, rowLog, rowMask, 1 /* useCache */);
+    {   /* Get the hash for ip, compute the appropriate row */
+        U32 const hash = ZSTD_row_nextCachedHash(hashCache, hashTable, tagTable, base, curr, hashLog, rowLog, mls);
+        U32 const relRow = (hash >> ZSTD_ROW_HASH_TAG_BITS) << rowLog;
+        U32 const tag = hash & ZSTD_ROW_HASH_TAG_MASK;
+        U32* const row = hashTable + relRow;
+        BYTE* tagRow = (BYTE*)(tagTable + relRow);
+        U32 const head = *tagRow & rowMask;
+        U32 matchBuffer[ZSTD_ROW_HASH_MAX_ENTRIES];
+        size_t numMatches = 0;
+        size_t currMatch = 0;
+        ZSTD_VecMask matches = ZSTD_row_getMatchMask(tagRow, (BYTE)tag, head, rowEntries);
+
+        /* Cycle through the matches and prefetch */
+        for (; (matches > 0) && (nbAttempts > 0); --nbAttempts, matches &= (matches - 1)) {
+            U32 const matchPos = (head + ZSTD_VecMask_next(matches)) & rowMask;
+            U32 const matchIndex = row[matchPos];
+            assert(numMatches < rowEntries);
+            if (matchIndex < lowLimit)
+                break;
+            if ((dictMode != ZSTD_extDict) || matchIndex >= dictLimit) {
+                PREFETCH_L1(base + matchIndex);
+            } else {
+                PREFETCH_L1(dictBase + matchIndex);
+            }
+            matchBuffer[numMatches++] = matchIndex;
+        }
+
+        /* Speed opt: insert current byte into hashtable too. This allows us to avoid one iteration of the loop
+           in ZSTD_row_update_internal() at the next search. */
+        {
+            U32 const pos = ZSTD_row_nextIndex(tagRow, rowMask);
+            tagRow[pos + ZSTD_ROW_HASH_TAG_OFFSET] = (BYTE)tag;
+            row[pos] = ms->nextToUpdate++;
+        }
+
+        /* Return the longest match */
+        for (; currMatch < numMatches; ++currMatch) {
+            U32 const matchIndex = matchBuffer[currMatch];
+            size_t currentMl=0;
+            assert(matchIndex < curr);
+            assert(matchIndex >= lowLimit);
+
+            if ((dictMode != ZSTD_extDict) || matchIndex >= dictLimit) {
+                const BYTE* const match = base + matchIndex;
+                assert(matchIndex >= dictLimit);   /* ensures this is true if dictMode != ZSTD_extDict */
+                if (match[ml] == ip[ml])   /* potentially better */
+                    currentMl = ZSTD_count(ip, match, iLimit);
+            } else {
+                const BYTE* const match = dictBase + matchIndex;
+                assert(match+4 <= dictEnd);
+                if (MEM_read32(match) == MEM_read32(ip))   /* assumption : matchIndex <= dictLimit-4 (by table construction) */
+                    currentMl = ZSTD_count_2segments(ip+4, match+4, iLimit, dictEnd, prefixStart) + 4;
+            }
+
+            /* Save best solution */
+            if (currentMl > ml) {
+                ml = currentMl;
+                *offsetPtr = STORE_OFFSET(curr - matchIndex);
+                if (ip+currentMl == iLimit) break; /* best possible, avoids read overflow on next attempt */
+            }
+        }
+    }
+
+    assert(nbAttempts <= (1U << ZSTD_SEARCHLOG_MAX)); /* Check we haven't underflowed. */
+    if (dictMode == ZSTD_dedicatedDictSearch) {
+        ml = ZSTD_dedicatedDictSearch_lazy_search(offsetPtr, ml, nbAttempts + ddsExtraAttempts, dms,
+                                                  ip, iLimit, prefixStart, curr, dictLimit, ddsIdx);
+    } else if (dictMode == ZSTD_dictMatchState) {
+        /* TODO: Measure and potentially add prefetching to DMS */
+        const U32 dmsLowestIndex       = dms->window.dictLimit;
+        const BYTE* const dmsBase      = dms->window.base;
+        const BYTE* const dmsEnd       = dms->window.nextSrc;
+        const U32 dmsSize              = (U32)(dmsEnd - dmsBase);
+        const U32 dmsIndexDelta        = dictLimit - dmsSize;
+
+        {   U32 const head = *dmsTagRow & rowMask;
+            U32 matchBuffer[ZSTD_ROW_HASH_MAX_ENTRIES];
+            size_t numMatches = 0;
+            size_t currMatch = 0;
+            ZSTD_VecMask matches = ZSTD_row_getMatchMask(dmsTagRow, (BYTE)dmsTag, head, rowEntries);
+
+            for (; (matches > 0) && (nbAttempts > 0); --nbAttempts, matches &= (matches - 1)) {
+                U32 const matchPos = (head + ZSTD_VecMask_next(matches)) & rowMask;
+                U32 const matchIndex = dmsRow[matchPos];
+                if (matchIndex < dmsLowestIndex)
+                    break;
+                PREFETCH_L1(dmsBase + matchIndex);
+                matchBuffer[numMatches++] = matchIndex;
+            }
+
+            /* Return the longest match */
+            for (; currMatch < numMatches; ++currMatch) {
+                U32 const matchIndex = matchBuffer[currMatch];
+                size_t currentMl=0;
+                assert(matchIndex >= dmsLowestIndex);
+                assert(matchIndex < curr);
+
+                {   const BYTE* const match = dmsBase + matchIndex;
+                    assert(match+4 <= dmsEnd);
+                    if (MEM_read32(match) == MEM_read32(ip))
+                        currentMl = ZSTD_count_2segments(ip+4, match+4, iLimit, dmsEnd, prefixStart) + 4;
+                }
+
+                if (currentMl > ml) {
+                    ml = currentMl;
+                    assert(curr > matchIndex + dmsIndexDelta);
+                    *offsetPtr = STORE_OFFSET(curr - (matchIndex + dmsIndexDelta));
+                    if (ip+currentMl == iLimit) break;
+                }
+            }
+        }
     }
+    return ml;
 }
 
 
+/*
+ * Generate search functions templated on (dictMode, mls, rowLog).
+ * These functions are outlined for code size & compilation time.
+ * ZSTD_searchMax() dispatches to the correct implementation function.
+ *
+ * TODO: The start of the search function involves loading and calculating a
+ * bunch of constants from the ZSTD_matchState_t. These computations could be
+ * done in an initialization function, and saved somewhere in the match state.
+ * Then we could pass a pointer to the saved state instead of the match state,
+ * and avoid duplicate computations.
+ *
+ * TODO: Move the match re-winding into searchMax. This improves compression
+ * ratio, and unlocks further simplifications with the next TODO.
+ *
+ * TODO: Try moving the repcode search into searchMax. After the re-winding
+ * and repcode search are in searchMax, there is no more logic in the match
+ * finder loop that requires knowledge about the dictMode. So we should be
+ * able to avoid force inlining it, and we can join the extDict loop with
+ * the single segment loop. It should go in searchMax instead of its own
+ * function to avoid having multiple virtual function calls per search.
+ */
+
+#define ZSTD_BT_SEARCH_FN(dictMode, mls) ZSTD_BtFindBestMatch_##dictMode##_##mls
+#define ZSTD_HC_SEARCH_FN(dictMode, mls) ZSTD_HcFindBestMatch_##dictMode##_##mls
+#define ZSTD_ROW_SEARCH_FN(dictMode, mls, rowLog) ZSTD_RowFindBestMatch_##dictMode##_##mls##_##rowLog
+
+#define ZSTD_SEARCH_FN_ATTRS FORCE_NOINLINE
+
+#define GEN_ZSTD_BT_SEARCH_FN(dictMode, mls)                                           \
+    ZSTD_SEARCH_FN_ATTRS size_t ZSTD_BT_SEARCH_FN(dictMode, mls)(                      \
+            ZSTD_matchState_t* ms,                                                     \
+            const BYTE* ip, const BYTE* const iLimit,                                  \
+            size_t* offBasePtr)                                                        \
+    {                                                                                  \
+        assert(MAX(4, MIN(6, ms->cParams.minMatch)) == mls);                           \
+        return ZSTD_BtFindBestMatch(ms, ip, iLimit, offBasePtr, mls, ZSTD_##dictMode); \
+    }                                                                                  \
+
+#define GEN_ZSTD_HC_SEARCH_FN(dictMode, mls)                                          \
+    ZSTD_SEARCH_FN_ATTRS size_t ZSTD_HC_SEARCH_FN(dictMode, mls)(                     \
+            ZSTD_matchState_t* ms,                                                    \
+            const BYTE* ip, const BYTE* const iLimit,                                 \
+            size_t* offsetPtr)                                                        \
+    {                                                                                 \
+        assert(MAX(4, MIN(6, ms->cParams.minMatch)) == mls);                          \
+        return ZSTD_HcFindBestMatch(ms, ip, iLimit, offsetPtr, mls, ZSTD_##dictMode); \
+    }                                                                                 \
+
+#define GEN_ZSTD_ROW_SEARCH_FN(dictMode, mls, rowLog)                                          \
+    ZSTD_SEARCH_FN_ATTRS size_t ZSTD_ROW_SEARCH_FN(dictMode, mls, rowLog)(                     \
+            ZSTD_matchState_t* ms,                                                             \
+            const BYTE* ip, const BYTE* const iLimit,                                          \
+            size_t* offsetPtr)                                                                 \
+    {                                                                                          \
+        assert(MAX(4, MIN(6, ms->cParams.minMatch)) == mls);                                   \
+        assert(MAX(4, MIN(6, ms->cParams.searchLog)) == rowLog);                               \
+        return ZSTD_RowFindBestMatch(ms, ip, iLimit, offsetPtr, mls, ZSTD_##dictMode, rowLog); \
+    }                                                                                          \
+
+#define ZSTD_FOR_EACH_ROWLOG(X, dictMode, mls) \
+    X(dictMode, mls, 4)                        \
+    X(dictMode, mls, 5)                        \
+    X(dictMode, mls, 6)
+
+#define ZSTD_FOR_EACH_MLS_ROWLOG(X, dictMode) \
+    ZSTD_FOR_EACH_ROWLOG(X, dictMode, 4)      \
+    ZSTD_FOR_EACH_ROWLOG(X, dictMode, 5)      \
+    ZSTD_FOR_EACH_ROWLOG(X, dictMode, 6)
+
+#define ZSTD_FOR_EACH_MLS(X, dictMode) \
+    X(dictMode, 4)                     \
+    X(dictMode, 5)                     \
+    X(dictMode, 6)
+
+#define ZSTD_FOR_EACH_DICT_MODE(X, ...) \
+    X(__VA_ARGS__, noDict)              \
+    X(__VA_ARGS__, extDict)             \
+    X(__VA_ARGS__, dictMatchState)      \
+    X(__VA_ARGS__, dedicatedDictSearch)
+
+/* Generate row search fns for each combination of (dictMode, mls, rowLog) */
+ZSTD_FOR_EACH_DICT_MODE(ZSTD_FOR_EACH_MLS_ROWLOG, GEN_ZSTD_ROW_SEARCH_FN)
+/* Generate binary Tree search fns for each combination of (dictMode, mls) */
+ZSTD_FOR_EACH_DICT_MODE(ZSTD_FOR_EACH_MLS, GEN_ZSTD_BT_SEARCH_FN)
+/* Generate hash chain search fns for each combination of (dictMode, mls) */
+ZSTD_FOR_EACH_DICT_MODE(ZSTD_FOR_EACH_MLS, GEN_ZSTD_HC_SEARCH_FN)
+
+typedef enum { search_hashChain=0, search_binaryTree=1, search_rowHash=2 } searchMethod_e;
+
+#define GEN_ZSTD_CALL_BT_SEARCH_FN(dictMode, mls)                         \
+    case mls:                                                             \
+        return ZSTD_BT_SEARCH_FN(dictMode, mls)(ms, ip, iend, offsetPtr);
+#define GEN_ZSTD_CALL_HC_SEARCH_FN(dictMode, mls)                         \
+    case mls:                                                             \
+        return ZSTD_HC_SEARCH_FN(dictMode, mls)(ms, ip, iend, offsetPtr);
+#define GEN_ZSTD_CALL_ROW_SEARCH_FN(dictMode, mls, rowLog)                         \
+    case rowLog:                                                                   \
+        return ZSTD_ROW_SEARCH_FN(dictMode, mls, rowLog)(ms, ip, iend, offsetPtr);
+
+#define ZSTD_SWITCH_MLS(X, dictMode)   \
+    switch (mls) {                     \
+        ZSTD_FOR_EACH_MLS(X, dictMode) \
+    }
+
+#define ZSTD_SWITCH_ROWLOG(dictMode, mls)                                    \
+    case mls:                                                                \
+        switch (rowLog) {                                                    \
+            ZSTD_FOR_EACH_ROWLOG(GEN_ZSTD_CALL_ROW_SEARCH_FN, dictMode, mls) \
+        }                                                                    \
+        ZSTD_UNREACHABLE;                                                    \
+        break;
+
+#define ZSTD_SWITCH_SEARCH_METHOD(dictMode)                       \
+    switch (searchMethod) {                                       \
+        case search_hashChain:                                    \
+            ZSTD_SWITCH_MLS(GEN_ZSTD_CALL_HC_SEARCH_FN, dictMode) \
+            break;                                                \
+        case search_binaryTree:                                   \
+            ZSTD_SWITCH_MLS(GEN_ZSTD_CALL_BT_SEARCH_FN, dictMode) \
+            break;                                                \
+        case search_rowHash:                                      \
+            ZSTD_SWITCH_MLS(ZSTD_SWITCH_ROWLOG, dictMode)         \
+            break;                                                \
+    }                                                             \
+    ZSTD_UNREACHABLE;
+
+/*
+ * Searches for the longest match at @p ip.
+ * Dispatches to the correct implementation function based on the
+ * (searchMethod, dictMode, mls, rowLog). We use switch statements
+ * here instead of using an indirect function call through a function
+ * pointer because after Spectre and Meltdown mitigations, indirect
+ * function calls can be very costly, especially in the kernel.
+ *
+ * NOTE: dictMode and searchMethod should be templated, so those switch
+ * statements should be optimized out. Only the mls & rowLog switches
+ * should be left.
+ *
+ * @param ms The match state.
+ * @param ip The position to search at.
+ * @param iend The end of the input data.
+ * @param[out] offsetPtr Stores the match offset into this pointer.
+ * @param mls The minimum search length, in the range [4, 6].
+ * @param rowLog The row log (if applicable), in the range [4, 6].
+ * @param searchMethod The search method to use (templated).
+ * @param dictMode The dictMode (templated).
+ *
+ * @returns The length of the longest match found, or < mls if no match is found.
+ * If a match is found its offset is stored in @p offsetPtr.
+ */
+FORCE_INLINE_TEMPLATE size_t ZSTD_searchMax(
+    ZSTD_matchState_t* ms,
+    const BYTE* ip,
+    const BYTE* iend,
+    size_t* offsetPtr,
+    U32 const mls,
+    U32 const rowLog,
+    searchMethod_e const searchMethod,
+    ZSTD_dictMode_e const dictMode)
+{
+    if (dictMode == ZSTD_noDict) {
+        ZSTD_SWITCH_SEARCH_METHOD(noDict)
+    } else if (dictMode == ZSTD_extDict) {
+        ZSTD_SWITCH_SEARCH_METHOD(extDict)
+    } else if (dictMode == ZSTD_dictMatchState) {
+        ZSTD_SWITCH_SEARCH_METHOD(dictMatchState)
+    } else if (dictMode == ZSTD_dedicatedDictSearch) {
+        ZSTD_SWITCH_SEARCH_METHOD(dedicatedDictSearch)
+    }
+    ZSTD_UNREACHABLE;
+    return 0;
+}
+
 /* *******************************
 *  Common parser - lazy strategy
 *********************************/
-typedef enum { search_hashChain, search_binaryTree } searchMethod_e;
 
 FORCE_INLINE_TEMPLATE size_t
 ZSTD_compressBlock_lazy_generic(
@@ -865,41 +1484,13 @@ ZSTD_compressBlock_lazy_generic(
     const BYTE* ip = istart;
     const BYTE* anchor = istart;
     const BYTE* const iend = istart + srcSize;
-    const BYTE* const ilimit = iend - 8;
+    const BYTE* const ilimit = (searchMethod == search_rowHash) ? iend - 8 - ZSTD_ROW_HASH_CACHE_SIZE : iend - 8;
     const BYTE* const base = ms->window.base;
     const U32 prefixLowestIndex = ms->window.dictLimit;
     const BYTE* const prefixLowest = base + prefixLowestIndex;
+    const U32 mls = BOUNDED(4, ms->cParams.minMatch, 6);
+    const U32 rowLog = BOUNDED(4, ms->cParams.searchLog, 6);
 
-    typedef size_t (*searchMax_f)(
-                        ZSTD_matchState_t* ms,
-                        const BYTE* ip, const BYTE* iLimit, size_t* offsetPtr);
-
-    /*
-     * This table is indexed first by the four ZSTD_dictMode_e values, and then
-     * by the two searchMethod_e values. NULLs are placed for configurations
-     * that should never occur (extDict modes go to the other implementation
-     * below and there is no DDSS for binary tree search yet).
-     */
-    const searchMax_f searchFuncs[4][2] = {
-        {
-            ZSTD_HcFindBestMatch_selectMLS,
-            ZSTD_BtFindBestMatch_selectMLS
-        },
-        {
-            NULL,
-            NULL
-        },
-        {
-            ZSTD_HcFindBestMatch_dictMatchState_selectMLS,
-            ZSTD_BtFindBestMatch_dictMatchState_selectMLS
-        },
-        {
-            ZSTD_HcFindBestMatch_dedicatedDictSearch_selectMLS,
-            NULL
-        }
-    };
-
-    searchMax_f const searchMax = searchFuncs[dictMode][searchMethod == search_binaryTree];
     U32 offset_1 = rep[0], offset_2 = rep[1], savedOffset=0;
 
     const int isDMS = dictMode == ZSTD_dictMatchState;
@@ -915,11 +1506,7 @@ ZSTD_compressBlock_lazy_generic(
                                      0;
     const U32 dictAndPrefixLength = (U32)((ip - prefixLowest) + (dictEnd - dictLowest));
 
-    assert(searchMax != NULL);
-
-    DEBUGLOG(5, "ZSTD_compressBlock_lazy_generic (dictMode=%u)", (U32)dictMode);
-
-    /* init */
+    DEBUGLOG(5, "ZSTD_compressBlock_lazy_generic (dictMode=%u) (searchFunc=%u)", (U32)dictMode, (U32)searchMethod);
     ip += (dictAndPrefixLength == 0);
     if (dictMode == ZSTD_noDict) {
         U32 const curr = (U32)(ip - base);
@@ -935,6 +1522,12 @@ ZSTD_compressBlock_lazy_generic(
         assert(offset_2 <= dictAndPrefixLength);
     }
 
+    if (searchMethod == search_rowHash) {
+        ZSTD_row_fillHashCache(ms, base, rowLog,
+                            MIN(ms->cParams.minMatch, 6 /* mls caps out at 6 */),
+                            ms->nextToUpdate, ilimit);
+    }
+
     /* Match Loop */
 #if defined(__x86_64__)
     /* I've measured random a 5% speed loss on levels 5 & 6 (greedy) when the
@@ -944,8 +1537,9 @@ ZSTD_compressBlock_lazy_generic(
 #endif
     while (ip < ilimit) {
         size_t matchLength=0;
-        size_t offset=0;
+        size_t offcode=STORE_REPCODE_1;
         const BYTE* start=ip+1;
+        DEBUGLOG(7, "search baseline (depth 0)");
 
         /* check repCode */
         if (isDxS) {
@@ -969,9 +1563,9 @@ ZSTD_compressBlock_lazy_generic(
 
         /* first search (depth 0) */
         {   size_t offsetFound = 999999999;
-            size_t const ml2 = searchMax(ms, ip, iend, &offsetFound);
+            size_t const ml2 = ZSTD_searchMax(ms, ip, iend, &offsetFound, mls, rowLog, searchMethod, dictMode);
             if (ml2 > matchLength)
-                matchLength = ml2, start = ip, offset=offsetFound;
+                matchLength = ml2, start = ip, offcode=offsetFound;
         }
 
         if (matchLength < 4) {
@@ -982,14 +1576,15 @@ ZSTD_compressBlock_lazy_generic(
         /* let's try to find a better solution */
         if (depth>=1)
         while (ip<ilimit) {
+            DEBUGLOG(7, "search depth 1");
             ip ++;
             if ( (dictMode == ZSTD_noDict)
-              && (offset) && ((offset_1>0) & (MEM_read32(ip) == MEM_read32(ip - offset_1)))) {
+              && (offcode) && ((offset_1>0) & (MEM_read32(ip) == MEM_read32(ip - offset_1)))) {
                 size_t const mlRep = ZSTD_count(ip+4, ip+4-offset_1, iend) + 4;
                 int const gain2 = (int)(mlRep * 3);
-                int const gain1 = (int)(matchLength*3 - ZSTD_highbit32((U32)offset+1) + 1);
+                int const gain1 = (int)(matchLength*3 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 1);
                 if ((mlRep >= 4) && (gain2 > gain1))
-                    matchLength = mlRep, offset = 0, start = ip;
+                    matchLength = mlRep, offcode = STORE_REPCODE_1, start = ip;
             }
             if (isDxS) {
                 const U32 repIndex = (U32)(ip - base) - offset_1;
@@ -1001,30 +1596,31 @@ ZSTD_compressBlock_lazy_generic(
                     const BYTE* repMatchEnd = repIndex < prefixLowestIndex ? dictEnd : iend;
                     size_t const mlRep = ZSTD_count_2segments(ip+4, repMatch+4, iend, repMatchEnd, prefixLowest) + 4;
                     int const gain2 = (int)(mlRep * 3);
-                    int const gain1 = (int)(matchLength*3 - ZSTD_highbit32((U32)offset+1) + 1);
+                    int const gain1 = (int)(matchLength*3 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 1);
                     if ((mlRep >= 4) && (gain2 > gain1))
-                        matchLength = mlRep, offset = 0, start = ip;
+                        matchLength = mlRep, offcode = STORE_REPCODE_1, start = ip;
                 }
             }
             {   size_t offset2=999999999;
-                size_t const ml2 = searchMax(ms, ip, iend, &offset2);
-                int const gain2 = (int)(ml2*4 - ZSTD_highbit32((U32)offset2+1));   /* raw approx */
-                int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)offset+1) + 4);
+                size_t const ml2 = ZSTD_searchMax(ms, ip, iend, &offset2, mls, rowLog, searchMethod, dictMode);
+                int const gain2 = (int)(ml2*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offset2)));   /* raw approx */
+                int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 4);
                 if ((ml2 >= 4) && (gain2 > gain1)) {
-                    matchLength = ml2, offset = offset2, start = ip;
+                    matchLength = ml2, offcode = offset2, start = ip;
                     continue;   /* search a better one */
             }   }
 
             /* let's find an even better one */
             if ((depth==2) && (ip<ilimit)) {
+                DEBUGLOG(7, "search depth 2");
                 ip ++;
                 if ( (dictMode == ZSTD_noDict)
-                  && (offset) && ((offset_1>0) & (MEM_read32(ip) == MEM_read32(ip - offset_1)))) {
+                  && (offcode) && ((offset_1>0) & (MEM_read32(ip) == MEM_read32(ip - offset_1)))) {
                     size_t const mlRep = ZSTD_count(ip+4, ip+4-offset_1, iend) + 4;
                     int const gain2 = (int)(mlRep * 4);
-                    int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)offset+1) + 1);
+                    int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 1);
                     if ((mlRep >= 4) && (gain2 > gain1))
-                        matchLength = mlRep, offset = 0, start = ip;
+                        matchLength = mlRep, offcode = STORE_REPCODE_1, start = ip;
                 }
                 if (isDxS) {
                     const U32 repIndex = (U32)(ip - base) - offset_1;
@@ -1036,46 +1632,45 @@ ZSTD_compressBlock_lazy_generic(
                         const BYTE* repMatchEnd = repIndex < prefixLowestIndex ? dictEnd : iend;
                         size_t const mlRep = ZSTD_count_2segments(ip+4, repMatch+4, iend, repMatchEnd, prefixLowest) + 4;
                         int const gain2 = (int)(mlRep * 4);
-                        int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)offset+1) + 1);
+                        int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 1);
                         if ((mlRep >= 4) && (gain2 > gain1))
-                            matchLength = mlRep, offset = 0, start = ip;
+                            matchLength = mlRep, offcode = STORE_REPCODE_1, start = ip;
                     }
                 }
                 {   size_t offset2=999999999;
-                    size_t const ml2 = searchMax(ms, ip, iend, &offset2);
-                    int const gain2 = (int)(ml2*4 - ZSTD_highbit32((U32)offset2+1));   /* raw approx */
-                    int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)offset+1) + 7);
+                    size_t const ml2 = ZSTD_searchMax(ms, ip, iend, &offset2, mls, rowLog, searchMethod, dictMode);
+                    int const gain2 = (int)(ml2*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offset2)));   /* raw approx */
+                    int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 7);
                     if ((ml2 >= 4) && (gain2 > gain1)) {
-                        matchLength = ml2, offset = offset2, start = ip;
+                        matchLength = ml2, offcode = offset2, start = ip;
                         continue;
             }   }   }
             break;  /* nothing found : store previous solution */
         }
 
         /* NOTE:
-         * start[-offset+ZSTD_REP_MOVE-1] is undefined behavior.
-         * (-offset+ZSTD_REP_MOVE-1) is unsigned, and is added to start, which
-         * overflows the pointer, which is undefined behavior.
+         * Pay attention that `start[-value]` can lead to strange undefined behavior
+         * notably if `value` is unsigned, resulting in a large positive `-value`.
          */
         /* catch up */
-        if (offset) {
+        if (STORED_IS_OFFSET(offcode)) {
             if (dictMode == ZSTD_noDict) {
-                while ( ((start > anchor) & (start - (offset-ZSTD_REP_MOVE) > prefixLowest))
-                     && (start[-1] == (start-(offset-ZSTD_REP_MOVE))[-1]) )  /* only search for offset within prefix */
+                while ( ((start > anchor) & (start - STORED_OFFSET(offcode) > prefixLowest))
+                     && (start[-1] == (start-STORED_OFFSET(offcode))[-1]) )  /* only search for offset within prefix */
                     { start--; matchLength++; }
             }
             if (isDxS) {
-                U32 const matchIndex = (U32)((start-base) - (offset - ZSTD_REP_MOVE));
+                U32 const matchIndex = (U32)((size_t)(start-base) - STORED_OFFSET(offcode));
                 const BYTE* match = (matchIndex < prefixLowestIndex) ? dictBase + matchIndex - dictIndexDelta : base + matchIndex;
                 const BYTE* const mStart = (matchIndex < prefixLowestIndex) ? dictLowest : prefixLowest;
                 while ((start>anchor) && (match>mStart) && (start[-1] == match[-1])) { start--; match--; matchLength++; }  /* catch up */
             }
-            offset_2 = offset_1; offset_1 = (U32)(offset - ZSTD_REP_MOVE);
+            offset_2 = offset_1; offset_1 = (U32)STORED_OFFSET(offcode);
         }
         /* store sequence */
 _storeSequence:
-        {   size_t const litLength = start - anchor;
-            ZSTD_storeSeq(seqStore, litLength, anchor, iend, (U32)offset, matchLength-MINMATCH);
+        {   size_t const litLength = (size_t)(start - anchor);
+            ZSTD_storeSeq(seqStore, litLength, anchor, iend, (U32)offcode, matchLength);
             anchor = ip = start + matchLength;
         }
 
@@ -1091,8 +1686,8 @@ ZSTD_compressBlock_lazy_generic(
                    && (MEM_read32(repMatch) == MEM_read32(ip)) ) {
                     const BYTE* const repEnd2 = repIndex < prefixLowestIndex ? dictEnd : iend;
                     matchLength = ZSTD_count_2segments(ip+4, repMatch+4, iend, repEnd2, prefixLowest) + 4;
-                    offset = offset_2; offset_2 = offset_1; offset_1 = (U32)offset;   /* swap offset_2 <=> offset_1 */
-                    ZSTD_storeSeq(seqStore, 0, anchor, iend, 0, matchLength-MINMATCH);
+                    offcode = offset_2; offset_2 = offset_1; offset_1 = (U32)offcode;   /* swap offset_2 <=> offset_1 */
+                    ZSTD_storeSeq(seqStore, 0, anchor, iend, STORE_REPCODE_1, matchLength);
                     ip += matchLength;
                     anchor = ip;
                     continue;
@@ -1106,8 +1701,8 @@ ZSTD_compressBlock_lazy_generic(
                  && (MEM_read32(ip) == MEM_read32(ip - offset_2)) ) {
                 /* store sequence */
                 matchLength = ZSTD_count(ip+4, ip+4-offset_2, iend) + 4;
-                offset = offset_2; offset_2 = offset_1; offset_1 = (U32)offset; /* swap repcodes */
-                ZSTD_storeSeq(seqStore, 0, anchor, iend, 0, matchLength-MINMATCH);
+                offcode = offset_2; offset_2 = offset_1; offset_1 = (U32)offcode; /* swap repcodes */
+                ZSTD_storeSeq(seqStore, 0, anchor, iend, STORE_REPCODE_1, matchLength);
                 ip += matchLength;
                 anchor = ip;
                 continue;   /* faster when present ... (?) */
@@ -1200,6 +1795,70 @@ size_t ZSTD_compressBlock_greedy_dedicatedDictSearch(
     return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_hashChain, 0, ZSTD_dedicatedDictSearch);
 }
 
+/* Row-based matchfinder */
+size_t ZSTD_compressBlock_lazy2_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 2, ZSTD_noDict);
+}
+
+size_t ZSTD_compressBlock_lazy_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 1, ZSTD_noDict);
+}
+
+size_t ZSTD_compressBlock_greedy_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 0, ZSTD_noDict);
+}
+
+size_t ZSTD_compressBlock_lazy2_dictMatchState_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 2, ZSTD_dictMatchState);
+}
+
+size_t ZSTD_compressBlock_lazy_dictMatchState_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 1, ZSTD_dictMatchState);
+}
+
+size_t ZSTD_compressBlock_greedy_dictMatchState_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 0, ZSTD_dictMatchState);
+}
+
+
+size_t ZSTD_compressBlock_lazy2_dedicatedDictSearch_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 2, ZSTD_dedicatedDictSearch);
+}
+
+size_t ZSTD_compressBlock_lazy_dedicatedDictSearch_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 1, ZSTD_dedicatedDictSearch);
+}
+
+size_t ZSTD_compressBlock_greedy_dedicatedDictSearch_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 0, ZSTD_dedicatedDictSearch);
+}
 
 FORCE_INLINE_TEMPLATE
 size_t ZSTD_compressBlock_lazy_extDict_generic(
@@ -1212,7 +1871,7 @@ size_t ZSTD_compressBlock_lazy_extDict_generic(
     const BYTE* ip = istart;
     const BYTE* anchor = istart;
     const BYTE* const iend = istart + srcSize;
-    const BYTE* const ilimit = iend - 8;
+    const BYTE* const ilimit = searchMethod == search_rowHash ? iend - 8 - ZSTD_ROW_HASH_CACHE_SIZE : iend - 8;
     const BYTE* const base = ms->window.base;
     const U32 dictLimit = ms->window.dictLimit;
     const BYTE* const prefixStart = base + dictLimit;
@@ -1220,18 +1879,20 @@ size_t ZSTD_compressBlock_lazy_extDict_generic(
     const BYTE* const dictEnd  = dictBase + dictLimit;
     const BYTE* const dictStart  = dictBase + ms->window.lowLimit;
     const U32 windowLog = ms->cParams.windowLog;
-
-    typedef size_t (*searchMax_f)(
-                        ZSTD_matchState_t* ms,
-                        const BYTE* ip, const BYTE* iLimit, size_t* offsetPtr);
-    searchMax_f searchMax = searchMethod==search_binaryTree ? ZSTD_BtFindBestMatch_extDict_selectMLS : ZSTD_HcFindBestMatch_extDict_selectMLS;
+    const U32 mls = BOUNDED(4, ms->cParams.minMatch, 6);
+    const U32 rowLog = BOUNDED(4, ms->cParams.searchLog, 6);
 
     U32 offset_1 = rep[0], offset_2 = rep[1];
 
-    DEBUGLOG(5, "ZSTD_compressBlock_lazy_extDict_generic");
+    DEBUGLOG(5, "ZSTD_compressBlock_lazy_extDict_generic (searchFunc=%u)", (U32)searchMethod);
 
     /* init */
     ip += (ip == prefixStart);
+    if (searchMethod == search_rowHash) {
+        ZSTD_row_fillHashCache(ms, base, rowLog,
+                               MIN(ms->cParams.minMatch, 6 /* mls caps out at 6 */),
+                               ms->nextToUpdate, ilimit);
+    }
 
     /* Match Loop */
 #if defined(__x86_64__)
@@ -1242,7 +1903,7 @@ size_t ZSTD_compressBlock_lazy_extDict_generic(
 #endif
     while (ip < ilimit) {
         size_t matchLength=0;
-        size_t offset=0;
+        size_t offcode=STORE_REPCODE_1;
         const BYTE* start=ip+1;
         U32 curr = (U32)(ip-base);
 
@@ -1251,7 +1912,8 @@ size_t ZSTD_compressBlock_lazy_extDict_generic(
             const U32 repIndex = (U32)(curr+1 - offset_1);
             const BYTE* const repBase = repIndex < dictLimit ? dictBase : base;
             const BYTE* const repMatch = repBase + repIndex;
-            if (((U32)((dictLimit-1) - repIndex) >= 3) & (repIndex > windowLow))   /* intentional overflow */
+            if ( ((U32)((dictLimit-1) - repIndex) >= 3) /* intentional overflow */
+               & (offset_1 <= curr+1 - windowLow) ) /* note: we are searching at curr+1 */
             if (MEM_read32(ip+1) == MEM_read32(repMatch)) {
                 /* repcode detected we should take it */
                 const BYTE* const repEnd = repIndex < dictLimit ? dictEnd : iend;
@@ -1261,9 +1923,9 @@ size_t ZSTD_compressBlock_lazy_extDict_generic(
 
         /* first search (depth 0) */
         {   size_t offsetFound = 999999999;
-            size_t const ml2 = searchMax(ms, ip, iend, &offsetFound);
+            size_t const ml2 = ZSTD_searchMax(ms, ip, iend, &offsetFound, mls, rowLog, searchMethod, ZSTD_extDict);
             if (ml2 > matchLength)
-                matchLength = ml2, start = ip, offset=offsetFound;
+                matchLength = ml2, start = ip, offcode=offsetFound;
         }
 
         if (matchLength < 4) {
@@ -1277,29 +1939,30 @@ size_t ZSTD_compressBlock_lazy_extDict_generic(
             ip ++;
             curr++;
             /* check repCode */
-            if (offset) {
+            if (offcode) {
                 const U32 windowLow = ZSTD_getLowestMatchIndex(ms, curr, windowLog);
                 const U32 repIndex = (U32)(curr - offset_1);
                 const BYTE* const repBase = repIndex < dictLimit ? dictBase : base;
                 const BYTE* const repMatch = repBase + repIndex;
-                if (((U32)((dictLimit-1) - repIndex) >= 3) & (repIndex > windowLow))  /* intentional overflow */
+                if ( ((U32)((dictLimit-1) - repIndex) >= 3) /* intentional overflow : do not test positions overlapping 2 memory segments  */
+                   & (offset_1 <= curr - windowLow) ) /* equivalent to `curr > repIndex >= windowLow` */
                 if (MEM_read32(ip) == MEM_read32(repMatch)) {
                     /* repcode detected */
                     const BYTE* const repEnd = repIndex < dictLimit ? dictEnd : iend;
                     size_t const repLength = ZSTD_count_2segments(ip+4, repMatch+4, iend, repEnd, prefixStart) + 4;
                     int const gain2 = (int)(repLength * 3);
-                    int const gain1 = (int)(matchLength*3 - ZSTD_highbit32((U32)offset+1) + 1);
+                    int const gain1 = (int)(matchLength*3 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 1);
                     if ((repLength >= 4) && (gain2 > gain1))
-                        matchLength = repLength, offset = 0, start = ip;
+                        matchLength = repLength, offcode = STORE_REPCODE_1, start = ip;
             }   }
 
             /* search match, depth 1 */
             {   size_t offset2=999999999;
-                size_t const ml2 = searchMax(ms, ip, iend, &offset2);
-                int const gain2 = (int)(ml2*4 - ZSTD_highbit32((U32)offset2+1));   /* raw approx */
-                int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)offset+1) + 4);
+                size_t const ml2 = ZSTD_searchMax(ms, ip, iend, &offset2, mls, rowLog, searchMethod, ZSTD_extDict);
+                int const gain2 = (int)(ml2*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offset2)));   /* raw approx */
+                int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 4);
                 if ((ml2 >= 4) && (gain2 > gain1)) {
-                    matchLength = ml2, offset = offset2, start = ip;
+                    matchLength = ml2, offcode = offset2, start = ip;
                     continue;   /* search a better one */
             }   }
 
@@ -1308,47 +1971,48 @@ size_t ZSTD_compressBlock_lazy_extDict_generic(
                 ip ++;
                 curr++;
                 /* check repCode */
-                if (offset) {
+                if (offcode) {
                     const U32 windowLow = ZSTD_getLowestMatchIndex(ms, curr, windowLog);
                     const U32 repIndex = (U32)(curr - offset_1);
                     const BYTE* const repBase = repIndex < dictLimit ? dictBase : base;
                     const BYTE* const repMatch = repBase + repIndex;
-                    if (((U32)((dictLimit-1) - repIndex) >= 3) & (repIndex > windowLow))  /* intentional overflow */
+                    if ( ((U32)((dictLimit-1) - repIndex) >= 3) /* intentional overflow : do not test positions overlapping 2 memory segments  */
+                       & (offset_1 <= curr - windowLow) ) /* equivalent to `curr > repIndex >= windowLow` */
                     if (MEM_read32(ip) == MEM_read32(repMatch)) {
                         /* repcode detected */
                         const BYTE* const repEnd = repIndex < dictLimit ? dictEnd : iend;
                         size_t const repLength = ZSTD_count_2segments(ip+4, repMatch+4, iend, repEnd, prefixStart) + 4;
                         int const gain2 = (int)(repLength * 4);
-                        int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)offset+1) + 1);
+                        int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 1);
                         if ((repLength >= 4) && (gain2 > gain1))
-                            matchLength = repLength, offset = 0, start = ip;
+                            matchLength = repLength, offcode = STORE_REPCODE_1, start = ip;
                 }   }
 
                 /* search match, depth 2 */
                 {   size_t offset2=999999999;
-                    size_t const ml2 = searchMax(ms, ip, iend, &offset2);
-                    int const gain2 = (int)(ml2*4 - ZSTD_highbit32((U32)offset2+1));   /* raw approx */
-                    int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)offset+1) + 7);
+                    size_t const ml2 = ZSTD_searchMax(ms, ip, iend, &offset2, mls, rowLog, searchMethod, ZSTD_extDict);
+                    int const gain2 = (int)(ml2*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offset2)));   /* raw approx */
+                    int const gain1 = (int)(matchLength*4 - ZSTD_highbit32((U32)STORED_TO_OFFBASE(offcode)) + 7);
                     if ((ml2 >= 4) && (gain2 > gain1)) {
-                        matchLength = ml2, offset = offset2, start = ip;
+                        matchLength = ml2, offcode = offset2, start = ip;
                         continue;
             }   }   }
             break;  /* nothing found : store previous solution */
         }
 
         /* catch up */
-        if (offset) {
-            U32 const matchIndex = (U32)((start-base) - (offset - ZSTD_REP_MOVE));
+        if (STORED_IS_OFFSET(offcode)) {
+            U32 const matchIndex = (U32)((size_t)(start-base) - STORED_OFFSET(offcode));
             const BYTE* match = (matchIndex < dictLimit) ? dictBase + matchIndex : base + matchIndex;
             const BYTE* const mStart = (matchIndex < dictLimit) ? dictStart : prefixStart;
             while ((start>anchor) && (match>mStart) && (start[-1] == match[-1])) { start--; match--; matchLength++; }  /* catch up */
-            offset_2 = offset_1; offset_1 = (U32)(offset - ZSTD_REP_MOVE);
+            offset_2 = offset_1; offset_1 = (U32)STORED_OFFSET(offcode);
         }
 
         /* store sequence */
 _storeSequence:
-        {   size_t const litLength = start - anchor;
-            ZSTD_storeSeq(seqStore, litLength, anchor, iend, (U32)offset, matchLength-MINMATCH);
+        {   size_t const litLength = (size_t)(start - anchor);
+            ZSTD_storeSeq(seqStore, litLength, anchor, iend, (U32)offcode, matchLength);
             anchor = ip = start + matchLength;
         }
 
@@ -1359,13 +2023,14 @@ size_t ZSTD_compressBlock_lazy_extDict_generic(
             const U32 repIndex = repCurrent - offset_2;
             const BYTE* const repBase = repIndex < dictLimit ? dictBase : base;
             const BYTE* const repMatch = repBase + repIndex;
-            if (((U32)((dictLimit-1) - repIndex) >= 3) & (repIndex > windowLow))  /* intentional overflow */
+            if ( ((U32)((dictLimit-1) - repIndex) >= 3) /* intentional overflow : do not test positions overlapping 2 memory segments  */
+               & (offset_2 <= repCurrent - windowLow) ) /* equivalent to `curr > repIndex >= windowLow` */
             if (MEM_read32(ip) == MEM_read32(repMatch)) {
                 /* repcode detected we should take it */
                 const BYTE* const repEnd = repIndex < dictLimit ? dictEnd : iend;
                 matchLength = ZSTD_count_2segments(ip+4, repMatch+4, iend, repEnd, prefixStart) + 4;
-                offset = offset_2; offset_2 = offset_1; offset_1 = (U32)offset;   /* swap offset history */
-                ZSTD_storeSeq(seqStore, 0, anchor, iend, 0, matchLength-MINMATCH);
+                offcode = offset_2; offset_2 = offset_1; offset_1 = (U32)offcode;   /* swap offset history */
+                ZSTD_storeSeq(seqStore, 0, anchor, iend, STORE_REPCODE_1, matchLength);
                 ip += matchLength;
                 anchor = ip;
                 continue;   /* faster when present ... (?) */
@@ -1412,3 +2077,26 @@ size_t ZSTD_compressBlock_btlazy2_extDict(
 {
     return ZSTD_compressBlock_lazy_extDict_generic(ms, seqStore, rep, src, srcSize, search_binaryTree, 2);
 }
+
+size_t ZSTD_compressBlock_greedy_extDict_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+{
+    return ZSTD_compressBlock_lazy_extDict_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 0);
+}
+
+size_t ZSTD_compressBlock_lazy_extDict_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+
+{
+    return ZSTD_compressBlock_lazy_extDict_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 1);
+}
+
+size_t ZSTD_compressBlock_lazy2_extDict_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize)
+
+{
+    return ZSTD_compressBlock_lazy_extDict_generic(ms, seqStore, rep, src, srcSize, search_rowHash, 2);
+}
diff --git a/lib/zstd/compress/zstd_lazy.h b/lib/zstd/compress/zstd_lazy.h
index 2fc5a6182134..e5bdf4df8dde 100644
--- a/lib/zstd/compress/zstd_lazy.h
+++ b/lib/zstd/compress/zstd_lazy.h
@@ -23,6 +23,7 @@
 #define ZSTD_LAZY_DDSS_BUCKET_LOG 2
 
 U32 ZSTD_insertAndFindFirstIndex(ZSTD_matchState_t* ms, const BYTE* ip);
+void ZSTD_row_update(ZSTD_matchState_t* const ms, const BYTE* ip);
 
 void ZSTD_dedicatedDictSearch_lazy_loadDictionary(ZSTD_matchState_t* ms, const BYTE* const ip);
 
@@ -40,6 +41,15 @@ size_t ZSTD_compressBlock_lazy(
 size_t ZSTD_compressBlock_greedy(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_lazy2_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_lazy_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_greedy_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
 
 size_t ZSTD_compressBlock_btlazy2_dictMatchState(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
@@ -53,6 +63,15 @@ size_t ZSTD_compressBlock_lazy_dictMatchState(
 size_t ZSTD_compressBlock_greedy_dictMatchState(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_lazy2_dictMatchState_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_lazy_dictMatchState_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_greedy_dictMatchState_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
 
 size_t ZSTD_compressBlock_lazy2_dedicatedDictSearch(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
@@ -63,6 +82,15 @@ size_t ZSTD_compressBlock_lazy_dedicatedDictSearch(
 size_t ZSTD_compressBlock_greedy_dedicatedDictSearch(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_lazy2_dedicatedDictSearch_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_lazy_dedicatedDictSearch_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_greedy_dedicatedDictSearch_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
 
 size_t ZSTD_compressBlock_greedy_extDict(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
@@ -73,9 +101,19 @@ size_t ZSTD_compressBlock_lazy_extDict(
 size_t ZSTD_compressBlock_lazy2_extDict(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_greedy_extDict_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_lazy_extDict_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
+size_t ZSTD_compressBlock_lazy2_extDict_row(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        void const* src, size_t srcSize);
 size_t ZSTD_compressBlock_btlazy2_extDict(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         void const* src, size_t srcSize);
+        
 
 
 #endif /* ZSTD_LAZY_H */
diff --git a/lib/zstd/compress/zstd_ldm.c b/lib/zstd/compress/zstd_ldm.c
index 8ef7e88a5add..dd86fc83e7dd 100644
--- a/lib/zstd/compress/zstd_ldm.c
+++ b/lib/zstd/compress/zstd_ldm.c
@@ -57,6 +57,33 @@ static void ZSTD_ldm_gear_init(ldmRollingHashState_t* state, ldmParams_t const*
     }
 }
 
+/* ZSTD_ldm_gear_reset()
+ * Feeds [data, data + minMatchLength) into the hash without registering any
+ * splits. This effectively resets the hash state. This is used when skipping
+ * over data, either at the beginning of a block, or skipping sections.
+ */
+static void ZSTD_ldm_gear_reset(ldmRollingHashState_t* state,
+                                BYTE const* data, size_t minMatchLength)
+{
+    U64 hash = state->rolling;
+    size_t n = 0;
+
+#define GEAR_ITER_ONCE() do {                                  \
+        hash = (hash << 1) + ZSTD_ldm_gearTab[data[n] & 0xff]; \
+        n += 1;                                                \
+    } while (0)
+    while (n + 3 < minMatchLength) {
+        GEAR_ITER_ONCE();
+        GEAR_ITER_ONCE();
+        GEAR_ITER_ONCE();
+        GEAR_ITER_ONCE();
+    }
+    while (n < minMatchLength) {
+        GEAR_ITER_ONCE();
+    }
+#undef GEAR_ITER_ONCE
+}
+
 /* ZSTD_ldm_gear_feed():
  *
  * Registers in the splits array all the split points found in the first
@@ -132,12 +159,12 @@ size_t ZSTD_ldm_getTableSize(ldmParams_t params)
     size_t const ldmBucketSize = ((size_t)1) << (params.hashLog - ldmBucketSizeLog);
     size_t const totalSize = ZSTD_cwksp_alloc_size(ldmBucketSize)
                            + ZSTD_cwksp_alloc_size(ldmHSize * sizeof(ldmEntry_t));
-    return params.enableLdm ? totalSize : 0;
+    return params.enableLdm == ZSTD_ps_enable ? totalSize : 0;
 }
 
 size_t ZSTD_ldm_getMaxNbSeq(ldmParams_t params, size_t maxChunkSize)
 {
-    return params.enableLdm ? (maxChunkSize / params.minMatchLength) : 0;
+    return params.enableLdm == ZSTD_ps_enable ? (maxChunkSize / params.minMatchLength) : 0;
 }
 
 /* ZSTD_ldm_getBucket() :
@@ -255,7 +282,7 @@ void ZSTD_ldm_fillHashTable(
     while (ip < iend) {
         size_t hashed;
         unsigned n;
-        
+
         numSplits = 0;
         hashed = ZSTD_ldm_gear_feed(&hashState, ip, iend - ip, splits, &numSplits);
 
@@ -327,16 +354,8 @@ static size_t ZSTD_ldm_generateSequences_internal(
 
     /* Initialize the rolling hash state with the first minMatchLength bytes */
     ZSTD_ldm_gear_init(&hashState, params);
-    {
-        size_t n = 0;
-
-        while (n < minMatchLength) {
-            numSplits = 0;
-            n += ZSTD_ldm_gear_feed(&hashState, ip + n, minMatchLength - n,
-                                    splits, &numSplits);
-        }
-        ip += minMatchLength;
-    }
+    ZSTD_ldm_gear_reset(&hashState, ip, minMatchLength);
+    ip += minMatchLength;
 
     while (ip < ilimit) {
         size_t hashed;
@@ -361,6 +380,7 @@ static size_t ZSTD_ldm_generateSequences_internal(
         for (n = 0; n < numSplits; n++) {
             size_t forwardMatchLength = 0, backwardMatchLength = 0,
                    bestMatchLength = 0, mLength;
+            U32 offset;
             BYTE const* const split = candidates[n].split;
             U32 const checksum = candidates[n].checksum;
             U32 const hash = candidates[n].hash;
@@ -428,9 +448,9 @@ static size_t ZSTD_ldm_generateSequences_internal(
             }
 
             /* Match found */
+            offset = (U32)(split - base) - bestEntry->offset;
             mLength = forwardMatchLength + backwardMatchLength;
             {
-                U32 const offset = (U32)(split - base) - bestEntry->offset;
                 rawSeq* const seq = rawSeqStore->seq + rawSeqStore->size;
 
                 /* Out of sequence storage */
@@ -447,6 +467,21 @@ static size_t ZSTD_ldm_generateSequences_internal(
             ZSTD_ldm_insertEntry(ldmState, hash, newEntry, *params);
 
             anchor = split + forwardMatchLength;
+
+            /* If we find a match that ends after the data that we've hashed
+             * then we have a repeating, overlapping, pattern. E.g. all zeros.
+             * If one repetition of the pattern matches our `stopMask` then all
+             * repetitions will. We don't need to insert them all into out table,
+             * only the first one. So skip over overlapping matches.
+             * This is a major speed boost (20x) for compressing a single byte
+             * repeated, when that byte ends up in the table.
+             */
+            if (anchor > ip + hashed) {
+                ZSTD_ldm_gear_reset(&hashState, anchor - minMatchLength, minMatchLength);
+                /* Continue the outer loop at anchor (ip + hashed == anchor). */
+                ip = anchor - hashed;
+                break;
+            }
         }
 
         ip += hashed;
@@ -500,7 +535,7 @@ size_t ZSTD_ldm_generateSequences(
 
         assert(chunkStart < iend);
         /* 1. Perform overflow correction if necessary. */
-        if (ZSTD_window_needOverflowCorrection(ldmState->window, chunkEnd)) {
+        if (ZSTD_window_needOverflowCorrection(ldmState->window, 0, maxDist, ldmState->loadedDictEnd, chunkStart, chunkEnd)) {
             U32 const ldmHSize = 1U << params->hashLog;
             U32 const correction = ZSTD_window_correctOverflow(
                 &ldmState->window, /* cycleLog */ 0, maxDist, chunkStart);
@@ -544,7 +579,9 @@ size_t ZSTD_ldm_generateSequences(
     return 0;
 }
 
-void ZSTD_ldm_skipSequences(rawSeqStore_t* rawSeqStore, size_t srcSize, U32 const minMatch) {
+void
+ZSTD_ldm_skipSequences(rawSeqStore_t* rawSeqStore, size_t srcSize, U32 const minMatch)
+{
     while (srcSize > 0 && rawSeqStore->pos < rawSeqStore->size) {
         rawSeq* seq = rawSeqStore->seq + rawSeqStore->pos;
         if (srcSize <= seq->litLength) {
@@ -622,12 +659,13 @@ void ZSTD_ldm_skipRawSeqStoreBytes(rawSeqStore_t* rawSeqStore, size_t nbBytes) {
 
 size_t ZSTD_ldm_blockCompress(rawSeqStore_t* rawSeqStore,
     ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+    ZSTD_paramSwitch_e useRowMatchFinder,
     void const* src, size_t srcSize)
 {
     const ZSTD_compressionParameters* const cParams = &ms->cParams;
     unsigned const minMatch = cParams->minMatch;
     ZSTD_blockCompressor const blockCompressor =
-        ZSTD_selectBlockCompressor(cParams->strategy, ZSTD_matchState_dictMode(ms));
+        ZSTD_selectBlockCompressor(cParams->strategy, useRowMatchFinder, ZSTD_matchState_dictMode(ms));
     /* Input bounds */
     BYTE const* const istart = (BYTE const*)src;
     BYTE const* const iend = istart + srcSize;
@@ -673,8 +711,8 @@ size_t ZSTD_ldm_blockCompress(rawSeqStore_t* rawSeqStore,
             rep[0] = sequence.offset;
             /* Store the sequence */
             ZSTD_storeSeq(seqStore, newLitLength, ip - newLitLength, iend,
-                          sequence.offset + ZSTD_REP_MOVE,
-                          sequence.matchLength - MINMATCH);
+                          STORE_OFFSET(sequence.offset),
+                          sequence.matchLength);
             ip += sequence.matchLength;
         }
     }
diff --git a/lib/zstd/compress/zstd_ldm.h b/lib/zstd/compress/zstd_ldm.h
index 25b25270b72e..fbc6a5e88fd7 100644
--- a/lib/zstd/compress/zstd_ldm.h
+++ b/lib/zstd/compress/zstd_ldm.h
@@ -63,6 +63,7 @@ size_t ZSTD_ldm_generateSequences(
  */
 size_t ZSTD_ldm_blockCompress(rawSeqStore_t* rawSeqStore,
             ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+            ZSTD_paramSwitch_e useRowMatchFinder,
             void const* src, size_t srcSize);
 
 /*
diff --git a/lib/zstd/compress/zstd_ldm_geartab.h b/lib/zstd/compress/zstd_ldm_geartab.h
index e5c24d856b0a..647f865be290 100644
--- a/lib/zstd/compress/zstd_ldm_geartab.h
+++ b/lib/zstd/compress/zstd_ldm_geartab.h
@@ -11,7 +11,10 @@
 #ifndef ZSTD_LDM_GEARTAB_H
 #define ZSTD_LDM_GEARTAB_H
 
-static U64 ZSTD_ldm_gearTab[256] = {
+#include "../common/compiler.h" /* UNUSED_ATTR */
+#include "../common/mem.h"      /* U64 */
+
+static UNUSED_ATTR const U64 ZSTD_ldm_gearTab[256] = {
     0xf5b8f72c5f77775c, 0x84935f266b7ac412, 0xb647ada9ca730ccc,
     0xb065bb4b114fb1de, 0x34584e7e8c3a9fd0, 0x4e97e17c6ae26b05,
     0x3a03d743bc99a604, 0xcecd042422c4044f, 0x76de76c58524259e,
diff --git a/lib/zstd/compress/zstd_opt.c b/lib/zstd/compress/zstd_opt.c
index dfc55e3e8119..fd82acfda62f 100644
--- a/lib/zstd/compress/zstd_opt.c
+++ b/lib/zstd/compress/zstd_opt.c
@@ -8,25 +8,12 @@
  * You may select, at your option, one of the above-listed licenses.
  */
 
-/*
- * Disable inlining for the optimal parser for the kernel build.
- * It is unlikely to be used in the kernel, and where it is used
- * latency shouldn't matter because it is very slow to begin with.
- * We prefer a ~180KB binary size win over faster optimal parsing.
- *
- * TODO(https://github.com/facebook/zstd/issues/2862):
- * Improve the code size of the optimal parser in general, so we
- * don't need this hack for the kernel build.
- */
-#define ZSTD_NO_INLINE 1
-
 #include "zstd_compress_internal.h"
 #include "hist.h"
 #include "zstd_opt.h"
 
 
 #define ZSTD_LITFREQ_ADD    2   /* scaling factor for litFreq, so that frequencies adapt faster to new stats */
-#define ZSTD_FREQ_DIV       4   /* log factor when using previous stats to init next stats */
 #define ZSTD_MAX_PRICE     (1<<30)
 
 #define ZSTD_PREDEF_THRESHOLD 1024   /* if srcSize < ZSTD_PREDEF_THRESHOLD, symbols' cost is assumed static, directly determined by pre-defined distributions */
@@ -36,11 +23,11 @@
 *  Price functions for optimal parser
 ***************************************/
 
-#if 0    /* approximation at bit level */
+#if 0    /* approximation at bit level (for tests) */
 #  define BITCOST_ACCURACY 0
 #  define BITCOST_MULTIPLIER (1 << BITCOST_ACCURACY)
-#  define WEIGHT(stat)  ((void)opt, ZSTD_bitWeight(stat))
-#elif 0  /* fractional bit accuracy */
+#  define WEIGHT(stat, opt) ((void)opt, ZSTD_bitWeight(stat))
+#elif 0  /* fractional bit accuracy (for tests) */
 #  define BITCOST_ACCURACY 8
 #  define BITCOST_MULTIPLIER (1 << BITCOST_ACCURACY)
 #  define WEIGHT(stat,opt) ((void)opt, ZSTD_fracWeight(stat))
@@ -78,7 +65,7 @@ MEM_STATIC double ZSTD_fCost(U32 price)
 
 static int ZSTD_compressedLiterals(optState_t const* const optPtr)
 {
-    return optPtr->literalCompressionMode != ZSTD_lcm_uncompressed;
+    return optPtr->literalCompressionMode != ZSTD_ps_disable;
 }
 
 static void ZSTD_setBasePrices(optState_t* optPtr, int optLevel)
@@ -91,25 +78,46 @@ static void ZSTD_setBasePrices(optState_t* optPtr, int optLevel)
 }
 
 
-/* ZSTD_downscaleStat() :
- * reduce all elements in table by a factor 2^(ZSTD_FREQ_DIV+malus)
- * return the resulting sum of elements */
-static U32 ZSTD_downscaleStat(unsigned* table, U32 lastEltIndex, int malus)
+static U32 sum_u32(const unsigned table[], size_t nbElts)
+{
+    size_t n;
+    U32 total = 0;
+    for (n=0; n<nbElts; n++) {
+        total += table[n];
+    }
+    return total;
+}
+
+static U32 ZSTD_downscaleStats(unsigned* table, U32 lastEltIndex, U32 shift)
 {
     U32 s, sum=0;
-    DEBUGLOG(5, "ZSTD_downscaleStat (nbElts=%u)", (unsigned)lastEltIndex+1);
-    assert(ZSTD_FREQ_DIV+malus > 0 && ZSTD_FREQ_DIV+malus < 31);
+    DEBUGLOG(5, "ZSTD_downscaleStats (nbElts=%u, shift=%u)", (unsigned)lastEltIndex+1, (unsigned)shift);
+    assert(shift < 30);
     for (s=0; s<lastEltIndex+1; s++) {
-        table[s] = 1 + (table[s] >> (ZSTD_FREQ_DIV+malus));
+        table[s] = 1 + (table[s] >> shift);
         sum += table[s];
     }
     return sum;
 }
 
+/* ZSTD_scaleStats() :
+ * reduce all elements in table is sum too large
+ * return the resulting sum of elements */
+static U32 ZSTD_scaleStats(unsigned* table, U32 lastEltIndex, U32 logTarget)
+{
+    U32 const prevsum = sum_u32(table, lastEltIndex+1);
+    U32 const factor = prevsum >> logTarget;
+    DEBUGLOG(5, "ZSTD_scaleStats (nbElts=%u, target=%u)", (unsigned)lastEltIndex+1, (unsigned)logTarget);
+    assert(logTarget < 30);
+    if (factor <= 1) return prevsum;
+    return ZSTD_downscaleStats(table, lastEltIndex, ZSTD_highbit32(factor));
+}
+
 /* ZSTD_rescaleFreqs() :
  * if first block (detected by optPtr->litLengthSum == 0) : init statistics
  *    take hints from dictionary if there is one
- *    or init from zero, using src for literals stats, or flat 1 for match symbols
+ *    and init from zero if there is none,
+ *    using src for literals stats, and baseline stats for sequence symbols
  * otherwise downscale existing stats, to be used as seed for next block.
  */
 static void
@@ -138,7 +146,7 @@ ZSTD_rescaleFreqs(optState_t* const optPtr,
                 optPtr->litSum = 0;
                 for (lit=0; lit<=MaxLit; lit++) {
                     U32 const scaleLog = 11;   /* scale to 2K */
-                    U32 const bitCost = HUF_getNbBits(optPtr->symbolCosts->huf.CTable, lit);
+                    U32 const bitCost = HUF_getNbBitsFromCTable(optPtr->symbolCosts->huf.CTable, lit);
                     assert(bitCost <= scaleLog);
                     optPtr->litFreq[lit] = bitCost ? 1 << (scaleLog-bitCost) : 1 /*minimum to calculate cost*/;
                     optPtr->litSum += optPtr->litFreq[lit];
@@ -186,14 +194,19 @@ ZSTD_rescaleFreqs(optState_t* const optPtr,
             if (compressedLiterals) {
                 unsigned lit = MaxLit;
                 HIST_count_simple(optPtr->litFreq, &lit, src, srcSize);   /* use raw first block to init statistics */
-                optPtr->litSum = ZSTD_downscaleStat(optPtr->litFreq, MaxLit, 1);
+                optPtr->litSum = ZSTD_downscaleStats(optPtr->litFreq, MaxLit, 8);
             }
 
-            {   unsigned ll;
-                for (ll=0; ll<=MaxLL; ll++)
-                    optPtr->litLengthFreq[ll] = 1;
+            {   unsigned const baseLLfreqs[MaxLL+1] = {
+                    4, 2, 1, 1, 1, 1, 1, 1,
+                    1, 1, 1, 1, 1, 1, 1, 1,
+                    1, 1, 1, 1, 1, 1, 1, 1,
+                    1, 1, 1, 1, 1, 1, 1, 1,
+                    1, 1, 1, 1
+                };
+                ZSTD_memcpy(optPtr->litLengthFreq, baseLLfreqs, sizeof(baseLLfreqs));
+                optPtr->litLengthSum = sum_u32(baseLLfreqs, MaxLL+1);
             }
-            optPtr->litLengthSum = MaxLL+1;
 
             {   unsigned ml;
                 for (ml=0; ml<=MaxML; ml++)
@@ -201,21 +214,26 @@ ZSTD_rescaleFreqs(optState_t* const optPtr,
             }
             optPtr->matchLengthSum = MaxML+1;
 
-            {   unsigned of;
-                for (of=0; of<=MaxOff; of++)
-                    optPtr->offCodeFreq[of] = 1;
+            {   unsigned const baseOFCfreqs[MaxOff+1] = {
+                    6, 2, 1, 1, 2, 3, 4, 4,
+                    4, 3, 2, 1, 1, 1, 1, 1,
+                    1, 1, 1, 1, 1, 1, 1, 1,
+                    1, 1, 1, 1, 1, 1, 1, 1
+                };
+                ZSTD_memcpy(optPtr->offCodeFreq, baseOFCfreqs, sizeof(baseOFCfreqs));
+                optPtr->offCodeSum = sum_u32(baseOFCfreqs, MaxOff+1);
             }
-            optPtr->offCodeSum = MaxOff+1;
+
 
         }
 
     } else {   /* new block : re-use previous statistics, scaled down */
 
         if (compressedLiterals)
-            optPtr->litSum = ZSTD_downscaleStat(optPtr->litFreq, MaxLit, 1);
-        optPtr->litLengthSum = ZSTD_downscaleStat(optPtr->litLengthFreq, MaxLL, 0);
-        optPtr->matchLengthSum = ZSTD_downscaleStat(optPtr->matchLengthFreq, MaxML, 0);
-        optPtr->offCodeSum = ZSTD_downscaleStat(optPtr->offCodeFreq, MaxOff, 0);
+            optPtr->litSum = ZSTD_scaleStats(optPtr->litFreq, MaxLit, 12);
+        optPtr->litLengthSum = ZSTD_scaleStats(optPtr->litLengthFreq, MaxLL, 11);
+        optPtr->matchLengthSum = ZSTD_scaleStats(optPtr->matchLengthFreq, MaxML, 11);
+        optPtr->offCodeSum = ZSTD_scaleStats(optPtr->offCodeFreq, MaxOff, 11);
     }
 
     ZSTD_setBasePrices(optPtr, optLevel);
@@ -251,7 +269,16 @@ static U32 ZSTD_rawLiteralsCost(const BYTE* const literals, U32 const litLength,
  * cost of literalLength symbol */
 static U32 ZSTD_litLengthPrice(U32 const litLength, const optState_t* const optPtr, int optLevel)
 {
-    if (optPtr->priceType == zop_predef) return WEIGHT(litLength, optLevel);
+    assert(litLength <= ZSTD_BLOCKSIZE_MAX);
+    if (optPtr->priceType == zop_predef)
+        return WEIGHT(litLength, optLevel);
+    /* We can't compute the litLength price for sizes >= ZSTD_BLOCKSIZE_MAX
+     * because it isn't representable in the zstd format. So instead just
+     * call it 1 bit more than ZSTD_BLOCKSIZE_MAX - 1. In this case the block
+     * would be all literals.
+     */
+    if (litLength == ZSTD_BLOCKSIZE_MAX)
+        return BITCOST_MULTIPLIER + ZSTD_litLengthPrice(ZSTD_BLOCKSIZE_MAX - 1, optPtr, optLevel);
 
     /* dynamic statistics */
     {   U32 const llCode = ZSTD_LLcode(litLength);
@@ -264,15 +291,17 @@ static U32 ZSTD_litLengthPrice(U32 const litLength, const optState_t* const optP
 /* ZSTD_getMatchPrice() :
  * Provides the cost of the match part (offset + matchLength) of a sequence
  * Must be combined with ZSTD_fullLiteralsCost() to get the full cost of a sequence.
- * optLevel: when <2, favors small offset for decompression speed (improved cache efficiency) */
+ * @offcode : expects a scale where 0,1,2 are repcodes 1-3, and 3+ are real_offsets+2
+ * @optLevel: when <2, favors small offset for decompression speed (improved cache efficiency)
+ */
 FORCE_INLINE_TEMPLATE U32
-ZSTD_getMatchPrice(U32 const offset,
+ZSTD_getMatchPrice(U32 const offcode,
                    U32 const matchLength,
              const optState_t* const optPtr,
                    int const optLevel)
 {
     U32 price;
-    U32 const offCode = ZSTD_highbit32(offset+1);
+    U32 const offCode = ZSTD_highbit32(STORED_TO_OFFBASE(offcode));
     U32 const mlBase = matchLength - MINMATCH;
     assert(matchLength >= MINMATCH);
 
@@ -315,8 +344,8 @@ static void ZSTD_updateStats(optState_t* const optPtr,
         optPtr->litLengthSum++;
     }
 
-    /* match offset code (0-2=>repCode; 3+=>offset+2) */
-    {   U32 const offCode = ZSTD_highbit32(offsetCode+1);
+    /* offset code : expected to follow storeSeq() numeric representation */
+    {   U32 const offCode = ZSTD_highbit32(STORED_TO_OFFBASE(offsetCode));
         assert(offCode <= MaxOff);
         optPtr->offCodeFreq[offCode]++;
         optPtr->offCodeSum++;
@@ -350,7 +379,7 @@ MEM_STATIC U32 ZSTD_readMINMATCH(const void* memPtr, U32 length)
 
 /* Update hashTable3 up to ip (excluded)
    Assumption : always within prefix (i.e. not within extDict) */
-static U32 ZSTD_insertAndFindFirstIndexHash3 (ZSTD_matchState_t* ms,
+static U32 ZSTD_insertAndFindFirstIndexHash3 (const ZSTD_matchState_t* ms,
                                               U32* nextToUpdate3,
                                               const BYTE* const ip)
 {
@@ -376,11 +405,13 @@ static U32 ZSTD_insertAndFindFirstIndexHash3 (ZSTD_matchState_t* ms,
 *  Binary Tree search
 ***************************************/
 /* ZSTD_insertBt1() : add one or multiple positions to tree.
- *  ip : assumed <= iend-8 .
+ * @param ip assumed <= iend-8 .
+ * @param target The target of ZSTD_updateTree_internal() - we are filling to this position
  * @return : nb of positions added */
 static U32 ZSTD_insertBt1(
-                ZSTD_matchState_t* ms,
+                const ZSTD_matchState_t* ms,
                 const BYTE* const ip, const BYTE* const iend,
+                U32 const target,
                 U32 const mls, const int extDict)
 {
     const ZSTD_compressionParameters* const cParams = &ms->cParams;
@@ -403,7 +434,10 @@ static U32 ZSTD_insertBt1(
     U32* smallerPtr = bt + 2*(curr&btMask);
     U32* largerPtr  = smallerPtr + 1;
     U32 dummy32;   /* to be nullified at the end */
-    U32 const windowLow = ms->window.lowLimit;
+    /* windowLow is based on target because
+     * we only need positions that will be in the window at the end of the tree update.
+     */
+    U32 const windowLow = ZSTD_getLowestMatchIndex(ms, target, cParams->windowLog);
     U32 matchEndIdx = curr+8+1;
     size_t bestLength = 8;
     U32 nbCompares = 1U << cParams->searchLog;
@@ -416,6 +450,7 @@ static U32 ZSTD_insertBt1(
 
     DEBUGLOG(8, "ZSTD_insertBt1 (%u)", curr);
 
+    assert(curr <= target);
     assert(ip <= iend-8);   /* required for h calculation */
     hashTable[h] = curr;   /* Update Hash Table */
 
@@ -504,7 +539,7 @@ void ZSTD_updateTree_internal(
                 idx, target, dictMode);
 
     while(idx < target) {
-        U32 const forward = ZSTD_insertBt1(ms, base+idx, iend, mls, dictMode == ZSTD_extDict);
+        U32 const forward = ZSTD_insertBt1(ms, base+idx, iend, target, mls, dictMode == ZSTD_extDict);
         assert(idx < (U32)(idx + forward));
         idx += forward;
     }
@@ -609,7 +644,7 @@ U32 ZSTD_insertBtAndGetAllMatches (
                 DEBUGLOG(8, "found repCode %u (ll0:%u, offset:%u) of length %u",
                             repCode, ll0, repOffset, repLen);
                 bestLength = repLen;
-                matches[mnum].off = repCode - ll0;
+                matches[mnum].off = STORE_REPCODE(repCode - ll0 + 1);  /* expect value between 1 and 3 */
                 matches[mnum].len = (U32)repLen;
                 mnum++;
                 if ( (repLen > sufficient_len)
@@ -638,7 +673,7 @@ U32 ZSTD_insertBtAndGetAllMatches (
                 bestLength = mlen;
                 assert(curr > matchIndex3);
                 assert(mnum==0);  /* no prior solution */
-                matches[0].off = (curr - matchIndex3) + ZSTD_REP_MOVE;
+                matches[0].off = STORE_OFFSET(curr - matchIndex3);
                 matches[0].len = (U32)mlen;
                 mnum = 1;
                 if ( (mlen > sufficient_len) |
@@ -647,7 +682,7 @@ U32 ZSTD_insertBtAndGetAllMatches (
                     return 1;
         }   }   }
         /* no dictMatchState lookup: dicts don't have a populated HC3 table */
-    }
+    }  /* if (mls == 3) */
 
     hashTable[h] = curr;   /* Update Hash Table */
 
@@ -672,20 +707,19 @@ U32 ZSTD_insertBtAndGetAllMatches (
 
         if (matchLength > bestLength) {
             DEBUGLOG(8, "found match of length %u at distance %u (offCode=%u)",
-                    (U32)matchLength, curr - matchIndex, curr - matchIndex + ZSTD_REP_MOVE);
+                    (U32)matchLength, curr - matchIndex, STORE_OFFSET(curr - matchIndex));
             assert(matchEndIdx > matchIndex);
             if (matchLength > matchEndIdx - matchIndex)
                 matchEndIdx = matchIndex + (U32)matchLength;
             bestLength = matchLength;
-            matches[mnum].off = (curr - matchIndex) + ZSTD_REP_MOVE;
+            matches[mnum].off = STORE_OFFSET(curr - matchIndex);
             matches[mnum].len = (U32)matchLength;
             mnum++;
             if ( (matchLength > ZSTD_OPT_NUM)
                | (ip+matchLength == iLimit) /* equal : no way to know if inf or sup */) {
                 if (dictMode == ZSTD_dictMatchState) nbCompares = 0; /* break should also skip searching dms */
                 break; /* drop, to preserve bt consistency (miss a little bit of compression) */
-            }
-        }
+        }   }
 
         if (match[matchLength] < ip[matchLength]) {
             /* match smaller than current */
@@ -721,18 +755,17 @@ U32 ZSTD_insertBtAndGetAllMatches (
             if (matchLength > bestLength) {
                 matchIndex = dictMatchIndex + dmsIndexDelta;
                 DEBUGLOG(8, "found dms match of length %u at distance %u (offCode=%u)",
-                        (U32)matchLength, curr - matchIndex, curr - matchIndex + ZSTD_REP_MOVE);
+                        (U32)matchLength, curr - matchIndex, STORE_OFFSET(curr - matchIndex));
                 if (matchLength > matchEndIdx - matchIndex)
                     matchEndIdx = matchIndex + (U32)matchLength;
                 bestLength = matchLength;
-                matches[mnum].off = (curr - matchIndex) + ZSTD_REP_MOVE;
+                matches[mnum].off = STORE_OFFSET(curr - matchIndex);
                 matches[mnum].len = (U32)matchLength;
                 mnum++;
                 if ( (matchLength > ZSTD_OPT_NUM)
                    | (ip+matchLength == iLimit) /* equal : no way to know if inf or sup */) {
                     break;   /* drop, to guarantee consistency (miss a little bit of compression) */
-                }
-            }
+            }   }
 
             if (dictMatchIndex <= dmsBtLow) { break; }   /* beyond tree size, stop the search */
             if (match[matchLength] < ip[matchLength]) {
@@ -742,39 +775,91 @@ U32 ZSTD_insertBtAndGetAllMatches (
                 /* match is larger than current */
                 commonLengthLarger = matchLength;
                 dictMatchIndex = nextPtr[0];
-            }
-        }
-    }
+    }   }   }  /* if (dictMode == ZSTD_dictMatchState) */
 
     assert(matchEndIdx > curr+8);
     ms->nextToUpdate = matchEndIdx - 8;  /* skip repetitive patterns */
     return mnum;
 }
 
-
-FORCE_INLINE_TEMPLATE U32 ZSTD_BtGetAllMatches (
-                        ZSTD_match_t* matches,   /* store result (match found, increasing size) in this table */
-                        ZSTD_matchState_t* ms,
-                        U32* nextToUpdate3,
-                        const BYTE* ip, const BYTE* const iHighLimit, const ZSTD_dictMode_e dictMode,
-                        const U32 rep[ZSTD_REP_NUM],
-                        U32 const ll0,
-                        U32 const lengthToBeat)
+typedef U32 (*ZSTD_getAllMatchesFn)(
+    ZSTD_match_t*,
+    ZSTD_matchState_t*,
+    U32*,
+    const BYTE*,
+    const BYTE*,
+    const U32 rep[ZSTD_REP_NUM],
+    U32 const ll0,
+    U32 const lengthToBeat);
+
+FORCE_INLINE_TEMPLATE U32 ZSTD_btGetAllMatches_internal(
+        ZSTD_match_t* matches,
+        ZSTD_matchState_t* ms,
+        U32* nextToUpdate3,
+        const BYTE* ip,
+        const BYTE* const iHighLimit,
+        const U32 rep[ZSTD_REP_NUM],
+        U32 const ll0,
+        U32 const lengthToBeat,
+        const ZSTD_dictMode_e dictMode,
+        const U32 mls)
 {
-    const ZSTD_compressionParameters* const cParams = &ms->cParams;
-    U32 const matchLengthSearch = cParams->minMatch;
-    DEBUGLOG(8, "ZSTD_BtGetAllMatches");
-    if (ip < ms->window.base + ms->nextToUpdate) return 0;   /* skipped area */
-    ZSTD_updateTree_internal(ms, ip, iHighLimit, matchLengthSearch, dictMode);
-    switch(matchLengthSearch)
-    {
-    case 3 : return ZSTD_insertBtAndGetAllMatches(matches, ms, nextToUpdate3, ip, iHighLimit, dictMode, rep, ll0, lengthToBeat, 3);
-    default :
-    case 4 : return ZSTD_insertBtAndGetAllMatches(matches, ms, nextToUpdate3, ip, iHighLimit, dictMode, rep, ll0, lengthToBeat, 4);
-    case 5 : return ZSTD_insertBtAndGetAllMatches(matches, ms, nextToUpdate3, ip, iHighLimit, dictMode, rep, ll0, lengthToBeat, 5);
-    case 7 :
-    case 6 : return ZSTD_insertBtAndGetAllMatches(matches, ms, nextToUpdate3, ip, iHighLimit, dictMode, rep, ll0, lengthToBeat, 6);
+    assert(BOUNDED(3, ms->cParams.minMatch, 6) == mls);
+    DEBUGLOG(8, "ZSTD_BtGetAllMatches(dictMode=%d, mls=%u)", (int)dictMode, mls);
+    if (ip < ms->window.base + ms->nextToUpdate)
+        return 0;   /* skipped area */
+    ZSTD_updateTree_internal(ms, ip, iHighLimit, mls, dictMode);
+    return ZSTD_insertBtAndGetAllMatches(matches, ms, nextToUpdate3, ip, iHighLimit, dictMode, rep, ll0, lengthToBeat, mls);
+}
+
+#define ZSTD_BT_GET_ALL_MATCHES_FN(dictMode, mls) ZSTD_btGetAllMatches_##dictMode##_##mls
+
+#define GEN_ZSTD_BT_GET_ALL_MATCHES_(dictMode, mls)            \
+    static U32 ZSTD_BT_GET_ALL_MATCHES_FN(dictMode, mls)(      \
+            ZSTD_match_t* matches,                             \
+            ZSTD_matchState_t* ms,                             \
+            U32* nextToUpdate3,                                \
+            const BYTE* ip,                                    \
+            const BYTE* const iHighLimit,                      \
+            const U32 rep[ZSTD_REP_NUM],                       \
+            U32 const ll0,                                     \
+            U32 const lengthToBeat)                            \
+    {                                                          \
+        return ZSTD_btGetAllMatches_internal(                  \
+                matches, ms, nextToUpdate3, ip, iHighLimit,    \
+                rep, ll0, lengthToBeat, ZSTD_##dictMode, mls); \
+    }
+
+#define GEN_ZSTD_BT_GET_ALL_MATCHES(dictMode)  \
+    GEN_ZSTD_BT_GET_ALL_MATCHES_(dictMode, 3)  \
+    GEN_ZSTD_BT_GET_ALL_MATCHES_(dictMode, 4)  \
+    GEN_ZSTD_BT_GET_ALL_MATCHES_(dictMode, 5)  \
+    GEN_ZSTD_BT_GET_ALL_MATCHES_(dictMode, 6)
+
+GEN_ZSTD_BT_GET_ALL_MATCHES(noDict)
+GEN_ZSTD_BT_GET_ALL_MATCHES(extDict)
+GEN_ZSTD_BT_GET_ALL_MATCHES(dictMatchState)
+
+#define ZSTD_BT_GET_ALL_MATCHES_ARRAY(dictMode)  \
+    {                                            \
+        ZSTD_BT_GET_ALL_MATCHES_FN(dictMode, 3), \
+        ZSTD_BT_GET_ALL_MATCHES_FN(dictMode, 4), \
+        ZSTD_BT_GET_ALL_MATCHES_FN(dictMode, 5), \
+        ZSTD_BT_GET_ALL_MATCHES_FN(dictMode, 6)  \
     }
+
+static ZSTD_getAllMatchesFn
+ZSTD_selectBtGetAllMatches(ZSTD_matchState_t const* ms, ZSTD_dictMode_e const dictMode)
+{
+    ZSTD_getAllMatchesFn const getAllMatchesFns[3][4] = {
+        ZSTD_BT_GET_ALL_MATCHES_ARRAY(noDict),
+        ZSTD_BT_GET_ALL_MATCHES_ARRAY(extDict),
+        ZSTD_BT_GET_ALL_MATCHES_ARRAY(dictMatchState)
+    };
+    U32 const mls = BOUNDED(3, ms->cParams.minMatch, 6);
+    assert((U32)dictMode < 3);
+    assert(mls - 3 < 4);
+    return getAllMatchesFns[(int)dictMode][mls - 3];
 }
 
 /* ***********************
@@ -783,16 +868,18 @@ FORCE_INLINE_TEMPLATE U32 ZSTD_BtGetAllMatches (
 
 /* Struct containing info needed to make decision about ldm inclusion */
 typedef struct {
-    rawSeqStore_t seqStore;         /* External match candidates store for this block */
-    U32 startPosInBlock;            /* Start position of the current match candidate */
-    U32 endPosInBlock;              /* End position of the current match candidate */
-    U32 offset;                     /* Offset of the match candidate */
+    rawSeqStore_t seqStore;   /* External match candidates store for this block */
+    U32 startPosInBlock;      /* Start position of the current match candidate */
+    U32 endPosInBlock;        /* End position of the current match candidate */
+    U32 offset;               /* Offset of the match candidate */
 } ZSTD_optLdm_t;
 
 /* ZSTD_optLdm_skipRawSeqStoreBytes():
- * Moves forward in rawSeqStore by nbBytes, which will update the fields 'pos' and 'posInSequence'.
+ * Moves forward in @rawSeqStore by @nbBytes,
+ * which will update the fields 'pos' and 'posInSequence'.
  */
-static void ZSTD_optLdm_skipRawSeqStoreBytes(rawSeqStore_t* rawSeqStore, size_t nbBytes) {
+static void ZSTD_optLdm_skipRawSeqStoreBytes(rawSeqStore_t* rawSeqStore, size_t nbBytes)
+{
     U32 currPos = (U32)(rawSeqStore->posInSequence + nbBytes);
     while (currPos && rawSeqStore->pos < rawSeqStore->size) {
         rawSeq currSeq = rawSeqStore->seq[rawSeqStore->pos];
@@ -813,8 +900,10 @@ static void ZSTD_optLdm_skipRawSeqStoreBytes(rawSeqStore_t* rawSeqStore, size_t
  * Calculates the beginning and end of the next match in the current block.
  * Updates 'pos' and 'posInSequence' of the ldmSeqStore.
  */
-static void ZSTD_opt_getNextMatchAndUpdateSeqStore(ZSTD_optLdm_t* optLdm, U32 currPosInBlock,
-                                                   U32 blockBytesRemaining) {
+static void
+ZSTD_opt_getNextMatchAndUpdateSeqStore(ZSTD_optLdm_t* optLdm, U32 currPosInBlock,
+                                       U32 blockBytesRemaining)
+{
     rawSeq currSeq;
     U32 currBlockEndPos;
     U32 literalsBytesRemaining;
@@ -826,8 +915,8 @@ static void ZSTD_opt_getNextMatchAndUpdateSeqStore(ZSTD_optLdm_t* optLdm, U32 cu
         optLdm->endPosInBlock = UINT_MAX;
         return;
     }
-    /* Calculate appropriate bytes left in matchLength and litLength after adjusting
-       based on ldmSeqStore->posInSequence */
+    /* Calculate appropriate bytes left in matchLength and litLength
+     * after adjusting based on ldmSeqStore->posInSequence */
     currSeq = optLdm->seqStore.seq[optLdm->seqStore.pos];
     assert(optLdm->seqStore.posInSequence <= currSeq.litLength + currSeq.matchLength);
     currBlockEndPos = currPosInBlock + blockBytesRemaining;
@@ -863,15 +952,16 @@ static void ZSTD_opt_getNextMatchAndUpdateSeqStore(ZSTD_optLdm_t* optLdm, U32 cu
 }
 
 /* ZSTD_optLdm_maybeAddMatch():
- * Adds a match if it's long enough, based on it's 'matchStartPosInBlock'
- * and 'matchEndPosInBlock', into 'matches'. Maintains the correct ordering of 'matches'
+ * Adds a match if it's long enough,
+ * based on it's 'matchStartPosInBlock' and 'matchEndPosInBlock',
+ * into 'matches'. Maintains the correct ordering of 'matches'.
  */
 static void ZSTD_optLdm_maybeAddMatch(ZSTD_match_t* matches, U32* nbMatches,
-                                      ZSTD_optLdm_t* optLdm, U32 currPosInBlock) {
-    U32 posDiff = currPosInBlock - optLdm->startPosInBlock;
+                                      const ZSTD_optLdm_t* optLdm, U32 currPosInBlock)
+{
+    U32 const posDiff = currPosInBlock - optLdm->startPosInBlock;
     /* Note: ZSTD_match_t actually contains offCode and matchLength (before subtracting MINMATCH) */
-    U32 candidateMatchLength = optLdm->endPosInBlock - optLdm->startPosInBlock - posDiff;
-    U32 candidateOffCode = optLdm->offset + ZSTD_REP_MOVE;
+    U32 const candidateMatchLength = optLdm->endPosInBlock - optLdm->startPosInBlock - posDiff;
 
     /* Ensure that current block position is not outside of the match */
     if (currPosInBlock < optLdm->startPosInBlock
@@ -881,6 +971,7 @@ static void ZSTD_optLdm_maybeAddMatch(ZSTD_match_t* matches, U32* nbMatches,
     }
 
     if (*nbMatches == 0 || ((candidateMatchLength > matches[*nbMatches-1].len) && *nbMatches < ZSTD_OPT_NUM)) {
+        U32 const candidateOffCode = STORE_OFFSET(optLdm->offset);
         DEBUGLOG(6, "ZSTD_optLdm_maybeAddMatch(): Adding ldm candidate match (offCode: %u matchLength %u) at block position=%u",
                  candidateOffCode, candidateMatchLength, currPosInBlock);
         matches[*nbMatches].len = candidateMatchLength;
@@ -892,8 +983,11 @@ static void ZSTD_optLdm_maybeAddMatch(ZSTD_match_t* matches, U32* nbMatches,
 /* ZSTD_optLdm_processMatchCandidate():
  * Wrapper function to update ldm seq store and call ldm functions as necessary.
  */
-static void ZSTD_optLdm_processMatchCandidate(ZSTD_optLdm_t* optLdm, ZSTD_match_t* matches, U32* nbMatches,
-                                              U32 currPosInBlock, U32 remainingBytes) {
+static void
+ZSTD_optLdm_processMatchCandidate(ZSTD_optLdm_t* optLdm,
+                                  ZSTD_match_t* matches, U32* nbMatches,
+                                  U32 currPosInBlock, U32 remainingBytes)
+{
     if (optLdm->seqStore.size == 0 || optLdm->seqStore.pos >= optLdm->seqStore.size) {
         return;
     }
@@ -904,19 +998,19 @@ static void ZSTD_optLdm_processMatchCandidate(ZSTD_optLdm_t* optLdm, ZSTD_match_
              * at the end of a match from the ldm seq store, and will often be some bytes
              * over beyond matchEndPosInBlock. As such, we need to correct for these "overshoots"
              */
-            U32 posOvershoot = currPosInBlock - optLdm->endPosInBlock;
+            U32 const posOvershoot = currPosInBlock - optLdm->endPosInBlock;
             ZSTD_optLdm_skipRawSeqStoreBytes(&optLdm->seqStore, posOvershoot);
-        } 
+        }
         ZSTD_opt_getNextMatchAndUpdateSeqStore(optLdm, currPosInBlock, remainingBytes);
     }
     ZSTD_optLdm_maybeAddMatch(matches, nbMatches, optLdm, currPosInBlock);
 }
 
+
 /*-*******************************
 *  Optimal parser
 *********************************/
 
-
 static U32 ZSTD_totalLen(ZSTD_optimal_t sol)
 {
     return sol.litlen + sol.mlen;
@@ -957,6 +1051,8 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
     const BYTE* const prefixStart = base + ms->window.dictLimit;
     const ZSTD_compressionParameters* const cParams = &ms->cParams;
 
+    ZSTD_getAllMatchesFn getAllMatches = ZSTD_selectBtGetAllMatches(ms, dictMode);
+
     U32 const sufficient_len = MIN(cParams->targetLength, ZSTD_OPT_NUM -1);
     U32 const minMatch = (cParams->minMatch == 3) ? 3 : 4;
     U32 nextToUpdate3 = ms->nextToUpdate;
@@ -984,7 +1080,7 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
         /* find first match */
         {   U32 const litlen = (U32)(ip - anchor);
             U32 const ll0 = !litlen;
-            U32 nbMatches = ZSTD_BtGetAllMatches(matches, ms, &nextToUpdate3, ip, iend, dictMode, rep, ll0, minMatch);
+            U32 nbMatches = getAllMatches(matches, ms, &nextToUpdate3, ip, iend, rep, ll0, minMatch);
             ZSTD_optLdm_processMatchCandidate(&optLdm, matches, &nbMatches,
                                               (U32)(ip-istart), (U32)(iend - ip));
             if (!nbMatches) { ip++; continue; }
@@ -998,18 +1094,18 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
              * in every price. We include the literal length to avoid negative
              * prices when we subtract the previous literal length.
              */
-            opt[0].price = ZSTD_litLengthPrice(litlen, optStatePtr, optLevel);
+            opt[0].price = (int)ZSTD_litLengthPrice(litlen, optStatePtr, optLevel);
 
             /* large match -> immediate encoding */
             {   U32 const maxML = matches[nbMatches-1].len;
-                U32 const maxOffset = matches[nbMatches-1].off;
+                U32 const maxOffcode = matches[nbMatches-1].off;
                 DEBUGLOG(6, "found %u matches of maxLength=%u and maxOffCode=%u at cPos=%u => start new series",
-                            nbMatches, maxML, maxOffset, (U32)(ip-prefixStart));
+                            nbMatches, maxML, maxOffcode, (U32)(ip-prefixStart));
 
                 if (maxML > sufficient_len) {
                     lastSequence.litlen = litlen;
                     lastSequence.mlen = maxML;
-                    lastSequence.off = maxOffset;
+                    lastSequence.off = maxOffcode;
                     DEBUGLOG(6, "large match (%u>%u), immediate encoding",
                                 maxML, sufficient_len);
                     cur = 0;
@@ -1018,24 +1114,25 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
             }   }
 
             /* set prices for first matches starting position == 0 */
-            {   U32 const literalsPrice = opt[0].price + ZSTD_litLengthPrice(0, optStatePtr, optLevel);
+            assert(opt[0].price >= 0);
+            {   U32 const literalsPrice = (U32)opt[0].price + ZSTD_litLengthPrice(0, optStatePtr, optLevel);
                 U32 pos;
                 U32 matchNb;
                 for (pos = 1; pos < minMatch; pos++) {
                     opt[pos].price = ZSTD_MAX_PRICE;   /* mlen, litlen and price will be fixed during forward scanning */
                 }
                 for (matchNb = 0; matchNb < nbMatches; matchNb++) {
-                    U32 const offset = matches[matchNb].off;
+                    U32 const offcode = matches[matchNb].off;
                     U32 const end = matches[matchNb].len;
                     for ( ; pos <= end ; pos++ ) {
-                        U32 const matchPrice = ZSTD_getMatchPrice(offset, pos, optStatePtr, optLevel);
+                        U32 const matchPrice = ZSTD_getMatchPrice(offcode, pos, optStatePtr, optLevel);
                         U32 const sequencePrice = literalsPrice + matchPrice;
                         DEBUGLOG(7, "rPos:%u => set initial price : %.2f",
                                     pos, ZSTD_fCost(sequencePrice));
                         opt[pos].mlen = pos;
-                        opt[pos].off = offset;
+                        opt[pos].off = offcode;
                         opt[pos].litlen = litlen;
-                        opt[pos].price = sequencePrice;
+                        opt[pos].price = (int)sequencePrice;
                 }   }
                 last_pos = pos-1;
             }
@@ -1050,9 +1147,9 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
             /* Fix current position with one literal if cheaper */
             {   U32 const litlen = (opt[cur-1].mlen == 0) ? opt[cur-1].litlen + 1 : 1;
                 int const price = opt[cur-1].price
-                                + ZSTD_rawLiteralsCost(ip+cur-1, 1, optStatePtr, optLevel)
-                                + ZSTD_litLengthPrice(litlen, optStatePtr, optLevel)
-                                - ZSTD_litLengthPrice(litlen-1, optStatePtr, optLevel);
+                                + (int)ZSTD_rawLiteralsCost(ip+cur-1, 1, optStatePtr, optLevel)
+                                + (int)ZSTD_litLengthPrice(litlen, optStatePtr, optLevel)
+                                - (int)ZSTD_litLengthPrice(litlen-1, optStatePtr, optLevel);
                 assert(price < 1000000000); /* overflow check */
                 if (price <= opt[cur].price) {
                     DEBUGLOG(7, "cPos:%zi==rPos:%u : better price (%.2f<=%.2f) using literal (ll==%u) (hist:%u,%u,%u)",
@@ -1078,7 +1175,7 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
             assert(cur >= opt[cur].mlen);
             if (opt[cur].mlen != 0) {
                 U32 const prev = cur - opt[cur].mlen;
-                repcodes_t newReps = ZSTD_updateRep(opt[prev].rep, opt[cur].off, opt[cur].litlen==0);
+                repcodes_t const newReps = ZSTD_newRep(opt[prev].rep, opt[cur].off, opt[cur].litlen==0);
                 ZSTD_memcpy(opt[cur].rep, &newReps, sizeof(repcodes_t));
             } else {
                 ZSTD_memcpy(opt[cur].rep, opt[cur - 1].rep, sizeof(repcodes_t));
@@ -1095,11 +1192,12 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
                 continue;  /* skip unpromising positions; about ~+6% speed, -0.01 ratio */
             }
 
+            assert(opt[cur].price >= 0);
             {   U32 const ll0 = (opt[cur].mlen != 0);
                 U32 const litlen = (opt[cur].mlen == 0) ? opt[cur].litlen : 0;
-                U32 const previousPrice = opt[cur].price;
+                U32 const previousPrice = (U32)opt[cur].price;
                 U32 const basePrice = previousPrice + ZSTD_litLengthPrice(0, optStatePtr, optLevel);
-                U32 nbMatches = ZSTD_BtGetAllMatches(matches, ms, &nextToUpdate3, inr, iend, dictMode, opt[cur].rep, ll0, minMatch);
+                U32 nbMatches = getAllMatches(matches, ms, &nextToUpdate3, inr, iend, opt[cur].rep, ll0, minMatch);
                 U32 matchNb;
 
                 ZSTD_optLdm_processMatchCandidate(&optLdm, matches, &nbMatches,
@@ -1137,7 +1235,7 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
 
                     for (mlen = lastML; mlen >= startML; mlen--) {  /* scan downward */
                         U32 const pos = cur + mlen;
-                        int const price = basePrice + ZSTD_getMatchPrice(offset, mlen, optStatePtr, optLevel);
+                        int const price = (int)basePrice + (int)ZSTD_getMatchPrice(offset, mlen, optStatePtr, optLevel);
 
                         if ((pos > last_pos) || (price < opt[pos].price)) {
                             DEBUGLOG(7, "rPos:%u (ml=%2u) => new better price (%.2f<%.2f)",
@@ -1167,7 +1265,7 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
          * update them while traversing the sequences.
          */
         if (lastSequence.mlen != 0) {
-            repcodes_t reps = ZSTD_updateRep(opt[cur].rep, lastSequence.off, lastSequence.litlen==0);
+            repcodes_t const reps = ZSTD_newRep(opt[cur].rep, lastSequence.off, lastSequence.litlen==0);
             ZSTD_memcpy(rep, &reps, sizeof(reps));
         } else {
             ZSTD_memcpy(rep, opt[cur].rep, sizeof(repcodes_t));
@@ -1211,7 +1309,7 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
 
                     assert(anchor + llen <= iend);
                     ZSTD_updateStats(optStatePtr, llen, anchor, offCode, mlen);
-                    ZSTD_storeSeq(seqStore, llen, anchor, iend, offCode, mlen-MINMATCH);
+                    ZSTD_storeSeq(seqStore, llen, anchor, iend, offCode, mlen);
                     anchor += advance;
                     ip = anchor;
             }   }
@@ -1223,38 +1321,30 @@ ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
     return (size_t)(iend - anchor);
 }
 
+static size_t ZSTD_compressBlock_opt0(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        const void* src, size_t srcSize, const ZSTD_dictMode_e dictMode)
+{
+    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 0 /* optLevel */, dictMode);
+}
+
+static size_t ZSTD_compressBlock_opt2(
+        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
+        const void* src, size_t srcSize, const ZSTD_dictMode_e dictMode)
+{
+    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 2 /* optLevel */, dictMode);
+}
 
 size_t ZSTD_compressBlock_btopt(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         const void* src, size_t srcSize)
 {
     DEBUGLOG(5, "ZSTD_compressBlock_btopt");
-    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 0 /*optLevel*/, ZSTD_noDict);
+    return ZSTD_compressBlock_opt0(ms, seqStore, rep, src, srcSize, ZSTD_noDict);
 }
 
 
-/* used in 2-pass strategy */
-static U32 ZSTD_upscaleStat(unsigned* table, U32 lastEltIndex, int bonus)
-{
-    U32 s, sum=0;
-    assert(ZSTD_FREQ_DIV+bonus >= 0);
-    for (s=0; s<lastEltIndex+1; s++) {
-        table[s] <<= ZSTD_FREQ_DIV+bonus;
-        table[s]--;
-        sum += table[s];
-    }
-    return sum;
-}
 
-/* used in 2-pass strategy */
-MEM_STATIC void ZSTD_upscaleStats(optState_t* optPtr)
-{
-    if (ZSTD_compressedLiterals(optPtr))
-        optPtr->litSum = ZSTD_upscaleStat(optPtr->litFreq, MaxLit, 0);
-    optPtr->litLengthSum = ZSTD_upscaleStat(optPtr->litLengthFreq, MaxLL, 0);
-    optPtr->matchLengthSum = ZSTD_upscaleStat(optPtr->matchLengthFreq, MaxML, 0);
-    optPtr->offCodeSum = ZSTD_upscaleStat(optPtr->offCodeFreq, MaxOff, 0);
-}
 
 /* ZSTD_initStats_ultra():
  * make a first compression pass, just to seed stats with more accurate starting values.
@@ -1276,7 +1366,7 @@ ZSTD_initStats_ultra(ZSTD_matchState_t* ms,
     assert(ms->window.dictLimit == ms->window.lowLimit);   /* no dictionary */
     assert(ms->window.dictLimit - ms->nextToUpdate <= 1);  /* no prefix (note: intentional overflow, defined as 2-complement) */
 
-    ZSTD_compressBlock_opt_generic(ms, seqStore, tmpRep, src, srcSize, 2 /*optLevel*/, ZSTD_noDict);   /* generate stats into ms->opt*/
+    ZSTD_compressBlock_opt2(ms, seqStore, tmpRep, src, srcSize, ZSTD_noDict);   /* generate stats into ms->opt*/
 
     /* invalidate first scan from history */
     ZSTD_resetSeqStore(seqStore);
@@ -1285,8 +1375,6 @@ ZSTD_initStats_ultra(ZSTD_matchState_t* ms,
     ms->window.lowLimit = ms->window.dictLimit;
     ms->nextToUpdate = ms->window.dictLimit;
 
-    /* re-inforce weight of collected statistics */
-    ZSTD_upscaleStats(&ms->opt);
 }
 
 size_t ZSTD_compressBlock_btultra(
@@ -1294,7 +1382,7 @@ size_t ZSTD_compressBlock_btultra(
         const void* src, size_t srcSize)
 {
     DEBUGLOG(5, "ZSTD_compressBlock_btultra (srcSize=%zu)", srcSize);
-    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 2 /*optLevel*/, ZSTD_noDict);
+    return ZSTD_compressBlock_opt2(ms, seqStore, rep, src, srcSize, ZSTD_noDict);
 }
 
 size_t ZSTD_compressBlock_btultra2(
@@ -1322,35 +1410,35 @@ size_t ZSTD_compressBlock_btultra2(
         ZSTD_initStats_ultra(ms, seqStore, rep, src, srcSize);
     }
 
-    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 2 /*optLevel*/, ZSTD_noDict);
+    return ZSTD_compressBlock_opt2(ms, seqStore, rep, src, srcSize, ZSTD_noDict);
 }
 
 size_t ZSTD_compressBlock_btopt_dictMatchState(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         const void* src, size_t srcSize)
 {
-    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 0 /*optLevel*/, ZSTD_dictMatchState);
+    return ZSTD_compressBlock_opt0(ms, seqStore, rep, src, srcSize, ZSTD_dictMatchState);
 }
 
 size_t ZSTD_compressBlock_btultra_dictMatchState(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         const void* src, size_t srcSize)
 {
-    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 2 /*optLevel*/, ZSTD_dictMatchState);
+    return ZSTD_compressBlock_opt2(ms, seqStore, rep, src, srcSize, ZSTD_dictMatchState);
 }
 
 size_t ZSTD_compressBlock_btopt_extDict(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         const void* src, size_t srcSize)
 {
-    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 0 /*optLevel*/, ZSTD_extDict);
+    return ZSTD_compressBlock_opt0(ms, seqStore, rep, src, srcSize, ZSTD_extDict);
 }
 
 size_t ZSTD_compressBlock_btultra_extDict(
         ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
         const void* src, size_t srcSize)
 {
-    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 2 /*optLevel*/, ZSTD_extDict);
+    return ZSTD_compressBlock_opt2(ms, seqStore, rep, src, srcSize, ZSTD_extDict);
 }
 
 /* note : no btultra2 variant for extDict nor dictMatchState,
diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf_decompress.c
index 5105e59ac04a..89b269a641c7 100644
--- a/lib/zstd/decompress/huf_decompress.c
+++ b/lib/zstd/decompress/huf_decompress.c
@@ -22,6 +22,13 @@
 #define HUF_STATIC_LINKING_ONLY
 #include "../common/huf.h"
 #include "../common/error_private.h"
+#include "../common/zstd_internal.h"
+
+/* **************************************************************
+*  Constants
+****************************************************************/
+
+#define HUF_DECODER_FAST_TABLELOG 11
 
 /* **************************************************************
 *  Macros
@@ -36,6 +43,26 @@
 #error "Cannot force the use of the X1 and X2 decoders at the same time!"
 #endif
 
+#if ZSTD_ENABLE_ASM_X86_64_BMI2 && DYNAMIC_BMI2
+# define HUF_ASM_X86_64_BMI2_ATTRS BMI2_TARGET_ATTRIBUTE
+#else
+# define HUF_ASM_X86_64_BMI2_ATTRS
+#endif
+
+#define HUF_EXTERN_C
+#define HUF_ASM_DECL HUF_EXTERN_C
+
+#if DYNAMIC_BMI2 || (ZSTD_ENABLE_ASM_X86_64_BMI2 && defined(__BMI2__))
+# define HUF_NEED_BMI2_FUNCTION 1
+#else
+# define HUF_NEED_BMI2_FUNCTION 0
+#endif
+
+#if !(ZSTD_ENABLE_ASM_X86_64_BMI2 && defined(__BMI2__))
+# define HUF_NEED_DEFAULT_FUNCTION 1
+#else
+# define HUF_NEED_DEFAULT_FUNCTION 0
+#endif
 
 /* **************************************************************
 *  Error Management
@@ -65,7 +92,7 @@
         return fn##_body(dst, dstSize, cSrc, cSrcSize, DTable);             \
     }                                                                       \
                                                                             \
-    static TARGET_ATTRIBUTE("bmi2") size_t fn##_bmi2(                       \
+    static BMI2_TARGET_ATTRIBUTE size_t fn##_bmi2(                          \
                   void* dst,  size_t dstSize,                               \
             const void* cSrc, size_t cSrcSize,                              \
             const HUF_DTable* DTable)                                       \
@@ -107,13 +134,147 @@ static DTableDesc HUF_getDTableDesc(const HUF_DTable* table)
     return dtd;
 }
 
+#if ZSTD_ENABLE_ASM_X86_64_BMI2
+
+static size_t HUF_initDStream(BYTE const* ip) {
+    BYTE const lastByte = ip[7];
+    size_t const bitsConsumed = lastByte ? 8 - BIT_highbit32(lastByte) : 0;
+    size_t const value = MEM_readLEST(ip) | 1;
+    assert(bitsConsumed <= 8);
+    return value << bitsConsumed;
+}
+typedef struct {
+    BYTE const* ip[4];
+    BYTE* op[4];
+    U64 bits[4];
+    void const* dt;
+    BYTE const* ilimit;
+    BYTE* oend;
+    BYTE const* iend[4];
+} HUF_DecompressAsmArgs;
+
+/*
+ * Initializes args for the asm decoding loop.
+ * @returns 0 on success
+ *          1 if the fallback implementation should be used.
+ *          Or an error code on failure.
+ */
+static size_t HUF_DecompressAsmArgs_init(HUF_DecompressAsmArgs* args, void* dst, size_t dstSize, void const* src, size_t srcSize, const HUF_DTable* DTable)
+{
+    void const* dt = DTable + 1;
+    U32 const dtLog = HUF_getDTableDesc(DTable).tableLog;
+
+    const BYTE* const ilimit = (const BYTE*)src + 6 + 8;
+
+    BYTE* const oend = (BYTE*)dst + dstSize;
+
+    /* The following condition is false on x32 platform,
+     * but HUF_asm is not compatible with this ABI */
+    if (!(MEM_isLittleEndian() && !MEM_32bits())) return 1;
+
+    /* strict minimum : jump table + 1 byte per stream */
+    if (srcSize < 10)
+        return ERROR(corruption_detected);
+
+    /* Must have at least 8 bytes per stream because we don't handle initializing smaller bit containers.
+     * If table log is not correct at this point, fallback to the old decoder.
+     * On small inputs we don't have enough data to trigger the fast loop, so use the old decoder.
+     */
+    if (dtLog != HUF_DECODER_FAST_TABLELOG)
+        return 1;
+
+    /* Read the jump table. */
+    {
+        const BYTE* const istart = (const BYTE*)src;
+        size_t const length1 = MEM_readLE16(istart);
+        size_t const length2 = MEM_readLE16(istart+2);
+        size_t const length3 = MEM_readLE16(istart+4);
+        size_t const length4 = srcSize - (length1 + length2 + length3 + 6);
+        args->iend[0] = istart + 6;  /* jumpTable */
+        args->iend[1] = args->iend[0] + length1;
+        args->iend[2] = args->iend[1] + length2;
+        args->iend[3] = args->iend[2] + length3;
+
+        /* HUF_initDStream() requires this, and this small of an input
+         * won't benefit from the ASM loop anyways.
+         * length1 must be >= 16 so that ip[0] >= ilimit before the loop
+         * starts.
+         */
+        if (length1 < 16 || length2 < 8 || length3 < 8 || length4 < 8)
+            return 1;
+        if (length4 > srcSize) return ERROR(corruption_detected);   /* overflow */
+    }
+    /* ip[] contains the position that is currently loaded into bits[]. */
+    args->ip[0] = args->iend[1] - sizeof(U64);
+    args->ip[1] = args->iend[2] - sizeof(U64);
+    args->ip[2] = args->iend[3] - sizeof(U64);
+    args->ip[3] = (BYTE const*)src + srcSize - sizeof(U64);
+
+    /* op[] contains the output pointers. */
+    args->op[0] = (BYTE*)dst;
+    args->op[1] = args->op[0] + (dstSize+3)/4;
+    args->op[2] = args->op[1] + (dstSize+3)/4;
+    args->op[3] = args->op[2] + (dstSize+3)/4;
+
+    /* No point to call the ASM loop for tiny outputs. */
+    if (args->op[3] >= oend)
+        return 1;
+
+    /* bits[] is the bit container.
+        * It is read from the MSB down to the LSB.
+        * It is shifted left as it is read, and zeros are
+        * shifted in. After the lowest valid bit a 1 is
+        * set, so that CountTrailingZeros(bits[]) can be used
+        * to count how many bits we've consumed.
+        */
+    args->bits[0] = HUF_initDStream(args->ip[0]);
+    args->bits[1] = HUF_initDStream(args->ip[1]);
+    args->bits[2] = HUF_initDStream(args->ip[2]);
+    args->bits[3] = HUF_initDStream(args->ip[3]);
+
+    /* If ip[] >= ilimit, it is guaranteed to be safe to
+        * reload bits[]. It may be beyond its section, but is
+        * guaranteed to be valid (>= istart).
+        */
+    args->ilimit = ilimit;
+
+    args->oend = oend;
+    args->dt = dt;
+
+    return 0;
+}
+
+static size_t HUF_initRemainingDStream(BIT_DStream_t* bit, HUF_DecompressAsmArgs const* args, int stream, BYTE* segmentEnd)
+{
+    /* Validate that we haven't overwritten. */
+    if (args->op[stream] > segmentEnd)
+        return ERROR(corruption_detected);
+    /* Validate that we haven't read beyond iend[].
+        * Note that ip[] may be < iend[] because the MSB is
+        * the next bit to read, and we may have consumed 100%
+        * of the stream, so down to iend[i] - 8 is valid.
+        */
+    if (args->ip[stream] < args->iend[stream] - 8)
+        return ERROR(corruption_detected);
+
+    /* Construct the BIT_DStream_t. */
+    bit->bitContainer = MEM_readLE64(args->ip[stream]);
+    bit->bitsConsumed = ZSTD_countTrailingZeros((size_t)args->bits[stream]);
+    bit->start = (const char*)args->iend[0];
+    bit->limitPtr = bit->start + sizeof(size_t);
+    bit->ptr = (const char*)args->ip[stream];
+
+    return 0;
+}
+#endif
+
 
 #ifndef HUF_FORCE_DECOMPRESS_X2
 
 /*-***************************/
 /*  single-symbol decoding   */
 /*-***************************/
-typedef struct { BYTE byte; BYTE nbBits; } HUF_DEltX1;   /* single-symbol decoding */
+typedef struct { BYTE nbBits; BYTE byte; } HUF_DEltX1;   /* single-symbol decoding */
 
 /*
  * Packs 4 HUF_DEltX1 structs into a U64. This is used to lay down 4 entries at
@@ -122,14 +283,44 @@ typedef struct { BYTE byte; BYTE nbBits; } HUF_DEltX1;   /* single-symbol decodi
 static U64 HUF_DEltX1_set4(BYTE symbol, BYTE nbBits) {
     U64 D4;
     if (MEM_isLittleEndian()) {
-        D4 = symbol + (nbBits << 8);
-    } else {
         D4 = (symbol << 8) + nbBits;
+    } else {
+        D4 = symbol + (nbBits << 8);
     }
     D4 *= 0x0001000100010001ULL;
     return D4;
 }
 
+/*
+ * Increase the tableLog to targetTableLog and rescales the stats.
+ * If tableLog > targetTableLog this is a no-op.
+ * @returns New tableLog
+ */
+static U32 HUF_rescaleStats(BYTE* huffWeight, U32* rankVal, U32 nbSymbols, U32 tableLog, U32 targetTableLog)
+{
+    if (tableLog > targetTableLog)
+        return tableLog;
+    if (tableLog < targetTableLog) {
+        U32 const scale = targetTableLog - tableLog;
+        U32 s;
+        /* Increase the weight for all non-zero probability symbols by scale. */
+        for (s = 0; s < nbSymbols; ++s) {
+            huffWeight[s] += (BYTE)((huffWeight[s] == 0) ? 0 : scale);
+        }
+        /* Update rankVal to reflect the new weights.
+         * All weights except 0 get moved to weight + scale.
+         * Weights [1, scale] are empty.
+         */
+        for (s = targetTableLog; s > scale; --s) {
+            rankVal[s] = rankVal[s - scale];
+        }
+        for (s = scale; s > 0; --s) {
+            rankVal[s] = 0;
+        }
+    }
+    return targetTableLog;
+}
+
 typedef struct {
         U32 rankVal[HUF_TABLELOG_ABSOLUTEMAX + 1];
         U32 rankStart[HUF_TABLELOG_ABSOLUTEMAX + 1];
@@ -162,8 +353,12 @@ size_t HUF_readDTableX1_wksp_bmi2(HUF_DTable* DTable, const void* src, size_t sr
     iSize = HUF_readStats_wksp(wksp->huffWeight, HUF_SYMBOLVALUE_MAX + 1, wksp->rankVal, &nbSymbols, &tableLog, src, srcSize, wksp->statsWksp, sizeof(wksp->statsWksp), bmi2);
     if (HUF_isError(iSize)) return iSize;
 
+
     /* Table header */
     {   DTableDesc dtd = HUF_getDTableDesc(DTable);
+        U32 const maxTableLog = dtd.maxTableLog + 1;
+        U32 const targetTableLog = MIN(maxTableLog, HUF_DECODER_FAST_TABLELOG);
+        tableLog = HUF_rescaleStats(wksp->huffWeight, wksp->rankVal, nbSymbols, tableLog, targetTableLog);
         if (tableLog > (U32)(dtd.maxTableLog+1)) return ERROR(tableLog_tooLarge);   /* DTable too small, Huffman tree cannot fit in */
         dtd.tableType = 0;
         dtd.tableLog = (BYTE)tableLog;
@@ -207,7 +402,7 @@ size_t HUF_readDTableX1_wksp_bmi2(HUF_DTable* DTable, const void* src, size_t sr
 
     /* fill DTable
      * We fill all entries of each weight in order.
-     * That way length is a constant for each iteration of the outter loop.
+     * That way length is a constant for each iteration of the outer loop.
      * We can switch based on the length to a different inner loop which is
      * optimized for that particular case.
      */
@@ -304,11 +499,15 @@ HUF_decodeStreamX1(BYTE* p, BIT_DStream_t* const bitDPtr, BYTE* const pEnd, cons
     BYTE* const pStart = p;
 
     /* up to 4 symbols at a time */
-    while ((BIT_reloadDStream(bitDPtr) == BIT_DStream_unfinished) & (p < pEnd-3)) {
-        HUF_DECODE_SYMBOLX1_2(p, bitDPtr);
-        HUF_DECODE_SYMBOLX1_1(p, bitDPtr);
-        HUF_DECODE_SYMBOLX1_2(p, bitDPtr);
-        HUF_DECODE_SYMBOLX1_0(p, bitDPtr);
+    if ((pEnd - p) > 3) {
+        while ((BIT_reloadDStream(bitDPtr) == BIT_DStream_unfinished) & (p < pEnd-3)) {
+            HUF_DECODE_SYMBOLX1_2(p, bitDPtr);
+            HUF_DECODE_SYMBOLX1_1(p, bitDPtr);
+            HUF_DECODE_SYMBOLX1_2(p, bitDPtr);
+            HUF_DECODE_SYMBOLX1_0(p, bitDPtr);
+        }
+    } else {
+        BIT_reloadDStream(bitDPtr);
     }
 
     /* [0-3] symbols remaining */
@@ -388,33 +587,36 @@ HUF_decompress4X1_usingDTable_internal_body(
         U32 endSignal = 1;
 
         if (length4 > cSrcSize) return ERROR(corruption_detected);   /* overflow */
+        if (opStart4 > oend) return ERROR(corruption_detected);      /* overflow */
         CHECK_F( BIT_initDStream(&bitD1, istart1, length1) );
         CHECK_F( BIT_initDStream(&bitD2, istart2, length2) );
         CHECK_F( BIT_initDStream(&bitD3, istart3, length3) );
         CHECK_F( BIT_initDStream(&bitD4, istart4, length4) );
 
         /* up to 16 symbols per loop (4 symbols per stream) in 64-bit mode */
-        for ( ; (endSignal) & (op4 < olimit) ; ) {
-            HUF_DECODE_SYMBOLX1_2(op1, &bitD1);
-            HUF_DECODE_SYMBOLX1_2(op2, &bitD2);
-            HUF_DECODE_SYMBOLX1_2(op3, &bitD3);
-            HUF_DECODE_SYMBOLX1_2(op4, &bitD4);
-            HUF_DECODE_SYMBOLX1_1(op1, &bitD1);
-            HUF_DECODE_SYMBOLX1_1(op2, &bitD2);
-            HUF_DECODE_SYMBOLX1_1(op3, &bitD3);
-            HUF_DECODE_SYMBOLX1_1(op4, &bitD4);
-            HUF_DECODE_SYMBOLX1_2(op1, &bitD1);
-            HUF_DECODE_SYMBOLX1_2(op2, &bitD2);
-            HUF_DECODE_SYMBOLX1_2(op3, &bitD3);
-            HUF_DECODE_SYMBOLX1_2(op4, &bitD4);
-            HUF_DECODE_SYMBOLX1_0(op1, &bitD1);
-            HUF_DECODE_SYMBOLX1_0(op2, &bitD2);
-            HUF_DECODE_SYMBOLX1_0(op3, &bitD3);
-            HUF_DECODE_SYMBOLX1_0(op4, &bitD4);
-            endSignal &= BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished;
-            endSignal &= BIT_reloadDStreamFast(&bitD2) == BIT_DStream_unfinished;
-            endSignal &= BIT_reloadDStreamFast(&bitD3) == BIT_DStream_unfinished;
-            endSignal &= BIT_reloadDStreamFast(&bitD4) == BIT_DStream_unfinished;
+        if ((size_t)(oend - op4) >= sizeof(size_t)) {
+            for ( ; (endSignal) & (op4 < olimit) ; ) {
+                HUF_DECODE_SYMBOLX1_2(op1, &bitD1);
+                HUF_DECODE_SYMBOLX1_2(op2, &bitD2);
+                HUF_DECODE_SYMBOLX1_2(op3, &bitD3);
+                HUF_DECODE_SYMBOLX1_2(op4, &bitD4);
+                HUF_DECODE_SYMBOLX1_1(op1, &bitD1);
+                HUF_DECODE_SYMBOLX1_1(op2, &bitD2);
+                HUF_DECODE_SYMBOLX1_1(op3, &bitD3);
+                HUF_DECODE_SYMBOLX1_1(op4, &bitD4);
+                HUF_DECODE_SYMBOLX1_2(op1, &bitD1);
+                HUF_DECODE_SYMBOLX1_2(op2, &bitD2);
+                HUF_DECODE_SYMBOLX1_2(op3, &bitD3);
+                HUF_DECODE_SYMBOLX1_2(op4, &bitD4);
+                HUF_DECODE_SYMBOLX1_0(op1, &bitD1);
+                HUF_DECODE_SYMBOLX1_0(op2, &bitD2);
+                HUF_DECODE_SYMBOLX1_0(op3, &bitD3);
+                HUF_DECODE_SYMBOLX1_0(op4, &bitD4);
+                endSignal &= BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished;
+                endSignal &= BIT_reloadDStreamFast(&bitD2) == BIT_DStream_unfinished;
+                endSignal &= BIT_reloadDStreamFast(&bitD3) == BIT_DStream_unfinished;
+                endSignal &= BIT_reloadDStreamFast(&bitD4) == BIT_DStream_unfinished;
+            }
         }
 
         /* check corruption */
@@ -440,6 +642,79 @@ HUF_decompress4X1_usingDTable_internal_body(
     }
 }
 
+#if HUF_NEED_BMI2_FUNCTION
+static BMI2_TARGET_ATTRIBUTE
+size_t HUF_decompress4X1_usingDTable_internal_bmi2(void* dst, size_t dstSize, void const* cSrc,
+                    size_t cSrcSize, HUF_DTable const* DTable) {
+    return HUF_decompress4X1_usingDTable_internal_body(dst, dstSize, cSrc, cSrcSize, DTable);
+}
+#endif
+
+#if HUF_NEED_DEFAULT_FUNCTION
+static
+size_t HUF_decompress4X1_usingDTable_internal_default(void* dst, size_t dstSize, void const* cSrc,
+                    size_t cSrcSize, HUF_DTable const* DTable) {
+    return HUF_decompress4X1_usingDTable_internal_body(dst, dstSize, cSrc, cSrcSize, DTable);
+}
+#endif
+
+#if ZSTD_ENABLE_ASM_X86_64_BMI2
+
+HUF_ASM_DECL void HUF_decompress4X1_usingDTable_internal_bmi2_asm_loop(HUF_DecompressAsmArgs* args) ZSTDLIB_HIDDEN;
+
+static HUF_ASM_X86_64_BMI2_ATTRS
+size_t
+HUF_decompress4X1_usingDTable_internal_bmi2_asm(
+          void* dst,  size_t dstSize,
+    const void* cSrc, size_t cSrcSize,
+    const HUF_DTable* DTable)
+{
+    void const* dt = DTable + 1;
+    const BYTE* const iend = (const BYTE*)cSrc + 6;
+    BYTE* const oend = (BYTE*)dst + dstSize;
+    HUF_DecompressAsmArgs args;
+    {
+        size_t const ret = HUF_DecompressAsmArgs_init(&args, dst, dstSize, cSrc, cSrcSize, DTable);
+        FORWARD_IF_ERROR(ret, "Failed to init asm args");
+        if (ret != 0)
+            return HUF_decompress4X1_usingDTable_internal_bmi2(dst, dstSize, cSrc, cSrcSize, DTable);
+    }
+
+    assert(args.ip[0] >= args.ilimit);
+    HUF_decompress4X1_usingDTable_internal_bmi2_asm_loop(&args);
+
+    /* Our loop guarantees that ip[] >= ilimit and that we haven't
+    * overwritten any op[].
+    */
+    assert(args.ip[0] >= iend);
+    assert(args.ip[1] >= iend);
+    assert(args.ip[2] >= iend);
+    assert(args.ip[3] >= iend);
+    assert(args.op[3] <= oend);
+    (void)iend;
+
+    /* finish bit streams one by one. */
+    {
+        size_t const segmentSize = (dstSize+3) / 4;
+        BYTE* segmentEnd = (BYTE*)dst;
+        int i;
+        for (i = 0; i < 4; ++i) {
+            BIT_DStream_t bit;
+            if (segmentSize <= (size_t)(oend - segmentEnd))
+                segmentEnd += segmentSize;
+            else
+                segmentEnd = oend;
+            FORWARD_IF_ERROR(HUF_initRemainingDStream(&bit, &args, i, segmentEnd), "corruption");
+            /* Decompress and validate that we've produced exactly the expected length. */
+            args.op[i] += HUF_decodeStreamX1(args.op[i], &bit, segmentEnd, (HUF_DEltX1 const*)dt, HUF_DECODER_FAST_TABLELOG);
+            if (args.op[i] != segmentEnd) return ERROR(corruption_detected);
+        }
+    }
+
+    /* decoded size */
+    return dstSize;
+}
+#endif /* ZSTD_ENABLE_ASM_X86_64_BMI2 */
 
 typedef size_t (*HUF_decompress_usingDTable_t)(void *dst, size_t dstSize,
                                                const void *cSrc,
@@ -447,8 +722,28 @@ typedef size_t (*HUF_decompress_usingDTable_t)(void *dst, size_t dstSize,
                                                const HUF_DTable *DTable);
 
 HUF_DGEN(HUF_decompress1X1_usingDTable_internal)
-HUF_DGEN(HUF_decompress4X1_usingDTable_internal)
 
+static size_t HUF_decompress4X1_usingDTable_internal(void* dst, size_t dstSize, void const* cSrc,
+                    size_t cSrcSize, HUF_DTable const* DTable, int bmi2)
+{
+#if DYNAMIC_BMI2
+    if (bmi2) {
+# if ZSTD_ENABLE_ASM_X86_64_BMI2
+        return HUF_decompress4X1_usingDTable_internal_bmi2_asm(dst, dstSize, cSrc, cSrcSize, DTable);
+# else
+        return HUF_decompress4X1_usingDTable_internal_bmi2(dst, dstSize, cSrc, cSrcSize, DTable);
+# endif
+    }
+#else
+    (void)bmi2;
+#endif
+
+#if ZSTD_ENABLE_ASM_X86_64_BMI2 && defined(__BMI2__)
+    return HUF_decompress4X1_usingDTable_internal_bmi2_asm(dst, dstSize, cSrc, cSrcSize, DTable);
+#else
+    return HUF_decompress4X1_usingDTable_internal_default(dst, dstSize, cSrc, cSrcSize, DTable);
+#endif
+}
 
 
 size_t HUF_decompress1X1_usingDTable(
@@ -518,106 +813,226 @@ size_t HUF_decompress4X1_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dstSize,
 /* *************************/
 
 typedef struct { U16 sequence; BYTE nbBits; BYTE length; } HUF_DEltX2;  /* double-symbols decoding */
-typedef struct { BYTE symbol; BYTE weight; } sortedSymbol_t;
+typedef struct { BYTE symbol; } sortedSymbol_t;
 typedef U32 rankValCol_t[HUF_TABLELOG_MAX + 1];
 typedef rankValCol_t rankVal_t[HUF_TABLELOG_MAX];
 
+/*
+ * Constructs a HUF_DEltX2 in a U32.
+ */
+static U32 HUF_buildDEltX2U32(U32 symbol, U32 nbBits, U32 baseSeq, int level)
+{
+    U32 seq;
+    DEBUG_STATIC_ASSERT(offsetof(HUF_DEltX2, sequence) == 0);
+    DEBUG_STATIC_ASSERT(offsetof(HUF_DEltX2, nbBits) == 2);
+    DEBUG_STATIC_ASSERT(offsetof(HUF_DEltX2, length) == 3);
+    DEBUG_STATIC_ASSERT(sizeof(HUF_DEltX2) == sizeof(U32));
+    if (MEM_isLittleEndian()) {
+        seq = level == 1 ? symbol : (baseSeq + (symbol << 8));
+        return seq + (nbBits << 16) + ((U32)level << 24);
+    } else {
+        seq = level == 1 ? (symbol << 8) : ((baseSeq << 8) + symbol);
+        return (seq << 16) + (nbBits << 8) + (U32)level;
+    }
+}
 
-/* HUF_fillDTableX2Level2() :
- * `rankValOrigin` must be a table of at least (HUF_TABLELOG_MAX + 1) U32 */
-static void HUF_fillDTableX2Level2(HUF_DEltX2* DTable, U32 sizeLog, const U32 consumed,
-                           const U32* rankValOrigin, const int minWeight,
-                           const sortedSymbol_t* sortedSymbols, const U32 sortedListSize,
-                           U32 nbBitsBaseline, U16 baseSeq, U32* wksp, size_t wkspSize)
+/*
+ * Constructs a HUF_DEltX2.
+ */
+static HUF_DEltX2 HUF_buildDEltX2(U32 symbol, U32 nbBits, U32 baseSeq, int level)
 {
     HUF_DEltX2 DElt;
-    U32* rankVal = wksp;
+    U32 const val = HUF_buildDEltX2U32(symbol, nbBits, baseSeq, level);
+    DEBUG_STATIC_ASSERT(sizeof(DElt) == sizeof(val));
+    ZSTD_memcpy(&DElt, &val, sizeof(val));
+    return DElt;
+}
+
+/*
+ * Constructs 2 HUF_DEltX2s and packs them into a U64.
+ */
+static U64 HUF_buildDEltX2U64(U32 symbol, U32 nbBits, U16 baseSeq, int level)
+{
+    U32 DElt = HUF_buildDEltX2U32(symbol, nbBits, baseSeq, level);
+    return (U64)DElt + ((U64)DElt << 32);
+}
 
-    assert(wkspSize >= HUF_TABLELOG_MAX + 1);
-    (void)wkspSize;
-    /* get pre-calculated rankVal */
-    ZSTD_memcpy(rankVal, rankValOrigin, sizeof(U32) * (HUF_TABLELOG_MAX + 1));
+/*
+ * Fills the DTable rank with all the symbols from [begin, end) that are each
+ * nbBits long.
+ *
+ * @param DTableRank The start of the rank in the DTable.
+ * @param begin The first symbol to fill (inclusive).
+ * @param end The last symbol to fill (exclusive).
+ * @param nbBits Each symbol is nbBits long.
+ * @param tableLog The table log.
+ * @param baseSeq If level == 1 { 0 } else { the first level symbol }
+ * @param level The level in the table. Must be 1 or 2.
+ */
+static void HUF_fillDTableX2ForWeight(
+    HUF_DEltX2* DTableRank,
+    sortedSymbol_t const* begin, sortedSymbol_t const* end,
+    U32 nbBits, U32 tableLog,
+    U16 baseSeq, int const level)
+{
+    U32 const length = 1U << ((tableLog - nbBits) & 0x1F /* quiet static-analyzer */);
+    const sortedSymbol_t* ptr;
+    assert(level >= 1 && level <= 2);
+    switch (length) {
+    case 1:
+        for (ptr = begin; ptr != end; ++ptr) {
+            HUF_DEltX2 const DElt = HUF_buildDEltX2(ptr->symbol, nbBits, baseSeq, level);
+            *DTableRank++ = DElt;
+        }
+        break;
+    case 2:
+        for (ptr = begin; ptr != end; ++ptr) {
+            HUF_DEltX2 const DElt = HUF_buildDEltX2(ptr->symbol, nbBits, baseSeq, level);
+            DTableRank[0] = DElt;
+            DTableRank[1] = DElt;
+            DTableRank += 2;
+        }
+        break;
+    case 4:
+        for (ptr = begin; ptr != end; ++ptr) {
+            U64 const DEltX2 = HUF_buildDEltX2U64(ptr->symbol, nbBits, baseSeq, level);
+            ZSTD_memcpy(DTableRank + 0, &DEltX2, sizeof(DEltX2));
+            ZSTD_memcpy(DTableRank + 2, &DEltX2, sizeof(DEltX2));
+            DTableRank += 4;
+        }
+        break;
+    case 8:
+        for (ptr = begin; ptr != end; ++ptr) {
+            U64 const DEltX2 = HUF_buildDEltX2U64(ptr->symbol, nbBits, baseSeq, level);
+            ZSTD_memcpy(DTableRank + 0, &DEltX2, sizeof(DEltX2));
+            ZSTD_memcpy(DTableRank + 2, &DEltX2, sizeof(DEltX2));
+            ZSTD_memcpy(DTableRank + 4, &DEltX2, sizeof(DEltX2));
+            ZSTD_memcpy(DTableRank + 6, &DEltX2, sizeof(DEltX2));
+            DTableRank += 8;
+        }
+        break;
+    default:
+        for (ptr = begin; ptr != end; ++ptr) {
+            U64 const DEltX2 = HUF_buildDEltX2U64(ptr->symbol, nbBits, baseSeq, level);
+            HUF_DEltX2* const DTableRankEnd = DTableRank + length;
+            for (; DTableRank != DTableRankEnd; DTableRank += 8) {
+                ZSTD_memcpy(DTableRank + 0, &DEltX2, sizeof(DEltX2));
+                ZSTD_memcpy(DTableRank + 2, &DEltX2, sizeof(DEltX2));
+                ZSTD_memcpy(DTableRank + 4, &DEltX2, sizeof(DEltX2));
+                ZSTD_memcpy(DTableRank + 6, &DEltX2, sizeof(DEltX2));
+            }
+        }
+        break;
+    }
+}
 
-    /* fill skipped values */
+/* HUF_fillDTableX2Level2() :
+ * `rankValOrigin` must be a table of at least (HUF_TABLELOG_MAX + 1) U32 */
+static void HUF_fillDTableX2Level2(HUF_DEltX2* DTable, U32 targetLog, const U32 consumedBits,
+                           const U32* rankVal, const int minWeight, const int maxWeight1,
+                           const sortedSymbol_t* sortedSymbols, U32 const* rankStart,
+                           U32 nbBitsBaseline, U16 baseSeq)
+{
+    /* Fill skipped values (all positions up to rankVal[minWeight]).
+     * These are positions only get a single symbol because the combined weight
+     * is too large.
+     */
     if (minWeight>1) {
-        U32 i, skipSize = rankVal[minWeight];
-        MEM_writeLE16(&(DElt.sequence), baseSeq);
-        DElt.nbBits   = (BYTE)(consumed);
-        DElt.length   = 1;
-        for (i = 0; i < skipSize; i++)
-            DTable[i] = DElt;
+        U32 const length = 1U << ((targetLog - consumedBits) & 0x1F /* quiet static-analyzer */);
+        U64 const DEltX2 = HUF_buildDEltX2U64(baseSeq, consumedBits, /* baseSeq */ 0, /* level */ 1);
+        int const skipSize = rankVal[minWeight];
+        assert(length > 1);
+        assert((U32)skipSize < length);
+        switch (length) {
+        case 2:
+            assert(skipSize == 1);
+            ZSTD_memcpy(DTable, &DEltX2, sizeof(DEltX2));
+            break;
+        case 4:
+            assert(skipSize <= 4);
+            ZSTD_memcpy(DTable + 0, &DEltX2, sizeof(DEltX2));
+            ZSTD_memcpy(DTable + 2, &DEltX2, sizeof(DEltX2));
+            break;
+        default:
+            {
+                int i;
+                for (i = 0; i < skipSize; i += 8) {
+                    ZSTD_memcpy(DTable + i + 0, &DEltX2, sizeof(DEltX2));
+                    ZSTD_memcpy(DTable + i + 2, &DEltX2, sizeof(DEltX2));
+                    ZSTD_memcpy(DTable + i + 4, &DEltX2, sizeof(DEltX2));
+                    ZSTD_memcpy(DTable + i + 6, &DEltX2, sizeof(DEltX2));
+                }
+            }
+        }
     }
 
-    /* fill DTable */
-    {   U32 s; for (s=0; s<sortedListSize; s++) {   /* note : sortedSymbols already skipped */
-            const U32 symbol = sortedSymbols[s].symbol;
-            const U32 weight = sortedSymbols[s].weight;
-            const U32 nbBits = nbBitsBaseline - weight;
-            const U32 length = 1 << (sizeLog-nbBits);
-            const U32 start = rankVal[weight];
-            U32 i = start;
-            const U32 end = start + length;
-
-            MEM_writeLE16(&(DElt.sequence), (U16)(baseSeq + (symbol << 8)));
-            DElt.nbBits = (BYTE)(nbBits + consumed);
-            DElt.length = 2;
-            do { DTable[i++] = DElt; } while (i<end);   /* since length >= 1 */
-
-            rankVal[weight] += length;
-    }   }
+    /* Fill each of the second level symbols by weight. */
+    {
+        int w;
+        for (w = minWeight; w < maxWeight1; ++w) {
+            int const begin = rankStart[w];
+            int const end = rankStart[w+1];
+            U32 const nbBits = nbBitsBaseline - w;
+            U32 const totalBits = nbBits + consumedBits;
+            HUF_fillDTableX2ForWeight(
+                DTable + rankVal[w],
+                sortedSymbols + begin, sortedSymbols + end,
+                totalBits, targetLog,
+                baseSeq, /* level */ 2);
+        }
+    }
 }
 
-
 static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
-                           const sortedSymbol_t* sortedList, const U32 sortedListSize,
+                           const sortedSymbol_t* sortedList,
                            const U32* rankStart, rankVal_t rankValOrigin, const U32 maxWeight,
-                           const U32 nbBitsBaseline, U32* wksp, size_t wkspSize)
+                           const U32 nbBitsBaseline)
 {
-    U32* rankVal = wksp;
+    U32* const rankVal = rankValOrigin[0];
     const int scaleLog = nbBitsBaseline - targetLog;   /* note : targetLog >= srcLog, hence scaleLog <= 1 */
     const U32 minBits  = nbBitsBaseline - maxWeight;
-    U32 s;
-
-    assert(wkspSize >= HUF_TABLELOG_MAX + 1);
-    wksp += HUF_TABLELOG_MAX + 1;
-    wkspSize -= HUF_TABLELOG_MAX + 1;
-
-    ZSTD_memcpy(rankVal, rankValOrigin, sizeof(U32) * (HUF_TABLELOG_MAX + 1));
-
-    /* fill DTable */
-    for (s=0; s<sortedListSize; s++) {
-        const U16 symbol = sortedList[s].symbol;
-        const U32 weight = sortedList[s].weight;
-        const U32 nbBits = nbBitsBaseline - weight;
-        const U32 start = rankVal[weight];
-        const U32 length = 1 << (targetLog-nbBits);
-
-        if (targetLog-nbBits >= minBits) {   /* enough room for a second symbol */
-            U32 sortedRank;
+    int w;
+    int const wEnd = (int)maxWeight + 1;
+
+    /* Fill DTable in order of weight. */
+    for (w = 1; w < wEnd; ++w) {
+        int const begin = (int)rankStart[w];
+        int const end = (int)rankStart[w+1];
+        U32 const nbBits = nbBitsBaseline - w;
+
+        if (targetLog-nbBits >= minBits) {
+            /* Enough room for a second symbol. */
+            int start = rankVal[w];
+            U32 const length = 1U << ((targetLog - nbBits) & 0x1F /* quiet static-analyzer */);
             int minWeight = nbBits + scaleLog;
+            int s;
             if (minWeight < 1) minWeight = 1;
-            sortedRank = rankStart[minWeight];
-            HUF_fillDTableX2Level2(DTable+start, targetLog-nbBits, nbBits,
-                           rankValOrigin[nbBits], minWeight,
-                           sortedList+sortedRank, sortedListSize-sortedRank,
-                           nbBitsBaseline, symbol, wksp, wkspSize);
+            /* Fill the DTable for every symbol of weight w.
+             * These symbols get at least 1 second symbol.
+             */
+            for (s = begin; s != end; ++s) {
+                HUF_fillDTableX2Level2(
+                    DTable + start, targetLog, nbBits,
+                    rankValOrigin[nbBits], minWeight, wEnd,
+                    sortedList, rankStart,
+                    nbBitsBaseline, sortedList[s].symbol);
+                start += length;
+            }
         } else {
-            HUF_DEltX2 DElt;
-            MEM_writeLE16(&(DElt.sequence), symbol);
-            DElt.nbBits = (BYTE)(nbBits);
-            DElt.length = 1;
-            {   U32 const end = start + length;
-                U32 u;
-                for (u = start; u < end; u++) DTable[u] = DElt;
-        }   }
-        rankVal[weight] += length;
+            /* Only a single symbol. */
+            HUF_fillDTableX2ForWeight(
+                DTable + rankVal[w],
+                sortedList + begin, sortedList + end,
+                nbBits, targetLog,
+                /* baseSeq */ 0, /* level */ 1);
+        }
     }
 }
 
 typedef struct {
     rankValCol_t rankVal[HUF_TABLELOG_MAX];
     U32 rankStats[HUF_TABLELOG_MAX + 1];
-    U32 rankStart0[HUF_TABLELOG_MAX + 2];
+    U32 rankStart0[HUF_TABLELOG_MAX + 3];
     sortedSymbol_t sortedSymbol[HUF_SYMBOLVALUE_MAX + 1];
     BYTE weightList[HUF_SYMBOLVALUE_MAX + 1];
     U32 calleeWksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
@@ -627,9 +1042,16 @@ size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
                        const void* src, size_t srcSize,
                              void* workSpace, size_t wkspSize)
 {
-    U32 tableLog, maxW, sizeOfSort, nbSymbols;
+    return HUF_readDTableX2_wksp_bmi2(DTable, src, srcSize, workSpace, wkspSize, /* bmi2 */ 0);
+}
+
+size_t HUF_readDTableX2_wksp_bmi2(HUF_DTable* DTable,
+                       const void* src, size_t srcSize,
+                             void* workSpace, size_t wkspSize, int bmi2)
+{
+    U32 tableLog, maxW, nbSymbols;
     DTableDesc dtd = HUF_getDTableDesc(DTable);
-    U32 const maxTableLog = dtd.maxTableLog;
+    U32 maxTableLog = dtd.maxTableLog;
     size_t iSize;
     void* dtPtr = DTable+1;   /* force compiler to avoid strict-aliasing */
     HUF_DEltX2* const dt = (HUF_DEltX2*)dtPtr;
@@ -647,11 +1069,12 @@ size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
     if (maxTableLog > HUF_TABLELOG_MAX) return ERROR(tableLog_tooLarge);
     /* ZSTD_memset(weightList, 0, sizeof(weightList)); */  /* is not necessary, even though some analyzer complain ... */
 
-    iSize = HUF_readStats_wksp(wksp->weightList, HUF_SYMBOLVALUE_MAX + 1, wksp->rankStats, &nbSymbols, &tableLog, src, srcSize, wksp->calleeWksp, sizeof(wksp->calleeWksp), /* bmi2 */ 0);
+    iSize = HUF_readStats_wksp(wksp->weightList, HUF_SYMBOLVALUE_MAX + 1, wksp->rankStats, &nbSymbols, &tableLog, src, srcSize, wksp->calleeWksp, sizeof(wksp->calleeWksp), bmi2);
     if (HUF_isError(iSize)) return iSize;
 
     /* check result */
     if (tableLog > maxTableLog) return ERROR(tableLog_tooLarge);   /* DTable can't fit code depth */
+    if (tableLog <= HUF_DECODER_FAST_TABLELOG && maxTableLog > HUF_DECODER_FAST_TABLELOG) maxTableLog = HUF_DECODER_FAST_TABLELOG;
 
     /* find maxWeight */
     for (maxW = tableLog; wksp->rankStats[maxW]==0; maxW--) {}  /* necessarily finds a solution before 0 */
@@ -664,7 +1087,7 @@ size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
             rankStart[w] = curr;
         }
         rankStart[0] = nextRankStart;   /* put all 0w symbols at the end of sorted list*/
-        sizeOfSort = nextRankStart;
+        rankStart[maxW+1] = nextRankStart;
     }
 
     /* sort symbols by weight */
@@ -673,7 +1096,6 @@ size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
             U32 const w = wksp->weightList[s];
             U32 const r = rankStart[w]++;
             wksp->sortedSymbol[r].symbol = (BYTE)s;
-            wksp->sortedSymbol[r].weight = (BYTE)w;
         }
         rankStart[0] = 0;   /* forget 0w symbols; this is beginning of weight(1) */
     }
@@ -698,10 +1120,9 @@ size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
     }   }   }   }
 
     HUF_fillDTableX2(dt, maxTableLog,
-                   wksp->sortedSymbol, sizeOfSort,
+                   wksp->sortedSymbol,
                    wksp->rankStart0, wksp->rankVal, maxW,
-                   tableLog+1,
-                   wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
+                   tableLog+1);
 
     dtd.tableLog = (BYTE)maxTableLog;
     dtd.tableType = 1;
@@ -714,7 +1135,7 @@ FORCE_INLINE_TEMPLATE U32
 HUF_decodeSymbolX2(void* op, BIT_DStream_t* DStream, const HUF_DEltX2* dt, const U32 dtLog)
 {
     size_t const val = BIT_lookBitsFast(DStream, dtLog);   /* note : dtLog >= 1 */
-    ZSTD_memcpy(op, dt+val, 2);
+    ZSTD_memcpy(op, &dt[val].sequence, 2);
     BIT_skipBits(DStream, dt[val].nbBits);
     return dt[val].length;
 }
@@ -723,15 +1144,17 @@ FORCE_INLINE_TEMPLATE U32
 HUF_decodeLastSymbolX2(void* op, BIT_DStream_t* DStream, const HUF_DEltX2* dt, const U32 dtLog)
 {
     size_t const val = BIT_lookBitsFast(DStream, dtLog);   /* note : dtLog >= 1 */
-    ZSTD_memcpy(op, dt+val, 1);
-    if (dt[val].length==1) BIT_skipBits(DStream, dt[val].nbBits);
-    else {
+    ZSTD_memcpy(op, &dt[val].sequence, 1);
+    if (dt[val].length==1) {
+        BIT_skipBits(DStream, dt[val].nbBits);
+    } else {
         if (DStream->bitsConsumed < (sizeof(DStream->bitContainer)*8)) {
             BIT_skipBits(DStream, dt[val].nbBits);
             if (DStream->bitsConsumed > (sizeof(DStream->bitContainer)*8))
                 /* ugly hack; works only because it's the last symbol. Note : can't easily extract nbBits from just this symbol */
                 DStream->bitsConsumed = (sizeof(DStream->bitContainer)*8);
-    }   }
+        }
+    }
     return 1;
 }
 
@@ -753,19 +1176,37 @@ HUF_decodeStreamX2(BYTE* p, BIT_DStream_t* bitDPtr, BYTE* const pEnd,
     BYTE* const pStart = p;
 
     /* up to 8 symbols at a time */
-    while ((BIT_reloadDStream(bitDPtr) == BIT_DStream_unfinished) & (p < pEnd-(sizeof(bitDPtr->bitContainer)-1))) {
-        HUF_DECODE_SYMBOLX2_2(p, bitDPtr);
-        HUF_DECODE_SYMBOLX2_1(p, bitDPtr);
-        HUF_DECODE_SYMBOLX2_2(p, bitDPtr);
-        HUF_DECODE_SYMBOLX2_0(p, bitDPtr);
+    if ((size_t)(pEnd - p) >= sizeof(bitDPtr->bitContainer)) {
+        if (dtLog <= 11 && MEM_64bits()) {
+            /* up to 10 symbols at a time */
+            while ((BIT_reloadDStream(bitDPtr) == BIT_DStream_unfinished) & (p < pEnd-9)) {
+                HUF_DECODE_SYMBOLX2_0(p, bitDPtr);
+                HUF_DECODE_SYMBOLX2_0(p, bitDPtr);
+                HUF_DECODE_SYMBOLX2_0(p, bitDPtr);
+                HUF_DECODE_SYMBOLX2_0(p, bitDPtr);
+                HUF_DECODE_SYMBOLX2_0(p, bitDPtr);
+            }
+        } else {
+            /* up to 8 symbols at a time */
+            while ((BIT_reloadDStream(bitDPtr) == BIT_DStream_unfinished) & (p < pEnd-(sizeof(bitDPtr->bitContainer)-1))) {
+                HUF_DECODE_SYMBOLX2_2(p, bitDPtr);
+                HUF_DECODE_SYMBOLX2_1(p, bitDPtr);
+                HUF_DECODE_SYMBOLX2_2(p, bitDPtr);
+                HUF_DECODE_SYMBOLX2_0(p, bitDPtr);
+            }
+        }
+    } else {
+        BIT_reloadDStream(bitDPtr);
     }
 
     /* closer to end : up to 2 symbols at a time */
-    while ((BIT_reloadDStream(bitDPtr) == BIT_DStream_unfinished) & (p <= pEnd-2))
-        HUF_DECODE_SYMBOLX2_0(p, bitDPtr);
+    if ((size_t)(pEnd - p) >= 2) {
+        while ((BIT_reloadDStream(bitDPtr) == BIT_DStream_unfinished) & (p <= pEnd-2))
+            HUF_DECODE_SYMBOLX2_0(p, bitDPtr);
 
-    while (p <= pEnd-2)
-        HUF_DECODE_SYMBOLX2_0(p, bitDPtr);   /* no need to reload : reached the end of DStream */
+        while (p <= pEnd-2)
+            HUF_DECODE_SYMBOLX2_0(p, bitDPtr);   /* no need to reload : reached the end of DStream */
+    }
 
     if (p < pEnd)
         p += HUF_decodeLastSymbolX2(p, bitDPtr, dt, dtLog);
@@ -799,7 +1240,6 @@ HUF_decompress1X2_usingDTable_internal_body(
     /* decoded size */
     return dstSize;
 }
-
 FORCE_INLINE_TEMPLATE size_t
 HUF_decompress4X2_usingDTable_internal_body(
           void* dst,  size_t dstSize,
@@ -841,57 +1281,60 @@ HUF_decompress4X2_usingDTable_internal_body(
         U32 const dtLog = dtd.tableLog;
 
         if (length4 > cSrcSize) return ERROR(corruption_detected);   /* overflow */
+        if (opStart4 > oend) return ERROR(corruption_detected);      /* overflow */
         CHECK_F( BIT_initDStream(&bitD1, istart1, length1) );
         CHECK_F( BIT_initDStream(&bitD2, istart2, length2) );
         CHECK_F( BIT_initDStream(&bitD3, istart3, length3) );
         CHECK_F( BIT_initDStream(&bitD4, istart4, length4) );
 
         /* 16-32 symbols per loop (4-8 symbols per stream) */
-        for ( ; (endSignal) & (op4 < olimit); ) {
+        if ((size_t)(oend - op4) >= sizeof(size_t)) {
+            for ( ; (endSignal) & (op4 < olimit); ) {
 #if defined(__clang__) && (defined(__x86_64__) || defined(__i386__))
-            HUF_DECODE_SYMBOLX2_2(op1, &bitD1);
-            HUF_DECODE_SYMBOLX2_1(op1, &bitD1);
-            HUF_DECODE_SYMBOLX2_2(op1, &bitD1);
-            HUF_DECODE_SYMBOLX2_0(op1, &bitD1);
-            HUF_DECODE_SYMBOLX2_2(op2, &bitD2);
-            HUF_DECODE_SYMBOLX2_1(op2, &bitD2);
-            HUF_DECODE_SYMBOLX2_2(op2, &bitD2);
-            HUF_DECODE_SYMBOLX2_0(op2, &bitD2);
-            endSignal &= BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished;
-            endSignal &= BIT_reloadDStreamFast(&bitD2) == BIT_DStream_unfinished;
-            HUF_DECODE_SYMBOLX2_2(op3, &bitD3);
-            HUF_DECODE_SYMBOLX2_1(op3, &bitD3);
-            HUF_DECODE_SYMBOLX2_2(op3, &bitD3);
-            HUF_DECODE_SYMBOLX2_0(op3, &bitD3);
-            HUF_DECODE_SYMBOLX2_2(op4, &bitD4);
-            HUF_DECODE_SYMBOLX2_1(op4, &bitD4);
-            HUF_DECODE_SYMBOLX2_2(op4, &bitD4);
-            HUF_DECODE_SYMBOLX2_0(op4, &bitD4);
-            endSignal &= BIT_reloadDStreamFast(&bitD3) == BIT_DStream_unfinished;
-            endSignal &= BIT_reloadDStreamFast(&bitD4) == BIT_DStream_unfinished;
+                HUF_DECODE_SYMBOLX2_2(op1, &bitD1);
+                HUF_DECODE_SYMBOLX2_1(op1, &bitD1);
+                HUF_DECODE_SYMBOLX2_2(op1, &bitD1);
+                HUF_DECODE_SYMBOLX2_0(op1, &bitD1);
+                HUF_DECODE_SYMBOLX2_2(op2, &bitD2);
+                HUF_DECODE_SYMBOLX2_1(op2, &bitD2);
+                HUF_DECODE_SYMBOLX2_2(op2, &bitD2);
+                HUF_DECODE_SYMBOLX2_0(op2, &bitD2);
+                endSignal &= BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished;
+                endSignal &= BIT_reloadDStreamFast(&bitD2) == BIT_DStream_unfinished;
+                HUF_DECODE_SYMBOLX2_2(op3, &bitD3);
+                HUF_DECODE_SYMBOLX2_1(op3, &bitD3);
+                HUF_DECODE_SYMBOLX2_2(op3, &bitD3);
+                HUF_DECODE_SYMBOLX2_0(op3, &bitD3);
+                HUF_DECODE_SYMBOLX2_2(op4, &bitD4);
+                HUF_DECODE_SYMBOLX2_1(op4, &bitD4);
+                HUF_DECODE_SYMBOLX2_2(op4, &bitD4);
+                HUF_DECODE_SYMBOLX2_0(op4, &bitD4);
+                endSignal &= BIT_reloadDStreamFast(&bitD3) == BIT_DStream_unfinished;
+                endSignal &= BIT_reloadDStreamFast(&bitD4) == BIT_DStream_unfinished;
 #else
-            HUF_DECODE_SYMBOLX2_2(op1, &bitD1);
-            HUF_DECODE_SYMBOLX2_2(op2, &bitD2);
-            HUF_DECODE_SYMBOLX2_2(op3, &bitD3);
-            HUF_DECODE_SYMBOLX2_2(op4, &bitD4);
-            HUF_DECODE_SYMBOLX2_1(op1, &bitD1);
-            HUF_DECODE_SYMBOLX2_1(op2, &bitD2);
-            HUF_DECODE_SYMBOLX2_1(op3, &bitD3);
-            HUF_DECODE_SYMBOLX2_1(op4, &bitD4);
-            HUF_DECODE_SYMBOLX2_2(op1, &bitD1);
-            HUF_DECODE_SYMBOLX2_2(op2, &bitD2);
-            HUF_DECODE_SYMBOLX2_2(op3, &bitD3);
-            HUF_DECODE_SYMBOLX2_2(op4, &bitD4);
-            HUF_DECODE_SYMBOLX2_0(op1, &bitD1);
-            HUF_DECODE_SYMBOLX2_0(op2, &bitD2);
-            HUF_DECODE_SYMBOLX2_0(op3, &bitD3);
-            HUF_DECODE_SYMBOLX2_0(op4, &bitD4);
-            endSignal = (U32)LIKELY((U32)
-                        (BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished)
-                      & (BIT_reloadDStreamFast(&bitD2) == BIT_DStream_unfinished)
-                      & (BIT_reloadDStreamFast(&bitD3) == BIT_DStream_unfinished)
-                      & (BIT_reloadDStreamFast(&bitD4) == BIT_DStream_unfinished));
+                HUF_DECODE_SYMBOLX2_2(op1, &bitD1);
+                HUF_DECODE_SYMBOLX2_2(op2, &bitD2);
+                HUF_DECODE_SYMBOLX2_2(op3, &bitD3);
+                HUF_DECODE_SYMBOLX2_2(op4, &bitD4);
+                HUF_DECODE_SYMBOLX2_1(op1, &bitD1);
+                HUF_DECODE_SYMBOLX2_1(op2, &bitD2);
+                HUF_DECODE_SYMBOLX2_1(op3, &bitD3);
+                HUF_DECODE_SYMBOLX2_1(op4, &bitD4);
+                HUF_DECODE_SYMBOLX2_2(op1, &bitD1);
+                HUF_DECODE_SYMBOLX2_2(op2, &bitD2);
+                HUF_DECODE_SYMBOLX2_2(op3, &bitD3);
+                HUF_DECODE_SYMBOLX2_2(op4, &bitD4);
+                HUF_DECODE_SYMBOLX2_0(op1, &bitD1);
+                HUF_DECODE_SYMBOLX2_0(op2, &bitD2);
+                HUF_DECODE_SYMBOLX2_0(op3, &bitD3);
+                HUF_DECODE_SYMBOLX2_0(op4, &bitD4);
+                endSignal = (U32)LIKELY((U32)
+                            (BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished)
+                        & (BIT_reloadDStreamFast(&bitD2) == BIT_DStream_unfinished)
+                        & (BIT_reloadDStreamFast(&bitD3) == BIT_DStream_unfinished)
+                        & (BIT_reloadDStreamFast(&bitD4) == BIT_DStream_unfinished));
 #endif
+            }
         }
 
         /* check corruption */
@@ -915,8 +1358,99 @@ HUF_decompress4X2_usingDTable_internal_body(
     }
 }
 
+#if HUF_NEED_BMI2_FUNCTION
+static BMI2_TARGET_ATTRIBUTE
+size_t HUF_decompress4X2_usingDTable_internal_bmi2(void* dst, size_t dstSize, void const* cSrc,
+                    size_t cSrcSize, HUF_DTable const* DTable) {
+    return HUF_decompress4X2_usingDTable_internal_body(dst, dstSize, cSrc, cSrcSize, DTable);
+}
+#endif
+
+#if HUF_NEED_DEFAULT_FUNCTION
+static
+size_t HUF_decompress4X2_usingDTable_internal_default(void* dst, size_t dstSize, void const* cSrc,
+                    size_t cSrcSize, HUF_DTable const* DTable) {
+    return HUF_decompress4X2_usingDTable_internal_body(dst, dstSize, cSrc, cSrcSize, DTable);
+}
+#endif
+
+#if ZSTD_ENABLE_ASM_X86_64_BMI2
+
+HUF_ASM_DECL void HUF_decompress4X2_usingDTable_internal_bmi2_asm_loop(HUF_DecompressAsmArgs* args) ZSTDLIB_HIDDEN;
+
+static HUF_ASM_X86_64_BMI2_ATTRS size_t
+HUF_decompress4X2_usingDTable_internal_bmi2_asm(
+          void* dst,  size_t dstSize,
+    const void* cSrc, size_t cSrcSize,
+    const HUF_DTable* DTable) {
+    void const* dt = DTable + 1;
+    const BYTE* const iend = (const BYTE*)cSrc + 6;
+    BYTE* const oend = (BYTE*)dst + dstSize;
+    HUF_DecompressAsmArgs args;
+    {
+        size_t const ret = HUF_DecompressAsmArgs_init(&args, dst, dstSize, cSrc, cSrcSize, DTable);
+        FORWARD_IF_ERROR(ret, "Failed to init asm args");
+        if (ret != 0)
+            return HUF_decompress4X2_usingDTable_internal_bmi2(dst, dstSize, cSrc, cSrcSize, DTable);
+    }
+
+    assert(args.ip[0] >= args.ilimit);
+    HUF_decompress4X2_usingDTable_internal_bmi2_asm_loop(&args);
+
+    /* note : op4 already verified within main loop */
+    assert(args.ip[0] >= iend);
+    assert(args.ip[1] >= iend);
+    assert(args.ip[2] >= iend);
+    assert(args.ip[3] >= iend);
+    assert(args.op[3] <= oend);
+    (void)iend;
+
+    /* finish bitStreams one by one */
+    {
+        size_t const segmentSize = (dstSize+3) / 4;
+        BYTE* segmentEnd = (BYTE*)dst;
+        int i;
+        for (i = 0; i < 4; ++i) {
+            BIT_DStream_t bit;
+            if (segmentSize <= (size_t)(oend - segmentEnd))
+                segmentEnd += segmentSize;
+            else
+                segmentEnd = oend;
+            FORWARD_IF_ERROR(HUF_initRemainingDStream(&bit, &args, i, segmentEnd), "corruption");
+            args.op[i] += HUF_decodeStreamX2(args.op[i], &bit, segmentEnd, (HUF_DEltX2 const*)dt, HUF_DECODER_FAST_TABLELOG);
+            if (args.op[i] != segmentEnd)
+                return ERROR(corruption_detected);
+        }
+    }
+
+    /* decoded size */
+    return dstSize;
+}
+#endif /* ZSTD_ENABLE_ASM_X86_64_BMI2 */
+
+static size_t HUF_decompress4X2_usingDTable_internal(void* dst, size_t dstSize, void const* cSrc,
+                    size_t cSrcSize, HUF_DTable const* DTable, int bmi2)
+{
+#if DYNAMIC_BMI2
+    if (bmi2) {
+# if ZSTD_ENABLE_ASM_X86_64_BMI2
+        return HUF_decompress4X2_usingDTable_internal_bmi2_asm(dst, dstSize, cSrc, cSrcSize, DTable);
+# else
+        return HUF_decompress4X2_usingDTable_internal_bmi2(dst, dstSize, cSrc, cSrcSize, DTable);
+# endif
+    }
+#else
+    (void)bmi2;
+#endif
+
+#if ZSTD_ENABLE_ASM_X86_64_BMI2 && defined(__BMI2__)
+    return HUF_decompress4X2_usingDTable_internal_bmi2_asm(dst, dstSize, cSrc, cSrcSize, DTable);
+#else
+    return HUF_decompress4X2_usingDTable_internal_default(dst, dstSize, cSrc, cSrcSize, DTable);
+#endif
+}
+
 HUF_DGEN(HUF_decompress1X2_usingDTable_internal)
-HUF_DGEN(HUF_decompress4X2_usingDTable_internal)
 
 size_t HUF_decompress1X2_usingDTable(
           void* dst,  size_t dstSize,
@@ -1025,25 +1559,25 @@ size_t HUF_decompress4X_usingDTable(void* dst, size_t maxDstSize,
 
 #if !defined(HUF_FORCE_DECOMPRESS_X1) && !defined(HUF_FORCE_DECOMPRESS_X2)
 typedef struct { U32 tableTime; U32 decode256Time; } algo_time_t;
-static const algo_time_t algoTime[16 /* Quantization */][3 /* single, double, quad */] =
+static const algo_time_t algoTime[16 /* Quantization */][2 /* single, double */] =
 {
     /* single, double, quad */
-    {{0,0}, {1,1}, {2,2}},  /* Q==0 : impossible */
-    {{0,0}, {1,1}, {2,2}},  /* Q==1 : impossible */
-    {{  38,130}, {1313, 74}, {2151, 38}},   /* Q == 2 : 12-18% */
-    {{ 448,128}, {1353, 74}, {2238, 41}},   /* Q == 3 : 18-25% */
-    {{ 556,128}, {1353, 74}, {2238, 47}},   /* Q == 4 : 25-32% */
-    {{ 714,128}, {1418, 74}, {2436, 53}},   /* Q == 5 : 32-38% */
-    {{ 883,128}, {1437, 74}, {2464, 61}},   /* Q == 6 : 38-44% */
-    {{ 897,128}, {1515, 75}, {2622, 68}},   /* Q == 7 : 44-50% */
-    {{ 926,128}, {1613, 75}, {2730, 75}},   /* Q == 8 : 50-56% */
-    {{ 947,128}, {1729, 77}, {3359, 77}},   /* Q == 9 : 56-62% */
-    {{1107,128}, {2083, 81}, {4006, 84}},   /* Q ==10 : 62-69% */
-    {{1177,128}, {2379, 87}, {4785, 88}},   /* Q ==11 : 69-75% */
-    {{1242,128}, {2415, 93}, {5155, 84}},   /* Q ==12 : 75-81% */
-    {{1349,128}, {2644,106}, {5260,106}},   /* Q ==13 : 81-87% */
-    {{1455,128}, {2422,124}, {4174,124}},   /* Q ==14 : 87-93% */
-    {{ 722,128}, {1891,145}, {1936,146}},   /* Q ==15 : 93-99% */
+    {{0,0}, {1,1}},  /* Q==0 : impossible */
+    {{0,0}, {1,1}},  /* Q==1 : impossible */
+    {{ 150,216}, { 381,119}},   /* Q == 2 : 12-18% */
+    {{ 170,205}, { 514,112}},   /* Q == 3 : 18-25% */
+    {{ 177,199}, { 539,110}},   /* Q == 4 : 25-32% */
+    {{ 197,194}, { 644,107}},   /* Q == 5 : 32-38% */
+    {{ 221,192}, { 735,107}},   /* Q == 6 : 38-44% */
+    {{ 256,189}, { 881,106}},   /* Q == 7 : 44-50% */
+    {{ 359,188}, {1167,109}},   /* Q == 8 : 50-56% */
+    {{ 582,187}, {1570,114}},   /* Q == 9 : 56-62% */
+    {{ 688,187}, {1712,122}},   /* Q ==10 : 62-69% */
+    {{ 825,186}, {1965,136}},   /* Q ==11 : 69-75% */
+    {{ 976,185}, {2131,150}},   /* Q ==12 : 75-81% */
+    {{1180,186}, {2070,175}},   /* Q ==13 : 81-87% */
+    {{1377,185}, {1731,202}},   /* Q ==14 : 87-93% */
+    {{1412,185}, {1695,202}},   /* Q ==15 : 93-99% */
 };
 #endif
 
@@ -1070,7 +1604,7 @@ U32 HUF_selectDecoder (size_t dstSize, size_t cSrcSize)
         U32 const D256 = (U32)(dstSize >> 8);
         U32 const DTime0 = algoTime[Q][0].tableTime + (algoTime[Q][0].decode256Time * D256);
         U32 DTime1 = algoTime[Q][1].tableTime + (algoTime[Q][1].decode256Time * D256);
-        DTime1 += DTime1 >> 3;  /* advantage to algorithm using less memory, to reduce cache eviction */
+        DTime1 += DTime1 >> 5;  /* small advantage to algorithm using less memory, to reduce cache eviction */
         return DTime1 < DTime0;
     }
 #endif
diff --git a/lib/zstd/decompress/zstd_decompress.c b/lib/zstd/decompress/zstd_decompress.c
index b4d81d84479a..b9b935a9f5c0 100644
--- a/lib/zstd/decompress/zstd_decompress.c
+++ b/lib/zstd/decompress/zstd_decompress.c
@@ -53,7 +53,6 @@
 *  Dependencies
 *********************************************************/
 #include "../common/zstd_deps.h"   /* ZSTD_memcpy, ZSTD_memmove, ZSTD_memset */
-#include "../common/cpu.h"         /* bmi2 */
 #include "../common/mem.h"         /* low level memory routines */
 #define FSE_STATIC_LINKING_ONLY
 #include "../common/fse.h"
@@ -252,11 +251,11 @@ static void ZSTD_initDCtx_internal(ZSTD_DCtx* dctx)
     dctx->inBuffSize  = 0;
     dctx->outBuffSize = 0;
     dctx->streamStage = zdss_init;
-    dctx->legacyContext = NULL;
-    dctx->previousLegacyVersion = 0;
     dctx->noForwardProgress = 0;
     dctx->oversizedDuration = 0;
-    dctx->bmi2 = ZSTD_cpuid_bmi2(ZSTD_cpuid());
+#if DYNAMIC_BMI2
+    dctx->bmi2 = ZSTD_cpuSupportsBmi2();
+#endif
     dctx->ddictSet = NULL;
     ZSTD_DCtx_resetParameters(dctx);
 #ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
@@ -277,8 +276,7 @@ ZSTD_DCtx* ZSTD_initStaticDCtx(void *workspace, size_t workspaceSize)
     return dctx;
 }
 
-ZSTD_DCtx* ZSTD_createDCtx_advanced(ZSTD_customMem customMem)
-{
+static ZSTD_DCtx* ZSTD_createDCtx_internal(ZSTD_customMem customMem) {
     if ((!customMem.customAlloc) ^ (!customMem.customFree)) return NULL;
 
     {   ZSTD_DCtx* const dctx = (ZSTD_DCtx*)ZSTD_customMalloc(sizeof(*dctx), customMem);
@@ -289,10 +287,15 @@ ZSTD_DCtx* ZSTD_createDCtx_advanced(ZSTD_customMem customMem)
     }
 }
 
+ZSTD_DCtx* ZSTD_createDCtx_advanced(ZSTD_customMem customMem)
+{
+    return ZSTD_createDCtx_internal(customMem);
+}
+
 ZSTD_DCtx* ZSTD_createDCtx(void)
 {
     DEBUGLOG(3, "ZSTD_createDCtx");
-    return ZSTD_createDCtx_advanced(ZSTD_defaultCMem);
+    return ZSTD_createDCtx_internal(ZSTD_defaultCMem);
 }
 
 static void ZSTD_clearDict(ZSTD_DCtx* dctx)
@@ -370,6 +373,19 @@ unsigned ZSTD_isFrame(const void* buffer, size_t size)
     return 0;
 }
 
+/*! ZSTD_isSkippableFrame() :
+ *  Tells if the content of `buffer` starts with a valid Frame Identifier for a skippable frame.
+ *  Note : Frame Identifier is 4 bytes. If `size < 4`, @return will always be 0.
+ */
+unsigned ZSTD_isSkippableFrame(const void* buffer, size_t size)
+{
+    if (size < ZSTD_FRAMEIDSIZE) return 0;
+    {   U32 const magic = MEM_readLE32(buffer);
+        if ((magic & ZSTD_MAGIC_SKIPPABLE_MASK) == ZSTD_MAGIC_SKIPPABLE_START) return 1;
+    }
+    return 0;
+}
+
 /* ZSTD_frameHeaderSize_internal() :
  *  srcSize must be large enough to reach header size fields.
  *  note : only works for formats ZSTD_f_zstd1 and ZSTD_f_zstd1_magicless.
@@ -497,7 +513,6 @@ size_t ZSTD_getFrameHeader(ZSTD_frameHeader* zfhPtr, const void* src, size_t src
     return ZSTD_getFrameHeader_advanced(zfhPtr, src, srcSize, ZSTD_f_zstd1);
 }
 
-
 /* ZSTD_getFrameContentSize() :
  *  compatible with legacy mode
  * @return : decompressed size of the single frame pointed to be `src` if known, otherwise
@@ -532,6 +547,37 @@ static size_t readSkippableFrameSize(void const* src, size_t srcSize)
     }
 }
 
+/*! ZSTD_readSkippableFrame() :
+ * Retrieves a zstd skippable frame containing data given by src, and writes it to dst buffer.
+ *
+ * The parameter magicVariant will receive the magicVariant that was supplied when the frame was written,
+ * i.e. magicNumber - ZSTD_MAGIC_SKIPPABLE_START.  This can be NULL if the caller is not interested
+ * in the magicVariant.
+ *
+ * Returns an error if destination buffer is not large enough, or if the frame is not skippable.
+ *
+ * @return : number of bytes written or a ZSTD error.
+ */
+ZSTDLIB_API size_t ZSTD_readSkippableFrame(void* dst, size_t dstCapacity, unsigned* magicVariant,
+                                            const void* src, size_t srcSize)
+{
+    U32 const magicNumber = MEM_readLE32(src);
+    size_t skippableFrameSize = readSkippableFrameSize(src, srcSize);
+    size_t skippableContentSize = skippableFrameSize - ZSTD_SKIPPABLEHEADERSIZE;
+
+    /* check input validity */
+    RETURN_ERROR_IF(!ZSTD_isSkippableFrame(src, srcSize), frameParameter_unsupported, "");
+    RETURN_ERROR_IF(skippableFrameSize < ZSTD_SKIPPABLEHEADERSIZE || skippableFrameSize > srcSize, srcSize_wrong, "");
+    RETURN_ERROR_IF(skippableContentSize > dstCapacity, dstSize_tooSmall, "");
+
+    /* deliver payload */
+    if (skippableContentSize > 0  && dst != NULL)
+        ZSTD_memcpy(dst, (const BYTE *)src + ZSTD_SKIPPABLEHEADERSIZE, skippableContentSize);
+    if (magicVariant != NULL)
+        *magicVariant = magicNumber - ZSTD_MAGIC_SKIPPABLE_START;
+    return skippableContentSize;
+}
+
 /* ZSTD_findDecompressedSize() :
  *  compatible with legacy mode
  *  `srcSize` must be the exact length of some number of ZSTD compressed and/or
@@ -824,7 +870,7 @@ static size_t ZSTD_decompressFrame(ZSTD_DCtx* dctx,
         switch(blockProperties.blockType)
         {
         case bt_compressed:
-            decodedSize = ZSTD_decompressBlock_internal(dctx, op, (size_t)(oend-op), ip, cBlockSize, /* frame */ 1);
+            decodedSize = ZSTD_decompressBlock_internal(dctx, op, (size_t)(oend-op), ip, cBlockSize, /* frame */ 1, not_streaming);
             break;
         case bt_raw :
             decodedSize = ZSTD_copyRawBlock(op, (size_t)(oend-op), ip, cBlockSize);
@@ -976,7 +1022,7 @@ size_t ZSTD_decompress(void* dst, size_t dstCapacity, const void* src, size_t sr
 {
 #if defined(ZSTD_HEAPMODE) && (ZSTD_HEAPMODE>=1)
     size_t regenSize;
-    ZSTD_DCtx* const dctx = ZSTD_createDCtx();
+    ZSTD_DCtx* const dctx =  ZSTD_createDCtx_internal(ZSTD_defaultCMem);
     RETURN_ERROR_IF(dctx==NULL, memory_allocation, "NULL pointer!");
     regenSize = ZSTD_decompressDCtx(dctx, dst, dstCapacity, src, srcSize);
     ZSTD_freeDCtx(dctx);
@@ -996,7 +1042,7 @@ size_t ZSTD_decompress(void* dst, size_t dstCapacity, const void* src, size_t sr
 size_t ZSTD_nextSrcSizeToDecompress(ZSTD_DCtx* dctx) { return dctx->expected; }
 
 /*
- * Similar to ZSTD_nextSrcSizeToDecompress(), but when when a block input can be streamed,
+ * Similar to ZSTD_nextSrcSizeToDecompress(), but when a block input can be streamed,
  * we allow taking a partial block as the input. Currently only raw uncompressed blocks can
  * be streamed.
  *
@@ -1010,7 +1056,7 @@ static size_t ZSTD_nextSrcSizeToDecompressWithInputSize(ZSTD_DCtx* dctx, size_t
         return dctx->expected;
     if (dctx->bType != bt_raw)
         return dctx->expected;
-    return MIN(MAX(inputSize, 1), dctx->expected);
+    return BOUNDED(1, inputSize, dctx->expected);
 }
 
 ZSTD_nextInputType_e ZSTD_nextInputType(ZSTD_DCtx* dctx) {
@@ -1116,7 +1162,7 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx* dctx, void* dst, size_t dstCapacity, c
             {
             case bt_compressed:
                 DEBUGLOG(5, "ZSTD_decompressContinue: case bt_compressed");
-                rSize = ZSTD_decompressBlock_internal(dctx, dst, dstCapacity, src, srcSize, /* frame */ 1);
+                rSize = ZSTD_decompressBlock_internal(dctx, dst, dstCapacity, src, srcSize, /* frame */ 1, is_streaming);
                 dctx->expected = 0;  /* Streaming not supported */
                 break;
             case bt_raw :
@@ -1438,7 +1484,7 @@ size_t ZSTD_decompress_usingDDict(ZSTD_DCtx* dctx,
 ZSTD_DStream* ZSTD_createDStream(void)
 {
     DEBUGLOG(3, "ZSTD_createDStream");
-    return ZSTD_createDStream_advanced(ZSTD_defaultCMem);
+    return ZSTD_createDCtx_internal(ZSTD_defaultCMem);
 }
 
 ZSTD_DStream* ZSTD_initStaticDStream(void *workspace, size_t workspaceSize)
@@ -1448,7 +1494,7 @@ ZSTD_DStream* ZSTD_initStaticDStream(void *workspace, size_t workspaceSize)
 
 ZSTD_DStream* ZSTD_createDStream_advanced(ZSTD_customMem customMem)
 {
-    return ZSTD_createDCtx_advanced(customMem);
+    return ZSTD_createDCtx_internal(customMem);
 }
 
 size_t ZSTD_freeDStream(ZSTD_DStream* zds)
@@ -1708,7 +1754,8 @@ size_t ZSTD_sizeof_DStream(const ZSTD_DStream* dctx)
 size_t ZSTD_decodingBufferSize_min(unsigned long long windowSize, unsigned long long frameContentSize)
 {
     size_t const blockSize = (size_t) MIN(windowSize, ZSTD_BLOCKSIZE_MAX);
-    unsigned long long const neededRBSize = windowSize + blockSize + (WILDCOPY_OVERLENGTH * 2);
+    /* space is needed to store the litbuffer after the output of a given block without stomping the extDict of a previous run, as well as to cover both windows against wildcopy*/
+    unsigned long long const neededRBSize = windowSize + blockSize + ZSTD_BLOCKSIZE_MAX + (WILDCOPY_OVERLENGTH * 2);
     unsigned long long const neededSize = MIN(frameContentSize, neededRBSize);
     size_t const minRBSize = (size_t) neededSize;
     RETURN_ERROR_IF((unsigned long long)minRBSize != neededSize,
@@ -1842,7 +1889,6 @@ size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_outBuffer* output, ZSTD_inB
             DEBUGLOG(5, "stage zdss_init => transparent reset ");
             zds->streamStage = zdss_loadHeader;
             zds->lhSize = zds->inPos = zds->outStart = zds->outEnd = 0;
-            zds->legacyVersion = 0;
             zds->hostageByte = 0;
             zds->expectedOutBuffer = *output;
             ZSTD_FALLTHROUGH;
diff --git a/lib/zstd/decompress/zstd_decompress_block.c b/lib/zstd/decompress/zstd_decompress_block.c
index 2d101d9a842e..c1913b8e7c89 100644
--- a/lib/zstd/decompress/zstd_decompress_block.c
+++ b/lib/zstd/decompress/zstd_decompress_block.c
@@ -69,15 +69,56 @@ size_t ZSTD_getcBlockSize(const void* src, size_t srcSize,
     }
 }
 
+/* Allocate buffer for literals, either overlapping current dst, or split between dst and litExtraBuffer, or stored entirely within litExtraBuffer */
+static void ZSTD_allocateLiteralsBuffer(ZSTD_DCtx* dctx, void* const dst, const size_t dstCapacity, const size_t litSize,
+    const streaming_operation streaming, const size_t expectedWriteSize, const unsigned splitImmediately)
+{
+    if (streaming == not_streaming && dstCapacity > ZSTD_BLOCKSIZE_MAX + WILDCOPY_OVERLENGTH + litSize + WILDCOPY_OVERLENGTH)
+    {
+        /* room for litbuffer to fit without read faulting */
+        dctx->litBuffer = (BYTE*)dst + ZSTD_BLOCKSIZE_MAX + WILDCOPY_OVERLENGTH;
+        dctx->litBufferEnd = dctx->litBuffer + litSize;
+        dctx->litBufferLocation = ZSTD_in_dst;
+    }
+    else if (litSize > ZSTD_LITBUFFEREXTRASIZE)
+    {
+        /* won't fit in litExtraBuffer, so it will be split between end of dst and extra buffer */
+        if (splitImmediately) {
+            /* won't fit in litExtraBuffer, so it will be split between end of dst and extra buffer */
+            dctx->litBuffer = (BYTE*)dst + expectedWriteSize - litSize + ZSTD_LITBUFFEREXTRASIZE - WILDCOPY_OVERLENGTH;
+            dctx->litBufferEnd = dctx->litBuffer + litSize - ZSTD_LITBUFFEREXTRASIZE;
+        }
+        else {
+            /* initially this will be stored entirely in dst during huffman decoding, it will partially shifted to litExtraBuffer after */
+            dctx->litBuffer = (BYTE*)dst + expectedWriteSize - litSize;
+            dctx->litBufferEnd = (BYTE*)dst + expectedWriteSize;
+        }
+        dctx->litBufferLocation = ZSTD_split;
+    }
+    else
+    {
+        /* fits entirely within litExtraBuffer, so no split is necessary */
+        dctx->litBuffer = dctx->litExtraBuffer;
+        dctx->litBufferEnd = dctx->litBuffer + litSize;
+        dctx->litBufferLocation = ZSTD_not_in_dst;
+    }
+}
 
 /* Hidden declaration for fullbench */
 size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
-                          const void* src, size_t srcSize);
+                          const void* src, size_t srcSize,
+                          void* dst, size_t dstCapacity, const streaming_operation streaming);
 /*! ZSTD_decodeLiteralsBlock() :
+ * Where it is possible to do so without being stomped by the output during decompression, the literals block will be stored
+ * in the dstBuffer.  If there is room to do so, it will be stored in full in the excess dst space after where the current
+ * block will be output.  Otherwise it will be stored at the end of the current dst blockspace, with a small portion being
+ * stored in dctx->litExtraBuffer to help keep it "ahead" of the current output write.
+ *
  * @return : nb of bytes read from src (< srcSize )
  *  note : symbol not declared but exposed for fullbench */
 size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
-                          const void* src, size_t srcSize)   /* note : srcSize < BLOCKSIZE */
+                          const void* src, size_t srcSize,   /* note : srcSize < BLOCKSIZE */
+                          void* dst, size_t dstCapacity, const streaming_operation streaming)
 {
     DEBUGLOG(5, "ZSTD_decodeLiteralsBlock");
     RETURN_ERROR_IF(srcSize < MIN_CBLOCK_SIZE, corruption_detected, "");
@@ -99,6 +140,7 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                 U32 const lhlCode = (istart[0] >> 2) & 3;
                 U32 const lhc = MEM_readLE32(istart);
                 size_t hufSuccess;
+                size_t expectedWriteSize = MIN(ZSTD_BLOCKSIZE_MAX, dstCapacity);
                 switch(lhlCode)
                 {
                 case 0: case 1: default:   /* note : default is impossible, since lhlCode into [0..3] */
@@ -121,8 +163,11 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                     litCSize = (lhc >> 22) + ((size_t)istart[4] << 10);
                     break;
                 }
+                RETURN_ERROR_IF(litSize > 0 && dst == NULL, dstSize_tooSmall, "NULL not handled");
                 RETURN_ERROR_IF(litSize > ZSTD_BLOCKSIZE_MAX, corruption_detected, "");
                 RETURN_ERROR_IF(litCSize + lhSize > srcSize, corruption_detected, "");
+                RETURN_ERROR_IF(expectedWriteSize < litSize , dstSize_tooSmall, "");
+                ZSTD_allocateLiteralsBuffer(dctx, dst, dstCapacity, litSize, streaming, expectedWriteSize, 0);
 
                 /* prefetch huffman table if cold */
                 if (dctx->ddictIsCold && (litSize > 768 /* heuristic */)) {
@@ -133,11 +178,11 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                     if (singleStream) {
                         hufSuccess = HUF_decompress1X_usingDTable_bmi2(
                             dctx->litBuffer, litSize, istart+lhSize, litCSize,
-                            dctx->HUFptr, dctx->bmi2);
+                            dctx->HUFptr, ZSTD_DCtx_get_bmi2(dctx));
                     } else {
                         hufSuccess = HUF_decompress4X_usingDTable_bmi2(
                             dctx->litBuffer, litSize, istart+lhSize, litCSize,
-                            dctx->HUFptr, dctx->bmi2);
+                            dctx->HUFptr, ZSTD_DCtx_get_bmi2(dctx));
                     }
                 } else {
                     if (singleStream) {
@@ -150,15 +195,22 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                         hufSuccess = HUF_decompress1X1_DCtx_wksp_bmi2(
                             dctx->entropy.hufTable, dctx->litBuffer, litSize,
                             istart+lhSize, litCSize, dctx->workspace,
-                            sizeof(dctx->workspace), dctx->bmi2);
+                            sizeof(dctx->workspace), ZSTD_DCtx_get_bmi2(dctx));
 #endif
                     } else {
                         hufSuccess = HUF_decompress4X_hufOnly_wksp_bmi2(
                             dctx->entropy.hufTable, dctx->litBuffer, litSize,
                             istart+lhSize, litCSize, dctx->workspace,
-                            sizeof(dctx->workspace), dctx->bmi2);
+                            sizeof(dctx->workspace), ZSTD_DCtx_get_bmi2(dctx));
                     }
                 }
+                if (dctx->litBufferLocation == ZSTD_split)
+                {
+                    ZSTD_memcpy(dctx->litExtraBuffer, dctx->litBufferEnd - ZSTD_LITBUFFEREXTRASIZE, ZSTD_LITBUFFEREXTRASIZE);
+                    ZSTD_memmove(dctx->litBuffer + ZSTD_LITBUFFEREXTRASIZE - WILDCOPY_OVERLENGTH, dctx->litBuffer, litSize - ZSTD_LITBUFFEREXTRASIZE);
+                    dctx->litBuffer += ZSTD_LITBUFFEREXTRASIZE - WILDCOPY_OVERLENGTH;
+                    dctx->litBufferEnd -= WILDCOPY_OVERLENGTH;
+                }
 
                 RETURN_ERROR_IF(HUF_isError(hufSuccess), corruption_detected, "");
 
@@ -166,13 +218,13 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                 dctx->litSize = litSize;
                 dctx->litEntropy = 1;
                 if (litEncType==set_compressed) dctx->HUFptr = dctx->entropy.hufTable;
-                ZSTD_memset(dctx->litBuffer + dctx->litSize, 0, WILDCOPY_OVERLENGTH);
                 return litCSize + lhSize;
             }
 
         case set_basic:
             {   size_t litSize, lhSize;
                 U32 const lhlCode = ((istart[0]) >> 2) & 3;
+                size_t expectedWriteSize = MIN(ZSTD_BLOCKSIZE_MAX, dstCapacity);
                 switch(lhlCode)
                 {
                 case 0: case 2: default:   /* note : default is impossible, since lhlCode into [0..3] */
@@ -189,23 +241,36 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                     break;
                 }
 
+                RETURN_ERROR_IF(litSize > 0 && dst == NULL, dstSize_tooSmall, "NULL not handled");
+                RETURN_ERROR_IF(expectedWriteSize < litSize, dstSize_tooSmall, "");
+                ZSTD_allocateLiteralsBuffer(dctx, dst, dstCapacity, litSize, streaming, expectedWriteSize, 1);
                 if (lhSize+litSize+WILDCOPY_OVERLENGTH > srcSize) {  /* risk reading beyond src buffer with wildcopy */
                     RETURN_ERROR_IF(litSize+lhSize > srcSize, corruption_detected, "");
-                    ZSTD_memcpy(dctx->litBuffer, istart+lhSize, litSize);
+                    if (dctx->litBufferLocation == ZSTD_split)
+                    {
+                        ZSTD_memcpy(dctx->litBuffer, istart + lhSize, litSize - ZSTD_LITBUFFEREXTRASIZE);
+                        ZSTD_memcpy(dctx->litExtraBuffer, istart + lhSize + litSize - ZSTD_LITBUFFEREXTRASIZE, ZSTD_LITBUFFEREXTRASIZE);
+                    }
+                    else
+                    {
+                        ZSTD_memcpy(dctx->litBuffer, istart + lhSize, litSize);
+                    }
                     dctx->litPtr = dctx->litBuffer;
                     dctx->litSize = litSize;
-                    ZSTD_memset(dctx->litBuffer + dctx->litSize, 0, WILDCOPY_OVERLENGTH);
                     return lhSize+litSize;
                 }
                 /* direct reference into compressed stream */
                 dctx->litPtr = istart+lhSize;
                 dctx->litSize = litSize;
+                dctx->litBufferEnd = dctx->litPtr + litSize;
+                dctx->litBufferLocation = ZSTD_not_in_dst;
                 return lhSize+litSize;
             }
 
         case set_rle:
             {   U32 const lhlCode = ((istart[0]) >> 2) & 3;
                 size_t litSize, lhSize;
+                size_t expectedWriteSize = MIN(ZSTD_BLOCKSIZE_MAX, dstCapacity);
                 switch(lhlCode)
                 {
                 case 0: case 2: default:   /* note : default is impossible, since lhlCode into [0..3] */
@@ -222,8 +287,19 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx* dctx,
                     RETURN_ERROR_IF(srcSize<4, corruption_detected, "srcSize >= MIN_CBLOCK_SIZE == 3; here we need lhSize+1 = 4");
                     break;
                 }
+                RETURN_ERROR_IF(litSize > 0 && dst == NULL, dstSize_tooSmall, "NULL not handled");
                 RETURN_ERROR_IF(litSize > ZSTD_BLOCKSIZE_MAX, corruption_detected, "");
-                ZSTD_memset(dctx->litBuffer, istart[lhSize], litSize + WILDCOPY_OVERLENGTH);
+                RETURN_ERROR_IF(expectedWriteSize < litSize, dstSize_tooSmall, "");
+                ZSTD_allocateLiteralsBuffer(dctx, dst, dstCapacity, litSize, streaming, expectedWriteSize, 1);
+                if (dctx->litBufferLocation == ZSTD_split)
+                {
+                    ZSTD_memset(dctx->litBuffer, istart[lhSize], litSize - ZSTD_LITBUFFEREXTRASIZE);
+                    ZSTD_memset(dctx->litExtraBuffer, istart[lhSize], ZSTD_LITBUFFEREXTRASIZE);
+                }
+                else
+                {
+                    ZSTD_memset(dctx->litBuffer, istart[lhSize], litSize);
+                }
                 dctx->litPtr = dctx->litBuffer;
                 dctx->litSize = litSize;
                 return lhSize+1;
@@ -343,7 +419,7 @@ static const ZSTD_seqSymbol ML_defaultDTable[(1<<ML_DEFAULTNORMLOG)+1] = {
 };   /* ML_defaultDTable */
 
 
-static void ZSTD_buildSeqTable_rle(ZSTD_seqSymbol* dt, U32 baseValue, U32 nbAddBits)
+static void ZSTD_buildSeqTable_rle(ZSTD_seqSymbol* dt, U32 baseValue, U8 nbAddBits)
 {
     void* ptr = dt;
     ZSTD_seqSymbol_header* const DTableH = (ZSTD_seqSymbol_header*)ptr;
@@ -355,7 +431,7 @@ static void ZSTD_buildSeqTable_rle(ZSTD_seqSymbol* dt, U32 baseValue, U32 nbAddB
     cell->nbBits = 0;
     cell->nextState = 0;
     assert(nbAddBits < 255);
-    cell->nbAdditionalBits = (BYTE)nbAddBits;
+    cell->nbAdditionalBits = nbAddBits;
     cell->baseValue = baseValue;
 }
 
@@ -367,7 +443,7 @@ static void ZSTD_buildSeqTable_rle(ZSTD_seqSymbol* dt, U32 baseValue, U32 nbAddB
 FORCE_INLINE_TEMPLATE
 void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
             const short* normalizedCounter, unsigned maxSymbolValue,
-            const U32* baseValue, const U32* nbAdditionalBits,
+            const U32* baseValue, const U8* nbAdditionalBits,
             unsigned tableLog, void* wksp, size_t wkspSize)
 {
     ZSTD_seqSymbol* const tableDecode = dt+1;
@@ -478,7 +554,7 @@ void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
             tableDecode[u].nbBits = (BYTE) (tableLog - BIT_highbit32(nextState) );
             tableDecode[u].nextState = (U16) ( (nextState << tableDecode[u].nbBits) - tableSize);
             assert(nbAdditionalBits[symbol] < 255);
-            tableDecode[u].nbAdditionalBits = (BYTE)nbAdditionalBits[symbol];
+            tableDecode[u].nbAdditionalBits = nbAdditionalBits[symbol];
             tableDecode[u].baseValue = baseValue[symbol];
         }
     }
@@ -487,7 +563,7 @@ void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
 /* Avoids the FORCE_INLINE of the _body() function. */
 static void ZSTD_buildFSETable_body_default(ZSTD_seqSymbol* dt,
             const short* normalizedCounter, unsigned maxSymbolValue,
-            const U32* baseValue, const U32* nbAdditionalBits,
+            const U32* baseValue, const U8* nbAdditionalBits,
             unsigned tableLog, void* wksp, size_t wkspSize)
 {
     ZSTD_buildFSETable_body(dt, normalizedCounter, maxSymbolValue,
@@ -495,9 +571,9 @@ static void ZSTD_buildFSETable_body_default(ZSTD_seqSymbol* dt,
 }
 
 #if DYNAMIC_BMI2
-TARGET_ATTRIBUTE("bmi2") static void ZSTD_buildFSETable_body_bmi2(ZSTD_seqSymbol* dt,
+BMI2_TARGET_ATTRIBUTE static void ZSTD_buildFSETable_body_bmi2(ZSTD_seqSymbol* dt,
             const short* normalizedCounter, unsigned maxSymbolValue,
-            const U32* baseValue, const U32* nbAdditionalBits,
+            const U32* baseValue, const U8* nbAdditionalBits,
             unsigned tableLog, void* wksp, size_t wkspSize)
 {
     ZSTD_buildFSETable_body(dt, normalizedCounter, maxSymbolValue,
@@ -507,7 +583,7 @@ TARGET_ATTRIBUTE("bmi2") static void ZSTD_buildFSETable_body_bmi2(ZSTD_seqSymbol
 
 void ZSTD_buildFSETable(ZSTD_seqSymbol* dt,
             const short* normalizedCounter, unsigned maxSymbolValue,
-            const U32* baseValue, const U32* nbAdditionalBits,
+            const U32* baseValue, const U8* nbAdditionalBits,
             unsigned tableLog, void* wksp, size_t wkspSize, int bmi2)
 {
 #if DYNAMIC_BMI2
@@ -529,7 +605,7 @@ void ZSTD_buildFSETable(ZSTD_seqSymbol* dt,
 static size_t ZSTD_buildSeqTable(ZSTD_seqSymbol* DTableSpace, const ZSTD_seqSymbol** DTablePtr,
                                  symbolEncodingType_e type, unsigned max, U32 maxLog,
                                  const void* src, size_t srcSize,
-                                 const U32* baseValue, const U32* nbAdditionalBits,
+                                 const U32* baseValue, const U8* nbAdditionalBits,
                                  const ZSTD_seqSymbol* defaultTable, U32 flagRepeatTable,
                                  int ddictIsCold, int nbSeq, U32* wksp, size_t wkspSize,
                                  int bmi2)
@@ -541,7 +617,7 @@ static size_t ZSTD_buildSeqTable(ZSTD_seqSymbol* DTableSpace, const ZSTD_seqSymb
         RETURN_ERROR_IF((*(const BYTE*)src) > max, corruption_detected, "");
         {   U32 const symbol = *(const BYTE*)src;
             U32 const baseline = baseValue[symbol];
-            U32 const nbBits = nbAdditionalBits[symbol];
+            U8 const nbBits = nbAdditionalBits[symbol];
             ZSTD_buildSeqTable_rle(DTableSpace, baseline, nbBits);
         }
         *DTablePtr = DTableSpace;
@@ -620,7 +696,7 @@ size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx* dctx, int* nbSeqPtr,
                                                       LL_defaultDTable, dctx->fseEntropy,
                                                       dctx->ddictIsCold, nbSeq,
                                                       dctx->workspace, sizeof(dctx->workspace),
-                                                      dctx->bmi2);
+                                                      ZSTD_DCtx_get_bmi2(dctx));
             RETURN_ERROR_IF(ZSTD_isError(llhSize), corruption_detected, "ZSTD_buildSeqTable failed");
             ip += llhSize;
         }
@@ -632,7 +708,7 @@ size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx* dctx, int* nbSeqPtr,
                                                       OF_defaultDTable, dctx->fseEntropy,
                                                       dctx->ddictIsCold, nbSeq,
                                                       dctx->workspace, sizeof(dctx->workspace),
-                                                      dctx->bmi2);
+                                                      ZSTD_DCtx_get_bmi2(dctx));
             RETURN_ERROR_IF(ZSTD_isError(ofhSize), corruption_detected, "ZSTD_buildSeqTable failed");
             ip += ofhSize;
         }
@@ -644,7 +720,7 @@ size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx* dctx, int* nbSeqPtr,
                                                       ML_defaultDTable, dctx->fseEntropy,
                                                       dctx->ddictIsCold, nbSeq,
                                                       dctx->workspace, sizeof(dctx->workspace),
-                                                      dctx->bmi2);
+                                                      ZSTD_DCtx_get_bmi2(dctx));
             RETURN_ERROR_IF(ZSTD_isError(mlhSize), corruption_detected, "ZSTD_buildSeqTable failed");
             ip += mlhSize;
         }
@@ -658,7 +734,6 @@ typedef struct {
     size_t litLength;
     size_t matchLength;
     size_t offset;
-    const BYTE* match;
 } seq_t;
 
 typedef struct {
@@ -672,9 +747,6 @@ typedef struct {
     ZSTD_fseState stateOffb;
     ZSTD_fseState stateML;
     size_t prevOffset[ZSTD_REP_NUM];
-    const BYTE* prefixStart;
-    const BYTE* dictEnd;
-    size_t pos;
 } seqState_t;
 
 /*! ZSTD_overlapCopy8() :
@@ -717,7 +789,7 @@ HINT_INLINE void ZSTD_overlapCopy8(BYTE** op, BYTE const** ip, size_t offset) {
  *         - ZSTD_overlap_src_before_dst: The src and dst may overlap and may be any distance apart.
  *           The src buffer must be before the dst buffer.
  */
-static void ZSTD_safecopy(BYTE* op, BYTE* const oend_w, BYTE const* ip, ptrdiff_t length, ZSTD_overlap_e ovtype) {
+static void ZSTD_safecopy(BYTE* op, const BYTE* const oend_w, BYTE const* ip, ptrdiff_t length, ZSTD_overlap_e ovtype) {
     ptrdiff_t const diff = op - ip;
     BYTE* const oend = op + length;
 
@@ -733,6 +805,7 @@ static void ZSTD_safecopy(BYTE* op, BYTE* const oend_w, BYTE const* ip, ptrdiff_
         /* Copy 8 bytes and ensure the offset >= 8 when there can be overlap. */
         assert(length >= 8);
         ZSTD_overlapCopy8(&op, &ip, diff);
+        length -= 8;
         assert(op - ip >= 8);
         assert(op <= oend);
     }
@@ -747,8 +820,31 @@ static void ZSTD_safecopy(BYTE* op, BYTE* const oend_w, BYTE const* ip, ptrdiff_
         assert(oend > oend_w);
         ZSTD_wildcopy(op, ip, oend_w - op, ovtype);
         ip += oend_w - op;
-        op = oend_w;
+        op += oend_w - op;
+    }
+    /* Handle the leftovers. */
+    while (op < oend) *op++ = *ip++;
+}
+
+/* ZSTD_safecopyDstBeforeSrc():
+ * This version allows overlap with dst before src, or handles the non-overlap case with dst after src
+ * Kept separate from more common ZSTD_safecopy case to avoid performance impact to the safecopy common case */
+static void ZSTD_safecopyDstBeforeSrc(BYTE* op, BYTE const* ip, ptrdiff_t length) {
+    ptrdiff_t const diff = op - ip;
+    BYTE* const oend = op + length;
+
+    if (length < 8 || diff > -8) {
+        /* Handle short lengths, close overlaps, and dst not before src. */
+        while (op < oend) *op++ = *ip++;
+        return;
+    }
+
+    if (op <= oend - WILDCOPY_OVERLENGTH && diff < -WILDCOPY_VECLEN) {
+        ZSTD_wildcopy(op, ip, oend - WILDCOPY_OVERLENGTH - op, ZSTD_no_overlap);
+        ip += oend - WILDCOPY_OVERLENGTH - op;
+        op += oend - WILDCOPY_OVERLENGTH - op;
     }
+
     /* Handle the leftovers. */
     while (op < oend) *op++ = *ip++;
 }
@@ -763,9 +859,9 @@ static void ZSTD_safecopy(BYTE* op, BYTE* const oend_w, BYTE const* ip, ptrdiff_
  */
 FORCE_NOINLINE
 size_t ZSTD_execSequenceEnd(BYTE* op,
-                            BYTE* const oend, seq_t sequence,
-                            const BYTE** litPtr, const BYTE* const litLimit,
-                            const BYTE* const prefixStart, const BYTE* const virtualStart, const BYTE* const dictEnd)
+    BYTE* const oend, seq_t sequence,
+    const BYTE** litPtr, const BYTE* const litLimit,
+    const BYTE* const prefixStart, const BYTE* const virtualStart, const BYTE* const dictEnd)
 {
     BYTE* const oLitEnd = op + sequence.litLength;
     size_t const sequenceLength = sequence.litLength + sequence.matchLength;
@@ -788,27 +884,76 @@ size_t ZSTD_execSequenceEnd(BYTE* op,
     if (sequence.offset > (size_t)(oLitEnd - prefixStart)) {
         /* offset beyond prefix */
         RETURN_ERROR_IF(sequence.offset > (size_t)(oLitEnd - virtualStart), corruption_detected, "");
-        match = dictEnd - (prefixStart-match);
+        match = dictEnd - (prefixStart - match);
         if (match + sequence.matchLength <= dictEnd) {
             ZSTD_memmove(oLitEnd, match, sequence.matchLength);
             return sequenceLength;
         }
         /* span extDict & currentPrefixSegment */
         {   size_t const length1 = dictEnd - match;
-            ZSTD_memmove(oLitEnd, match, length1);
-            op = oLitEnd + length1;
-            sequence.matchLength -= length1;
-            match = prefixStart;
-    }   }
+        ZSTD_memmove(oLitEnd, match, length1);
+        op = oLitEnd + length1;
+        sequence.matchLength -= length1;
+        match = prefixStart;
+        }
+    }
+    ZSTD_safecopy(op, oend_w, match, sequence.matchLength, ZSTD_overlap_src_before_dst);
+    return sequenceLength;
+}
+
+/* ZSTD_execSequenceEndSplitLitBuffer():
+ * This version is intended to be used during instances where the litBuffer is still split.  It is kept separate to avoid performance impact for the good case.
+ */
+FORCE_NOINLINE
+size_t ZSTD_execSequenceEndSplitLitBuffer(BYTE* op,
+    BYTE* const oend, const BYTE* const oend_w, seq_t sequence,
+    const BYTE** litPtr, const BYTE* const litLimit,
+    const BYTE* const prefixStart, const BYTE* const virtualStart, const BYTE* const dictEnd)
+{
+    BYTE* const oLitEnd = op + sequence.litLength;
+    size_t const sequenceLength = sequence.litLength + sequence.matchLength;
+    const BYTE* const iLitEnd = *litPtr + sequence.litLength;
+    const BYTE* match = oLitEnd - sequence.offset;
+
+
+    /* bounds checks : careful of address space overflow in 32-bit mode */
+    RETURN_ERROR_IF(sequenceLength > (size_t)(oend - op), dstSize_tooSmall, "last match must fit within dstBuffer");
+    RETURN_ERROR_IF(sequence.litLength > (size_t)(litLimit - *litPtr), corruption_detected, "try to read beyond literal buffer");
+    assert(op < op + sequenceLength);
+    assert(oLitEnd < op + sequenceLength);
+
+    /* copy literals */
+    RETURN_ERROR_IF(op > *litPtr && op < *litPtr + sequence.litLength, dstSize_tooSmall, "output should not catch up to and overwrite literal buffer");
+    ZSTD_safecopyDstBeforeSrc(op, *litPtr, sequence.litLength);
+    op = oLitEnd;
+    *litPtr = iLitEnd;
+
+    /* copy Match */
+    if (sequence.offset > (size_t)(oLitEnd - prefixStart)) {
+        /* offset beyond prefix */
+        RETURN_ERROR_IF(sequence.offset > (size_t)(oLitEnd - virtualStart), corruption_detected, "");
+        match = dictEnd - (prefixStart - match);
+        if (match + sequence.matchLength <= dictEnd) {
+            ZSTD_memmove(oLitEnd, match, sequence.matchLength);
+            return sequenceLength;
+        }
+        /* span extDict & currentPrefixSegment */
+        {   size_t const length1 = dictEnd - match;
+        ZSTD_memmove(oLitEnd, match, length1);
+        op = oLitEnd + length1;
+        sequence.matchLength -= length1;
+        match = prefixStart;
+        }
+    }
     ZSTD_safecopy(op, oend_w, match, sequence.matchLength, ZSTD_overlap_src_before_dst);
     return sequenceLength;
 }
 
 HINT_INLINE
 size_t ZSTD_execSequence(BYTE* op,
-                         BYTE* const oend, seq_t sequence,
-                         const BYTE** litPtr, const BYTE* const litLimit,
-                         const BYTE* const prefixStart, const BYTE* const virtualStart, const BYTE* const dictEnd)
+    BYTE* const oend, seq_t sequence,
+    const BYTE** litPtr, const BYTE* const litLimit,
+    const BYTE* const prefixStart, const BYTE* const virtualStart, const BYTE* const dictEnd)
 {
     BYTE* const oLitEnd = op + sequence.litLength;
     size_t const sequenceLength = sequence.litLength + sequence.matchLength;
@@ -817,6 +962,98 @@ size_t ZSTD_execSequence(BYTE* op,
     const BYTE* const iLitEnd = *litPtr + sequence.litLength;
     const BYTE* match = oLitEnd - sequence.offset;
 
+    assert(op != NULL /* Precondition */);
+    assert(oend_w < oend /* No underflow */);
+    /* Handle edge cases in a slow path:
+     *   - Read beyond end of literals
+     *   - Match end is within WILDCOPY_OVERLIMIT of oend
+     *   - 32-bit mode and the match length overflows
+     */
+    if (UNLIKELY(
+        iLitEnd > litLimit ||
+        oMatchEnd > oend_w ||
+        (MEM_32bits() && (size_t)(oend - op) < sequenceLength + WILDCOPY_OVERLENGTH)))
+        return ZSTD_execSequenceEnd(op, oend, sequence, litPtr, litLimit, prefixStart, virtualStart, dictEnd);
+
+    /* Assumptions (everything else goes into ZSTD_execSequenceEnd()) */
+    assert(op <= oLitEnd /* No overflow */);
+    assert(oLitEnd < oMatchEnd /* Non-zero match & no overflow */);
+    assert(oMatchEnd <= oend /* No underflow */);
+    assert(iLitEnd <= litLimit /* Literal length is in bounds */);
+    assert(oLitEnd <= oend_w /* Can wildcopy literals */);
+    assert(oMatchEnd <= oend_w /* Can wildcopy matches */);
+
+    /* Copy Literals:
+     * Split out litLength <= 16 since it is nearly always true. +1.6% on gcc-9.
+     * We likely don't need the full 32-byte wildcopy.
+     */
+    assert(WILDCOPY_OVERLENGTH >= 16);
+    ZSTD_copy16(op, (*litPtr));
+    if (UNLIKELY(sequence.litLength > 16)) {
+        ZSTD_wildcopy(op + 16, (*litPtr) + 16, sequence.litLength - 16, ZSTD_no_overlap);
+    }
+    op = oLitEnd;
+    *litPtr = iLitEnd;   /* update for next sequence */
+
+    /* Copy Match */
+    if (sequence.offset > (size_t)(oLitEnd - prefixStart)) {
+        /* offset beyond prefix -> go into extDict */
+        RETURN_ERROR_IF(UNLIKELY(sequence.offset > (size_t)(oLitEnd - virtualStart)), corruption_detected, "");
+        match = dictEnd + (match - prefixStart);
+        if (match + sequence.matchLength <= dictEnd) {
+            ZSTD_memmove(oLitEnd, match, sequence.matchLength);
+            return sequenceLength;
+        }
+        /* span extDict & currentPrefixSegment */
+        {   size_t const length1 = dictEnd - match;
+        ZSTD_memmove(oLitEnd, match, length1);
+        op = oLitEnd + length1;
+        sequence.matchLength -= length1;
+        match = prefixStart;
+        }
+    }
+    /* Match within prefix of 1 or more bytes */
+    assert(op <= oMatchEnd);
+    assert(oMatchEnd <= oend_w);
+    assert(match >= prefixStart);
+    assert(sequence.matchLength >= 1);
+
+    /* Nearly all offsets are >= WILDCOPY_VECLEN bytes, which means we can use wildcopy
+     * without overlap checking.
+     */
+    if (LIKELY(sequence.offset >= WILDCOPY_VECLEN)) {
+        /* We bet on a full wildcopy for matches, since we expect matches to be
+         * longer than literals (in general). In silesia, ~10% of matches are longer
+         * than 16 bytes.
+         */
+        ZSTD_wildcopy(op, match, (ptrdiff_t)sequence.matchLength, ZSTD_no_overlap);
+        return sequenceLength;
+    }
+    assert(sequence.offset < WILDCOPY_VECLEN);
+
+    /* Copy 8 bytes and spread the offset to be >= 8. */
+    ZSTD_overlapCopy8(&op, &match, sequence.offset);
+
+    /* If the match length is > 8 bytes, then continue with the wildcopy. */
+    if (sequence.matchLength > 8) {
+        assert(op < oMatchEnd);
+        ZSTD_wildcopy(op, match, (ptrdiff_t)sequence.matchLength - 8, ZSTD_overlap_src_before_dst);
+    }
+    return sequenceLength;
+}
+
+HINT_INLINE
+size_t ZSTD_execSequenceSplitLitBuffer(BYTE* op,
+    BYTE* const oend, const BYTE* const oend_w, seq_t sequence,
+    const BYTE** litPtr, const BYTE* const litLimit,
+    const BYTE* const prefixStart, const BYTE* const virtualStart, const BYTE* const dictEnd)
+{
+    BYTE* const oLitEnd = op + sequence.litLength;
+    size_t const sequenceLength = sequence.litLength + sequence.matchLength;
+    BYTE* const oMatchEnd = op + sequenceLength;   /* risk : address space overflow (32-bits) */
+    const BYTE* const iLitEnd = *litPtr + sequence.litLength;
+    const BYTE* match = oLitEnd - sequence.offset;
+
     assert(op != NULL /* Precondition */);
     assert(oend_w < oend /* No underflow */);
     /* Handle edge cases in a slow path:
@@ -828,7 +1065,7 @@ size_t ZSTD_execSequence(BYTE* op,
             iLitEnd > litLimit ||
             oMatchEnd > oend_w ||
             (MEM_32bits() && (size_t)(oend - op) < sequenceLength + WILDCOPY_OVERLENGTH)))
-        return ZSTD_execSequenceEnd(op, oend, sequence, litPtr, litLimit, prefixStart, virtualStart, dictEnd);
+        return ZSTD_execSequenceEndSplitLitBuffer(op, oend, oend_w, sequence, litPtr, litLimit, prefixStart, virtualStart, dictEnd);
 
     /* Assumptions (everything else goes into ZSTD_execSequenceEnd()) */
     assert(op <= oLitEnd /* No overflow */);
@@ -896,6 +1133,7 @@ size_t ZSTD_execSequence(BYTE* op,
     return sequenceLength;
 }
 
+
 static void
 ZSTD_initFseState(ZSTD_fseState* DStatePtr, BIT_DStream_t* bitD, const ZSTD_seqSymbol* dt)
 {
@@ -909,20 +1147,10 @@ ZSTD_initFseState(ZSTD_fseState* DStatePtr, BIT_DStream_t* bitD, const ZSTD_seqS
 }
 
 FORCE_INLINE_TEMPLATE void
-ZSTD_updateFseState(ZSTD_fseState* DStatePtr, BIT_DStream_t* bitD)
-{
-    ZSTD_seqSymbol const DInfo = DStatePtr->table[DStatePtr->state];
-    U32 const nbBits = DInfo.nbBits;
-    size_t const lowBits = BIT_readBits(bitD, nbBits);
-    DStatePtr->state = DInfo.nextState + lowBits;
-}
-
-FORCE_INLINE_TEMPLATE void
-ZSTD_updateFseStateWithDInfo(ZSTD_fseState* DStatePtr, BIT_DStream_t* bitD, ZSTD_seqSymbol const DInfo)
+ZSTD_updateFseStateWithDInfo(ZSTD_fseState* DStatePtr, BIT_DStream_t* bitD, U16 nextState, U32 nbBits)
 {
-    U32 const nbBits = DInfo.nbBits;
     size_t const lowBits = BIT_readBits(bitD, nbBits);
-    DStatePtr->state = DInfo.nextState + lowBits;
+    DStatePtr->state = nextState + lowBits;
 }
 
 /* We need to add at most (ZSTD_WINDOWLOG_MAX_32 - 1) bits to read the maximum
@@ -936,116 +1164,105 @@ ZSTD_updateFseStateWithDInfo(ZSTD_fseState* DStatePtr, BIT_DStream_t* bitD, ZSTD
         : 0)
 
 typedef enum { ZSTD_lo_isRegularOffset, ZSTD_lo_isLongOffset=1 } ZSTD_longOffset_e;
-typedef enum { ZSTD_p_noPrefetch=0, ZSTD_p_prefetch=1 } ZSTD_prefetch_e;
 
 FORCE_INLINE_TEMPLATE seq_t
-ZSTD_decodeSequence(seqState_t* seqState, const ZSTD_longOffset_e longOffsets, const ZSTD_prefetch_e prefetch)
+ZSTD_decodeSequence(seqState_t* seqState, const ZSTD_longOffset_e longOffsets)
 {
     seq_t seq;
-    ZSTD_seqSymbol const llDInfo = seqState->stateLL.table[seqState->stateLL.state];
-    ZSTD_seqSymbol const mlDInfo = seqState->stateML.table[seqState->stateML.state];
-    ZSTD_seqSymbol const ofDInfo = seqState->stateOffb.table[seqState->stateOffb.state];
-    U32 const llBase = llDInfo.baseValue;
-    U32 const mlBase = mlDInfo.baseValue;
-    U32 const ofBase = ofDInfo.baseValue;
-    BYTE const llBits = llDInfo.nbAdditionalBits;
-    BYTE const mlBits = mlDInfo.nbAdditionalBits;
-    BYTE const ofBits = ofDInfo.nbAdditionalBits;
-    BYTE const totalBits = llBits+mlBits+ofBits;
-
-    /* sequence */
-    {   size_t offset;
-        if (ofBits > 1) {
-            ZSTD_STATIC_ASSERT(ZSTD_lo_isLongOffset == 1);
-            ZSTD_STATIC_ASSERT(LONG_OFFSETS_MAX_EXTRA_BITS_32 == 5);
-            assert(ofBits <= MaxOff);
-            if (MEM_32bits() && longOffsets && (ofBits >= STREAM_ACCUMULATOR_MIN_32)) {
-                U32 const extraBits = ofBits - MIN(ofBits, 32 - seqState->DStream.bitsConsumed);
-                offset = ofBase + (BIT_readBitsFast(&seqState->DStream, ofBits - extraBits) << extraBits);
-                BIT_reloadDStream(&seqState->DStream);
-                if (extraBits) offset += BIT_readBitsFast(&seqState->DStream, extraBits);
-                assert(extraBits <= LONG_OFFSETS_MAX_EXTRA_BITS_32);   /* to avoid another reload */
-            } else {
-                offset = ofBase + BIT_readBitsFast(&seqState->DStream, ofBits/*>0*/);   /* <=  (ZSTD_WINDOWLOG_MAX-1) bits */
-                if (MEM_32bits()) BIT_reloadDStream(&seqState->DStream);
-            }
-            seqState->prevOffset[2] = seqState->prevOffset[1];
-            seqState->prevOffset[1] = seqState->prevOffset[0];
-            seqState->prevOffset[0] = offset;
-        } else {
-            U32 const ll0 = (llBase == 0);
-            if (LIKELY((ofBits == 0))) {
-                if (LIKELY(!ll0))
-                    offset = seqState->prevOffset[0];
-                else {
-                    offset = seqState->prevOffset[1];
-                    seqState->prevOffset[1] = seqState->prevOffset[0];
-                    seqState->prevOffset[0] = offset;
+    const ZSTD_seqSymbol* const llDInfo = seqState->stateLL.table + seqState->stateLL.state;
+    const ZSTD_seqSymbol* const mlDInfo = seqState->stateML.table + seqState->stateML.state;
+    const ZSTD_seqSymbol* const ofDInfo = seqState->stateOffb.table + seqState->stateOffb.state;
+    seq.matchLength = mlDInfo->baseValue;
+    seq.litLength = llDInfo->baseValue;
+    {   U32 const ofBase = ofDInfo->baseValue;
+        BYTE const llBits = llDInfo->nbAdditionalBits;
+        BYTE const mlBits = mlDInfo->nbAdditionalBits;
+        BYTE const ofBits = ofDInfo->nbAdditionalBits;
+        BYTE const totalBits = llBits+mlBits+ofBits;
+
+        U16 const llNext = llDInfo->nextState;
+        U16 const mlNext = mlDInfo->nextState;
+        U16 const ofNext = ofDInfo->nextState;
+        U32 const llnbBits = llDInfo->nbBits;
+        U32 const mlnbBits = mlDInfo->nbBits;
+        U32 const ofnbBits = ofDInfo->nbBits;
+        /*
+         * As gcc has better branch and block analyzers, sometimes it is only
+         * valuable to mark likelyness for clang, it gives around 3-4% of
+         * performance.
+         */
+
+        /* sequence */
+        {   size_t offset;
+    #if defined(__clang__)
+            if (LIKELY(ofBits > 1)) {
+    #else
+            if (ofBits > 1) {
+    #endif
+                ZSTD_STATIC_ASSERT(ZSTD_lo_isLongOffset == 1);
+                ZSTD_STATIC_ASSERT(LONG_OFFSETS_MAX_EXTRA_BITS_32 == 5);
+                assert(ofBits <= MaxOff);
+                if (MEM_32bits() && longOffsets && (ofBits >= STREAM_ACCUMULATOR_MIN_32)) {
+                    U32 const extraBits = ofBits - MIN(ofBits, 32 - seqState->DStream.bitsConsumed);
+                    offset = ofBase + (BIT_readBitsFast(&seqState->DStream, ofBits - extraBits) << extraBits);
+                    BIT_reloadDStream(&seqState->DStream);
+                    if (extraBits) offset += BIT_readBitsFast(&seqState->DStream, extraBits);
+                    assert(extraBits <= LONG_OFFSETS_MAX_EXTRA_BITS_32);   /* to avoid another reload */
+                } else {
+                    offset = ofBase + BIT_readBitsFast(&seqState->DStream, ofBits/*>0*/);   /* <=  (ZSTD_WINDOWLOG_MAX-1) bits */
+                    if (MEM_32bits()) BIT_reloadDStream(&seqState->DStream);
                 }
+                seqState->prevOffset[2] = seqState->prevOffset[1];
+                seqState->prevOffset[1] = seqState->prevOffset[0];
+                seqState->prevOffset[0] = offset;
             } else {
-                offset = ofBase + ll0 + BIT_readBitsFast(&seqState->DStream, 1);
-                {   size_t temp = (offset==3) ? seqState->prevOffset[0] - 1 : seqState->prevOffset[offset];
-                    temp += !temp;   /* 0 is not valid; input is corrupted; force offset to 1 */
-                    if (offset != 1) seqState->prevOffset[2] = seqState->prevOffset[1];
-                    seqState->prevOffset[1] = seqState->prevOffset[0];
-                    seqState->prevOffset[0] = offset = temp;
-        }   }   }
-        seq.offset = offset;
-    }
-
-    seq.matchLength = mlBase;
-    if (mlBits > 0)
-        seq.matchLength += BIT_readBitsFast(&seqState->DStream, mlBits/*>0*/);
-
-    if (MEM_32bits() && (mlBits+llBits >= STREAM_ACCUMULATOR_MIN_32-LONG_OFFSETS_MAX_EXTRA_BITS_32))
-        BIT_reloadDStream(&seqState->DStream);
-    if (MEM_64bits() && UNLIKELY(totalBits >= STREAM_ACCUMULATOR_MIN_64-(LLFSELog+MLFSELog+OffFSELog)))
-        BIT_reloadDStream(&seqState->DStream);
-    /* Ensure there are enough bits to read the rest of data in 64-bit mode. */
-    ZSTD_STATIC_ASSERT(16+LLFSELog+MLFSELog+OffFSELog < STREAM_ACCUMULATOR_MIN_64);
-
-    seq.litLength = llBase;
-    if (llBits > 0)
-        seq.litLength += BIT_readBitsFast(&seqState->DStream, llBits/*>0*/);
-
-    if (MEM_32bits())
-        BIT_reloadDStream(&seqState->DStream);
-
-    DEBUGLOG(6, "seq: litL=%u, matchL=%u, offset=%u",
-                (U32)seq.litLength, (U32)seq.matchLength, (U32)seq.offset);
-
-    if (prefetch == ZSTD_p_prefetch) {
-        size_t const pos = seqState->pos + seq.litLength;
-        const BYTE* const matchBase = (seq.offset > pos) ? seqState->dictEnd : seqState->prefixStart;
-        seq.match = matchBase + pos - seq.offset;  /* note : this operation can overflow when seq.offset is really too large, which can only happen when input is corrupted.
-                                                    * No consequence though : no memory access will occur, offset is only used for prefetching */
-        seqState->pos = pos + seq.matchLength;
-    }
-
-    /* ANS state update
-     * gcc-9.0.0 does 2.5% worse with ZSTD_updateFseStateWithDInfo().
-     * clang-9.2.0 does 7% worse with ZSTD_updateFseState().
-     * Naturally it seems like ZSTD_updateFseStateWithDInfo() should be the
-     * better option, so it is the default for other compilers. But, if you
-     * measure that it is worse, please put up a pull request.
-     */
-    {
-#if !defined(__clang__)
-        const int kUseUpdateFseState = 1;
-#else
-        const int kUseUpdateFseState = 0;
-#endif
-        if (kUseUpdateFseState) {
-            ZSTD_updateFseState(&seqState->stateLL, &seqState->DStream);    /* <=  9 bits */
-            ZSTD_updateFseState(&seqState->stateML, &seqState->DStream);    /* <=  9 bits */
-            if (MEM_32bits()) BIT_reloadDStream(&seqState->DStream);    /* <= 18 bits */
-            ZSTD_updateFseState(&seqState->stateOffb, &seqState->DStream);  /* <=  8 bits */
-        } else {
-            ZSTD_updateFseStateWithDInfo(&seqState->stateLL, &seqState->DStream, llDInfo);    /* <=  9 bits */
-            ZSTD_updateFseStateWithDInfo(&seqState->stateML, &seqState->DStream, mlDInfo);    /* <=  9 bits */
-            if (MEM_32bits()) BIT_reloadDStream(&seqState->DStream);    /* <= 18 bits */
-            ZSTD_updateFseStateWithDInfo(&seqState->stateOffb, &seqState->DStream, ofDInfo);  /* <=  8 bits */
+                U32 const ll0 = (llDInfo->baseValue == 0);
+                if (LIKELY((ofBits == 0))) {
+                    offset = seqState->prevOffset[ll0];
+                    seqState->prevOffset[1] = seqState->prevOffset[!ll0];
+                    seqState->prevOffset[0] = offset;
+                } else {
+                    offset = ofBase + ll0 + BIT_readBitsFast(&seqState->DStream, 1);
+                    {   size_t temp = (offset==3) ? seqState->prevOffset[0] - 1 : seqState->prevOffset[offset];
+                        temp += !temp;   /* 0 is not valid; input is corrupted; force offset to 1 */
+                        if (offset != 1) seqState->prevOffset[2] = seqState->prevOffset[1];
+                        seqState->prevOffset[1] = seqState->prevOffset[0];
+                        seqState->prevOffset[0] = offset = temp;
+            }   }   }
+            seq.offset = offset;
         }
+
+    #if defined(__clang__)
+        if (UNLIKELY(mlBits > 0))
+    #else
+        if (mlBits > 0)
+    #endif
+            seq.matchLength += BIT_readBitsFast(&seqState->DStream, mlBits/*>0*/);
+
+        if (MEM_32bits() && (mlBits+llBits >= STREAM_ACCUMULATOR_MIN_32-LONG_OFFSETS_MAX_EXTRA_BITS_32))
+            BIT_reloadDStream(&seqState->DStream);
+        if (MEM_64bits() && UNLIKELY(totalBits >= STREAM_ACCUMULATOR_MIN_64-(LLFSELog+MLFSELog+OffFSELog)))
+            BIT_reloadDStream(&seqState->DStream);
+        /* Ensure there are enough bits to read the rest of data in 64-bit mode. */
+        ZSTD_STATIC_ASSERT(16+LLFSELog+MLFSELog+OffFSELog < STREAM_ACCUMULATOR_MIN_64);
+
+    #if defined(__clang__)
+        if (UNLIKELY(llBits > 0))
+    #else
+        if (llBits > 0)
+    #endif
+            seq.litLength += BIT_readBitsFast(&seqState->DStream, llBits/*>0*/);
+
+        if (MEM_32bits())
+            BIT_reloadDStream(&seqState->DStream);
+
+        DEBUGLOG(6, "seq: litL=%u, matchL=%u, offset=%u",
+                    (U32)seq.litLength, (U32)seq.matchLength, (U32)seq.offset);
+
+        ZSTD_updateFseStateWithDInfo(&seqState->stateLL, &seqState->DStream, llNext, llnbBits);    /* <=  9 bits */
+        ZSTD_updateFseStateWithDInfo(&seqState->stateML, &seqState->DStream, mlNext, mlnbBits);    /* <=  9 bits */
+        if (MEM_32bits()) BIT_reloadDStream(&seqState->DStream);    /* <= 18 bits */
+        ZSTD_updateFseStateWithDInfo(&seqState->stateOffb, &seqState->DStream, ofNext, ofnbBits);  /* <=  8 bits */
     }
 
     return seq;
@@ -1098,9 +1315,11 @@ MEM_STATIC void ZSTD_assertValidSequence(
 #endif
 
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG
+
+
 FORCE_INLINE_TEMPLATE size_t
 DONT_VECTORIZE
-ZSTD_decompressSequences_body( ZSTD_DCtx* dctx,
+ZSTD_decompressSequences_bodySplitLitBuffer( ZSTD_DCtx* dctx,
                                void* dst, size_t maxDstSize,
                          const void* seqStart, size_t seqSize, int nbSeq,
                          const ZSTD_longOffset_e isLongOffset,
@@ -1112,17 +1331,16 @@ ZSTD_decompressSequences_body( ZSTD_DCtx* dctx,
     BYTE* const oend = ostart + maxDstSize;
     BYTE* op = ostart;
     const BYTE* litPtr = dctx->litPtr;
-    const BYTE* const litEnd = litPtr + dctx->litSize;
+    const BYTE* litBufferEnd = dctx->litBufferEnd;
     const BYTE* const prefixStart = (const BYTE*) (dctx->prefixStart);
     const BYTE* const vBase = (const BYTE*) (dctx->virtualStart);
     const BYTE* const dictEnd = (const BYTE*) (dctx->dictEnd);
-    DEBUGLOG(5, "ZSTD_decompressSequences_body");
+    DEBUGLOG(5, "ZSTD_decompressSequences_bodySplitLitBuffer");
     (void)frame;
 
     /* Regen sequences */
     if (nbSeq) {
         seqState_t seqState;
-        size_t error = 0;
         dctx->fseEntropy = 1;
         { U32 i; for (i=0; i<ZSTD_REP_NUM; i++) seqState.prevOffset[i] = dctx->entropy.rep[i]; }
         RETURN_ERROR_IF(
@@ -1138,70 +1356,255 @@ ZSTD_decompressSequences_body( ZSTD_DCtx* dctx,
                 BIT_DStream_endOfBuffer < BIT_DStream_completed &&
                 BIT_DStream_completed < BIT_DStream_overflow);
 
+        /* decompress without overrunning litPtr begins */
+        {
+            seq_t sequence = ZSTD_decodeSequence(&seqState, isLongOffset);
+            /* Align the decompression loop to 32 + 16 bytes.
+                *
+                * zstd compiled with gcc-9 on an Intel i9-9900k shows 10% decompression
+                * speed swings based on the alignment of the decompression loop. This
+                * performance swing is caused by parts of the decompression loop falling
+                * out of the DSB. The entire decompression loop should fit in the DSB,
+                * when it can't we get much worse performance. You can measure if you've
+                * hit the good case or the bad case with this perf command for some
+                * compressed file test.zst:
+                *
+                *   perf stat -e cycles -e instructions -e idq.all_dsb_cycles_any_uops \
+                *             -e idq.all_mite_cycles_any_uops -- ./zstd -tq test.zst
+                *
+                * If you see most cycles served out of the MITE you've hit the bad case.
+                * If you see most cycles served out of the DSB you've hit the good case.
+                * If it is pretty even then you may be in an okay case.
+                *
+                * This issue has been reproduced on the following CPUs:
+                *   - Kabylake: Macbook Pro (15-inch, 2019) 2.4 GHz Intel Core i9
+                *               Use Instruments->Counters to get DSB/MITE cycles.
+                *               I never got performance swings, but I was able to
+                *               go from the good case of mostly DSB to half of the
+                *               cycles served from MITE.
+                *   - Coffeelake: Intel i9-9900k
+                *   - Coffeelake: Intel i7-9700k
+                *
+                * I haven't been able to reproduce the instability or DSB misses on any
+                * of the following CPUS:
+                *   - Haswell
+                *   - Broadwell: Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GH
+                *   - Skylake
+                *
+                * Alignment is done for each of the three major decompression loops:
+                *   - ZSTD_decompressSequences_bodySplitLitBuffer - presplit section of the literal buffer
+                *   - ZSTD_decompressSequences_bodySplitLitBuffer - postsplit section of the literal buffer
+                *   - ZSTD_decompressSequences_body
+                * Alignment choices are made to minimize large swings on bad cases and influence on performance
+                * from changes external to this code, rather than to overoptimize on the current commit.
+                *
+                * If you are seeing performance stability this script can help test.
+                * It tests on 4 commits in zstd where I saw performance change.
+                *
+                *   https://gist.github.com/terrelln/9889fc06a423fd5ca6e99351564473f4
+                */
 #if defined(__x86_64__)
-        /* Align the decompression loop to 32 + 16 bytes.
-         *
-         * zstd compiled with gcc-9 on an Intel i9-9900k shows 10% decompression
-         * speed swings based on the alignment of the decompression loop. This
-         * performance swing is caused by parts of the decompression loop falling
-         * out of the DSB. The entire decompression loop should fit in the DSB,
-         * when it can't we get much worse performance. You can measure if you've
-         * hit the good case or the bad case with this perf command for some
-         * compressed file test.zst:
-         *
-         *   perf stat -e cycles -e instructions -e idq.all_dsb_cycles_any_uops \
-         *             -e idq.all_mite_cycles_any_uops -- ./zstd -tq test.zst
-         *
-         * If you see most cycles served out of the MITE you've hit the bad case.
-         * If you see most cycles served out of the DSB you've hit the good case.
-         * If it is pretty even then you may be in an okay case.
-         *
-         * I've been able to reproduce this issue on the following CPUs:
-         *   - Kabylake: Macbook Pro (15-inch, 2019) 2.4 GHz Intel Core i9
-         *               Use Instruments->Counters to get DSB/MITE cycles.
-         *               I never got performance swings, but I was able to
-         *               go from the good case of mostly DSB to half of the
-         *               cycles served from MITE.
-         *   - Coffeelake: Intel i9-9900k
-         *
-         * I haven't been able to reproduce the instability or DSB misses on any
-         * of the following CPUS:
-         *   - Haswell
-         *   - Broadwell: Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GH
-         *   - Skylake
-         *
-         * If you are seeing performance stability this script can help test.
-         * It tests on 4 commits in zstd where I saw performance change.
-         *
-         *   https://gist.github.com/terrelln/9889fc06a423fd5ca6e99351564473f4
-         */
-        __asm__(".p2align 5");
-        __asm__("nop");
-        __asm__(".p2align 4");
+            __asm__(".p2align 6");
+#  if __GNUC__ >= 7
+	    /* good for gcc-7, gcc-9, and gcc-11 */
+            __asm__("nop");
+            __asm__(".p2align 5");
+            __asm__("nop");
+            __asm__(".p2align 4");
+#    if __GNUC__ == 8 || __GNUC__ == 10
+	    /* good for gcc-8 and gcc-10 */
+            __asm__("nop");
+            __asm__(".p2align 3");
+#    endif
+#  endif
+#endif
+
+            /* Handle the initial state where litBuffer is currently split between dst and litExtraBuffer */
+            for (; litPtr + sequence.litLength <= dctx->litBufferEnd; ) {
+                size_t const oneSeqSize = ZSTD_execSequenceSplitLitBuffer(op, oend, litPtr + sequence.litLength - WILDCOPY_OVERLENGTH, sequence, &litPtr, litBufferEnd, prefixStart, vBase, dictEnd);
+#if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_ASSERT_VALID_SEQUENCE)
+                assert(!ZSTD_isError(oneSeqSize));
+                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequence, prefixStart, vBase);
+#endif
+                if (UNLIKELY(ZSTD_isError(oneSeqSize)))
+                    return oneSeqSize;
+                DEBUGLOG(6, "regenerated sequence size : %u", (U32)oneSeqSize);
+                op += oneSeqSize;
+                if (UNLIKELY(!--nbSeq))
+                    break;
+                BIT_reloadDStream(&(seqState.DStream));
+                sequence = ZSTD_decodeSequence(&seqState, isLongOffset);
+            }
+
+            /* If there are more sequences, they will need to read literals from litExtraBuffer; copy over the remainder from dst and update litPtr and litEnd */
+            if (nbSeq > 0) {
+                const size_t leftoverLit = dctx->litBufferEnd - litPtr;
+                if (leftoverLit)
+                {
+                    RETURN_ERROR_IF(leftoverLit > (size_t)(oend - op), dstSize_tooSmall, "remaining lit must fit within dstBuffer");
+                    ZSTD_safecopyDstBeforeSrc(op, litPtr, leftoverLit);
+                    sequence.litLength -= leftoverLit;
+                    op += leftoverLit;
+                }
+                litPtr = dctx->litExtraBuffer;
+                litBufferEnd = dctx->litExtraBuffer + ZSTD_LITBUFFEREXTRASIZE;
+                dctx->litBufferLocation = ZSTD_not_in_dst;
+                {
+                    size_t const oneSeqSize = ZSTD_execSequence(op, oend, sequence, &litPtr, litBufferEnd, prefixStart, vBase, dictEnd);
+#if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_ASSERT_VALID_SEQUENCE)
+                    assert(!ZSTD_isError(oneSeqSize));
+                    if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequence, prefixStart, vBase);
+#endif
+                    if (UNLIKELY(ZSTD_isError(oneSeqSize)))
+                        return oneSeqSize;
+                    DEBUGLOG(6, "regenerated sequence size : %u", (U32)oneSeqSize);
+                    op += oneSeqSize;
+                    if (--nbSeq)
+                        BIT_reloadDStream(&(seqState.DStream));
+                }
+            }
+        }
+
+        if (nbSeq > 0) /* there is remaining lit from extra buffer */
+        {
+
+#if defined(__x86_64__)
+            __asm__(".p2align 6");
+            __asm__("nop");
+#  if __GNUC__ != 7
+            /* worse for gcc-7 better for gcc-8, gcc-9, and gcc-10 and clang */
+            __asm__(".p2align 4");
+            __asm__("nop");
+            __asm__(".p2align 3");
+#  elif __GNUC__ >= 11
+            __asm__(".p2align 3");
+#  else
+            __asm__(".p2align 5");
+            __asm__("nop");
+            __asm__(".p2align 3");
+#  endif
+#endif
+
+            for (; ; ) {
+                seq_t const sequence = ZSTD_decodeSequence(&seqState, isLongOffset);
+                size_t const oneSeqSize = ZSTD_execSequence(op, oend, sequence, &litPtr, litBufferEnd, prefixStart, vBase, dictEnd);
+#if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_ASSERT_VALID_SEQUENCE)
+                assert(!ZSTD_isError(oneSeqSize));
+                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequence, prefixStart, vBase);
+#endif
+                if (UNLIKELY(ZSTD_isError(oneSeqSize)))
+                    return oneSeqSize;
+                DEBUGLOG(6, "regenerated sequence size : %u", (U32)oneSeqSize);
+                op += oneSeqSize;
+                if (UNLIKELY(!--nbSeq))
+                    break;
+                BIT_reloadDStream(&(seqState.DStream));
+            }
+        }
+
+        /* check if reached exact end */
+        DEBUGLOG(5, "ZSTD_decompressSequences_bodySplitLitBuffer: after decode loop, remaining nbSeq : %i", nbSeq);
+        RETURN_ERROR_IF(nbSeq, corruption_detected, "");
+        RETURN_ERROR_IF(BIT_reloadDStream(&seqState.DStream) < BIT_DStream_completed, corruption_detected, "");
+        /* save reps for next block */
+        { U32 i; for (i=0; i<ZSTD_REP_NUM; i++) dctx->entropy.rep[i] = (U32)(seqState.prevOffset[i]); }
+    }
+
+    /* last literal segment */
+    if (dctx->litBufferLocation == ZSTD_split)  /* split hasn't been reached yet, first get dst then copy litExtraBuffer */
+    {
+        size_t const lastLLSize = litBufferEnd - litPtr;
+        RETURN_ERROR_IF(lastLLSize > (size_t)(oend - op), dstSize_tooSmall, "");
+        if (op != NULL) {
+            ZSTD_memmove(op, litPtr, lastLLSize);
+            op += lastLLSize;
+        }
+        litPtr = dctx->litExtraBuffer;
+        litBufferEnd = dctx->litExtraBuffer + ZSTD_LITBUFFEREXTRASIZE;
+        dctx->litBufferLocation = ZSTD_not_in_dst;
+    }
+    {   size_t const lastLLSize = litBufferEnd - litPtr;
+        RETURN_ERROR_IF(lastLLSize > (size_t)(oend-op), dstSize_tooSmall, "");
+        if (op != NULL) {
+            ZSTD_memcpy(op, litPtr, lastLLSize);
+            op += lastLLSize;
+        }
+    }
+
+    return op-ostart;
+}
+
+FORCE_INLINE_TEMPLATE size_t
+DONT_VECTORIZE
+ZSTD_decompressSequences_body(ZSTD_DCtx* dctx,
+    void* dst, size_t maxDstSize,
+    const void* seqStart, size_t seqSize, int nbSeq,
+    const ZSTD_longOffset_e isLongOffset,
+    const int frame)
+{
+    const BYTE* ip = (const BYTE*)seqStart;
+    const BYTE* const iend = ip + seqSize;
+    BYTE* const ostart = (BYTE*)dst;
+    BYTE* const oend = dctx->litBufferLocation == ZSTD_not_in_dst ? ostart + maxDstSize : dctx->litBuffer;
+    BYTE* op = ostart;
+    const BYTE* litPtr = dctx->litPtr;
+    const BYTE* const litEnd = litPtr + dctx->litSize;
+    const BYTE* const prefixStart = (const BYTE*)(dctx->prefixStart);
+    const BYTE* const vBase = (const BYTE*)(dctx->virtualStart);
+    const BYTE* const dictEnd = (const BYTE*)(dctx->dictEnd);
+    DEBUGLOG(5, "ZSTD_decompressSequences_body");
+    (void)frame;
+
+    /* Regen sequences */
+    if (nbSeq) {
+        seqState_t seqState;
+        dctx->fseEntropy = 1;
+        { U32 i; for (i = 0; i < ZSTD_REP_NUM; i++) seqState.prevOffset[i] = dctx->entropy.rep[i]; }
+        RETURN_ERROR_IF(
+            ERR_isError(BIT_initDStream(&seqState.DStream, ip, iend - ip)),
+            corruption_detected, "");
+        ZSTD_initFseState(&seqState.stateLL, &seqState.DStream, dctx->LLTptr);
+        ZSTD_initFseState(&seqState.stateOffb, &seqState.DStream, dctx->OFTptr);
+        ZSTD_initFseState(&seqState.stateML, &seqState.DStream, dctx->MLTptr);
+        assert(dst != NULL);
+
+        ZSTD_STATIC_ASSERT(
+            BIT_DStream_unfinished < BIT_DStream_completed &&
+            BIT_DStream_endOfBuffer < BIT_DStream_completed &&
+            BIT_DStream_completed < BIT_DStream_overflow);
+
+#if defined(__x86_64__)
+            __asm__(".p2align 6");
+            __asm__("nop");
+#  if __GNUC__ >= 7
+            __asm__(".p2align 5");
+            __asm__("nop");
+            __asm__(".p2align 3");
+#  else
+            __asm__(".p2align 4");
+            __asm__("nop");
+            __asm__(".p2align 3");
+#  endif
 #endif
+
         for ( ; ; ) {
-            seq_t const sequence = ZSTD_decodeSequence(&seqState, isLongOffset, ZSTD_p_noPrefetch);
+            seq_t const sequence = ZSTD_decodeSequence(&seqState, isLongOffset);
             size_t const oneSeqSize = ZSTD_execSequence(op, oend, sequence, &litPtr, litEnd, prefixStart, vBase, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_ASSERT_VALID_SEQUENCE)
             assert(!ZSTD_isError(oneSeqSize));
             if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequence, prefixStart, vBase);
 #endif
+            if (UNLIKELY(ZSTD_isError(oneSeqSize)))
+                return oneSeqSize;
             DEBUGLOG(6, "regenerated sequence size : %u", (U32)oneSeqSize);
-            BIT_reloadDStream(&(seqState.DStream));
             op += oneSeqSize;
-            /* gcc and clang both don't like early returns in this loop.
-             * Instead break and check for an error at the end of the loop.
-             */
-            if (UNLIKELY(ZSTD_isError(oneSeqSize))) {
-                error = oneSeqSize;
+            if (UNLIKELY(!--nbSeq))
                 break;
-            }
-            if (UNLIKELY(!--nbSeq)) break;
+            BIT_reloadDStream(&(seqState.DStream));
         }
 
         /* check if reached exact end */
         DEBUGLOG(5, "ZSTD_decompressSequences_body: after decode loop, remaining nbSeq : %i", nbSeq);
-        if (ZSTD_isError(error)) return error;
         RETURN_ERROR_IF(nbSeq, corruption_detected, "");
         RETURN_ERROR_IF(BIT_reloadDStream(&seqState.DStream) < BIT_DStream_completed, corruption_detected, "");
         /* save reps for next block */
@@ -1229,9 +1632,37 @@ ZSTD_decompressSequences_default(ZSTD_DCtx* dctx,
 {
     return ZSTD_decompressSequences_body(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
 }
+
+static size_t
+ZSTD_decompressSequencesSplitLitBuffer_default(ZSTD_DCtx* dctx,
+                                               void* dst, size_t maxDstSize,
+                                         const void* seqStart, size_t seqSize, int nbSeq,
+                                         const ZSTD_longOffset_e isLongOffset,
+                                         const int frame)
+{
+    return ZSTD_decompressSequences_bodySplitLitBuffer(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
+}
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG */
 
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
+
+FORCE_INLINE_TEMPLATE size_t
+ZSTD_prefetchMatch(size_t prefetchPos, seq_t const sequence,
+                   const BYTE* const prefixStart, const BYTE* const dictEnd)
+{
+    prefetchPos += sequence.litLength;
+    {   const BYTE* const matchBase = (sequence.offset > prefetchPos) ? dictEnd : prefixStart;
+        const BYTE* const match = matchBase + prefetchPos - sequence.offset; /* note : this operation can overflow when seq.offset is really too large, which can only happen when input is corrupted.
+                                                                              * No consequence though : memory address is only used for prefetching, not for dereferencing */
+        PREFETCH_L1(match); PREFETCH_L1(match+CACHELINE_SIZE);   /* note : it's safe to invoke PREFETCH() on any memory address, including invalid ones */
+    }
+    return prefetchPos + sequence.matchLength;
+}
+
+/* This decoding function employs prefetching
+ * to reduce latency impact of cache misses.
+ * It's generally employed when block contains a significant portion of long-distance matches
+ * or when coupled with a "cold" dictionary */
 FORCE_INLINE_TEMPLATE size_t
 ZSTD_decompressSequencesLong_body(
                                ZSTD_DCtx* dctx,
@@ -1243,10 +1674,10 @@ ZSTD_decompressSequencesLong_body(
     const BYTE* ip = (const BYTE*)seqStart;
     const BYTE* const iend = ip + seqSize;
     BYTE* const ostart = (BYTE*)dst;
-    BYTE* const oend = ostart + maxDstSize;
+    BYTE* const oend = dctx->litBufferLocation == ZSTD_in_dst ? dctx->litBuffer : ostart + maxDstSize;
     BYTE* op = ostart;
     const BYTE* litPtr = dctx->litPtr;
-    const BYTE* const litEnd = litPtr + dctx->litSize;
+    const BYTE* litBufferEnd = dctx->litBufferEnd;
     const BYTE* const prefixStart = (const BYTE*) (dctx->prefixStart);
     const BYTE* const dictStart = (const BYTE*) (dctx->virtualStart);
     const BYTE* const dictEnd = (const BYTE*) (dctx->dictEnd);
@@ -1254,18 +1685,17 @@ ZSTD_decompressSequencesLong_body(
 
     /* Regen sequences */
     if (nbSeq) {
-#define STORED_SEQS 4
+#define STORED_SEQS 8
 #define STORED_SEQS_MASK (STORED_SEQS-1)
-#define ADVANCED_SEQS 4
+#define ADVANCED_SEQS STORED_SEQS
         seq_t sequences[STORED_SEQS];
         int const seqAdvance = MIN(nbSeq, ADVANCED_SEQS);
         seqState_t seqState;
         int seqNb;
+        size_t prefetchPos = (size_t)(op-prefixStart); /* track position relative to prefixStart */
+
         dctx->fseEntropy = 1;
         { int i; for (i=0; i<ZSTD_REP_NUM; i++) seqState.prevOffset[i] = dctx->entropy.rep[i]; }
-        seqState.prefixStart = prefixStart;
-        seqState.pos = (size_t)(op-prefixStart);
-        seqState.dictEnd = dictEnd;
         assert(dst != NULL);
         assert(iend >= ip);
         RETURN_ERROR_IF(
@@ -1277,36 +1707,100 @@ ZSTD_decompressSequencesLong_body(
 
         /* prepare in advance */
         for (seqNb=0; (BIT_reloadDStream(&seqState.DStream) <= BIT_DStream_completed) && (seqNb<seqAdvance); seqNb++) {
-            sequences[seqNb] = ZSTD_decodeSequence(&seqState, isLongOffset, ZSTD_p_prefetch);
-            PREFETCH_L1(sequences[seqNb].match); PREFETCH_L1(sequences[seqNb].match + sequences[seqNb].matchLength - 1); /* note : it's safe to invoke PREFETCH() on any memory address, including invalid ones */
+            seq_t const sequence = ZSTD_decodeSequence(&seqState, isLongOffset);
+            prefetchPos = ZSTD_prefetchMatch(prefetchPos, sequence, prefixStart, dictEnd);
+            sequences[seqNb] = sequence;
         }
         RETURN_ERROR_IF(seqNb<seqAdvance, corruption_detected, "");
 
-        /* decode and decompress */
-        for ( ; (BIT_reloadDStream(&(seqState.DStream)) <= BIT_DStream_completed) && (seqNb<nbSeq) ; seqNb++) {
-            seq_t const sequence = ZSTD_decodeSequence(&seqState, isLongOffset, ZSTD_p_prefetch);
-            size_t const oneSeqSize = ZSTD_execSequence(op, oend, sequences[(seqNb-ADVANCED_SEQS) & STORED_SEQS_MASK], &litPtr, litEnd, prefixStart, dictStart, dictEnd);
+        /* decompress without stomping litBuffer */
+        for (; (BIT_reloadDStream(&(seqState.DStream)) <= BIT_DStream_completed) && (seqNb < nbSeq); seqNb++) {
+            seq_t sequence = ZSTD_decodeSequence(&seqState, isLongOffset);
+            size_t oneSeqSize;
+
+            if (dctx->litBufferLocation == ZSTD_split && litPtr + sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK].litLength > dctx->litBufferEnd)
+            {
+                /* lit buffer is reaching split point, empty out the first buffer and transition to litExtraBuffer */
+                const size_t leftoverLit = dctx->litBufferEnd - litPtr;
+                if (leftoverLit)
+                {
+                    RETURN_ERROR_IF(leftoverLit > (size_t)(oend - op), dstSize_tooSmall, "remaining lit must fit within dstBuffer");
+                    ZSTD_safecopyDstBeforeSrc(op, litPtr, leftoverLit);
+                    sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK].litLength -= leftoverLit;
+                    op += leftoverLit;
+                }
+                litPtr = dctx->litExtraBuffer;
+                litBufferEnd = dctx->litExtraBuffer + ZSTD_LITBUFFEREXTRASIZE;
+                dctx->litBufferLocation = ZSTD_not_in_dst;
+                oneSeqSize = ZSTD_execSequence(op, oend, sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK], &litPtr, litBufferEnd, prefixStart, dictStart, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_ASSERT_VALID_SEQUENCE)
-            assert(!ZSTD_isError(oneSeqSize));
-            if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequences[(seqNb-ADVANCED_SEQS) & STORED_SEQS_MASK], prefixStart, dictStart);
+                assert(!ZSTD_isError(oneSeqSize));
+                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK], prefixStart, dictStart);
 #endif
-            if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
-            PREFETCH_L1(sequence.match); PREFETCH_L1(sequence.match + sequence.matchLength - 1); /* note : it's safe to invoke PREFETCH() on any memory address, including invalid ones */
-            sequences[seqNb & STORED_SEQS_MASK] = sequence;
-            op += oneSeqSize;
+                if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
+
+                prefetchPos = ZSTD_prefetchMatch(prefetchPos, sequence, prefixStart, dictEnd);
+                sequences[seqNb & STORED_SEQS_MASK] = sequence;
+                op += oneSeqSize;
+            }
+            else
+            {
+                /* lit buffer is either wholly contained in first or second split, or not split at all*/
+                oneSeqSize = dctx->litBufferLocation == ZSTD_split ?
+                    ZSTD_execSequenceSplitLitBuffer(op, oend, litPtr + sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK].litLength - WILDCOPY_OVERLENGTH, sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK], &litPtr, litBufferEnd, prefixStart, dictStart, dictEnd) :
+                    ZSTD_execSequence(op, oend, sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK], &litPtr, litBufferEnd, prefixStart, dictStart, dictEnd);
+#if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_ASSERT_VALID_SEQUENCE)
+                assert(!ZSTD_isError(oneSeqSize));
+                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequences[(seqNb - ADVANCED_SEQS) & STORED_SEQS_MASK], prefixStart, dictStart);
+#endif
+                if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
+
+                prefetchPos = ZSTD_prefetchMatch(prefetchPos, sequence, prefixStart, dictEnd);
+                sequences[seqNb & STORED_SEQS_MASK] = sequence;
+                op += oneSeqSize;
+            }
         }
         RETURN_ERROR_IF(seqNb<nbSeq, corruption_detected, "");
 
         /* finish queue */
         seqNb -= seqAdvance;
         for ( ; seqNb<nbSeq ; seqNb++) {
-            size_t const oneSeqSize = ZSTD_execSequence(op, oend, sequences[seqNb&STORED_SEQS_MASK], &litPtr, litEnd, prefixStart, dictStart, dictEnd);
+            seq_t *sequence = &(sequences[seqNb&STORED_SEQS_MASK]);
+            if (dctx->litBufferLocation == ZSTD_split && litPtr + sequence->litLength > dctx->litBufferEnd)
+            {
+                const size_t leftoverLit = dctx->litBufferEnd - litPtr;
+                if (leftoverLit)
+                {
+                    RETURN_ERROR_IF(leftoverLit > (size_t)(oend - op), dstSize_tooSmall, "remaining lit must fit within dstBuffer");
+                    ZSTD_safecopyDstBeforeSrc(op, litPtr, leftoverLit);
+                    sequence->litLength -= leftoverLit;
+                    op += leftoverLit;
+                }
+                litPtr = dctx->litExtraBuffer;
+                litBufferEnd = dctx->litExtraBuffer + ZSTD_LITBUFFEREXTRASIZE;
+                dctx->litBufferLocation = ZSTD_not_in_dst;
+                {
+                    size_t const oneSeqSize = ZSTD_execSequence(op, oend, *sequence, &litPtr, litBufferEnd, prefixStart, dictStart, dictEnd);
 #if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_ASSERT_VALID_SEQUENCE)
-            assert(!ZSTD_isError(oneSeqSize));
-            if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequences[seqNb&STORED_SEQS_MASK], prefixStart, dictStart);
+                    assert(!ZSTD_isError(oneSeqSize));
+                    if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequences[seqNb&STORED_SEQS_MASK], prefixStart, dictStart);
 #endif
-            if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
-            op += oneSeqSize;
+                    if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
+                    op += oneSeqSize;
+                }
+            }
+            else
+            {
+                size_t const oneSeqSize = dctx->litBufferLocation == ZSTD_split ?
+                    ZSTD_execSequenceSplitLitBuffer(op, oend, litPtr + sequence->litLength - WILDCOPY_OVERLENGTH, *sequence, &litPtr, litBufferEnd, prefixStart, dictStart, dictEnd) :
+                    ZSTD_execSequence(op, oend, *sequence, &litPtr, litBufferEnd, prefixStart, dictStart, dictEnd);
+#if defined(FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION) && defined(FUZZING_ASSERT_VALID_SEQUENCE)
+                assert(!ZSTD_isError(oneSeqSize));
+                if (frame) ZSTD_assertValidSequence(dctx, op, oend, sequences[seqNb&STORED_SEQS_MASK], prefixStart, dictStart);
+#endif
+                if (ZSTD_isError(oneSeqSize)) return oneSeqSize;
+                op += oneSeqSize;
+            }
         }
 
         /* save reps for next block */
@@ -1314,10 +1808,21 @@ ZSTD_decompressSequencesLong_body(
     }
 
     /* last literal segment */
-    {   size_t const lastLLSize = litEnd - litPtr;
+    if (dctx->litBufferLocation == ZSTD_split)  /* first deplete literal buffer in dst, then copy litExtraBuffer */
+    {
+        size_t const lastLLSize = litBufferEnd - litPtr;
+        RETURN_ERROR_IF(lastLLSize > (size_t)(oend - op), dstSize_tooSmall, "");
+        if (op != NULL) {
+            ZSTD_memmove(op, litPtr, lastLLSize);
+            op += lastLLSize;
+        }
+        litPtr = dctx->litExtraBuffer;
+        litBufferEnd = dctx->litExtraBuffer + ZSTD_LITBUFFEREXTRASIZE;
+    }
+    {   size_t const lastLLSize = litBufferEnd - litPtr;
         RETURN_ERROR_IF(lastLLSize > (size_t)(oend-op), dstSize_tooSmall, "");
         if (op != NULL) {
-            ZSTD_memcpy(op, litPtr, lastLLSize);
+            ZSTD_memmove(op, litPtr, lastLLSize);
             op += lastLLSize;
         }
     }
@@ -1341,7 +1846,7 @@ ZSTD_decompressSequencesLong_default(ZSTD_DCtx* dctx,
 #if DYNAMIC_BMI2
 
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG
-static TARGET_ATTRIBUTE("bmi2") size_t
+static BMI2_TARGET_ATTRIBUTE size_t
 DONT_VECTORIZE
 ZSTD_decompressSequences_bmi2(ZSTD_DCtx* dctx,
                                  void* dst, size_t maxDstSize,
@@ -1351,10 +1856,20 @@ ZSTD_decompressSequences_bmi2(ZSTD_DCtx* dctx,
 {
     return ZSTD_decompressSequences_body(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
 }
+static BMI2_TARGET_ATTRIBUTE size_t
+DONT_VECTORIZE
+ZSTD_decompressSequencesSplitLitBuffer_bmi2(ZSTD_DCtx* dctx,
+                                 void* dst, size_t maxDstSize,
+                           const void* seqStart, size_t seqSize, int nbSeq,
+                           const ZSTD_longOffset_e isLongOffset,
+                           const int frame)
+{
+    return ZSTD_decompressSequences_bodySplitLitBuffer(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
+}
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG */
 
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
-static TARGET_ATTRIBUTE("bmi2") size_t
+static BMI2_TARGET_ATTRIBUTE size_t
 ZSTD_decompressSequencesLong_bmi2(ZSTD_DCtx* dctx,
                                  void* dst, size_t maxDstSize,
                            const void* seqStart, size_t seqSize, int nbSeq,
@@ -1383,11 +1898,25 @@ ZSTD_decompressSequences(ZSTD_DCtx* dctx, void* dst, size_t maxDstSize,
 {
     DEBUGLOG(5, "ZSTD_decompressSequences");
 #if DYNAMIC_BMI2
-    if (dctx->bmi2) {
+    if (ZSTD_DCtx_get_bmi2(dctx)) {
         return ZSTD_decompressSequences_bmi2(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
     }
 #endif
-  return ZSTD_decompressSequences_default(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
+    return ZSTD_decompressSequences_default(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
+}
+static size_t
+ZSTD_decompressSequencesSplitLitBuffer(ZSTD_DCtx* dctx, void* dst, size_t maxDstSize,
+                                 const void* seqStart, size_t seqSize, int nbSeq,
+                                 const ZSTD_longOffset_e isLongOffset,
+                                 const int frame)
+{
+    DEBUGLOG(5, "ZSTD_decompressSequencesSplitLitBuffer");
+#if DYNAMIC_BMI2
+    if (ZSTD_DCtx_get_bmi2(dctx)) {
+        return ZSTD_decompressSequencesSplitLitBuffer_bmi2(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
+    }
+#endif
+    return ZSTD_decompressSequencesSplitLitBuffer_default(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG */
 
@@ -1407,7 +1936,7 @@ ZSTD_decompressSequencesLong(ZSTD_DCtx* dctx,
 {
     DEBUGLOG(5, "ZSTD_decompressSequencesLong");
 #if DYNAMIC_BMI2
-    if (dctx->bmi2) {
+    if (ZSTD_DCtx_get_bmi2(dctx)) {
         return ZSTD_decompressSequencesLong_bmi2(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
     }
 #endif
@@ -1448,7 +1977,7 @@ ZSTD_getLongOffsetsShare(const ZSTD_seqSymbol* offTable)
 size_t
 ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
                               void* dst, size_t dstCapacity,
-                        const void* src, size_t srcSize, const int frame)
+                        const void* src, size_t srcSize, const int frame, const streaming_operation streaming)
 {   /* blockType == blockCompressed */
     const BYTE* ip = (const BYTE*)src;
     /* isLongOffset must be true if there are long offsets.
@@ -1463,7 +1992,7 @@ ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
     RETURN_ERROR_IF(srcSize >= ZSTD_BLOCKSIZE_MAX, srcSize_wrong, "");
 
     /* Decode literals section */
-    {   size_t const litCSize = ZSTD_decodeLiteralsBlock(dctx, src, srcSize);
+    {   size_t const litCSize = ZSTD_decodeLiteralsBlock(dctx, src, srcSize, dst, dstCapacity, streaming);
         DEBUGLOG(5, "ZSTD_decodeLiteralsBlock : %u", (U32)litCSize);
         if (ZSTD_isError(litCSize)) return litCSize;
         ip += litCSize;
@@ -1511,7 +2040,10 @@ ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
 
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG
         /* else */
-        return ZSTD_decompressSequences(dctx, dst, dstCapacity, ip, srcSize, nbSeq, isLongOffset, frame);
+        if (dctx->litBufferLocation == ZSTD_split)
+            return ZSTD_decompressSequencesSplitLitBuffer(dctx, dst, dstCapacity, ip, srcSize, nbSeq, isLongOffset, frame);
+        else
+            return ZSTD_decompressSequences(dctx, dst, dstCapacity, ip, srcSize, nbSeq, isLongOffset, frame);
 #endif
     }
 }
@@ -1534,7 +2066,7 @@ size_t ZSTD_decompressBlock(ZSTD_DCtx* dctx,
 {
     size_t dSize;
     ZSTD_checkContinuity(dctx, dst, dstCapacity);
-    dSize = ZSTD_decompressBlock_internal(dctx, dst, dstCapacity, src, srcSize, /* frame */ 0);
+    dSize = ZSTD_decompressBlock_internal(dctx, dst, dstCapacity, src, srcSize, /* frame */ 0, not_streaming);
     dctx->previousDstEnd = (char*)dst + dSize;
     return dSize;
 }
diff --git a/lib/zstd/decompress/zstd_decompress_block.h b/lib/zstd/decompress/zstd_decompress_block.h
index e7f5f6689459..3d2d57a5d25a 100644
--- a/lib/zstd/decompress/zstd_decompress_block.h
+++ b/lib/zstd/decompress/zstd_decompress_block.h
@@ -33,6 +33,12 @@
  */
 
 
+ /* Streaming state is used to inform allocation of the literal buffer */
+typedef enum {
+    not_streaming = 0,
+    is_streaming = 1
+} streaming_operation;
+
 /* ZSTD_decompressBlock_internal() :
  * decompress block, starting at `src`,
  * into destination buffer `dst`.
@@ -41,7 +47,7 @@
  */
 size_t ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
                                void* dst, size_t dstCapacity,
-                         const void* src, size_t srcSize, const int frame);
+                         const void* src, size_t srcSize, const int frame, const streaming_operation streaming);
 
 /* ZSTD_buildFSETable() :
  * generate FSE decoding table for one symbol (ll, ml or off)
@@ -54,7 +60,7 @@ size_t ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
  */
 void ZSTD_buildFSETable(ZSTD_seqSymbol* dt,
              const short* normalizedCounter, unsigned maxSymbolValue,
-             const U32* baseValue, const U32* nbAdditionalBits,
+             const U32* baseValue, const U8* nbAdditionalBits,
                    unsigned tableLog, void* wksp, size_t wkspSize,
                    int bmi2);
 
diff --git a/lib/zstd/decompress/zstd_decompress_internal.h b/lib/zstd/decompress/zstd_decompress_internal.h
index 4b9052f68755..98102edb6a83 100644
--- a/lib/zstd/decompress/zstd_decompress_internal.h
+++ b/lib/zstd/decompress/zstd_decompress_internal.h
@@ -20,7 +20,7 @@
  *  Dependencies
  *********************************************************/
 #include "../common/mem.h"             /* BYTE, U16, U32 */
-#include "../common/zstd_internal.h"   /* ZSTD_seqSymbol */
+#include "../common/zstd_internal.h"   /* constants : MaxLL, MaxML, MaxOff, LLFSELog, etc. */
 
 
 
@@ -40,7 +40,7 @@ static UNUSED_ATTR const U32 OF_base[MaxOff+1] = {
                  0xFFFD, 0x1FFFD, 0x3FFFD, 0x7FFFD, 0xFFFFD, 0x1FFFFD, 0x3FFFFD, 0x7FFFFD,
                  0xFFFFFD, 0x1FFFFFD, 0x3FFFFFD, 0x7FFFFFD, 0xFFFFFFD, 0x1FFFFFFD, 0x3FFFFFFD, 0x7FFFFFFD };
 
-static UNUSED_ATTR const U32 OF_bits[MaxOff+1] = {
+static UNUSED_ATTR const U8 OF_bits[MaxOff+1] = {
                      0,  1,  2,  3,  4,  5,  6,  7,
                      8,  9, 10, 11, 12, 13, 14, 15,
                     16, 17, 18, 19, 20, 21, 22, 23,
@@ -106,6 +106,22 @@ typedef struct {
     size_t ddictPtrCount;
 } ZSTD_DDictHashSet;
 
+#ifndef ZSTD_DECODER_INTERNAL_BUFFER
+#  define ZSTD_DECODER_INTERNAL_BUFFER  (1 << 16)
+#endif
+
+#define ZSTD_LBMIN 64
+#define ZSTD_LBMAX (128 << 10)
+
+/* extra buffer, compensates when dst is not large enough to store litBuffer */
+#define ZSTD_LITBUFFEREXTRASIZE  BOUNDED(ZSTD_LBMIN, ZSTD_DECODER_INTERNAL_BUFFER, ZSTD_LBMAX)
+
+typedef enum {
+    ZSTD_not_in_dst = 0,  /* Stored entirely within litExtraBuffer */
+    ZSTD_in_dst = 1,           /* Stored entirely within dst (in memory after current output write) */
+    ZSTD_split = 2            /* Split between litExtraBuffer and dst */
+} ZSTD_litLocation_e;
+
 struct ZSTD_DCtx_s
 {
     const ZSTD_seqSymbol* LLTptr;
@@ -136,7 +152,9 @@ struct ZSTD_DCtx_s
     size_t litSize;
     size_t rleSize;
     size_t staticSize;
+#if DYNAMIC_BMI2 != 0
     int bmi2;                     /* == 1 if the CPU supports BMI2 and 0 otherwise. CPU support is determined dynamically once per context lifetime. */
+#endif
 
     /* dictionary */
     ZSTD_DDict* ddictLocal;
@@ -158,16 +176,16 @@ struct ZSTD_DCtx_s
     size_t outStart;
     size_t outEnd;
     size_t lhSize;
-    void* legacyContext;
-    U32 previousLegacyVersion;
-    U32 legacyVersion;
     U32 hostageByte;
     int noForwardProgress;
     ZSTD_bufferMode_e outBufferMode;
     ZSTD_outBuffer expectedOutBuffer;
 
     /* workspace */
-    BYTE litBuffer[ZSTD_BLOCKSIZE_MAX + WILDCOPY_OVERLENGTH];
+    BYTE* litBuffer;
+    const BYTE* litBufferEnd;
+    ZSTD_litLocation_e litBufferLocation;
+    BYTE litExtraBuffer[ZSTD_LITBUFFEREXTRASIZE + WILDCOPY_OVERLENGTH]; /* literal buffer can be split between storage within dst and within this scratch buffer */
     BYTE headerBuffer[ZSTD_FRAMEHEADERSIZE_MAX];
 
     size_t oversizedDuration;
@@ -180,6 +198,14 @@ struct ZSTD_DCtx_s
     /* Tracing */
 };  /* typedef'd to ZSTD_DCtx within "zstd.h" */
 
+MEM_STATIC int ZSTD_DCtx_get_bmi2(const struct ZSTD_DCtx_s *dctx) {
+#if DYNAMIC_BMI2 != 0
+	return dctx->bmi2;
+#else
+    (void)dctx;
+	return 0;
+#endif
+}
 
 /*-*******************************************************
  *  Shared internal functions
diff --git a/lib/zstd/decompress_sources.h b/lib/zstd/decompress_sources.h
index 0fbec508f285..a06ca187aab5 100644
--- a/lib/zstd/decompress_sources.h
+++ b/lib/zstd/decompress_sources.h
@@ -16,6 +16,12 @@
  * decompression.
  */
 
+/*
+ * Disable the ASM Huffman implementation because we need to
+ * include all the sources.
+ */
+#define ZSTD_DISABLE_ASM 1
+
 #include "common/debug.c"
 #include "common/entropy_common.c"
 #include "common/error_private.c"
diff --git a/lib/zstd/zstd_compress_module.c b/lib/zstd/zstd_compress_module.c
index 65548a4bb934..04e1b5c01d9b 100644
--- a/lib/zstd/zstd_compress_module.c
+++ b/lib/zstd/zstd_compress_module.c
@@ -133,7 +133,11 @@ EXPORT_SYMBOL(zstd_init_cstream);
 size_t zstd_reset_cstream(zstd_cstream *cstream,
 	unsigned long long pledged_src_size)
 {
-	return ZSTD_resetCStream(cstream, pledged_src_size);
+	if (pledged_src_size == 0)
+		pledged_src_size = ZSTD_CONTENTSIZE_UNKNOWN;
+	ZSTD_FORWARD_IF_ERR( ZSTD_CCtx_reset(cstream, ZSTD_reset_session_only) );
+	ZSTD_FORWARD_IF_ERR( ZSTD_CCtx_setPledgedSrcSize(cstream, pledged_src_size) );
+	return 0;
 }
 EXPORT_SYMBOL(zstd_reset_cstream);
 
-- 
2.38.1

