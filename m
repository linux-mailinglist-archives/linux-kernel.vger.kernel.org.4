Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6425C665BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAKMuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAKMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:50:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C23B2000
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673441394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dZD+zLisXFNNxRAEfO1nx+xL5Q7F5mrHdFA1PLb+YAU=;
        b=XHTqdyZKXMeFnqr5McyQfBYFLHa+4i4osccWjW9a9scq9VnE9KBu70Z5M/jSKOOK0YkPbg
        tRP5sIRdikJDf2/wdligqPqPR8Wq8Avm8mUqTzSDX/RE+jc0YtA/VNhtpE5TTmSd3Qc0xX
        uZyKPQt52EftXuXol991gJdyOymaBxo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-425-BEb28brvPK2cMqrQSUZZgQ-1; Wed, 11 Jan 2023 07:49:53 -0500
X-MC-Unique: BEb28brvPK2cMqrQSUZZgQ-1
Received: by mail-qt1-f198.google.com with SMTP id bt4-20020ac86904000000b003a96b35e7a8so7086136qtb.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZD+zLisXFNNxRAEfO1nx+xL5Q7F5mrHdFA1PLb+YAU=;
        b=zEVsQmnK3KRDB/GUh7uZNm4aN3WP6caWYXntmWi5boLvCRcWZ+fCaD1c/48jrESHaW
         p9K5n7Nmh54dXowReeloJvyJUKJtT1Z55xX0YU5c0oTUYhqxag0/u+6jd0Hc+o3sNKnk
         VF8zg0sYifeH+u7yXVV5oTmibBnbNWb1xknSPQxkyJRvkwevpnARGG+n0mYwzuzI4nMy
         H3s3qn3iq3sDxVRFNMXcWbPJoIAbx/Z3Gq1H8FmKaUi83Y6l0WxxlhFnDLA6EYNYAnlF
         hQyfT9IY/XAy9BNvzlAHHjjS6Szd7/1Av2QdG7R8kF38k2HonZT+OCnzrqqTLhLxnwhb
         ZbVQ==
X-Gm-Message-State: AFqh2kosvIKTfxTfFMhs0lbpcKe7mJibf7pjR0wG4Gj5T8cpPAX7odaO
        TxEKPck8Q3thVENxBZRfSclC85VWSMwmvV/ohiSZJ81DdjG5goScYOgIHDWAFkPfv/29AS4rWem
        7KwyXIvct8KQf2oBuCK6sg9Hw
X-Received: by 2002:ac8:1205:0:b0:3a8:5d1:aabc with SMTP id x5-20020ac81205000000b003a805d1aabcmr95049788qti.15.1673441392363;
        Wed, 11 Jan 2023 04:49:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXumVT507iP9o2XgKK5qfN5REgfvhXrRR1lSRyjTzV8DmIgF5FxkOeGU6YN2Ork2z6ZcyfDROQ==
X-Received: by 2002:ac8:1205:0:b0:3a8:5d1:aabc with SMTP id x5-20020ac81205000000b003a805d1aabcmr95049767qti.15.1673441392107;
        Wed, 11 Jan 2023 04:49:52 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id l23-20020a37f917000000b006fc2b672950sm8911280qkj.37.2023.01.11.04.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 04:49:51 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v7 4/4] workqueue: Unbind kworkers before sending them
 to exit()
In-Reply-To: <Y73KeZ3g0WdukMQo@slm.duckdns.org>
References: <20230109133316.4026472-1-vschneid@redhat.com>
 <20230109133316.4026472-5-vschneid@redhat.com>
 <Y73KeZ3g0WdukMQo@slm.duckdns.org>
Date:   Wed, 11 Jan 2023 12:49:49 +0000
Message-ID: <xhsmhv8ldck2a.mognet@vschneid.remote.csb>
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

On 10/01/23 10:28, Tejun Heo wrote:
> Hello,
>
> The series generally looks good to me. Just one thing.
>
> On Mon, Jan 09, 2023 at 01:33:16PM +0000, Valentin Schneider wrote:
>> @@ -3658,13 +3702,24 @@ static void put_unbound_pool(struct worker_pool *pool)
>>  			   TASK_UNINTERRUPTIBLE);
>>  	pool->flags |= POOL_MANAGER_ACTIVE;
>>  
>> +	/*
>> +	 * We need to hold wq_pool_attach_mutex() while destroying the workers,
>> +	 * but we can't grab it in rcuwait_wait_event() as it can clobber
>> +	 * current's task state. We can drop pool->lock here as we've set
>> +	 * POOL_MANAGER_ACTIVE, no one else can steal our manager position.
>> +	 */
>> +	raw_spin_unlock_irq(&pool->lock);
>> +	mutex_lock(&wq_pool_attach_mutex);
>> +	raw_spin_lock_irq(&pool->lock);
>
> The original pattern was a bit weird to begin with and this makes it quite
> worse.

That it does!

> Let's do something more straight forward like:
>
>         while (true) {
>                 rcuwait_wait_event(&manager_wait,
>                                    !(pool->flags & POOL_MANAGER_ACTIVE),
>                                    TASK_UNINTERRUPTIBLE);
>                 mutex_lock(&wq_pool_attach_mutex);
>                 raw_spin_lock_irq(&pool->lock);
>                 if (!(pool->flags & POOL_MANAGER_ACTIVE)) {
>                         pool->flags |= POOL_MANAGER_ACTIVE;
>                         break;
>                 }
>                 raw_spin_unlock_irq(&pool->lock);
>                 mutex_unlock(&wq_pool_attach_mutex);
>         }
>

That should do the trick, I'll go test it out.


While we're here, for my own education I was trying to figure out in what
scenarios we can hit this manager-already-active condition. When sending
out v6 I had convinced myself it could happen during failed
initialization of a new unbound pool, but having another look at it now I'm
not so sure anymore.

The only scenario I can think of now is around maybe_create_worker()'s
release of pool->lock, as that implies another worker can drain the
pool->worklist and thus let pool->refcnt reach 0 while another worker is
being the pool manager. Am I looking at the right thing?

Thanks

