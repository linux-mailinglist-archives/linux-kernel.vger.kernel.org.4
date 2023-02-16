Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1B6989D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBPBbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBPBbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:31:15 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FCD4392F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:31:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d2so391233pjd.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFnTj3xaQGXFaZEZzqz0a+srrlcH3VfM0zva+Qxv9y4=;
        b=TeMPRMUDTveQAZoKz1p1K03tpiFtB/bQSoRJmK+KdSQXS1h0IBYdRXY1vFVaUMP0ys
         4PMyMHzbF8ynVnRRROfyN+//zV/Igm1Cx9rbslEtcvx+Ci+/cncqw3uLZm9S/MsUts0s
         gQuq5wy5moUQkJgJDs1/brGFQ+NyCwrBOOZsmZkZ1h2iT3foZCGLBMXoj3u1LPZXTqE0
         VO31LphxZcoYMfUxi1P7IdqRevNkjWiVYrjwcGJSc2KbxDRDKaYfLaj6KTKtGFD3rQVT
         Yq10ILhnFuIZkrDFJyMBVCFj99/Og9uHIYeFeWt6WwJyMS/7EuNsI/wNMx/eieZ8Zufa
         5umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFnTj3xaQGXFaZEZzqz0a+srrlcH3VfM0zva+Qxv9y4=;
        b=vdIo8+noUDbeEfs4wDTwIqVABeZLkMOLBxgNSXito8vbiNDzSXWRvQGF4ESmDqqxpB
         tC5m39270DD7BWV81NdTlzqUDeJXbKi5MdWee+iLimzM+ysZeW1/+opASpzErJ27iVXp
         T2ERTfwI2urfTtFvCqTjQU8bCzHQ7ZxtR2SEZRZRDdaXCFimiZQ1iP1YpmfWrM2blHJ7
         pHBP4OchiBu7FgMm+kFLHoiqGXto7uNRxD1GFWWVjH95goFYdM30/wZuE0a9sOMUJB2H
         7OV1i/CT4z2ePUMEZ7z8capefBSl4+rnUBE9I2ClNDtv33jqhrTBf14vrP4EdcmmfYAf
         k9fQ==
X-Gm-Message-State: AO0yUKWZVXBoDojIMkSFwF4YkSTFBO2wzjwqWHi9fR/dnI8TdBF17US4
        RrdpgncQj7cwvvkm08/ks8k=
X-Google-Smtp-Source: AK7set9aMj0hytGgw668GcKl/JEGR4c0PS8FOq8W/j5HrlkAFVHy4Xi7TteCtqZz2VmZuR4liR7s5A==
X-Received: by 2002:a05:6a20:a003:b0:bc:92cd:1536 with SMTP id p3-20020a056a20a00300b000bc92cd1536mr4336582pzj.61.1676511073641;
        Wed, 15 Feb 2023 17:31:13 -0800 (PST)
Received: from localhost.localdomain (c-98-35-160-214.hsd1.ca.comcast.net. [98.35.160.214])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b005941ff79428sm5316pfn.90.2023.02.15.17.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:31:12 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Nick Terrell <nickrterrell@gmail.com>,
        Kernel Team <Kernel-team@fb.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, Yann Collet <cyan@fb.com>
Subject: [PATCH 1/1] lib: zstd: Backport fix for in-place decompression
Date:   Wed, 15 Feb 2023 17:39:28 -0800
Message-Id: <20230216013928.1784731-2-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230216013928.1784731-1-nickrterrell@gmail.com>
References: <20230216013928.1784731-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Backport the relevant part of upstream commit 5b266196 [0].

This fixes in-place decompression for x86-64 kernel decompression. It
uses a bound of 131072 + (uncompressed_size >> 8), which can be violated
after upstream commit 6a7ede3d [1], as zstd can use part of the output
buffer as temporary storage, and without this patch needs a bound of
~262144.

The fix is for zstd to detect that the input and output buffers overlap,
so that zstd knows it can't use the overlapping portion of the output
buffer as tempoary storage. If the margin is not large enough, this will
ensure that zstd will fail the decompression, rather than overwriting
part of the input data, and causing corruption.

This fix has been landed upstream and is in release v1.5.4. That commit
also adds unit and fuzz tests to verify that the margin we use is
respected, and correct. That means that the fix is well tested upstream.

