Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1479B6F19E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346333AbjD1NpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD1NpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588E268D;
        Fri, 28 Apr 2023 06:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A017663532;
        Fri, 28 Apr 2023 13:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55576C433EF;
        Fri, 28 Apr 2023 13:44:57 +0000 (UTC)
Date:   Fri, 28 Apr 2023 09:44:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Hou Wenlong" <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Qing Zhang" <zhangqing@loongson.cn>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 22/43] x86/ftrace: Adapt ftrace nop patching for PIE
 support
Message-ID: <20230428094454.0f2f5049@gandalf.local.home>
In-Reply-To: <38a5029cd2590e04209117740f8912db36eff58f.1682673543.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
        <38a5029cd2590e04209117740f8912db36eff58f.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 17:51:02 +0800
"Hou Wenlong" <houwenlong.hwl@antgroup.com> wrote:

> From: Thomas Garnier <thgarnie@chromium.org>
> 
> From: Thomas Garnier <thgarnie@chromium.org>
> 
> When using PIE with function tracing, the compiler generates a
> call through the GOT (call *__fentry__@GOTPCREL). This instruction
> takes 6-bytes instead of 5-bytes with a relative call. And -mnop-mcount
> option is not implemented for -fPIE now.
> 
> If PIE is enabled, replace the 6th byte of the GOT call by a 1-byte nop
> so ftrace can handle the previous 5-bytes as before.

Wait! This won't work!

You can't just append another nop to fill in the blanks here. We must
either have a single 6 byte nop, or we need to refactor the entire logic to
something that other archs have.

The two nops means that the CPU can take it as two separate commands.
There's nothing stopping the computer from preempting a task between the
two. If that happens, and you modify the 1byte nop and 5byte nop with a
single 6 byte command, when the task get's rescheduled, it will execute the
last 5 bytes of that 6 byte command and take a general protection fault, and
likely crash the machine.

NACK on this. It needs a better solution.

-- Steve


> 
> [Hou Wenlong: Adapt code change and fix wrong offset calculation in
> make_nop_x86()]
> 
