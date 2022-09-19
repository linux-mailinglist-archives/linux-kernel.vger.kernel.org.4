Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B325BCB66
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiISME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiISMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:04:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A6410552;
        Mon, 19 Sep 2022 05:04:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so6874107pja.5;
        Mon, 19 Sep 2022 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eI4u84KYFK+dj/YqAg8H8+uUIvvv2P6EQfy6KpkjQso=;
        b=MUfutWPv9hFaiv0rFYWgouVFFl9iEyNOiQucdWCOv1Q+1uFXnyFphu+1o/IVbLdh6a
         n9wdFD5k2tClYGXGTfIygGvf8rhHBfSKgA5iioGTNU4Ew/UG/5fuo/D8JmKOF4cE+y+7
         dLLgtFvdNWH+Yo2CDOa2EEdr1dhX7jCDEYbenJ0RccIqGF1BdVsuQFxSGoyAjDu5xx92
         NYnQUa25uMvABwQWFXQ6zt19ToPt0QnLJ4w7KOzxsnfVKhyTiKnqkddYRpx4Jq0Nu44E
         Jbk1yI2YB6+PYHGZMlwlJb/043Ue5HlQe7fBFkmHYnblR83PNTvF+KpJRF6lA7qFF9z/
         /Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eI4u84KYFK+dj/YqAg8H8+uUIvvv2P6EQfy6KpkjQso=;
        b=nujl4tSnCfiZ+xxezclBmozAMZFlxyr3AZbgHBgVmOtbQYxP0aymGh7D64MUdeiEU4
         z7pTrVusORr1JFVNQ0MPNXObxNc6JYbrN4AWyDjl3lzAuObPQtqqAtjY/EfVCVuYoF+/
         eTmSt5xZhlbsaCIqAOTAPta1wmYHN9Rz3PY5aXeDounPKOQLVf33hM9QA+vqN9B+ZSFe
         6nh7u50rM+376NGjkx7CbAaY+5C3iCUfUndFEkeCVF5E9POli9ZdTFJGVdu42C9IwAMn
         M7APvo2FMta7XbACiuzJ0G6g/4jUU1RkA8YAywGQQdCv9ThczgQHTGd/N5cAwZRZEggc
         yxRg==
X-Gm-Message-State: ACrzQf12NnPsl+pDt+xD114se/O3c8M1tSg/0/hK+m/+CaUXyoXs8aLC
        WSvC/zmO9+9CDhPn284EQpY=
X-Google-Smtp-Source: AMsMyM6+4wgWqU8vuU2PV5k979vWE40wnlNWl9JwSYqRpywEgtYXerH1IRsAyhDrYJ24EAsr/wL17Q==
X-Received: by 2002:a17:903:110d:b0:178:9066:8c66 with SMTP id n13-20020a170903110d00b0017890668c66mr9811194plh.68.1663589060400;
        Mon, 19 Sep 2022 05:04:20 -0700 (PDT)
Received: from bobo.ibm.com (118-208-203-28.tpgi.com.au. [118.208.203.28])
        by smtp.gmail.com with ESMTPSA id 72-20020a62174b000000b0053eec4bb1b1sm20074355pfx.64.2022.09.19.05.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:04:19 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] lib: zstd: build common files separately for compress and decompress
Date:   Mon, 19 Sep 2022 22:04:08 +1000
Message-Id: <20220919120408.3956424-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
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

It is possible for compress to be built as a module and decompress to
be built in, and kernel and module C flags can be different. This can
cause module built code to be linked into the kernel or vice versa.

Use symbolic links from the common code to compression and decompression
module directories to avoid this problem.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
I'm not sure if this is the preferred way to fix it. I hadn't
thought about this problem before but now I notice it in zstd
it seems like it could be a pitfall in other parts of the kernel
as well. Is there a better way to solve it? Or some way to
automatically detect the conflict and fail the build rather than
silently succeed?