I have not been able to reproduce the potential bug in x86-64 kernel
decompression locally, nor have I recieved reports of failures to
decompress the kernel. It is possible that compression saves enough
space to make it very hard for the issue to appear.

I've boot tested the zstd compressed kernel on x86-64 and i386 with this
patch, which uses in-place decompression, and sanity tested zstd compression
in btrfs / squashfs to make sure that we don't see any issues, but other
uses of zstd shouldn't be affected, because they don't use in-place
decompression.

Thanks to Vasily Gorbik <gor@linux.ibm.com> for debugging a related issue
on s390, which was triggered by the same commit, but was a bug in how
__decompress() was called [2]. And to Sasha Levin <sashal@kernel.org>
for the CC alerting me of the issue.

[0] https://github.com/facebook/zstd/commit/5b266196a41e6a15e21bd4f0eeab43b938db1d90
[1] https://github.com/facebook/zstd/commit/6a7ede3dfccbf3e0a5928b4224a039c260dcff72
[2] https://lore.kernel.org/r/patch-1.thread-41c676.git-41c676c2d153.your-ad-here.call-01675030179-ext-9637@work.hours

CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Heiko Carstens <hca@linux.ibm.com>
CC: Sasha Levin <sashal@kernel.org>
CC: Yann Collet <cyan@fb.com>
Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/zstd/decompress/zstd_decompress.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/lib/zstd/decompress/zstd_decompress.c b/lib/zstd/decompress/zstd_decompress.c
index b9b935a9f5c0..6b3177c94711 100644
--- a/lib/zstd/decompress/zstd_decompress.c
+++ b/lib/zstd/decompress/zstd_decompress.c
@@ -798,7 +798,7 @@ static size_t ZSTD_copyRawBlock(void* dst, size_t dstCapacity,
         if (srcSize == 0) return 0;
         RETURN_ERROR(dstBuffer_null, "");
     }
-    ZSTD_memcpy(dst, src, srcSize);
+    ZSTD_memmove(dst, src, srcSize);
     return srcSize;
 }

@@ -858,6 +858,7 @@ static size_t ZSTD_decompressFrame(ZSTD_DCtx* dctx,

     /* Loop on each block */
     while (1) {
+        BYTE* oBlockEnd = oend;
         size_t decodedSize;
         blockProperties_t blockProperties;
         size_t const cBlockSize = ZSTD_getcBlockSize(ip, remainingSrcSize, &blockProperties);
@@ -867,16 +868,34 @@ static size_t ZSTD_decompressFrame(ZSTD_DCtx* dctx,
         remainingSrcSize -= ZSTD_blockHeaderSize;
         RETURN_ERROR_IF(cBlockSize > remainingSrcSize, srcSize_wrong, "");

+        if (ip >= op && ip < oBlockEnd) {
+            /* We are decompressing in-place. Limit the output pointer so that we
+             * don't overwrite the block that we are currently reading. This will
+             * fail decompression if the input & output pointers aren't spaced
+             * far enough apart.
+             *
+             * This is important to set, even when the pointers are far enough
+             * apart, because ZSTD_decompressBlock_internal() can decide to store
+             * literals in the output buffer, after the block it is decompressing.
+             * Since we don't want anything to overwrite our input, we have to tell
+             * ZSTD_decompressBlock_internal to never write past ip.
+             *
+             * See ZSTD_allocateLiteralsBuffer() for reference.
+             */
+            oBlockEnd = op + (ip - op);
+        }
+
         switch(blockProperties.blockType)
         {
         case bt_compressed:
-            decodedSize = ZSTD_decompressBlock_internal(dctx, op, (size_t)(oend-op), ip, cBlockSize, /* frame */ 1, not_streaming);
+            decodedSize = ZSTD_decompressBlock_internal(dctx, op, (size_t)(oBlockEnd-op), ip, cBlockSize, /* frame */ 1, not_streaming);
             break;
         case bt_raw :
+            /* Use oend instead of oBlockEnd because this function is safe to overlap. It uses memmove. */
             decodedSize = ZSTD_copyRawBlock(op, (size_t)(oend-op), ip, cBlockSize);
             break;
         case bt_rle :
-            decodedSize = ZSTD_setRleBlock(op, (size_t)(oend-op), *ip, blockProperties.origSize);
+            decodedSize = ZSTD_setRleBlock(op, (size_t)(oBlockEnd-op), *ip, blockProperties.origSize);
             break;
         case bt_reserved :
         default:
--
2.39.0

