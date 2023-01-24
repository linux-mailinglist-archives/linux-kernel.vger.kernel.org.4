Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00539679C08
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjAXOf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjAXOf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:35:57 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5BC5B84
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:35:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P1TpJ1bNkz9xqdF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:27:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
        by APP2 (Coremail) with SMTP id GxC2BwD3xl2n7M9jRCHBAA--.13278S2;
        Tue, 24 Jan 2023 15:35:30 +0100 (CET)
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To:     paulmck@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH] tools/memory-model Flag suspicious use of srcu cookies
Date:   Tue, 24 Jan 2023 15:39:51 +0100
Message-Id: <20230124143951.23372-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GxC2BwD3xl2n7M9jRCHBAA--.13278S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZry3CrWDAFykWrWrury3urg_yoW5Aw1kpr
        W8ta4rKw4DtFyfuwn2g347uFyrXas7XrZFyrn3Ja48Z3W5ZrnrCryxKas0qw43tF17ta18
        ZryYqFsFy3WkJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF0
        eHDUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The herd model of LKMM deviates from actual implementations in the
range of cookies that might be returned by srcu_lock() and similar
functions.  As a consequence, code that relies on srcu_lock()
returning specific values might pass on the herd model but fail in
the real world.

This patch flags any code that looks at the value of a cookie
without passing it on to an srcu_unlock().  This indicates that the
cookie value might be being used in ways that can lead herd to
produce incorrect results, as in the following (contrived) case:

P0(struct srcu_struct *ss)
{
	int r = srcu_read_lock(ss);
	if (r==0)
		srcu_read_unlock(ss, r);
}

Without this patch, the code passes herd7 without any warnings.

With this patch, this code is flagged with illegal-srcu-cookie-ctrl,
indicating that a cookie is used to compute a control condition.
Such scenarios potentially lead to other branches of the code that
are possible in real usage not being evaluated by herd7.  In this
example, this affects the branch where r!=0, which would lead to
an unmatched read side critical section and thus to hangs of
synchronize_srcu() calls.

Besides use of cookies in control conditions, the patch also flags
use in address computation and any time a cookie is inspected but
not later passed to srcu_read_unlock().

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 tools/memory-model/linux-kernel.bell | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 6e702cda15e1..db5993acc241 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -58,7 +58,8 @@ flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-unlock
 
 (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
 let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
-let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
+let pass-cookie = carry-srcu-data ; data
+let srcu-rscs = ([Srcu-lock] ; pass-cookie ; [Srcu-unlock]) & loc
 
 (* Validate nesting *)
 flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-lock
@@ -71,6 +72,15 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 (* Validate SRCU dynamic match *)
 flag ~empty different-values(srcu-rscs) as bad-srcu-value-match
 
+(*
+ * Check that srcu cookies are only used for passing to srcu_unlock()
+ * Note: this check is only approximate
+ *)
+flag ~empty [Srcu-lock] ; pass-cookie ; rf ;
+	[~ domain(pass-cookie ; [Srcu-unlock])] as suspicious-srcu-cookie-use
+flag ~empty [Srcu-lock] ; carry-srcu-data ; ctrl as illegal-srcu-cookie-ctrl
+flag ~empty [Srcu-lock] ; carry-srcu-data ; addr as illegal-srcu-cookie-addr
+
 (* Compute marked and plain memory accesses *)
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
-- 
2.17.1

