Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05D57450C4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjGBTmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGBTlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A201BC2;
        Sun,  2 Jul 2023 12:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D58F360D14;
        Sun,  2 Jul 2023 19:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC09C433CD;
        Sun,  2 Jul 2023 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326862;
        bh=BtzzT0gShwKKESD0YSJ8pzWY9b6wD08QiLIgCKxIGVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTFeO5YDb2xGZMHzbWqEMV7PTtMSKMKa50ivrMDIrlMTLAYBYJiMJ5p5q8qUM1z9y
         LtNvjT9Vf3Y7dNG2mbQtozdLJex5S+cbJQjyI6gXwhK12WfiXwiB8CSEY5JCBdF8gA
         wJ7afTu92b5k9Z1VNSAMVceRJOlrDtt8qbvJCdAKEWuM/O42580W51JefCKRgVcb3S
         LOs1V34R/hgSWVaisHzi/pfHnXjiZCOBDDdFvu8va/gzzLeQfVPaapiNQDSNW88Dwz
         0bl6byDmaYybM1DAOuXmYJTRoAiH8hfa5qfr4d4IWt4ibqDZ+fIKYVIcQU4Z2DQnhh
         UIJq8cWZjkAtA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.3 04/14] debugobjects: Recheck debug_objects_enabled before reporting
Date:   Sun,  2 Jul 2023 15:40:43 -0400
Message-Id: <20230702194053.1777356-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194053.1777356-1-sashal@kernel.org>
References: <20230702194053.1777356-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
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

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 8b64d420fe2450f82848178506d3e3a0bd195539 ]

syzbot is reporting false a positive ODEBUG message immediately after
ODEBUG was disabled due to OOM.

  [ 1062.309646][T22911] ODEBUG: Out of memory. ODEBUG disabled
  [ 1062.886755][ T5171] ------------[ cut here ]------------
  [ 1062.892770][ T5171] ODEBUG: assert_init not available (active state 0) object: ffffc900056afb20 object type: timer_list hint: process_timeout+0x0/0x40

  CPU 0 [ T5171]                CPU 1 [T22911]
  --------------                --------------
  debug_object_assert_init() {
    if (!debug_objects_enabled)
      return;
    db = get_bucket(addr);
                                lookup_object_or_alloc() {
                                  debug_objects_enabled = 0;
                                  return NULL;
                                }
                                debug_objects_oom() {
                                  pr_warn("Out of memory. ODEBUG disabled\n");
                                  // all buckets get emptied here, and
                                }
    lookup_object_or_alloc(addr, db, descr, false, true) {
      // this bucket is already empty.
      return ERR_PTR(-ENOENT);
    }
    // Emits false positive warning.
    debug_print_object(&o, "assert_init");
  }

Recheck debug_object_enabled in debug_print_object() to avoid that.

Reported-by: syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/492fe2ae-5141-d548-ebd5-62f5fe2e57f7@I-love.SAKURA.ne.jp
Closes: https://syzkaller.appspot.com/bug?extid=7937ba6a50bdd00fffdf
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 986adca357b4b..c0a880f8d6715 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -498,6 +498,15 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 	const struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
+	/*
+	 * Don't report if lookup_object_or_alloc() by the current thread
+	 * failed because lookup_object_or_alloc()/debug_objects_oom() by a
+	 * concurrent thread turned off debug_objects_enabled and cleared
+	 * the hash buckets.
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	if (limit < 5 && descr != descr_test) {
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;
-- 
2.39.2

