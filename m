Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373116EEFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbjDZH77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbjDZH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:59:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AC030EE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:59:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b67a26069so8784027b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682495996; x=1685087996;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc4wDl/tbFwtdOVf6B2vMeyGyk+KqhBb2cMLF7Q7QOA=;
        b=UJjx2uOOeSPNRatofuOeass7kXfXaJ/hZeZaX82LMUL4prH8MXwLYwvFxgl441r1/E
         d8uDza9GS52WmP2+5fjykj4VeSYiWwjz2EDxUvBRTBoweXqbWkaxU2eLT/4skyRCmVHr
         sRyHF9vP23xkE4ZEmBbEMm1uyxqYKH553phHmJOgsyoxWGbYOhSovDiM/fE9FQpsKZe2
         /eHKJDqUWR0NhOyLvGGs6hLU9KHB7ysaeSxoM6hIenCSTYmutzzLoivJXOdPSiVERKT6
         4Rq+3k3icLaWJ3xSc5SQ174qICutDkrFhAVSJvdNVspH/teldHImc0GTuR/AXRW3vxcd
         FRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682495996; x=1685087996;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc4wDl/tbFwtdOVf6B2vMeyGyk+KqhBb2cMLF7Q7QOA=;
        b=hmn4wzcPIa+QY//2WnThvIzdvseDJXPUSgYnsrHvzaenSG69jKmZ/aTtvcxwFN2t4i
         brd06z5NZLda3ILRtaTjLAQYmsfAq17nABewJZkgyWL6TE6f01zCwLZDAMX5zivi2OUR
         LB8W10vUg+6UghR62HEyOKsrvb9VdtTr2YPmBe5oU8PnYFV21fsC7ijeoDRlg844QRi1
         34nSZ/iqro8hVB7Tbve2gBBCgYHT8cv8+G4RRDHAR8dYNxfTcR9PBiBw8gHjSjSROPOD
         yx37GHYDbq1/J6uoIARRKQsoRImn1nl8s/Iht7TOJhgvJM+CVZkUMwiT1oEkYnqF3vS/
         hM1g==
X-Gm-Message-State: AAQBX9ejzbRFKVAi4X+QqaWDqp1tX38TFLsDYT/5xtdcUtaa8Os75+15
        5UoXQOR8dbuRd7ItRu2m+TengWLzJwY=
X-Google-Smtp-Source: AKy350aQV1dryEZ5Nx3UA8cjnGTmq4Rjsc/TJqsW1biOz6F9bTsbGajPGMeD7QD6iUn3BlDXyn9V3A==
X-Received: by 2002:a05:6a00:2385:b0:63d:4358:9140 with SMTP id f5-20020a056a00238500b0063d43589140mr29634914pfc.34.1682495996234;
        Wed, 26 Apr 2023 00:59:56 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a22-20020a62d416000000b0063f9de332f8sm5364486pfh.167.2023.04.26.00.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 00:59:55 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Subject: [PATCH] erofs: fold in z_erofs_decompress()
Date:   Wed, 26 Apr 2023 15:59:43 +0800
Message-Id: <20230426075943.26629-1-zbestahu@gmail.com>
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

No need this helper since it's just a simple wrapper for decompress
method and only one caller.  So, let's fold in directly instead.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/compress.h     | 3 +--
 fs/erofs/decompressor.c | 8 +-------
 fs/erofs/zdata.c        | 4 +++-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..9e423316f5a1 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -89,8 +89,7 @@ static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
-int z_erofs_decompress(struct z_erofs_decompress_req *rq,
-		       struct page **pagepool);
+extern const struct z_erofs_decompressor decompressors[];
 
 /* prototypes for specific algorithms */
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 7021e2cf6146..5ed82b72a5a5 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -363,7 +363,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
-static struct z_erofs_decompressor decompressors[] = {
+const struct z_erofs_decompressor decompressors[] = {
 	[Z_EROFS_COMPRESSION_SHIFTED] = {
 		.decompress = z_erofs_transform_plain,
 		.name = "shifted"
@@ -383,9 +383,3 @@ static struct z_erofs_decompressor decompressors[] = {
 	},
 #endif
 };
-
-int z_erofs_decompress(struct z_erofs_decompress_req *rq,
-		       struct page **pagepool)
-{
-	return decompressors[rq->alg].decompress(rq, pagepool);
-}
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a90d37c7bdd7..f5c8ab176b23 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1290,6 +1290,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct z_erofs_decompressor decompressor =
+				decompressors[pcl->algorithmformat];
 	unsigned int i, inputsize;
 	int err2;
 	struct page *page;
@@ -1333,7 +1335,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	else
 		inputsize = pclusterpages * PAGE_SIZE;
 
-	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+	err = decompressor.decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
-- 
2.17.1

