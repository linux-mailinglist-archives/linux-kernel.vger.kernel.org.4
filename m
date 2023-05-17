Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D03706E43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjEQQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEQQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:36:26 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189527AB2;
        Wed, 17 May 2023 09:36:22 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0BD2F142370;
        Wed, 17 May 2023 16:36:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 30CA8142440;
        Wed, 17 May 2023 16:36:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684341378; a=rsa-sha256;
        cv=none;
        b=8TBJJLNQPn2h1nvnLjuoogxoWhcqu1X6n6bqAKhXQXHU4o1ue0LHLr8Z077YAC1CyrJPbG
        gvvEd+1tUAu53nx/gEiVPwjd6hJWz1Q40AZx6upEyBZV50bevrlZH8P9v7YIF7vMTZgtGg
        evoF39Bg3REUKV3Tb/PEq8xp/Sitz/SFSWkN8vwST8pLLsRJNj0JK9MD3oo/mYxwjhurL+
        6DSsamsKLCiJTD9GR1HfrLkzM+EAXUh+eSvboAjrqPnzIpiVEoOS+nmsw79rrjBQkUYL8n
        HTnbLbHh4GUphxw4mzpK8Wr+P5lX4wik9bzmIaHP1kgAvGCGphAn7RnOA2Rn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684341378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=lyiRfuaV6vZjIMI62a7F2smJjyomKoQQVaxcFOW0RMU=;
        b=p5Rkn0Eb9Katw9I3hrYPtNJcumec0+M6R11t/o+cCCKkEaP7OFukpzM+xs4rcSvAZa+1T+
        B48psbdNnByI9iUnnUviJ/QpomUkBg1MeDD3brWRKfjdOhIxHcEPRyNumjYX2BN9cyyvQS
        kS9Flp0aDYgI+FRiZDxizov3h4yOmIak0mhFtcinpiDYKxhlxjSvuuzsBXlyjMlbeo1Ib+
        FbwclrKYsp6NaLDhuZOBl9yGLf8MKM1tEMLkt1gU5ptW6KKkMZ6I87xyHl9AQkMNpjfkVn
        BwwIFLo+1hLlnDAC2ZC39c/h1rMN1ilK3G60tMrnBs0v8TmrjaSw8l3akAh9HQ==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-qfmcz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Average: 21cc3ecd1ea00827_1684341378774_1935386030
X-MC-Loop-Signature: 1684341378774:2797499641
X-MC-Ingress-Time: 1684341378774
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.163.35 (trex/6.8.1);
        Wed, 17 May 2023 16:36:18 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4QLzJJ4jRWz3P;
        Wed, 17 May 2023 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684341377;
        bh=lyiRfuaV6vZjIMI62a7F2smJjyomKoQQVaxcFOW0RMU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=XgRrMz+u0P8x1yYoJtc4xEPAgSrWVfT2hFfBYeCARaEMzRO19A8+JWvdOseSpTwBN
         8aSNiaPoCjOMI2bwl3syscqc+WPtRH1i9ol7PfTumYO1ZfxGdSeRJIxMPXi40TJmO+
         39m1pirdAxEICt0SkmDFzCO3D5/YXqYtyThKdgWGyplhxi3OBomm0RaLGKyZogowSG
         teu6jqWKVvfCa43KqvgPFFjeoBcA3UUT7MVxdKEEC+HDsRbv0VWupXS4DYl3m31U8M
         pOGaV/SWew6e03dlVR2xtXwqDsmxXsQUwY627LjPtYCmCmXRgwoqoeXBGDwGOip6cl
         wDcgwvY73D3Sw==
Date:   Wed, 17 May 2023 09:03:10 -0700
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
        Jonathan Corbet <corbet@lwn.net>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [RFC PATCH 1/4] rseq: Add sched_state field to struct rseq
Message-ID: <43ssw4ghx52wpw2klzyi35ioc4fr5g2givcc7sdxcyndytghsd@z4j6vdwvmn4d>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
 <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
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

On Wed, 17 May 2023, Mathieu Desnoyers wrote:

>Expose the "on-cpu" state for each thread through struct rseq to allow
>adaptative mutexes to decide more accurately between busy-waiting and
>calling sys_futex() to release the CPU, based on the on-cpu state of the
>mutex owner.

Oh yeah moving the spin stuff out of the kernel is much nicer.

>It is only provided as an optimization hint, because there is no
>guarantee that the page containing this field is in the page cache, and
>therefore the scheduler may very well fail to clear the on-cpu state on
>preemption. This is expected to be rare though, and is resolved as soon
>as the task returns to user-space.
>
>The goal is to improve use-cases where the duration of the critical
>sections for a given lock follows a multi-modal distribution, preventing
>statistical guesses from doing a good job at choosing between busy-wait
>and futex wait behavior.
>
>Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>Cc: Jonathan Corbet <corbet@lwn.net>
>Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
>Cc: Carlos O'Donell <carlos@redhat.com>
>Cc: Florian Weimer <fweimer@redhat.com>
>Cc: libc-alpha@sourceware.org
>---
> include/linux/sched.h     | 12 ++++++++++++
> include/uapi/linux/rseq.h | 17 +++++++++++++++++
> kernel/rseq.c             | 14 ++++++++++++++
> 3 files changed, 43 insertions(+)

Ie: previous efforts

  kernel/futex.c             |  675 ++++++++++++++++++++++++++++++++++++++------
  kernel/futex.c             |  572 ++++++++++++++++++++++++++++++++++++-------------

Thanks,
Davidlohr
