Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F33D618959
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKCUGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKCUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:05:16 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53188205F2;
        Thu,  3 Nov 2022 13:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505904;
        bh=ghI6w5m/fBuPawbc/R5A+f4FNxklkEyjIEUh4Xg9S2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUfZiiUuutcK6KdatvmWhn8NGtZU2VkDD1lmteu03H71N+hiQ14a19T1sM2+NRdQl
         vsxPW2pf5z+7LfNYbI+42XEl58Sokm0z8oeAq+CEAqx41xeCYSBPVwRM8mL6bi3Xxn
         kNBiSe+Dd2A0fOl+mKepMVMjhE2alx5vYAHAXsY19WCTf1qAtBkVeKAmg0yY1szCth
         OiS091Bbw+YlZR02oFvKNRf9IgU0qmIbETFXs+DTyTjWRStLTqKz6cA2TiHzec+awQ
         tj9knfGeYfmgjNB5qxMCDvEyyyZ6A8DY1y4LkoONY+wKi3bi7609pHurYtwl8USGpY
         SwETJy9PhRz3g==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F9D0p0Tzg0D;
        Thu,  3 Nov 2022 16:05:04 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v5 23/24] selftests/rseq: parametrized test: Report/abort on negative cpu id
Date:   Thu,  3 Nov 2022 16:03:58 -0400
Message-Id: <20221103200359.328736-24-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report and abort when a negative cpu id value is observed by the
spinlock test.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/param_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index f3687a90ec0c..1c86b45bd579 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -410,6 +410,11 @@ static int rseq_this_cpu_lock(struct percpu_lock *lock)
 		int ret;
 
 		cpu = get_current_cpu_id();
+		if (cpu < 0) {
+			fprintf(stderr, "pid: %d: tid: %d, cpu: %d: Observing vcpu id %d\n",
+					getpid(), (int) rseq_gettid(), rseq_current_cpu_raw(), cpu);
+			abort();
+		}
 		ret = rseq_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
 					 &lock->c[cpu].v,
 					 0, 1, cpu);
-- 
2.25.1

