Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69F26F7383
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjEDTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjEDTnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5A17EF1;
        Thu,  4 May 2023 12:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B8AE6305B;
        Thu,  4 May 2023 19:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28427C4339B;
        Thu,  4 May 2023 19:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229366;
        bh=hH/l81anuCs6BR9skkB2qfBrEHiihE5JzFvsKGzSM9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaSgldHf2OrdqjbmGpoR8dDujwvthKbXXwyjW2qkxd+yw+Cy3FCgq29dkGkxu16yi
         0I8IZM6ebRugDwqNSCdlyRvep2Fq3mQLgBnGlCtx0F38KmFCI/dE+Iiz4xjFihLOV1
         Db2Q9xih1kwmCvo0IVLnSFhTBoksU0DfcTLQA1HBlWfoPWZoQGDQt16rWCdfo0+FMu
         OrzjmbLdKpaK3YXHPwFq69XSsOPoJ6OYsp0D7++7IzeWKCzrujD3lqUJXqN6s2GnFT
         Hc+y5Q6iQMNIteX57IxjNGbgVl6xtmi1lJlzAEjjPDH/3hDEb8WwMCWa6csPDKR7F5
         IsvXYC+UqHBvQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, rpeterso@redhat.com,
        cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 6.3 22/59] gfs2: Fix inode height consistency check
Date:   Thu,  4 May 2023 15:41:05 -0400
Message-Id: <20230504194142.3805425-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit cfcdb5bad34f600aed7613c3c1a5e618111f77b7 ]

The maximum allowed height of an inode's metadata tree depends on the
filesystem block size; it is lower for bigger-block filesystems.  When
reading in an inode, make sure that the height doesn't exceed the
maximum allowed height.

Arrays like sd_heightsize are sized to be big enough for any filesystem
block size; they will often be slightly bigger than what's needed for a
specific filesystem.

Reported-by: syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 4d99cc77a29b7..b65950e76be5a 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -396,6 +396,7 @@ static int inode_go_demote_ok(const struct gfs2_glock *gl)
 
 static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	const struct gfs2_dinode *str = buf;
 	struct timespec64 atime;
 	u16 height, depth;
@@ -442,7 +443,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	/* i_diskflags and i_eattr must be set before gfs2_set_inode_flags() */
 	gfs2_set_inode_flags(inode);
 	height = be16_to_cpu(str->di_height);
-	if (unlikely(height > GFS2_MAX_META_HEIGHT))
+	if (unlikely(height > sdp->sd_max_height))
 		goto corrupt;
 	ip->i_height = (u8)height;
 
-- 
2.39.2

