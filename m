Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1783463480B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiKVUYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiKVUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:23:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C83167FB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:23:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jn7so12885612plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4u4OXrLVlO99xYsRoKZMfZRyTXMaPRYGMBVHkWDPkM=;
        b=oiwM53ogJ2puZg4oizPgE12GVOLkIoaFbBa4mg7Y/L1vrXQ/bbl5GjiyuKMwDSei5b
         S8onGp+gN6sPJW+3DFEXy5Ip7mOd7xqZcc725OTs0jMhYRjayBkmG83dNVpilt912xW8
         WxNXRo98unrU3lDoL7n/eQed+4zn2Qn6qVFhYvqFihX8JXf+m0GiOftcanPq1e5g1ZpL
         Dw+pz/8W9pHkowcIjhEo2iM2raWscvfmAMWzY0Qzl4wdA6IvW3Q4B/FTPbQYnvfy80YX
         Yey+OIsW1ILS4UtiowCMNgYuYe2e9JBV3f4tuOXn3y0wQEklKfIqm4/u9gMqxs2kuQOI
         xlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4u4OXrLVlO99xYsRoKZMfZRyTXMaPRYGMBVHkWDPkM=;
        b=y138xGXj6A84/Wd79/q1ztQhXA85einnBPYyR2AP9q2PsslTkS2RYEgJ44bj0o7m39
         KJtMwGx5YNv83y1AR7ffxriNt0T4IbZYV2yL1Ku14T7nKlLgpaMNhK4ZzMylBQe5VBVC
         sxWclOSg/JBQPqfJQy5Yt3Y2p+CzEV37c9l172uBQx/EcJV6eTjGMUykSaPL7JN+0ttU
         LB0VG8oEwirkYupWoF4IxcwXbToULxAImTp740BKjCzb6mFAhi6VK71tCe+b1zAOycpr
         EYpYZR8fNg8s+PU8iwyLvMh3qriIAkWFo3fL70+ugWCZlmHGl/VrgEiRyjsuH/i/o6Js
         LsIw==
X-Gm-Message-State: ANoB5plGm6eVIaM3/GQ1SQw6g/gULLcgotgowGjhW4FeQiyCUZPEacuy
        MWT45MmBwKaU7IqUItaL4pQ=
X-Google-Smtp-Source: AA0mqf5LHWkD6Dw4to90dMqIf/oktJdBUmN7p81CM5H+bPCnnL2fiwrmjwp/7ZlHGaG8O9420Uk45A==
X-Received: by 2002:a17:902:ec01:b0:186:878e:3b0d with SMTP id l1-20020a170902ec0100b00186878e3b0dmr5522521pld.149.1669148619084;
        Tue, 22 Nov 2022 12:23:39 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bb3])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b00188c5f0f9e9sm12316383plb.199.2022.11.22.12.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:23:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Nov 2022 10:23:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v5 4/5] workqueue: Convert the idle_timer to a timer +
 work_struct
Message-ID: <Y30vyTgB7+kGkDGa@slm.duckdns.org>
References: <20221122192937.2386494-1-vschneid@redhat.com>
 <20221122192937.2386494-5-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122192937.2386494-5-vschneid@redhat.com>
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

On Tue, Nov 22, 2022 at 07:29:36PM +0000, Valentin Schneider wrote:
> @@ -2039,12 +2060,48 @@ static void idle_worker_timeout(struct timer_list *t)
>  		worker = list_entry(pool->idle_list.prev, struct worker, entry);
>  		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
>  
> +		/* All remaining entries will be younger than this */
>  		if (time_before(jiffies, expires)) {
> -			mod_timer(&pool->idle_timer, expires);
> +			if (!cull_cnt)
> +				mod_timer(&pool->idle_timer, expires);
>  			break;
>  		}
>  
> +		/*
> +		 * Mark the idle worker ripe for culling.
> +		 * If a preempted idle worker gets to run before the idle cull
> +		 * handles it, it will just pop itself out of that list and
> +		 * continue as normal.
> +		 */
> +		list_move(&worker->entry, &pool->idle_cull_list);
> +	}
> +	raw_spin_unlock_irq(&pool->lock);
> +
> +	if (cull_cnt)
> +		queue_work(system_unbound_wq, &pool->idle_cull_work);
> +}

So, you mentioned this explicitly in the cover letter but I think I'd prefer
if the timer were simpler and all logic were in the work item. It just needs
to pick at the first worker and compare the expiration once, right? If that
bothers you, we can make workers keep track of the oldest idle's timestamp
in, say, wq->first_idle_at as the workers go idle and busy and then the
timer can simply look at the value and decide to schedule the work item or
not.

Thanks.

-- 
tejun
