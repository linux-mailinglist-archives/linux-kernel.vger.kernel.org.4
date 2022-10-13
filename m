Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A45FDE12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJMQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJMQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:17:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07BB1382DD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:16:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ot12so5062160ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gvChvblwrqqBVMw+9jrRt287l5o5CC4/lYWsLRZwSc=;
        b=qpaawdzu7lmLyCeZqvh30EUyvgzINjTvwiUjAGTGScpnpx7QAgleBxugMi90sGDp2A
         VsZygBgLxujtOGt3ljp7eNH5USkFGhd81uk5aOrTC9qYLZSK3BJNC3+nmtWyLFKqFphg
         PdhG/mtcupZ/fdtPcbQwpAP+sspowMpvdRQf6oS/JtPok/ucjpOPN+YHxU6iOlUq4PD6
         2maOJ3Duw2Sft4yPLGsNJn5gZ7kzRuxrWlG9P/dhbNKQi6HMb3BjFhijttPW0CQqFHXs
         dopXZID6WXWmawrunP+3yHl71C7g1Y9KKnpx3LRggne8qDKtzmHoOKBqOHS2RlEyfhmm
         UdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gvChvblwrqqBVMw+9jrRt287l5o5CC4/lYWsLRZwSc=;
        b=JvmgsiymK4IeyAJa+N9EP+xn8WzY4C6iRtc79eqYx2JfsTIjZ1FlvLZmXYY+0vasq2
         OMR7BI9wKrKPlAYp4HbWxnhCyTXTggOxyBKMjmO/tbt0YLcQpV6QMmXtqeoD3gIWsnIw
         F6DtMtzblRsEh9X3URPORc+ININGaQjAfamvjscKLt1vWGWUrS0VEFcxIHOpgXAuTFpp
         pvLz6lRPenmIdH8HcW/1YZcf/2g9+FbANtbflRc/qhHBN8edvxBAnQ1OSmP+Cw7GNVr8
         BkrPjjhGLeaPSdeeVtHkyEHwnkgXrnSuHgYO7XKlTu/YWugAQUnSFP/aHt9b+Y62nGrQ
         Rcaw==
X-Gm-Message-State: ACrzQf1q0Qvy0/x/AtNJB8fHInjudXDWwg9g82RCjhJT4jp2CzXJVixY
        Oa4nrjvHLdGT5lL4l52Wpng=
X-Google-Smtp-Source: AMsMyM5TrmjIZdXYcCI5QT+bOwqzoxvCRfsYn3iLK69PBXnak3goClzfSIMXGFShl/ZCVg9mhFRCGQ==
X-Received: by 2002:a17:907:e91:b0:782:607a:8dc9 with SMTP id ho17-20020a1709070e9100b00782607a8dc9mr356300ejc.729.1665677814906;
        Thu, 13 Oct 2022 09:16:54 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-189-63.retail.telecomitalia.it. [79.53.189.63])
        by smtp.gmail.com with ESMTPSA id v8-20020aa7d9c8000000b00458d8c68241sm105950eds.18.2022.10.13.09.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:16:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] fs/hostfs: Replace kmap() with kmap_local_page()
Date:   Thu, 13 Oct 2022 18:17:00 +0200
Message-Id: <20221013161700.11631-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Therefore, replace kmap() with kmap_local_page() in hostfs_kern.c, it
being the only file with kmap() call sites currently left in fs/hostfs.

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

These changes are not tested in a 32 bits VM as I use to do with other more
problematic conversions. Mere code inspection makes me reasonably think
that the rules of local mappings are not violated by this conversion.

Furthermore, I have no idea how to test this code. If maintainers think
that tests are absolutely necessary, any hints about how to perform them
would be greatly appreciated.

 fs/hostfs/hostfs_kern.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 07881b76d42f..0c9f89352601 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -412,7 +412,7 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 	if (page->index >= end_index)
 		count = inode->i_size & (PAGE_SIZE-1);
 
-	buffer = kmap(page);
+	buffer = kmap_local_page(page);
 
 	err = write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
 	if (err != count) {
@@ -428,9 +428,9 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 	err = 0;
 
  out:
-	kunmap(page);
-
+	kunmap_local(buffer);
 	unlock_page(page);
+
 	return err;
 }
 
@@ -441,7 +441,7 @@ static int hostfs_read_folio(struct file *file, struct folio *folio)
 	loff_t start = page_offset(page);
 	int bytes_read, ret = 0;
 
-	buffer = kmap(page);
+	buffer = kmap_local_page(page);
 	bytes_read = read_file(FILE_HOSTFS_I(file)->fd, &start, buffer,
 			PAGE_SIZE);
 	if (bytes_read < 0) {
@@ -458,8 +458,9 @@ static int hostfs_read_folio(struct file *file, struct folio *folio)
 
  out:
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_local(buffer);
 	unlock_page(page);
+
 	return ret;
 }
 
@@ -484,9 +485,9 @@ static int hostfs_write_end(struct file *file, struct address_space *mapping,
 	unsigned from = pos & (PAGE_SIZE - 1);
 	int err;
 
-	buffer = kmap(page);
+	buffer = kmap_local_page(page);
 	err = write_file(FILE_HOSTFS_I(file)->fd, &pos, buffer + from, copied);
-	kunmap(page);
+	kunmap_local(buffer);
 
 	if (!PageUptodate(page) && err == PAGE_SIZE)
 		SetPageUptodate(page);
-- 
2.37.3

