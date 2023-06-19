Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45518735613
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFSLqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFSLqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:46:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A7DA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/HhEuG3WD10cmV7zC5BZSkc1uXyPlJle62QUY05GBXw=; b=TZ8tWpWBQUdyITpxRFLYqMde5y
        17Lmf+E9yHM8IbAY/ij0PCR29waBoVWnc7k8BJ1wgJkXhqlhnmLKC3bL5WyMbIKVSKFijTUc1yZd2
        QFyKIHCG3jWk+k+R7qMHXm5A0ixVD5OB9Seu2B4gbSPUP8SSBwMD8siZYcUx2/9mIiTfKCABdQEiY
        TNRy0I2JWQ1f8PEI63pCvgZtM/f8A84p9iyWqsFpbhpgJJ1uEVP6kdg1ihvaB6IJ6gEpXL2xMA5Pz
        sz7NeHXQvuw0u+Xinc5bendR7L5YSvmY1wULViNs+oCCgFq/VZqEjd12UvrhLz81NC+H8hC16FmA+
        6HAb0Lkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBDKD-00Bo8M-P6; Mon, 19 Jun 2023 11:45:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC84E3001E7;
        Mon, 19 Jun 2023 13:45:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29484201B6401; Mon, 19 Jun 2023 13:07:00 +0200 (CEST)
Date:   Mon, 19 Jun 2023 13:07:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH v10 0/2] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <20230619110700.GM4253@hirez.programming.kicks-ass.net>
References: <20230614122323.37957-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614122323.37957-1-wander@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 09:23:20AM -0300, Wander Lairson Costa wrote:
> Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
> locks. Therefore, it can't be called from an non-preemptible context.
> 
> Instead of calling __put_task_struct() directly, we defer it using
> call_rcu(). A more natural approach would use a workqueue, but since
> in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
> the code would become more complex because we would need to put the
> work_struct instance in the task_struct and initialize it when we
> allocate a new task_struct.

> 
> Wander Lairson Costa (2):
>   kernel/fork: beware of __put_task_struct calling context
>   sched: avoid false lockdep splat in put_task_struct()

Thanks!
