Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4690170AA56
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjETS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjETS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C510F1;
        Sat, 20 May 2023 11:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37C11616C3;
        Sat, 20 May 2023 18:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E1EC433D2;
        Sat, 20 May 2023 18:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607014;
        bh=aks827XbioErvve/dkNRJXRajnnTOO0WCKzcP5cIXm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tapxMojmHUVo5gTl8xp+w/RXAq/zwfxq/ptGPb84oozJU+iFq8DcJ+c2XpOJCrVwb
         FS04GaL9PXcEiKxy782Fijc82i4lxcy3VUEzdKTYvCyPEnGrWVf8SF6T9kCrJMtzJu
         XzO6mw1lsQos74qHftHeRq3lZb0k58pSdnzWavz8nxlx9y3Ks0qa8b2IL1aNcZuGLJ
         hs+a50qy859GiKO5zgfJPsWxFW3A/SJcS2IUK+jbxfN71SA0K5wylGtsqJQ28jTCrR
         F+sFtX5SvOT41i/cXu47ogY6AhU7DeB/m/zF2gBGZITNu3uaqcM2w+Y/RfUd9s45aY
         ESaVPBV7Z2fHQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Yang Lan <lanyang0908@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.10 4/8] gfs2: Don't deref jdesc in evict
Date:   Sat, 20 May 2023 14:23:08 -0400
Message-Id: <20230520182312.851751-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182312.851751-1-sashal@kernel.org>
References: <20230520182312.851751-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit 504a10d9e46bc37b23d0a1ae2f28973c8516e636 ]

On corrupt gfs2 file systems the evict code can try to reference the
journal descriptor structure, jdesc, after it has been freed and set to
NULL. The sequence of events is:

init_journal()
...
fail_jindex:
   gfs2_jindex_free(sdp); <------frees journals, sets jdesc = NULL
      if (gfs2_holder_initialized(&ji_gh))
         gfs2_glock_dq_uninit(&ji_gh);
fail:
   iput(sdp->sd_jindex); <--references jdesc in evict_linked_inode
      evict()
         gfs2_evict_inode()
            evict_linked_inode()
               ret = gfs2_trans_begin(sdp, 0, sdp->sd_jdesc->jd_blocks);
<------references the now freed/zeroed sd_jdesc pointer.

The call to gfs2_trans_begin is done because the truncate_inode_pages
call can cause gfs2 events that require a transaction, such as removing
journaled data (jdata) blocks from the journal.

This patch fixes the problem by adding a check for sdp->sd_jdesc to
function gfs2_evict_inode. In theory, this should only happen to corrupt
gfs2 file systems, when gfs2 detects the problem, reports it, then tries
to evict all the system inodes it has read in up to that point.

Reported-by: Yang Lan <lanyang0908@gmail.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 5cb7e771b57ab..e01b6a2d12d30 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1416,6 +1416,14 @@ static void gfs2_evict_inode(struct inode *inode)
 	if (inode->i_nlink || sb_rdonly(sb))
 		goto out;
 
+	/*
+	 * In case of an incomplete mount, gfs2_evict_inode() may be called for
+	 * system files without having an active journal to write to.  In that
+	 * case, skip the filesystem evict.
+	 */
+	if (!sdp->sd_jdesc)
+		goto out;
+
 	gfs2_holder_mark_uninitialized(&gh);
 	ret = evict_should_delete(inode, &gh);
 	if (ret == SHOULD_DEFER_EVICTION)
-- 
2.39.2

