Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FBA643B28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiLFCFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiLFCFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:05:46 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0101523E97
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:05:44 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q1so12092627pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHmD3xs8roq6lRQt1suUNqzb6hxll2StyBFmmfiMKoI=;
        b=lNsjzCZncteYqrwdO/TseXc2HybO421IF4m+pzoQkc9CaSe4HErk8V/TIYn3wjzzSm
         TqJ6XxO1Cs36zejqqK0TA5eIFa20c/Srpg4F5E835/2DUZOaFrnr52RiND9JxTSM6c3b
         UJGx9ZA2V+a+NkdS5raWc95SAP0OdQcYOkL1Sr8sDzhHZNkQ+Qeuc8sLmZ7S7WLKXAgW
         I5/0VNt05Mw+we42Rx21Y1X9Nt3mABVHYn12yS36OY19pFQiTWdjIDXKP+2GWFg5+OmT
         dBZq5FQQMYhE/ACL9l5gPQUTtSdsbG+ZHkY4A0pzlGAuzmikxjY14ee0I7sIvOREiKu/
         hRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHmD3xs8roq6lRQt1suUNqzb6hxll2StyBFmmfiMKoI=;
        b=upQAg+wdh0lVvBYSrGzfJ3KdHGWMSbmLgAKmvx9WFdFdiTW+zL8d77PPfPVdpaEoh0
         DfWXXlkPD38OUhBAIUY12/qPxqZ5Yc/mF6onzDsQGKhIKhAuatYJbyfSisVm6fyYP+rX
         8w8eL8DsTOJy5HUwezOtbqRfIq1TFreoyP9j1MFikIr2WX7ggdBgQ3Ob3OSi7rqot0wH
         XEijUBfIE6yW6nkm0QF/Ro8+kiKEghUAhNQu9+qLQfiGso0miBsn8SeXfh2rA4Ne9QRe
         VP15N3a7R4royw3e180zFCXhHl3bhK0ItvMfwxr9/bmfEFp7nK8V/phyR2RyXrLvng3G
         7jxg==
X-Gm-Message-State: ANoB5pkf+wFjZYwtYwuBK+6H6lINuCzx8FV6lQ2pXDTm1tShPTiWXzEp
        M+4S3QND7CcezZ8+kDIswXg=
X-Google-Smtp-Source: AA0mqf68Ek1YJ49YW3cw+lgqG+bk3MZ5DvmFOdCpzYi9j3/SCzo5jbrcXK6U8CtnnuEjaDxk+NSbLQ==
X-Received: by 2002:a63:5f83:0:b0:478:ab05:4da9 with SMTP id t125-20020a635f83000000b00478ab054da9mr9445885pgb.369.1670292344310;
        Mon, 05 Dec 2022 18:05:44 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id q24-20020aa78438000000b00576984617b1sm5037164pfn.60.2022.12.05.18.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:05:43 -0800 (PST)
Date:   Mon, 5 Dec 2022 18:05:40 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@meta.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20221206020540.3j5x7fs7uuarzct5@macbook-pro-6.dhcp.thefacebook.com>
References: <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home>
 <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
 <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
 <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
 <20221202014129.n5lmvzsy436ebo4b@macbook-pro-6.dhcp.thefacebook.com>
 <Y4ogRH7zWLpmVXzJ@mit.edu>
 <20221202212711.5ot66apmazm4yz6y@macbook-pro-6.dhcp.thefacebook.com>
 <20221205075015.71226685a254fe86aa9f1fcc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205075015.71226685a254fe86aa9f1fcc@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 07:50:15AM +0900, Masami Hiramatsu wrote:
