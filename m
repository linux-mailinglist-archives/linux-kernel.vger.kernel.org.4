Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA6747466
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjGDOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjGDOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:47:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E9D10CF;
        Tue,  4 Jul 2023 07:47:54 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688482072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Qmq4SKQQ7gKHnn/JkJpEXp7Z561AjgrQQ8nebwxnbE=;
        b=0gvl+bGOgGOiLURH54fDatcGdd8MjBgZfcnwAwVVkf4gA28kMPlkVBrHMQrLLpxDDB+UYi
        GNDhJsej80SMFtSO1xhs2KUl0aWkEtXlREvKJFEnNhO7O1K9dbnzTPEUgkqOv3yfjLCR1s
        XmIl1FdHF94pwmvJA1cCpoQRzAOayNYxOo9500ZDoZI/it6qT4QsHtUCZMXsiolTUDVxt2
        jodh7JYw4ndQYh8znHGZxUTp2g4urPTMcoPfnIuOPVwrWqYcCPR5cYGPL/ZpH1xy1F63G9
        K1qCqiJQYyzo/kTCQvGXl09aAYF4FUvBwXkGIm5tBqiHYf+Cs56oGFPcz4QyKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688482072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Qmq4SKQQ7gKHnn/JkJpEXp7Z561AjgrQQ8nebwxnbE=;
        b=9mNXV1XDq2TewPCvWKvPq+HGiD4Uwo/9ihdfKiFM7wmzHiZR8QuJj3F5TBoh8n8HQFK8C/
        +49i+Kxn/2aZ1hCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        juri.lelli@redhat.com
Subject: Re: Splat in kernel RT while processing incoming network packets
Message-ID: <20230704144749.wJUlub6-@linutronix.de>
References: <bkw2aao62e3ppg7332dbhycgzdwr7k5brezj3bcij6zewphmnd@eigmbvjh6wuu>
 <20230703142908.RcxjjF_E@linutronix.de>
 <x6d2ae4ss4wvvuib2hmop6ztysjsbyno7gbjkyek5xng2kmgyd@yfmnfognlj5n>
 <20230704100527.75hMNZ35@linutronix.de>
 <a4ed5a8cc35f34a3cb11aded76b0f289c658c1a7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a4ed5a8cc35f34a3cb11aded76b0f289c658c1a7.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-04 12:29:33 [+0200], Paolo Abeni wrote:
> Just to hopefully clarify the networking side of it, napi instances !=3D
> network backlog (used by RPS). The network backlog (RPS) is available
> for all the network devices, including the loopback and all the virtual
> ones.=C2=A0

Yes.

> The napi instances (and the threaded mode) are available only on
> network device drivers implementing the napi model. The loopback driver
> does not implement the napi model, as most virtual devices and even
> some H/W NICs (mostily low end ones).

Yes.

> The network backlog can't run in threaded mode: there is no API/sysctl
> nor infrastructure for that. The backlog processing threaded mode could
> be implemented, even if should not be completely trivial and it sounds
> a bit weird to me.

Yes, I mean that this needs to be done.

>=20
> Just for the records, I mentioned the following in the bz:
>=20
> It looks like flush_smp_call_function_queue() has 2 only callers,
> migration, and do_idle().
>=20
> What about moving softirq processing from
> flush_smp_call_function_queue() into cpu_stopper_thread(), outside the
> unpreemptable critical section?

This doesn't solve anything. You schedule softirq from hardirq and from
this moment on you are in "anonymous context" and we solve this by
processing it in ksoftirqd.
For !RT you process it while leaving the hardirq. For RT, we can't.
Processing it in the context of the currently running process (say idle
as in the reported backtrace or an another running user task) would lead
to processing network related that originated somewhere at someone
else's expense. Assume you have a high prio RT task running, not related
to networking at all, and suddenly you throw a bunch of skbs on it.

Therefore it is preferred to process them within the interrupt thread in
which the softirq was raised/ within its origin.

The other problem with ksoftirqd processing is that everything is added
to a global state and then left for ksoftirqd to process. The global
state is considered by every local_bh_enable() instance so random
interrupt thread could process it or even a random task doing a syscall
involving spin_lock_bh().

The NAPI-threads are nice in a way that they don't clobber the global
state.
For RPS we would need either per-CPU threads or serve this in
ksoftirqd/X. The additional thread per-CPU makes only sense if it runs
at higher priority. However without the priority it would be no
different to ksoftirqd unless it does only the backlog's work.

puh. I'm undecided here. We might want to throw it into ksoftirqd,
remove the warning. But then this will be processed with other softirqs
(like USB due to tasklet) and at some point and might be picked up by
another interrupt thread.

> Cheers,
>=20
> Paolo

Sebastian
