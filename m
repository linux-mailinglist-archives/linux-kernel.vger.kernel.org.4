Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED206F767D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjEDUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjEDUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0869A19923;
        Thu,  4 May 2023 12:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D3D263858;
        Thu,  4 May 2023 19:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A5BC433A1;
        Thu,  4 May 2023 19:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229949;
        bh=DWXXE1Qgt5ylhoBrjl8jRrgrireq5/zhBXbxdggqznM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHKHaHtA/m4mSYL5XNu43s/gG0JeiUYyMSfqN1BI+I0zs9w731I7EHLnGc7/LPvrb
         tcILvz2YwRaPpVfkN8ZmDtP8tGdbvryHRS+BL+B4y/ZzzRJzfPGaFauyDdNXYhAyO7
         T8e4QsT/41FSeMrz2c1eNbQBcOQoQD/V1irGpSCpfAqQaPdoGQWQ7eI7itIafisszh
         bxqDkDT5PzodOMi2wVjU/m7Mbl50pzBsHq8mCa21gVNRMpeVbMXb0c1O5GoR1EAvjx
         3u5dpLu0QWEVYK2SISQKUkbQs9GnPhHkDhuVlgoNTtMTp3wKNjbRmP9sBQD/IGlXDF
         OT3OilGiYoEkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, rpeterso@redhat.com,
        cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.14 08/13] gfs2: Fix inode height consistency check
Date:   Thu,  4 May 2023 15:52:00 -0400
Message-Id: <20230504195207.3809116-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195207.3809116-1-sashal@kernel.org>
References: <20230504195207.3809116-1-sashal@kernel.org>
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
index f1844af4005b6..4838e26c06f74 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -333,6 +333,7 @@ static int inode_go_demote_ok(const struct gfs2_glock *gl)
 
 static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	const struct gfs2_dinode *str = buf;
 	struct timespec atime;
 	u16 height, depth;
@@ -372,7 +373,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	/* i_diskflags and i_eattr must be set before gfs2_set_inode_flags() */
 	gfs2_set_inode_flags(&ip->i_inode);
 	height = be16_to_cpu(str->di_height);
-	if (unlikely(height > GFS2_MAX_META_HEIGHT))
+	if (unlikely(height > sdp->sd_max_height))
 		goto corrupt;
 	ip->i_height = (u8)height;
 
-- 
2.39.2

