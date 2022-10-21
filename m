Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43D606FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJUGCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJUGCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:02:22 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CF6E2339AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:02:20 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29L625HW007419;
        Fri, 21 Oct 2022 08:02:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH] tools/nolibc/string: fix memcmp() implementation
Date:   Fri, 21 Oct 2022 08:01:53 +0200
Message-Id: <20221021060153.7378-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

The C standard says that memcmp() must treat the buffers as consisting
of "unsigned chars". If char happens to be unsigned, the casts are ok,
but then obviously the c1 variable can never contain a negative
value. And when char is signed, the casts are wrong, and there's still
a problem with using an 8-bit quantity to hold the difference, because
that can range from -255 to +255.

For example, assuming char is signed, comparing two 1-byte buffers,
one containing 0x00 and another 0x80, the current implementation would
return -128 for both memcmp(a, b, 1) and memcmp(b, a, 1), whereas one
of those should of course return something positive.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc")
Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Willy Tarreau <w@1wt.eu>
---

Paul,

please also include this patch to your series of fixes. I messed up
with memcmp() making it possibly return a wrong sign depending on the
distance between input bytes. It could for example affect a use case
where it would be used in the same way as with qsort() (even though
we do not implement qsort). I'm sending you separately a second patch
to include a selftest for this one; the selftest does not need to be
backported.

Thank you!
Willy

---

 tools/include/nolibc/string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index bef35bee9c44..cc1bddcb5927 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -19,9 +19,9 @@ static __attribute__((unused))
 int memcmp(const void *s1, const void *s2, size_t n)
 {
 	size_t ofs = 0;
-	char c1 = 0;
+	int c1 = 0;
 
-	while (ofs < n && !(c1 = ((char *)s1)[ofs] - ((char *)s2)[ofs])) {
+	while (ofs < n && !(c1 = ((unsigned char *)s1)[ofs] - ((unsigned char *)s2)[ofs])) {
 		ofs++;
 	}
 	return c1;
-- 
2.17.5

