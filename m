Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1AB70FD28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjEXRtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjEXRtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:49:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0F8D3;
        Wed, 24 May 2023 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6wNxw+nducg4EyIUz4whyVHInx2gaaIUR5Txh0QLUdM=; b=Ax930C8zsyJklztV6uvrnNZBHy
        2qM/RnIANtcIKaqE4wABLMFsgYAG96YhxokTN4lGILdq5iMN4uJo0y/pwykuIhfrGULe/4liiBe59
        YTeM0DtLDc3nS5/ziY431sQcKQFdu7w1S67AX1MK+GdCnqnzaw/GdJ4Da56/ZcVfVD74O1pM6w1J1
        Ial9Xt818ZsNV/atXzq24OO1HHEqa6mYjkmdhZIolEAu3VOd/s4b1xGNyJ1crDRfW2+YntsRuVihp
        oufE8A7WzM3obXJXSnpSMtb7UUmKBOW1wyKd95xy1zW8NlRqd4mgQwD0wF/iIXObXjdj91J4/za7e
        MTO+wqnQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1sbp-00EFuy-1R;
        Wed, 24 May 2023 17:49:13 +0000
Date:   Wed, 24 May 2023 10:49:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [linus:master] [module] 8660484ed1:
 WARNING:at_kernel/module/dups.c:#kmod_dup_request_exists_wait
Message-ID: <ZG5OGRDfIbMs6sxz@bombadil.infradead.org>
References: <202305221508.753c7b78-yujie.liu@intel.com>
 <ZG2doZJrCK7Nlrqf@bombadil.infradead.org>
 <ZG3Ho7eK+KqoAdda@yujie-X299>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG3Ho7eK+KqoAdda@yujie-X299>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 04:15:31PM +0800, Yujie Liu wrote:
> Hi Luis,
> 
> On Tue, May 23, 2023 at 10:16:17PM -0700, Luis Chamberlain wrote:
> > On Mon, May 22, 2023 at 03:51:59PM +0800, kernel test robot wrote:
> > > Hello,
> > > 
> > > kernel test robot noticed "WARNING:at_kernel/module/dups.c:#kmod_dup_request_exists_wait" on:
> > > 
> > > commit: 8660484ed1cf3261e89e0bad94c6395597e87599 ("module: add debugging auto-load duplicate module support")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > [test failed on linux-next/master 798d276b39e984345d52b933a900a71fa0815928]
> > > 
> > > in testcase: boot
> > > 
> > > compiler: gcc-11
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > > 
> > > We are not sure if this is expected as this patch is for debugging
> > > duplicate module requests issues, so we are sending this report for
> > > your information. Thanks.
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202305221508.753c7b78-yujie.liu@intel.com
> > > 
> > > 
> > > [   48.705567][    T1] ------------[ cut here ]------------
> > > [   48.706519][    T1] module-autoload: duplicate request for module intel_qat
> > > [ 48.707866][ T1] WARNING: CPU: 0 PID: 1 at kernel/module/dups.c:183 kmod_dup_request_exists_wait (kernel/module/dups.c:183 (discriminator 1)) 
> > 
> > This is a real issue since CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE was enabled.
> > If you enable CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE and these warnings
> > come up a bette detailed report would be better. In this case the goal
> > was to capture races of request_module() and so the idea for developers
> > is to identify the module that caused this, in this case intel_qat, and
> > then see who called the request_module() for it. They could try things
> > like try_module_get(), but could also ensure that multiple requests
> > won't be done in the code by using locking schemes or whatever. Only
> > one request should be issued.
> > 
> > The trace below would show possible users but I don't even see
> > drivers/crypto/qat/qat_c3xxx/adf_drv.c in my kernel tree.
> > 
> > If you don't to deal with this reporting you can just disable this
> > config option.
> 
> Thanks a lot for the information. Does this indicate that there is
> indeed a multiple requests issue in that crypto driver and we could
> report to its author/owner? Thanks.

Not for the crypto driver, there are multiple requests for
something like:

  request_module("intel_qat")

the trace shows who it could be. A git grep shows:

