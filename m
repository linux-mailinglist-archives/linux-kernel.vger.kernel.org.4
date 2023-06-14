Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05B773049E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjFNQLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFNQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:11:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E68E1FCC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA6163D68
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC53C433C8;
        Wed, 14 Jun 2023 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686759060;
        bh=d/6LGrrxRVt13rFpG8sOHqoRpWYJK2jysFBzCM0AugY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MzkPzC/V9icUPyqtNTVo2NcGiI4XiCHiI73DmrSR/HEqVlU/Fl+ZMfB3UxoSC/l+M
         Q3j21Qs7GmEaswumMO6lbsSSYUKgliMlgnL07FSpta/wHiRMsaJ+9wCukkhMuX7e2c
         dATG59SwQ8q1sBqu2yPk7uRrhGYThcqbONY6xB4JBl3RxmvR/vx0ergpV1n2zcNZo7
         UCBwPL0ecAzCIQbq8Vad1WWe39J0B4R0ZBrmNBV0YC6eIl70XD4X2wduteYeFW1oob
         ma+HHvIm19Z1jwxSm4XCSGoVmY5UKV/pbbikug8tvVFH0RJXrYrL5QHQhoipM5WWOH
         pEkH08tA0fHKg==
Date:   Wed, 14 Jun 2023 09:10:58 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: do not issue small discard commands during
 checkpoint
Message-ID: <ZInmkgjDnAUD5Nk0@google.com>
References: <20230613203947.2745943-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613203947.2745943-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

 Change log from v1:
  - move the skip logic to avoid dangling objects

 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8c7af8b4fc47..0457d620011f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2193,7 +2193,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 			len = next_pos - cur_pos;
 
 			if (f2fs_sb_has_blkzoned(sbi) ||
-			    (force && len < cpc->trim_minlen))
+					!force || len < cpc->trim_minlen)
 				goto skip;
 
 			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
-- 
2.41.0.162.gfafddb0af9-goog

