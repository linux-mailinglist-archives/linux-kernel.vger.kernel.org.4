Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C425961FE82
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiKGTXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiKGTXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:23:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDA82A977;
        Mon,  7 Nov 2022 11:23:04 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667848982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7p/ayoMYEZOszbj3azJd/UmvgO45YhgQaQ55gMey2Wg=;
        b=Hu555M8XWA2JR5fR4ULUmSBdajYRaNog6UPBDrFxFI5SwDhkZ6d10+KvDyuU55BlDNXsn/
        jgP2XasxN9Qr9gVSeJ24smKD96wXRz979jRcXAOZtBYpL6l1Qiz8oxCSy0a5vnwJFN9yWc
        qAx4e476rEe9l/ndCPKqduQIAIcaIWycicuR+iiQlSQvAwKgP1IEj0EUcGSwUamF/BWiIl
        Q8qnUr3m8zGF3WAknHCvtmoimiMB5fCw8mmjCPkBUllgsMqr8atUZKexsmBr16SR5PWoRQ
        TpRiDtFKTp/fLNI2SFDqbGe8fcR7ETrLqsE6FYotyHM8FtquIB4b13ANbdZAbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667848982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7p/ayoMYEZOszbj3azJd/UmvgO45YhgQaQ55gMey2Wg=;
        b=QAQ/Cd1Q+ZF4t2ZrTw0dxibL2qK67/oBAGjz/mqBdH9RqH/FK31sBkiBTp74rqBdPa66EK
        JYHm0UiEuxjjSQCg==
To:     paulmck@kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v3 01/40] rcu: implement lockdep_rcu_enabled for
 !CONFIG_DEBUG_LOCK_ALLOC
In-Reply-To: <20221107180157.GL28461@paulmck-ThinkPad-P17-Gen-1>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-2-john.ogness@linutronix.de>
 <20221107180157.GL28461@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 07 Nov 2022 20:29:01 +0106
Message-ID: <87h6za602y.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-07, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> Provide an implementation for debug_lockdep_rcu_enabled() when
>> CONFIG_DEBUG_LOCK_ALLOC is not enabled. This allows code to check
>> if rcu lockdep debugging is available without needing an extra
>> check if CONFIG_DEBUG_LOCK_ALLOC is enabled.
>> 
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>
> If you would like me to take this one, please let me know.

Yes, it would be great if you would carry this in the rcu tree. This
printk series is already relying on the rcu tree for the NMI-safe
work. Thanks!

John
