Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5756EECE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 06:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbjDZEMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 00:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbjDZEM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 00:12:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E9A1990
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:12:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63d4595d60fso40297817b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682482345; x=1685074345;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=colsF3QIXsTiooOemlNXQSPda56nkWMKGesQwoq3aEs=;
        b=mazw8iLRHJGZBQdTJyeMGzuvsIwR4uLQ33MCJ/K5e343t+/FHOL+GrfZhglheX+uqg
         nbKyPWCtuqGV3Vx00K/tF/QYlYHmaGznzQ3ypUHqvk05C6aPqX8PDCofm1mu8j/tzVnl
         /Im8COJ9vjtanht5dTS7i8++Z0tHPkMx5hR5a00sFWHctVsl/khPGC3KeldHXIJo0r1s
         A8jaIKazTg5TYsMVRUUJvB6Gm26PFcBrjC0bGECphRSqNitASGu0y4FFGkAl3zURjDTt
         FqLcxk5aMko+CQcVb/aQNNUURHqU3DB6TrAo6/U0o14clg0mi7ybbo3KKHNk6fNgNzvK
         xpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682482345; x=1685074345;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=colsF3QIXsTiooOemlNXQSPda56nkWMKGesQwoq3aEs=;
        b=gWDFPC5ZdpczpL6vr8n8fCsdDCOW7QqYcJZvBBhSUo4yNyJnbM7DiwNDbNvSkxLRbj
         I7a0xpkf+UYFTbjBFoTv7xLUxssPCPN6+j9GMuqohKGjsrRmJvMfU9KdOWYYkRnQTTOw
         u3YBjx42JpuGRYbRmlfAqK5SW3wXr+cbNg1vftj68amuJ83icZaat/eHEg9/t21L4/Go
         5NoyVKeZj6YQIqUlrA+YAch/FZJPQ0KbX4JfxXW2KL7Oe7Gw2ZHLjbhD6kuh/DBmUtFn
         fQ6sj8UBX2s3A2KBexInrvFmvHX9uIOHzks+yaErTRFGNSOIEdo4AGkhUHebGzMxcDYq
         V+ng==
X-Gm-Message-State: AC+VfDzwGVXXWlRD0sAyCCqlvO6d6ZrVe0hMXqZP5Drv7nbfVGcypnne
        6altzlp9UBxw+abt591hAyGz5gMfiMg=
X-Google-Smtp-Source: ACHHUZ4mxs1ocDrhW6pfoAjpak0Xu9bxJMWsH0LzDxJRxFceS67uB7SM33esHXAp4RsbqHJlcrX4IQ==
X-Received: by 2002:a17:903:445:b0:1a9:7bf4:17d8 with SMTP id iw5-20020a170903044500b001a97bf417d8mr1216085plb.18.1682482345344;
        Tue, 25 Apr 2023 21:12:25 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902bc4500b001a68d613ad9sm8983193plz.132.2023.04.25.21.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 21:12:24 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Subject: [PATCH 1/2] erofs: get rid of name from struct z_erofs_decompressor
Date:   Wed, 26 Apr 2023 12:10:26 +0800
Message-Id: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

There are no users of the name and we can get this via ->alg if needed.
Also, move struct z_erofs_decompressor into decompressor.c which is the
only one to use it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/compress.h     | 6 ------
 fs/erofs/decompressor.c | 9 +++++----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..d161683bda03 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -20,12 +20,6 @@ struct z_erofs_decompress_req {
 	bool inplace_io, partial_decoding, fillgaps;
 };
 
-struct z_erofs_decompressor {
-	int (*decompress)(struct z_erofs_decompress_req *rq,
-			  struct page **pagepool);
-	char *name;
-};
-
 /* some special page->private (unsigned long, see below) */
 #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
 #define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 7021e2cf6146..f416ebd6f0dc 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -363,23 +363,24 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
+struct z_erofs_decompressor {
+	int (*decompress)(struct z_erofs_decompress_req *rq,
+			  struct page **pagepool);
+};
+
 static struct z_erofs_decompressor decompressors[] = {
 	[Z_EROFS_COMPRESSION_SHIFTED] = {
 		.decompress = z_erofs_transform_plain,
-		.name = "shifted"
 	},
 	[Z_EROFS_COMPRESSION_INTERLACED] = {
 		.decompress = z_erofs_transform_plain,
-		.name = "interlaced"
 	},
 	[Z_EROFS_COMPRESSION_LZ4] = {
 		.decompress = z_erofs_lz4_decompress,
-		.name = "lz4"
 	},
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
 	[Z_EROFS_COMPRESSION_LZMA] = {
 		.decompress = z_erofs_lzma_decompress,
-		.name = "lzma"
 	},
 #endif
 };
-- 
2.17.1

