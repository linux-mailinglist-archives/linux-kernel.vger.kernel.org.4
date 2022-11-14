Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682756289E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiKNTyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiKNTyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:54:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79534B39
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:54:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668455654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1EggVRVm0nioc+pWMxnSMEbvb3Nb3DHvMkPt+H9FP0=;
        b=S1beXo0HJFFk8FF0ct/xaMsp3NCjpBGP/7m1W8ufK85DgBYOib+E3Wq99yq85DAQsqlaTI
        IpCOCw/c+VM5a2+1UKRP1Gi0I/O4FFfN88/CMDB8uWi7dzW5M6ACCg6KRa/6i1BzhUhYSt
        +i6wCNrMtKUR7WxyP+FiCVgiBflfG2RZCm2sep11nF9Ug9D+CrLX3/43K/4vYjfoDymiCa
        iF9bx4xX/60ZkQE+2xym521rmH2i5Ksati4ko390buxVRTen6M7qhct9qOzdSrWRvPZu69
        +ifgZ/bvCuqfcgXQYOk2M3XdXbDES7uZRo/dc1UahMWThJh3yEdSVjoLo7jAyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668455654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1EggVRVm0nioc+pWMxnSMEbvb3Nb3DHvMkPt+H9FP0=;
        b=Ntd4Kviz/ogS/PWkJdBPWnJMqaxRbn2Y1vm3xLIU/VWvv4h3EK8QAIypcMDZitZg024ui5
        UtObFJkEEE65P9CQ==
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
In-Reply-To: <20221114142858.59682a42@gandalf.local.home>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.343514404@goodmis.org> <875yfitpdu.ffs@tglx>
 <20221113191518.0a3b29b1@rorschach.local.home> <87sfims7ca.ffs@tglx>
 <20221114083635.60e23559@gandalf.local.home> <87bkp9s61z.ffs@tglx>
 <20221114142858.59682a42@gandalf.local.home>
Date:   Mon, 14 Nov 2022 20:54:13 +0100
Message-ID: <8735als462.ffs@tglx>
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

On Mon, Nov 14 2022 at 14:28, Steven Rostedt wrote:
> On Mon, 14 Nov 2022 20:13:28 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> The warning does not buy us anything, unless you want to go and amend
>> all the usage sites which trigger it with 'if (mystruct->shutdown)'
>> conditionals.
>
> The rationale for the warning was that it would let us know what drivers
> need to be fixed for older kernels without the shutdown state. I'm
> perfectly fine in removing the warning. We may just add it to the field
> kernels so that we can know if there's any drivers that have issues that we
> need to look at.

The warning is not guaranteed to catch the subtle cases. It might happen
once in a blue-moon.

I rather argue that (once we agreed on the semantics) we should backport
timer_shutdown() and the fixes which we add to Linus tree. Searching for
potentially problematic places is a job for Coccinelle, though fixing
them needs to have deep human inspection.

Backporting the core code and the corresponding fixes is way simpler
than identifying the problematic cases via the unreliable warning and
then coming up with a per driver solution by sprinkling 'if
(in_shutdown)' conditionals all over the place.

Thanks,

        tglx
