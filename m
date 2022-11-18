Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5062F470
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiKRMSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbiKRMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:18:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA7970B0;
        Fri, 18 Nov 2022 04:18:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79F91B823AF;
        Fri, 18 Nov 2022 12:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BC4C433D7;
        Fri, 18 Nov 2022 12:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668773893;
        bh=5rRdeZZJ4Nf86f04xkQi1yG/8nl3q8uCEteIy43H/JE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EHrw5mhDjtpByitEA9nkbzIPJ0hg6cZ1cK6Fw012oLA/Ewa7iYNId/LX2Mku6s83z
         V9CN/mleu6Law/ItD478Awjy+PP7uCOfS+ib3zDIQ+wZG+MvA30GjgVuaTIaQO4m86
         AEiD+NUB+bakhBMtBEgTQ8JPaZxg5P+zjll1C+2yBJInWlij8/wqKlqG+mMLUVn2vL
         ikVV9uke4XDUF1iC6JbnW53mEGH0xGu+6/AH2R9L3EGYqc01w6cGMHqMqfpzynwUy8
         m29z8YPmGkYHtbq2HxlVMDEi73Z1qBzcgS3biXh5DKaDhL/dbJ9NeQEMpBfJIO3Lj/
         o6U6t6OKzKvsw==
Date:   Fri, 18 Nov 2022 21:18:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rafael Mendonca <rafaelmendsr@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Fix race where eprobes can be called before
 the event
Message-Id: <20221118211809.701d40c0f8a757b0df3c025a@kernel.org>
In-Reply-To: <20221117214249.2addbe10@gandalf.local.home>
References: <20221117214249.2addbe10@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 21:42:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The flag that tells the event to call its triggers after reading the event
> is set for eprobes after the eprobe is enabled. This leads to a race where
> the eprobe may be triggered at the beginning of the event where the record
> information is NULL. The eprobe then dereferences the NULL record causing
> a NULL kernel pointer bug.
> 
> Test for a NULL record to keep this from happening.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20221116192552.1066630-1-rafaelmendsr@gmail.com/

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, would other trigger callbacks also need to add similar checks?

Thank you,

> 
> Cc: stable@vger.kernel.org
> Fixes: 7491e2c442781 ("tracing: Add a probe that attaches to trace events")
> Reported-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_eprobe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 5dd0617e5df6..6b31b74954d9 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -563,6 +563,9 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
>  {
>  	struct eprobe_data *edata = data->private_data;
>  
> +	if (unlikely(!rec))
> +		return;
> +
>  	__eprobe_trace_func(edata, rec);
>  }
>  
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
