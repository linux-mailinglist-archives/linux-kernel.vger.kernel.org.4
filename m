Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2D6CDAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjC2N1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjC2N1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:27:11 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9431040D7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680096430;
  x=1711632430;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=UkIA7Mg0wkSS6SCzGoV03/Dn00Q/NHxhddn7Mq3em5s=;
  b=kQLty5mD+HuwKux26PscmHCZrct9mVvW2IJr6w9kwk832aC0Frx2KtLB
   EErZwkyJlgQvBircJzLuCV3V/tNSaDaVUHWrU9MnhpJB0Syd22YOBWilo
   cxXto2Ce6L+ugbD1AyZ1KWZyRtQaKeT3EHJr62uYP9DFKR70wArp2gAIk
   GKrKeCfEqMbAc3fscSX0KwhzpNPRz6lbXOImuYD/Ck9oplrddEAXKuQ4S
   joaGchcaAne+E4gCGWxBQBnQZ1CGqraaWY0xNL0WVuOGqQgGY/ItEjiOq
   x5dOpuj1zxjEvzqIX6Dm9vA5WDiCdZtsLlonKJllHiwJo9E0aWf0XUEuc
   w==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Wed, 29 Mar 2023 15:26:53 +0200
Subject: [PATCH] ubifs: Free memory for tmpfile name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230329-memleak-fix-v1-1-7133da56ea8f@axis.com>
X-B4-Tracking: v=1; b=H4sIAJw8JGQC/x2N0QqCQBBFf0XmuYF1lcp+JXoY9ZpD7RYzEYH47
 649Hs493IUcpnC6VAsZvur6ygXqQ0XDLPkO1rEwxRCb0MSOE9IT8uBJf3w+SahHmdpjBypFLw7
 uTfIw700S/8B28TaU/f/melvXDQwLA4N2AAAA
To:     Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680096427; l=1436;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=BQF80pngKmi7ePG4d1VaptHuj1kVld09nplcrbehaww=;
 b=Wvpk/gDC9fmrtxlT41NqXHys/iJAdKNjJrY/dL3U76qd1MDSOBEs23HKh7iROqCk4lHiEK6Yf
 OEfjY8L0EmPAhlI6/aIADRvPqm1Bky8DE/PD2Fb3td7QdZkuJ8mb3Tm
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When opening a ubifs tmpfile on an encrypted directory, function
fscrypt_setup_filename allocates memory for the name that is to be
stored in the directory entry, but after the name has been copied to the
directory entry inode, the memory is not freed.

When running kmemleak on it we see that it is registered as a leak. The
report below is triggered by a simple program 'tmpfile' just opening a
tmpfile:

  unreferenced object 0xffff88810178f380 (size 32):
    comm "tmpfile", pid 509, jiffies 4294934744 (age 1524.742s)
    backtrace:
      __kmem_cache_alloc_node
      __kmalloc
      fscrypt_setup_filename
      ubifs_tmpfile
      vfs_tmpfile
      path_openat

Free this memory after it has been copied to the inode.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 fs/ubifs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 0f29cf201136..089ca6910124 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -491,6 +491,7 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out_cancel;
 	unlock_2_inodes(dir, inode);
 
+	fscrypt_free_filename(&nm);
 	ubifs_release_budget(c, &req);
 
 	return finish_open_simple(file, 0);

---
base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
change-id: 20230329-memleak-fix-87a01daf469e

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>

