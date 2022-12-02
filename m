Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2978640E7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiLBTat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiLBTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:30:46 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6FFEC80E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:30:46 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c7so2414363pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4lTGxL2A35iMA/bzpPtas8WyqEmZI1JlvurkUw6N00=;
        b=K9wVvTymW8HSkZXdGkRKRVJ4ShwxDmAlV0FXM9Kn4q3xgRmi1yVHjeJtZmSohh+Qzm
         q7bf5bPSMr/w7q6tVBFl9d5BpBzAxoRl/nYhypjJZ21cHW0rCK2ldw1k0efvv4D0EJTY
         1OzWvJVn8ujw+AoEGv6PUDn45c2tBx5TemGkewFB9Z+6SlCCve5gBz2AQMQ6ly0p57xc
         SmjWZbhhuwgeRqc0EvGtkS46cXNYDs3QDhv9yejeIm55KlIfAO1mZP/0qHGUWo8Y7aR/
         WfTjWEWI6NkpXNMaMOSsCpk3bsnPYQryLylgadjZ7diaEMQHM8lpz3h0h6z9eWdRxoOa
         5EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4lTGxL2A35iMA/bzpPtas8WyqEmZI1JlvurkUw6N00=;
        b=It3It4qdImz6ydvlteuIEhQ6m4CD1Dw5yripZzKeT0P5pN0B6uUqcHT8om3o7tFbC7
         B4HqnIufO1kC189nIiZNDUQKRJXF6kJJhpd/9/N+wd9buGKE58//0ULn9tHMO5oeG5t1
         Xz3yPVm54stQ6gYdS6Ogusn3abzfyNmQfxlwX6AI1tAWRkplepO0vB01RT23vaO5j4Dj
         OHVNhztVPqwyiEVu8aoxHAhLjKZMNc0cxUBBvRo4Jyv0rYFnxIkraqB2E7YdkMD1QtJq
         tkXF1en1Rr/Pi8OvypOc9us8ygbc7c6SeTMgH7OL1Sdy9gN3+EXXF/nw8uKX6GRz4T6Y
         atgA==
X-Gm-Message-State: ANoB5plRJLYnGE6pgyjGxlSl6tuEq2s+3pYvmpvoYYm4wrUeekr0ymW4
        aTLd0rSsbLMyH8DMMvYf+JQ=
X-Google-Smtp-Source: AA0mqf7hO5XlZTy0sJ3iQiqgRnbblLCGe9UvzkX4XhihRx7lIOVTev2++8Tlv77KE1DC5Pm5edZ+0A==
X-Received: by 2002:a63:2251:0:b0:476:cb2a:b99b with SMTP id t17-20020a632251000000b00476cb2ab99bmr65009694pgm.436.1670009445389;
        Fri, 02 Dec 2022 11:30:45 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:c181])
        by smtp.gmail.com with ESMTPSA id b16-20020aa79510000000b00574f83c5d51sm5440151pfp.198.2022.12.02.11.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:30:43 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:30:39 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@meta.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
Message-ID: <20221202193039.jle5fek5t5tff2lp@macbook-pro-6.dhcp.thefacebook.com>
References: <Y3vSQo85ofkfD/L8@zn.tnic>
 <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic>
 <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home>
 <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
 <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
 <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
 <c9912b24-f611-29b8-28e1-5e8be0d5ad41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9912b24-f611-29b8-28e1-5e8be0d5ad41@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 03:55:38PM +0100, Benjamin Tissoires wrote:
