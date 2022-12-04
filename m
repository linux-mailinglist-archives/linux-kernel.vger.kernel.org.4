Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0649A64201F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLDWub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiLDWuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:50:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6834FAED
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 14:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35AEB60F0D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 22:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309D1C433C1;
        Sun,  4 Dec 2022 22:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670194220;
        bh=llhY6K//QrKHHMCXAm2vnC5UWiH9N73A5scTeFrKjvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z1vdfKWdyhGtA+kkv+uQjl8gbM8zdIlGtg9tXkUBWqLjlJjqNZvX/kMigNpGATLQc
         KIsIJ1v7vxgx1qWnuuM7EJgjYuFvdr5DVOABk5itQkCqRhfTy7iDTX7U2xTgK9SUx+
         x+MibnqZU6LczNQFeIhNqyMR2qk543jQtTtLfuTmskHG+JjlhAjfNS90N5m8Lc0WLp
         6JEQYs/2Avwjp8a0LYZzsZbbRyZJoUMV39F4w9YR8B//z/o1p4zwz9BE1V9V5V93oV
         iYZEjC3dypIftyGV83q5lpnvxzWvAcrYMNzVtcQopDF8pAe7ropoRx62f7QgGxVite
         5eN5NGWulsTHA==
Date:   Mon, 5 Dec 2022 07:50:15 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Christoph Hellwig <hch@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error
 injection
Message-Id: <20221205075015.71226685a254fe86aa9f1fcc@kernel.org>
In-Reply-To: <20221202212711.5ot66apmazm4yz6y@macbook-pro-6.dhcp.thefacebook.com>
References: <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
        <Y3ymzAYRyH5IWEe/@zn.tnic>
        <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
        <20221122132905.12a8d5ad@gandalf.local.home>
        <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
        <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
        <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
        <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
        <20221202014129.n5lmvzsy436ebo4b@macbook-pro-6.dhcp.thefacebook.com>
        <Y4ogRH7zWLpmVXzJ@mit.edu>
        <20221202212711.5ot66apmazm4yz6y@macbook-pro-6.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 13:27:11 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Dec 02, 2022 at 10:56:52AM -0500, Theodore Ts'o wrote:
