Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8E63F396
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiLAPSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLAPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:18:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD959A47E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:18:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669907907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SrY7hzYfEOK2q/hdFn3ec4v1Q9N6ZIdTKpdo+YTUPKo=;
        b=RbknPhJBPVpMo1//GiCZjwdQyCkwD0stL5GKaoffCL8JRnSH5hht8sb0rsMvY0VeBd9Mld
        YIQ8vsB5XUfR6eViBeq9W+7+TfW6j5gN7Ry7WiOzl2bqxXLVIgtQBzTjpTuc2K4ExKc6wL
        C+bLyiGLoBmHf56QZWMjSZlha0aFPQu6mMCE7c0V6OOD31t+AHgI+MC/aNSviKQDkJCtKN
        f9EAysLK6DFEXt8inuXRRHui+7K5EQG1Z/eO+epyjy6sBuT3LiugmM9IaAtZJAB4PwJP16
        QzauIN+7dJjgeGHLxTVvmS7a1ITTCOUlzxjdo1nSXIo6bv6GSuV8a3QCCcycug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669907907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SrY7hzYfEOK2q/hdFn3ec4v1Q9N6ZIdTKpdo+YTUPKo=;
        b=CQKEg9q1ssDtf5cTVF2u8o281141q5m9o2muF6ytphftb3OzXscPMnTD+XGbAIj6zycKXS
        uMxy06J1nsP4XBBQ==
To:     Jake Macneal <jake.macneal@gmail.com>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, arnd@arndb.de
Subject: Re: [PATCH] time: copy tai value (International Atomic Time, in
 seconds) to output __user struct in get_old_timex32().
In-Reply-To: <CAHn5w+piDmr2iJGo74BCOW6QApEgJmd0p2Z0TZgxU3X6PiJiAA@mail.gmail.com>
References: <20221121055345.111567-1-jake.macneal@gmail.com>
 <877czbs0al.ffs@tglx>
 <CAHn5w+piDmr2iJGo74BCOW6QApEgJmd0p2Z0TZgxU3X6PiJiAA@mail.gmail.com>
Date:   Thu, 01 Dec 2022 16:18:26 +0100
Message-ID: <87y1rrqhj1.ffs@tglx>
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

Jake,

On Thu, Dec 01 2022 at 10:00, Jake Macneal wrote:
>>> This is despite all other fields of the corresponding __kernel_timex
>>> struct being copied to the old_timex32 __user struct in this function.
>
>> This is completely backwards. get_old_timex32() copies from the user
>> supplied old_timex32 struct to the __kernel_timex struct, no?
>
> You're totally right, I managed to mix up the order right off the bat.
>
>> I'm not against this change per se, but the justification for it really
>> boils down to:
>
>>     Make it consistent with the regular syscall
>

> I agree, that's a better summary. There isn't any effect in the kernel
> now due to get_old_timex32() ignoring the tai value from userspace. So
> this patch would be purely aesthetic, although one might argue that
> copying the userspace tai value into txc is also less likely to lead
> to a bug in the future, were any of the functions do_adjtimex(),
> __do_adjtimex(), or process_adjtimex_modes() to be changed in a way so
> that the userspace tai value became used (I realize this is unlikely).

Right. Unlikely or not, consistency is always a good thing.

> I apologize for any confusion I caused.

No problem. Been there, done that :)

Thanks,

        tglx