> 
> 
> On 12/1/22 22:13, Linus Torvalds wrote:
> > On Thu, Dec 1, 2022 at 8:59 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > 
> > > The hid-bpf framework depends on it.
> > 
> > Ok, this is completely unacceptably disgusting hack.
> 
> [foreword: I have read the other replies, just replying to this one
> because it is the explicit ask for a fix]
> 
> > 
> > That needs fixing.
> > 
> > > Either hid-bpf or bpf core can add
> > > "depends on FUNCTION_ERROR_INJECTION"
> > 
> > No, it needs to be narrowed down a lot. Nobody sane wants error
> > injection just because they want some random HID thing.
> > 
> > And no, BPF shouldn't need it either.
> > 
> > This needs to be narrowed down to the point where HID can say "I want
> > *this* particular call to be able to be a bpf call.
> 
> So, would the following be OK? I still have a few concerns I'll explain
> after the patch.
> 
> ---
> From 1290561304eb3e48e1e6d727def13c16698a26f1 Mon Sep 17 00:00:00 2001
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Date: Fri, 2 Dec 2022 12:40:29 +0100
> Subject: [PATCH] bpf: do not rely on ALLOW_ERROR_INJECTION for fmod_ret
> 
> The current way of expressing that a non-bpf kernel component is willing
> to accept that bpf programs can be attached to it and that they can change
> the return value is to abuse ALLOW_ERROR_INJECTION.
> This is debated in the link below, and the result is that it is not a
> reasonable thing to do.
> 
> An easy fix is to keep the list of valid functions in the BPF verifier
> in the same way we keep the non-sleepable ALLOW_ERROR_INJECTION ones.
> However, this kind of defeat the point of being able to add bpf APIs in
> non-BPF subsystems, so we probably need to rethink that part.
> 
> 
> Link: https://lore.kernel.org/all/20221121104403.1545f9b5@gandalf.local.home/
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c  |  2 --
>  drivers/hid/bpf/hid_bpf_jmp_table.c |  1 -
>  kernel/bpf/verifier.c               | 20 +++++++++++++++++++-
>  3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> index 3c989e74d249..d1f6a1d4ae60 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -44,7 +44,6 @@ __weak noinline int hid_bpf_device_event(struct hid_bpf_ctx *ctx)
>  {
>  	return 0;
>  }
> -ALLOW_ERROR_INJECTION(hid_bpf_device_event, ERRNO);
>  u8 *
>  dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type, u8 *data,
> @@ -105,7 +104,6 @@ __weak noinline int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx)
>  {
>  	return 0;
>  }
> -ALLOW_ERROR_INJECTION(hid_bpf_rdesc_fixup, ERRNO);
>  u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
>  {
> diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
> index 579a6c06906e..207972b028d9 100644
> --- a/drivers/hid/bpf/hid_bpf_jmp_table.c
> +++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
> @@ -103,7 +103,6 @@ __weak noinline int __hid_bpf_tail_call(struct hid_bpf_ctx *ctx)
>  {
>  	return 0;
>  }
> -ALLOW_ERROR_INJECTION(__hid_bpf_tail_call, ERRNO);
>  int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
>  		     struct hid_bpf_ctx_kern *ctx_kern)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 225666307bba..4eac440d659f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24,6 +24,7 @@
>  #include <linux/bpf_lsm.h>
>  #include <linux/btf_ids.h>
>  #include <linux/poison.h>
> +#include <linux/hid_bpf.h>
>  #include "disasm.h"
> @@ -14827,6 +14828,20 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>  }
> +/* Manually tag fmod_ret functions to not misuse ALLOW_ERROR_INJECTION */
> +BTF_SET_START(btf_modify_return)
> +#if CONFIG_HID_BPF
> +BTF_ID(func, hid_bpf_device_event)
> +BTF_ID(func, hid_bpf_rdesc_fixup)
> +BTF_ID(func, __hid_bpf_tail_call)
> +#endif /* CONFIG_HID_BPF */
> +BTF_SET_END(btf_modify_return)
> +
> +static int check_function_modify_return(u32 btf_id)
> +{
> +	return btf_id_set_contains(&btf_modify_return, btf_id);
> +}
> +
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    const struct bpf_prog *prog,
>  			    const struct bpf_prog *tgt_prog,
> @@ -15047,7 +15062,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  				bpf_log(log, "can't modify return codes of BPF programs\n");
>  				return -EINVAL;
>  			}
> -			ret = check_attach_modify_return(addr, tname);
> +			ret = -EINVAL;
> +			if (!check_function_modify_return(btf_id) ||
> +			    check_attach_modify_return(addr, tname))
> +				ret = 0;
>  			if (ret) {
>  				bpf_log(log, "%s() is not modifiable\n", tname);
>  				return ret;
> -- 
> 2.38.1
> ---
> 
> While this patch removes the need for ALLOW_ERROR_INJECTION it has a
> couple of drawbacks:
> - suddenly we lose the nice separation of concerns between bpf core and
> its users (HID in my case)
> - it would need to be changed in 6.3 simply because of the previous
> point, so it is just a temporary fix.

Agree, but it works short term.
A silver lining is BTF_SET approach consumes 4 bytes per mark
while ALLOW_ERROR_INJECTION consumes 16 bytes for struct error_injection_entry
and then another 48 bytes per mark for struct ei_entry.

An alternative would be to define a known prefix like "bpf_modret_"
or "bpf_hook_" and rename these three functions.

Then there will be no need for #include <linux/hid_bpf.h> in bpf core.

> So I am not sure if this would qualify HID-BPF for 6.2. Please speak up.

Since that was the only thing I think it's fine to stay in the queue.
