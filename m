Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E707062FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjEQIfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjEQIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:34:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5804B40DA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25344113e9bso320284a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684312431; x=1686904431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeHWs4TMvYrjLFyahG6AgBgtUUvTSDY2RBDGAImwGlQ=;
        b=IxZUXD8Mc4d+wNZM5tj1OTlkG8zL0Gr58LSDP8rzdDNcegxwgMVUx2RdFRBj2ACCHO
         m5PztVZlr6NXC/1mX7VmvpX+MUMmtnN9v4vMkqyhHImGM/FbwfbHjw7qmQ7z0bPWtMGD
         hUVbNp4PDHNNUa/UoAMBmIMKMtNwwqCDCUWhOMDkHqmSXqQGDkfLb0lNbR98pmM+4fpX
         pYK/IpFc4ryGPkfay5BuSqWiTAZacfULHsWsG9loNVfdZ1Q83kdQY1xLxwl29lzYFQnB
         hCHtmTqO7mKTAFx+y8G1HsSnA3ABcr54jL9drRjq1ZLCt2uppxxtCQhBs1OyFOtKb4M3
         fGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312431; x=1686904431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeHWs4TMvYrjLFyahG6AgBgtUUvTSDY2RBDGAImwGlQ=;
        b=eIFXYHVyZkOaLHnb/hRPBaBd6Mqyh3wlTL9OQpNSVSjYaHcBu3mCY47DQQATFrZm8+
         tDsqzEOWhuhcPoS1dcNt8jHZk+U/j76CohYcvE37h5AynFRBZnotFMGb2jhs4DCRs2hP
         xJbQjMesqpak4PuMfNJK+aMk1D3M5JXzVn3J/Bsb0UOtXyVRltgHIynMetdmRzMybGlk
         lOs5imP7NL4Z1but7AE9DcJmcIKEOkKS5EudnExVm90SsOxDZZ9So6qct3RmwVm4ZUYg
         mZibLUaeCv43pEv6Ds2MJkCUdO3o+TAM53Z/vfVwntJFl1PrOUv5vMRJkSrcPvJv8JLJ
         mpbw==
X-Gm-Message-State: AC+VfDxC0jfLkW4OpUQLMcY65K42yU1BpOv8ZPIdXw2tzDTe6V4pq0Wl
        tMtYfHOJ8cAOeI1l2MFntOY=
X-Google-Smtp-Source: ACHHUZ6s0YDlCaMpPsx+XCwz31zvZDx5d9/HorLAI5gfFLW4w5AVtacB90JBFp2h6DtMoaNDt4HxgQ==
X-Received: by 2002:a17:90b:198b:b0:24b:8480:39d6 with SMTP id mv11-20020a17090b198b00b0024b848039d6mr38463980pjb.0.1684312431259;
        Wed, 17 May 2023 01:33:51 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id h1-20020a17090adb8100b0024de39e8746sm984586pjv.11.2023.05.17.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 01:33:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1BA8B10627B; Wed, 17 May 2023 15:33:46 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jan Kara <jack@suse.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 1/2] fs: udf: Replace GPL 2.0 boilerplate license notice with SPDX identifier
Date:   Wed, 17 May 2023 15:33:43 +0700
Message-Id: <20230517083344.1090863-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517083344.1090863-1-bagasdotme@gmail.com>
References: <20230517083344.1090863-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9922; i=bagasdotme@gmail.com; h=from:subject; bh=ENYRulR8xCF2JJMyQYtBQI3u1s5NMgEVv0myAKHeNJ8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpE9PFex/zPNrwSsavT2xyRnu9nVqG6aQla4/lVLzeu +DoY/UNHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZgIvzPDP7OpDzUnTV7D3yMU 3SbEy+wl6iYTXM9Sdfpohp9hW0bHUUaGe3W71ezWbGW6Kqym6sTlm3KJ84jpnkAl8cufYx1dbs7 mAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The notice refers to full GPL 2.0 text on now defunct MIT FTP site [1].
Replace it with appropriate SPDX license identifier.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pali Rohár <pali@kernel.org>
Link: https://web.archive.org/web/20020809115410/ftp://prep.ai.mit.edu/pub/gnu/GPL [1]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/udf/balloc.c    | 6 +-----
 fs/udf/dir.c       | 6 +-----
 fs/udf/directory.c | 6 +-----
 fs/udf/file.c      | 6 +-----
 fs/udf/ialloc.c    | 6 +-----
 fs/udf/inode.c     | 6 +-----
 fs/udf/lowlevel.c  | 6 +-----
 fs/udf/misc.c      | 6 +-----
 fs/udf/namei.c     | 6 +-----
 fs/udf/partition.c | 6 +-----
 fs/udf/super.c     | 6 +-----
 fs/udf/symlink.c   | 6 +-----
 fs/udf/truncate.c  | 6 +-----
 fs/udf/unicode.c   | 6 +-----
 14 files changed, 14 insertions(+), 70 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 14b9db4c80f03f..ab3ffc355949dc 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * balloc.c
  *