git grep request_module | grep intel_qat
drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c: request_module("intel_qat");
drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c: request_module("intel_qat");
drivers/crypto/intel/qat/qat_c62x/adf_drv.c: request_module("intel_qat");
drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c: request_module("intel_qat");
drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c: request_module("intel_qat");
drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c: request_module("intel_qat");

And so there should be one request issued, ideally.

Nothing bad happens of multiple request are sent, however duplicate
requests means that you can end up userspace trying to load multiple
requests just for one to be freed.

This is not a serious bug.

Soon, I'll implement a solution so that even if duplicate requests get
to userspace it won't trigger a duplicate load in-kernel, and therefore
duplicate module loads won't have to free the extra ones. At that point
this becomes less of an issue.

request_module() just calls to modprobe, and modprobe is supposed to
check if a module is already loaded before trying finit_module(). If
two duplicate requests end up calling modprobe though there is a small
race that two concurrent finit_module() calls will happen as userspace
would not have seen one load request going in before. The issue is that
finit_module() uses vmalloc space multiple times for the size of the
module, even if the module is a duplicate. One vmalloc space is for
kernel_read*() call, the other is for the copy we want to keep around
in kernel, the final copy. If module deeecompression is used another
vmalloc is used. So in the worst case 3 vmallocs.

A duplicate request could end up being failed only to find out a module
is already loaded, and so about 2-3 times the size of vmalloc space of
a module size could be free'd just due to a duplicate.

We could avoid memory pressure proactively by trying to issue only one
request out.

CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS was added to detect these possible
duplicates when they were triggered by module-autoloading, through the
request_module() API, directly from the kernel. It turns out that there
aren't many of these duplicates. That was the point to the exercise.
To proove the kernel likely wasn't the one causing tons of duplicates.

Because if you enable CONFIG_MODULE_STATS and then cat /sys/kernel/debug/modules/stats
you will see tons of duplicates. This gets worse  by the number of CPUs
you have. Seeing little reports of CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS
proves the issue is elsewhere and at this point I'm certain this is
coming from udev kmod library usage and it forking and not being able
to detect the same context for the kmod library for loading modules,
and so duplicate module request go out for tons of modules for each CPU.

See commit 064f4536d13939 ("module: avoid allocation if module is
already present and ready") for a graph of this.

That commit also prevents having to do one vmalloc allocation if the
module is already present. I'm going to work now on one which prevents
the first, and so duplicates requests coming from either userspace or
the module-autoloader should be harmless. But that is not merged yet,
and I still have to post the patch.

So in the meantime CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE should only
be enabled so to try to help those who wish to be proactive and want
to enhance the kernel module auto-loader so to only issue one
request_module() for a module needed by the kernel.

Technically CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS also implements a
way to unify requests for the same module into one, and they all
share the same result, but this works only for non-async calls to
request_module(). That config option is a debug mechanism right now,
but we could make it default later.

> Not sure if I undertand this correctly: enabling
> CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE can help detect multiple
> requests issues in existing code, so we should report to the original
> author of the modules that have this issue,

It would be an optimization that they could make. It is not a serious
bug. It would be a more serious bug if we had tons of these reports
all over. But a few, no.

Come to think of it, at this point in time CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE
should just be considered informational and debugging, no need to report
anything to anyone becuase I do think I can get the vmalloc wasted
space issue figured out for userspace and kernel module-autoloader,
and so this becomes a non-issue at all. Yes, it would still be nice
to reduce latencies by having duplicate requests not be issued, but
the developers keen on that would enable CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE.

So I'd say enable CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE only if
you want to avoid help avoid duplicates yourself. The kconfig language
already is a bit clear about that, but we could enhance it to explain
the gains for developers who may want this. Since we can't talk about
the future though in kconfig, I think the language now is OK.

The bigger source of duplicates has been determined to come from
userspace, I'll Cc you on a patch to fix the last vmalloc wasted
space, so that this would never incur tons of wasted vmalloc space.

I'd recommend for now to just disable CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE
unless you want to make the reports informational and describe the
situation as I just did.

Actually, could we talk soon about testing? Because I want to automate
some more tests for modules with kdevops.

> but shouldn't report on
> this commit that introduces the CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE
> option?

Not sure I understand this question.

  Luis
