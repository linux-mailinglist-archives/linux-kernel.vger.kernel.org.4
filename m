Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4A661F80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjAIH4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjAIHzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:55:37 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BF3F13D55
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:55:36 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3097soBf026019;
        Mon, 9 Jan 2023 08:54:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 5/6] tools/nolibc: prevent gcc from making memset() loop over itself
Date:   Mon,  9 Jan 2023 08:54:41 +0100
Message-Id: <20230109075442.25963-6-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109075442.25963-1-w@1wt.eu>
References: <20230109075442.25963-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building on ARM in thumb mode with gcc-11.3 at -O2 or -O3,
nolibc-test segfaults during the select() tests. It turns out that at
this level, gcc recognizes an opportunity for using memset() to zero
the fd_set, but it miscompiles it because it also recognizes a memset
pattern as well, and decides to call memset() from the memset() code:

  000122bc <memset>:
     122bc:       b510            push    {r4, lr}
     122be:       0004            movs    r4, r0
     122c0:       2a00            cmp     r2, #0
     122c2:       d003            beq.n   122cc <memset+0x10>
     122c4:       23ff            movs    r3, #255        ; 0xff
     122c6:       4019            ands    r1, r3
     122c8:       f7ff fff8       bl      122bc <memset>
     122cc:       0020            movs    r0, r4
     122ce:       bd10            pop     {r4, pc}

Simply placing an empty asm() statement inside the loop suffices to
avoid this.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 0932db3817d2..fffdaf6ff467 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -88,8 +88,11 @@ void *memset(void *dst, int b, size_t len)
 {
 	char *p = dst;
 
-	while (len--)
+	while (len--) {
+		/* prevent gcc from recognizing memset() here */
+		asm volatile("");
 		*(p++) = b;
+	}
 	return dst;
 }
 
-- 
2.35.3

