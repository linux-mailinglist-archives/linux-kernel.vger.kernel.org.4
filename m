Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C496D1633
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCaEGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCaEGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:06:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9CFEF81;
        Thu, 30 Mar 2023 21:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gBX524btH9snFWHEFtS36Ef/+oCds0DOnnoMhfwMpMA=; b=J1eZx8Rm7eysxvm+rRg6aidaJ5
        EGFAyV5KfQyxXPN9YFGgTfqF6YmMSxY/FV/CmA79NzzL7oSkW/V9lKfAVv6mwsatzXGp4BqvbAuMN
        XBUhT/rUA5CPn1K3nq2RIQPRW7cARbZR0X3duW6ogmIepNETe/GVQx72OM6rQw3X2SMKVxNcYkNxS
        Tc6cEWSAOelrW9o8mCm+JSXZjsWwBzNkoYerEK5fbL7xcme213r4+GZLK2OaWv5RNjfjVDRNBFJ4P
        i7QXH9DzxP8NyCHnerM5zHKUcI8t14VI60PhR/CwgeCDND7pSHApYpHfpwwd7Df1L9qJqM2hJ4KcE
        QGYNq4AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pi61p-00B4Tq-CB; Fri, 31 Mar 2023 04:06:17 +0000
Date:   Fri, 31 Mar 2023 05:06:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, petr.pavlu@suse.com,
        prarit@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de, song@kernel.org,
        rppt@kernel.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
Message-ID: <ZCZcOQBLwv+MRrT3@casper.infradead.org>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net>
 <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
 <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
 <20230330115626.GA124812@hirez.programming.kicks-ass.net>
 <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
 <ZCZXcJ+KJffpFrpX@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCZXcJ+KJffpFrpX@bombadil.infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 08:45:52PM -0700, Luis Chamberlain wrote:
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 291d4167fab8..00c9fcd90e1a 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1177,7 +1177,7 @@ static const struct {
>  static struct ratelimit_state bld_ratelimit;
>  
>  static unsigned int sysctl_sld_mitigate = 1;
> -static DEFINE_SEMAPHORE(buslock_sem);
> +static DEFINE_MUTEX(buslock_sem);
>  
>  #ifdef CONFIG_PROC_SYSCTL
>  static struct ctl_table sld_sysctls[] = {
> @@ -1315,7 +1315,7 @@ static void split_lock_init(void)
>  static void __split_lock_reenable_unlock(struct work_struct *work)
>  {
>  	sld_update_msr(true);
> -	up(&buslock_sem);
> +	mutex_unlock(&buslock_sem);
>  }
>  
>  static DECLARE_DELAYED_WORK(sl_reenable_unlock, __split_lock_reenable_unlock);

^^^ clearly unsafe.  __split_lock_reenable_unlock() is called as a
delayed_work(), ie not in the context of the mutex locker.  lockdep
will freak out at this.

> @@ -351,12 +351,12 @@ virt_efi_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
>  {
>  	efi_status_t status;
>  
> -	if (down_trylock(&efi_runtime_lock))
> +	if (!mutex_trylock(&efi_runtime_lock))
>  		return EFI_NOT_READY;

looks to me like this can be called while we're oopsing.  if that's in
non-process context, lockdep will get angry.

> @@ -149,10 +149,10 @@ EXPORT_SYMBOL_NS_GPL(efivar_lock, EFIVAR);
>   */
>  int efivar_trylock(void)
>  {
> -	if (down_trylock(&efivars_lock))
> +	if (!mutex_trylock(&efivars_lock))

also can be called from oops context.

> @@ -228,7 +228,7 @@ adb_probe_task(void *x)
>  	do_adb_reset_bus();
>  	pr_debug("adb: finished probe task...\n");
>  
> -	up(&adb_probe_mutex);
> +	mutex_unlock(&adb_probe_mutex);

adb_probe_task() can be called from a different context than the lock
holder.

> @@ -10594,7 +10594,7 @@ static bool bnx2x_prev_is_path_marked(struct bnx2x *bp)
>  	struct bnx2x_prev_path_list *tmp_list;
>  	bool rc = false;
>  
> -	if (down_trylock(&bnx2x_prev_sem))
> +	if (!mutex_trylock(&bnx2x_prev_sem))

bet you this can be called from interrupt context.

this really isn't something to use coccinelle for.