Thanks,
Nick

 lib/zstd/Makefile                           | 20 ++++++++++----------
 lib/zstd/compress/common/bitstream.h        |  1 +
 lib/zstd/compress/common/compiler.h         |  1 +
 lib/zstd/compress/common/cpu.h              |  1 +
 lib/zstd/compress/common/debug.c            |  1 +
 lib/zstd/compress/common/debug.h            |  1 +
 lib/zstd/compress/common/entropy_common.c   |  1 +
 lib/zstd/compress/common/error_private.c    |  1 +
 lib/zstd/compress/common/error_private.h    |  1 +
 lib/zstd/compress/common/fse.h              |  1 +
 lib/zstd/compress/common/fse_decompress.c   |  1 +
 lib/zstd/compress/common/huf.h              |  1 +
 lib/zstd/compress/common/mem.h              |  1 +
 lib/zstd/compress/common/zstd_common.c      |  1 +
 lib/zstd/compress/common/zstd_deps.h        |  1 +
 lib/zstd/compress/common/zstd_internal.h    |  1 +
 lib/zstd/decompress/common/bitstream.h      |  1 +
 lib/zstd/decompress/common/compiler.h       |  1 +
 lib/zstd/decompress/common/cpu.h            |  1 +
 lib/zstd/decompress/common/debug.c          |  1 +
 lib/zstd/decompress/common/debug.h          |  1 +
 lib/zstd/decompress/common/entropy_common.c |  1 +
 lib/zstd/decompress/common/error_private.c  |  1 +
 lib/zstd/decompress/common/error_private.h  |  1 +
 lib/zstd/decompress/common/fse.h            |  1 +
 lib/zstd/decompress/common/fse_decompress.c |  1 +
 lib/zstd/decompress/common/huf.h            |  1 +
 lib/zstd/decompress/common/mem.h            |  1 +
 lib/zstd/decompress/common/zstd_common.c    |  1 +
 lib/zstd/decompress/common/zstd_deps.h      |  1 +
 lib/zstd/decompress/common/zstd_internal.h  |  1 +
 31 files changed, 40 insertions(+), 10 deletions(-)
 create mode 120000 lib/zstd/compress/common/bitstream.h
 create mode 120000 lib/zstd/compress/common/compiler.h
 create mode 120000 lib/zstd/compress/common/cpu.h
 create mode 120000 lib/zstd/compress/common/debug.c
 create mode 120000 lib/zstd/compress/common/debug.h
 create mode 120000 lib/zstd/compress/common/entropy_common.c
 create mode 120000 lib/zstd/compress/common/error_private.c
 create mode 120000 lib/zstd/compress/common/error_private.h
 create mode 120000 lib/zstd/compress/common/fse.h
 create mode 120000 lib/zstd/compress/common/fse_decompress.c
 create mode 120000 lib/zstd/compress/common/huf.h
 create mode 120000 lib/zstd/compress/common/mem.h
 create mode 120000 lib/zstd/compress/common/zstd_common.c
 create mode 120000 lib/zstd/compress/common/zstd_deps.h
 create mode 120000 lib/zstd/compress/common/zstd_internal.h
 create mode 120000 lib/zstd/decompress/common/bitstream.h
 create mode 120000 lib/zstd/decompress/common/compiler.h
 create mode 120000 lib/zstd/decompress/common/cpu.h
 create mode 120000 lib/zstd/decompress/common/debug.c
 create mode 120000 lib/zstd/decompress/common/debug.h
 create mode 120000 lib/zstd/decompress/common/entropy_common.c
 create mode 120000 lib/zstd/decompress/common/error_private.c
 create mode 120000 lib/zstd/decompress/common/error_private.h
 create mode 120000 lib/zstd/decompress/common/fse.h
 create mode 120000 lib/zstd/decompress/common/fse_decompress.c
 create mode 120000 lib/zstd/decompress/common/huf.h
 create mode 120000 lib/zstd/decompress/common/mem.h
 create mode 120000 lib/zstd/decompress/common/zstd_common.c
 create mode 120000 lib/zstd/decompress/common/zstd_deps.h
 create mode 120000 lib/zstd/decompress/common/zstd_internal.h

diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index fc45339fc3a3..6d785268f8c3 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -13,11 +13,11 @@ obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
 
 zstd_compress-y := \
 		zstd_compress_module.o \
-		common/debug.o \
-		common/entropy_common.o \
-		common/error_private.o \
-		common/fse_decompress.o \
-		common/zstd_common.o \
+		compress/common/debug.o \
+		compress/common/entropy_common.o \
+		compress/common/error_private.o \
+		compress/common/fse_decompress.o \
+		compress/common/zstd_common.o \
 		compress/fse_compress.o \
 		compress/hist.o \
 		compress/huf_compress.o \
@@ -33,11 +33,11 @@ zstd_compress-y := \
 
 zstd_decompress-y := \
 		zstd_decompress_module.o \
-		common/debug.o \
-		common/entropy_common.o \
-		common/error_private.o \
-		common/fse_decompress.o \
-		common/zstd_common.o \
+		decompress/common/debug.o \
+		decompress/common/entropy_common.o \
+		decompress/common/error_private.o \
+		decompress/common/fse_decompress.o \
+		decompress/common/zstd_common.o \
 		decompress/huf_decompress.o \
 		decompress/zstd_ddict.o \
 		decompress/zstd_decompress.o \
