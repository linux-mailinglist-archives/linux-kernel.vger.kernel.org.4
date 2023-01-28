Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE84D67F913
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjA1P0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 10:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjA1P0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 10:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A95C7D8E
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674919557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iq/y1QTv41OfHtUj+eR0YkveZjKSMDd8lSSUgPMocJU=;
        b=bgTVTqgASLFdxjcddNt1ivpNOAMKzTeNRFOg9BYsEkVrsQRG0NE5hiezfRDURG3ju653hR
        6AfDRn91VvFzH+cBQPzodXaASFSWimlA7VMgMHaJWsHdkGx37yQ4xGPaGP79sQ4hBoxs9w
        FWAMoGDMo+liTd9dT6XOwjRB/LNkZug=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-XWzMTuTTOCCZcU-NqinR-Q-1; Sat, 28 Jan 2023 10:25:55 -0500
X-MC-Unique: XWzMTuTTOCCZcU-NqinR-Q-1
Received: by mail-qk1-f198.google.com with SMTP id h13-20020a05620a244d00b006fb713618b8so4915071qkn.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 07:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq/y1QTv41OfHtUj+eR0YkveZjKSMDd8lSSUgPMocJU=;
        b=ntFrsOWu2f+jB2Dl1a6/pHMj3eIUx2s4JP9WLWsRGTw7q+2pEKerwXHtjMt+K94mBd
         3iKgxm2Oek58ITuhGVZyY59cU453PZS5XJXxFknaz4t3b8p7+eo/aUQju+2rVK4wiu+8
         rpKtjYqjONXpRzLrqULyodHps+lRHQLE2o8ZJmKam1nskjVDHM2/+0IXw1ZXJFm3lvAn
         Xvwhh6eQg0DosNwPPtzzAk8NpfMUCEZZ3zkcpVzMCofWz8Oo1MqfviY5ehr++l9BFOw7
         wnMgyfUS+59jT0c3/aVhOhd1Fey4ZM5B8YUItOgRwy3yWoZmd/MS7sKuA4otPEl9wabi
         Csug==
X-Gm-Message-State: AO0yUKXac2CXIBxSjgVjKs+gZ1qfbx2fr6XXTvjVeApr6zJ8nJvKFneL
        ib+BEshD5rc20/JOD/7E8Ug9OYXdIUM+H68DrAVLBkH0ifAK+BIIvCZShsr9oUwlkltQg/jT4mK
        aHqs2ESeTVeXltyQdxqgNeJQJ
X-Received: by 2002:ac8:7f52:0:b0:3b8:53be:e51f with SMTP id g18-20020ac87f52000000b003b853bee51fmr1590922qtk.8.1674919555125;
        Sat, 28 Jan 2023 07:25:55 -0800 (PST)
X-Google-Smtp-Source: AK7set+WWCUaSQResyucKM9xNxLbIuYfnmjyh3J+BnyLvgZQKaX6ZxyzY5bZ9BNdQDEQ6iIGibOtrw==
X-Received: by 2002:ac8:7f52:0:b0:3b8:53be:e51f with SMTP id g18-20020ac87f52000000b003b853bee51fmr1590898qtk.8.1674919554901;
        Sat, 28 Jan 2023 07:25:54 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v3-20020ac87283000000b003b62e9c82ebsm4737008qto.48.2023.01.28.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 07:25:54 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] 9p: remove shadow variable retval in v9fs_dir_release()
Date:   Sat, 28 Jan 2023 07:25:49 -0800
Message-Id: <20230128152549.1241870-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
fs/9p/vfs_dir.c:219:8: style: Local variable 'retval' shadows outer variable [shadowVariable]
   int retval = file_write_and_wait_range(filp, 0, -1);
       ^

Having another retval decl is not needed, if the initialized 0 is overwritten by a non 0
value by the call to file_write_and_wait_ranget(), the function returns early.

Fixes: b67c64fb0143 ("fs/9p: Consolidate file operations and add readahead and writeback")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/9p/vfs_dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 1fc07bb86e6f..a5783afdf31a 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -216,7 +216,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		 inode, filp, fid ? fid->fid : -1);
 	if (fid) {
 		if ((fid->qid.type == P9_QTFILE) && (filp->f_mode & FMODE_WRITE)) {
-			int retval = file_write_and_wait_range(filp, 0, -1);
+			retval = file_write_and_wait_range(filp, 0, -1);
 
 			if (retval != 0) {
 				p9_debug(P9_DEBUG_ERROR,
-- 
2.26.3

