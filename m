Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9CA72D124
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbjFLUv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbjFLUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E170E296F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 220A162F35
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBCEC43328;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=/HEE7wLoU0aARylBa78hxj5pmV8p3SLHOC7ItTxKH/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tihZiaNXAFPQV8WTdLoz1e8HNDHvHyM/vmV+hRjqOcMSvSXozg1Dvc/PBJG3aQrNh
         EL7VCkgaO/qD379Ji2euUx5IyGyf6FcxXy9/zgmcly7JIKwsgyFs/o3tX2PtLDY6h/
         Z6D6Te0V3tPh4qYsJP3DPJp4OWWLbfYqVMTqLsH2xrwblhYckqtBPeydIafUqJdLcI
         +4ADVLzjaw1LoPuEBMTJLKKxN0LfMUyRcCELguDn3+RbqkLI16rkiFY37HTR3nunn8
         jHGVbXr/MDczb+1vXBoB0WA8K07MvowhhJfEwIxLRFIM4EB3tPJFX4Iri60T4JvEqL
         kGarpICXDGIzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0DE96CE3A84; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 39/53] tools/nolibc: ppoll/ppoll_time64: add a missing argument
Date:   Mon, 12 Jun 2023 13:45:00 -0700
Message-Id: <20230612204514.292087-39-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
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

From: Zhangjin Wu <falcon@tinylab.org>

The ppoll and ppoll_time64 syscalls have 5 arguments, but we only
provide 4, align with kernel and add the missing sigsetsize argument.

Because the sigmask is NULL, the last sigsetsize argument is ignored,
keep it as 0 here is safe enough.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 7836d7e7760d..0160605444e7 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -939,7 +939,7 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 		t.tv_sec  = timeout / 1000;
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
-	return my_syscall4(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL);
+	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
 #elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #else
-- 
2.40.1