diff --git a/lib/zstd/compress/common/bitstream.h b/lib/zstd/compress/common/bitstream.h
new file mode 120000
index 000000000000..de97b72f47ce
--- /dev/null
+++ b/lib/zstd/compress/common/bitstream.h
@@ -0,0 +1 @@
+../../common/bitstream.h
\ No newline at end of file
diff --git a/lib/zstd/compress/common/compiler.h b/lib/zstd/compress/common/compiler.h
new file mode 120000
index 000000000000..a316286adf05
--- /dev/null
+++ b/lib/zstd/compress/common/compiler.h
@@ -0,0 +1 @@
+../../common/compiler.h
\ No newline at end of file
diff --git a/lib/zstd/compress/common/cpu.h b/lib/zstd/compress/common/cpu.h
new file mode 120000
index 000000000000..35282be494a2
--- /dev/null
+++ b/lib/zstd/compress/common/cpu.h
@@ -0,0 +1 @@
+../../common/cpu.h
\ No newline at end of file
diff --git a/lib/zstd/compress/common/debug.c b/lib/zstd/compress/common/debug.c
new file mode 120000
index 000000000000..5d7b272026d6
--- /dev/null
+++ b/lib/zstd/compress/common/debug.c
@@ -0,0 +1 @@
+../../common/debug.c
\ No newline at end of file
diff --git a/lib/zstd/compress/common/debug.h b/lib/zstd/compress/common/debug.h
new file mode 120000
index 000000000000..15c1e1cd5c95
--- /dev/null
+++ b/lib/zstd/compress/common/debug.h
@@ -0,0 +1 @@
+../../common/debug.h
\ No newline at end of file
diff --git a/lib/zstd/compress/common/entropy_common.c b/lib/zstd/compress/common/entropy_common.c
new file mode 120000
index 000000000000..221119c32817
--- /dev/null
+++ b/lib/zstd/compress/common/entropy_common.c
@@ -0,0 +1 @@
+../../common/entropy_common.c
\ No newline at end of file
diff --git a/lib/zstd/compress/common/error_private.c b/lib/zstd/compress/common/error_private.c
new file mode 120000
index 000000000000..f87d3cf6851f
--- /dev/null
+++ b/lib/zstd/compress/common/error_private.c
@@ -0,0 +1 @@
+../../common/error_private.c
\ No newline at end of file
diff --git a/lib/zstd/compress/common/error_private.h b/lib/zstd/compress/common/error_private.h
new file mode 120000
index 000000000000..30d469222942
--- /dev/null
+++ b/lib/zstd/compress/common/error_private.h
@@ -0,0 +1 @@
+../../common/error_private.h
\ No newline at end of file
diff --git a/lib/zstd/compress/common/fse.h b/lib/zstd/compress/common/fse.h
new file mode 120000
index 000000000000..29c44ebdd2da
--- /dev/null
+++ b/lib/zstd/compress/common/fse.h
@@ -0,0 +1 @@
+../../common/fse.h
\ No newline at end of file
diff --git a/lib/zstd/compress/common/fse_decompress.c b/lib/zstd/compress/common/fse_decompress.c
new file mode 120000
index 000000000000..658e375541f1
--- /dev/null
+++ b/lib/zstd/compress/common/fse_decompress.c
@@ -0,0 +1 @@
+../../common/fse_decompress.c
\ No newline at end of file
diff --git a/lib/zstd/compress/common/huf.h b/lib/zstd/compress/common/huf.h
new file mode 120000
index 000000000000..7c9142232da6
--- /dev/null
+++ b/lib/zstd/compress/common/huf.h
@@ -0,0 +1 @@
+../../common/huf.h
\ No newline at end of file
diff --git a/lib/zstd/compress/common/mem.h b/lib/zstd/compress/common/mem.h
new file mode 120000
index 000000000000..0d9921eb1ca4
--- /dev/null
+++ b/lib/zstd/compress/common/mem.h
@@ -0,0 +1 @@
+../../common/mem.h
\ No newline at end of file
diff --git a/lib/zstd/compress/common/zstd_common.c b/lib/zstd/compress/common/zstd_common.c
new file mode 120000
index 000000000000..5a7475cd3b87
--- /dev/null
+++ b/lib/zstd/compress/common/zstd_common.c
@@ -0,0 +1 @@
+../../common/zstd_common.c
\ No newline at end of file
diff --git a/lib/zstd/compress/common/zstd_deps.h b/lib/zstd/compress/common/zstd_deps.h
new file mode 120000
index 000000000000..21b3a7e967da
--- /dev/null
+++ b/lib/zstd/compress/common/zstd_deps.h
@@ -0,0 +1 @@
+../../common/zstd_deps.h
\ No newline at end of file
diff --git a/lib/zstd/compress/common/zstd_internal.h b/lib/zstd/compress/common/zstd_internal.h
new file mode 120000
index 000000000000..3bf2b94e718f
--- /dev/null
+++ b/lib/zstd/compress/common/zstd_internal.h
@@ -0,0 +1 @@
+../../common/zstd_internal.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/bitstream.h b/lib/zstd/decompress/common/bitstream.h
new file mode 120000
index 000000000000..de97b72f47ce
--- /dev/null
+++ b/lib/zstd/decompress/common/bitstream.h
@@ -0,0 +1 @@
+../../common/bitstream.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/compiler.h b/lib/zstd/decompress/common/compiler.h
new file mode 120000
index 000000000000..a316286adf05
--- /dev/null
+++ b/lib/zstd/decompress/common/compiler.h
@@ -0,0 +1 @@
+../../common/compiler.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/cpu.h b/lib/zstd/decompress/common/cpu.h
new file mode 120000
index 000000000000..35282be494a2
--- /dev/null
+++ b/lib/zstd/decompress/common/cpu.h
@@ -0,0 +1 @@
+../../common/cpu.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/debug.c b/lib/zstd/decompress/common/debug.c
new file mode 120000
index 000000000000..5d7b272026d6
--- /dev/null
+++ b/lib/zstd/decompress/common/debug.c
@@ -0,0 +1 @@
+../../common/debug.c
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/debug.h b/lib/zstd/decompress/common/debug.h
new file mode 120000
index 000000000000..15c1e1cd5c95
--- /dev/null
+++ b/lib/zstd/decompress/common/debug.h
@@ -0,0 +1 @@
+../../common/debug.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/entropy_common.c b/lib/zstd/decompress/common/entropy_common.c
new file mode 120000
index 000000000000..221119c32817
--- /dev/null
+++ b/lib/zstd/decompress/common/entropy_common.c
@@ -0,0 +1 @@
+../../common/entropy_common.c
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/error_private.c b/lib/zstd/decompress/common/error_private.c
new file mode 120000
index 000000000000..f87d3cf6851f
--- /dev/null
+++ b/lib/zstd/decompress/common/error_private.c
@@ -0,0 +1 @@
+../../common/error_private.c
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/error_private.h b/lib/zstd/decompress/common/error_private.h
new file mode 120000
index 000000000000..30d469222942
--- /dev/null
+++ b/lib/zstd/decompress/common/error_private.h
@@ -0,0 +1 @@
+../../common/error_private.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/fse.h b/lib/zstd/decompress/common/fse.h
new file mode 120000
index 000000000000..29c44ebdd2da
--- /dev/null
+++ b/lib/zstd/decompress/common/fse.h
@@ -0,0 +1 @@
+../../common/fse.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/fse_decompress.c b/lib/zstd/decompress/common/fse_decompress.c
new file mode 120000
index 000000000000..658e375541f1
--- /dev/null
+++ b/lib/zstd/decompress/common/fse_decompress.c
@@ -0,0 +1 @@
+../../common/fse_decompress.c
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/huf.h b/lib/zstd/decompress/common/huf.h
new file mode 120000
index 000000000000..7c9142232da6
--- /dev/null
+++ b/lib/zstd/decompress/common/huf.h
@@ -0,0 +1 @@
+../../common/huf.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/mem.h b/lib/zstd/decompress/common/mem.h
new file mode 120000
index 000000000000..0d9921eb1ca4
--- /dev/null
+++ b/lib/zstd/decompress/common/mem.h
@@ -0,0 +1 @@
+../../common/mem.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/zstd_common.c b/lib/zstd/decompress/common/zstd_common.c
new file mode 120000
index 000000000000..5a7475cd3b87
--- /dev/null
+++ b/lib/zstd/decompress/common/zstd_common.c
@@ -0,0 +1 @@
+../../common/zstd_common.c
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/zstd_deps.h b/lib/zstd/decompress/common/zstd_deps.h
new file mode 120000
index 000000000000..21b3a7e967da
--- /dev/null
+++ b/lib/zstd/decompress/common/zstd_deps.h
@@ -0,0 +1 @@
+../../common/zstd_deps.h
\ No newline at end of file
diff --git a/lib/zstd/decompress/common/zstd_internal.h b/lib/zstd/decompress/common/zstd_internal.h
new file mode 120000
index 000000000000..3bf2b94e718f
--- /dev/null
+++ b/lib/zstd/decompress/common/zstd_internal.h
@@ -0,0 +1 @@
+../../common/zstd_internal.h
\ No newline at end of file
-- 
2.37.2

