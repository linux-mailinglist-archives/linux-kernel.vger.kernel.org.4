Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DDC709DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjESRTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjESRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:19:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D09139;
        Fri, 19 May 2023 10:19:06 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75939de402dso189086585a.1;
        Fri, 19 May 2023 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684516745; x=1687108745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNvkHM3C8oMIiEYBQOR2QcPZngwWS8RB4fg2zL79fnY=;
        b=AOm/dibf3V4J+EHKVHoe0O+9mITE7gFpTuRVTZvDH2PaOvftXn+CVoE5h0unk51WFK
         tj5/qniAnoovIUeuyJMG62bsuZifc/NGumLY2dXedtLf9fE57jsdGubfXSsPBANl4s9W
         AnOHSZqHwo4gRcfhsDZ20I/dTeKl99Y8vd6w/NqydamlD5NTao0MUTducK8L+fQjLGAe
         IU3ZjCqSdUNCCYylZlguMA4Dw33NXsLyeGi6VvJD9PARnv/hp2BDHSomNKNhlfjtC8v1
         JHKURKKyWzWDah/Ire0vT0dVgr2fq9DbaHvNnnT8YdFzj/2itS9NKbJkAy7bF9fG3VJz
         Hlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516745; x=1687108745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNvkHM3C8oMIiEYBQOR2QcPZngwWS8RB4fg2zL79fnY=;
        b=B4dWOc0N+0ui8Ryd/ecBgwCR9h2GOj19h7FyPtc9kcJ1zAsNqrCko+WR0HhAdb73A3
         0DShVN7wylcqpHRnPAnW0OlMD6pEvwXpIA5RDoFme8JGH9IBvzCu89Jtn4TifK5r1xzk
         aBx65gPZzXyzQO+1fKkMoWkTSt2EVUj2NLwNucsM3uTnfM6qvk76hCI2L2XrlN+GPvG4
         xK1OIeh7LBZZkxVmUU4VmblJzs/0NVaT9z43lAJlxO5qpG8T8ohwgxzZ2Q3tIftbrIsy
         F7AfHrcKniaND3/6EW++3WHsJcNv9ub3KYQlQ986JXTFVu80nPf1E7RYceFJhoBqaPEe
         Ot8w==
X-Gm-Message-State: AC+VfDxdTes20YtG6ZisSBoSD6BMmF3YlDAdxuNLuaWJ/lJ6YBZquSF4
        Ib0WWrryscwWVuUae5smNpI=
X-Google-Smtp-Source: ACHHUZ71a5EXWIh4bpeS0CYUvFf5ufUdp7lwzzXIKP64RMTY1jT8R4s4nN7vgxgi+JeHX0csRt0TlQ==
X-Received: by 2002:a05:6214:d8d:b0:621:363c:ea93 with SMTP id e13-20020a0562140d8d00b00621363cea93mr4473305qve.15.1684516745089;
        Fri, 19 May 2023 10:19:05 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a8-20020a0ca988000000b00623839cba8csm1476328qvb.44.2023.05.19.10.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:19:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9B2DC27C0054;
        Fri, 19 May 2023 13:19:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 May 2023 13:19:03 -0400
X-ME-Sender: <xms:hq9nZDFjKx-D5N9bhOST6GS9Q6i32Ru78Q8023CvHAKlB8tmjXEyAg>
    <xme:hq9nZAVeuXcjXBlKXi87up-_ipE_xZyz4quL8AipVax3KSPMaRcsrkBl_luuWc7-o
    E5KNSHxdFdSWvM_3A>
X-ME-Received: <xmr:hq9nZFLeYX4ZV7nJKe3QbgVyMBrsoZ2zgboSUM_dlH25DXN5sH6HQ01EyXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptddtudegueevgefhgfeuffetffeuheekgedtffefhefhjeffhffgfeeg
    geetgefhnecuffhomhgrihhnpegvfhhfihgtihhoshdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:hq9nZBHB5BGVLkp2BrzU93m5-LXng1l43P-VoOJr3C7Y0XOGfH12hQ>
    <xmx:hq9nZJU-yxlc5s-dQ27-MzulGb9aMm9eiCarMrcP3tE6p-rtU6yomA>
    <xmx:hq9nZMMfBv6uRnDIoNI0hqNzGdXmXp0QiJIeeW0uCta1ojHOzXjr2w>
    <xmx:h69nZPHp7iKi3wWnJ0XDEWKvw6qNnkZ3qs2d9ErLd33RQxH0pYjdiw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 13:19:01 -0400 (EDT)
