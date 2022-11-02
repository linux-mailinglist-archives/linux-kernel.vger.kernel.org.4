Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F5E616A51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKBROy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiKBROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670F620F6B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667409207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rMygVofTeWk0y7mrE7U7rWszMFWJ2DrgJb6LCCOl3G8=;
        b=A9eiKbKU8hqZxWGSC3Ok1QHhikXeRuXVODLBDtfkfYJ9iaHKYdZbd4jHqGBSqDltQmZY3J
        CgqhzaRYtzmYifmmFG/Pe+r0FN4VHBxMeEryPfG/pjxxq6NBmxXcKBx6Gd1Kq4u3sDf8R7
        XhVnsqYRcut6TYyuKhQQzwVe6EtfmEw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-cqVGEHSpN_W3UnpaO9ppTA-1; Wed, 02 Nov 2022 13:13:26 -0400
X-MC-Unique: cqVGEHSpN_W3UnpaO9ppTA-1
Received: by mail-qk1-f197.google.com with SMTP id j13-20020a05620a288d00b006be7b2a758fso15562783qkp.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMygVofTeWk0y7mrE7U7rWszMFWJ2DrgJb6LCCOl3G8=;
        b=og6o/hea7ckm0isHuOGiTP7rWH3koYCBc9921mME4IX8Up8HqCjw1xCuafCRgY5LBe
         oEbQ7VRQQQd32gObPmMYBk78bYbjHGB3w8ou5Oa3tiC02TDg4UhI2rDPJxzMN3Ss2BG1
         6tqNfREcblal0Ci8Xowppi5CtUBzz+JU1gYZdqmNOXtlLNy+dyV2nulDgOHkLigtda/a
         KigZQGgYf7/6Arzmeqn5k2Os/OnqhyRZPP18L4RpAbzbXYFirLD4CuL0L4CyJOjcUrwJ
         j756vKFWgka3yKzI5kUZoC74UMAqskSFSPeqFSQgCCKMVihwTu+fpX95ECoeUDJ7pqne
         t/UA==
X-Gm-Message-State: ACrzQf1GGhv3TOVbXDi1Wr6vWpkAlsRmjdeiKNqMbPHzO02eAfXI9omR
        kmBBn+grwm8Ml/Tdi7kN6beYcDxRs8JSjQyCvQ4WVAVjseLLTTvFSWhOHLuKEovJLugGeDEs0qA
        EKPTPXJjLhgCZ5OiY3uC+rZd+
X-Received: by 2002:a05:6214:4109:b0:4bb:e8dd:9fa5 with SMTP id kc9-20020a056214410900b004bbe8dd9fa5mr16674540qvb.118.1667409206035;
        Wed, 02 Nov 2022 10:13:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6R/H4Hq44AUe8gTu4iGUxpRdAnc83CKxSvygKWPM+AbKRhAFd3jY+9qlgR3Es4cyuAs/pq0A==
X-Received: by 2002:a05:6214:4109:b0:4bb:e8dd:9fa5 with SMTP id kc9-20020a056214410900b004bbe8dd9fa5mr16674520qvb.118.1667409205866;
        Wed, 02 Nov 2022 10:13:25 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a280b00b006f8665f483fsm8836208qkp.85.2022.11.02.10.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:13:25 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 3/4] workqueue: Convert the idle_timer to a delayed_work
In-Reply-To: <Y2AYrG8q+I3VhHoF@slm.duckdns.org>
References: <20221004150521.822266-1-vschneid@redhat.com>
 <20221004150521.822266-4-vschneid@redhat.com>
 <Y2AYrG8q+I3VhHoF@slm.duckdns.org>
Date:   Wed, 02 Nov 2022 17:13:22 +0000
Message-ID: <xhsmh4jvhwa8d.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/22 08:49, Tejun Heo wrote:
> Hello,
>
> On Tue, Oct 04, 2022 at 04:05:20PM +0100, Valentin Schneider wrote:
>> +static void idle_reaper_fn(struct work_struct *work)
>>  {
>> -	struct worker_pool *pool = from_timer(pool, t, idle_timer);
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct worker_pool *pool = container_of(dwork, struct worker_pool, idle_reaper_work);
>>
>>      raw_spin_lock_irq(&pool->lock);
>>
>>      while (too_many_workers(pool)) {
>>              struct worker *worker;
>>              unsigned long expires;
>> +		unsigned long now = jiffies;
>>
>> -		/* idle_list is kept in LIFO order, check the last one */
>> +		/* idle_list is kept in LIFO order, check the oldest entry */
>>              worker = list_entry(pool->idle_list.prev, struct worker, entry);
>>              expires = worker->last_active + IDLE_WORKER_TIMEOUT;
>>
>> -		if (time_before(jiffies, expires)) {
>> -			mod_timer(&pool->idle_timer, expires);
>
> So, one thing which bothers me is that the idle timer is supposed to go off
> spuriously periodically. The idea being that letting it expire spuriously
> should usually be cheaper than trying to update it constantly as workers
> wake up and sleep. Converting the timer to a delayed work makes spurious
> wakeups significantly more expensive tho as it's now a full scheduling
> event.
>

Right.

> Can we separate the timer and work item out so that we can kick off the work
> item iff there actually are tasks to kill?
>

One thing I can try to have a DIY delayed_work where the timer callback
doesn't just queue the work but first checks for too_many_workers(). This
will mostly likely result in a different behaviour as worker deletion will
then involve two pool->lock regions, but this will still catch long-idling
workers.

> Thanks.
>
> --
> tejun

