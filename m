Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084CB63EEB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiLALDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLALDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B6DA321D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669892488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dIYgRYjREh+bqtm1hANgqL8y6UtRFdWTjY6cfe7VFrQ=;
        b=WEQ+qsXr+vDTjMXxUKHsKvSgsr86SDe87QFptvtSry2k6JsirrTs5I8XaoiDmImAIx0wBb
        ptUTXhZiA2vpNu6282eoNJ9p4xUEH3zXht2Yu+wPKpBKDX9gV0MVGh6L+KCQXLBYhSWtyx
        AAXm/IFAwmTr/Q0JRNT7Tz8TPLHOkQI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-UBhw5hpiO7qPDmhLau1nMQ-1; Thu, 01 Dec 2022 06:01:27 -0500
X-MC-Unique: UBhw5hpiO7qPDmhLau1nMQ-1
Received: by mail-wr1-f70.google.com with SMTP id g14-20020adfa48e000000b00241f94bcd54so306286wrb.23
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIYgRYjREh+bqtm1hANgqL8y6UtRFdWTjY6cfe7VFrQ=;
        b=BSlYIMru4paODzlXVK/B1XMuJatJZIlQ502DBPkWaZn44bL3IArbz380LbaoP8Sa9p
         vqtTluLV0+2ymH81lZiUHD+e4GL3YbHFZmcJRUuPbNAgBILhCfSP9ey0Vn87OU6shsxn
         Q4FIGm4x6vShBBA+1DGndXdcaszkAIZWXJ/b7/5XnZmQroN+3bWEFRuuw2L2P/yyk54G
         TReqIn/8HXwBxiUS6+6/0KsQz2C2ivOrhh5eItc0nBNDwhSEoI9A0fKe17r6t8QJf9/S
         dPe5JjtQQKy1e2+AiiF49b/4ISpKHW7apVCuYkxhS2RMAFpwS8wmvs3/rZ7EaZJw1rIT
         S5lw==
X-Gm-Message-State: ANoB5pnwSxtWGo0wI7TEDvPoaorK+OHwTk/psqHk51Ts6sHZ/S1lo0Dz
        9GMEqP9g0cgcTpwbaIn6q4uJ3kZMVVRaz1xEvoSzXvWzwDFj9xU4gPx7tw86ZdJVaTzge0NOg+J
        GUMeGB6QGKru5L8VslIdBDw0y
X-Received: by 2002:a05:6000:1a4e:b0:242:71b:e3cf with SMTP id t14-20020a0560001a4e00b00242071be3cfmr18607703wry.144.1669892486271;
        Thu, 01 Dec 2022 03:01:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4nUcVhof4h19m5eYtRbCFNncqAgIXWYD1r7VD9LnwHnEJCDPu/hJHesi7WrnlYjBuoBQFaSg==
X-Received: by 2002:a05:6000:1a4e:b0:242:71b:e3cf with SMTP id t14-20020a0560001a4e00b00242071be3cfmr18607680wry.144.1669892486082;
        Thu, 01 Dec 2022 03:01:26 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id p14-20020adf9d8e000000b00236b2804d79sm4148410wre.2.2022.12.01.03.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:01:25 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v6 3/4] workqueue: Convert the idle_timer to a timer +
 work_struct
In-Reply-To: <Y4fFzBrjZiOQO9Te@slm.duckdns.org>
References: <20221128183109.446754-1-vschneid@redhat.com>
 <20221128183109.446754-4-vschneid@redhat.com>
 <Y4fFzBrjZiOQO9Te@slm.duckdns.org>
Date:   Thu, 01 Dec 2022 11:01:24 +0000
Message-ID: <xhsmh5yevl75n.mognet@vschneid.remote.csb>
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

On 30/11/22 11:06, Tejun Heo wrote:
> On Mon, Nov 28, 2022 at 06:31:08PM +0000, Valentin Schneider wrote:
>> @@ -1806,7 +1808,9 @@ static void worker_enter_idle(struct worker *worker)
>>      /* idle_list is LIFO */
>>      list_add(&worker->entry, &pool->idle_list);
>>
>> -	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
>> +	if (too_many_workers(pool) &&
>> +	    !timer_pending(&pool->idle_timer) &&
>> +	    !work_pending(&pool->idle_cull_work))
>
> Just checking the timer should be enough here, I think.
>

That would let the timer be re-armed when the cull work is pending, which
itself will re-arm the timer to the next non-culled idle worker expiry (if
there is any remaining).

Not an issue per se, it's just that having the cull work pending is a
"promise" that the timer will be re-armed if and when necessary.

I think in cases where the cull work doesn't get to run for a while, not
having the extra work_pending() check and just arming the timer in
worker_enter_idle() might be cheaper than repeatedly checking both
timer_pending() and work_pending(), but otherwise I would assume not arming
the timer would be preferred.

>>              mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
>>
>>      /* Sanity check nr_running. */
>> @@ -2019,17 +2023,56 @@ static void destroy_worker(struct worker *worker)
>>      wake_up_process(worker->task);
>>  }
>>
>> +/*
>> + * idle_worker_timeout - check if some idle workers can now be deleted.
>
> Might as well turn it into a proper function comment starting w/ "/**" and
> with argument list.
>

Ack.

>> + *
>> + * The timer is armed in worker_enter_idle(). Note that it isn't disarmed in
>> + * worker_leave_idle(), as a worker flicking between idle and active while its
>> + * pool is at the too_many_workers() tipping point would cause too much timer
>> + * housekeeping overhead. Since IDLE_WORKER_TIMEOUT is long enough, we just let
>> + * it expire and re-evaluate things from there.
>> + */
>>  static void idle_worker_timeout(struct timer_list *t)
>>  {
>>      struct worker_pool *pool = from_timer(pool, t, idle_timer);
>> +	bool do_cull = false;
>> +
>> +	if (work_pending(&pool->idle_cull_work))
>> +		return;
>>
>>      raw_spin_lock_irq(&pool->lock);
>>
>> -	while (too_many_workers(pool)) {
>> +	if (too_many_workers(pool)) {
>>              struct worker *worker;
>>              unsigned long expires;
>>
>>              /* idle_list is kept in LIFO order, check the last one */
>> +		worker = list_entry(pool->idle_list.prev, struct worker, entry);
>> +		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
>> +		do_cull = !time_before(jiffies, expires);
>> +
>> +		if (!do_cull)
>> +			mod_timer(&pool->idle_timer, expires);
>> +	}
>> +	raw_spin_unlock_irq(&pool->lock);
>> +
>> +	if (do_cull)
>> +		queue_work(system_unbound_wq, &pool->idle_cull_work);
>> +}
>> +
>> +/*
>> + * idle_cull_fn - cull workers that have been idle for too long.
>> + */
>
> Please turn it into a full function comment or drop the wings (ie. make it
> an one-liner).
>

Patch 4/4 adds the rest of the comment, but I can make the whole thing
appear in patch 4 if you prefer.

