Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5134863A4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiK1JZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiK1JZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:25:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9403CC59;
        Mon, 28 Nov 2022 01:25:33 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669627531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzfUYrqVvJQIGgcRMIOY/c4k5K9QDq4xHL6fNLFlt4I=;
        b=vFlaGgqTq4SSxWVW9zjseTZNcJEtNK9yLI0h/G4LglDwd2N7LUgKp1vKi4zjOtNPabn/zM
        eKu7ntMUxfC7KuniqlX5bvzSe9atRWpOh+jzQSIFnS18ilXmBsCK37x4Hb0joDTcDkIRhw
        VRJj8F5PdNFYvGpXdqmNlNl4Qs0ArIM/z+NAosC2y1X7hrBxf7NNAV6kpq6UBPic3M2SSJ
        PepAVY/z+EZrUrHQsnG5FGQf3jCyiMzsXFNALme5lGOIYz5pFUfrw+7Wr8BRnzpeH0AXD+
        tDMpjg0fyL0EsmMlWc4O1IlutVVDVVZAezq9nFrfDyPC9AsSD3kQCmdGN2XnSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669627531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzfUYrqVvJQIGgcRMIOY/c4k5K9QDq4xHL6fNLFlt4I=;
        b=RWiPwXFcsMegNyR14z4aHc9KTk+n4lRAcBTWyVvxOKEN4nJ5k0ru2sJBdWe73CW4gV8W15
        t+Kl7rTGr0wWiUBQ==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 2/3] random: introduce generic vDSO getrandom()
 implementation
In-Reply-To: <Y4PcLi8c010MEfTA@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-3-Jason@zx2c4.com> <877cziy7zg.ffs@tglx>
 <Y4PcLi8c010MEfTA@zx2c4.com>
Date:   Mon, 28 Nov 2022 10:25:31 +0100
Message-ID: <87lenvwhv8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason!

On Sun, Nov 27 2022 at 22:52, Jason A. Donenfeld wrote:
> On Fri, Nov 25, 2022 at 11:39:15PM +0100, Thomas Gleixner wrote:
>> If you really need anything from fs.h then please isolate it out into a
>> separate header file which is included by fs.h and here.
>
> Hm. I need MAX_RW_COUNT from linux/fs.h. I could just hardcode `(INT_MAX
> & PAGE_MASK)`, though, if you'd prefer, and leave a comment. I'll do
> that. Or I could move MAX_RW_COUNT into linux/kernel.h? But maybe that's
> undesirable.
>
> So:
>
>     ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
>
> I'll do that, if it's okay with you. Or tell me if you want me to
> instead move MAX_RW_COUNT into linux/kernel.h.
>
> Also, if I remove linux/fs.h, I need to include linux/time.h in its
> place, because vdso/datapage.h implicitly depends on it. Alternatively,
> I could add linux/time.h to vdso/datapage.h, but I don't want to touch
> too many files uninvited.

Actually the minimal includes are those:

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -8,8 +8,9 @@
  * 32 Bit compat layer by Stefani Seibold <stefani@seibold.net>
  *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
  */
-#include <linux/time.h>
+#include <linux/cache.h>
 #include <linux/kernel.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 #include "../../../../lib/vdso/gettimeofday.c"

>> > +	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);
>> 
>> Where is the sanity check for state->pos <= sizeof(state->batch)?
>
> That condition cannot happen. "Does the compiler or some other checker
> prove that as part of the development cycle?" No, unfortunately. So what
> would you like to do here? Per Linus' email on an unrelated topic [1],
> "We don't test for things that can't happen." And there's no
> WARN_ON/BUG_ON primitive that'd be wise to use here -- nobody wants to
> emit a ud2 into vDSO code I assume. So what would you like? For me to
> add that check and bail out of the function if it's wrong, even if that
> should normally never happen? Or adhere to the [1] more strictly and do
> nothing, as is the case now? I'll do what you want here.

I think we can do without any further checks. If the callsite fiddles
with state then the resulting memcpy will go into lala land and the
process can keep the pieces.

Thanks,

        tglx
