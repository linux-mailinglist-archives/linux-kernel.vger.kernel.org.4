Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913656412D9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiLCAzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiLCAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:55:19 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF56101D3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:55:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 21so6411016pfw.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 16:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYhOSAAecw5hMoG44eS+mB/LIIFEkB0A8/BXG3TWxmw=;
        b=gWZT/4OZ9cDZ4JFrR8F90PCn8KydHDcemskto7lMnUujpX0OnOktV2KWL360pPMsUs
         WqiVpJcCNBK47h5SBYeOeZIMiUSgDLQrOC0nIxHlXFtAqh2dgQY3vITG0Mg2hGvigiSF
         p8iF4r2Kebkar9gzUA5lWix+HvENA6dBoXtMQcgx8SDCBbekZrDRu0X6IL5PNv9ad0wX
         UDApnGl0qtrq/MBxiUFoTStXBSRmMXF3lRqVrhqV0cMTb2EOZCtwDkZwxAMyj+xexgmw
         FQ+mRzRej8wFWx/hVfzlNxqi2fCAn6eJtR0Eoepm0CxQIdeFae7SpLk5ouxGbOzTO4dn
         wTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYhOSAAecw5hMoG44eS+mB/LIIFEkB0A8/BXG3TWxmw=;
        b=az5iRYG38YBZUchRIoU9fGc1eVI8gaNDUHZG5E2NYb2GqaiqfOkbehXj9cpOBQhiHK
         Bh3BAC70YgpfUY927Pxi2Llsy/lmR7GzyaOjiXd20D/tLqO6j3ng3lgwsW+Npgy+SjeR
         xPKHKZhyja/DCLL+rLS4RGe9wOTLVla3LP6IW62CTz3w5YVRUYZhv2BjadLfsG7H0/o7
         pR60NAX8ONl+REvefJyOnOdl20t6p2DSo6SdZZYYc+xxHAteXSjdtqsx/TlPw+wTrHo2
         efQvo3FUvquq0RpHbaWyNn3JLnOFzFRjsDTKPufZyyT+FQ95UPlVk21ESXH6Qpu35uPy
         riUg==
X-Gm-Message-State: ANoB5pmCXJrpNK8LkjkQIj9SSQeWu+1A4f/ao9nZIS0LhhoLcPuVO9+I
        WbVRnoahhlnQwZGw3CCOsrte2htRfyA=
X-Google-Smtp-Source: AA0mqf647S6/Dv4OVsVyRWyYx5WoG0UCJUpqaTLGlL0AtJ2l351/zGCa72SY0bd/9h11gpRtEe2Ahw==
X-Received: by 2002:a63:5802:0:b0:46f:59af:c1f4 with SMTP id m2-20020a635802000000b0046f59afc1f4mr47473044pgb.344.1670028911589;
        Fri, 02 Dec 2022 16:55:11 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:c181])
        by smtp.gmail.com with ESMTPSA id ik25-20020a170902ab1900b001869b988d93sm6081148plb.187.2022.12.02.16.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 16:55:10 -0800 (PST)
Date:   Fri, 2 Dec 2022 16:55:07 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@meta.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
Message-ID: <20221203005507.szqy2o7sogqmfjsz@macbook-pro-6.dhcp.thefacebook.com>
References: <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home>
 <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
 <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
 <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
 <20221202014129.n5lmvzsy436ebo4b@macbook-pro-6.dhcp.thefacebook.com>
 <Y4ogRH7zWLpmVXzJ@mit.edu>
 <20221202212711.5ot66apmazm4yz6y@macbook-pro-6.dhcp.thefacebook.com>
 <20221202181724.4ec93cf0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202181724.4ec93cf0@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 06:17:24PM -0500, Steven Rostedt wrote:
> On Fri, 2 Dec 2022 13:27:11 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1874,8 +1874,12 @@ config NETDEV_NOTIFIER_ERROR_INJECT
> >  	  If unsure, say N.
> >  
> >  config FUNCTION_ERROR_INJECTION
> 
> Why not just call this "ERROR_INJECTION" having this be FUNCTION and the
> one for functions be FUNC is confusing.

That's what I had initially, but it causes plenty of churn to arch/*/Makefile
and a bunch of .h-s.
Keeping it as FUNCTION_ERROR_INJECTION removes all that noise from the diff.

> > +        bool
> > +
> > +config FUNC_ERROR_INJECTION
> >  	bool "Fault-injections of functions"
> >  	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
> > +	select FUNCTION_ERROR_INJECTION
> >  	help
> >  	  Add fault injections into various functions that are annotated with
> >  	  ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
> > @@ -1883,6 +1887,17 @@ config FUNCTION_ERROR_INJECTION
> >  
> >  	  If unsure, say N
> >  
> > +config SYSCALL_ERROR_INJECTION
> > +	bool "Error injections in syscalls"
> > +	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
> > +	select FUNCTION_ERROR_INJECTION
> > +	default y
> 
> IIUC, Linus prefers everything to be "default n" unless there's a really
> good reason for it. Like only making other options available, but not doing
> anything to the kernel. I do have DYNAMIC_FTRACE as "default y" but that's
> only because it depends on CONFIG_FUNCTION_TRACER and nobody that enables
> that should have DYNAMIC_FTRACE off (except for academia).

The FUNCTION_ERROR_INJECTION used to be "def_bool y" for ~5 years.
BTW the macro was called BPF_ALLOW_ERROR_INJECTION() when Josef initially implemented it.
Massami later renamed it ALLOW_ERROR_INJECTION() and allowed kprobes to use it.
Today there is a user expectation that this feature is available in the kernel.
We can do "default n" here, let distros decide and potentially upset users.
I don't feel strongly about that.

> 
> > +	help
> > +	  Allows error injection framework to return errors from syscalls.
> > +	  BPF may modify return values of syscalls as well.
> 
> And here's the thing. If BPF returns anything *but* an error, then this is
> a misnomer and incorrect. Name it something else like "HIJACK_SYSCALLS".

The bpf prog must return errno. No doubt about that.
Today the verifier validates return values whenever is necessary.
When original bpf_override_return was added the verifier wasn't that smart.
Since then we added return value checks pretty much everywhere.
Looks like the check is still missing bpf_override_return.
We will fix it asap.

> > +
> > +	  If unsure, say Y
> 
> And I'm curious, why Y if unsure?

Copy-paste. I can remove that line.
