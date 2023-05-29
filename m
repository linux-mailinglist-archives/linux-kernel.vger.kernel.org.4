Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE4714D15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjE2Pda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE2Pd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:33:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411D29C;
        Mon, 29 May 2023 08:33:26 -0700 (PDT)
Date:   Mon, 29 May 2023 15:33:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685374403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IVExDsKMOfQgMfJYMFd84Zl750/nZDXDFa/lLIGwQYw=;
        b=Sl7uwjaIV0D/Dc0EbqsrHfanFriAqQARVDi2FNG6jwy1RosR5RfvXGJKzFMwyuH/9VRnSJ
        0/douHIs9KnGNOjJ6nDW2eG3GJ1Qu3qovUBb4/M8cC4nrXB6BSWH2q+bLQJJ00KKmsYhMo
        rD6s3SbZWjnYSzIWr+bk7LOobR3l7gmhcXBxoi/hbUhDybKwUgC/Pv18gzLPyO1ylmEVwe
        stT5W3Sv89WxZuZF6ut8k0PykBATojSBY8nXtJ9hWiD7WjlylN/LYkKPMejc+bhQxg6VYB
        icUnvxs5YZXogIcsOU7jiGCIIPP46cPFZKLoWO/hxaTALTyL1bvBs43LcaKKmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685374403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IVExDsKMOfQgMfJYMFd84Zl750/nZDXDFa/lLIGwQYw=;
        b=SHjjbwtDOW+vtTBTgNDsBUpe0mrQ5afnbhWCCjMZV/qz8k2BdzCUzG7lrWutdDifjhnc3b
        084RPg4mafS02gCA==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/csum: Fix clang -Wuninitialized in csum_partial()
Cc:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168537440297.404.2900420539886506252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     2fe1e67e6987b6f05329740da79c8150a2205b0d
Gitweb:        https://git.kernel.org/tip/2fe1e67e6987b6f05329740da79c8150a2205b0d
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 26 May 2023 08:47:40 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 29 May 2023 06:52:32 -07:00

x86/csum: Fix clang -Wuninitialized in csum_partial()

Clang warns:

  arch/x86/lib/csum-partial_64.c:74:20: error: variable 'result' is uninitialized when used here [-Werror,-Wuninitialized]
                  return csum_tail(result, temp64, odd);
                                   ^~~~~~
  arch/x86/lib/csum-partial_64.c:48:22: note: initialize the variable 'result' to silence this warning
          unsigned odd, result;
                              ^
                               = 0
  1 error generated.

The only initialization and uses of result in csum_partial() were moved
into csum_tail() but result is still being passed by value to
csum_tail() (clang's -Wuninitialized does not do interprocedural
analysis to realize that result is always assigned in csum_tail()
however). Sink the declaration of result into csum_tail() to clear up
the warning.

Closes: https://lore.kernel.org/202305262039.3HUYjWJk-lkp@intel.com/
Fixes: 688eb8191b47 ("x86/csum: Improve performance of `csum_partial`")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230526-csum_partial-wuninitialized-v1-1-ebc0108dcec1%40kernel.org
---
 arch/x86/lib/csum-partial_64.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index fe58619..cea25ca 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -21,8 +21,10 @@ static inline unsigned short from32to16(unsigned a)
 	return b;
 }
 
-static inline __wsum csum_tail(unsigned int result, u64 temp64, int odd)
+static inline __wsum csum_tail(u64 temp64, int odd)
 {
+	unsigned int result;
+
 	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
 	if (unlikely(odd)) {
 		result = from32to16(result);
@@ -45,7 +47,7 @@ static inline __wsum csum_tail(unsigned int result, u64 temp64, int odd)
 __wsum csum_partial(const void *buff, int len, __wsum sum)
 {
 	u64 temp64 = (__force u64)sum;
-	unsigned odd, result;
+	unsigned odd;
 
 	odd = 1 & (unsigned long) buff;
 	if (unlikely(odd)) {
@@ -71,7 +73,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    "adcq $0,%[res]"
 		    : [res] "+r"(temp64)
 		    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
-		return csum_tail(result, temp64, odd);
+		return csum_tail(temp64, odd);
 	}
 	if (unlikely(len >= 64)) {
 		/*
@@ -141,7 +143,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    : [res] "+r"(temp64)
 		    : [trail] "r"(trail));
 	}
-	return csum_tail(result, temp64, odd);
+	return csum_tail(temp64, odd);
 }
 EXPORT_SYMBOL(csum_partial);
 
