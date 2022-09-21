Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464875D1C97
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiIUSG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIUSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:06:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571EA75FD1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:06:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t3so6459131ply.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZmaPuLYMyXSi8pa5Ffg0dP+gxXhcRRdC4OxDDiOEqxU=;
        b=emEHyGSl8xe1q4RrCrKnlY483K5aKI0sJAS0tSGI/UgwioPCr9LfjZh7J9OZBZbW2U
         Vws8kEDLJijRGrH7L+XHt5bz1jLXL+dTkkZnqo7ovP9Ly67LpYxC2Q6xZSu4KxVobglL
         bvjLiSDYoN0AoayOKElGD8KE2ih7/Oimqa5Fto751WE4qn6YsN+bDSun0nSm16Y3PTKr
         W5SgVVHyWwAVyNqiO2FOBa8sfyvwIKrV0TSVgQxuTZHVEEMmQmALECGnHtMGjoyg7NtU
         8xGH2OQsRobG+/65KpmLzouA5r2jAW8FK+WsCAr4bzoUpsHXk0mBZKscXxt1BiaSceK5
         j2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZmaPuLYMyXSi8pa5Ffg0dP+gxXhcRRdC4OxDDiOEqxU=;
        b=6Ii3FkldwrvO/17pCc1ci30Y3l9PruJporDEkW2jf1fN331VoN+3FhRP9aZukem1Rc
         2I+MKrFb1jYmUgDdGMc+XU3C/90JI+YA5CE88FWzvS/skKF3na9hqCgWD+IvsQ6c+kc+
         Q7Pxw6sG2gZ6l4YyhsR2forKzV5BCkSYmpun1wyWPIv3PC2Q7IQkkF6xymygbOqt8HjV
         D2IjfzKCDkmtoRMFimkUKfarDLWZ4LHHqI3Mcg0newynA3dVBHYKo9eNTO/jmvAz8aTW
         cLmO+gZXJjFgSNO/09Dzsj3BZLon/evLj+4vviTQH7UIGK7C2k0NNRRSR1ECXyk5gM+m
         wfhA==
X-Gm-Message-State: ACrzQf3Nd2RXmWnf7vU85Jzq+y04DbK+Vpepu9JEFv40LegsOWsU9N/c
        5jDOmy6fhe2FphlFosoptJg=
X-Google-Smtp-Source: AMsMyM52E6XNCFF5LEzyB6B5IdKLaN1AaWgmRDZcngIhgE2/fS0qlfz6Nwlp48bH07/de2uqk9oHJw==
X-Received: by 2002:a17:902:f612:b0:178:a692:b20a with SMTP id n18-20020a170902f61200b00178a692b20amr6009585plg.55.1663783613509;
        Wed, 21 Sep 2022 11:06:53 -0700 (PDT)
Received: from sc2-hs2-b1628.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i64-20020a62c143000000b0053617cbe2d2sm2442590pfg.168.2022.09.21.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:06:53 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>, stable@kernel.org
Subject: [PATCH v2] x86/alternative: Fix race in try_get_desc()
Date:   Wed, 21 Sep 2022 18:09:32 +0000
Message-Id: <20220921180932.30401-1-namit@vmware.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The text poke mechanism claims to have an RCU-like behavior, but it does
not appear that there is any quiescent state to ensure that nobody holds
reference to desc. As a result, the following race appears to be
possible, which can lead to memory corruption.

  CPU0					CPU1
  ----					----
  text_poke_bp_batch()
  -> smp_store_release(&bp_desc, &desc)

  [ notice that desc is on
    the stack			]

					poke_int3_handler()

					[ int3 might be kprobe's
					  so sync events are do not
					  help ]

					-> try_get_desc(descp=&bp_desc)
					   desc = __READ_ONCE(bp_desc)

					   if (!desc) [false, success]
  WRITE_ONCE(bp_desc, NULL);
  atomic_dec_and_test(&desc.refs)

  [ success, desc space on the stack
    is being reused and might have
    non-zero value. ]
					arch_atomic_inc_not_zero(&desc->refs)

					[ might succeed since desc points to
					  stack memory that was freed and might
					  be reused. ]

