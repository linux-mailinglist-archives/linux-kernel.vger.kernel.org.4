Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA42A688B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjBBXpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjBBXpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:45:10 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF0709AC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:45:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k13so3623423plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 15:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzVi4P/ecBkJtrR6cKdjwG9m7I4GTGe+PDH1n+cOfw4=;
        b=Gs7RkqznmOLZPACPKblWCJt1et3+6DZg6lLf3atMuDf1v/wQpob6JSOnBH3nA3XdmE
         URBLL6S/Cq7GjOat4tkU8TqNdGOneguzSKr7VDj7lGljXhUOP9ozLOQRMJNDGe3j+ZxC
         muehAT3MNVH5YHinkp3nEE5PE1AmxdLoUqPCoQVeLMdswdwiHhOEX7ULLh9haUOu5045
         PEKwc4obGBA8bF+NpJPTdF1xF7klKvMT+vMWDTpXzT5TKVANtbtn7xJzdXo1zamy6NiH
         Jh4HnucV/TCgKOF3zUNxpf/EkLIRNjz31rQzVTVKgP4YgBXytW67yRwbx0lABhVKj0kb
         kotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzVi4P/ecBkJtrR6cKdjwG9m7I4GTGe+PDH1n+cOfw4=;
        b=dabXwR832Q52kPvmUfcwJ9jDhkFQa+0YtNQX0QInQlFUuRYCpjPDIMTt0GJXGCXTkr
         e9pHS3gO4ZPF0eBt3HHy9dNFQZ1FxlJqDgHjN08b5RJ+UbsqqN3zsm420kZMPTO5SD54
         /OhOyLUaFnpdrt6Hu+7sx072Aiz7cq1f108jeq8OfBwk36bJNiOfO0lexJyQT2YIyTLi
         OexqQD2BuLoGr3Jn1EYAVUhmeJARPRRjBNYnjFwAf8eczb73C2zCvv++ooyMCBm0Uy4f
         dR7elPX6x5kTZ5uJDoFNipMtCIGtnLF/YSlY5ymcuJQuJw71QvPILXwPw1AsW3aAsTjk
         0ijg==
X-Gm-Message-State: AO0yUKUyQx27cHOACvmaC0DSgtyiKRwPnLtZyucSHc4guTwuUomk/f3R
        x3bVoNKKiIvy4Y/QhRirHOI=
X-Google-Smtp-Source: AK7set8myGv7d37pbJBOi/Lh5rQWBbJsMC//jQBm9wh4YYfeyHTMTebbWhZoPlGNx7kveEhymBWThg==
X-Received: by 2002:a05:6a21:3990:b0:bf:8840:ffd0 with SMTP id ad16-20020a056a21399000b000bf8840ffd0mr5006808pzc.29.1675381507254;
        Thu, 02 Feb 2023 15:45:07 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id d9-20020a63a709000000b004b1b9e23790sm304607pgf.92.2023.02.02.15.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:45:06 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 13:45:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/5] workqueue: Print backtraces from CPUs with hung CPU
 bound workqueues
Message-ID: <Y9xLAdc9ODyEO+RQ@slm.duckdns.org>
References: <20230201134543.13687-1-pmladek@suse.com>
 <20230201134543.13687-6-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134543.13687-6-pmladek@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I generally really like it.

> +static bool show_pool_suspicious_workers(struct worker_pool *pool, bool shown_title)

Maybe the name can be a bit more specific? show_cpu_pool_hog()?

> +{
> +	bool shown_any = false;
> +	struct worker *worker;
> +	unsigned long flags;
> +	int bkt;
> +
> +	raw_spin_lock_irqsave(&pool->lock, flags);
> +
> +	if (pool->cpu < 0)
> +		goto out;

This can be tested before grabbling the lock.

> +	if (!per_cpu(wq_watchdog_hung_cpu, pool->cpu))
> +		goto out;

Given that the state is per-pool, would it make sense to mark this on the
pool instead?

> +	if (list_empty(&pool->worklist))
> +		goto out;

This condition isn't really necessary, right?

> +	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
> +		if (!task_is_running(worker->task))
> +			continue;
> +
> +		if (!shown_title) {
> +			pr_info("Showing backtraces of running workers in stuck CPU-bound worker pools:\n");
> +			shown_title = true;
> +		}
> +
> +		shown_any = true;
> +		pr_info("pool %d:\n", pool->id);
> +		sched_show_task(worker->task);
> +	}
> +out:
> +	raw_spin_unlock_irqrestore(&pool->lock, flags);
> +	return shown_any;
> +}
> +
> +static void show_suspicious_workers(void)
> +{
> +	struct worker_pool *pool;
> +	bool shown_title = false;
> +	int pi;
> +
> +	rcu_read_lock();
> +
> +	for_each_pool(pool, pi) {
> +		bool shown;
> +
> +		shown = show_pool_suspicious_workers(pool, shown_title);
> +		if (shown)
> +			shown_title = shown;

Maybe, move shown to the outer scope and:

	shown |= show_pool_suspicious_workers(pool, show);

> +	}
> +
> +	rcu_read_unlock();
> +}
>  
>  static void wq_watchdog_reset_touched(void)
>  {

Thanks.

-- 
tejun
