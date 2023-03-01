Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0416A734B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCASSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCASSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:18:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BFB44BF;
        Wed,  1 Mar 2023 10:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8B98B810DB;
        Wed,  1 Mar 2023 18:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4ABC433D2;
        Wed,  1 Mar 2023 18:18:34 +0000 (UTC)
Date:   Wed, 1 Mar 2023 13:18:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Message-ID: <20230301131831.6c8d4ff5@gandalf.local.home>
In-Reply-To: <CAFULd4YePGAqxpq0kJMnNHkqqkL9HEnEz1ud9kNrae5wqpRVbA@mail.gmail.com>
References: <20230228175929.7534-1-ubizjak@gmail.com>
        <20230228175929.7534-4-ubizjak@gmail.com>
        <20230228164346.0691bb11@gandalf.local.home>
        <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
        <20230301111850.768f8526@gandalf.local.home>
        <CAFULd4YePGAqxpq0kJMnNHkqqkL9HEnEz1ud9kNrae5wqpRVbA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 18:16:04 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> > It's different, but I'm not so sure it's beneficial.  
> 
> This is the place we are looking for. Please see that a move at $1464
> and a compare at $1473 is missing in the assembly from the patched
> code. If it is beneficial ... well, we achieved the same result with
> two instructions less in a loopy code.

Note, none of these locations are in fast paths. (now if we had a
local_try_cmpxchg() then we could improve those locations!).

Thus my main concern here is for correctness. Unfortunately, to add a
cmpxchg_success() would require a lot of work, as all the cmpxchg()
functions are really macros that do a lot of magic (the
include/linux/atomic/atomic-instrumented.h says its even generated!). So
that will likely not happen.

I have mixed feelings for this patch. I like the fact that you are looking
in optimizing the code, but I'm also concerned that it could cause issues
later down the road.

I am leaning to just taking this, and hope that it doesn't cause problems.
And I would really love to change all the local_cmpxchg() to
local_try_cmpxchg(). Hmm, I wonder how much of an effort that would be to
implement those?

-- Steve
