Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49BC61F51A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiKGOQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiKGOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F5E19C2A;
        Mon,  7 Nov 2022 06:16:42 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hsx1u5F/1CiKvy2GFTZ4ZBzQ1rYlt65AF3SRkTuxsig=;
        b=gGZzuKnOEmjKPxnbVv/2pWVKTnVFnDA6n6uJGrTaFNs5ZYKCtrOZcWBE0nUslYYBrhiBFC
        wWXzKY0XCcdwU49sdLis2tWo+CqiLw27jBnhr7tjmFvfKL1ktOzUawjgzEsiy43FowPSV+
        2R9HP522uAqxmgAD/Z92yUxYQeOtbus8a/JAigqgIL9U1loZ5DnW140SsJvb8Ab/i7cokn
        48tUsK+EubYJAZr2PCtGbTlP1T+9Z/al4ryuJnrvWsLq9PyqJYttnZWggUbaOgfsRQD3bQ
        FICdkdqh8pvtpKl3+PBEpjQJ6Ky3mRf3ya0jmwlyBd+Q6GZY4U1uV66yHgUUgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hsx1u5F/1CiKvy2GFTZ4ZBzQ1rYlt65AF3SRkTuxsig=;
        b=O0NGeysRpJ2rTQa3JNmWJZLtFDJUBBFvVlOpA/ai0W0bs6FRiXV/Cp6mDv/3mE65r7hslX
        eRRyPQGXENizajAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH printk v3 01/40] rcu: implement lockdep_rcu_enabled for !CONFIG_DEBUG_LOCK_ALLOC
Date:   Mon,  7 Nov 2022 15:21:59 +0106
Message-Id: <20221107141638.3790965-2-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an implementation for debug_lockdep_rcu_enabled() when
CONFIG_DEBUG_LOCK_ALLOC is not enabled. This allows code to check
if rcu lockdep debugging is available without needing an extra
check if CONFIG_DEBUG_LOCK_ALLOC is enabled.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 I also sent this patch to Paul as a suggestion. If it is not
 acceptable, I just need to add an ifdef CONFIG_DEBUG_LOCK_ALLOC
 into console_list_lock() of patch 21.

 include/linux/rcupdate.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 08605ce7379d..65178c40ab6f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -340,6 +340,11 @@ static inline int rcu_read_lock_any_held(void)
 	return !preemptible();
 }
 
+static inline int debug_lockdep_rcu_enabled(void)
+{
+	return 0;
+}
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 #ifdef CONFIG_PROVE_RCU
-- 
2.30.2

