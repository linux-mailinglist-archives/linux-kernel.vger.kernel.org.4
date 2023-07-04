Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8185D746E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGDKFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGDKFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:05:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0260EE;
        Tue,  4 Jul 2023 03:05:30 -0700 (PDT)
Date:   Tue, 4 Jul 2023 12:05:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688465129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MTmdUPrOxgHFBWgYdG8uHdtoV2yVFTVtMbfQtqI+N4=;
        b=w8g9zcjFUkBQGTavZvYh+mxRwEQbWF/wvTL5F26kb5aDCtJSlsuEQbkT1II7W+AqLuhm2e
        UYGJcNhxH+ctOs0U+E6G1yHVuz6Eebmzz9pXRKP3wOgfWhFv8BclaETf6EtTDyZohZ5UoN
        fQWp5nX+SWm9jPmPJuiquffPGsMeZDlriJajYpJatc/wOyqAo9SgB6X1hDKkaC+cAST+Qk
        wfAXKioU53axGudjYCcmmx9nCDmQaeNdlul6CJKja0s3uMbPB6zIJRx+iemQptrHuqYoOj
        e1fIlW6ku52s5g+KjvVFaHsF1iV09ubBInI+zMwmYGYPn30ME8onc7laFeOqeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688465129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MTmdUPrOxgHFBWgYdG8uHdtoV2yVFTVtMbfQtqI+N4=;
        b=rqUf3S4T7NRDsOq8vH2lBF1h3Fnp9qybW4fqH1LoOvIGZpXX4/YR0DYpeOPQcYUJn7ESzs
        dKvqjMXhERPe+pDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, juri.lelli@redhat.com
Subject: Re: Splat in kernel RT while processing incoming network packets
Message-ID: <20230704100527.75hMNZ35@linutronix.de>
References: <bkw2aao62e3ppg7332dbhycgzdwr7k5brezj3bcij6zewphmnd@eigmbvjh6wuu>
 <20230703142908.RcxjjF_E@linutronix.de>
 <x6d2ae4ss4wvvuib2hmop6ztysjsbyno7gbjkyek5xng2kmgyd@yfmnfognlj5n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <x6d2ae4ss4wvvuib2hmop6ztysjsbyno7gbjkyek5xng2kmgyd@yfmnfognlj5n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-03 18:15:58 [-0300], Wander Lairson Costa wrote:
> > Not sure how to proceed. One thing you could do is a hack similar like
> > net-Avoid-the-IPI-to-free-the.patch which does it for defer_csd.
>=20
> At first sight it seems straightforward to implement.
>=20
> > On the other hand we could drop net-Avoid-the-IPI-to-free-the.patch and
> > remove the warning because we have now commit
> >    d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
>=20
> But I am more in favor of a solution that removes code than one that
> adds more :)

Raising the softirq from anonymous (hardirq context) is not ideal for
the reasons I stated below.

> > Prior that, raising softirq from hardirq would wake ksoftirqd which in
> > turn would collect all pending softirqs. As a consequence all following
> > softirqs (networking, =E2=80=A6) would run as SCHED_OTHER and compete w=
ith
> > SCHED_OTHER tasks for resources. Not good because the networking work is
> > no longer processed within the networking interrupt thread. Also not a
> > DDoS kind of situation where one could want to delay processing.
> >=20
> > With that change, this isn't the case anymore. Only an "unrelated" IRQ
> > thread could pick up the networking work which is less then ideal. That
> > is because the global softirq set is added, ksoftirq is marked for a
> > wakeup and could be delayed because other tasks are busy. Then the disk
> > interrupt (for instance) could pick it up as part of its threaded
> > interrupt.
> >=20
> > Now that I think about, we could make the backlog pseudo device a
> > thread. NAPI threading enables one thread but here we would need one
> > thread per-CPU. So it would remain kind of special. But we would avoid
> > clobbering the global state and delay everything to ksoftird. Processing
> > it in ksoftirqd might not be ideal from performance point of view.
>=20
> Before sending this to the ML, I talked to Paolo about using NAPI
> thread. He explained that it is implemented per interface. For example,
> for this specific case, it happened on the loopback interface, which
> doesn't implement NAPI. I am cc'ing him, so the can correct me if I am
> saying something wrong.

It is per NAPI-queue/instance and you could have multiple instances per
interface. However loopback has one and you need per-CPU threads if you
want to RPS your skbs to any CPU.

We could just remove the warning but then your RPS processes the skbs in
SCHED_OTHER. This might not be what you want. Maybe Paolo has a better
idea.

> > > Cheers,
> > > Wander

Sebastian
