Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CAB74CCAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGJGLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGJGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D60132
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EF4C60DE8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7040AC433C7;
        Mon, 10 Jul 2023 06:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688969463;
        bh=POVkwNRnXDTfSq2EQOtvr5EVAKm/0LZO6D8+9fhg9qo=;
        h=From:To:Cc:Subject:Date:From;
        b=aVlZps9/ljtmmOZ258zRJ3em8y5MKFcpsgUk5gQ2I0RfOelUVPcNP3v4Kje8iStoY
         Wgx7DUbELlRfQ09wzhWlxTys4GqfDbj/ctlfZb7CfNZQzQJPA4cLCuTv9lyU/bZ6dT
         SQ+WU9IelPcfdOZjl4yRnmP7tcqzU+bhR1fi1o6W2LAW1eshtdD2oxdoA7KtXSJOJ3
         02NOZBgZ8CoYrSX9liEIb0q6DDv24srL47b9Dpo3PXFRXR1goSEwulRo2Kvd98pjQj
         qEXO2u+4R4cDosRFb6MeVGT5sw6MegBWj1KlPDwuMBczMODIYJ6AdI5PiXhd6lNs1U
         iuDyi/mUe8o8w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: don't handle error case of f2fs_compress_alloc_page()
Date:   Mon, 10 Jul 2023 14:10:58 +0800
Message-Id: <20230710061058.2303767-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_compress_alloc_page() uses mempool to allocate memory, it never
fail, don't handle error case in its callers.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 236d890f560b..9662d635efbe 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -649,13 +649,8 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 		goto destroy_compress_ctx;
 	}
 
-	for (i = 0; i < cc->nr_cpages; i++) {
+	for (i = 0; i < cc->nr_cpages; i++)
 		cc->cpages[i] = f2fs_compress_alloc_page();
-		if (!cc->cpages[i]) {
-			ret = -ENOMEM;
-			goto out_free_cpages;
-		}
-	}
 
 	cc->rbuf = f2fs_vmap(cc->rpages, cc->cluster_size);
 	if (!cc->rbuf) {
@@ -1574,8 +1569,6 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
 		}
 
 		dic->tpages[i] = f2fs_compress_alloc_page();
-		if (!dic->tpages[i])
-			return -ENOMEM;
 	}
 
 	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
@@ -1656,11 +1649,6 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		struct page *page;
 
 		page = f2fs_compress_alloc_page();
-		if (!page) {
-			ret = -ENOMEM;
-			goto out_free;
-		}
-
 		f2fs_set_compressed_page(page, cc->inode,
 					start_idx + i + 1, dic);
 		dic->cpages[i] = page;
-- 
2.40.1

