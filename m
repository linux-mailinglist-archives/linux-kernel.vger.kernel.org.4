Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8B667E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjALTEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbjALTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:03:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B410FAE6B;
        Thu, 12 Jan 2023 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QAzSLI/6LHH9CQpLa9FURf4dHQ/1/6b6zFCg9vC993M=; b=wtor9ASerabdoMG62kjMOgrKW/
        WjRq7l+rFmwBT0qWGaWqbkjzdZa6MIw/Vw5JLkP7Da1JeDiNnWJvwZtRE65Z/hJLGlNsuRFWadnuz
        cmvONDkqZ6uLrlDWsSndiscQbzdP2DEMqBtIMRvuVgj11++gB8aVDRnhAtibCG5ESFdG20BIsuvre
        nUFD6LdmR+xrUbDK3v+5aPQHI5py1JR1078fyJwLxfjokVn+0lRSKlibzaxz4/Ysc3GRG1h6iKy1N
        FxUO67pKIJHrhS6wN4/0lGz0VNWw7XBqMxZHz68V2sRaorrH3jiUGaaAtaHVVaSKTOe37h2igH0UA
        Q3mF/EHg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pG2Za-00GKda-BY; Thu, 12 Jan 2023 18:45:10 +0000
Date:   Thu, 12 Jan 2023 10:45:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Petr Mladek <pmladek@suse.com>, prarit@redhat.com,
        david@redhat.com, mwilck@suse.com
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-modules@vger.kernel.org,
        John Haxby <john.haxby@oracle.com>,
        Jann Horn <jannh@google.com>, mcgrof@kernel.org
Subject: Re: [PATCH v3] kmod: harden user namespaces with new
 kernel.ns_modules_allowed sysctl
Message-ID: <Y8BVNihCrKOeY/FO@bombadil.infradead.org>
References: <20230112131911.7684-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112131911.7684-1-vegard.nossum@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:19:11PM +0100, Vegard Nossum wrote:
> Creating a new user namespace grants you the ability to reach a lot of code
> (including loading certain kernel modules) that would otherwise be out of
> reach of an attacker. We can reduce the attack surface and block exploits
> by ensuring that user namespaces cannot trigger module (auto-)loading.
> 
> A cursory search of exploits found online yields the following
> non-exhaustive list of vulnerabilities, and shows that the technique is
> both old and still in use:
> 
> - CVE-2016-8655
> - CVE-2017-1000112
> - CVE-2021-32606
> - CVE-2022-2588
> - CVE-2022-27666
> - CVE-2022-34918
> - CVE-2023-0179
> 
> A quick survey of common distros shows that Ubuntu, Fedora, RHEL, CentOS
> Stream, and Oracle Linux allow unprivileged user namespaces by default,
> probably to support sandboxing in browsers and containers. Major
> exceptions would be Debian and Arch Linux which carry an out-of-tree patch
> to disable user namespaces by default.
> 
> This patch adds a new sysctl, kernel.ns_modules_allowed, which when set to
> 0 will block requests to load modules when the request originates in a
> process running in a user namespace.
> 
> For backwards compatibility, the default value of the sysctl is set to
> CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON, which in turn defaults to 1, meaning
> there should be absolutely no change in behaviour unless you opt in either
> at compile time or at runtime.
> 
> This mitigation obviously offers no protection if the vulnerable module is
> already loaded, but for many of these exploits the vast majority of users
> will never actually load or use these modules on purpose; in other words,
> for the vast majority of users, this would block exploits for the above
> list of vulnerabilities.
> 
> Testing: Running the reproducer for CVE-2022-2588 fails and results in the
> following message in the kernel log:
> 
>     [  130.208030] request_module: pid 4107 (a.out) requested kernel module rtnl-link-dummy; denied due to kernel.ns_modules_allowed sysctl
> 
> v2:
> - fix build failure due to missing CONFIG_SYSCTL guard around register_sysctl_init()
> - use .maxlen = sizeof(int) for proc_dobool()
> - don't warn when sysctl_ns_modules_allowed == 1
> 
> v3:
> - drop capable(CAP_SYS_MODULE) check
> - add a new CVE to changelog :-)
> - add survey of distros that enable unpriv userns to changelog
> 
> Link: https://lore.kernel.org/lkml/20220809185229.28417-1-vegard.nossum@oracle.com/ # v1
> Link: https://lore.kernel.org/lkml/20220815082753.6088-1-vegard.nossum@oracle.com/ # v2
> Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-modules@vger.kernel.org
> Cc: John Haxby <john.haxby@oracle.com>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 11 ++++++
>  init/Kconfig                                | 17 ++++++++++
>  kernel/kmod.c                               | 37 +++++++++++++++++++++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 46e3d62c0eea..bd9b4e911a6a 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -612,6 +612,17 @@ A value of 0 means no change. The default value is 200 meaning the NMI
>  watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).
>  
>  
> +ns_modules_allowed
> +==================
> +
> +Control whether processes may trigger module loading inside a user namespace.

