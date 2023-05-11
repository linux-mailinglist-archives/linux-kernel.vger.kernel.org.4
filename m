Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0176FEFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbjEKK2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbjEKK2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:28:22 -0400
X-Greylist: delayed 622 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 03:28:20 PDT
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A08EE1FDA
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:28:20 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:33257.1589737745
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.84 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id 2059D2800AB;
        Thu, 11 May 2023 18:17:47 +0800 (CST)
X-189-SAVE-TO-SEND: +renlei1@chinatelecom.cn
Received: from  ([36.111.64.84])
        by app0025 with ESMTP id 119dc4bf77aa4dda88a45456292276a0 for djwong@kernel.org;
        Thu, 11 May 2023 18:17:57 CST
X-Transaction-ID: 119dc4bf77aa4dda88a45456292276a0
X-Real-From: renlei1@chinatelecom.cn
X-Receive-IP: 36.111.64.84
X-MEDUSA-Status: 0
Sender: renlei1@chinatelecom.cn
From:   renlei1@chinatelecom.cn
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ren Lei <renlei1@chinatelecom.cn>
Subject: [PATCH] xfs: xfs_nfs_get_inode support zero generation
Date:   Thu, 11 May 2023 18:17:21 +0800
Message-Id: <1683800241-14488-1-git-send-email-renlei1@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ren Lei <renlei1@chinatelecom.cn>

If generation is zero, bypass the verification of generation number
to avoid stale file error. (Be consistent with other fs, such as
ext4, fat, jfs, etc.)

Signed-off-by: Ren Lei<renlei1@chinatelecom.cn>
---
 fs/xfs/xfs_export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index 1064c2342876..cbee32c5ad37 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -146,7 +146,7 @@ xfs_nfs_get_inode(
 		return ERR_PTR(error);
 	}
 
-	if (VFS_I(ip)->i_generation != generation) {
+	if (generation && VFS_I(ip)->i_generation != generation) {
 		xfs_irele(ip);
 		return ERR_PTR(-ESTALE);
 	}
-- 
2.27.0

