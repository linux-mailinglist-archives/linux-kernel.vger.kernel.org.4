Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210F663EE08
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLAKis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiLAKio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE14DF81
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669891062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3bWYpJRGJvzwl1M5ydVuTNavbl8h6/aSe+cL4KpRcY=;
        b=i+SgaQEaDFsDF9o+FCrEczyalzwXH1PheBjYYJeIiukS8axP/J1EPQirwvcbu501MIYk62
        mX6/Jn32mcLEMj9Bmk0KeMnhEpgWRy684Hk0qsgcHRgnkU9Yl3l8l8k2aZwk7QMNmCTHgA
        I5baN63Ee1J4A9ERPDkYuDyRAyl9EL8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-X3P_Fm9fMBaU4QOzm6I6DA-1; Thu, 01 Dec 2022 05:37:33 -0500
X-MC-Unique: X3P_Fm9fMBaU4QOzm6I6DA-1
Received: by mail-wm1-f71.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso675228wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:37:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3bWYpJRGJvzwl1M5ydVuTNavbl8h6/aSe+cL4KpRcY=;
        b=qMnlVsXdHricQHElG6UPx5V1P3zPo5CqveABAuC38dctBfG2Hbwg3OffvBaXyNxw5r
         q5r48EZDSadP20j2rSgfBuwPm1YKpnPc7Pz46U83UYE7szXhwZ8gD7DhBTnF5HzqX7io
         /ZEskPKPCBtUjNU/6R2S7/kRutyPz5iXtPHzbnuvcKrFIaeuvdrtHm0JoxAmGQ7NmIpb
         H/vRVI+kAyjVzYnW2xKs1P4G7It2QULlDo00bf4XuRM0aniNModsyXaIX1T8HZ4+eLN6
         0xOtGZkfiJov+brPIZe892Bm1Xn6PTw+VrlBrKUfF9gnxpNXMWA/8xjYANdT2FyJJ+kt
         eoYA==
X-Gm-Message-State: ANoB5pm7ms5D3i6rlQhETXss2GgmYF69RVeUy8Xps42YLn/0KLCX+F9k
        5laEkPYExtDudoPsCuSpiU5PfEKOC5SawUrnu1q9yrollS0zKq1uJzYhzYOcvAlPR4b3DVFx0TF
        /M3RUoDjwfBHBZbZu2bOt8YwR
X-Received: by 2002:a05:600c:46cd:b0:3cf:88c3:d010 with SMTP id q13-20020a05600c46cd00b003cf88c3d010mr51219553wmo.180.1669891052652;
        Thu, 01 Dec 2022 02:37:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf71FP0Ng8pK+VB+NxScW6m8Z0WKDjtcQ6XGGQJzuqy5dX/XtmG7xBznHIxGjjxu/VSHMOumZQ==
X-Received: by 2002:a05:600c:46cd:b0:3cf:88c3:d010 with SMTP id q13-20020a05600c46cd00b003cf88c3d010mr51219539wmo.180.1669891052451;
        Thu, 01 Dec 2022 02:37:32 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d55ce000000b002422816aa25sm4927232wrw.108.2022.12.01.02.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:37:31 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v6 4/4] workqueue: Unbind kworkers before sending them
 to exit()
In-Reply-To: <CAJhGHyB06u=mtbouGBw2CbLX9+gXPSPqHrHZHvorzF+8cPrG+Q@mail.gmail.com>
References: <20221128183109.446754-1-vschneid@redhat.com>
 <20221128183109.446754-5-vschneid@redhat.com>
 <CAJhGHyB06u=mtbouGBw2CbLX9+gXPSPqHrHZHvorzF+8cPrG+Q@mail.gmail.com>
Date:   Thu, 01 Dec 2022 10:37:30 +0000
Message-ID: <xhsmh8rjrl89h.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/22 11:01, Lai Jiangshan wrote:
> On Tue, Nov 29, 2022 at 2:31 AM Valentin Schneider <vschneid@redhat.com> wrote:
>
>> @@ -3627,8 +3668,11 @@ static bool wq_manager_inactive(struct worker_pool *pool)
>>  static void put_unbound_pool(struct worker_pool *pool)
>>  {
>>         DECLARE_COMPLETION_ONSTACK(detach_completion);
>> +       struct list_head cull_list;
>>         struct worker *worker;
>>
>> +       INIT_LIST_HEAD(&cull_list);
>> +
>>         lockdep_assert_held(&wq_pool_mutex);
>>
>>         if (--pool->refcnt)
>> @@ -3651,17 +3695,19 @@ static void put_unbound_pool(struct worker_pool *pool)
>>          * Because of how wq_manager_inactive() works, we will hold the
>>          * spinlock after a successful wait.
>>          */
>> +       mutex_lock(&wq_pool_attach_mutex);
>>         rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
>>                            TASK_UNINTERRUPTIBLE);
>>         pool->flags |= POOL_MANAGER_ACTIVE;
>
> Hello, Valentin
>
> I'm afraid it might deadlock here.
>
> If put_unbound_pool() is called while manage_workers() is sleeping
> on allocating memory, put_unbound_pool() will get the wq_pool_attach_mutex
> earlier than the manager which prevents the manager from getting the
> lock to attach the newly created worker and deadlock.
>

Well spotted, I can see it now.

> I think mutex_lock(&wq_pool_attach_mutex) can be moved into
> wq_manager_inactive(), and handle it in the same way as pool->lock.
>

That looks sane enough, I'll try to tweak my tests to get the manager
involved to test this out. Thanks!

