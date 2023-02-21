Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4E69E652
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjBURuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjBURuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:50:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908BA2F7A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:50:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BED261172
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697B8C433EF;
        Tue, 21 Feb 2023 17:50:34 +0000 (UTC)
Date:   Tue, 21 Feb 2023 12:50:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Olivier Dion <odion@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Official documentation from Intel stating that poking INT3
 (single-byte) concurrently is OK ?
Message-ID: <20230221125032.0b02d309@gandalf.local.home>
In-Reply-To: <786f4aed-2c30-806b-409b-23a60b3d7571@efficios.com>
References: <786f4aed-2c30-806b-409b-23a60b3d7571@efficios.com>
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

On Tue, 21 Feb 2023 11:44:42 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Hi Peter,
> 
> I have emails from you dating from a few years back unofficially stating
> that it's OK to update the first byte of an instruction with a single-byte
> int3 concurrently:
> 
> https://lkml.indiana.edu/hypermail/linux/kernel/1001.1/01530.html
> 
> It is referred in the original implementation of text_poke_bp():
> commit fd4363fff3d9 ("x86: Introduce int3 (breakpoint)-based instruction patching")
> 
> Olivier Dion is working on the libpatch [1,2] project aiming to use this
> property for low-latency/low-overhead live code patching in user-space as
> well, but we cannot find an official statement from Intel that guarantees
> this breakpoint-bypass technique is indeed OK without stopping the world
> while patching.
> 
> Do you know where I could find an official statement of this guarantee ?
> 

The fact that we have been using it for over 10 years without issue should
be a good guarantee ;-)

I know you probably prefer an official statement, and I thought they
actually gave one, but can't seem to find it. Anyway. how does the dynamic
linker do this? Doesn't it update code on the fly as well?

-- Steve

