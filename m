Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF2365F092
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjAEPx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjAEPxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:53:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E464BC0B;
        Thu,  5 Jan 2023 07:53:22 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672934000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFN2JUnnjmOiZqK5WqhsGGMNgDSJTA2VQpZUv4AE5Po=;
        b=NGnLo08NePVHH8A1VWzRfNn1V++LFk0R5om2N6Q/gMi3z5O1D5+gN6GihF1DEGxX2dvheZ
        NoO+dPLac0Z3cNKKSRjRYCDnV9HpYTNmf61QGFRPk73eVJjZnXZq8Gs7rJ5TcEpEgr6yMC
        +bQyvJ3L94T0G8xa1WcZ/nyjq3HITqQ1YvFZyKFAd/VaIwP1aB/BMEhDtunK1kOAiunOTY
        Ceml8ue+WHGKLzV9XrAn6g+YMaN5TEp3/eSd5pii7ghRGn7hRVMF1YTVneSbpep/rOTGKf
        qL37yMu+vM0PmpDuGmH9rnJejDUh/Yrh5Z90KxlU6UoWQV/AElOByGmvKwUsCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672934000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFN2JUnnjmOiZqK5WqhsGGMNgDSJTA2VQpZUv4AE5Po=;
        b=3UuVruMNYXHk31m2N/6lYkzsgHzhkHSUt8/FGJjLL9wr3dK+wwkX3IC0zZz5GtLZAfz0p1
        caJaYFL3XjX9lyDw==
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH rcu 27/27] rcu: Remove CONFIG_SRCU
In-Reply-To: <20230105152351.GP4028633@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-27-paulmck@kernel.org>
 <87r0w9csqn.fsf@jogness.linutronix.de>
 <20230105152351.GP4028633@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 05 Jan 2023 16:58:40 +0106
Message-ID: <871qo9c71z.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> $ git grep CONFIG_SRCU
>> drivers/base/core.c:#ifdef CONFIG_SRCU
>> drivers/base/core.c:#else /* !CONFIG_SRCU */
>> drivers/base/core.c:#endif /* !CONFIG_SRCU */
>> fs/locks.c:#if IS_ENABLED(CONFIG_SRCU)
>> fs/locks.c:#else /* !IS_ENABLED(CONFIG_SRCU) */
>> fs/locks.c:#endif /* IS_ENABLED(CONFIG_SRCU) */
>> kernel/notifier.c:#ifdef CONFIG_SRCU
>> kernel/notifier.c:#endif /* CONFIG_SRCU */
>
> In the -rcu tree, these are removed by these commits:
>
> 1798c5b6b0ea ("drivers/base: Remove CONFIG_SRCU")
> 19aa50512372 ("fs: Remove CONFIG_SRCU")
> fe0c9bd625ad ("kernel/notifier: Remove CONFIG_SRCU")
>
>> Should those be removed before this patch?
>
> When I merge the -rcu tree's "dev" branch with current mainline, "git
> grep CONFIG_SRCU" gives me no output.  Am I fat-fingering something
> here?

Sorry, I checked against the wrong branch. You are good.

Reviewed-by: John Ogness <john.ogness@linutronix.de>
