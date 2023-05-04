Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8A6F75E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjEDUCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjEDUBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC7E203F3;
        Thu,  4 May 2023 12:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B027363822;
        Thu,  4 May 2023 19:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69765C4339E;
        Thu,  4 May 2023 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229811;
        bh=2VFGY4HvW2OUGZk0bl99gzoUPjHwc42VfKnYTyrV3dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrU1/vugLVnZUXUhTNGbBSwJG/i22hWPe6dhOEndUAUpaI1g9oolSTPvTGRLjxWol
         KjJbaLOKkkCnDmTCg8LK8vKPjd1I7hdkjKFaCFLeyfPvLriwaGJwm1CvZHywLUPRzf
         R2VQhQ8Xqm6Ctgq/5Um0ddaJY6VFLPQ24VQtx8WWvh58a3UYKM66TwV/5OPFCKH1Qo
         FIO9D+aT5Tg4YuHkdqZw+morGn1MG8kR0c9Q3lmQV3gjE7rCZicXczGTXf6Pky3QTM
         P/gRcg+AzDOHPnhsenrU3lJpjQUxkn00XuMqYm2VT7Fh9Ew1oIFraBGlimMFZMOmNR
         mBCzTLjuW9WKw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, rpeterso@redhat.com,
        cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.10 12/24] gfs2: Fix inode height consistency check
Date:   Thu,  4 May 2023 15:49:25 -0400
Message-Id: <20230504194937.3808414-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194937.3808414-1-sashal@kernel.org>
References: <20230504194937.3808414-1-sashal@kernel.org>
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
index db28c240dae35..87f8110884663 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -405,6 +405,7 @@ static int inode_go_demote_ok(const struct gfs2_glock *gl)
 
 static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	const struct gfs2_dinode *str = buf;
 	struct timespec64 atime;
 	u16 height, depth;
@@ -444,7 +445,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	/* i_diskflags and i_eattr must be set before gfs2_set_inode_flags() */
 	gfs2_set_inode_flags(&ip->i_inode);
 	height = be16_to_cpu(str->di_height);
-	if (unlikely(height > GFS2_MAX_META_HEIGHT))
+	if (unlikely(height > sdp->sd_max_height))
 		goto corrupt;
 	ip->i_height = (u8)height;
 
-- 
2.39.2

