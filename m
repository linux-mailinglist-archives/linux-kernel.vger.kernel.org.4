Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507C1662F23
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjAISc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbjAISb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:31:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E076822
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:28:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so9823520wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQsYU9s5sn84PfxbWUwiKgQvYiR2Q5ciljT8pIpWjsU=;
        b=XAFYDHBYKwl+i8VwBOR3L46TTB4tcgczPI8XwWID3rKpfMPoK8l4fR6MoM4RsQk/63
         yeX28oBapCO8R9m7mUSrtSr4AtqsxTpJdF60rR4l+mKfzVDp8jyUZ/r67GOtPXrNPmdm
         vaoR/ugbZBQHtERGRCOqlt4i/qKeujw7rVkk++fR9bH+Wa70B0MIzebJQoJVkvd6yEF3
         Lfy8R0w82OOA5daAeAYH3nfLiMPRw/Q22YWONvjQhmYMA5YITSu5imKHYq+3sJwOOe1U
         4zqUph5DwJuF25yox8j7EUhWNpH5zrn2dmK1ip+vjiqe6CL2GfMD2gUoaWTvZY84sxq4
         4z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQsYU9s5sn84PfxbWUwiKgQvYiR2Q5ciljT8pIpWjsU=;
        b=HiTcD+Bzp4UD5FtNl4XHWPWYMM5I1oo10VvwsJqjXg5VHoE6aMhXn2egmdKjy2K/mV
         4hULl8S4hVZWJOuMd1j0etnB9e2JFOVNrWxVKnlZgdcBk40Hg06JdUkwlx2rS+Hi9ghB
         ov8XmJg6R4rvQCNqp10oDQIGiFKOxX434I2kx1JDgygdHBfpnkKqGZ76gOjgiJDVucql
         p3E4LlZbtX9uAC3eUsd+I6Fmkh0EfJshcojLM5a8xiwu3zIaB3oqjduEMFpfC9j8bjH+
         TF9s2VTZU+F41iMSx+FoQSRXRMHQx4g9DvoKn/sjE4W055IenVhJDbe9QfUB3879GDYD
         lriQ==
X-Gm-Message-State: AFqh2ko2GWg5h4d8S/4UN/FZRRW+8Tw+ulTtTKKWHIqwF94qYN6LiRIj
        LR0UBgkd5RJqJMI+vulOcIA=
X-Google-Smtp-Source: AMrXdXvdQA1uVIW4HmQ9fNgn+3QU/3jc0GXynWLUmxWBbUebRPwQZbvMfQ++elGpNPA8d7qpBsAWVg==
X-Received: by 2002:a05:600c:3844:b0:3d3:4406:8a3a with SMTP id s4-20020a05600c384400b003d344068a3amr56867090wmr.30.1673288927542;
        Mon, 09 Jan 2023 10:28:47 -0800 (PST)
Received: from localhost.localdomain (host-79-13-98-249.retail.telecomitalia.it. [79.13.98.249])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003d9dee823a3sm12731141wmq.5.2023.01.09.10.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:28:46 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Christian Brauner <brauner@kernel.org>
Subject: [RESEND PATCH] fs/cramfs: Convert kmap() to kmap_local_data()
Date:   Mon,  9 Jan 2023 19:28:43 +0100
Message-Id: <20230109182843.12056-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The use of kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/cramfs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/cramfs. Instead
of open-coding kmap_local_page() + memcpy(), use memcpy_from_page().

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I'm resending this patch to Al Viro as it was asked by Nicolas[1]. In
the meantime I'm also adding three "Reviewed-by" tags from Christian,
Ira and Nicolas (thanks to you all!).

[1] https://lore.kernel.org/lkml/210n4959-p557-894p-20qp-r595540r0827@syhkavp.arg/

 fs/cramfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 61ccf7722fc3..c17cbba5d45e 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -238,8 +238,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 		struct page *page = pages[i];
 
 		if (page) {
-			memcpy(data, kmap(page), PAGE_SIZE);
-			kunmap(page);
+			memcpy_from_page(data, page, 0, PAGE_SIZE);
 			put_page(page);
 		} else
 			memset(data, 0, PAGE_SIZE);
@@ -815,7 +814,7 @@ static int cramfs_read_folio(struct file *file, struct folio *folio)
 
 	maxblock = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	bytes_filled = 0;
-	pgdata = kmap(page);
+	pgdata = kmap_local_page(page);
 
 	if (page->index < maxblock) {
 		struct super_block *sb = inode->i_sb;
@@ -903,13 +902,13 @@ static int cramfs_read_folio(struct file *file, struct folio *folio)
 
 	memset(pgdata + bytes_filled, 0, PAGE_SIZE - bytes_filled);
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_local(pgdata);
 	SetPageUptodate(page);
 	unlock_page(page);
 	return 0;
 
 err:
-	kunmap(page);
+	kunmap_local(pgdata);
 	ClearPageUptodate(page);
 	SetPageError(page);
 	unlock_page(page);
-- 
2.39.0

