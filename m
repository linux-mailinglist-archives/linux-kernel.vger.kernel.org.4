Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB59E63E820
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLADCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiLADCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:02:00 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC0B83256
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:01:59 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id n188so260031iof.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A1q0DUW0UHb1nD0XGbTyZTTfZ/Tzl76R+aLJImRrqQE=;
        b=nxB3GTyrTZMoG76NG8T3un04JYOU7mS4NbBynHGZYyxJk+1KTl0xgrZam7ICoBV5sk
         46cG5ZeZpbvxqm6BO/02KAKO/TSHz9oaSufUZ6hx69OMHM+lFmiAWHCuMik9cnEDuia6
         Jc9CKI/9nqBA9B6GHEINQFKHU54u9hFGrrZibG3c375ixo5BdkeKYNhZN7ZjY4/La/sI
         bFpqBz8/VjNqPeH4ngj03RbXzN2MIvQ542DHSLY4EDQP79sHrQOPZ7WphtHRzD/qho+C
         OryCEbTT6k6S7X77hQC5knHdsoj8tkvuycRNQZzwg2Sxd5eKRuacG2CMz5VE2Bjk22Ku
         Ikog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1q0DUW0UHb1nD0XGbTyZTTfZ/Tzl76R+aLJImRrqQE=;
        b=THj8Yz8cT5Pvagjn9wO6iizMQ4ZVQP68T+bbWjDd32uJs1YzByUNLGDBuaccYpPHTg
         wzTMYSnMHFSmpwwdm/aGEzwfgcXzwQm5ZTZeaTXqg1UTsyO1fAZPH9SxII52nwsb2QC0
         uhwaj02ZwAlJlvF7hEWVyrrajYczzOlJ2yCtdKaWd8CLRHTMGHLiTVXizgnYZzvA/ph5
         2i7Hs/D3VDfeHA4Dl7Gh9efWXzZN2t2p6EMNiiBUwOZXNQ7LcDL3KuHJfdffA8a5DbPD
         OaWXz351bPyswMiQrRUYRA7UCz6l/JRV0Jr1B2SjrhqSnNObzGQc+0Errh0cUVMi7Bzi
         yfWA==
X-Gm-Message-State: ANoB5pkaukySy/EboH9xveD2dkNOnStKBYXa72LfD7ke3JEDoCQcECHL
        mme+kRNk64j54O8o9kuBko2Wj6uVTJPHiB4wfGs=
X-Google-Smtp-Source: AA0mqf5z+cv5HPVxQDr315u+p13BdeBR81byPRvf0Vq9IrrDONw5BOcJyyrEaD6inTxLA7L+bsWRtCroOvzcgbt+/SU=
X-Received: by 2002:a02:cbde:0:b0:387:7704:abc3 with SMTP id
 u30-20020a02cbde000000b003877704abc3mr18317041jaq.72.1669863718925; Wed, 30
 Nov 2022 19:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20221128183109.446754-1-vschneid@redhat.com> <20221128183109.446754-5-vschneid@redhat.com>
In-Reply-To: <20221128183109.446754-5-vschneid@redhat.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 1 Dec 2022 11:01:47 +0800
Message-ID: <CAJhGHyB06u=mtbouGBw2CbLX9+gXPSPqHrHZHvorzF+8cPrG+Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] workqueue: Unbind kworkers before sending them to exit()
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 2:31 AM Valentin Schneider <vschneid@redhat.com> wrote:

> @@ -3627,8 +3668,11 @@ static bool wq_manager_inactive(struct worker_pool *pool)
>  static void put_unbound_pool(struct worker_pool *pool)
>  {
>         DECLARE_COMPLETION_ONSTACK(detach_completion);
> +       struct list_head cull_list;
>         struct worker *worker;
>
> +       INIT_LIST_HEAD(&cull_list);
> +
>         lockdep_assert_held(&wq_pool_mutex);
>
>         if (--pool->refcnt)
> @@ -3651,17 +3695,19 @@ static void put_unbound_pool(struct worker_pool *pool)
>          * Because of how wq_manager_inactive() works, we will hold the
>          * spinlock after a successful wait.
>          */
> +       mutex_lock(&wq_pool_attach_mutex);
>         rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
>                            TASK_UNINTERRUPTIBLE);
>         pool->flags |= POOL_MANAGER_ACTIVE;

Hello, Valentin

I'm afraid it might deadlock here.

If put_unbound_pool() is called while manage_workers() is sleeping
on allocating memory, put_unbound_pool() will get the wq_pool_attach_mutex
earlier than the manager which prevents the manager from getting the
lock to attach the newly created worker and deadlock.

I think mutex_lock(&wq_pool_attach_mutex) can be moved into
wq_manager_inactive(), and handle it in the same way as pool->lock.

>
>         while ((worker = first_idle_worker(pool)))
> -               destroy_worker(worker);
> +               set_worker_dying(worker, &cull_list);
>         WARN_ON(pool->nr_workers || pool->nr_idle);
>         raw_spin_unlock_irq(&pool->lock);
>
> -       mutex_lock(&wq_pool_attach_mutex);
> -       if (!list_empty(&pool->workers))
> +       wake_dying_workers(&cull_list);
> +
> +       if (!list_empty(&pool->workers) || !list_empty(&pool->dying_workers))
>                 pool->detach_completion = &detach_completion;
>         mutex_unlock(&wq_pool_attach_mutex);
>
> --
> 2.31.1
>
