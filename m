Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4FD667E72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjALSzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbjALSyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:54:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7971FFE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qP5Y2eUFT5kgzAIkCgX2pt1Occzxryjhe5CUsEAITVc=; b=ias47fpdwEIOZ53RC1IvMwWSaK
        QguCsnNLqb9UTnaJreclpAKZIA+R9v6ugogJTyWksoDcBDy60VwsL2YXgr3TvPvQp9XZzeDuU0Vig
        Wnl4vp382Xu+wYWz2LyUhLPBd6s4hyv6U7+z4DHuhvHzIdJrwH3SSyCu/v/1n/13vq12Yb7jYb31V
        qbtr7au2kIKzt2bBDb7hqnVhNKdI2QnfwOYznIXsF8R0lZsV2xixybxvacBQ+zZjYYY9zfPYUFU0x
        oO98Ucyi8ffYqcPfrXsG/m6qvpfncKCX/B+QF2X22yYlYaLQsDh8JlEki+qvX40RkYShtL7yxmkD8
        7HW3qrXA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pG2Fn-00GINn-7e; Thu, 12 Jan 2023 18:24:43 +0000
Date:   Thu, 12 Jan 2023 10:24:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        "Erhard F ." <erhard_f@mailbox.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] kallsyms: Fix scheduling with interrupts disabled in
 self-test
Message-ID: <Y8BQaw5tVzDjZ9Sz@bombadil.infradead.org>
References: <20230112105426.1037325-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112105426.1037325-1-npiggin@gmail.com>
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

On Thu, Jan 12, 2023 at 08:54:26PM +1000, Nicholas Piggin wrote:
> kallsyms_on_each* may schedule so must not be called with interrupts
> disabled. The iteration function could disable interrupts, but this
> also changes lookup_symbol() to match the change to the other timing
> code.
> 
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Link: https://lore.kernel.org/all/bug-216902-206035@https.bugzilla.kernel.org%2F/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202212251728.8d0872ff-oliver.sang@intel.com
> Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Thanks Nicholas!

Petr had just suggested removing this aspect of the selftests, the performance
test as its specific to the config, it doesn't run many times to get an
average and odd things on a system can create different metrics. Zhen Lei
had given up on fixing it and has a patch to instead remove this part of
the selftest.

I still find value in keeping it, but Petr, would like your opinion on
this fix, if we were to keep it.

  Luis

>  kernel/kallsyms_selftest.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
> index f35d9cc1aab1..bfbc12da3326 100644
> --- a/kernel/kallsyms_selftest.c
> +++ b/kernel/kallsyms_selftest.c
> @@ -157,14 +157,11 @@ static void test_kallsyms_compression_ratio(void)
>  static int lookup_name(void *data, const char *name, struct module *mod, unsigned long addr)
>  {
>  	u64 t0, t1, t;
> -	unsigned long flags;
>  	struct test_stat *stat = (struct test_stat *)data;
>  
> -	local_irq_save(flags);
> -	t0 = sched_clock();
> +	t0 = ktime_get_ns();
>  	(void)kallsyms_lookup_name(name);
> -	t1 = sched_clock();
> -	local_irq_restore(flags);
> +	t1 = ktime_get_ns();
>  
>  	t = t1 - t0;
>  	if (t < stat->min)
> @@ -234,18 +231,15 @@ static int find_symbol(void *data, const char *name, struct module *mod, unsigne
>  static void test_perf_kallsyms_on_each_symbol(void)
>  {
>  	u64 t0, t1;
> -	unsigned long flags;
>  	struct test_stat stat;
>  
>  	memset(&stat, 0, sizeof(stat));
>  	stat.max = INT_MAX;
>  	stat.name = stub_name;
>  	stat.perf = 1;
> -	local_irq_save(flags);
> -	t0 = sched_clock();
> +	t0 = ktime_get_ns();
>  	kallsyms_on_each_symbol(find_symbol, &stat);
> -	t1 = sched_clock();
> -	local_irq_restore(flags);
> +	t1 = ktime_get_ns();
>  	pr_info("kallsyms_on_each_symbol() traverse all: %lld ns\n", t1 - t0);
>  }
>  
> @@ -270,17 +264,14 @@ static int match_symbol(void *data, unsigned long addr)
>  static void test_perf_kallsyms_on_each_match_symbol(void)
>  {
>  	u64 t0, t1;
> -	unsigned long flags;
>  	struct test_stat stat;
>  
>  	memset(&stat, 0, sizeof(stat));
>  	stat.max = INT_MAX;
>  	stat.name = stub_name;
> -	local_irq_save(flags);
> -	t0 = sched_clock();
> +	t0 = ktime_get_ns();
>  	kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
> -	t1 = sched_clock();
> -	local_irq_restore(flags);
> +	t1 = ktime_get_ns();
>  	pr_info("kallsyms_on_each_match_symbol() traverse all: %lld ns\n", t1 - t0);
>  }
>  
> -- 
> 2.37.2
> 
