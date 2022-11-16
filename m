Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A762CD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiKPV5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiKPV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:57:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D72617E;
        Wed, 16 Nov 2022 13:57:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668635837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9L+zEqSpNA5Jp91IUNwLWWPcTldTbJ3Yh/ZXwlMJ7o=;
        b=YYu6UTIRbqPBau5Ut/qwkKhGLGNNsed5hymlWTKsUnRKhWBVJ/gDGsZXPpF55LxrASkVvh
        Wujj2Y2pi2j8epnr8ybwtw1Hv0qguEnGOvmtNi0+A3/evsop9u38jtUnxKHnxYdzCcsOvq
        amdJRSNyRSXJdBMsanV5ULVbm2BNx2uDlexEyPNF+kxIu9VLhVP76UXjS54MDysa84qypf
        A0wv24asxIz5LWKD8c8n+AaVhoFr33jAVWhnA2W23I4m2WSI+Axv/gexOjQXyEPC5MKV9c
        moLly4Wta9YJWx/VJym62o35wd4GrZ9ZHdCKv1BRwXJ5NsbCTofnAO467LJlNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668635837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9L+zEqSpNA5Jp91IUNwLWWPcTldTbJ3Yh/ZXwlMJ7o=;
        b=loO4HQQDMPAIHiHMQbzc/fsfbK3p6w/MAh9ZDtvehmncrUf11IE91XKIjT2rGuSBaAELvq
        5RAXM8xKUOACZcAw==
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
In-Reply-To: <CAPj211tkReuuqyi8w2dFvrz3MFgmVFgnheDJbJ25_gCBvZX7VA@mail.gmail.com>
References: <20221115161627.4169428-1-kristen@linux.intel.com>
 <CAPj211ugzBFJHgDNtSgR2zB7ZcGa_EqOAQGhFSu938718u+yMQ@mail.gmail.com>
 <87cz9nqff2.ffs@tglx>
 <CAPj211shRbJQcnhEpjs461nEMQw2x53f+2G46CXWJg6_Rc-x-g@mail.gmail.com>
 <Y3UcLudVzuS55Bp5@iweiny-mobl>
 <CAPj211tkReuuqyi8w2dFvrz3MFgmVFgnheDJbJ25_gCBvZX7VA@mail.gmail.com>
Date:   Wed, 16 Nov 2022 22:57:16 +0100
Message-ID: <87zgcqo94z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2022 at 21:00, Fabio M. De Francesco wrote:
> On mercoled=C3=AC 16 novembre 2022 18:21:50 CET Ira Weiny wrote:
>> > Despite I suppose that nobody should rely on those kmap_atomic() side
>> > effects, I have been observing that a large part of the users of the
>> > Highmem API used to call kmap_atomic() for its implicit
>> > pagefault_disable()
>> > and preempt_disable() side effects.
>>
>> Fabio I think you missed the point here.  Just because we have found _so=
me_
>> places where the side effect was required does not mean that "a large pa=
rt
>> of the users..." do.
>
> You are right. Numbers don't support that "a large part of the users..." =
but
> that it happened and will happen again.

There is a fundamental misconception here. You argue about requirement
instead of dependency. Those are absolutely not the same.

Technically there is no requirement at all to use kmap_atomic().

kmap_atomic() in it's original implementation had the requirement of
disabling preemption to protect the temporary mapping. kmap_atomic()
is nothing else than a conveniance wrapper:

   preempt_disable();
   establish_mapping();

and later on when pagefault_disable() was separated from
preempt_disable() it became:

   preempt_disable();
   pagefault_disable();
   establish_mapping();

which is again technically not required at all.

It was done because there were usage sites where the implementation of
the kmap_atomic() section _depended_ on the implicit pagefault_disable()
of preempt_disable(). So the pagefault_disable() was added in order not
to break these usage sites.

But did any of the usage sites have a hard technical requirment to have
pagefaults or preemption disabled by kmap_atomic(). No. Not a single
one. All of them could have been converted to disable preemption and/or
pagefaults explicitely.

The implementation dependencies are a consequence of the original
kmap_atomic() implementation and not the other way round.

There is no single context where the implicit preemption and pagefault
disable of kmap_atomic() is required due to the context itself.

If there is code which runs, e.g. with interrupts disabled and needs a
temporary mapping which is then used for a copy to user operation, which
can obviously fault, then there is still no requirement for
kmap_atomic() to disable preemption or pagefaults.

The requirement to disable pagefaults comes from the
copy_to_user_inatomic() which is in turn necessary because the code runs
with interrupts disabled.

So now we have kmap_local() which does not rely on preemption disable
anymore because the protection of the temporary mapping is done
differently.

So you can convert any instance of kmap_atomic() over to kmap_local(),
but you have to analyze whether any code inside the mapped section
requires protection against preemption or pagefault handling.

If there is code which requires that, then you have to figure out
whether that code has been written in that way due to the semantics of
kmap_atomic() or if there is a different requirement for it.

In the previous example I gave you vs. copy_to_user_inatomic()

again:
    kmap_atomic();
    remaining =3D copy_to_user_inatomic();
    kunmap_atomic();
    if (remaining) {
	if (try_to_handle_fault())
	    goto again;
	ret =3D -EFAULT;
    }

is clearly no requirement neither for preemption nor for pagefault
disable. The semantics of kmap_atomic() enforced to write the code this
way. The replacement code:

    kmap_local();
    ret =3D copy_to_user();
    kunmap_local();

is completely equivalent. It can be written this way because
kmap_local() has no implicit side effects which prevent using
copy_to_user() which in turn can fault, handle the fault ...

This is all about implementation details which depend on the original
kmap_atomic() semantics and have been enforced by them.

E.g. something like this:

    kmap_atomic();
    smp_processor_id();
    kunmap_atomic();

has a dependency, but not a requirement.

    kmap_local();
    preempt_disable();
    smp_processor_id();
    preempt_enable();
    kunmap_local();
=20=20=20=20
is completely equivalent and it makes it entirely clear why preemption
needs to be disabled: because smp_processor_id() requires it.

There are only the three classes of usage sites which are affected:

   1) The code which is enforced to be stupid because of kmap_atomic()

   2) The code which (ab)uses the side effects of kmap_atomic()

   3) The combination of #1 and #2

All of them can be replaced by functionaly equivalent code.

There is not a single usage site which has a hard requirement on the
kmap_atomic() semantics due to the context in which kmap_atomic() is
invoked.

Ergo _ALL_ usage of kmap_atomic() and related interfaces can be
eliminated completely.

Claiming that even a single place

>> > used to call kmap_atomic() for its implicit pagefault_disable() and
>> > preempt_disable() side effects.

belongs into fairy tale territory, but has nothing to do with technical
reality and facts. Why? Simply because there was no other solution to
handle highmem in a hotpath or in a non-sleepable context.

Ergo developers were forced to use kmap_atomic() and then obviously had
to accomodate the code in the mapping section. Of course they utilized
the side effects because that's what we do with spinlocks and other
primitives as well.

So can we just go and fix these places instead of indulging in
handwaving and bikeshedding?

Thanks,

        tglx








