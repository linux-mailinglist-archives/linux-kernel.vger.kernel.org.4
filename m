Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2AE68C335
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBFQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjBFQ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:28:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865EBBAE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675700891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKvPpE2CBuuZUCMj9SaC3BZ+r7n6t9mttNCgwIV4Ex4=;
        b=fEcRhX02a2elD2axokB75hEztu1SGUXPmiO/MthoXmpP8GxI0IF5X6yj+18ikIM7YVRw2Y
        eMr17LKOB1hhMUqDh2y9pQyeCoZ+A17R9IcGErsN+DbJShWtCR+1Ay6WF7DSw+rkMx3NQ7
        dHym9Y90J5GmnFlG/fIzEM5n32n87P8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-rc6AX9phN_We6q8leQ7g7g-1; Mon, 06 Feb 2023 11:28:06 -0500
X-MC-Unique: rc6AX9phN_We6q8leQ7g7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2448887406;
        Mon,  6 Feb 2023 16:28:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-30.brq.redhat.com [10.40.194.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 741D4440BC;
        Mon,  6 Feb 2023 16:28:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  6 Feb 2023 17:28:02 +0100 (CET)
Date:   Mon, 6 Feb 2023 17:27:58 +0100
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
Message-ID: <20230206162758.GB1487@redhat.com>
References: <20230206130449.41360-1-wander@redhat.com>
 <Y+EVNz4ORkFSvTfP@linutronix.de>
 <20230206152712.GA1487@redhat.com>
 <Y+Ek98n1xUhTP+8a@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Ek98n1xUhTP+8a@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
> On 2023-02-06 16:27:12 [+0100], Oleg Nesterov wrote:
>
> > > If so why not use it
> > > unconditionally?
> >
> > performance ?
>
> All the free() part is moved from the caller into rcu.

sorry, I don't understand,

>
> >
> > And... I still don't like the name of delayed_put_task_struct_rcu() to me
> > ___put_task_struct_rcu() looks a bit less confusing, note that we already
> > have delayed_put_task_struct(). But this is minor.
>
> So if we do it unconditionally then we could get rid of
> put_task_struct_rcu_user().

Yes. But the whole purpose of rcu_users is that we want to avoid the unconditional
rcu grace period before free_task() ?

Just in case... please note that delayed_put_task_struct() delays
refcount_sub(t->usage), not free_task().

Why do we need this? Consider

	rcu_read_lock();

	task = find-task-in-rcu-protected-list;

	// Safe, task->usage can't be zero
	get_task_struct(task);

	rcu_read_unlock();


> Otherwise we could use put_task_struct_rcu_user() in that timer
> callback because it will lead to lockdep warnings once printk is fixed.

IIUC there are more in-atomic callers of put_task_struct(). But perhaps
I misunderstood you...

Oleg.

