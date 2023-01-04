Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9D65D69C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjADOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjADOzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:55:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2014619286
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:55:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9228B8169E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BE1C433F1;
        Wed,  4 Jan 2023 14:55:18 +0000 (UTC)
Date:   Wed, 4 Jan 2023 09:55:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH] trace: Add trace points for tasklet entry/exit
Message-ID: <20230104095514.0481f1d8@gandalf.local.home>
In-Reply-To: <20230104232918.2791484c39ac54c59a7110f4@kernel.org>
References: <20230103185408.2874345-1-jstultz@google.com>
        <20230103151554.5c0a6c6f@gandalf.local.home>
        <20230104232918.2791484c39ac54c59a7110f4@kernel.org>
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

On Wed, 4 Jan 2023 23:29:18 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> >  # echo 'e:tasklet_info tasklet/tasklet_entry state=+8($tasklet):u64' > dynamic_events  
> 
> Hmm, what about saving 'state' and 'count' instead of 'tasklet'?
> 
> I have a question about the basic policy of making a new tracepoint.

The policy is to have something that is useful for analysis and debugging ;-)

> 
> Of course we can expand the event with eprobes as you said, but without
> eprobe, this 'tasklet' field of this event just exposing a kernel
> internal object address. That is useless in most cases. And also the
> offset (layout) in the kernel data structure can be changed by some
> debug options. We need an external tool to find correct offset (e.g.
> perf probe).
> 
> So my question is when adding a new event, whether it should expose a
> (address of) related data structure, or expose some value fields of
> the structure. IMHO, the basic policy is latter. Of course if the
> data structure is enough big and most of its fields are usually not
> interesting, it may be better to save the data structure itself.

This isn't unprecedented. Lots of tracepoints expose a pointer to a
structure. It's useful as that pointer becomes an identifier and can be
tracked.

The reason I prefer eprobe, is because it prevents anything from making it
into a ABI. We should try not exposing internally used fields if possible.
By exposing state and count, something can easily depend on those fields
as they are then exposed in the format file. Where as, eprobes is just
reading offsets of a pointer, and not something that can become ABI,
especially because the addresses may change with different compiled options.

-- Steve
