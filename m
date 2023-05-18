Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EFC708ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjERVuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjERVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:50:13 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5016318D;
        Thu, 18 May 2023 14:50:12 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-61b58779b93so23265936d6.0;
        Thu, 18 May 2023 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684446611; x=1687038611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/OOEUuiCNBKdd9zMbn4KjwkaAOTRthUNUVRcur4ZwI=;
        b=iVPTGelyaQvulIYchtlqJtiru7b5+iJ4aroWFy1//Kn+Ytac0/PVYN9smOvMdih5h5
         kH0Qx4EIHgLF5JMBn1HBq7BfIL/pHbisWL2opvSN/x9rfwqPUa1xP8pneO53Gp8iDbrX
         VwB8eAD/s1P/wMAZgrNi9I0MJ+oB8x1wgjzgWrf3eWbpy7tB+xxpCES3cY5th7Hbiktt
         h4NAK9DrQiGwsmgqdLt0DeODZg9COfGFUSPsd720evv/kOv/V+9OuSvxxIIPol/rQf6r
         +KQBVXxoXDiH5U0LXVeaPdt1QszHU5M2nuQO6m/cRZ9idvCuG42D5ywogWRk36flmbyK
         vwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684446611; x=1687038611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/OOEUuiCNBKdd9zMbn4KjwkaAOTRthUNUVRcur4ZwI=;
        b=O0xNOtPMGylkedgrewnq5O0ZDf4Pah1CCIBOYzfuRSzu1LKEn1ZTbnzy9PkkitKLKL
         6GwOL6jm40/ilNoHpHfOTOp8dDMQPYRFkfoqcs3vo6li2jsSluKdu9mZFkc40/gDMudp
         APlNG2WQG8RS8JtmiqKJS2n/eENq1gHLfddGMs/iu8HsRNNNkz1mQD/YaBmP4UbiYnn2
         ZZJW/Dnn4GMuZ1i+PQeXyKqS3u3dky6i4THGAC9VyuAXTDrci3Nthrh3EVLmB1CgTHb0
         zZqZoFF9XkBGiEaewyTYzbby4o2g1QVFeFRCQD+WfJ4UdiTqjaF65YQ6BXJpfUFnpziz
         OIfw==
X-Gm-Message-State: AC+VfDyzlfO5rxYshtGIn6Eos3SHTK0v301fPfHpLYYs7Vd5JOLfcqZh
        X4zaWeQ3yqnb2qwltVvYu0M=
X-Google-Smtp-Source: ACHHUZ5zGM/5wdpd7/eJvnvjX2dZLc1zy8U7oQzS60iygPq36k1FP8MONKTWdI70eSTu4kr0s38vIg==
X-Received: by 2002:a05:6214:d02:b0:61b:5afc:d4be with SMTP id 2-20020a0562140d0200b0061b5afcd4bemr1051113qvh.7.1684446611289;
        Thu, 18 May 2023 14:50:11 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h11-20020a0cedab000000b0061ac0b43a16sm809880qvr.103.2023.05.18.14.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:50:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id E2AC927C005B;
        Thu, 18 May 2023 17:50:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 May 2023 17:50:09 -0400
X-ME-Sender: <xms:j51mZIekthRM44pWdpOPIBUusHncGShmVjoSzE7iUOgyZc9LnGRJrA>
    <xme:j51mZKNz_-9wNRq1Th9mk4a2YQkDbSkh7FeSHG7WMZtycfyxfL1yPc1JQgZEZrRtC
    ymgItnrjjCWjcmShQ>
X-ME-Received: <xmr:j51mZJgGTZ31bC6OM36mPxyFgGSidHVmGIPaAc_ojFObBMe3ucZ1MZPChaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:j51mZN_Ku1YAR3kEjZlKobH8u_j_SjQLmfkgZILrTkdByfq-Pzpn8Q>
    <xmx:j51mZEt_EUqGpofAfHOjKaA-QxYBLYSSOmoHJr3GFFIE7RR5RarX2w>
    <xmx:j51mZEEx2yUoyDUwmp80FdQwbPRz179X1AuUh5DqYcM88cSRWfPScg>
    <xmx:kZ1mZEeO0xdrvqGSMGLQJ-t81zXSPr0_Nkd3kpgMODw2UwA-MFozXg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 17:50:07 -0400 (EDT)
Date:   Thu, 18 May 2023 14:49:40 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [RFC PATCH 1/4] rseq: Add sched_state field to struct rseq
Message-ID: <ZGaddGcHw7nJE+Gh@boqun-archlinux>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
 <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:26:51AM -0400, Mathieu Desnoyers wrote:
