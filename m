Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091B168C14C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBFP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBFP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:28:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D229435
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675697245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqMfOhk7UAJ+GKZmfZfNn5Y3A7f9OlfCIqc7mKeMN8g=;
        b=RYxXboJCIBl8XrxoKf4CRfIghWwQuixdFKcHjF1aTMSJvFW0E6eqR1i610KJ6ezt9utHSO
        /9oFarU/T9o+yngZfrponnS8JaczpqDsacIhGGPZejuqe8LPQTsXVdzO+/buzkr+t8+SFf
        jtasxCQ01OwjGAtQmMT4zKY1w2js14o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-xydvujg6NgKtohr-kgCJJA-1; Mon, 06 Feb 2023 10:27:21 -0500
X-MC-Unique: xydvujg6NgKtohr-kgCJJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61095805595;
        Mon,  6 Feb 2023 15:27:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-30.brq.redhat.com [10.40.194.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 48EC61121318;
        Mon,  6 Feb 2023 15:27:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  6 Feb 2023 16:27:16 +0100 (CET)
Date:   Mon, 6 Feb 2023 16:27:12 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v4] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <20230206152712.GA1487@redhat.com>
References: <20230206130449.41360-1-wander@redhat.com>
 <Y+EVNz4ORkFSvTfP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+EVNz4ORkFSvTfP@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06, Sebastian Andrzej Siewior wrote:
>
> On 2023-02-06 10:04:47 [-0300], Wander Lairson Costa wrote:
>
> > @@ -857,6 +857,29 @@ void __put_task_struct(struct task_struct *tsk)
> …
> > +void __put_task_struct(struct task_struct *tsk)
> > +{
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))
>
> Is it safe to use the rcu member in any case?

I thinks it is safe but deserves a comment. I guess Wander misunderstood
me when I asked him to do this...

__put_task_struct() is called when refcount_dec_and_test(&t->usage) succeeds.

This means that it can't "conflict" with put_task_struct_rcu_user() which
abuses ->rcu the same way; rcu_users has a reference so task->usage can't
be zero after rcu_users 1 -> 0 transition.

> If so why not use it
> unconditionally?

performance ?


And... I still don't like the name of delayed_put_task_struct_rcu() to me
___put_task_struct_rcu() looks a bit less confusing, note that we already
have delayed_put_task_struct(). But this is minor.

Oleg.

