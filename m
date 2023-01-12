Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5466708B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjALLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjALLIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:08:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79EDD23C;
        Thu, 12 Jan 2023 03:00:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 556C8AD7;
        Thu, 12 Jan 2023 03:01:29 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E28033F67D;
        Thu, 12 Jan 2023 03:00:44 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:00:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     catalin.marinas@arm.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, rostedt@goodmis.org,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/8] ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <Y7/oUy2fIOoq1yFC@FVFF77S0Q05N>
References: <20230109135828.879136-1-mark.rutland@arm.com>
 <20230109135828.879136-5-mark.rutland@arm.com>
 <ec65815e-a8c9-470a-ff89-41626c94df28@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec65815e-a8c9-470a-ff89-41626c94df28@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:48:45PM +0800, Li Huafei wrote:
> On 2023/1/9 21:58, Mark Rutland wrote:
> 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 99f1146614c04..5eeb2776124c5 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -57,6 +57,9 @@ void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip);
> >  void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> >  			       struct ftrace_ops *op, struct ftrace_regs *fregs);
> >  #endif
> > +extern const struct ftrace_ops ftrace_nop_ops;
> > +extern const struct ftrace_ops ftrace_list_ops;
> > +struct ftrace_ops *ftrace_find_unique_ops(struct dyn_ftrace *rec);
> 
> Hi Mark,

Hi Huafei,

Thanks for the reporrt.

> This patch has build issues on x86:
> 
>     CC      mm/readahead.o
>   In file included from include/linux/perf_event.h:52:0,
>                    from arch/x86/events/amd/lbr.c:2:
>   include/linux/ftrace.h:62:50: error: ‘struct dyn_ftrace’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>    struct ftrace_ops *ftrace_find_unique_ops(struct dyn_ftrace *rec);
> 
> Here we should need 'struct dyn_ftrace' forward declaration.

The build robot spotted this a couple of days ago (from my branch rather than
the list), and I fixed it there a couple of days ago. The relevant messages were:

  https://lore.kernel.org/oe-kbuild-all/202301100944.E0mV3kSO-lkp@intel.com/
  https://lore.kernel.org/oe-kbuild-all/Y72TJ3qQuvx3gIOi@FVFF77S0Q05N/#t

... and the updated commit is at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/ftrace/per-callsite-ops&id=acab29d6ea2f20d8d156cdd301ad9790bd1d888f


... I'll post a v2 with that folded in once this has had a bit more time to gather comments.

Thanks,	
Mark.