> Expose the "on-cpu" state for each thread through struct rseq to allow
> adaptative mutexes to decide more accurately between busy-waiting and
> calling sys_futex() to release the CPU, based on the on-cpu state of the
> mutex owner.
> 
> It is only provided as an optimization hint, because there is no
> guarantee that the page containing this field is in the page cache, and
> therefore the scheduler may very well fail to clear the on-cpu state on
> preemption. This is expected to be rare though, and is resolved as soon
> as the task returns to user-space.
> 
> The goal is to improve use-cases where the duration of the critical
> sections for a given lock follows a multi-modal distribution, preventing
> statistical guesses from doing a good job at choosing between busy-wait
> and futex wait behavior.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Carlos O'Donell <carlos@redhat.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: libc-alpha@sourceware.org
> ---
>  include/linux/sched.h     | 12 ++++++++++++
>  include/uapi/linux/rseq.h | 17 +++++++++++++++++
>  kernel/rseq.c             | 14 ++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index eed5d65b8d1f..c7e9248134c1 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2351,11 +2351,20 @@ static inline void rseq_signal_deliver(struct ksignal *ksig,
>  	rseq_handle_notify_resume(ksig, regs);
>  }
>  
> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state);
> +
> +static inline void rseq_set_sched_state(struct task_struct *t, unsigned int state)
> +{
> +	if (t->rseq)
> +		__rseq_set_sched_state(t, state);
> +}
> +
>  /* rseq_preempt() requires preemption to be disabled. */
>  static inline void rseq_preempt(struct task_struct *t)
>  {
>  	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
>  	rseq_set_notify_resume(t);
> +	rseq_set_sched_state(t, 0);
>  }
>  
>  /* rseq_migrate() requires preemption to be disabled. */
> @@ -2405,6 +2414,9 @@ static inline void rseq_signal_deliver(struct ksignal *ksig,
>  				       struct pt_regs *regs)
>  {
>  }
> +static inline void rseq_set_sched_state(struct task_struct *t, unsigned int state)
> +{
> +}
>  static inline void rseq_preempt(struct task_struct *t)
>  {
>  }
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index c233aae5eac9..c6d8537e23ca 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -37,6 +37,13 @@ enum rseq_cs_flags {
>  		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
>  };
>  
> +enum rseq_sched_state {
> +	/*
> +	 * Task is currently running on a CPU if bit is set.
> +	 */
> +	RSEQ_SCHED_STATE_ON_CPU		= (1U << 0),
> +};
> +
>  /*
>   * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
>   * contained within a single cache-line. It is usually declared as
> @@ -148,6 +155,16 @@ struct rseq {
>  	 */
>  	__u32 mm_cid;
>  
> +	/*
> +	 * Restartable sequences sched_state field. Updated by the kernel. Read
> +	 * by user-space with single-copy atomicity semantics. This fields can
> +	 * be read by any userspace thread. Aligned on 32-bit. Contains a

Maybe this is a premature optimization, but since most of the time the
bit would be read by another thread, does it make sense putting the
"sched_state" into a different cache line to avoid false sharing?

Also We could have a "sched_state_local" and "sched_state_remote" for
different usages (local reads vs remote reads).

Regards,
Boqun

> +	 * bitmask of enum rseq_sched_state. This field is provided as a hint
> +	 * by the scheduler, and requires that the page holding struct rseq is
> +	 * faulted-in for the state update to be performed by the scheduler.
> +	 */
> +	__u32 sched_state;
> +
>  	/*
>  	 * Flexible array member at end of structure, after last feature field.
>  	 */
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 9de6e35fe679..b2eb3bbaa9ef 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -91,6 +91,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
>  	u32 cpu_id = raw_smp_processor_id();
>  	u32 node_id = cpu_to_node(cpu_id);
>  	u32 mm_cid = task_mm_cid(t);
> +	u32 sched_state = RSEQ_SCHED_STATE_ON_CPU;
>  
>  	WARN_ON_ONCE((int) mm_cid < 0);
>  	if (!user_write_access_begin(rseq, t->rseq_len))
> @@ -99,6 +100,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
>  	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
>  	unsafe_put_user(node_id, &rseq->node_id, efault_end);
>  	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
> +	unsafe_put_user(sched_state, &rseq->sched_state, efault_end);
>  	/*
>  	 * Additional feature fields added after ORIG_RSEQ_SIZE
>  	 * need to be conditionally updated only if
> @@ -339,6 +341,18 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>  	force_sigsegv(sig);
>  }
>  
> +/*
> + * Attempt to update rseq scheduler state.
> + */
> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state)
> +{
> +	if (unlikely(t->flags & PF_EXITING))
> +		return;
> +	pagefault_disable();
> +	(void) put_user(state, &t->rseq->sched_state);
> +	pagefault_enable();
> +}
> +
>  #ifdef CONFIG_DEBUG_RSEQ
>  
>  /*
> -- 
> 2.25.1
> 
