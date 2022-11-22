Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA706347EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiKVURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiKVURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:17:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4152DDE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:17:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y4so14746604plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOGHLP5HIj9i23WKx8F5fFOZNnqfBffKUE8KWY64clY=;
        b=NzS91rjsOTy4kDCWDLyGmvr/liq0C+vIn2YjV7FPq/+cVzAyEUBzFgeBbzmM0vCVV/
         Y+iw3mdzeZeuWffmnbFvxcH2BksFpC6t5Fyggd/KXkRP/EITa9rqx6cMOQ9+wGoz91/j
         OVqTCPzqQZSDVS16WuvYwfmJ7QgcEpvttLaBcXeCJgaLi9qDwnl1qgpjK2gp0+3kvQQG
         /mIrAG/w1qw1D7RFPu2V0lET6GHsd8sD3mcatlRrY/L3YkkDCu+/KEtC/arvJ5/+0HSr
         Y8L1g6NUlRa7OMA9O6QfvUcUd3k1j1T0kVhad4BkwxWF43mdVjBtDCyvOQDMcWX3U9kc
         9x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOGHLP5HIj9i23WKx8F5fFOZNnqfBffKUE8KWY64clY=;
        b=HEMga9gluY+EtzJklxInhSQwgrEQY2Df5G2a4rhDxMTTTsws4Upjlu8eSQtjoIMCag
         hOw9zV0+RvX1qlV0MY2onaKg1A8P/svtBhtO//VRIbgRosiu3g4BzMhmvs4NcIIkobhA
         azk0wMBCjerz8KoeCeLEbnSxRpgkb6jS3frUnri+gQj8pHjTRyDgGqYGZIJOdrDwxazu
         b1j0SMePU75uvZJ/ANxHg1WCRmcVFMlzUPLiRBd4J/ObdOQ1vE3qfP8ND9pMHwZ50wVJ
         9XyCf1VTtKWexuWBUjWTETJqf8yeruzoGCqBdTzpJ4y7lTk+IWYYeOusgNZkPvuN5r+5
         wG2g==
X-Gm-Message-State: ANoB5pnVt0+L4prBPQHCTG+C89AVHTzdwsM/gKEYvqy8pG9/ZMqiFniK
        wfPCRzM029HCIPJwHhRU3vc=
X-Google-Smtp-Source: AA0mqf5/yZRUWfzUlv412lMPgmSdCkAtoLh+djHTvtSi4lmtwQ3l5XgkObKKpA/+gUDC4sw7olEwdQ==
X-Received: by 2002:a17:902:cccd:b0:186:fd58:c706 with SMTP id z13-20020a170902cccd00b00186fd58c706mr5786135ple.4.1669148261037;
        Tue, 22 Nov 2022 12:17:41 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bb3])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b00188f9534a3esm11050639pli.87.2022.11.22.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:17:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Nov 2022 10:17:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v5 3/5] workqueue: Make too_many_workers() return the
 worker excess
Message-ID: <Y30uY/Y8pffIhrUp@slm.duckdns.org>
References: <20221122192937.2386494-1-vschneid@redhat.com>
 <20221122192937.2386494-4-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122192937.2386494-4-vschneid@redhat.com>
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

On Tue, Nov 22, 2022 at 07:29:35PM +0000, Valentin Schneider wrote:
...
> The function currently returns true when
>   (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO >= nr_busy
> thus, the desired number of idle workers is expressed by
>   (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO == nr_busy - 1
> IOW
>    nr_idle == ((nr_busy - 1) / MAX_IDLE_WORKERS_RATIO) + 2
> +/* How many idle workers should we get rid of, if any? */
> +static unsigned int worker_cull_count(struct worker_pool *pool)

Can we name it nr_workers_to_cull()?

>  {
>  	bool managing = pool->flags & POOL_MANAGER_ACTIVE;
>  	int nr_idle = pool->nr_idle + managing; /* manager is considered idle */
>  	int nr_busy = pool->nr_workers - nr_idle;
>  
> -	return nr_idle > 2 && (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO >= nr_busy;
> +	lockdep_assert_held(&pool->lock);
> +
> +	/*
> +	 * We keep at least 2 spare idle workers, but overall aim to keep at
> +	 * most (1 / MAX_IDLE_WORKERS_RATIO) workers idle.
> +	 */
> +	return max(0, nr_idle - 2 - ((nr_busy - 1) / MAX_IDLE_WORKERS_RATIO));

I think we can do away with the subtraction on nr_busy. I don't think it'd
make any material difference, so maybe we can do:

        return max(0, nr_idle - 2 - nr_busy / MAX_IDLE_WORKERS_RATIO);

Thanks.

-- 
tejun
