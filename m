Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B6B714FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjE2Tga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjE2Tg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E763B7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685388941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8SqjRaOI7SSEDak/JLmJD7dtB3ewVlNqCAod3ToFvI=;
        b=g804D2RRU6PYR/HyezkvKIyQbMINnvyzQCOGvcrNpNp47qsFlb8KrV+ovpcMbqwDRNXUkS
        7L8X9O+9ZiSnAv2cADZwUptc0Lca9NVk4ADQqXQm1Ds6vY9GyXBZ6oK04wLCYY/yFrE4+S
        EvSnDgcXHHI5/ZCgJknUesxPvitBZeU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-QShCzv_1NS-KmvGGCjnC8g-1; Mon, 29 May 2023 15:35:38 -0400
X-MC-Unique: QShCzv_1NS-KmvGGCjnC8g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D51F3806624;
        Mon, 29 May 2023 19:35:37 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95058C154D1;
        Mon, 29 May 2023 19:35:32 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
        <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
Date:   Mon, 29 May 2023 21:35:30 +0200
In-Reply-To: <20230529191416.53955-2-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 29 May 2023 15:14:13 -0400")
Message-ID: <87wn0r6id9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> +/*
> + * rseq_sched_state should be aligned on the cache line size.
> + */
> +struct rseq_sched_state {
> +	/*
> +	 * Version of this structure. Populated by the kernel, read by
> +	 * user-space.
> +	 */
> +	__u32 version;
> +	/*
> +	 * The state is updated by the kernel. Read by user-space with
> +	 * single-copy atomicity semantics. This field can be read by any
> +	 * userspace thread. Aligned on 32-bit. Contains a bitmask of enum
> +	 * rseq_sched_state_flags. This field is provided as a hint by the
> +	 * scheduler, and requires that the page holding this state is
> +	 * faulted-in for the state update to be performed by the scheduler.
> +	 */
> +	__u32 state;
> +	/*
> +	 * Thread ID associated with the thread registering this structure.
> +	 * Initialized by user-space before registration.
> +	 */
> +	__u32 tid;
> +};

How does the version handshake protocol in practice?  Given that this
user-allocated?

I don't see why we can't stick this directly into struct rseq because
it's all public anyway.

The TID field would be useful in its own right.

Thanks,
Florian

