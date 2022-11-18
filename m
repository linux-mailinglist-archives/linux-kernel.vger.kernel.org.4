Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4296A62EADB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbiKRB2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiKRB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:28:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0116D4A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:28:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668734887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/uOAq27HWepm1hqB8gGgqIddmHBWCv9QGtuYTUirTs=;
        b=q0hJEFCUuVnEFgYt8eI169Sk/RNEe5RVFfu9GMLK45iva/WlxD2u31XMFTFhfNHPrNKoFJ
        oYrt5mSAPgBiPeK/pyafTN6JsOV7C7mJQqyMglCVI88oaIM8qbYp5FjqGkO/JJkksMWEsi
        NcuKMOoPWaqSBm39BhAUqM8iRjW++S+feBkY3KQSSFdw6W2EA08Hj1No2fRScn/ZtAS6bW
        50gUVfp8F5LhqHiVWY2BhcJKgpnyTjaMGNulZ7mDxkjvL+vFpc2rzsQbzChZBe4YQvdwq4
        zgvnAPe+U04MpMhxTJ3qJzJVEu8JAUy/jhFzDpSTmQGok64cE0Sm12qORkx6Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668734887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/uOAq27HWepm1hqB8gGgqIddmHBWCv9QGtuYTUirTs=;
        b=Qj0CgMXy+F/yZi3h3s8cXHKYflU50c/Mi+oOS9LLwuXRXuoCWvpR8VFEePibs/ilnOxi/D
        rWxonOSABAHfEwDw==
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 18/46] entry, lto: Mark raw_irqentry_exit_cond_resched()
 as __visible
In-Reply-To: <289e03d2-be50-4249-343a-75dae302b0e5@linux.intel.com>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-19-jirislaby@kernel.org> <87a64qo4th.ffs@tglx>
 <Y3XzkxNVTvdB4a/1@hirez.programming.kicks-ass.net>
 <289e03d2-be50-4249-343a-75dae302b0e5@linux.intel.com>
Date:   Fri, 18 Nov 2022 02:28:06 +0100
Message-ID: <8735ahkq55.ffs@tglx>
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

On Thu, Nov 17 2022 at 14:07, Andi Kleen wrote:
>> Anyway; I think we can drop all this crazy on the floor again, since per
>> the 0/n (which I didn't get) there isn't any actual benefit from using
>> GCC-LTO, so why should we bother with all this ugly.
>
> At least in the past it generated smaller kernels for small configurations.
>
> One benefit that wasn't mentioned is doing type and other checks (e.g. 
> constant propagation
>
> through inlining) across files.
>
> In general LTO gives the compiler a lot more freedom to optimize code, 
> so even if it's not quite there
>
> yet I think it's beneficial to let users play around with it and see if 
> they can get benefits.

Sure, they can play around with it but that does not require to merge
all this nonsensical ballast for a half thought out compiler.

If they want to do that they can apply the pile of patches as provided
and play around.

If anything useful comes out of that with sensible changelogs and a
sensible argumentation why supporting a half thought out compiler is
required then we can revisit that.

Up to that point this is all considered to be __invisible.

Thanks,

        tglx
