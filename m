Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7563B629D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiKOPSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiKOPR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:17:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB212982C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:17:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE48261867
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900EDC433C1;
        Tue, 15 Nov 2022 15:17:55 +0000 (UTC)
Date:   Tue, 15 Nov 2022 10:18:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Jianlin Lv <iecedge@gmail.com>, alison.schofield@intel.com,
        davidgow@google.com, thunder.leizhen@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracepoint: Allow livepatch module add trace event
Message-ID: <20221115101837.37da9d1e@gandalf.local.home>
In-Reply-To: <20221116000707.a8a692e377d8daaf3764ee64@kernel.org>
References: <20221102160236.11696-1-iecedge@gmail.com>
        <20221114122255.72588f45@gandalf.local.home>
        <CAFA-uR8TakkW=KoA_9RXcyw00Zj8+nNn2erSZ4Y9ULNM8ne11g@mail.gmail.com>
        <20221114220216.05dd0541@gandalf.local.home>
        <20221116000707.a8a692e377d8daaf3764ee64@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 00:07:07 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> BTW, now the kprobe_ftrace_handler() uses ftrace_test_recursion_trylock()
> to avoid ftrace recursion, is that OK for this case?

Note, the ftrace_test_recursion_trylock() only prevents "same context"
recursion. That is, it will not let normal context recurse into normal
context, or interrupt context recurse into interrupt context.

It has the logic of breaking up into 4 levels:

 1. normal
 2. softirq
 3. irq
 4. NMI

It allows the high levels to recurse into lower levels
 (e.g. irq context into normal context)

Thus, the code within the ftrace_test_recursion_trylock() must itself be
re-entrant to handle being called from different contexts.

-- Steve
