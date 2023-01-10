Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0040A664D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjAJUbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjAJUaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:30:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7851633A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:28:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so17699861pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNez16VMF4rRmKYhCe0O3ABHc5tdrND3Cm+xmlv4IIQ=;
        b=VDtEnRD0IULnX2C+hz7ue9+Ox87DOT+65LNmd6Y8TrDOritXAKvpw5sE/xe22MNPgp
         6fycVwPIDqgFeyrCKVBf9XMngexY72yWSKnWg/uznGFCiCahyGaZNBBgFq4g+oloYZBY
         HcKK5Rm9+BJEOXjeTHagp6I1GQZmyDZZw+HgJTxzmqEatwzESgqMaWS/vDSTBwN5tlMP
         ZF7ura2oe1p7EO8S3bl+NSPEiSLldLpC/Mr5mXFUCqUk3d8eA3H1zvpvSiNz9wE767w1
         jzEBso/x4g5vvrBfa2bqya+2hG47870jxcjGjiNH7NZWJhwfLckBhg7eOeOpzb7C4iMO
         erTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNez16VMF4rRmKYhCe0O3ABHc5tdrND3Cm+xmlv4IIQ=;
        b=C0dbAYGc66K6h2uCPFnPZUyUDuP8MP9M6wQpG/9xE8Wj60BjIyLLhlVZZJVUwYw32W
         N2b6XqcI0xHl3CYC5ioFe7SO6nDWVwwAY+xoWVdPJRIugG6j/9YwpvRxqsS7dlwM0HXJ
         kVZyjcREs+GbTg05bk5dxGq8nPq1rJL4cbTfD8rzb0r2K/C52wYvwPqdwHzWcTEduaLL
         KNnG0+5NgomnPiGhyU5wL+jJgEoboP4Wid0wqw7blBtPxOcavRrxsN/GxwAOsyDpDfQX
         ag54aI5LS9LYTvtas+SN3M5oC+/PywtWpsE9ug//6d3AOMMpNJOxtIqpFcmRDedXAoHm
         n2Kg==
X-Gm-Message-State: AFqh2kq5IGe0czgFnkamqGK2tCIDm79QfjR6R4QUr9MWAu4ZIxoAjiMV
        aXHRg6BmbUDBg4BXCmp7dSo=
X-Google-Smtp-Source: AMrXdXs5B83oTFUdyufH1m6gzfZsgR/0a2/gzotO5bt9J7aYOdGXU4G0YeySaAOMGhg/T+mqUwdRWQ==
X-Received: by 2002:a05:6a20:c78d:b0:a3:878d:c126 with SMTP id hk13-20020a056a20c78d00b000a3878dc126mr89685965pzb.42.1673382523621;
        Tue, 10 Jan 2023 12:28:43 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n5-20020a634005000000b004a737a6e62fsm6989361pga.14.2023.01.10.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 12:28:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Jan 2023 10:28:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v7 4/4] workqueue: Unbind kworkers before sending them to
 exit()
Message-ID: <Y73KeZ3g0WdukMQo@slm.duckdns.org>
References: <20230109133316.4026472-1-vschneid@redhat.com>
 <20230109133316.4026472-5-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109133316.4026472-5-vschneid@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The series generally looks good to me. Just one thing.

On Mon, Jan 09, 2023 at 01:33:16PM +0000, Valentin Schneider wrote:
> @@ -3658,13 +3702,24 @@ static void put_unbound_pool(struct worker_pool *pool)
>  			   TASK_UNINTERRUPTIBLE);
>  	pool->flags |= POOL_MANAGER_ACTIVE;
>  
> +	/*
> +	 * We need to hold wq_pool_attach_mutex() while destroying the workers,
> +	 * but we can't grab it in rcuwait_wait_event() as it can clobber
> +	 * current's task state. We can drop pool->lock here as we've set
> +	 * POOL_MANAGER_ACTIVE, no one else can steal our manager position.
> +	 */
> +	raw_spin_unlock_irq(&pool->lock);
> +	mutex_lock(&wq_pool_attach_mutex);
> +	raw_spin_lock_irq(&pool->lock);

The original pattern was a bit weird to begin with and this makes it quite
worse. Let's do something more straight forward like:

        while (true) {
                rcuwait_wait_event(&manager_wait,
                                   !(pool->flags & POOL_MANAGER_ACTIVE),
                                   TASK_UNINTERRUPTIBLE);
                mutex_lock(&wq_pool_attach_mutex);
                raw_spin_lock_irq(&pool->lock);
                if (!(pool->flags & POOL_MANAGER_ACTIVE)) {
                        pool->flags |= POOL_MANAGER_ACTIVE;
                        break;
                }
                raw_spin_unlock_irq(&pool->lock);
                mutex_unlock(&wq_pool_attach_mutex);
        }

Thanks.

-- 
tejun
