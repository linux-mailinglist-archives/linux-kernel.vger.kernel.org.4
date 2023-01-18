Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520A5671A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjARL2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjARL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:27:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175FCBD145;
        Wed, 18 Jan 2023 02:45:53 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mg12so9851399ejc.5;
        Wed, 18 Jan 2023 02:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJaMI56CuLQSWiXvcFp/J8HGei2lr3N4VqMBnaci1Eg=;
        b=h1pBp+ReYZJ1R2WXFgIEHoWl0UI1RZ8YxXFlZUuvlcn7bNNethjx3rZKL83ZRXIt1A
         2tzcW98ytzjAjZUkpVYsIP9xVm481iP91GeIlzPkssYEKvxyKHfVbWP+rbxHABMVMFBx
         n8iGaTiyh7PIcCzRfnVRFPUwfI2NncWMoAQVUbvW2GdKdBajOtC8X/RluZu6lKj0Y2zp
         HUP8jb8ooNS8SAsclVxfsDLO2u4nyeIb89YrLKtNeS44tVrY/C+zF6tojUAcTVAHAWfj
         h0iK9568MFunp7NedC8boxuY+DHoWCOrrXv4HcysNklsV0uSAt3Zva3Hch3hioRBmwyF
         FoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJaMI56CuLQSWiXvcFp/J8HGei2lr3N4VqMBnaci1Eg=;
        b=3mTIfZqT/5FqnJ6Z1/UYhqvQbxXUMXWVz6WBrLK9IfXQOR96W9ucFU8e/0Pyvk9UfD
         YHOZ6f+WDjweHgxtsaOTjwuadGZtSSrQHHr9gzpNAYgX7Xv6GSI2Yx/B98iC93CL0M5R
         Zi6wWKpjBl2P/FiTfzxWRqyugP3wiF0AvUNleeCboHYdIWAp6c1EQW2qXcIh1qEdBI/4
         NYrNBBLIr/F4rlSdrjocZTHT+fsOa15Nfj8zra9jRPF5fVsNZF3YK0sgoqX56ovzwjsB
         Ajl4bWJBPQ2RtxILiwNCkdUN6HGYJUTpQZdKUiKwz7xAC0J2XLXNedz0KXmnTtdss5Cd
         xloQ==
X-Gm-Message-State: AFqh2kq6KcHOcSn1MKj7jtNjPbC41uLvaLEl4pQmmrMTVt049akTXzoE
        N2slDy1gNU9PYLi1+UZOB80=
X-Google-Smtp-Source: AMrXdXtvhn2U2RX2/t9Rt422JPZkiRxbYqLS3xwB7ZOocBkenMXPFWgl4FYZh4Nlmxi0Bnir2UzbBQ==
X-Received: by 2002:a17:906:fb0d:b0:856:6884:675f with SMTP id lz13-20020a170906fb0d00b008566884675fmr6467925ejb.52.1674038751892;
        Wed, 18 Jan 2023 02:45:51 -0800 (PST)
Received: from gmail.com ([31.46.242.11])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090631c100b007aea1dc1840sm14429002ejf.111.2023.01.18.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 02:45:51 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Jan 2023 11:45:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8fN2VQQTGUZ3ykw@gmail.com>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> > > dio_truncate is not a realtime application but indefinite writer 
> > > starvation
> > 
> > If so then the PI boosting would not work if we would have it ;)
> > 
> 
> True, but it's still undesirable for a basic functional test using normal 
> tasks with no prioritisation to stall forever.

Agreed.

> +/*
> + * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick.
> + * This matches RWSEM_WAIT_TIMEOUT for the generic RWSEM implementation.
> + * The granularity is not exact as the lowest bit in rwbase_rt->waiter_timeout
> + * is used to detect recent DL / RT tasks taking a read lock.
> + */
> +#define RWBASE_RT_WAIT_TIMEOUT DIV_ROUND_UP(HZ, 250)
> +
> +static void __sched update_dlrt_reader(struct rwbase_rt *rwb)
> +{
> +	/* No update required if DL / RT tasks already identified. */
> +	if (rwb->waiter_timeout & 1)
> +		return;
> +
> +	/*
> +	 * Record a DL / RT task acquiring the lock for read. This may result
> +	 * in indefinite writer starvation but DL / RT tasks should avoid such
> +	 * behaviour.
> +	 */
> +	if (rt_task(current)) {
> +		struct rt_mutex_base *rtm = &rwb->rtmutex;
> +		unsigned long flags;
> +
> +		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> +		rwb->waiter_timeout |= 1;
> +		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> +	}
> +}

So I'm not sure this should be dependent on the task being an RT task.

Starvation scenarios are bad no matter what scheduling policy is used.

Should be unconditional - and all workloads should live with the new 
behavior.

Thanks,

	Ingo
