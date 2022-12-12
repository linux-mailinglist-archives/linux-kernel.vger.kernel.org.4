Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC45649D05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiLLLGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiLLLGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:06:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59961DE8E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:51:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670842312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BI75jv3SojWdWnJhQdL7/zcp5WoGBOdCS/w2y9xGd0A=;
        b=CJNV6mE5L+J0e96mYgBNQRLLytrm5pqk8dxVjabjBSMvLed9dV/vaAWDkI364S5izbcPUK
        SAv71ixz1b8mF4zj7WIUqrdarW3ZP7Vqkg9Nb4D5jaqtg34WQPbOst7ZRF48cQSih0d3eg
        MPTsxIqAcofJpVhXqPwlgxx/wKdrel7mRUKM5iDngN83CizMhYWiOqp3q6FuAtHYe/zam/
        c3WxiZnWxYc5fpTHpFzzj+hVQVPUcf5xdHlFB2+QN0OoLt1gLKEEleP6qnYAa5jfJz2niF
        c+GFZ7X75vJNRGGy7O/3ZFhzeXv7WwnhtgOF2pQ/qGMoLhN1sgOhw2SE+MNVNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670842312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BI75jv3SojWdWnJhQdL7/zcp5WoGBOdCS/w2y9xGd0A=;
        b=DFYzBEIKApdUePhD9qtYDChQiG/aZShwvkMTbHqfAUI3gaGOvyUvWhY30pJyfD5MsiJRBE
        LvqvyJcHFPAFrhDw==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [for-next][PATCH 13/25] x86/mm/kmmio: Use
 rcu_read_lock_sched_notrace()
In-Reply-To: <20221210185555.7abc4de4@gandalf.local.home>
References: <20221210135750.425719934@goodmis.org>
 <20221210135825.241167123@goodmis.org>
 <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <20221210133425.4657985e@gandalf.local.home> <87359mdeg3.ffs@tglx>
 <20221210185555.7abc4de4@gandalf.local.home>
Date:   Mon, 12 Dec 2022 11:51:51 +0100
Message-ID: <87wn6wc2t4.ffs@tglx>
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

On Sat, Dec 10 2022 at 18:55, Steven Rostedt wrote:
> On Sun, 11 Dec 2022 00:30:36 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> I concede that there are hot paths which actually can benefit, but this
>> code has exactly _ZERO_ benefit from that. Taking that tracing exception
>> and handling it is orders of magnitudes more expensive than a regular
>> preempt_enable().
>> 
>> So just get rid of it and don't proliferate cargo cult programming.
>> 
> The point of the patch is to just fix the lockdep issue. I'm happy to
> remove that "no_resched" (I was planning to), but that would be a separate
> change, with a different purpose, and thus a separate patch.

Right, but please make that part of the series.

Thanks,

        tglx
