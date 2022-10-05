Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563C55F4CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 02:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJEANu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 20:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJEANl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 20:13:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B63CBCD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:13:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u16-20020a250950000000b006be72659056so444250ybm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date;
        bh=ALlsjTVmbFyHzlceNb3zXq0xbc4i58mJkMbiPt8Nklg=;
        b=WXsW31CKjwyBzaVilJ2DnAeTlCI+vDf2ypDdUDNBvs+jgXLQStreLyIFlIIELEsBrU
         OdNeDpnaugvcltOyqkbpjbDhXBw53GM6T8XjSsmSl/4WxTRZ2CXiCwaxFOIN0J2COD0o
         7fofUJcp/f/ibUvXMs75ijky51J70fLUynG4a1zHNPtZ3gw6FswYvHiZRxxRXZc9RuZd
         UVW7GS/uFKH5FeUWZDzk3olBA6kAkR70QLY3UMXJcyiJnsPUDjHy0bg7VdKwQU6sS7PY
         1Lb5+FSv/X3GW9r7HwNI2BIWoWRIVs3ILHNxFpAxCxa5XySSR2xaS1wY9fDLz58qdUkF
         ZCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ALlsjTVmbFyHzlceNb3zXq0xbc4i58mJkMbiPt8Nklg=;
        b=3fXn0CMG4Mdwe4GJyE3h9HLxmbIcCOepUdv7fIh8JWjnAfyPuI9MKdIv3SvHspslJY
         r3z5+9OEHPmJQtmAdlUVfgPCUzvbK0OWh+davbBlYrBU8TZ388gz3lICpfVoofH6zytV
         Z5dOSTHBYuX8EVaFj5PseAKkhy4YY8rLrBTvjH/NtdlKxPesDyhRvQtZKpmYL088zvDG
         maZSJlB1VUSqf3KDQ0NdX5Uvd0OwJD0C4DN3THsgizqbzmboyRkZJlaJjq4w9oabMjFe
         UxnEuQhpR9jwbn88BRg7WeyWSqaLgFkXTbB0sXlGuwI4AOCfZPiUS0QzPojNST3eN7Mo
         nl9g==
X-Gm-Message-State: ACrzQf01PrjitCUkzVTn950Y6apNNAeB/0R0jjK2BxyL5joA1/MbVHxV
        OQKPT280fy9RnKgzybDJqgqB3la/CUE=
X-Google-Smtp-Source: AMsMyM52vg4YK8/fSwfK04NxkWNQzncvTu04WP5OlBYW1o0xmWzW9ukoUY3J3XNF6KUOVJ0nwa7BTRCu+Ho=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:d76c:54ee:23e5:ee12])
 (user=yuzhao job=sendgmr) by 2002:a25:790d:0:b0:670:6032:b1df with SMTP id
 u13-20020a25790d000000b006706032b1dfmr27235358ybc.629.1664928813418; Tue, 04
 Oct 2022 17:13:33 -0700 (PDT)
Date:   Tue,  4 Oct 2022 18:13:26 -0600
Message-Id: <20221005001326.157644-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH] fscrypt: fix lockdep warning
From:   Yu Zhao <yuzhao@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fscrypt_initialize() shouldn't allocate memory without GFP_NOFS.

The problem seems to go back to 2015
commit 57e5055b0a5e ("f2fs crypto: add f2fs encryption facilities")
but I have never heard of any complaints, hence not CC'ing stable.

  ======================================================
  WARNING: possible circular locking dependency detected
  6.0.0-lockdep #1 Not tainted
  ------------------------------------------------------
  kswapd0/77 is trying to acquire lock:
  71ffff808b254a18 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x76c/0x8dc

  but task is already holding lock:
  ffffffea26533310 (fs_reclaim){+.+.}-{0:0}, at: 0x1

  which lock already depends on the new lock.

  <snipped>

  other info that might help us debug this:

  Chain exists of:
    jbd2_handle --> fscrypt_init_mutex --> fs_reclaim

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(fs_reclaim);
                                 lock(fscrypt_init_mutex);
                                 lock(fs_reclaim);
    lock(jbd2_handle);

   *** DEADLOCK ***

  3 locks held by kswapd0/77:
   #0: ffffffea26533310 (fs_reclaim){+.+.}-{0:0}, at: 0x1
   #1: ffffffea26529220 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x54/0x464
   #2: 6dffff808abe90e8 (&type->s_umount_key#47){++++}-{3:3}, at: trylock_super+0x2c/0x8c

  <snipped>

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 fs/crypto/crypto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index e78be66bbf01..e10fc30142a6 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -316,6 +316,7 @@ EXPORT_SYMBOL(fscrypt_decrypt_block_inplace);
 int fscrypt_initialize(unsigned int cop_flags)
 {
 	int err = 0;
+	unsigned int flags;
 
 	/* No need to allocate a bounce page pool if this FS won't use it. */
 	if (cop_flags & FS_CFLG_OWN_PAGES)
@@ -326,8 +327,10 @@ int fscrypt_initialize(unsigned int cop_flags)
 		goto out_unlock;
 
 	err = -ENOMEM;
+	flags = memalloc_nofs_save();
 	fscrypt_bounce_page_pool =
 		mempool_create_page_pool(num_prealloc_crypto_pages, 0);
+	memalloc_nofs_restore(flags);
 	if (!fscrypt_bounce_page_pool)
 		goto out_unlock;
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

