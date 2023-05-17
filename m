Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C6706E71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEQQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:41:31 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08678A5D7;
        Wed, 17 May 2023 09:41:09 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B8785762444;
        Wed, 17 May 2023 16:41:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9D77B76251B;
        Wed, 17 May 2023 16:41:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684341668; a=rsa-sha256;
        cv=none;
        b=Lxw+3UaSmZUVI2O9OZtRvy3Bd40NNV+PqdwYNl5n69OGv8j7D5bRybTsQU/a7J6kcnjGYX
        Oc9F+GnhW7B/2URGRWKGulzqBJ/ODGxHBYtlm5yvRJIo/gY8mqMokfZhIMWHg4UjmeVk1K
        4tyPStGUf1B382FTGKRyTTyryRyR7fEoHyVWeF6Rlufzc/4H4MlB4w8YhSZKn/UzRVQd5V
        PzQ7vCYXaUZLAM3du/CNjYaPMfgwiBUW5QM2iBMlGV5LbPl685Sha21hZDkKLC6FWr0nkF
        h+o+lpNIe8Zl4wYTNPVJjUYDZIiNN6lQwdio8VmJrEDyXZ8T4AGgXd7np4sIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684341668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=VXKqe3jgNKbRnhNO0B2pUNp9eHQyU6zNHI/Xvc/t0e4=;
        b=jhNXvhs+TY+moRx10tepTNbDr+qJFTAnrnfKV2x+o5pQIk5fz2vLjzFwdxtuU5XP9JEZqq
        SqZNXPLZq+vJbXqCk483kr1iRmqaszV2UxU5g7NG/nX/KoMO/fBpHxG4Fn2/eqPJq4wBll
        pGDSG4MApUYfrQmfzouMkpGMtPkV4l4S8cHjNzd30e4iJHyUIFbI+pINYNvpf+J+HgOVbR
        2znEGMJogR/S+mrsrcnnWdZc8FdB8k6Bz9/fOeFTQJcEmx9b6I86sho9Z6taPHNox72OXz
        LaMUkOYxKJ5r2GtSXbvFO2ff1x3CCe8xqsYuff8dbzo7t8roSsIeQouSXAO2sw==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-ws6n5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Shelf: 62d8a2582083a651_1684341668443_4082558754
X-MC-Loop-Signature: 1684341668443:922589920
X-MC-Ingress-Time: 1684341668443
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.48 (trex/6.8.1);
        Wed, 17 May 2023 16:41:08 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4QLzPp3pgMz3P;
        Wed, 17 May 2023 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684341663;
        bh=VXKqe3jgNKbRnhNO0B2pUNp9eHQyU6zNHI/Xvc/t0e4=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=dlFmXIyQIztX0tJouWHTvTY1Rb0sk+fq5HQzDnG4pl2dG1LMjo37/QrY4WR1oVVQY
         zcOBu+lN+vSkuZn5/ajgy1n75kD9f51+QkzLgfPmdWX6higJ9F9Vagb6cEOO5Je2uY
         ehCbK2LXPCK5UNTiYQYqyHNPqqNtrR/I1NEN1sutBItnI03zvazV43ZDGo7DZkGrvx
         anhgfky3eGrtK4g4rgDArvPVkYrt0fcc6pRCSI3PWFwiWLigq7bHm8QCOrv8CL1+Po
         WGMUqZ3CJS2VWnzG8ji4V7wvWkPm//uPWeVckwWKO4bo7WZX9QW8Dd3Z9PVeHPKPA1
         Ct5U9TCw1skHA==
Date:   Wed, 17 May 2023 09:07:56 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        =?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, longman@redhat.com
Subject: Re: [RFC PATCH 0/4] Extend rseq with sched_state field
Message-ID: <a5x2hd6yx55fqtlfhoke4ofvsua5sddmqvi5fd5xuh4uuoo676@nffuciys4zcm>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
User-Agent: NeoMutt/20230407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Waiman.

On Wed, 17 May 2023, Mathieu Desnoyers wrote:

>This prototype extends struct rseq with a new sched_state field, which
>contains a "on-cpu" flag kept up-to-date by the scheduler.
>
>It is meant to be used by userspace adaptative mutexes to decide between
>busy-wait and futex wait system call (releasing the CPU) behaviors based
>on the current state of the mutex owner.
>
>The goal is to improve use-cases where the duration of the critical
>sections for a given lock follows a multi-modal distribution, preventing
>statistical guesses from doing a good job at choosing between busy-wait
>and futex wait behavior.
>
>This is in response to the LWN coverage of 2023 Open Source Summit North
>America (https://lwn.net/Articles/931789/) unscheduled slot "Adaptive
>spinning in user space" presented by Andr=E9 Almeida.
>
>Feedback is welcome!
>
>Mathieu
>
>Mathieu Desnoyers (4):
>  rseq: Add sched_state field to struct rseq
>  selftests/rseq: Add sched_state rseq field and getter
>  selftests/rseq: Implement sched state test program
>  selftests/rseq: Implement rseq_mutex test program
>
> include/linux/sched.h                         |  12 ++
> include/uapi/linux/rseq.h                     |  17 +++
> kernel/rseq.c                                 |  14 ++
> tools/testing/selftests/rseq/.gitignore       |   2 +
> tools/testing/selftests/rseq/Makefile         |   3 +-
> tools/testing/selftests/rseq/rseq-abi.h       |  17 +++
> tools/testing/selftests/rseq/rseq.h           |   5 +
> tools/testing/selftests/rseq/rseq_mutex.c     | 120 ++++++++++++++++++
> .../testing/selftests/rseq/sched_state_test.c |  71 +++++++++++
> 9 files changed, 260 insertions(+), 1 deletion(-)
> create mode 100644 tools/testing/selftests/rseq/rseq_mutex.c
> create mode 100644 tools/testing/selftests/rseq/sched_state_test.c
>
>--
>2.25.1
>
