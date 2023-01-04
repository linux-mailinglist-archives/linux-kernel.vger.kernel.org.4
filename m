Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED75965DCA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjADTVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjADTVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:21:06 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C23B24F;
        Wed,  4 Jan 2023 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1672860060;
        bh=EkluNBVpVWqQAv87WSQmghkcqC2q2Qy6C1sH75HStM8=;
        h=From:To:Cc:Subject:Date:From;
        b=uHpzNIkexlMwMW6tcNulYBdFNfgt/LIfn/2hxHwEPbcvX0EY0xNxNtx4nytz3So3I
         eA4+dqiTbDQVdhd/5EhS+4kZS8AtpXJffodZopOxaRaFj3FT/oFc5P2rlQCU1x4/2G
         CT50Dnc7FAsOeq+2T4Rv7mvTMfa6ugO8kX0sGDfg8+ZPOr/94ClKDjO5WytRyNlZvE
         OyziHvhheM8LLwjdeAx0OoHWRa2guPOmWACMe6l0kzsOI8bzgmI8EdSmWnJ8pGjEa3
         OISba1sr4BVI6b4KNdf+TWbjKplAKoJIySKWR+KSJonxNseLadt0ct+/Wc+NVEgfZo
         eg5JQL5oa8ZMQ==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NnKFm4PWhzf6q;
        Wed,  4 Jan 2023 14:21:00 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [RFC PATCH tip] rseq: Fix: Increase AT_VECTOR_SIZE_BASE to match rseq auxvec entries
Date:   Wed,  4 Jan 2023 14:20:54 -0500
Message-Id: <20230104192054.34046-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new auxiliary vector entries are introduced for rseq without
matching increment of the AT_VECTOR_SIZE_BASE, which causes failures
with CONFIG_HARDENED_USERCOPY=y.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/Y7XJKZhuU9VJZQ11@dev-arch.thelio-3990X
Fixes: 317c8194e6ae ("rseq: Introduce feature size and alignment ELF auxiliary vector entries")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/auxvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index f68d0ec2d740..407f7005e6d6 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -4,6 +4,6 @@
 
 #include <uapi/linux/auxvec.h>
 
-#define AT_VECTOR_SIZE_BASE 20 /* NEW_AUX_ENT entries in auxiliary table */
+#define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
 #endif /* _LINUX_AUXVEC_H */
-- 
2.25.1

