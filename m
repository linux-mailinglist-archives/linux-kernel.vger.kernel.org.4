Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF948645B67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLGNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiLGNvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:51:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0478F59172;
        Wed,  7 Dec 2022 05:51:04 -0800 (PST)
Date:   Wed, 7 Dec 2022 14:51:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670421062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mx4FrQXn0z6frpjJL58zvvJiiJEsdejNIy8r20RlzLQ=;
        b=fhgAF5VZ5RbrnyyxU0aLj2zyfMX8TDZrLvDtt1Pfl/zXnfX+CyjTaeb48aF94viXyU3fmS
        BCd5+JK1eB37TzHrTbikq4iMcZFsGYFBc8NbT2FhJhS8L34ZQoIQUFOzx0Ml8RauAyIC+5
        AIpiyAjb1sNI8hAHR+9IUG0BUYeBmlDxaRcYWpR1S2LPr0lgID6/xsmTI9rhpJ2qGPRY1I
        rSS9Yx6vLEafwaxND8dtZSYDua0maa+csYfmaENgRv4GLNNjLf0py0bIoAfiiDR2rPDuFx
        PrM3Y2+rU0M30IxYm2GEjJvuinB8E9a/zZpHwBipK5bhkO9Jbfmj1DGzV7m3Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670421062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mx4FrQXn0z6frpjJL58zvvJiiJEsdejNIy8r20RlzLQ=;
        b=VwIcAmFoune3EAEcU8UR0VM73wCNNZtNGlfDDIxvunb7L/LBZoFywPpsPDgWsYlJp0vTHC
        9suybCGfH4tlsbDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/highmem: Add notes about conversions from
 kmap{,_atomic}()
Message-ID: <Y5CaRLtwaYXXlGYS@linutronix.de>
References: <20221206070029.7342-1-fmdefrancesco@gmail.com>
 <2093077.OBFZWjSADL@suse>
 <Y5BIHdnP4yeJ8svL@linutronix.de>
 <2130641.irdbgypaU6@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2130641.irdbgypaU6@suse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-07 14:01:50 [+0100], Fabio M. De Francesco wrote:
> > > If so, I understand and I again agree with you. If not, I'm missing
> > > something; so please let me understand properly.
> > >=20
> > > Aside from the above, I'm not sure whether you deleted the last phrase
> > > before
> > > your suggestion. What about making it to become "For the above-mentio=
ned
> > > cases, conversions should also explicitly disable page-faults and/or
> > > preemption"?
> >=20
> > They need to disable preemption or page-faults or both if it is needed
> > (not unconditionally) and where it is needed. This means not
> > unconditionally over the whole kmap-ed section.
>=20
> I never meant to suggest to _unconditionally_ disable page-faults=20
> and/or preemption. I was only trying to say that developers must carefull=
y=20
> check whether or not the whole kmap-ed section depended on those side eff=
ects.

I know. That are the two condition that should be checked/ kept in mind
while replacing the code. Maybe I read it wrongly=E2=80=A6

> If so, they must _explicitly_ disable preemption or page-faults or both=
=20
> together with the use of kmap_local_page().

Right. The requirement for it should be probably documented in case it
is not obvious. For PREEMPT_RT it will become a problem if the preempt
disabled section additionally acquired a spinlock_t or allocated memory.=20
So ideally it won't be used ;)

>                                             Instead, if the section doesn=
't=20
> depend on preemption and/or page-faults disabling, they must only replace=
=20
> kmap_atomic() with kmap_local_page().

Correct and I assumed that you know all this.=20

> I had probably used a bad wording when trying to say the same things that=
 you=20
> wrote much more clearly.

Write it as you wish I just made a recommendation. If the wording is
crystal clear then there is less room for interpretations.

> Thanks,
>=20
> Fabio

Sebastian
