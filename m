Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1ED5EAF6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiIZSRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiIZSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:16:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB839F18A;
        Mon, 26 Sep 2022 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ta2fqcORnTPhm6SqYBRMkwwfMiYClGmt06JcabgqfpQ=; b=UpWOL/SaSMuiNnVO3YXv9vgiwU
        QEZCudfajDBURy71rTA2XbtSEKCmGMx783wOqvc1ASC8/hdHv0TZI4uVCkP7oJhgHxpXxgpPa6+13
        j0LebLryLy8t7VlKmkPKi47xFSzpQOuhIeVUzNWBMwRjOr88nOuVLzRSua/nz8WZY8JfiLlh983de
        TEr95we4+wkK8tMKUGmtKlCR1BF4XS+MxCimif8AYhPDaLvePCcGTl1Yb5Wp/IbhiT7mUdfrhUjky
        RbA/b5V6s+kpGsnTX8jZ7MA8srLjzJCY0M6rG/qAPysoNyjAFuPTW46W2UZ3delHOVqcqM+izQyDM
        rgCDAklw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocsVH-00Aigs-UN; Mon, 26 Sep 2022 18:06:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98A2430007E;
        Mon, 26 Sep 2022 20:06:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 742262B6B2F7B; Mon, 26 Sep 2022 20:06:46 +0200 (CEST)
Date:   Mon, 26 Sep 2022 20:06:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     bigeasy@linutronix.de, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        oleg@redhat.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        tj@kernel.org, vincent.guittot@linaro.org, will@kernel.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Amit Shah <amit@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YzHqNiRj2Q5vxdCV@hirez.programming.kicks-ass.net>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
 <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
 <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
 <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
 <9ec643f3-b935-0119-d8bc-1fbe46c36356@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ec643f3-b935-0119-d8bc-1fbe46c36356@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 05:49:16PM +0200, Christian Borntraeger wrote:

> Hmm,
> 
> #define ___wait_is_interruptible(state)                                         \
>         (!__builtin_constant_p(state) ||                                        \
>                 state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)          \
> 
> That would not trigger when state is also TASK_FREEZABLE, no?

Spot on!

signal_pending_state() writes that as:

	state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)

which is the correct form.

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 14ad8a0e9fac..7f5a51aae0a7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -281,7 +281,7 @@ static inline void wake_up_pollfree(struct wait_queue_head *wq_head)
 
 #define ___wait_is_interruptible(state)						\
 	(!__builtin_constant_p(state) ||					\
-		state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)		\
+	 (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
 
 extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 

Let me go git-grep some to see if there's more similar fail.
