Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5116288F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiKNTNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiKNTNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:13:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4091121B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:13:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668453209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFCYO0bHRjcTvTpGq7Vtp1Hadc8JaC4bd6BEg7uPrUI=;
        b=qy4tO0G3Qi1Pg5D9LFujaCRXcIZKIhfDx/gcptOcXGs6+olhHaQSM+jWNNKyt4Hi4QA40h
        Tr2zggcWgrRMsaiVfaAio0hT2coNAAPmlgHIwVGDH95z+LDKZtmKb+BBVh/M9aklbxlOOL
        zD0erMcPBRLfkJADUHtvGOOb2rujmrbzPr5GOXFvTeyv9kOBSsfVxHz0Hu+ogU0dmyDuSb
        HUngwg/2q51ExjxSlP5q2jQb4XVReGoZQXwfVyxYqTeCMVq13zxrHu6LURU/7pDunQPtbX
        67DLpoMVFLImUJAhwLlUtnG+JOUZ1WKm/QRLdFGZ2IYTHNnnUTX3eyqLD+g6lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668453209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFCYO0bHRjcTvTpGq7Vtp1Hadc8JaC4bd6BEg7uPrUI=;
        b=hLSUTQSx6QFc0Gy8gZsbDQ+mzl/nrLiRYGvjLxAZ6l5v39AxzG9rIQGYtBn6PBKiur8/Eu
        SSfCMHRQ1ZGXhsCg==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
In-Reply-To: <20221114083635.60e23559@gandalf.local.home>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.343514404@goodmis.org> <875yfitpdu.ffs@tglx>
 <20221113191518.0a3b29b1@rorschach.local.home> <87sfims7ca.ffs@tglx>
 <20221114083635.60e23559@gandalf.local.home>
Date:   Mon, 14 Nov 2022 20:13:28 +0100
Message-ID: <87bkp9s61z.ffs@tglx>
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

On Mon, Nov 14 2022 at 08:36, Steven Rostedt wrote:
> On Mon, 14 Nov 2022 01:33:25 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>    https://lore.kernel.org/all/87v8vjiaih.ffs@tglx/
>> 
> I'm not sure what you mean by that. The idea is that once timer_shutdown()
> is called, we still warn on re-arming the timer.

That's the whole point. As Linus and I discussed in that thread:

   "That would mean, that we still check the function pointer for NULL
    without warning and just return. That would indeed be a good argument
    for not having the warning at all."

and as I demonstrated you on the example of the BT driver which you
"fixed" this is the only sensible way to handle this.

The warning does not buy us anything, unless you want to go and amend
all the usage sites which trigger it with 'if (mystruct->shutdown)'
conditionals.

It's very similar to the work->canceling logic for kthreads that Linus
mentioned in this thread which prevents that the work timer is rearmed
concurrently. The difference is that timer_shutdown() is a final
decision which renders the timer unusable unless it is explicitely
reinitialized.

But that's mostly a matter of documentation and it has to be made clear
that nothing in a shutdown path which has the BT pattern:

     timer_shutdown();
     destroy_workqueue();

relies on the timer being functional after the shutdown point. I'm
pretty sure that the vast majority of such use cases do not care, but
given the size of the driver zoo I'm also sure that you'll find at least
one which depends on the timer working accross teardown.

Thanks,

        tglx




