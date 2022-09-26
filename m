Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03B85EA895
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiIZOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiIZOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:36:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C2164EA;
        Mon, 26 Sep 2022 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9e5ZsFmEwqFgQJJWTznPDZKlyACAw4+tFf2Fsk0YUI4=; b=MyO0V+ZRwmf429N2b3uG/HRVUh
        FT5vAkpKajidvb0yBrBvav/7E/0A20CN8bVWgICAaTqQtNX3M8w2++EEM1w+AV8V4KZpD3u5LETB8
        wHHldUhL/DnmDs4jn8B64LZwWM8EnRZ2ehf6HeYgcZhMCeqAyRkJrUekYf6IMyC4SWSYA3xaQo3BS
        Flvo4KDvCNoigiGhtR7SgmyP+Enhx5IsagftIHKfY3Faeb5y4Ip31VVGCFZGq1FHanbOtjXgodBFY
        Cv+ChVWrwug/70b3LpgCiWq8NzRA3G3iiy85a7UTGOKTvgDNf0AajL0tFUixgqu9L0sPdfwSJZcYx
        QIfupF4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocneF-00G1fp-8A; Mon, 26 Sep 2022 12:55:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 306A7300A72;
        Mon, 26 Sep 2022 14:55:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11B5D201E09E7; Mon, 26 Sep 2022 14:55:46 +0200 (CEST)
Date:   Mon, 26 Sep 2022 14:55:45 +0200
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
Message-ID: <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:32:24PM +0200, Christian Borntraeger wrote:
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 9fa3c76a267f..e93df4f735fe 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -790,7 +790,7 @@ static int wait_port_writable(struct port *port, bool nonblock)
>                 if (nonblock)
>                         return -EAGAIN;
> -               ret = wait_event_freezable(port->waitqueue,
> +               ret = wait_event_interruptible(port->waitqueue,
>                                            !will_write_block(port));
>                 if (ret < 0)
>                         return ret;
> 
> Does fix the problem.

It's almost as if someone does try_to_wake_up(.state = TASK_FREEZABLE)
-- which would be quite insane.

Could you please test with something like the below on? I can boot that
with KVM, but obviously I didn't suffer any weirdness to begin with :/

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4e6a6417211f..ef9ccfc3a8c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4051,6 +4051,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	unsigned long flags;
 	int cpu, success = 0;
 
+	WARN_ON_ONCE(state & TASK_FREEZABLE);
+
 	preempt_disable();
 	if (p == current) {
 		/*
