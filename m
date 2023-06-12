Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0772CC55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjFLRXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjFLRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:23:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63571A5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:23:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686590600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ndr+IFVihX0wTQU0pRCS9MpzNfxeaUdLr88C71hGhcQ=;
        b=towGF8UnI2SFEkIU8GuVBcblSZQWc6ulxnxIUepyUxoo4WAZmsRfSzAmW/q8BCUsxKasQd
        SI7Ome+hLhcv89291jftUd6Q/G28oOQjIr+jOkC0BsGzXvEBcnJnRwQV9/mqEYG/FV94XH
        tNgAc02i5ZRf5QcO2SswEJo38CWOz9nIM7RRU0c+luRszvxkkwLxy89jXkuMFExnnssWgI
        l6jqynSz4Qd0U9ewT6COoXLMdXVWzCD75eiNkWtNllpCjSObp7o6jheF4KbUruAPjDMAai
        rS9V7CvnaFA8Q0EGnUxt1U1Bo6WjIHroWxPKpYY/u/ldtcWRh56ichWTDDE8cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686590600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ndr+IFVihX0wTQU0pRCS9MpzNfxeaUdLr88C71hGhcQ=;
        b=hZr4vTHJmXO4fadtmAH4KWflFF8oByuhcpwFqQo/3Fk59b9Xj7DmMObGkNVNtgBrUPARCv
        roWXQKAnVDUhmJAg==
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
In-Reply-To: <20230612154246.GLZIc89v6Q2THgsY8N@fat_crate.local>
References: <20230605141332.25948-1-bp@alien8.de>
 <20230605141332.25948-2-bp@alien8.de> <87ilbs7lcr.ffs@tglx>
 <20230612154246.GLZIc89v6Q2THgsY8N@fat_crate.local>
Date:   Mon, 12 Jun 2023 19:23:19 +0200
Message-ID: <87a5x47fy0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12 2023 at 17:42, Borislav Petkov wrote:
> On Mon, Jun 12, 2023 at 05:26:28PM +0200, Thomas Gleixner wrote:
>> Why is it suddenly required to prevent late loading on SMT threads?
>
> The intent is, like a chicken bit, to revert to the *old* behavior which
> would not load on both threads. In *case* some old configuration of CPU
> and microcode cannot handle loading on both threads. Which is from
> Bulldozer onwards but I don't think anyone uses Bulldozer anymore.

So why not making the late loading thing depend on >= bulldozer?

Also I'm failing to see how this is different from the early loader:

>> That's the exact opposite of what e7ad18d1169c ("x86/microcode/AMD:
>> Apply the patch early on every logical thread") is doing.

That changelogs says:

  "Btw, change only the early paths. On the late loading paths, there's
   no point in doing per-thread modification because if is it some case
   like in the bugzilla below - removing a CPUID flag - the kernel cannot
   go and un-use features it has detected are there early. For that, one
   should use early loading anyway."

which makes sense to some extent, but obviously there is a use case for
late loading on both threads. So what are you worried about breaking
here?

If the late load does a behavioural change, then it does not matter
whether you make sure both threads are hosed in the same way or not. If
the late load is harmless and just addressing some correctness issue
then loading on the secondary thread should be a noop, right?

> No, see patch 1 - it does exactly the same what this commit does but for
> late loading.

Sorry no. Patch 1 brings the late loading decision in line with the
early loading decision, i.e. ensure that microcode is loaded on both
threads. That condition

	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (rev > mc_amd->hdr.patch_id) {

really could do with a proper comment which explains why loading the
same revision makes sense.

> Bottomline: on AMD, we should load on both threads by default.

Fine. Then what is this about? If it survives early loading on both
threads then why do we need a chickenbit for late loading?

So if someone turns that on needlessly then in the worst case the
primary thread behaves differently than the secondary thread, right?

>> Aside of that why is this a kernel side chicken bit and not communicated
>> by the microcode header?
>
> See above. This chicken bit is there, just in case, to help in the case
> where the user cannot do anything else. It should not be used, judging
> by all the combinations I've tested here.

If it should not be used, then where is the big fat warning emitted when
it is actually enabled?

The more I read this the less I'm convinced that this makes any sense at
all:

  1) You did not add a chicken bit when you made this change for the
     early loader. Why needs late loading suddenly one?

  2) Late loading is "use at your own peril" up to the point where the
     minimum revision field is in place. So why do we need a bandaid
     chickenbit for something which is considered unsafe anyway?

  3) The microcode people @AMD should be able to figure out whether
     unconditionally (late) loading on the secondary thread is safe or
     not.

I told Intel to make microcode loading something sane. It's not any
different for AMD. This hastily cobbled together chickenbit thing
without a fundamental technical justification definitely does not
quality for sane.

>> Why ULL bits for a unsigned long variable?
>
> There's no BIT_UL() macro.

git grep '#define BIT(' include/

Thanks,

        tglx
