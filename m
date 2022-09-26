Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CCC5EAE30
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiIZR2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiIZR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392AB92F60
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94F6960F61
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E416DC433D6;
        Mon, 26 Sep 2022 16:45:43 +0000 (UTC)
Date:   Mon, 26 Sep 2022 12:46:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [RFC PATCH] x86/syscalls: allow tracing of __do_sys_[syscall]
 functions
Message-ID: <20220926124651.5d35dd5f@gandalf.local.home>
In-Reply-To: <20220913135213.720368-1-namit@vmware.com>
References: <20220913135213.720368-1-namit@vmware.com>
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

On Tue, 13 Sep 2022 06:52:13 -0700
Nadav Amit <nadav.amit@gmail.com> wrote:

> +++ b/include/linux/compiler_types.h
> @@ -152,8 +152,12 @@ struct ftrace_likely_data {
>   * externally visible function. This makes extern inline behave as per gnu89
>   * semantics rather than c99. This prevents multiple symbol definition errors
>   * of extern inline functions at link time.
> - * A lot of inline functions can cause havoc with function tracing.
> + *
> + * A lot of inline functions can cause havoc with function tracing. If the
> + * function is known to be safe for tracing, inline_trace can be used. Otherwise
> + * inline would prevent tracing.

Perhaps add:

 * Don't complain if this function is not available to trace!

  ;-)

-- Steve

>   */
> +#define inline_trace __inline __gnu_inline __inline_maybe_unused
>  #define inline inline __gnu_inline __inline_maybe_unused notrace
>  
