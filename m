Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B46F22B9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 05:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347185AbjD2Dik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 23:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjD2Dif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 23:38:35 -0400
Received: from out0-205.mail.aliyun.com (out0-205.mail.aliyun.com [140.205.0.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E1C26A6;
        Fri, 28 Apr 2023 20:38:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.STlDLfd_1682739506;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STlDLfd_1682739506)
          by smtp.aliyun-inc.com;
          Sat, 29 Apr 2023 11:38:27 +0800
Date:   Sat, 29 Apr 2023 11:38:26 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     <linux-kernel@vger.kernel.org>,
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
Message-ID: <20230429033826.GA91541@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <38a5029cd2590e04209117740f8912db36eff58f.1682673543.git.houwenlong.hwl@antgroup.com>
 <20230428094454.0f2f5049@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428094454.0f2f5049@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 09:44:54PM +0800, Steven Rostedt wrote:
> On Fri, 28 Apr 2023 17:51:02 +0800
> "Hou Wenlong" <houwenlong.hwl@antgroup.com> wrote:
> 
> > From: Thomas Garnier <thgarnie@chromium.org>
> > 
> > From: Thomas Garnier <thgarnie@chromium.org>
> > 
> > When using PIE with function tracing, the compiler generates a
> > call through the GOT (call *__fentry__@GOTPCREL). This instruction
> > takes 6-bytes instead of 5-bytes with a relative call. And -mnop-mcount
> > option is not implemented for -fPIE now.
> > 
> > If PIE is enabled, replace the 6th byte of the GOT call by a 1-byte nop
> > so ftrace can handle the previous 5-bytes as before.
> 
> Wait! This won't work!
> 
> You can't just append another nop to fill in the blanks here. We must
> either have a single 6 byte nop, or we need to refactor the entire logic to
> something that other archs have.
> 
> The two nops means that the CPU can take it as two separate commands.
> There's nothing stopping the computer from preempting a task between the
> two. If that happens, and you modify the 1byte nop and 5byte nop with a
> single 6 byte command, when the task get's rescheduled, it will execute the
> last 5 bytes of that 6 byte command and take a general protection fault, and
> likely crash the machine.
> 
> NACK on this. It needs a better solution.
> 
> -- Steve
> 
>
Hi Steve,

Sorry for not providing the original patch link:
https://lore.kernel.org/all/20190131192533.34130-22-thgarnie@chromium.org/

I drop the Reviewed-by tag due to the change described in commit
message.

This nop patching is only used for the first time (addr = MCOUNT) before
SMP or executing code in module. And ftrace_make_call() is not modified,
then we would use 5 byte direct call to replace the first 5 byte nop
when tracepoint is enabled like before, it's still one instruction. So,
the logic is same like before, patch the first 5 byte when tracepoint is
enabled or disabled during running.

> > 
> > [Hou Wenlong: Adapt code change and fix wrong offset calculation in
> > make_nop_x86()]
> > 
