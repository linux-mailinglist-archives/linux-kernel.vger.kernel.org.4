Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA6A7335EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjFPQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjFPQYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:24:06 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8D11BD6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:24:04 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qACEz-00G6rY-Jj; Fri, 16 Jun 2023 17:24:01 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qACEz-0005wX-0k;
        Fri, 16 Jun 2023 17:24:01 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] pipe: remove CONFIG_WATCH_QUEUE for several protoypes
Date:   Fri, 16 Jun 2023 17:24:00 +0100
Message-Id: <20230616162400.22836-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several function protoypes in include/linux/pipe_fs_i.h which
are only declared for CONFIG_WATCH_QUEUE. However these seem to be used
even if this is not declared, and their implementations in fs/pipe.c are
not conditional on CONFIG_WATCH_QUEUE. Silence the following sparse warnings
by alwas defining these:

fs/pipe.c:759:15: warning: symbol 'account_pipe_buffers' was not declared. Should it be static?
fs/pipe.c:765:6: warning: symbol 'too_many_pipe_buffers_soft' was not declared. Should it be static?
fs/pipe.c:772:6: warning: symbol 'too_many_pipe_buffers_hard' was not declared. Should it be static?
fs/pipe.c:779:6: warning: symbol 'pipe_is_unprivileged_user' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 include/linux/pipe_fs_i.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index d2c3f16cf6b1..6a1e0b0fbcc3 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -261,13 +261,11 @@ void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
 
 extern const struct pipe_buf_operations nosteal_pipe_buf_ops;
 
-#ifdef CONFIG_WATCH_QUEUE
 unsigned long account_pipe_buffers(struct user_struct *user,
 				   unsigned long old, unsigned long new);
 bool too_many_pipe_buffers_soft(unsigned long user_bufs);
 bool too_many_pipe_buffers_hard(unsigned long user_bufs);
 bool pipe_is_unprivileged_user(void);
-#endif
 
 /* for F_SETPIPE_SZ and F_GETPIPE_SZ */
 #ifdef CONFIG_WATCH_QUEUE
-- 
2.39.2

