Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7B72B588
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjFLCyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjFLCyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59CFE48;
        Sun, 11 Jun 2023 19:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8268361D94;
        Mon, 12 Jun 2023 02:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD9DC4339B;
        Mon, 12 Jun 2023 02:54:08 +0000 (UTC)
Date:   Sun, 11 Jun 2023 22:54:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230611225407.3e9b8ad2@gandalf.local.home>
In-Reply-To: <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
References: <20230611130029.1202298-1-jolsa@kernel.org>
        <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2023 17:22:29 -0700
Yonghong Song <yhs@meta.com> wrote:

> > Note displayed address is the patch-site address and can differ from
> > /proc/kallsyms address.  
> 
> Could you explain how these addresses will be used in kernel, esp.
> since these addresses are different from kallsyms addresses?

These are the addresses that will be patched by the ftrace infrastructure.
It's more efficient to use these addresses when setting a function filter
with ftrace_set_filter_ip(), as it doesn't need to call into the kallsyms
infrastructure to look to see if the passed in ip lands on a function. That
is, if rec->ip matches the ip, it uses it. If you look at ftrace_location()
(which is used to find the record to be patched), it first does a search of
these addresses. If it doesn't find it, it then has to call into kallsyms
to find the start and end of the function, and do another search into that
range.

> 
> Also, if there are multiple same static functions with
> different addresses, user space might need to check dwarf or
> proposed BTF_KIND_KFUNC (which encode kallsyms addresses)
> to find whether entry in available_filter_functions_addrs
> to be used. But addresses may not match. How this issue could
> be resolved?

Easy, you use the address between two other addresses in kallsyms. The
address is still in the function. The addresses in kallsyms is the starting
address, but there's cases that the patch location is not at the start.

-- Steve