> On Fri, 2 Dec 2022 13:27:11 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Fri, Dec 02, 2022 at 10:56:52AM -0500, Theodore Ts'o wrote:
> > > On Thu, Dec 01, 2022 at 05:41:29PM -0800, Alexei Starovoitov wrote:
> > > > 
> > > > The fault injection framework disables individual syscall with zero performance
> > > > overhead comparing to LSM and seccomp mechanisms.
> > > > BPF is not involved here. It's a kprobe in one spot.
> > > > All other syscalls don't notice it.
> > > > It's an attractive way to improve security.
> > > > 
> > > > A BPF prog over syscall can filter by user, cgroup, task and give fine grain
> > > > control over security surface.
> > > > tbh I'm not aware of folks doing "syscall disabling" through command line like
> > > > above (I've only seen it through bpf), but it doesn't mean that somebody will
> > > > not start complaining that their script broke, because distro disabled fault
> > > > injection.
> > > > 
> > > > So should we split FUNCTION_ERROR_INJECTION kconfig into two ?
> > > > And do default N for things like should_failslab() and
> > > > default Y for syscalls?
> > > 
> > > How about calling the latter something like bpf syscall hooks, and not
> > > using the terminology "error injection" in relation to system calls?
> > > I think that might be less confusing.
> > 
> > I think 'syscall error injection' name fits well.
> > It's a generic feature that both kprobes and bpf should be able to use.
> > Here is the patch...
> > 
> > Even with this patch we have 7 failures in BPF selftests.
> > We will fix them later with the same mechanism as we will pick for hid-bpf.
> > 
> > This patch will keep 'syscall disabling' scripts working
> > and bpf syscall adjustment will work too.
> > So no chance of breaking anyone.
> > While actual error injection inside the kernel will be disabled.
> > 
> > Better name suggestions are welcome, of course.
> > 
> > From 2960958f91d1134b1a8f27787875f6b9300f205e Mon Sep 17 00:00:00 2001
> > From: Alexei Starovoitov <ast@kernel.org>
> > Date: Fri, 2 Dec 2022 13:06:08 -0800
> > Subject: [PATCH] error-injection: Split FUNCTION_ERROR_INJECTION into syscalls
> >  and the rest.
> > 
> > Split FUNCTION_ERROR_INJECTION into:
> > - SYSCALL_ERROR_INJECTION with default y
> > - FUNC_ERROR_INJECTION with default n.
> 
> OK, syscall is a bit different, it is clearly the boundary of the
> functionality, so this seems safe.
> IMHO, it is better to extend seccomp framework for testing.

seccomp doesn't support eBPF

> > 
> > The former is only used to modify return values of syscalls for security and
> > user space testing reasons while the latter is for the rest of error injection
> > in the kernel that should only be used to stress test and debug the kernel.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  arch/arm64/include/asm/syscall_wrapper.h   |  8 ++++----
> >  arch/powerpc/include/asm/syscall_wrapper.h |  4 ++--
> >  arch/s390/include/asm/syscall_wrapper.h    | 12 ++++++------
> >  arch/x86/include/asm/syscall_wrapper.h     |  4 ++--
> >  include/asm-generic/error-injection.h      |  1 +
> >  include/linux/compat.h                     |  4 ++--
> >  include/linux/syscalls.h                   |  4 ++--
> >  kernel/fail_function.c                     |  1 +
> >  lib/Kconfig.debug                          | 15 +++++++++++++++
> >  lib/error-inject.c                         |  6 ++++++
> >  10 files changed, 41 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
> > index d30217c21eff..2c5ca239e88c 100644
> > --- a/arch/arm64/include/asm/syscall_wrapper.h
> > +++ b/arch/arm64/include/asm/syscall_wrapper.h
> > @@ -19,7 +19,7 @@
> >  
> >  #define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
> >  	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs);		\
> > -	ALLOW_ERROR_INJECTION(__arm64_compat_sys##name, ERRNO);				\
> > +	ALLOW_ERROR_INJECTION(__arm64_compat_sys##name, SYSCALL);				\
> 
> But in that case, please don't use ALLOW_ERROR_INJECTION. I don't want to
> mix up the function-level error injection(FEI) and syscall error injection.

Are you suggesting to copy-paste ALLOW_ERROR_INJECTION logic into another
special section, another vmlinux.lds.h hack, copy-paste of lib/error-inject.c ?
Only to have a different name? Sorry, but that makes no sense.
syscalls return errno towards user space,
while the rest of 'error inject' funcs return errno towards the kernel.
Both are quite similar. There is no need to duplicate:
debugfs_create_dir("error_injection", ...
fault_create_debugfs_attr("fail_function", ...

> For this reason, I want to decouple it from the FEI. FEI will be used
> for more kernel internal functions under development (or debugging),
> which can break something because it will forcibly change the code
> behavior and the kernel will be in unexpected state.

There is no 'unexpected state'.
When Josef added BPF_ALLOW_ERROR_INJECTION() in include/linux/bpf.h
we marked several functions in fs/btrfs/ this way.
Later more functions were marked.
The callers of all those functions have to be ready to deal with errors.
If any of the currently marked functions can oops the kernel it's a bug
in the caller and it has to be fixed, because normal execution can
sooner or later return similar error.
Consider ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
That function was specifically added to exercise memory allocation errors.
The bpf error injection mechanism is not the only one that can generate
the errors.

Later you renamed BPF_ALLOW_ERROR_INJECTION into ALLOW_ERROR_INJECTION in
commit 540adea3809f ("error-injection: Separate error-injection from kprobe"),
but the main purpose of "bpf error injection" stayed the same.
We didn't mark random kernel functions as 'inject errors here'.
Only those whose callers must do sane things in case of errors.

So attemp to 'will be used for more kernel internal functions under development'
doesn't fit the spirit for bpf error injection as it is today.
For this kind of random kernel injection please use some other mechanism.
We cannot allow bpf to change return values of random function.

As far as users of this [BPF_]ALLOW_ERROR_INJECTION...
I couldn't find any blog, article or post that is talking about
text interface to tweak return values /sys/kernel/debug/fail_function.
Only links to kernel doc.
But there are plenty of BPF users of error injection. Like:
https://github.com/iovisor/bcc/blob/master/tools/inject_example.txt
https://chaos-mesh.org/docs/simulate-kernel-chaos-on-kubernetes/
https://github.com/iovisor/bpftrace/blob/master/docs/reference_guide.md#20-override-override-return-value
so we should tailor this 'error injection' facility to actual users
and not hypothetical 'more kernel internal functions under development'.