I encountered some occasional crashes of poke_int3_handler() when
kprobes are set, while accessing desc->vec. The analysis has been done
offline and I did not corroborate the cause of the crashes. Yet, it
seems that this race might be the root cause.

Fix this issue with small backportable patch. Instead of trying to make
RCU-like behavior for bp_desc, just eliminate the unnecessary level of
indirection of bp_desc, and hold the whole descriptor as a global.
Anyhow, there is only a single descriptor at any given moment.

Fixes: 1f676247f36a4 ("x86/alternatives: Implement a better poke_int3_handler() completion scheme")
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
Link: https://lkml.kernel.org/r/20220920224743.3089-1-namit@vmware.com
---
 arch/x86/kernel/alternative.c | 45 ++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 62f6b8b7c4a5..4f3204364caa 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1319,22 +1319,23 @@ struct bp_patching_desc {
 	atomic_t refs;
 };
 
-static struct bp_patching_desc *bp_desc;
+static struct bp_patching_desc bp_desc;
 
 static __always_inline
-struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
+struct bp_patching_desc *try_get_desc(void)
 {
-	/* rcu_dereference */
-	struct bp_patching_desc *desc = __READ_ONCE(*descp);
+	struct bp_patching_desc *desc = &bp_desc;
 
-	if (!desc || !arch_atomic_inc_not_zero(&desc->refs))
+	if (!arch_atomic_inc_not_zero(&desc->refs))
 		return NULL;
 
 	return desc;
 }
 
-static __always_inline void put_desc(struct bp_patching_desc *desc)
+static __always_inline void put_desc(void)
 {
+	struct bp_patching_desc *desc = &bp_desc;
+
 	smp_mb__before_atomic();
 	arch_atomic_dec(&desc->refs);
 }
@@ -1367,15 +1368,15 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
-	 * bp_desc:
+	 * bp_desc with non-zero refcount:
 	 *
-	 *	bp_desc = desc			INT3
+	 *	bp_desc.refs = 1		INT3
 	 *	WMB				RMB
-	 *	write INT3			if (desc)
+	 *	write INT3			if (bp_desc.refs != 0)
 	 */
 	smp_rmb();
 
-	desc = try_get_desc(&bp_desc);
+	desc = try_get_desc();
 	if (!desc)
 		return 0;
 
@@ -1429,7 +1430,7 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 	ret = 1;
 
 out_put:
-	put_desc(desc);
+	put_desc();
 	return ret;
 }
 
@@ -1460,18 +1461,20 @@ static int tp_vec_nr;
  */
 static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
-	struct bp_patching_desc desc = {
-		.vec = tp,
-		.nr_entries = nr_entries,
-		.refs = ATOMIC_INIT(1),
-	};
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
 	int do_sync;
 
 	lockdep_assert_held(&text_mutex);
 
-	smp_store_release(&bp_desc, &desc); /* rcu_assign_pointer */
+	bp_desc.vec = tp;
+	bp_desc.nr_entries = nr_entries;
+
+	/*
+	 * Corresponds to the implicit memory barrier in try_get_desc() to
+	 * ensure reading a non-zero refcount provides up to date bp_desc data.
+	 */
+	atomic_set_release(&bp_desc.refs, 1);
 
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
@@ -1559,12 +1562,10 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		text_poke_sync();
 
 	/*
-	 * Remove and synchronize_rcu(), except we have a very primitive
-	 * refcount based completion.
+	 * Remove and wait for refs to be zero.
 	 */
-	WRITE_ONCE(bp_desc, NULL); /* RCU_INIT_POINTER */
-	if (!atomic_dec_and_test(&desc.refs))
-		atomic_cond_read_acquire(&desc.refs, !VAL);
+	if (!atomic_dec_and_test(&bp_desc.refs))
+		atomic_cond_read_acquire(&bp_desc.refs, !VAL);
 }
 
 static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
-- 
2.34.1