Date:   Fri, 19 May 2023 10:18:31 -0700
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
Message-ID: <ZGevZxOjJLMO9zlM@boqun-archlinux>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
 <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
 <ZGaddGcHw7nJE+Gh@boqun-archlinux>
 <06ee47e0-99e0-4b6a-ab67-239fccf2777d@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ee47e0-99e0-4b6a-ab67-239fccf2777d@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:15:11AM -0400, Mathieu Desnoyers wrote:
> On 2023-05-18 17:49, Boqun Feng wrote:
> > On Wed, May 17, 2023 at 11:26:51AM -0400, Mathieu Desnoyers wrote:
> [...]
> > > diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> > > index c233aae5eac9..c6d8537e23ca 100644
> > > --- a/include/uapi/linux/rseq.h
> > > +++ b/include/uapi/linux/rseq.h
> > > @@ -37,6 +37,13 @@ enum rseq_cs_flags {
> > >   		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
> > >   };
> > > +enum rseq_sched_state {
> > > +	/*
> > > +	 * Task is currently running on a CPU if bit is set.
> > > +	 */
> > > +	RSEQ_SCHED_STATE_ON_CPU		= (1U << 0),
> > > +};
> [...]
> > > +	/*
> > > +	 * Restartable sequences sched_state field. Updated by the kernel. Read
> > > +	 * by user-space with single-copy atomicity semantics. This fields can
> > > +	 * be read by any userspace thread. Aligned on 32-bit. Contains a
> > 
> > Maybe this is a premature optimization, but since most of the time the
> > bit would be read by another thread, does it make sense putting the
> > "sched_state" into a different cache line to avoid false sharing?
> 
> I'm puzzled by your optimization proposal, so I'll say it outright: I'm
> probably missing something.
> 

Maybe it's me who is missing something ;-)

> I agree that false-sharing would be an issue if various threads would
> contend for updating any field within this cache line.
> 
> But the only thread responsible for updating this cache line's fields is the
> current thread, either from userspace (stores to rseq_abi->rseq_cs) or from
> the kernel (usually on return to userspace, except for this new ON_CPU bit
> clear on context switch).
> 
> The other threads busy-waiting on the content of this sched_state field will
> only load from it, never store. And they will only busy-wait on it as long

But their loads can change the cache line state from "Exclusive" to
"Shared" (using MESI terms), right? And that could delay the stores of
the current thread.

> as the current task runs. When that task gets preempted, other threads will
> notice the flag change and use sys_futex instead.
> 
> So the very worse I can think of in terms of pattern causing cache coherency
> traffic due to false-sharing is if the lock owner happens to have lots of
> rseq critical sections as well, causing it to repeatedly store to the
> rseq_abi->rseq_cs field, which is in the same cache line.
> 
> But even then I'm wondering if this really matters, because each of those
> stores to rseq_cs would only slow down loads from other threads which will
> need to retry busy-wait anyway if the on-cpu flag is still set.
> 
> So, what am I missing ? Is this heavy use of rseq critical sections while
> the lock is held the scenario you are concerned about ?
> 

The case in my mind is the opposite direction: the loads from other
threads delay the stores to rseq_cs on the current thread, which I
assume are usually a fast path. For example:

	CPU 1				CPU 2

	lock(foo); // holding a lock
	rseq_start():
	  <CPU 1 own the cache line exclusively>
	  				lock(foo):
					  <fail to get foo>
					  <check whether the lock owner is on CPU>
					  <cache line becames shared>
	  ->rseq_cs = .. // Need to invalidate the cache line on other CPU

But as you mentioned, there is only one updater here (the current
thread), so maybe it doesn't matter... but since it's a userspace ABI,
so I cannot help thinking "what if there is another bit that has a
different usage pattern introduced in the future", so..

> Note that the heavy cache-line bouncing in my test-case happens on the lock
> structure (cmpxchg expecting NULL, setting the current thread rseq_get_abi()
> pointer on success). There are probably better ways to implement that part,
> it is currently just a simple prototype showcasing the approach.
> 

Yeah.. that's a little strange, I guess you can just read the lock
owner's rseq_abi, for example:

	rseq_lock_slowpath() {
		struct rseq_abi *other_rseq = lock->owner;

		if (RSEQ_ACCESS_ONCE(other_rseq->sched_state)) {
			...
		}
	}

?

Regards,
Boqun

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
