Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA0F6EE7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjDYSte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjDYStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111B14F43
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:09 -0700 (PDT)
Message-ID: <20230425183313.249063953@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Sx10pK8BcTlPxWuC2UdyTLoJxTd/hzNVWxOXwJTCI1U=;
        b=oVYfclpJ4lXKyc1Bv0jWCtlJnHFR794oSAq6ZcvZ6asVYXISjUvO0tN93BYtwSO12YAd21
        MiA5UkB41+BZuAcVdlwhCozJ6bxIb8u0daak4y8sWpeW++b+jPuLhnXj9Xb4IjzSLadoEI
        eXo3aZ+rMSBfX2vYolhSI2ddy6fTkjTiyl8Zp/rL/IBs4vWg2EgqF7hBomKS3iAc/SekNQ
        louWpCkTkZ7BFVTcBJAlCAttj+oMMxOd3MCoD+zZdAw/LRmUrQfE2CyJFXtjmsTYLXa2hj
        gYsPjfalmaSX9INSBITMwbcm9yqSXJMDcpkUprqvvL0cWJ8Y1Z1Kr5yxTDLIeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Sx10pK8BcTlPxWuC2UdyTLoJxTd/hzNVWxOXwJTCI1U=;
        b=fJxM40v2se4bAIg7K9hcBCTFrE3LoyTK2ertCWxBDpVMTKPMPr3GAupe6nWQ1401iGOGSE
        87AUOcaZkmXy4WDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 08/20] posix-timers: Remove pointless irqsafe from hash_lock
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:08 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All usage of hash_lock is in thread context. No point in using
spin_lock_irqsave()/irqrestore() for a single usage site.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -470,10 +470,9 @@ static void k_itimer_rcu_free(struct rcu
 static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 {
 	if (it_id_set) {
-		unsigned long flags;
-		spin_lock_irqsave(&hash_lock, flags);
+		spin_lock(&hash_lock, flags);
 		hlist_del_rcu(&tmr->t_hash);
-		spin_unlock_irqrestore(&hash_lock, flags);
+		spin_unlock(&hash_lock, flags);
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);