> > On Thu, Dec 01, 2022 at 05:41:29PM -0800, Alexei Starovoitov wrote:
> > > 
> > > The fault injection framework disables individual syscall with zero performance
> > > overhead comparing to LSM and seccomp mechanisms.
> > > BPF is not involved here. It's a kprobe in one spot.
> > > All other syscalls don't notice it.
> > > It's an attractive way to improve security.
> > > 
> > > A BPF prog over syscall can filter by user, cgroup, task and give fine grain
> > > control over security surface.
> > > tbh I'm not aware of folks doing "syscall disabling" through command line like
> > > above (I've only seen it through bpf), but it doesn't mean that somebody will
> > > not start complaining that their script broke, because distro disabled fault
> > > injection.
> > > 
> > > So should we split FUNCTION_ERROR_INJECTION kconfig into two ?
> > > And do default N for things like should_failslab() and
> > > default Y for syscalls?
> > 
> > How about calling the latter something like bpf syscall hooks, and not
> > using the terminology "error injection" in relation to system calls?
> > I think that might be less confusing.
> 
> I think 'syscall error injection' name fits well.
> It's a generic feature that both kprobes and bpf should be able to use.
> Here is the patch...
> 
> Even with this patch we have 7 failures in BPF selftests.
> We will fix them later with the same mechanism as we will pick for hid-bpf.
> 
> This patch will keep 'syscall disabling' scripts working
> and bpf syscall adjustment will work too.
> So no chance of breaking anyone.
> While actual error injection inside the kernel will be disabled.
> 
> Better name suggestions are welcome, of course.
> 
> From 2960958f91d1134b1a8f27787875f6b9300f205e Mon Sep 17 00:00:00 2001
> From: Alexei Starovoitov <ast@kernel.org>
> Date: Fri, 2 Dec 2022 13:06:08 -0800
> Subject: [PATCH] error-injection: Split FUNCTION_ERROR_INJECTION into syscalls
>  and the rest.
> 
> Split FUNCTION_ERROR_INJECTION into:
> - SYSCALL_ERROR_INJECTION with default y
> - FUNC_ERROR_INJECTION with default n.

OK, syscall is a bit different, it is clearly the boundary of the
functionality, so this seems safe.
IMHO, it is better to extend seccomp framework for testing.

> 
> The former is only used to modify return values of syscalls for security and
> user space testing reasons while the latter is for the rest of error injection
> in the kernel that should only be used to stress test and debug the kernel.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  arch/arm64/include/asm/syscall_wrapper.h   |  8 ++++----
>  arch/powerpc/include/asm/syscall_wrapper.h |  4 ++--
>  arch/s390/include/asm/syscall_wrapper.h    | 12 ++++++------
>  arch/x86/include/asm/syscall_wrapper.h     |  4 ++--
>  include/asm-generic/error-injection.h      |  1 +
>  include/linux/compat.h                     |  4 ++--
>  include/linux/syscalls.h                   |  4 ++--
>  kernel/fail_function.c                     |  1 +
>  lib/Kconfig.debug                          | 15 +++++++++++++++
>  lib/error-inject.c                         |  6 ++++++
>  10 files changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
> index d30217c21eff..2c5ca239e88c 100644
> --- a/arch/arm64/include/asm/syscall_wrapper.h
> +++ b/arch/arm64/include/asm/syscall_wrapper.h
> @@ -19,7 +19,7 @@
>  
>  #define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
>  	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs);		\
> -	ALLOW_ERROR_INJECTION(__arm64_compat_sys##name, ERRNO);				\
> +	ALLOW_ERROR_INJECTION(__arm64_compat_sys##name, SYSCALL);				\

But in that case, please don't use ALLOW_ERROR_INJECTION. I don't want to
mix up the function-level error injection(FEI) and syscall error injection.

For this reason, I want to decouple it from the FEI. FEI will be used
for more kernel internal functions under development (or debugging),
which can break something because it will forcibly change the code
behavior and the kernel will be in unexpected state.

Thank you,

>  	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
>  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
>  	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs)		\
> @@ -34,7 +34,7 @@
>  
>  #define COMPAT_SYSCALL_DEFINE0(sname)							\
>  	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused);	\
> -	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);			\
> +	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, SYSCALL);			\
>  	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused)
>  
>  #define COND_SYSCALL_COMPAT(name) 							\
> @@ -50,7 +50,7 @@
>  
>  #define __SYSCALL_DEFINEx(x, name, ...)						\
>  	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);		\
> -	ALLOW_ERROR_INJECTION(__arm64_sys##name, ERRNO);			\
> +	ALLOW_ERROR_INJECTION(__arm64_sys##name, SYSCALL);			\
>  	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
>  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
>  	asmlinkage long __arm64_sys##name(const struct pt_regs *regs)		\
> @@ -69,7 +69,7 @@
>  #define SYSCALL_DEFINE0(sname)							\
>  	SYSCALL_METADATA(_##sname, 0);						\
>  	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);	\
> -	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);			\
> +	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, SYSCALL);			\
>  	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused)
>  
>  #define COND_SYSCALL(name)							\
> diff --git a/arch/powerpc/include/asm/syscall_wrapper.h b/arch/powerpc/include/asm/syscall_wrapper.h
> index 67486c67e8a2..ce1148809c6b 100644
> --- a/arch/powerpc/include/asm/syscall_wrapper.h
> +++ b/arch/powerpc/include/asm/syscall_wrapper.h
> @@ -17,7 +17,7 @@ struct pt_regs;
>  
>  #define __SYSCALL_DEFINEx(x, name, ...)						\
>  	long sys##name(const struct pt_regs *regs);			\
> -	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
> +	ALLOW_ERROR_INJECTION(sys##name, SYSCALL);			\
>  	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
>  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
>  	long sys##name(const struct pt_regs *regs)			\
> @@ -36,7 +36,7 @@ struct pt_regs;
>  #define SYSCALL_DEFINE0(sname)							\
>  	SYSCALL_METADATA(_##sname, 0);						\
>  	long sys_##sname(const struct pt_regs *__unused);		\
> -	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);			\
> +	ALLOW_ERROR_INJECTION(sys_##sname, SYSCALL);			\
>  	long sys_##sname(const struct pt_regs *__unused)
>  
>  #define COND_SYSCALL(name)							\
> diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
> index fde7e6b1df48..a253def48cbe 100644
> --- a/arch/s390/include/asm/syscall_wrapper.h
> +++ b/arch/s390/include/asm/syscall_wrapper.h
> @@ -58,7 +58,7 @@
>  
>  #define __S390_SYS_STUBx(x, name, ...)						\
>  	long __s390_sys##name(struct pt_regs *regs);				\
> -	ALLOW_ERROR_INJECTION(__s390_sys##name, ERRNO);				\
> +	ALLOW_ERROR_INJECTION(__s390_sys##name, SYSCALL);				\
>  	long __s390_sys##name(struct pt_regs *regs)				\
>  	{									\
>  		long ret = __do_sys##name(SYSCALL_PT_ARGS(x, regs,		\
> @@ -74,13 +74,13 @@
>  #define COMPAT_SYSCALL_DEFINE0(sname)					\
>  	SYSCALL_METADATA(_##sname, 0);					\
>  	long __s390_compat_sys_##sname(void);				\
> -	ALLOW_ERROR_INJECTION(__s390_compat_sys_##sname, ERRNO);	\
> +	ALLOW_ERROR_INJECTION(__s390_compat_sys_##sname, SYSCALL);	\
>  	long __s390_compat_sys_##sname(void)
>  
>  #define SYSCALL_DEFINE0(sname)						\
>  	SYSCALL_METADATA(_##sname, 0);					\
>  	long __s390x_sys_##sname(void);					\
> -	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
> +	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, SYSCALL);		\
>  	long __s390_sys_##sname(void)					\
>  		__attribute__((alias(__stringify(__s390x_sys_##sname)))); \
>  	long __s390x_sys_##sname(void)
> @@ -100,7 +100,7 @@
>  	long __s390_compat_sys##name(struct pt_regs *regs);				\
>  	long __s390_compat_sys##name(struct pt_regs *regs)				\
>  		__attribute__((alias(__stringify(__se_compat_sys##name))));		\
> -	ALLOW_ERROR_INJECTION(__s390_compat_sys##name, ERRNO);				\
> +	ALLOW_ERROR_INJECTION(__s390_compat_sys##name, SYSCALL);				\
>  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
>  	long __se_compat_sys##name(struct pt_regs *regs);				\
>  	long __se_compat_sys##name(struct pt_regs *regs)				\
> @@ -131,7 +131,7 @@
>  #define SYSCALL_DEFINE0(sname)						\
>  	SYSCALL_METADATA(_##sname, 0);					\
>  	long __s390x_sys_##sname(void);					\
> -	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
> +	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, SYSCALL);		\
>  	long __s390x_sys_##sname(void)
>  
>  #define COND_SYSCALL(name)						\
> @@ -148,7 +148,7 @@
>  		      "Type aliasing is used to sanitize syscall arguments");		\
>  	long __s390x_sys##name(struct pt_regs *regs)					\
>  		__attribute__((alias(__stringify(__se_sys##name))));			\
> -	ALLOW_ERROR_INJECTION(__s390x_sys##name, ERRNO);				\
> +	ALLOW_ERROR_INJECTION(__s390x_sys##name, SYSCALL);				\
>  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));		\
>  	long __se_sys##name(struct pt_regs *regs);					\
>  	__S390_SYS_STUBx(x, name, __VA_ARGS__)						\
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index fd2669b1cb2d..ca0cd8fa1866 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -67,13 +67,13 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>  
>  #define __SYS_STUB0(abi, name)						\
>  	long __##abi##_##name(const struct pt_regs *regs);		\
> -	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
> +	ALLOW_ERROR_INJECTION(__##abi##_##name, SYSCALL);			\
>  	long __##abi##_##name(const struct pt_regs *regs)		\
>  		__alias(__do_##name);
>  
>  #define __SYS_STUBx(abi, name, ...)					\
>  	long __##abi##_##name(const struct pt_regs *regs);		\
> -	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
> +	ALLOW_ERROR_INJECTION(__##abi##_##name, SYSCALL);			\
>  	long __##abi##_##name(const struct pt_regs *regs)		\
>  	{								\
>  		return __se_##name(__VA_ARGS__);			\
> diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
> index fbca56bd9cbc..c4fb52f5b789 100644
> --- a/include/asm-generic/error-injection.h
> +++ b/include/asm-generic/error-injection.h
> @@ -9,6 +9,7 @@ enum {
>  	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
>  	EI_ETYPE_ERRNO_NULL,	/* Return -ERRNO or NULL if failure */
>  	EI_ETYPE_TRUE,		/* Return true if failure */
> +	EI_ETYPE_SYSCALL,	/* Return -ERRNO out of syscall */
>  };
>  
>  struct error_injection_entry {
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 594357881b0b..21d2fd48f7e2 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -45,7 +45,7 @@
>  #ifndef COMPAT_SYSCALL_DEFINE0
>  #define COMPAT_SYSCALL_DEFINE0(name) \
>  	asmlinkage long compat_sys_##name(void); \
> -	ALLOW_ERROR_INJECTION(compat_sys_##name, ERRNO); \
> +	ALLOW_ERROR_INJECTION(compat_sys_##name, SYSCALL); \
>  	asmlinkage long compat_sys_##name(void)
>  #endif /* COMPAT_SYSCALL_DEFINE0 */
>  
> @@ -74,7 +74,7 @@
>  		      "Type aliasing is used to sanitize syscall arguments");\
>  	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
>  		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
> -	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
> +	ALLOW_ERROR_INJECTION(compat_sys##name, SYSCALL);				\
>  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
>  	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
>  	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a34b0f9a9972..05fc3a0575c0 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -210,7 +210,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>  #define SYSCALL_DEFINE0(sname)					\
>  	SYSCALL_METADATA(_##sname, 0);				\
>  	asmlinkage long sys_##sname(void);			\
> -	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
> +	ALLOW_ERROR_INJECTION(sys_##sname, SYSCALL);		\
>  	asmlinkage long sys_##sname(void)
>  #endif /* SYSCALL_DEFINE0 */
>  
> @@ -241,7 +241,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>  		      "Type aliasing is used to sanitize syscall arguments");\
>  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
>  		__attribute__((alias(__stringify(__se_sys##name))));	\
> -	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
> +	ALLOW_ERROR_INJECTION(sys##name, SYSCALL);			\
>  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
>  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
>  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index a7ccd2930c5f..65d3f5db5f3a 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -38,6 +38,7 @@ static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
>  	switch (get_injectable_error_type(addr)) {
>  	case EI_ETYPE_NULL:
>  		return 0;
> +	case EI_ETYPE_SYSCALL:
>  	case EI_ETYPE_ERRNO:
>  		if (retv < (unsigned long)-MAX_ERRNO)
>  			return (unsigned long)-EINVAL;
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 38545c56bf69..729002405a55 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1874,8 +1874,12 @@ config NETDEV_NOTIFIER_ERROR_INJECT
>  	  If unsure, say N.
>  
>  config FUNCTION_ERROR_INJECTION
> +        bool
> +
> +config FUNC_ERROR_INJECTION
>  	bool "Fault-injections of functions"
>  	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
> +	select FUNCTION_ERROR_INJECTION
>  	help
>  	  Add fault injections into various functions that are annotated with
>  	  ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
> @@ -1883,6 +1887,17 @@ config FUNCTION_ERROR_INJECTION
>  
>  	  If unsure, say N
>  
> +config SYSCALL_ERROR_INJECTION
> +	bool "Error injections in syscalls"
> +	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
> +	select FUNCTION_ERROR_INJECTION
> +	default y
> +	help
> +	  Allows error injection framework to return errors from syscalls.
> +	  BPF may modify return values of syscalls as well.
> +
> +	  If unsure, say Y
> +
>  config FAULT_INJECTION
>  	bool "Fault-injection framework"
>  	depends on DEBUG_KERNEL
> diff --git a/lib/error-inject.c b/lib/error-inject.c
> index 1afca1b1cdea..9ba868eb8c43 100644
> --- a/lib/error-inject.c
> +++ b/lib/error-inject.c
> @@ -71,6 +71,10 @@ static void populate_error_injection_list(struct error_injection_entry *start,
>  
>  	mutex_lock(&ei_mutex);
>  	for (iter = start; iter < end; iter++) {
> +		if (iter->etype != EI_ETYPE_SYSCALL &&
> +		    !IS_ENABLED(CONFIG_FUNC_ERROR_INJECTION))
> +			continue;
> +
>  		entry = (unsigned long)dereference_symbol_descriptor((void *)iter->addr);
>  
>  		if (!kernel_text_address(entry) ||
> @@ -189,6 +193,8 @@ static const char *error_type_string(int etype)
>  		return "ERRNO_NULL";
>  	case EI_ETYPE_TRUE:
>  		return "TRUE";
> +	case EI_ETYPE_SYSCALL:
> +		return "SYSCALL";
>  	default:
>  		return "(unknown)";
>  	}
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
