Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6CC61748D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKCCyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKCCye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:54:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A01A18E0E;
        Wed,  2 Nov 2022 19:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B667261CFE;
        Thu,  3 Nov 2022 02:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84508C433D6;
        Thu,  3 Nov 2022 02:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667443991;
        bh=tHC19MIoBGE2+d3PdgbHi+j8F7t5gEgI/znPL5d61eI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dgP8e8dnzHCqau1QRm+eE/8fhILU1r4Kzcu0Rhkmo4kKgWGehofONHk6vdcfR9xuh
         1OuQ/hLnapVsN+babK7USrSPVBdPiVzg22Mz2ystmu5iq+D7vPKrV+UbWci1zpV1CQ
         KLyMYX/CcacNcbfk0RR/g8nabne0VkqNszAWSR1hS0hG52kZtdGiDb5pY4RKMya8YV
         oAPPUJNmrZjxns7pIHxMobp+VgDTfh6/o5RBZYfu8/iYgwyY5ppjPxTBndbFu+SZ/v
         fOgrDkLjbE5wfbgy8yXmylapilKPHsRT0ih4fJfylMMBJMarDlbm0i0H6rJqbbyIOZ
         A740gT2+cBPgg==
Date:   Thu, 3 Nov 2022 11:53:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Roland Ruckerbauer <roland.rucky@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, regressions@lists.linux.dev,
        Steven Noonan <steven.noonan@gmail.com>
Subject: Re: [PATCH] ring-buffer: Check for NULL cpu_buffer in
 ring_buffer_wake_waiters()
Message-Id: <20221103115307.3d253be73d1259dfa6417b3c@kernel.org>
In-Reply-To: <20221101191009.1e7378c8@rorschach.local.home>
References: <20221101191009.1e7378c8@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 19:10:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> On some machines the number of listed CPUs may be bigger than the actual
> CPUs that exist. The tracing subsystem allocates a per_cpu directory with
> access to the per CPU ring buffer via a cpuX file. But to save space, the
> ring buffer will only allocate buffers for online CPUs, even though the
> CPU array will be as big as the nr_cpu_ids.
> 
> With the addition of waking waiters on the ring buffer when closing the
> file, the ring_buffer_wake_waiters() now needs to make sure that the
> buffer is allocated (with the irq_work allocated with it) before trying to
> wake waiters, as it will cause a NULL pointer dereference.
> 
> While debugging this, I added a NULL check for the buffer itself (which is
> OK to do), and also NULL pointer checks against buffer->buffers (which is
> not fine, and will WARN) as well as making sure the CPU number passed in
> is within the nr_cpu_ids (which is also not fine if it isn't).
> 
> Link: https://lore.kernel.org/all/87h6zklb6n.wl-tiwai@suse.de/
> Link: https://lore.kernel.org/all/CAM6Wdxc0KRJMXVAA0Y=u6Jh2V=uWB-_Fn6M4xRuNppfXzL1mUg@mail.gmail.com/
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: stable@vger.kernel.org
> Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1204705
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Reported-by: Roland Ruckerbauer <roland.rucky@gmail.com>
> Fixes: f3ddb74ad079 ("tracing: Wake up ring buffer waiters on closing of the file")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 199759c73519..9712083832f4 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -937,6 +937,9 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	struct rb_irq_work *rbwork;
>  
> +	if (!buffer)
> +		return;
> +
>  	if (cpu == RING_BUFFER_ALL_CPUS) {
>  
>  		/* Wake up individual ones too. One level recursion */
> @@ -945,7 +948,15 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
>  
>  		rbwork = &buffer->irq_work;
>  	} else {
> +		if (WARN_ON_ONCE(!buffer->buffers))
> +			return;
> +		if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
> +			return;
> +
>  		cpu_buffer = buffer->buffers[cpu];
> +		/* The CPU buffer may not have been initialized yet */
> +		if (!cpu_buffer)
> +			return;
>  		rbwork = &cpu_buffer->irq_work;
>  	}
>  
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