This is false documentation. The place it is trying to protect simply
prevents trying to call modprobe for auto-loading within the kernel.

> diff --git a/kernel/kmod.c b/kernel/kmod.c
> index b717134ebe17..938c0a39381a 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -25,6 +25,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/async.h>
>  #include <linux/uaccess.h>
> +#include <linux/sysctl.h>
>  
>  #include <trace/events/module.h>
>  
> @@ -105,6 +106,12 @@ static int call_modprobe(char *module_name, int wait)
>  	return -ENOMEM;
>  }
>  
> +/*
> + * Allow processes running inside namespaces to trigger module loading?
> + */
> +static bool sysctl_ns_modules_allowed __read_mostly =
> +	IS_BUILTIN(CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON);
> +
>  /**
>   * __request_module - try to load a kernel module
>   * @wait: wait (or not) for the operation to complete
> @@ -148,6 +155,16 @@ int __request_module(bool wait, const char *fmt, ...)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Disallow module loading if we're in a user namespace.
> +	 */
> +	if (current_user_ns() != &init_user_ns &&
> +	    !sysctl_ns_modules_allowed) {
> +		pr_warn_ratelimited("request_module: pid %d (%s) in user namespace requested kernel module %s; denied due to kernel.ns_modules_allowed sysctl\n",
> +			task_pid_nr(current), current->comm, module_name);
> +		return -EPERM;
> +	}
> +
>  	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
>  		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
>  				    atomic_read(&kmod_concurrent_max),

Have you seen what call_modprobe() does?

This is just a limitting the auto-loading through calling modprobe.
If the concern is to load modules wouldn't you be better off just
putting a stop gap at finit_module() which actually receives the
load attempt from modprobe? Ie, an evil namespace, if it has access
to /sbin/modprobe could simply just try calling /sbin/modprobe on its
own.

Beating the royal shit out of kmod is already stress tested via
tools/testing/selftests/kmod/kmod.sh in particular:

tools/testing/selftests/kmod/kmod.sh -t 0008
tools/testing/selftests/kmod/kmod.sh -t 0009

What this *could* do is race to force a failure on some other *real*
modprobe request we do wish to honor when the above kmod kmod_concurrent_max
is triggered.

So in terms of justification, this commit log needs a bit more work as I
just can't see how this alone is fixing any CVE.

Note: actually *racing* tons of requests at the same time could end
up then *in kernel requests* being processed, and there lies another
shit show which we've recently been nose diving into through the work
and report by Petr Pavlu [0]. Although I have that patch in modules-next,
it was too soon to send to Linus for v6.2-rc1 due to lack of testing on
linux-next. You may want to test that too, as its an old regression.
Even though the commit log describe honest requests for modules, surely
an exploit bad namespace could in theory try to race other requests too
to prefer its own frequency module, etc.

So let's take a step back and think this through. What exaclty and why
would this commit fix *any* security issue? Itemizing CVEs won't cut it.

[0] https://lkml.kernel.org/r/20221205103557.18363-1-petr.pavlu@suse.com

  Luis
