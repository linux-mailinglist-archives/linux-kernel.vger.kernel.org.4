Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6F6D249C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjCaQFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCaQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:05:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDE91EFC9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:05:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 43ADF1F8A3;
        Fri, 31 Mar 2023 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680278731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3FsFrFZEEvyj+FZQD8XDhYw0Rbs8LXkmS09BCUboQc=;
        b=vssTaNEWuuOsvjH3CRaxUE7nk3r5WyiLxXjHnxHcAwsTHXqvcamczlJG+a/RTzstGjOEZ5
        A+v7TzmBTWvwU1rlJScZlbOr1IUEjCIlasM7gaJS4B2AkFT769JIugzmcOgKKLboutpMTn
        7hnRsV6zpCfqTsfxmGEbELMZJBiVwCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680278731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3FsFrFZEEvyj+FZQD8XDhYw0Rbs8LXkmS09BCUboQc=;
        b=lsKnCu+HdX2lZj2g10HGMbRNwSuJexFbUDF1aTZbyySaNPuFBHuk0Z8rZcnO4MmSKoqwYs
        0Kqb4TIvqTNVJVDA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7F6B42C141;
        Fri, 31 Mar 2023 16:05:28 +0000 (UTC)
Date:   Fri, 31 Mar 2023 18:05:27 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        nathanl@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] pseries/smp: export the smt level in the SYS FS.
Message-ID: <20230331160527.GA3132@kitsune.suse.cz>
References: <20230331153905.31698-1-ldufour@linux.ibm.com>
 <20230331153905.31698-2-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331153905.31698-2-ldufour@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Mar 31, 2023 at 05:39:04PM +0200, Laurent Dufour wrote:
> There is no SMT level recorded in the kernel neither in user space.
> Indeed there is no real constraint about that and mixed SMT levels are
> allowed and system is working fine this way.
> 
> However when new CPU are added, the kernel is onlining all the threads
> which is leading to mixed SMT levels and confuse end user a bit.
> 
> To prevent this exports a SMT level from the kernel so user space
> application like the energy daemon, could read it to adjust their settings.
> There is no action unless recording the value when a SMT value is written
> into the new sysfs entry. User space applications like ppc64_cpu should
> update the sysfs when changing the SMT level to keep the system consistent.
> 
> Suggested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/pseries.h |  3 ++
>  arch/powerpc/platforms/pseries/smp.c     | 39 ++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index f8bce40ebd0c..af0a145af98f 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -23,7 +23,9 @@ extern int pSeries_machine_check_exception(struct pt_regs *regs);
>  extern long pseries_machine_check_realmode(struct pt_regs *regs);
>  void pSeries_machine_check_log_err(void);
>  
> +
>  #ifdef CONFIG_SMP
> +extern int pseries_smt;
>  extern void smp_init_pseries(void);
>  
>  /* Get state of physical CPU from query_cpu_stopped */
> @@ -34,6 +36,7 @@ int smp_query_cpu_stopped(unsigned int pcpu);
>  #define QCSS_HARDWARE_ERROR -1
>  #define QCSS_HARDWARE_BUSY -2
>  #else
> +#define pseries_smt 1

Is this really needed for anything?

The code using pseries_smt would not compile with a define, and would be
only compiled with SMP enabled anyway so we should not need this.

Thanks

Michal

>  static inline void smp_init_pseries(void) { }
>  #endif
>  
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
> index c597711ef20a..6c382922f8f3 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -21,6 +21,7 @@
>  #include <linux/device.h>
>  #include <linux/cpu.h>
>  #include <linux/pgtable.h>
> +#include <linux/sysfs.h>
>  
>  #include <asm/ptrace.h>
>  #include <linux/atomic.h>
> @@ -45,6 +46,8 @@
>  
>  #include "pseries.h"
>  
> +int pseries_smt;
> +
>  /*
>   * The Primary thread of each non-boot processor was started from the OF client
>   * interface by prom_hold_cpus and is spinning on secondary_hold_spinloop.
> @@ -280,3 +283,39 @@ void __init smp_init_pseries(void)
>  
>  	pr_debug(" <- smp_init_pSeries()\n");
>  }
> +
> +static ssize_t pseries_smt_store(struct class *class,
> +			 struct class_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	int smt;
> +
> +	if (kstrtou32(buf, 0, &smt) || !smt || smt > (u32) threads_per_core) {
> +		pr_err("Invalid pseries_smt specified.\n");
> +		return -EINVAL;
> +	}
> +
> +	pseries_smt = smt;
> +
> +	return count;
> +}
> +
> +static ssize_t pseries_smt_show(struct class *class, struct class_attribute *attr,
> +			  char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", pseries_smt);
> +}
> +
> +static CLASS_ATTR_RW(pseries_smt);
> +
> +static int __init pseries_smt_init(void)
> +{
> +	int rc;
> +
> +	pseries_smt = smt_enabled_at_boot;
> +	rc = sysfs_create_file(kernel_kobj, &class_attr_pseries_smt.attr);
> +	if (rc)
> +		pr_err("Can't create pseries_smt sysfs/kernel entry.\n");
> +	return rc;
> +}
> +machine_device_initcall(pseries, pseries_smt_init);
> -- 
> 2.40.0
> 
