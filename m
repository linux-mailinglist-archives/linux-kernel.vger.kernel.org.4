Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7151A72B58D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjFLC6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFLC57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32C2E42;
        Sun, 11 Jun 2023 19:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA4261BBA;
        Mon, 12 Jun 2023 02:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A66C433EF;
        Mon, 12 Jun 2023 02:57:56 +0000 (UTC)
Date:   Sun, 11 Jun 2023 22:57:54 -0400
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
Message-ID: <20230611225754.01350a50@gandalf.local.home>
In-Reply-To: <20230611225407.3e9b8ad2@gandalf.local.home>
References: <20230611130029.1202298-1-jolsa@kernel.org>
        <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
        <20230611225407.3e9b8ad2@gandalf.local.home>
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

On Sun, 11 Jun 2023 22:54:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Also, if there are multiple same static functions with
> > different addresses, user space might need to check dwarf or
> > proposed BTF_KIND_KFUNC (which encode kallsyms addresses)
> > to find whether entry in available_filter_functions_addrs
> > to be used. But addresses may not match. How this issue could
> > be resolved?  
> 
> Easy, you use the address between two other addresses in kallsyms. The
> address is still in the function. The addresses in kallsyms is the starting
> address, but there's cases that the patch location is not at the start.

Not to mention, you can still use the kallsyms address. If you did the work
to find it, then use it (it may not be as efficient as I mentioned before).
That's basically what is done today (so I am told), and this patch was to
create a file where you don't need to look up kallsyms when you know which
function to use. The functions are sorted by address, so if you know of a
unique function near the duplicate, you just find the duplicate that's near
the unique function name.

-- Steve
