Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB164871A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLIQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLIQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:57:58 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF912761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:57:54 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id i83so2331025ioa.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9011w90XDpr2MVjqnY9vogUhRJotSgkyEmZP8aBuFE=;
        b=JwKeeivhpsC10CzgvrHnuK1oVUEYYiIUo6cczYHGAiWtUOc7/TIoFhhzYahvQrsQoP
         XLDHRxeV2jJoFgAAgMExr2BKGSPgUTjVvGd/kj9+SZZ+fdDN4K95x8PhfJ3Ru+ssJYV1
         hIa7DbzOLShdmupfceuf+xeB+mIppHuMcaWyK7Bwef/Kabr8yqqEA9k3AF8SHjbFM0VB
         1sy29nq6VcqnMAJ8aJfVYj0gn8apBGD09M+lwbnXUwSQUhv27V1YC/o7p875emZv/ecm
         h7eDFZOCnVW8ca7CH8+WI5/RpK2My/4+c3+Yo+E7Nr1/9qc/joNUb78OErFrp4BPSdGT
         4znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9011w90XDpr2MVjqnY9vogUhRJotSgkyEmZP8aBuFE=;
        b=Y/8PyRUQLrLVLLsl4Bv+nqzEYucrCub0FdjnOerqSKPX4oCyDBgT7oE+iZ5qzh1c+J
         C7k2b9W9EXbB0qhpSG+SdmhKfrbs6tZLfGVttI65OC9t/gS6R+G37nlO/eCiqSaC3jJy
         16MEm+oRa9BpGObWTcjkQKVOyEyRTNgveULfYoGT4fIDhFz0GMsO62aogWRJITBI5Hs0
         Ouy7rTk7L7fwaCCPeWCwEHt+dQkk9shOgoewQUvb7EnNODTpWPUIcJ/90sIyzCMQtwH6
         y27FnxLqtcr3ZTQqGFjOmJOpx+KKZrgsiNb7ARSADV6lg9QxuuZMZQLz9bLwFIqxWm/u
         6QTA==
X-Gm-Message-State: ANoB5pn3sTks71KYgsPerOhc5g92pgPaj9YSATwersrWyf0xNYNBmrtu
        OFeM6yqByucCgc5/BDuvMqM1wg==
X-Google-Smtp-Source: AA0mqf6TgS97lagKm0YkuI6Gf5tZhd8p5qNJkld8omxKxp09jFRBbzDewGDblwWEuMmOaRRdWQMptw==
X-Received: by 2002:a5d:991a:0:b0:6df:da71:30d5 with SMTP id x26-20020a5d991a000000b006dfda7130d5mr3730719iol.0.1670605073180;
        Fri, 09 Dec 2022 08:57:53 -0800 (PST)
Received: from google.com ([2620:15c:183:200:a53b:fb2d:b8a1:f544])
        by smtp.gmail.com with ESMTPSA id c1-20020a023b01000000b00389e336e92fsm582833jaa.75.2022.12.09.08.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:57:52 -0800 (PST)
Date:   Fri, 9 Dec 2022 09:57:48 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Handle resize in early boot up
Message-ID: <Y5NpDF0AnY9ibwEl@google.com>
References: <20221209101151.1fec1167@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209101151.1fec1167@gandalf.local.home>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 10:11:51AM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> With the new command line option that allows trace event triggers to be
> added at boot, the "snapshot" trigger will allocate the snapshot buffer
> very early, when interrupts can not be enabled. Allocating the ring buffer
> is not the problem, but it also resizes it, which is, as the resize code
> does synchronization that can not be preformed at early boot.
> 
> To handle this, first change the raw_spin_lock_irq() in rb_insert_pages()
> to raw_spin_lock_irqsave(), such that the unlocking of that spin lock will
> not enable interrupts.
> 
> Next, where it calls schedule_work_on(), disable migration and check if
> the CPU to update is the current CPU, and if so, perform the work
> directly, otherwise re-enable migration and call the schedule_work_on() to
> the CPU that is being updated. The rb_insert_pages() just needs to be run
> on the CPU that it is updating, and does not need preemption nor
> interrupts disabled when calling it.
> 
> Link: https://lore.kernel.org/lkml/Y5J%2FCajlNh1gexvo@google.com/
> 
> Fixes: a01fdc897fa5 ("tracing: Add trace_trigger kernel command line option")
> Reported-by: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
<>
> @@ -2298,9 +2308,17 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
>  		if (!cpu_online(cpu_id))
>  			rb_update_pages(cpu_buffer);
>  		else {
> -			schedule_work_on(cpu_id,
> -					 &cpu_buffer->update_pages_work);
> -			wait_for_completion(&cpu_buffer->update_done);
> +			/* Run directly if possible. */
> +			migrate_disable();
> +			if (cpu_id == smp_processor_id()) {
> +				rb_update_pages(cpu_buffer);
> +				migrate_enable();
> +			} else {
> +				migrate_enable();
> +				schedule_work_on(cpu_id,
> +						 &cpu_buffer->update_pages_work);
> +				wait_for_completion(&cpu_buffer->update_done);

I ran with this patch on my test VM and hit the same Oops from the original
report.

I think the problem is that we're still trying to enable interrupts via
wait_for_completion():

wait_for_completion()
  wait_for_common()
    __wait_for_common()
      raw_spin_unlock_irq()
        _raw_spin_unlock_irq()
          __raw_spin_unlock_irq()
            local_irq_enable()

I'm testing on a QEMU VM with 4 virtual CPUs, if that helps WRT where work is
being scheduled (cpu_id == smp_processor_id).