@@ -5,11 +6,6 @@
  *	Block allocation handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1999-2001 Ben Fennema
  *  (C) 1999 Stelias Computing Inc
  *
diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index 212393b12c2266..f6533f93851b95 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * dir.c
  *
@@ -5,11 +6,6 @@
  *  Directory handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2004 Ben Fennema
  *
  * HISTORY
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 654536d2b60976..1c775e072b2fef 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * directory.c
  *
  * PURPOSE
  *	Directory related functions
  *
- * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
  */
 
 #include "udfdecl.h"
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 8238f742377bab..b871b85457e5bb 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * file.c
  *
@@ -5,11 +6,6 @@
  *  File handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *  This file is distributed under the terms of the GNU General Public
- *  License (GPL). Copies of the GPL can be obtained from:
- *    ftp://prep.ai.mit.edu/pub/gnu/GPL
- *  Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-1999 Dave Boynton
  *  (C) 1998-2004 Ben Fennema
  *  (C) 1999-2000 Stelias Computing Inc
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 8d50121778a57d..5f7ac8c8479873 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * ialloc.c
  *
@@ -5,11 +6,6 @@
  *	Inode allocation handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2001 Ben Fennema
  *
  * HISTORY
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 1e71e04ae8f6b9..28cdfc57d946e3 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * inode.c
  *
@@ -5,11 +6,6 @@
  *  Inode handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *  This file is distributed under the terms of the GNU General Public
- *  License (GPL). Copies of the GPL can be obtained from:
- *    ftp://prep.ai.mit.edu/pub/gnu/GPL
- *  Each contributing author retains all rights to their own work.
- *
  *  (C) 1998 Dave Boynton
  *  (C) 1998-2004 Ben Fennema
  *  (C) 1999-2000 Stelias Computing Inc
diff --git a/fs/udf/lowlevel.c b/fs/udf/lowlevel.c
index c87ed942d07653..9d847a7a0905dd 100644
--- a/fs/udf/lowlevel.c
+++ b/fs/udf/lowlevel.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * lowlevel.c
  *
@@ -5,11 +6,6 @@
  *  Low Level Device Routines for the UDF filesystem
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1999-2001 Ben Fennema
  *
  * HISTORY
diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 3777468d06ce58..0788593b6a1d8b 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * misc.c
  *
@@ -5,11 +6,6 @@
  *	Miscellaneous routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1998 Dave Boynton
  *  (C) 1998-2004 Ben Fennema
  *  (C) 1999-2000 Stelias Computing Inc
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index fd20423d3ed24c..49e1e0fe3feeb2 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * namei.c
  *
@@ -5,11 +6,6 @@
  *      Inode name handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *      This file is distributed under the terms of the GNU General Public
- *      License (GPL). Copies of the GPL can be obtained from:
- *              ftp://prep.ai.mit.edu/pub/gnu/GPL
- *      Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2004 Ben Fennema
  *  (C) 1999-2000 Stelias Computing Inc
  *
diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index 5bcfe78d5cabe9..af877991edc13a 100644
--- a/fs/udf/partition.c
+++ b/fs/udf/partition.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * partition.c
  *
@@ -5,11 +6,6 @@
  *      Partition handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *      This file is distributed under the terms of the GNU General Public
- *      License (GPL). Copies of the GPL can be obtained from:
- *              ftp://prep.ai.mit.edu/pub/gnu/GPL
- *      Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2001 Ben Fennema
  *
  * HISTORY
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 6304e3c5c3d969..928a04d9d9e0ad 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * super.c
  *
@@ -15,11 +16,6 @@
  *    https://www.iso.org/
  *
  * COPYRIGHT
- *  This file is distributed under the terms of the GNU General Public
- *  License (GPL). Copies of the GPL can be obtained from:
- *    ftp://prep.ai.mit.edu/pub/gnu/GPL
- *  Each contributing author retains all rights to their own work.
- *
  *  (C) 1998 Dave Boynton
  *  (C) 1998-2004 Ben Fennema
  *  (C) 2000 Stelias Computing Inc
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index a34c8c4e6d2109..779b5c2c75f61e 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * symlink.c
  *
@@ -5,11 +6,6 @@
  *	Symlink handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2001 Ben Fennema
  *  (C) 1999 Stelias Computing Inc
  *
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 2e7ba234bab8b8..a686c10fd709d1 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * truncate.c
  *
@@ -5,11 +6,6 @@
  *	Truncate handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1999-2004 Ben Fennema
  *  (C) 1999 Stelias Computing Inc
  *
diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 622569007b530b..ae6e809fa3aac7 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * unicode.c
  *
@@ -11,11 +12,6 @@
  *	UTF-8 is explained in the IETF RFC XXXX.
  *		ftp://ftp.internic.net/rfc/rfcxxxx.txt
  *
- * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
  */
 
 #include "udfdecl.h"
-- 
An old man doll... just what I always wanted! - Clara

