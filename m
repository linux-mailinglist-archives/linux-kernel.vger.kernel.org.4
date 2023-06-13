Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06E572ED32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjFMUkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjFMUjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A392EB8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 383D061337
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910F0C433C0;
        Tue, 13 Jun 2023 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686688789;
        bh=sLZ+P360Imf7bwyICslM2xpcRXFrq+wunkzXqiYuC6c=;
        h=From:To:Cc:Subject:Date:From;
        b=nZ9YV6tj3Y7La98xNEpw85oJMLL0gU6jsgf/cp7ApkpVAIGvgK6noVqsGG3xyy9Gu
         qcoPD2tHLvUPYABIyRfS7fHlQU9EEILPo0vYwdBWx2sCCWEkQIZjcMJNFeO9eqj2sP
         73Qo3VEL0dr2ed1HPLZUgIVLNeAkLCRKj6dvVtchxtkHTNfnyn/IcY4u0gsI8qel8k
         mS5CKjoi8WAUQYkx8m7mDD1zIOMl6B8vDuaCeRRLrF38IBPr/da4aC7HQuA16C5rtS
         CkWfC0E0PkN0djNLLccF3WAUuZXccRiDUJ05GJ4hhRaHyhA3miYfEQE1/sg5rX/Vsi
         smDV0j5ZU5Vxw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not issue small discard commands during checkpoint
Date:   Tue, 13 Jun 2023 13:39:47 -0700
Message-ID: <20230613203947.2745943-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there're huge # of small discards, this will increase checkpoint latency
insanely. Let's issue small discards only by trim.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0c0c033c4bdd..ef46bb085385 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2178,7 +2178,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
-	if (!f2fs_block_unit_discard(sbi))
+	if (!f2fs_block_unit_discard(sbi) || !force)
 		goto wakeup;
 
 	/* send small discards */
@@ -2192,8 +2192,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					sbi->blocks_per_seg, cur_pos);
 			len = next_pos - cur_pos;
 
-			if (f2fs_sb_has_blkzoned(sbi) ||
-			    (force && len < cpc->trim_minlen))
+			if (f2fs_sb_has_blkzoned(sbi) || len < cpc->trim_minlen)
 				goto skip;
 
 			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
-- 
2.41.0.162.gfafddb0af9-goog

