Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE23F6E35FA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDPIEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjDPIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8341198C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681632191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AsijbwtgVEkna0mqKPvq39T6ILYAssDt/QkxZMA9A3U=;
        b=VFCKw0NktuETzXgdnnhIj/sjXmrgwvm4XjZxNR211M5TU6Q4gewLboMqnvyYV0JybmqjoA
        yJM/h6LKE/iYkaK2Xz8Iq+3xPrpm/uEl+BwGe0lGTT4i/fHw2kbKO7OXFp1f94O3xu+aI+
        vd6iTYZGP1YCGjBwUebV4GdOA+Yexi8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-hjV_DpwiO7-7VHuSVIPl6g-1; Sun, 16 Apr 2023 04:03:10 -0400
X-MC-Unique: hjV_DpwiO7-7VHuSVIPl6g-1
Received: by mail-pg1-f197.google.com with SMTP id 185-20020a6302c2000000b005135edbb985so7390070pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681632189; x=1684224189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsijbwtgVEkna0mqKPvq39T6ILYAssDt/QkxZMA9A3U=;
        b=gHIvrMpSqHoNFQwJQeWV990ji8p7E3QXBUHfRLjBAnwOg+kbfTPA6uVN9omRx5uO54
         udH3U96k0TQmRjbuFPM6a2RNh6DKazrSidgzINAXK53bYPIPOKCSth+xwU3KHMc4ncJf
         GFryoyQPh7z2gkJPVJONwTTvzOp2mEhLwq4v92qnm43l7h/e+zZQN8Scdspg4+NWhxij
         sfHZWc75+x5g1rd/t82XA1YRhVGHpJ19JhJGn76UgqIpRmhuqgmGVqllw7EzfUQyOmVO
         btbpaXjQBxp3IgtOxziJyoyScpZn406FiJIMiey3aDhDcKY2xrHXIUtAFRo99wQfgf/0
         MYLg==
X-Gm-Message-State: AAQBX9fJABunyDRPAb4beqzFncTEteWOvn6eftvnVHtbFBQn4Q1l5vpy
        oTpz9zzescuTHGe9QZZosX3kUTcEtE7LaPioOFZeqc1o0AAfyfUaAhhb8q03Sv8SYBZAyh3eg7C
        e432mljqG92TFJPfHdi+ZO2CA
X-Received: by 2002:a17:90b:3142:b0:247:1418:ad28 with SMTP id ip2-20020a17090b314200b002471418ad28mr11833211pjb.22.1681632189067;
        Sun, 16 Apr 2023 01:03:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZR/fotGBjjHkP5yM7BBh+tw0Fju8WOiq76VFEefygG+nrCNioyyqTni3EqrQkp1uEpO3DhlQ==
X-Received: by 2002:a17:90b:3142:b0:247:1418:ad28 with SMTP id ip2-20020a17090b314200b002471418ad28mr11833160pjb.22.1681632188152;
        Sun, 16 Apr 2023 01:03:08 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id b16-20020a17090a101000b00246ba2b48f3sm2572971pja.3.2023.04.16.01.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 01:03:07 -0700 (PDT)
From:   Ryosuke Yasuoka <ryasuoka@redhat.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, sandeen@sandeen.net,
        Ryosuke Yasuoka <ryasuoka@redhat.com>
Subject: [PATCH v3] xfs: Use for_each_perag() to iterate all available AGs
Date:   Sun, 16 Apr 2023 17:02:37 +0900
Message-Id: <20230416080237.16005-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfs_filestream_pick_ag() iterates all available AGs when no
unassociated AGs are available by using for_each_perag_wrap().
To iterate all the available AGs, just use for_each_perag() instead.

Also, create xfs_perag_get_first_avail(). It encapslate the iteration
since it is common operation.

Chnages since v2 [1]:
Use for_each_perag() to iterate all available AGs.
Encapsulate these operations into xfs_perag_get_first_avail().
Set err to zero in its declaration.

[1] https://lore.kernel.org/linux-xfs/20230410160727.3748239-1-ryasuoka@redhat.com/raw

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 fs/xfs/xfs_filestream.c |  5 ++---
 fs/xfs/xfs_filestream.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
index 22c13933c8f8..66e0d74fe235 100644
--- a/fs/xfs/xfs_filestream.c
+++ b/fs/xfs/xfs_filestream.c
@@ -67,7 +67,7 @@ xfs_filestream_pick_ag(
 	xfs_extlen_t		free = 0, minfree, maxfree = 0;
 	xfs_agnumber_t		agno;
 	bool			first_pass = true;
-	int			err;
+	int			err = 0;
 
 	/* 2% of an AG's blocks must be free for it to be chosen. */
 	minfree = mp->m_sb.sb_agblocks / 50;
@@ -151,8 +151,7 @@ xfs_filestream_pick_ag(
 		 * grab.
 		 */
 		if (!max_pag) {
-			for_each_perag_wrap(args->mp, 0, start_agno, args->pag)
-				break;
+			args->pag = xfs_perag_get_first_avail(mp);
 			atomic_inc(&args->pag->pagf_fstrms);
 			*longest = 0;
 		} else {
diff --git a/fs/xfs/xfs_filestream.h b/fs/xfs/xfs_filestream.h
index 84149ed0e340..92faf84c287f 100644
--- a/fs/xfs/xfs_filestream.h
+++ b/fs/xfs/xfs_filestream.h
@@ -6,6 +6,8 @@
 #ifndef __XFS_FILESTREAM_H__
 #define __XFS_FILESTREAM_H__
 
+#include "xfs_ag.h"
+
 struct xfs_mount;
 struct xfs_inode;
 struct xfs_bmalloca;
@@ -25,4 +27,18 @@ xfs_inode_is_filestream(
 		(ip->i_diflags & XFS_DIFLAG_FILESTREAM);
 }
 
+static inline struct xfs_perag *
+xfs_perag_get_first_avail(
+		struct xfs_mount	*mp)
+{
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		agno;
+
+	for_each_perag(mp, agno, pag)
+		return pag;
+
+	ASSERT(0);
+	return NULL;
+}
+
 #endif /* __XFS_FILESTREAM_H__ */
-- 
2.39.2

